Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271D6458144
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 00:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhKUAAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 19:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbhKUAAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 19:00:45 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2559C0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:57:23 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bk14so29578699oib.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4EATv+FwODOuV+ZRABVg9/1CC2ykd4xp59vZNvIXH9E=;
        b=ifIntxF6LyuBffRnPfXgOKWqFgH4WvmRP3WWC6D+7ap/7S7DhiUcHzSLfZ73ncYGM9
         gppVaRD/j5QjQWkyepHbA7UTXlGxxOv5zUSjso7EviPU40bru07cYtq3xwFwpsMMucyo
         mEXfXKmVrN32iGENW1RZ7K/QUSzeXJmKBEFOK/v0eSQ2c6bgKfgRYYeATDgHvdM3XSdD
         dx2+AGjfBuwmJznEGGGibcRn6zIh8mV6rMePa+M/hGIThZl5dTdxLiDjS5m4RqdJusSu
         OJHlXWz6uRdKKldwTNYQB41r33AOgaGLQrZnIxX3DSKz1WcD0Vln1rwaOdB5psKTCl6u
         qrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4EATv+FwODOuV+ZRABVg9/1CC2ykd4xp59vZNvIXH9E=;
        b=XMHlPvyJnka+PpXrU2fTqipydn9uQfDpxMPLkYUL4SH8Sbb6LA4PKQTvmWkBU0yrTD
         Hx12h2+6txCdsk4+nw0G/xKngQ1ZVZjWRS4P/EIRE85GLnLLscAmkUtkgadgD+Pb9Xx2
         0xcNY2TLgU8yQp8wjHc3BlUTjHIWbxqnyGL1bZXnNsuXkqV3B3lpUURxS4SIt7cWHlkv
         auRzcgqoqsF4Pac/6gD76pIV3s/ZQX3RytbqnHFd66TTiDAqtWwFhhR/IyR1rMcEfDHo
         t3gExaxG6o4Vt145RGDILllJzbopbAvBl6FnzhbPUcG7FYUhqQt+D1O/S+2k2nV/dx3m
         BI2A==
X-Gm-Message-State: AOAM5315RpUJxmuMqeZ4R+mZ/lgteagYR4wEntWs0+PX5k/1BTm3fV5K
        xcqCHnPEsaYvgCFBbOWmj3TF1A==
X-Google-Smtp-Source: ABdhPJzHkQD78j6D98A9tJ4kAlGW8ylSPUToqFiXbMsGu6yZQNpzYn9P4F+T+hDJ8MwVkAR0ryWAlg==
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr9808969oia.95.1637452643175;
        Sat, 20 Nov 2021 15:57:23 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s13sm856669otv.34.2021.11.20.15.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 15:57:22 -0800 (PST)
Date:   Sat, 20 Nov 2021 17:57:18 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Caleb Connolly <caleb@connolly.tech>,
        Dang Huynh <danct12@riseup.net>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexey Min <alexey.min@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: Re: [PATCH v4 5/8] arm64: dts: qcom: sdm660-xiaomi-lavender: Add
 volume up button
Message-ID: <YZmLXtvxH57/Cv43@builder.lan>
References: <20211120214227.779742-1-danct12@riseup.net>
 <20211120214227.779742-6-danct12@riseup.net>
 <5ecda386-0ae3-cf46-9f91-1f54c3b4f89d@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ecda386-0ae3-cf46-9f91-1f54c3b4f89d@connolly.tech>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 20 Nov 15:51 CST 2021, Caleb Connolly wrote:

> 
> 
> On 20/11/2021 21:42, Dang Huynh wrote:
> > This enables the volume up key.
> >
> > Signed-off-by: Dang Huynh <danct12@riseup.net>
> > ---
> >   .../arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
> > index 9a6684922804..c7bdf4c28be4 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
> > @@ -9,6 +9,8 @@
> >   #include "sdm660.dtsi"
> >   #include "pm660.dtsi"
> >   #include "pm660l.dtsi"
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/input/gpio-keys.h>
> >
> >   / {
> >   	model = "Xiaomi Redmi Note 7";
> > @@ -33,6 +35,18 @@ vph_pwr: vph-pwr-regulator {
> >   		regulator-boot-on;
> >   	};
> >
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +		input-name = "gpio-keys";
> I don't think input-name is used anymore.

It seems you're correct, we have it in a number of dts files, but I
don't see it in the binding document or the Linux implementation.

I've applied the rest of the patches in the series for now.

Thanks,
Bjorn

> > +
> > +		volup {
> > +			label = "Volume Up";
> > +			gpios = <&pm660l_gpios 7 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_VOLUMEUP>;
> > +			debounce-interval = <15>;
> > +		};
> > +	};
> > +
> >   	reserved-memory {
> >   		#address-cells = <2>;
> >   		#size-cells = <2>;
> > --
> > 2.33.1
> >
> 
> --
> Kind Regards,
> Caleb
> 
