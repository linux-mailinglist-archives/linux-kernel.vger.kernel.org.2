Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0069B34301C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhCTWm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhCTWmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:42:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7FCC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4mDsL15abTqOqk7vZ4xYCrnDfgqfrdW7pgSkeCPBCaY=; b=ff1dQ5SO1IOX3GCqwxUc2DiqIv
        92REu42OwWBMdUoGVpqkqy97OZM2t951WjCMi4tcKE1MBkJ8jyfTNGD6lGsR4n4Ww7NKbcjFbTuXz
        LFg5HlUPeeJ7rareEj9CslUbMzzDNr8gnea2ZrHgqHp3RtCSnGt7ZLoVgF97+cj3dnjwIpydy3jU7
        GWw3Og9gzmkuFUUI8fBATo0StNYmbGBWjbkBxOLx3X/iMmzbMI48gYHvA1deLGMwP6OKe4mkNeXsc
        KEslviC+PB/9OkS7uZADatHRsJ6AM7YUsA2MhYUpZ+PRV10aL+iAwxoNtJGMUww0MpKw72yA2/zPh
        33vgAScQ==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNkHt-0024j2-Jd; Sat, 20 Mar 2021 22:41:42 +0000
Date:   Sat, 20 Mar 2021 15:41:41 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: epapr: A typo fix
In-Reply-To: <20210320213932.22697-1-unixbhaskar@gmail.com>
Message-ID: <58285cd-cc1e-3988-2753-a8eaae9e419@bombadil.infradead.org>
References: <20210320213932.22697-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_154141_669336_4759A38C 
X-CRM114-Status: GOOD (  12.73  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote: > > s/parmeters/parameters/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/parmeters/parameters/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> arch/powerpc/include/asm/epapr_hcalls.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
> index c99ba08a408d..cdf3c6df5123 100644
> --- a/arch/powerpc/include/asm/epapr_hcalls.h
> +++ b/arch/powerpc/include/asm/epapr_hcalls.h
> @@ -65,7 +65,7 @@
>  * but the gcc inline assembly syntax does not allow us to specify registers
>  * on the clobber list that are also on the input/output list.  Therefore,
>  * the lists of clobbered registers depends on the number of register
> - * parmeters ("+r" and "=r") passed to the hypercall.
> + * parameters ("+r" and "=r") passed to the hypercall.
>  *
>  * Each assembly block should use one of the HCALL_CLOBBERSx macros.  As a
>  * general rule, 'x' is the number of parameters passed to the assembly
> --
> 2.26.2
>
>
