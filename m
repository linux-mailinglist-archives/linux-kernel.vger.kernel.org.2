Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34693DABF9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhG2Tm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhG2Tm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:42:56 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CE2C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 12:42:51 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d9so4753935qty.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=64yQslIW6W7QqPGTuD8FUE1efa8mhm9yDQIT6VE7nC8=;
        b=Yk0G8QEfIJq8Kf9ydFd0uXVVLhLzCdeUlUn2XOJVQOguVJscKeacurhDnkoO/G3iJm
         HrZLkrUIejU8w+NQzGBMToqbUONRa8UDrRAwh1pnk+bi0VPwirfSq8YlxHf11mFz9qZA
         PJKOvDYGwCGs5Z7+r/7nXEGZqEWvUEkQSTCVo7k2ukrkFK1gIdhhUXqFIHCaA9aB+Sbj
         oa/xdshjzSmFTxOaPdLa6WLwJL33LYXiicI9IcU8y2FTiY/2fAUOG3YMv3dotoLXtrRK
         P2VGJqenukf7m6qvqKP6rpO8gUg5f2pGmv2qejujVzN2FABKYq59/LcHMgfVSqneAr4w
         +8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=64yQslIW6W7QqPGTuD8FUE1efa8mhm9yDQIT6VE7nC8=;
        b=HzGo+JKqT+V0n865+ZVWQiwHlEmjJTedf1AjLuaTAydp2i6JL7KTRpIveLxM+V7GJv
         /A3OMfBLcfz8xlBhdIoTtsnOTKzav/p94h8+tsNgPJwxVPczL11MB/3Ujh2cBgMhtOEv
         BhIk83uDyijAlrqC/v7EhKdvacX3C7iUTR20yGp1gYGLFciYZRiKDrpoUnrnY4192gLj
         A1JiB1j3u+yuPYBsoJEjwWJVnnCxowUYa3LuDGTd4SA4hUYP8eccJDnAvcR/IMrwfgDp
         A5Dxqu5tvYYwlLZCoSnEwHHkp8Zope3f/Q9kXdJfwM2g3XobNHFQ0+5/9o0QjvCuwzND
         enrA==
X-Gm-Message-State: AOAM533eNY1Mcm2aEyE/Oh3euX35n9RLoqpIqsK5haQduS0xh1VPIi2U
        DLa8/Llrv7Fyz8K0O8K2MuXujQ==
X-Google-Smtp-Source: ABdhPJzpbNXETkFkSSyKK2tzWyQADm607VDPajsOrlr0a7VYaR6XFHEiudYACcvx9lTufqmd4Nlq5Q==
X-Received: by 2002:ac8:51ca:: with SMTP id d10mr5650540qtn.97.1627587771113;
        Thu, 29 Jul 2021 12:42:51 -0700 (PDT)
Received: from localhost ([167.100.64.199])
        by smtp.gmail.com with ESMTPSA id u7sm1688689qta.27.2021.07.29.12.42.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Jul 2021 12:42:50 -0700 (PDT)
Date:   Thu, 29 Jul 2021 15:42:46 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        linux-arm-msm@vger.kernel.org, a.hajda@samsung.com,
        sam@ravnborg.org, airlied@linux.ie, bjorn.andersson@linaro.org,
        daniel@ffwll.ch, devicetree@vger.kernel.org,
        rodrigo.vivi@intel.com, jonas@kwiboo.se, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, robert.foss@linaro.org,
        jernej.skrabec@gmail.com, mripard@kernel.org,
        linus.walleij@linaro.org, maarten.lankhorst@linux.intel.com,
        rajeevny@codeaurora.org, lyude@redhat.com,
        thierry.reding@gmail.com, steev@kali.org,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] drm/panel: atna33xc20: Fix the Samsung ATNA33XC20
 panel
Message-ID: <20210729194242.GB31127@art_vandelay>
References: <20210728164557.1882787-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728164557.1882787-1-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 09:45:51AM -0700, Douglas Anderson wrote:
> 
> The overall goal of this series is to make the Samsung ATNA33XC20
> panel work more properly. As part of this, we have:
> * A bugfix for the recently abstracted DP AUX backlight code.
> * A bugfix for the sequencing of the ti-sn65dsi86 bridge driver.
> * Removal of the panel from panel-simple and moving it to its own
>   driver.
> 
> If the bugfixes look good but the rest of the series needs work then
> those could land early on their own. There's no real compile time
> dependency on the bugfixes, things are just glitchier without them.
> 
> NOTE: this series will (slightly) conflict with my other recent series
> making eDP panels probable [1]. The conflict is easy to resolve and
> I'm happy to repost either once the other lands. It should be noted
> that the fact that the Samsung ATNA33XC20 needs its own panel driver
> means that it _can't_ handled as a probed driver. I think this is
> fine, at least for now. I don't think it would be easy to make a
> unified design with this panel and other panels given that it's an
> AMOLED panel and has a whole bunch of different components on board.
> 
> [1] https://lore.kernel.org/r/20210723002146.1962910-1-dianders@chromium.org/
> 
> 
> Douglas Anderson (6):

Hi Doug,
Thanks for the patchset, it all looks to me.


For all 6:

Reviewed-by: Sean Paul <seanpaul@chromium.org>

Sean

>   drm/dp: Don't zero PWMGEN_BIT_COUNT when driver_pwm_freq_hz not
>     specified
>   drm/bridge: ti-sn65dsi86: Fix power off sequence
>   drm/bridge: ti-sn65dsi86: Add some 100 us delays
>   Revert "drm/panel-simple: Add Samsung ATNA33XC20"
>   Revert "drm/panel-simple: Support for delays between GPIO & regulator"
>   drm/panel: atna33xc20: Introduce the Samsung ATNA33XC20 panel
> 
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c         |  17 +-
>  drivers/gpu/drm/drm_dp_helper.c               |  10 +-
>  drivers/gpu/drm/panel/Kconfig                 |  12 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 366 ++++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c          |  61 ---
>  6 files changed, 398 insertions(+), 69 deletions(-)
>  create mode 100644 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> 
> -- 
> 2.32.0.432.gabb21c7263-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
