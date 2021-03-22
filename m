Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC88344EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCVSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhCVSpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:45:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E27C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=YDznzbC9kBnOi1zDch9k5axeMze5seDath3nLiBy+3M=; b=qo5BG2DysvkxUXCcJ06pf2+KLD
        8bb/t3cX7/pHAE8yb+KNs2krAaLmp09LLeSmc+3vnFnw2T0fbwtsNtNw5tgo6g7xQ8gZ/gliuvFYY
        fTQuD3mMHiA58nnyKg+19caAEFdhbAaHR9iyi9wAQ11DO0n0UAGBBYLUstkg2sWL6M+/iRa405FiJ
        1GGQ2PgMN6gx8GKIMYLoLaH2VgdEnAyNUt5WH0AmbozPdGEMjKdyQX9y+0bC8/7tljgKTPTeFukAs
        ZkL1VWUcGjpyJ2weUFl9WXZczQoENEAswYFDFYwgwIhtNtv6lGZiJkFzUZb6oCWb/OFrpE5K4VKf6
        YByS4n/w==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPY8-008vxO-P2; Mon, 22 Mar 2021 18:45:16 +0000
Subject: Re: [PATCH] powerpc/asm: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210322113254.2081445-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <96eda8ce-1d89-1491-51a2-92ba9883912b@infradead.org>
Date:   Mon, 22 Mar 2021 11:45:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322113254.2081445-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 4:32 AM, Bhaskar Chowdhury wrote:
> 
> s/poiner/pointer/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

However, it would be a GOOD THING to collect multiple similar
patches that are in e.g. arch/powerpc/ and send them as one patch
instead of many little patches.


> ---
>  arch/powerpc/include/asm/cpm2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/cpm2.h b/arch/powerpc/include/asm/cpm2.h
> index 2211b934ecb4..bda45788cfcc 100644
> --- a/arch/powerpc/include/asm/cpm2.h
> +++ b/arch/powerpc/include/asm/cpm2.h
> @@ -594,7 +594,7 @@ typedef struct fcc_enet {
>  	uint	fen_p256c;	/* Total packets 256 < bytes <= 511 */
>  	uint	fen_p512c;	/* Total packets 512 < bytes <= 1023 */
>  	uint	fen_p1024c;	/* Total packets 1024 < bytes <= 1518 */
> -	uint	fen_cambuf;	/* Internal CAM buffer poiner */
> +	uint	fen_cambuf;	/* Internal CAM buffer pointer */
>  	ushort	fen_rfthr;	/* Received frames threshold */
>  	ushort	fen_rfcnt;	/* Received frames count */
>  } fcc_enet_t;
> --


-- 
~Randy

