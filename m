Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E00337A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCKQyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:54:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229942AbhCKQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615481623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RsNecIoLWMmtHw2ukLD+MXYyvQSCHtDN1GLSjaRSntQ=;
        b=aNQpgEJWAMqmnFArJwBXV4QW7bAtEeai/A1m3Fut9TjpMyAFZyu/ohg518Z0JQxR8p9juP
        R7kJmHLR9vhoz1x8/EvLsiWL6tM/pzWWZ5jIgtcbNsw7E27sedaumVkUndFdyQiQFL8SGC
        HKDSnLeu89l9yqzc++RMdMto7TXA4s8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-ibkYS-aaMPGpYU69OceJqQ-1; Thu, 11 Mar 2021 11:53:41 -0500
X-MC-Unique: ibkYS-aaMPGpYU69OceJqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4E51CC624;
        Thu, 11 Mar 2021 16:53:40 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EC9218BBC;
        Thu, 11 Mar 2021 16:53:38 +0000 (UTC)
Subject: Re: [PATCH] mm: cma: Use pr_err_ratelimited for CMA warning
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <ce2251ef49e1727a9a40531d1996660b05462bd2.1615279825.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <796ca026-31e8-7958-5e7b-e8b5446247a3@redhat.com>
Date:   Thu, 11 Mar 2021 17:53:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <ce2251ef49e1727a9a40531d1996660b05462bd2.1615279825.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.21 10:16, Baolin Wang wrote:
> If we did not reserve extra CMA memory, the log buffer can be
> easily filled up by CMA failure warning when the devices calling
> dmam_alloc_coherent() to alloc DMA memory. Thus we can use
> pr_err_ratelimited() instead to reduce the duplicate CMA warning.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/cma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 54eee21..d101bdb 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -500,8 +500,8 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   	}
>   
>   	if (ret && !no_warn) {
> -		pr_err("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
> -		       __func__, cma->name, count, ret);
> +		pr_err_ratelimited("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
> +				   __func__, cma->name, count, ret);
>   		cma_debug_show_areas(cma);
>   	}
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

