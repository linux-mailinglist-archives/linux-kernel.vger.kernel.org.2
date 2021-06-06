Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED34739D1DE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 00:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhFFWbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 18:31:35 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:37408 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhFFWbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 18:31:34 -0400
Received: by mail-lj1-f179.google.com with SMTP id e2so19466817ljk.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UwWzxYz9+U86AfgXfL1goygie7Gy2zkFjiUJTJ3EoKs=;
        b=kxMgCYy0vlpyi5AxRTHdMn6e+jmq/2X4YVIV7ESue3MoUcw92UfESVJ3sdbDulxWA1
         tPdf3RMim5CdNxQH4OEUKwrHvJnjGln2XCnil/Kd6HralhcTQrUYq+J0uan1laHAr8i9
         AVNc8GksMQVDByd6y3gKsDYGiXZbZ+sazjLwH9Zfczi0tPK+lrLvqlV7bhxCoG1+FxAA
         9N5LDRa6ULJ8os2HzpYhySygRDYFQScmw1IVTHhH6tTF2ej/5RVdFOnqx3urP68g4ZPf
         6S0ZH4fjO247kE6HloU4lbp6BgAfT+H8TigLljR//wJL1hgtqQ1Or9u0aP6Vp1MX4G43
         bP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwWzxYz9+U86AfgXfL1goygie7Gy2zkFjiUJTJ3EoKs=;
        b=GbPqmKwS3lanWWwWo+ns2wejRGEkEqT0g9Tl+yPzspaZ2RXP4CzSj69/QiYu+oZNsk
         BeV9ISyXacQCKG/AJeQWfPb6uLgDaWW3Mc1YtSSAh3EK7TjrCjlXLVRNk64q91xt5E4v
         hPEDhAhp3Ky89j+VLK6NsS0k8/b7OAc0AOlpYRsGm9Xn6vBlHIM1GamYyN752x8ldS4L
         PfB7M0uRBLmtkWZ2v2oYT9fh+O9tukJnuTYoiz0QCqHyx9ecT1wsZ6PWhGrGSQml0Vpr
         9tksmcGzkTo1kYUKrCHzBIKiXt9PLqof5+hOQsaRSVupeEiINoFONSXG57ezJIuaBz3i
         7gjg==
X-Gm-Message-State: AOAM532k0fI0AXi5kNGr78MZzuWSNEofr5r+JV+LHBq2Tv83UPEWMtoI
        fSetCVldHCHLF36zLYtjDaOF12VKcuWtpvg1h+nvdg==
X-Google-Smtp-Source: ABdhPJwd0M4l7QBJaYxqX2KVo84RtPuoN2RuZ8lx+Cbpug6jYPX8lTD/yitLZl+l8asOm1ZUPwC7gsj2Leas0Dk+ukE=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr12719543lji.273.1623018508658;
 Sun, 06 Jun 2021 15:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210601104429.GA26261@DESKTOP-I556OUN.localdomain> <AM7PR06MB6769E1183F68DEBB252F665ABA3E9@AM7PR06MB6769.eurprd06.prod.outlook.com>
In-Reply-To: <AM7PR06MB6769E1183F68DEBB252F665ABA3E9@AM7PR06MB6769.eurprd06.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Jun 2021 00:28:17 +0200
Message-ID: <CACRpkdZ2iZSkQngyN-XFfCrjPv+_C4Z4+OnewfXg+dsw+SnLgw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mcp23s08: fix race condition in irq handler
To:     Radim Pavlik <radim.pavlik@tbs-biometrics.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Preston <thomas.preston@codethink.co.uk>,
        =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>,
        Phil Reid <preid@electromag.com.au>,
        Lars Poeschel <poeschel@lemonage.de>,
        Jason Kridner <jkridner@gmail.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 12:48 PM Radim Pavlik
<radim.pavlik@tbs-biometrics.com> wrote:

> Checking value of MCP_INTF in mcp23s08_irq suggests that the handler may be
> called even when there is no interrupt pending.
>
> But the actual interrupt could happened between reading MCP_INTF and MCP_GPIO.
> In this situation we got nothing from MCP_INTF, but the event gets acknowledged
> on the expander by reading MCP_GPIO. This leads to losing events.
>
> Fix the problem by not reading any register until we see something in MCP_INTF.
>
> The error was reproduced and fix tested on MCP23017.
>
> Signed-off-by: Radim Pavlik <radim.pavlik@tbs-biometrics.com>

The patch makes perfect sense to me.

This message was mangled really seriously and could not be
applied, but since the patch was simple I recreated it locally
and applied for fixes.

It also seems the lore mail archive has not accepted it.

> +       if (intf == 0) {
> +               /* There is no interrupt pending */
> +               goto unlock;
> +       }
>          if (mcp_read(mcp, MCP_INTCAP, &intcap))
>                  goto unlock;
>
> @@ -368,10 +372,6 @@ static irqreturn_t mcp23s08_irq(int irq, void *data)
>          mcp->cached_gpio = gpio;
>          mutex_unlock(&mcp->lock);
>
> -       if (intf == 0) {
> -               /* There is no interrupt pending */
> -               return IRQ_HANDLED;
> -       }

Paging some other mcp28s08 users to make sure they don't have
a problem with this.

Yours,
Linus Walleij
