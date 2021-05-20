Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3355638AFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbhETNNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:13:51 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:59095 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232596AbhETNNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:13:49 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ljiTR-0044HK-56; Thu, 20 May 2021 15:12:25 +0200
Received: from p5b13a0fe.dip0.t-ipconnect.de ([91.19.160.254] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ljiTQ-003P20-OP; Thu, 20 May 2021 15:12:25 +0200
Subject: Re: [PATCH v1 1/1] kernel.h: split out panic and oops helpers (ia64
 fix)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
References: <20210520130557.55277-1-andriy.shevchenko@linux.intel.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <f2420178-53d7-a1e4-eea7-5e1773835411@physik.fu-berlin.de>
Date:   Thu, 20 May 2021 15:12:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210520130557.55277-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.254
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy!

On 5/20/21 3:05 PM, Andy Shevchenko wrote:
> Note, this patch is untested. I have no ia64 compiler at hand.
> 
>  arch/ia64/include/asm/pal.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/ia64/include/asm/pal.h b/arch/ia64/include/asm/pal.h
> index 5c51fceedaf9..e6b652f9e45e 100644
> --- a/arch/ia64/include/asm/pal.h
> +++ b/arch/ia64/include/asm/pal.h
> @@ -99,6 +99,7 @@
>  
>  #include <linux/types.h>
>  #include <asm/fpu.h>
> +#include <asm/intrinsics.h>
>  
>  /*
>   * Data types needed to pass information into PAL procedures and
> 

I can test it later today.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
