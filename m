Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A4432459A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 22:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhBXVJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 16:09:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:22827 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233191AbhBXVJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 16:09:00 -0500
IronPort-SDR: ulrvroW1zpkGVHI+I1u2DCMs1w/zsKNB/yNJAohO6gbG2YOAtTZo06hcrQf4ctqkL7+8YfN/Y+
 asCLnBVfiqNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="182847858"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="182847858"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 13:07:15 -0800
IronPort-SDR: phezcjYPkAo2Xn3FYEvPijWpsjggQF7R23wbuHGSnno5a7V5UMLnEiAx0TOfX2MaNG4ajQ54GZ
 bogDRwuN8tiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="367135742"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga006.jf.intel.com with SMTP; 24 Feb 2021 13:07:11 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 24 Feb 2021 23:07:10 +0200
Date:   Wed, 24 Feb 2021 23:07:10 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] fbdev: atyfb: add stubs for aty_{ld,st}_lcd()
Message-ID: <YDa//vfs9J15V7k5@intel.com>
References: <20210222032853.21483-1-rdunlap@infradead.org>
 <YDPtYx1uU5Y4HNZ7@intel.com>
 <7d416971-ae9b-52a8-bfba-79c2c920ec6c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d416971-ae9b-52a8-bfba-79c2c920ec6c@infradead.org>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 11:59:45AM -0800, Randy Dunlap wrote:
> On 2/22/21 9:44 AM, Ville Syrjälä wrote:
> > On Sun, Feb 21, 2021 at 07:28:53PM -0800, Randy Dunlap wrote:
> >> Fix build errors when these functions are not defined.
> >>
> >> ../drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_power_mgmt':
> >> ../drivers/video/fbdev/aty/atyfb_base.c:2002:7: error: implicit declaration of function 'aty_ld_lcd'; did you mean 'aty_ld_8'? [-Werror=implicit-function-declaration]
> >>  2002 |  pm = aty_ld_lcd(POWER_MANAGEMENT, par);
> >> ../drivers/video/fbdev/aty/atyfb_base.c:2004:2: error: implicit declaration of function 'aty_st_lcd'; did you mean 'aty_st_8'? [-Werror=implicit-function-declaration]
> >>  2004 |  aty_st_lcd(POWER_MANAGEMENT, pm, par);
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Cc: linux-fbdev@vger.kernel.org
> >> Cc: dri-devel@lists.freedesktop.org
> >> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >> Cc: Sam Ravnborg <sam@ravnborg.org>
> >> Cc: Daniel Vetter <daniel@ffwll.ch>
> >> Cc: David Airlie <airlied@linux.ie>
> >> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> >> ---
> >>  drivers/video/fbdev/aty/atyfb_base.c |    9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> --- linux-next-20210219.orig/drivers/video/fbdev/aty/atyfb_base.c
> >> +++ linux-next-20210219/drivers/video/fbdev/aty/atyfb_base.c
> >> @@ -175,6 +175,15 @@ u32 aty_ld_lcd(int index, const struct a
> >>  		return aty_ld_le32(LCD_DATA, par);
> >>  	}
> >>  }
> >> +#else /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) \
> >> +	 defined(CONFIG_FB_ATY_GENERIC_LCD) */
> > 
> > A better fix would seem to be to include these functions if
> > CONFIG_PPC_PMAC is enabled. Otherwise the PM code will surely
> > not work correctly. Though I'm not sure if that PPC PM
> > code makes any sense w/o LCD/backlight support anyway.
> 
> Hi Ville,
> 
> I tried this:
> 
> -#if defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_GENERIC_LCD) || \
> -defined(CONFIG_FB_ATY_BACKLIGHT)
> +#if defined(CONFIG_PPC_PMAC)
> 
> in both atyfb_base.c and atyfb.h, but then there is a build error in
> mach64_ct.c when PPC_PMAC is not enabled but FB_ATY_GENERIC_LCD is enabled.
> [mach64_ct.c is the only other user of aty_{ld,st}_lcd()]
> 
> or did you mean adding CONFIG_PPC_PMAC to that longish #if list?
> (that's not how I understood your comment.)

Yeah, I meant adding ||PPC_PMAC to the existing set of conditions.
You definitely need to have this stuff for the LCD/backlight
support on !PPC_PMAC as well.

> 
> 
> I'll gladly step away and let you submit patches for this. :)

I don't have any powerbook/etc. hw to test this so couldn't
really add any extra value. Just have vague memories of touching
this stuff long ago so figured I'd provide my "expertise" :)

> 
> >> +void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
> >> +{ }
> >> +
> >> +u32 aty_ld_lcd(int index, const struct atyfb_par *par)
> >> +{
> >> +	return 0;
> >> +}
> >>  #endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
> >>  
> >>  #ifdef CONFIG_FB_ATY_GENERIC_LCD
> >> _______________________________________________
> 
> 
> thanks.
> -- 
> ~Randy

-- 
Ville Syrjälä
Intel
