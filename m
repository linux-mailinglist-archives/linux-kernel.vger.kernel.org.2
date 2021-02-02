Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690E430BAB2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhBBJNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:13:44 -0500
Received: from smtp2.axis.com ([195.60.68.18]:19391 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhBBJJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1612256959;
  x=1643792959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BHxuxWQtEX0RO+muKGufvPHHrWWvf6q3kzp2I3KPWpo=;
  b=ovOIzX4Ov4L3O3ej17s35RxpWFY0Qq9Navvrv8dSR/ShYhzSLUrRvN4U
   fgtAw/k0GCDG+mGYLfLXFHgzZzrs5Rgla/Ns4AGNumi/4sh4o4RR0E0l2
   ZyEIQXXp7Rt44jWDc9FpK2oh6JL1r9Hw+K0JNe5pwsisTA05+Ca+DrGuu
   WXFOFEO3dnloSjU/1g+HI8UWoQXwCTxcgAKh57kEIhcYVLwOGIJ0fml94
   pwhUN88cYPbaCDDJBI1lBONKQB3BoXzDVWEpqcgCWJSuRuOnVZhlYyZjw
   yV3kBD7mjDUOzD6Y3YEDZqR9lVXJ9h1ih1SzPNdEbBhE6JunZq+HnOqlq
   w==;
Date:   Tue, 2 Feb 2021 10:08:35 +0100
From:   Jesper Nilsson <Jesper.Nilsson@axis.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
CC:     Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Lars Persson <Lars.Persson@axis.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: remove unneeded semicolon
Message-ID: <20210202090835.GF30470@axis.com>
References: <1612231357-11598-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1612231357-11598-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 03:02:37AM +0100, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./arch/arm/mach-artpec/board-artpec6.c:42:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  arch/arm/mach-artpec/board-artpec6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-artpec/board-artpec6.c b/arch/arm/mach-artpec/board-artpec6.c
> index d3cf3e8..c27e7bb 100644
> --- a/arch/arm/mach-artpec/board-artpec6.c
> +++ b/arch/arm/mach-artpec/board-artpec6.c
> @@ -39,7 +39,7 @@ static void __init artpec6_init_machine(void)
>  		 */
>  		regmap_write(regmap, ARTPEC6_DMACFG_REGNUM,
>  			     ARTPEC6_DMACFG_UARTS_BURST);
> -	};
> +	}
>  }
>  
>  static void artpec6_l2c310_write_sec(unsigned long val, unsigned reg)
> -- 
> 1.8.3.1
> 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
