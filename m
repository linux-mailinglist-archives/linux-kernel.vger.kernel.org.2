Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C2C34347F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhCUUFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCUUFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:05:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7C8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bO0LvOOiaASsKYeBOQwIQI91+dKxTmYZBNVqvU6ArzU=; b=wW2PORSpeakrkKIX7oUOI6ZwUW
        mmQ1sqaZ71NVPUJUgsz0tWM59ok/d+h+79ZVra4DMt3jYGSo/2tNDW1rXZfdsgM3VMsAJl2sXq1zn
        7d4MtFfpd3RgnUuAoF2d8jk/A3j5Ic3xxvMydMV9Vt2+y2szkbViywsZv/y5o8hyerB1enZHxLpcp
        9RDFGsGpPhi+sJa358UEKKp1cksHGN9BE2ubO7zUe0u6fcDcc8YR5i5tcjawCSIaSa3ZkPvrpJEQv
        CuoKJuzY4THdMT/JXT0juPVObHH5rbZkypBm7a8qBeD2boGchASbEMK9hhnh0UYwaP9udS9S1xaqY
        9zaLqJBg==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lO4KB-002UF7-Ea; Sun, 21 Mar 2021 20:05:24 +0000
Date:   Sun, 21 Mar 2021 13:05:23 -0700 (PDT)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org, rppt@kernel.org,
        jroedel@suse.de, thomas.lendacky@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/realmode: Fix a typo
In-Reply-To: <20210321193246.3559073-1-unixbhaskar@gmail.com>
Message-ID: <4de7bbf8-e2a-9c4c-b1a1-1acf2cebe4f8@infradead.org>
References: <20210321193246.3559073-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210321_130523_510472_63B736B0 
X-CRM114-Status: GOOD (  11.64  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Mon, 22 Mar 2021, Bhaskar Chowdhury wrote: > > s/perfomed/performed/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/perfomed/performed/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> arch/x86/realmode/init.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 22fda7d99159..1be71ef5e4c4 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -103,7 +103,7 @@ static void __init setup_real_mode(void)
> 		*ptr += phys_base;
> 	}
>
> -	/* Must be perfomed *after* relocation. */
> +	/* Must be performed *after* relocation. */
> 	trampoline_header = (struct trampoline_header *)
> 		__va(real_mode_header->trampoline_header);
>
> --
> 2.31.0
>
>
