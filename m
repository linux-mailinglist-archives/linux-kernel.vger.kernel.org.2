Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7A3242AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhBXQ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhBXQzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:55:18 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E1EC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:54:35 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id a4so1806659pgc.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mmfyPvStXtF7u0Xac1+SfPR3u7qpBmzf5YppFvZBp6k=;
        b=jINqzVOtmNNzWHggNZ5Bcv10X2UhcxYKwtp7nqEj2Xqu/T7lRFz85XuEcxyL741K0V
         0hbsSgsY6SKIxcHqzYcGQEb8fxhuLqGEZSkCOmwlzXtzaFiOhlx70adyqo7FYUwELk6r
         Yfo3Qt/Lgc+pQ33eDKD8fjZfsG6rPB/wkaIUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmfyPvStXtF7u0Xac1+SfPR3u7qpBmzf5YppFvZBp6k=;
        b=l9b+5mLuvBekaR06Q/mFW4w4UMSHs8F/dYoi4popGx31HeOh0ySrkmjcse//eWvDTW
         w9dBXgBY3FK5/WYM0gLcCv3AW1j/x/gaPcxDpmL6fxUy5XvNai9bPB5/tNMVUGPcZVMm
         KYxtdO5mdqGEtuwpnXEq+tXZOtil6x6CM26p3GRzq4RFbzsJchy4YxKHbrpKA7mAitfG
         EeJ8UeIHzk4kFiVPSco2wzcASc1S2lUhqZHuCRvu0b0npaVj9deblBZaHmaDKVFsmw4s
         ucBYX5NT/GG0vg6il53iLR/a5OGQtGZDHZht1slcrjZlgyCQB6L7rUIIWnbVAfsjMCJb
         3LZg==
X-Gm-Message-State: AOAM532mpQtZ6pFphOtCUBXrky7rKZuHp+fH6YZBxq6RVKU9VUXKqZXx
        xIZOAriIrbTr8XUECzweUeqxIA==
X-Google-Smtp-Source: ABdhPJyaV2heBCie+AEicWXVBCE1Unoh7KiztvFLYltPpJsjq0Q7+hHKPCZdRigJeDE/wxKC/GYfow==
X-Received: by 2002:a65:4508:: with SMTP id n8mr26645153pgq.294.1614185674794;
        Wed, 24 Feb 2021 08:54:34 -0800 (PST)
Received: from localhost ([2620:15c:202:1:9f5:1448:883f:b01])
        by smtp.gmail.com with UTF8SMTPSA id v3sm3199593pff.217.2021.02.24.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 08:54:34 -0800 (PST)
Date:   Wed, 24 Feb 2021 08:54:32 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc7180: Delete charger thermal
 zone and ADC channel for lazor <= rev3
Message-ID: <YDaEyASeJdgs3hS9@google.com>
References: <20210219181032.1.I23e12818c4a841ba9c37c60b3ba8cfeeb048285f@changeid>
 <20210219181032.3.Ia4c1022191d09fe8c56a16486b77796b83ffcae4@changeid>
 <CAA8EJpoCBe_5khmWPGvr35zBWdcoSJ4OeY=6Nw1diTsNtv7EpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA8EJpoCBe_5khmWPGvr35zBWdcoSJ4OeY=6Nw1diTsNtv7EpA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 02:12:30PM +0300, Dmitry Baryshkov wrote:
> Hi,
> 
> On Sat, 20 Feb 2021 at 05:13, Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Lazor rev3 and older are stuffed with a 47k NTC as thermistor for
> > the charger temperature which currently isn't supported by the
> > PM6150 ADC driver. Delete the charger thermal zone and ADC channel
> > to avoid the use of bogus temperature values.
> 
> Should we just expand the adc/adc-tm drivers with additional calibration tables?

Generally that seems desirable, I'm not sure about the process, I guess
someone with access to a climate chamber would have to create these tables?

I think it would also require an extension of the DT bindings, currently
the ADC driver assumes that a 100k NTC is connected, something in the DT
would have to indicate the thermistor type.

We want to remove the bogus temperatures from the system now, if support for
47k NTCs is added at some point we can consider changing the DT again.
