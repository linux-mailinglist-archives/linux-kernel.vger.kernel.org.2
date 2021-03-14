Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AB33A345
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 07:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhCNGKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 01:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhCNGKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 01:10:11 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8AEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 22:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=flQLJwzUvdHiy8FJWLSt05mQkzejQiPxw61jx/cedNs=; b=2oDMDw9U40Zo5sP+gBBLwYtZsJ
        HkCmgeUjkaMVl0zzxZnJAM29mODYIXCsOi5twFhk2FFD0lNV7UByK47oyrkXOXtxU4u0LTYtG+gOE
        w2R64aJeLIQN9LZq13D3f+aNmyzqlkvO8Dp62rbVWWaYcm3pXO/17hr9TGSocud0YpHIlB6+h9JKs
        tziPElScROTsauEr5+/DhnN2nJDS+5VbPidNEkTablDx/sElvgpHezpECcmpN65+o9B6BaN79wcuy
        v6jT9g6DG3I+YSEFT04EGILUhiCMeSv1uE/xRinHuKnCdOsaZh3gxSC7y1IQMGpnpn78HsUVridMz
        DFNWaT/w==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLJx0-001B4w-3k; Sun, 14 Mar 2021 06:10:06 +0000
Subject: Re: [PATCH] h8300: kernel: Spelling fix in the file irq.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        ysato@users.sourceforge.jp, uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org
References: <20210314051931.6378-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ea00df3-53c2-1541-881d-bd05537af663@infradead.org>
Date:   Sat, 13 Mar 2021 22:10:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314051931.6378-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/21 9:19 PM, Bhaskar Chowdhury wrote:
> 
> s/writerble/writeable/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/h8300/kernel/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/h8300/kernel/irq.c b/arch/h8300/kernel/irq.c
> index 834e4d7b1bcf..4afa13db6774 100644
> --- a/arch/h8300/kernel/irq.c
> +++ b/arch/h8300/kernel/irq.c
> @@ -43,7 +43,7 @@ static unsigned long __init *get_vector_address(void)
>  	/* ramvector base address */
>  	base -= EXT_IRQ0*4;
> 
> -	/* writerble? */
> +	/* writeable? */
>  	tmp = ~(*(volatile unsigned long *)base);
>  	(*(volatile unsigned long *)base) = tmp;
>  	if ((*(volatile unsigned long *)base) != tmp)
> --


-- 
~Randy

