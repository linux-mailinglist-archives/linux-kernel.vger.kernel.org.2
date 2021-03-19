Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1253424AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhCSS3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbhCSS3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616178545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3wnp6ZfCmHQC3RhizXiAxrkd6ldfktjQBxi5hT4ZDXM=;
        b=hk/fzR2eBUT7Vq1qSVp2pDvhdoW5QRT2vOlI+3e0befsjOBOkAcOCgNtD2hzlDaAx+rmU/
        kO7OwqJce2qsQJp9nFOuJi/NxHWAtzxejNqjH9KpVkM7/kBVHCjXZJy0a+ud9bmWHtA1YR
        dSeAkigctMnzO/WzClCc+2siZ4qXyso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-1r82QA2UNwqNWngkTT4kgw-1; Fri, 19 Mar 2021 14:29:02 -0400
X-MC-Unique: 1r82QA2UNwqNWngkTT4kgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BD841084D6B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 18:29:01 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC66360871;
        Fri, 19 Mar 2021 18:29:00 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id AAC5058; Fri, 19 Mar 2021 15:28:56 -0300 (-03)
Date:   Fri, 19 Mar 2021 15:28:56 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     hyunji-Hong <onlygod0807@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Tools: lib: string: Fix isspace() parameter to avoid
 undefined behavior
Message-ID: <20210319182856.GA2120@redhat.com>
References: <20210319001415.8928-1-hyunji_hong@korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319001415.8928-1-hyunji_hong@korea.ac.kr>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 19, 2021 at 09:14:15AM +0900, hyunji-Hong escreveu:
> isspace() could be vulnerable in terms of unpredictable results. So, the parameter of the isspace() should be cast with 'unsigned int'. We found out that information through these sites. (Microsoft, Stack Overflow)
> url: [https://docs.microsoft.com/en-us/cpp/code-quality/c6328?view=msvc-160]
> url: [https://stackoverflow.com/questions/122721]

tools/ and the kernel versions of isspace are implemented in
include/linux/ctype.h and tools/include/linux/ctype.h.

- Arnaldo
 
> Signed-off-by: SeungHoon Woo, Hyunji Hong, Kyeongseok Yang <hyunji_hong@korea.ac.kr>
> ---
>  tools/lib/string.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/string.c b/tools/lib/string.c
> index 8b6892f959ab..7d01be5cdcf8 100644
> --- a/tools/lib/string.c
> +++ b/tools/lib/string.c
> @@ -123,7 +123,7 @@ size_t __weak strlcpy(char *dest, const char *src, size_t size)
>   */
>  char *skip_spaces(const char *str)
>  {
> -	while (isspace(*str))
> +	while (isspace((unsigned char)*str))
>  		++str;
>  	return (char *)str;
>  }
> @@ -146,7 +146,7 @@ char *strim(char *s)
>  		return s;
>  
>  	end = s + size - 1;
> -	while (end >= s && isspace(*end))
> +	while (end >= s && isspace((unsigned char)*end))
>  		end--;
>  	*(end + 1) = '\0';
>  
> -- 
> 2.17.1

