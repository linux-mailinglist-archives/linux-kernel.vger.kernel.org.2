Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA82C450344
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhKOLTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:19:40 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:12198 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhKOLSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636974919;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Giit+j3Xh5ufhxBQPkxvfcH3PZ5jUDKgn+uF7kZx8YU=;
    b=WAFMSqmtx2RkViKC6mvAVwetiWdZBXWiJXYFoF5qX0oWi+H/q3nVQ5M7ZONT4AUicR
    s4RN1rFPqPdJP8ZAy/1C8v7dBgj9achCFdrqb0J+5nFktGgGCKJtst6nvo9PMGnZDxsD
    oB4R7zwryd6HnHX+0t9fpO/RqA89kpentQN6zPfZfOiS7LkF+bU3iRvFhbVAQTBACba8
    SkNQ7gNFuoSsxLyaqXdNrLlTFyayecjNqu7bCKEc5/UeqEKklkdQpvUzsK7/0N0+Usk+
    hNewIRM8GALimnvn6O+clQJFVreeBZBIreBgwGntQW4S1+Ls1rBEpn6R5JJPi198f5Xx
    87Gw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhULn41ofxiIeRCozj2DXHQY5mFDw=="
X-RZG-CLASS-ID: mo00
Received: from cc-build-machine.a-eon.tld
    by smtp.strato.de (RZmta 47.34.5 AUTH)
    with ESMTPSA id N03801xAFBFHoXX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 15 Nov 2021 12:15:17 +0100 (CET)
Subject: Re: [PATCH] powerpc/book3e: Fix TLBCAM preset at boot
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Darren Stevens <darren@stevens-zone.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Matthew Leaman <matthew@a-eon.biz>,
        mad skateman <madskateman@gmail.com>
References: <d319f2a9367d4d08fd2154e506101bd5f100feeb.1636967119.git.christophe.leroy@csgroup.eu>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <9f920db0-73db-9113-83db-0dbecbe6bcc1@xenosoft.de>
Date:   Mon, 15 Nov 2021 12:15:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d319f2a9367d4d08fd2154e506101bd5f100feeb.1636967119.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 November 2021 at 10:05 am, Christophe Leroy wrote:
> Commit 52bda69ae8b5 ("powerpc/fsl_booke: Tell map_mem_in_cams() if
> init is done") was supposed to just add an additional parameter to
> map_mem_in_cams() and always set it to 'true' at that time.
>
> But a few call sites were messed up. Fix them.
>
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Fixes: 52bda69ae8b5 ("powerpc/fsl_booke: Tell map_mem_in_cams() if init is done")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/powerpc/mm/nohash/kaslr_booke.c | 2 +-
>   arch/powerpc/mm/nohash/tlb.c         | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
> index 8fc49b1b4a91..6ec978967da0 100644
> --- a/arch/powerpc/mm/nohash/kaslr_booke.c
> +++ b/arch/powerpc/mm/nohash/kaslr_booke.c
> @@ -314,7 +314,7 @@ static unsigned long __init kaslr_choose_location(void *dt_ptr, phys_addr_t size
>   		pr_warn("KASLR: No safe seed for randomizing the kernel base.\n");
>   
>   	ram = min_t(phys_addr_t, __max_low_memory, size);
> -	ram = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM, true, false);
> +	ram = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM, true, true);
>   	linear_sz = min_t(unsigned long, ram, SZ_512M);
>   
>   	/* If the linear size is smaller than 64M, do not randmize */
> diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
> index 89353d4f5604..647bf454a0fa 100644
> --- a/arch/powerpc/mm/nohash/tlb.c
> +++ b/arch/powerpc/mm/nohash/tlb.c
> @@ -645,7 +645,7 @@ static void early_init_this_mmu(void)
>   
>   		if (map)
>   			linear_map_top = map_mem_in_cams(linear_map_top,
> -							 num_cams, true, true);
> +							 num_cams, false, true);
>   	}
>   #endif
>   
> @@ -766,7 +766,7 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
>   		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
>   
>   		linear_sz = map_mem_in_cams(first_memblock_size, num_cams,
> -					    false, true);
> +					    true, true);
>   
>   		ppc64_rma_size = min_t(u64, linear_sz, 0x40000000);
>   	} else
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>

Thanks
