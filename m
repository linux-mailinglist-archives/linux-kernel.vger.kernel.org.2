Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E76342F18
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 20:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCTTBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 15:01:19 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:48335 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhCTTBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 15:01:12 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lNgqU-001gPD-7c; Sat, 20 Mar 2021 20:01:10 +0100
Received: from p5b13afd4.dip0.t-ipconnect.de ([91.19.175.212] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lNgqU-0003fI-1B; Sat, 20 Mar 2021 20:01:10 +0100
Subject: Re: [PATCH] IA64: Trivial spelling fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210320182347.21440-1-unixbhaskar@gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <a3f98ec2-46e4-c7be-5e73-96c768a35bef@physik.fu-berlin.de>
Date:   Sat, 20 Mar 2021 20:01:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210320182347.21440-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.175.212
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhaskar!

On 3/20/21 7:23 PM, Bhaskar Chowdhury wrote:
> 
> s/seralize/serialize/ .....three different places
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/ia64/kernel/pal.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/ia64/kernel/pal.S b/arch/ia64/kernel/pal.S
> index d3e22c018b68..06d01a070aae 100644
> --- a/arch/ia64/kernel/pal.S
> +++ b/arch/ia64/kernel/pal.S
> @@ -86,7 +86,7 @@ GLOBAL_ENTRY(ia64_pal_call_static)
>  	mov ar.pfs = loc1
>  	mov rp = loc0
>  	;;
> -	srlz.d				// seralize restoration of psr.l
> +	srlz.d				// serialize restoration of psr.l
>  	br.ret.sptk.many b0
>  END(ia64_pal_call_static)
>  EXPORT_SYMBOL(ia64_pal_call_static)
> @@ -194,7 +194,7 @@ GLOBAL_ENTRY(ia64_pal_call_phys_static)
>  	mov rp = loc0
>  	;;
>  	mov ar.rsc=loc4			// restore RSE configuration
> -	srlz.d				// seralize restoration of psr.l
> +	srlz.d				// serialize restoration of psr.l
>  	br.ret.sptk.many b0
>  END(ia64_pal_call_phys_static)
>  EXPORT_SYMBOL(ia64_pal_call_phys_static)
> @@ -252,7 +252,7 @@ GLOBAL_ENTRY(ia64_pal_call_phys_stacked)
>  	mov rp = loc0
>  	;;
>  	mov ar.rsc=loc4			// restore RSE configuration
> -	srlz.d				// seralize restoration of psr.l
> +	srlz.d				// serialize restoration of psr.l
>  	br.ret.sptk.many b0
>  END(ia64_pal_call_phys_stacked)
>  EXPORT_SYMBOL(ia64_pal_call_phys_stacked)
> --
> 2.26.2

Thanks for fixing this. Btw, we usually use all-lowercase letters for architecture
names in the Linux kernel, so it should probably be "ia64: Trivial spelling fixes".

And the easiest way to get those fixes into the kernel would be through Andrew Morton's
tree.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

