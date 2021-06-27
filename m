Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2833B551E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 22:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhF0U2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 16:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhF0U2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 16:28:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8776EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 13:25:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c7so22231533edn.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/Zn1I2M+Wt1TmihQs535Y+fjsrSFYX9XLAbFt7QxGI=;
        b=mQU+QpABF4SUnwGx7zw4zY0rpx9/ZaLTR2ImzkDUwpnixcF/AYS2w+8NYxUUor+e/0
         EH+Fp9fNRXUNwZ3aDNLgl7V+SlqTJpW57h+W/XRlTc9tgGJQxETpA/SsvoMepiW1ZJ+n
         CIT8MQPzvJlEGukHWj33UVrCGvFV9S0J/7KH1R7rJ18G5ExTfVGD8M++f/13cNP6Yp43
         ILyiurn7sqDk/4kp22q426Dn57jvrTkkGU2U1Tcq3r34tHHccLcLZdS9CuOY0W9HWHq3
         +cgqB5zRX/2Lmlp/vYaaXQrEBZhVaZ0L4u7nhgdqaW0tTq3wxSkptTXjMIuRxdyMSvES
         XTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/Zn1I2M+Wt1TmihQs535Y+fjsrSFYX9XLAbFt7QxGI=;
        b=Z5v2Ov5vdXs+85farSq/kMaHAq4DZwH9U9mZSIYFYdSrboGgiRYSFfl7aM4tII48gD
         rEug+hEjcmc1FikntG8JMkkUfiiY6pLBBGGZMr7r0Sfrj5dMBm1pmcyCAnJq47st3shm
         4WsjWDM/7igcs1hSnkU1PDs6P/IcBpp2SNATELEoF3W5Z2ZU1CJCiYsofdpeH6vHzAJX
         vGn2fgURmgY+AFoTQALWN2BX/ed1L0cf4RB1lmA7vl8g3eraidv3Vh9dUf9YxpctlWg/
         hEnhxhaXewDNAzrPjbVcskVeDxkQXqzax8Rxfl9rdCFk10CbPzN0yS/gjGGsoex7VN9h
         X2Aw==
X-Gm-Message-State: AOAM533bisgxjW8i4GZNmo1T/TlaOKePGWfGXFYxHh0o3CfVSgyxd6y/
        jyfVp8PHJntAKzvfnb6NjPEd/DSAnBoJh8e0Rns=
X-Google-Smtp-Source: ABdhPJwr6Rc0LaKsO2ZI8Ag1Z2/TERum8nYsgvoqHGVvdsLrKU5BtJjQMKrI5h5ju+ajrEHfzhORg4vRB8Jzcur/CDw=
X-Received: by 2002:a05:6402:706:: with SMTP id w6mr28300727edx.176.1624825543911;
 Sun, 27 Jun 2021 13:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-7-linux.amoon@gmail.com>
 <CAFBinCCE+6G7QtDoxfbcZVVRf-MDX-epSo=_k_PJZgWX+_Whvg@mail.gmail.com>
 <CANAwSgRqixugUr-t2OheLBVwD=EOkaLqxnGkT-Bx=p_A4Nyr8Q@mail.gmail.com>
 <CAFBinCALsnpbJGEb4LBLd_jy3E8fOZAQaacz-P7ijfkeyYg2dA@mail.gmail.com>
 <CANAwSgRABOyWYJPrrw64Wa6j2D94T4tybn7MHGCTbBowt7UncA@mail.gmail.com>
 <CAFBinCD91eYNXSqnmDKoAvJHWqqRbXVjnaq9RuRNCnip9kKqkw@mail.gmail.com>
 <CANAwSgRzY+699aSS9MVGAJYVR6_0Ni75JPhO9=LKunHQK0p=oA@mail.gmail.com> <CANAwSgQktfn9Q=PJhx5Uq0UQ2dHqJwjKu1RWyb2k=-dA9=+BSQ@mail.gmail.com>
In-Reply-To: <CANAwSgQktfn9Q=PJhx5Uq0UQ2dHqJwjKu1RWyb2k=-dA9=+BSQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 27 Jun 2021 22:25:33 +0200
Message-ID: <CAFBinCD+seUuYUrObiqJNgEi_DaULB3nU+QQFHz9d85dAU06ZA@mail.gmail.com>
Subject: Re: [RFCv1 6/8] phy: amlogic: meson8b-usb2: Use phy reset callback function
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Sun, Jun 27, 2021 at 10:07 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> Sorry for the delay.
> We could switch the reset logic to
> *devm_reset_control_get_optional_exclusive* as below
> to fix the reset line, since both the dwc2 c90c0000.usb and c9040000.usb
> will have their own context to reset control register, it means the
> reset line is not share
> between two USB PHY nodes.
This is something I don't understand.
As discussed in our previous mails reset_control_reset in case of the
USB PHY driver (which uses the RESET_USB_OTG reset line for *both*
PHYs) is equivalent to the following code in the vendor kernel:
  aml_cbus_update_bits(0x1102, 0x1<<2, 0x1<<2)

We have two PHYs but only one reset line. So in my own words I
describe the reset line as being shared.

>
> -       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> +       priv->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
> +                                                               "reset");
Have you boot-tested this?
Without any .dts changes this will return NULL because there's no
reset-names = "reset"; in the .dts(i).
If you replace "reset" with NULL then I assume that the second PHY
will fail to obtain the reset line because it's shared between two
devices but we're trying to obtain it exclusively for both (PHYs).


Best regards,
Martin
