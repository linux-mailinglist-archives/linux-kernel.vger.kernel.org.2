Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E0A363C64
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbhDSHXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbhDSHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:23:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6239C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:22:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x7so32791856wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SyHfgB6+zRTrv/Haj5bvpwPiVHLCQUxHRjTDe9iiH6E=;
        b=dU/4LDGRRx8nJXozQ+Zxr4ntLfl8eJOmmOdmXn29QZwsESpQ2dTw3PM0u45Vr9LIpr
         3tyvaCuWfV0joiMGdJrFXQ3Ga/UdF2t10SuyDvOVZwxxWVA6ZFtyuri5pN0Gwy/XLJJV
         8nXTPRk/sCWQfj7F0gjmd+gLMZ5Cuk2CPaUyDzT6PmoGLqdrcGfRS5LdMTr0aoGGIK5L
         EiZGvmreJlkSeVDdLGTuZvqfJsG7oD08F9/O4yRfrH3g53scMBan2Mrrkq3tUeupeI+w
         Lre0xFKk9J+sQFEpneE6rYGagHWsMSrNRNIyOpuW9M1AF3GCiNuNBD0V6Huwt4Xfrj3R
         iZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SyHfgB6+zRTrv/Haj5bvpwPiVHLCQUxHRjTDe9iiH6E=;
        b=qtFzkTeYLzWSJm1LcQR2Zkk4gADVAhv0FFPMKJ6Z+TNj8Jwn5yqxaVtmP5PGXd7yN4
         15yGH7EGwd80XPr/NsA4gHifpnGr0E/zSUEXS6/2XvFUJLlqHFAtzyhcdx9BbV3SGzUd
         eEzsp/D8YOdAi5vGe82UYe3cyeEHwWN0oVQYe7hOMznkwzEOeLdTcdXm3H4gbZtASMJj
         F1Zooq6H4rkXmQIGGmeeWTh7OmL/fj/RayD3RymEuSoMiiX9+umTigWwM4meUyVWgbTQ
         IGiOtRVKCgcYqPEjKXbZCqwDa4jLmbCKUerf85TFALUzGDH/5DMOwOEBNKhjynN5zXwY
         SwPQ==
X-Gm-Message-State: AOAM533JI0+5MCcE1/xN9xBPSHJri7ndCtVIj18H4j02Rq+aXXvimZIb
        uwbLUej65SIuuUtWMuGwe+U5QA==
X-Google-Smtp-Source: ABdhPJxh18Iex/zR5QdzoK6VikkBPDY8E2/oAyYW/dloMMublMlaJLI0hJSIcJwBfxJ2wTpMKDi89A==
X-Received: by 2002:adf:e650:: with SMTP id b16mr12543937wrn.273.1618816952381;
        Mon, 19 Apr 2021 00:22:32 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id l7sm23627114wrb.35.2021.04.19.00.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:22:31 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:22:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v6 1/4] mfd: rt4831: Adds support for Richtek RT4831
Message-ID: <20210419072229.GA4869@dell>
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <CADiBU3-d3_L8RTeYCirnfjJdG=ea6UVenAi8O8GO_LvOaB7OdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiBU3-d3_L8RTeYCirnfjJdG=ea6UVenAi8O8GO_LvOaB7OdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021, ChiYuan Huang wrote:

> Hi, Linux mfd reviewers:
>    It's been three weeks not to get any response from you.
> Is there something wrong about this mfd patch?
> If yes, please feel free to let me know.

Couple of things:

First, if you think a patch had fallen through the gaps, which does
happen sometimes, it is generally considered acceptable to submit a
[RESEND] ~2 weeks after the initial submission.  FYI: This was such a
patch.  It was not on, or had fallen off of my radar for some reason.

Secondly, we are really late in the release cycle.  -rc8 has just been
released.  Quite a few maintainers slow down at ~-rc6.  Particularly
for new drivers.

No need to resubmit this driver this time.  It is now on my to-review
list and I will tend to it shortly.

Thanks for your patience.

> cy_huang <u0084500@gmail.com> 於 2021年3月28日 週日 下午11:24寫道：
> >
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > This adds support Richtek RT4831 core. It includes four channel WLED driver
> > and Display Bias Voltage outputs.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > The RT4831 regulator patches are already on main stream, and can be referred to
> > 9351ab8b0cb6 regulator: rt4831: Adds support for Richtek RT4831 DSV regulator
> > 934b05e81862 regulator: rt4831: Adds DT binding document for Richtek RT4831 DSV regulator
> >
> > since v6
> > - Respin the date from 2020 to 2021.
> > - Rmove the shutdown routine.
> > - Change the macro OF_MFD_CELL to MFD_CELL_OF.
> >
> >
> > since v5
> > - Rename file name from rt4831-core.c to rt4831.c
> > - Change RICHTEK_VID to RICHTEK_VENDOR_ID.
> > - Change gpio_desc nameing from 'enable' to 'enable_gpio' in probe.
> > - Change variable 'val' to the meaningful name 'chip_id'.
> > - Refine the error log when vendor id is not matched.
> > - Remove of_match_ptr.
> >
> > since v2
> > - Refine Kconfig descriptions.
> > - Add copyright.
> > - Refine error logs in probe.
> > - Refine comment lines in remove and shutdown.
> > ---
> >  drivers/mfd/Kconfig  |  10 +++++
> >  drivers/mfd/Makefile |   1 +
> >  drivers/mfd/rt4831.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 126 insertions(+)
> >  create mode 100644 drivers/mfd/rt4831.c

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
