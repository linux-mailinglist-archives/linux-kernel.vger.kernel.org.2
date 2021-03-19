Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AB03412A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 03:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhCSCOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229948AbhCSCOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616120050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXGszVoo3fAp78eYyGAJSnqrZRwZNBn6vVYcv+9xJHs=;
        b=LKuYJpGIZTujZ5rBHV1D61jKan/C/TSWt8UVWJ0F1vsK/Pe20US5bpkl1yJpp30WKs6NiD
        DCtU39yVn+DnqKb2AlTbS+OFaMqxuSrfphjCbcFQ+o7NKhqFT7Q9Hc97i/sDX4HrUJ+c+x
        RLXkIpEkYFthgTbN2SdeOEG1bZSWDRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-PVGudvEOPuSjZokdZDno5A-1; Thu, 18 Mar 2021 22:14:08 -0400
X-MC-Unique: PVGudvEOPuSjZokdZDno5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BF41107B768;
        Fri, 19 Mar 2021 02:14:07 +0000 (UTC)
Received: from treble (ovpn-113-46.rdu2.redhat.com [10.10.113.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09096690FE;
        Fri, 19 Mar 2021 02:14:05 +0000 (UTC)
Date:   Thu, 18 Mar 2021 21:14:03 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/14] objtool: Extract elf_symbol_add()
Message-ID: <20210319021403.idfcvrzuj3ywbxhx@treble>
References: <20210318171103.577093939@infradead.org>
 <20210318171920.007925810@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318171920.007925810@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:11:13PM +0100, Peter Zijlstra wrote:
> Create a common helper to add symbols.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/elf.c |   57 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 24 deletions(-)
> 
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -290,12 +290,41 @@ static int read_sections(struct elf *elf
>  	return 0;
>  }
>  
> +static bool elf_symbol_add(struct elf *elf, struct symbol *sym)

How about "elf_add_symbol()" for consistency with my other suggestions
(elf_add_reloc() and elf_add_string()).  And return an int.

-- 
Josh

