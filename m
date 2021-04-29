Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3C36E2E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 03:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhD2BMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 21:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhD2BMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 21:12:33 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7FBC06138C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 18:11:47 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y2so74283194ybq.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 18:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9WmxfQPgVB/G8qqdqqrH4JxR1XC119NUyqOOtSd7t0=;
        b=pkiPHPNLc8oPY1Rpg9s6MMH9zsVYb3Pu6hknNjJ97Hfi1mRnSBTaBnKpkK1xFjd1Qc
         cQcOSKlv6GspGLFBVFS0a2R7wfDy66R5CFpgbbx4KptsbtihfP16CiZn9rhGgXqx5QTW
         bT7wJSVgy86XNC/E1yQdfItBAZhtztfAwi05/r0kJhF9SMDdROLy1hNoB4qjsCCc7xWl
         mnFO4W/wNfSaDiAaT4Hzi7/2XKbK/+nwY+9Li/v4xqODqdRq+++/zwuK2aVSJ6jeZ06F
         W59O7/MT/99ty+gNnLuDf32EQ5etfkSEubBJ3iZEk34moqDnV4u5QwEcMfSvrieB519k
         avQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9WmxfQPgVB/G8qqdqqrH4JxR1XC119NUyqOOtSd7t0=;
        b=k1Fs+nOdeub89C2ODRoRg16LS/zgJlgmSo6ZvvlUvNk0HbxyNXnoGkA3epOLJGuxGb
         SAP10NcUkB9rB4q6pY8KkoQKsIB2lTiu1VRWMMaxnHvLRFlBQnJuwyICmX/WvJ0GhfG9
         gH/1O//39Z/5BeNlDXzGM2owPQjZEtcZGPn3FQYwckUtUSLoyrgXT7xb2Lkfk1wR9K1t
         iA3HWiOdRLTex9TbiBotjNIGu7+QMQR03sY8JDwWZNbxMIFLxCSdXW+72EniA7zfzWzO
         Db96ZT0IPP4pknKZ6m/5fMKSNv0GLdMNVRdMkcF4WEaXJTYGMFa+EvlG1ZEMgApNdk5T
         X9ww==
X-Gm-Message-State: AOAM532qSrngP1RQBrGnl7fWnZ12BceFNkFcjlLDYRqlttdE3g+fRoor
        wKSFFVxuy1pgUIx4+YdwEhTpq7CuRpHEMCpxoZ24hA==
X-Google-Smtp-Source: ABdhPJzGFBnav+DZBGGJcieg9JxgTULrcj3YfzoYD2uRXeNcTYI7rbQImezTdi5sUdA9XukgcMPYmupPisXhoBxFVf8=
X-Received: by 2002:a25:58d5:: with SMTP id m204mr47013043ybb.32.1619658706418;
 Wed, 28 Apr 2021 18:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210428222953.235280-1-sebastian.reichel@collabora.com> <20210428222953.235280-2-sebastian.reichel@collabora.com>
In-Reply-To: <20210428222953.235280-2-sebastian.reichel@collabora.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 28 Apr 2021 18:11:10 -0700
Message-ID: <CAGETcx_YoYJkOgh=kX7tZf-oAWGMmTDT+Azm1A3thWD1SRy_4A@mail.gmail.com>
Subject: Re: [PATCHv2 1/5] rtc: m41t80: add support for fixed clock
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rtc@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 3:29 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Congatec's QMX6 system on module (SoM) uses a m41t62 as RTC. The
> modules SQW clock output defaults to 32768 Hz. This behaviour is
> used to provide the i.MX6 CKIL clock. Once the RTC driver is probed,
> the clock is disabled and all i.MX6 functionality depending on
> the 32 KHz clock has undefined behaviour. For example when using
> the hardware watchdog the system will likely do arbitrary reboots.
>
> Referencing the m41t62 directly results in a deadlock. The kernel
> will see, that i.MX6 system clock needs the RTC clock and do probe
> deferral. But the i.MX6 I2C module never becomes usable without the
> i.MX6 CKIL clock and thus the RTC's clock will not be probed. So
> from the kernel's perspective this is a chicken-and-egg problem.
>
> Technically everything is fine by not touching anything, since
> the RTC clock correctly enables the clock on reset (i.e. on
> battery backup power loss) and also the bootloader enables it
> in case an something (e.g. an unpatched kernel) disabled this
> incorrectly.
>
> A workaround for this issue is describing the square wave pin
> as fixed-clock, which is registered early and basically how
> this pin is used on the i.MX6.
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc-m41t80.txt |  9 +++++++++
>  drivers/rtc/rtc-m41t80.c                             | 12 ++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-m41t80.txt b/Documentation/devicetree/bindings/rtc/rtc-m41t80.txt
> index c746cb221210..cdd196b1e9bd 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-m41t80.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-m41t80.txt
> @@ -21,10 +21,19 @@ Optional properties:
>                        clock name
>  - wakeup-source: Enables wake up of host system on alarm
>
> +Optional child node:
> +- clock: Provide this if the square wave pin is used as boot-enabled fixed clock.
> +
>  Example:
>         rtc@68 {
>                 compatible = "st,m41t80";
>                 reg = <0x68>;
>                 interrupt-parent = <&UIC0>;
>                 interrupts = <0x9 0x8>;
> +
> +               clock {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <32768>;
> +               };
>         };
> diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
> index 89128fc29ccc..b3ece42b6f90 100644
> --- a/drivers/rtc/rtc-m41t80.c
> +++ b/drivers/rtc/rtc-m41t80.c
> @@ -544,10 +544,22 @@ static struct clk *m41t80_sqw_register_clk(struct m41t80_data *m41t80)
>  {
>         struct i2c_client *client = m41t80->client;
>         struct device_node *node = client->dev.of_node;
> +       struct device_node *fixed_clock;
>         struct clk *clk;
>         struct clk_init_data init;
>         int ret;
>
> +       fixed_clock = of_get_child_by_name(node, "clock");
> +       if (fixed_clock) {
> +               /*
> +                * skip registering square wave clock when a fixed
> +                * clock has been registered. The fixed clock is
> +                * registered automatically when being referenced.
> +                */
> +               of_node_put(fixed_clock);
> +               return 0;
> +       }
> +
>         /* First disable the clock */
>         ret = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
>         if (ret < 0)

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana
