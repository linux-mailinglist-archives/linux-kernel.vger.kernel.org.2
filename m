Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5E7326274
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhBZMOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:14:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:33190 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhBZMNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:13:54 -0500
IronPort-SDR: vTug/gGgSZcNX0kuq/eCSMDBYH6eS6Kv4Y5dJ6zHLl/GXyfMOFH7pIMtKJundADBKjE9lcaDV1
 2XdDQg2p02zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="183398775"
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="183398775"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 04:12:08 -0800
IronPort-SDR: QCKg8pjubAp90lXqeGeoPALpG5qzrqJOgRL0AlLgP82lLZJzn6fJKDI7O11yztOLi9VKo11et/
 UWa6hqZMV76g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="404877581"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga008.jf.intel.com with SMTP; 26 Feb 2021 04:12:04 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 26 Feb 2021 14:12:03 +0200
Date:   Fri, 26 Feb 2021 14:12:03 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH -next] fbdev: atyfb: use LCD management functions for
 PPC_PMAC also
Message-ID: <YDjlkzg7/qnPBIKI@intel.com>
References: <20210226000537.8674-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210226000537.8674-1-rdunlap@infradead.org>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 04:05:37PM -0800, Randy Dunlap wrote:
> Include PPC_PMAC in the configs that use aty_ld_lcd() and
> aty_st_lcd() implementations so that the PM code may work
> correctly for PPC_PMAC.
> 
> Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> ---
> Daniel- We also need this patch:
> https://lore.kernel.org/dri-devel/20210224215528.822-1-rdunlap@infradead.org/
> to fix a kernel test robot build error.
> 
>  drivers/video/fbdev/aty/atyfb_base.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> --- linux-next-20210219.orig/drivers/video/fbdev/aty/atyfb_base.c
> +++ linux-next-20210219/drivers/video/fbdev/aty/atyfb_base.c
> @@ -132,8 +132,7 @@
>  #define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
>  #define PRINTKE(fmt, args...)	printk(KERN_ERR "atyfb: " fmt, ## args)
>  
> -#if defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_GENERIC_LCD) || \
> -defined(CONFIG_FB_ATY_BACKLIGHT)
> +#if defined(CONFIG_PPC_PMAC)

Did you send an old version by accident? That's definitely
not what we want since it would break everything except PPC_PMAC.

>  static const u32 lt_lcd_regs[] = {
>  	CNFG_PANEL_LG,
>  	LCD_GEN_CNTL_LG,
> @@ -175,8 +174,7 @@ u32 aty_ld_lcd(int index, const struct a
>  		return aty_ld_le32(LCD_DATA, par);
>  	}
>  }
> -#else /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) \
> -	 defined(CONFIG_FB_ATY_GENERIC_LCD) */
> +#else /* defined(CONFIG_PPC_PMAC) */
>  void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
>  { }
>  
> @@ -184,7 +182,7 @@ u32 aty_ld_lcd(int index, const struct a
>  {
>  	return 0;
>  }
> -#endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
> +#endif /* defined(CONFIG_PPC_PMAC) */
>  
>  #ifdef CONFIG_FB_ATY_GENERIC_LCD
>  /*

-- 
Ville Syrjälä
Intel
