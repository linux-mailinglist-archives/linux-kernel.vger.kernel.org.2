Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B51344F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhCVSwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhCVSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:51:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F74BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=KqWlvhAGgyStdJLBW78wBFkvyCWpxBzSVDDJlh/HL90=; b=ZVhuah8QLyHaRfi5DaIMP+8KR3
        Rqz0HEJy5GOMs+GeP5oX15a2ApgBEEtJ5l/Xcpa2ohrvqfCk77QvwTgYfH3nwC3Q9vGzsBAlim8Fn
        3Z3Ose0MR0e11E9FdlpoEXmMdX4/56dhDC29xFgo7rDnzJG0eyFxoupZq9EwKo68A49zvT+JZLWoc
        W1nGwUIeAOW5GBJ+GppY4UIkVVa1UpTvZgbNLGRxezMu88Vc1epNpO6Qju9IGJsvyexskEWiDEWer
        9bg5+Qo71NGFCsToH24ewMwFMThUrKK1Xb79QfOnyLoFmb9hZXLCCWxQLbe8a/zZ0pju4QwhUgOh3
        cLem4M2Q==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPdX-008wJa-Pl; Mon, 22 Mar 2021 18:51:07 +0000
Subject: Re: [PATCH] powerpc: kernel: Trivial spelling fixes throughout the
 file head_fsl_booke.S
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, rppt@kernel.org,
        akpm@linux-foundation.org, christophe.leroy@csgroup.eu,
        oss@buserror.net, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210315033732.4173500-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3b2e038c-6c17-0b53-0b96-8795ee32c09b@infradead.org>
Date:   Mon, 22 Mar 2021 11:50:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315033732.4173500-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/21 8:37 PM, Bhaskar Chowdhury wrote:
> s/virutal/virtual/
> s/mismach/mismatch/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  As Randy pointed out I was changing the predefined macro name,so, reverted
>  or leave it alone.
>  Michael,sorry to run down a cold weave in your spine with my stupdity,this is
>  okay.
> 
>  arch/powerpc/kernel/head_fsl_booke.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index 3f4a40cccef5..a955403247f1 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -113,7 +113,7 @@ _ENTRY(_start);
> 
>  1:
>  	/*
> -	 * We have the runtime (virutal) address of our base.
> +	 * We have the runtime (virtual) address of our base.
>  	 * We calculate our shift of offset from a 64M page.
>  	 * We could map the 64M page we belong to at PAGE_OFFSET and
>  	 * get going from there.
> @@ -497,7 +497,7 @@ END_BTB_FLUSH_SECTION
>  #endif
>  #endif
> 
> -	bne	2f			/* Bail if permission/valid mismach */
> +	bne	2f			/* Bail if permission/valid mismatch */
> 
>  	/* Jump to common tlb load */
>  	b	finish_tlb_load
> @@ -592,7 +592,7 @@ END_BTB_FLUSH_SECTION
>  #endif
>  #endif
> 
> -	bne	2f			/* Bail if permission mismach */
> +	bne	2f			/* Bail if permission mismatch */
> 
>  	/* Jump to common TLB load point */
>  	b	finish_tlb_load
> --
> 2.30.2
> 


-- 
~Randy

