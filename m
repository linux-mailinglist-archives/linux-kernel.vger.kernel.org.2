Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF3D349C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 23:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhCYWAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 18:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhCYWA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 18:00:26 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6080EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 15:00:25 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g38so3805966ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u/C9TsTCQ0PRFFrgi26e+qLoeB/aiJxeCwqVoG6hVhU=;
        b=ILL316a2Wk1nu8gaGtD5yCRvHQgTxFPuc7pThI2zDVE2XEx7NZCaAvFKvUuGff0dMQ
         Pg5g42psvw9VnGP51Gu4+N0jH+/XUWpqvZjxTvDHdAZiIJwuH7sf3yOqvTJoNB0C8UOx
         1U2V8keMS2jiQv1ZGdoLs+bcA43niAaGPYGCjTeJd4BQWdICncGABtUnRClwHocZTPi3
         /Gxg3zA4lmAwqr+lnG/0v14HJ/yp5TFf9n7dcukax9hOtk9wnEQq2aDTGDNGIpSt/8DL
         o5z4hXIJvSWqrQfYmkzl+5g+fH8qcummVH1N3MDzAma0aQkqmxKF6QMaoYtPsMy5W1gh
         y0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/C9TsTCQ0PRFFrgi26e+qLoeB/aiJxeCwqVoG6hVhU=;
        b=Si9Y3luMynlD88oaxOREHAB5QkM7m1zWr9dPjG7O3oea8T70ulEOoKJ7SwS2SbAiNm
         Ghk8ZGcOfP4SXIpGmAbm8JZXaRx0VDfn14uXSexZBO9a9DPiHMmdPla0yyywsaEZLODh
         lCGfaFJ4DELwpEPTs7KY7gjWX81CTjBO5LiC72Qa8zxgm/mr6bWwI1fQvUyUxyWfJSqx
         tV83dvQpWNCwQn/CgJ06yUNTN+pfwqNtzjlLM+nsFyOjISuK1C9XlJqSTMEUcIrsc0Ik
         EHcCFwF1OYxhnD8c4vL5rVua31Lekqe2SoS4KNOLQBFPXzAJ+ZFx0BkDU63H/ntv12v0
         c1iA==
X-Gm-Message-State: AOAM532ec1NQqb8xU6OcN4NhePNKAP7X7zwA7FRNBsiRJwgNfZ7y7r+4
        82VwHoXnFT93/QYVXMdYw0AujxFQTvnThuaP5fL7bg==
X-Google-Smtp-Source: ABdhPJxkbBD0rZxKJpmIzqouHs/GD7vYYE0FJghizB65LpBmBGL1cNLw/f7scE2bayVmbPxDMN56CUp4BGgh4B163hM=
X-Received: by 2002:a25:3854:: with SMTP id f81mr7308021yba.466.1616709624344;
 Thu, 25 Mar 2021 15:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com> <161670714806.3012082.14889556041667946511@swboyd.mtv.corp.google.com>
In-Reply-To: <161670714806.3012082.14889556041667946511@swboyd.mtv.corp.google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 25 Mar 2021 14:59:48 -0700
Message-ID: <CAGETcx9Snf23wrXqjDhJiTok9M3GcoVYDSyNYSMj9QnSRrA=cA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by default""
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 2:19 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Saravana Kannan (2021-03-02 13:11:32)
> > This reverts commit 3e4c982f1ce75faf5314477b8da296d2d00919df.
> >
> > Since all reported issues due to fw_devlink=on should be addressed by
> > this series, revert the revert. fw_devlink=on Take II.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
>
> This seems to break the display on lazor (see
> arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi) on linux next today
> (next-20210325). I tried booting with fw_devlink=permissive on the
> commandline and the display came up again. Looking at the drivers that
> are in the deferred state there are three:
>
>  localhost ~ # cat /sys/kernel/debug/devices_deferred
>  ae94000.dsi
>  panel
>  2-002d
>
> and the panel has these suppliers:
>
>  localhost ~ # ls /sys/devices/platform/panel/
>  driver_override  power                supplier:platform:pp3300-dx-edp-regulator
>  modalias         subsystem            uevent
>  of_node          supplier:i2c:2-002d  waiting_for_supplier
>
> Is there some sort of circular dependency going on that is preventing
> either driver from probing? My understanding is 2-002d is the dsi bridge
> (compatible is ti,sn65dsi86) and that is waiting for the panel to come
> up, and the panel does a circular dependency where it requests the hpd
> gpio from the dsi bridge at probe but then ignores it and tries to get
> the hpd gpio later when powering on the panel. If it didn't do this it
> would probe defer forever because the bridge supplies the hpd gpio to
> the panel and the panel provides the panel to the bridge driver.

I had a side chat with Stephen. The problem is due to a cycle of
dependency between panel and bridge (supplier:i2c:2-002d). panel needs
GPIO from bridge, and bridge has panel as a remote-endpoint. But
fw_delink isn't able to break the cycle because it doesn't parse
"remote-endpoint" yet. So for now, only permissive will work for this
case.

I'll look into adding remote-endpoint support. But that's a bit more
complicated.

-Saravana

>
> >  drivers/base/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 45c75cc96fdc..de518178ac36 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1538,7 +1538,7 @@ static void device_links_purge(struct device *dev)
> >  #define FW_DEVLINK_FLAGS_RPM           (FW_DEVLINK_FLAGS_ON | \
> >                                          DL_FLAG_PM_RUNTIME)
> >
> > -static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
> > +static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_ON;
> >  static int __init fw_devlink_setup(char *arg)
> >  {
> >         if (!arg)
