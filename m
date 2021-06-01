Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BDE39677E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhEaR6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhEaR6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:58:48 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC57C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 10:57:06 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u11so13001295oiv.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DSZZAxEHbdLZZFw3vP+gxBVlQqCyrawB+uRSZuIZgfE=;
        b=RP19OH9CpI0aNDLkOYv5uoSwZpnzBzCwG0E1jDZxgOQ9DkRGGQYX9AtUXLRsZUgVPo
         RhURb0Raz1N7KIW7dJk7am/V/UUhd1h7rhObulSEsAMaZIsfDG58KTC/2JJCrx0H5Blf
         diMBqTGi5N3gPAiSkrw7aGA6R5O3N10wvHQwj67IHblAzBpQlFMbYyWK6NKnx5HYhYpG
         7UpGewtypbHUCieQA7m+QYitIdJ5XPYD2btoDY5+khlbBWoe4QPpC965AwC3FlZk0SfY
         PLYAllF1azN0SygOufTNLacrELbXVw8k30ShmM228igEYhszT1xLdFQhVAXDFon1SyL9
         S/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DSZZAxEHbdLZZFw3vP+gxBVlQqCyrawB+uRSZuIZgfE=;
        b=Me9C5khnUj0lC2qmFUNhr4im/RoNRxDQd8ntweDE/70KgAjEffvuqWUZqHG8TIrNIT
         NZIDn0KMrUGvBJYqMYnSAQcQJKg34r38Xgj4lRSwNgrK1wGgXn7tK+4QmEHMYiN5ucYn
         E52gIdIhYb2RbvQ2elqIg0IhXHNxCtpP6o098Pg6Y+ptKgQw6LFZwhCnWwJGFMROMX7S
         448K0AUgMyeV/LScjTl+/vYoRo/Mw9N4dBN4iomqN9thlDao3bfC+tuHwCyYHBH2fK2v
         Ya0+0O0Aamm0E6ZfsrSadvOajGh81lDNWEKnLJvnjxxe7/IjCkujcqZXJxRwduN1IKTR
         OpBA==
X-Gm-Message-State: AOAM531DlX4GzFlSHcsbJ+u9RvQQLWtHy75YNh/iAIeRk7FdsH41OO4t
        kqZIuv9ZWlqSOBBpAGf5Glbk7Q==
X-Google-Smtp-Source: ABdhPJyMSM6FwtPAzJOnXLO+pv4nc6c2SOvHU9KLqi26VKWEHZ1Ea9pf222zATy1Qo3Pp5k6oOaR9w==
X-Received: by 2002:a54:4113:: with SMTP id l19mr203643oic.38.1622483826247;
        Mon, 31 May 2021 10:57:06 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 7sm3169597oti.30.2021.05.31.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 10:57:05 -0700 (PDT)
Date:   Mon, 31 May 2021 12:57:03 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>, evgreen@chromium.org,
        mka@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, linux@roeck-us.net, rnayak@codeaurora.org,
        lsrao@codeaurora.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 3/5] arm64: dts: qcom: sc7180: Enable SoC sleep stats
Message-ID: <YLUjbwFSJOSWS0IV@builder.lan>
References: <1621596371-26482-1-git-send-email-mkshah@codeaurora.org>
 <1621596371-26482-4-git-send-email-mkshah@codeaurora.org>
 <CAE-0n53ySKwDwzRYFYjnQnqVAujVrkik2U-PeCuS61xQU-hbWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53ySKwDwzRYFYjnQnqVAujVrkik2U-PeCuS61xQU-hbWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26 May 18:30 CDT 2021, Stephen Boyd wrote:

> Quoting Maulik Shah (2021-05-21 04:26:09)
> > Add device node for SoC sleep stats driver which provides various
> > low power mode stats.
> >
> > Also update the reg size of aoss_qmp device to 0x400.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7180.dtsi | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > index 6228ba2..889d04d 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > @@ -3215,7 +3215,7 @@
> >
> >                 aoss_qmp: power-controller@c300000 {
> >                         compatible = "qcom,sc7180-aoss-qmp";
> > -                       reg = <0 0x0c300000 0 0x100000>;
> > +                       reg = <0 0x0c300000 0 0x400>;
> >                         interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
> >                         mboxes = <&apss_shared 0>;
> >
> > @@ -3223,6 +3223,11 @@
> >                         #power-domain-cells = <1>;
> >                 };
> >
> > +               rpmh-sleep-stats@c3f0000 {
> > +                       compatible = "qcom,rpmh-sleep-stats";
> > +                       reg = <0 0x0c3f0000 0 0x400>;
> > +               };
> > +
> 
> Does this need to be in DT? Can the sc7180-aoss-qmp driver use the
> aux-bus and stick the sleep stats device on there?
> 

The AOSS memory space has N chunks of "message ram", one is used for the
QMP protocol (presumably the APSS specific one), a different one is used
for the sleep stats.

I presume we could have come up with a binding for the entire AOSS/AOP
and then describe (either implicit or explicitly) the QMP and
debug-stats under that.

But we'd also have to come up with the same container-device for the RPM
case.

Regards,
Bjorn

> >                 spmi_bus: spmi@c440000 {
> >                         compatible = "qcom,spmi-pmic-arb";
> >                         reg = <0 0x0c440000 0 0x1100>,
