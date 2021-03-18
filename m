Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949F33404E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhCRLnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhCRLnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:43:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53151C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:43:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so3172743wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qlh0PLI7gh/qmZ34aTQwcT+xdXL5fD/J8CQcbj7KKrg=;
        b=NUsfxEv4djJ6Ej8xDqOo7zjA3jA6YXbq2HmjCS2XbUrlo8NFP38X1dqdG7q1IMGJit
         zbXI/4JuajopV+n76wfbO75FdAY6CxPom4nD8go0ia0NBjPP3tioicSib8TwY4BzcX+U
         nu56D/6N7nBfrd9CfrFp8YCDQ1UgS5luOCTbX7cCuSJeNczKiIPCMTsHKVEEs94ZwTy+
         mx11kN9vkV67tHtBJ/46m24GCoGiOL2eOGYIr7gRvBb8HZw4X2RxeCQlWYbUD8nvIVIA
         Fj3RPQND/DnVaQeUgurOUQ4+y9VNmsdoEf2TjbBmn591VWhrnf1PSa9INaI0scVjEfcy
         VbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qlh0PLI7gh/qmZ34aTQwcT+xdXL5fD/J8CQcbj7KKrg=;
        b=RBTN4OiMGsYehioKHQm2vBGLRCcEKPJn8uU6+JkL95xPSJdJHxS9r/NdZb5T1Okpyv
         FSBCx7AmsrwICBxAERHppbGQbc/1IC9Fqma35d3LT47Jp/AO2m6XTmju3Nju5/FKGp1M
         VZlrFgmv39aqZm7o6mAJlsVG4vZa4PX8SHznrv4IHFXL7Umc3Er1VeQE1ecCG3mOt94c
         HODluTiC6FLA4k/PN7RUqba7xsxqb4hqvWcdH4/mfYza0HQOCFAjyRfsg4Esg2w60XPZ
         GU/ACvBiO6nwpYVIBkZZsXxk5ykErqzmjJi4hxb4tkw/maYQ+rYI76KzKMgOFXps4iFo
         0Pbw==
X-Gm-Message-State: AOAM533+ZsmqmOI5foPx/6hizHoto93oHcb7K9NlvuyqR7xyRi1DE34W
        fC8MtvtGQZzZlO6um8IhHNcSmA==
X-Google-Smtp-Source: ABdhPJwDsjFbmhs8zkFQ91cXTJVPdBZL/4TzKiQZhgpkFmHLoQ1cwC496vYDK6cJtaio41lVF+8gOQ==
X-Received: by 2002:a1c:5416:: with SMTP id i22mr3247883wmb.146.1616067792719;
        Thu, 18 Mar 2021 04:43:12 -0700 (PDT)
Received: from dell ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id u2sm2724691wrp.12.2021.03.18.04.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:43:12 -0700 (PDT)
Date:   Thu, 18 Mar 2021 11:43:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
Message-ID: <20210318114310.GE2916463@dell>
References: <20210307151807.35201-1-hdegoede@redhat.com>
 <433cda84-2d61-ccb4-155a-5f8fa1021c90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <433cda84-2d61-ccb4-155a-5f8fa1021c90@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021, Hans de Goede wrote:

> Hi Lee,
> 
> On 3/7/21 4:17 PM, Hans de Goede wrote:
> > Hi All,
> > 
> > Here is v4 of my series to rework the arizona codec jack-detect support
> > to use the snd_soc_jack helpers instead of direct extcon reporting.
> > 
> > As discussed before here is a resend rebased on 5.12-rc2, making sure that
> > all patches this depends on are in place.
> > 
> > Lee, can you pick-up patches 1-6 through the MFD tree and then send a
> > pull-req to Mark so that Mark can merge the Asoc parts throught the ASoC
> > tree ?
> > 
> > Patches 2-6 touch drivers/extcon, these all have an Ack from Chanwoo Choi
> > for merging these through the MFD tree.
> 
> Lee, is there a specific reason why these have not been merged yet,
> or did you just not get around to these yet ?
> 
> As I already mentioned Chanwoo Choi already gave an ack for merging
> the extcon patches through MFD, so AFAICT eveything is ready to merge
> 1-6 through the MFD tree, and then have Mark merge an ib from the
> MFD tree and merge the rest.

I can't remember where we left it.

I guess I can take 1-6 (as suggested above) without issue.

Hold tight.

> > Here is some more generic info on this series from the previous
> > cover-letter:
> > 
> > This is done by reworking the extcon driver into an arizona-jackdet
> > library and then modifying the codec drivers to use that directly,
> > replacing the old separate extcon child-devices and extcon-driver.
> > 
> > This brings the arizona-codec jack-detect handling inline with how
> > all other ASoC codec driver do this. This was developed and tested on
> > a Lenovo Yoga Tablet 1051L with a WM5102 codec.
> > 
> > This was also tested by Charles Keepax, one of the Cirrus Codec folks.
> > 
> > Regards,
> > 
> > Hans
> > 
> > 
> > Hans de Goede (13):
> >   mfd: arizona: Drop arizona-extcon cells
> >   extcon: arizona: Fix some issues when HPDET IRQ fires after the jack
> >     has been unplugged
> >   extcon: arizona: Fix various races on driver unbind
> >   extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol")
> >     call
> >   extcon: arizona: Always use pm_runtime_get_sync() when we need the
> >     device to be awake
> >   ASoC/extcon: arizona: Move arizona jack code to
> >     sound/soc/codecs/arizona-jack.c
> >   ASoC: arizona-jack: Move jack-detect variables to struct arizona_priv
> >   ASoC: arizona-jack: Use arizona->dev for runtime-pm
> >   ASoC: arizona-jack: convert into a helper library for codec drivers
> >   ASoC: arizona-jack: Use snd_soc_jack to report jack events
> >   ASoC: arizona-jack: Cleanup logging
> >   ASoC: arizona: Make the wm5102, wm5110, wm8997 and wm8998 drivers use
> >     the new jack library
> >   ASoC: Intel: bytcr_wm5102: Add jack detect support
> > 
> >  MAINTAINERS                                   |   3 +-
> >  drivers/extcon/Kconfig                        |   8 -
> >  drivers/extcon/Makefile                       |   1 -
> >  drivers/mfd/arizona-core.c                    |  20 -
> >  sound/soc/codecs/Makefile                     |   2 +-
> >  .../soc/codecs/arizona-jack.c                 | 577 +++++++-----------
> >  sound/soc/codecs/arizona.h                    |  44 ++
> >  sound/soc/codecs/wm5102.c                     |  12 +-
> >  sound/soc/codecs/wm5110.c                     |  12 +-
> >  sound/soc/codecs/wm8997.c                     |  14 +-
> >  sound/soc/codecs/wm8998.c                     |   9 +
> >  sound/soc/intel/boards/bytcr_wm5102.c         |  28 +-
> >  12 files changed, 325 insertions(+), 405 deletions(-)
> >  rename drivers/extcon/extcon-arizona.c => sound/soc/codecs/arizona-jack.c (76%)
> > 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
