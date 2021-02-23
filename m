Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD31B322952
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 12:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhBWLNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhBWLNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:13:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F2C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 03:12:43 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id w19so15637386qki.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 03:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDJKyrOYFbZgyIbDoSlNOmxT0wOERdFNLnLjqv9XaI4=;
        b=AKvkQC2O5sPNCelEGUg7Weo2THVB644tAmz6ADl4Ek1PAhqTvjEnah72Av2XwaTppL
         MrfUGT6mqbmRXaz87K2P077IXvJvpX2wU+xVOEe5rzjqDqIChOqC4Aj0IEjdqLiu+fn/
         S/acrId2IUz2UEgyBB2C7xXHFEuV3GLGB64mF7ZxO24bIkcQmOIUqwB9Fk6uVv6Bgn1K
         Gy2I/5o8RW2ut6f1dqOjWjgTuYlc/ga0c5r51EK0VskySqe8uNXid2s0ez4FBXmPOfFu
         81IrfjsYopalLRN2VooNbaMA2Cwib3Qilg4NOpm7xAmj3GoFoulAfUbmyLcPisJavTvr
         6KDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDJKyrOYFbZgyIbDoSlNOmxT0wOERdFNLnLjqv9XaI4=;
        b=lbjuAfG3E1oJl7I9LkjELBbrei2OcFA3kDOia8HP4M6Pcrc305ZwVL+2p+wNlWQflI
         SD6OSWJ/YK8MCaH8TW2VUzIk7nBRlK1q2Z7evIjk0DgaISIpfli4JggNaTucpyKcQmSS
         9nkcVF3zRRkVC9fY+kcb4cxAAjf0tYVOyi0SdzX0bLSpwbdXhOb19k1aTrt15zZIRHYO
         ujscncn2TXybKtPkU1URfSCCeY6bIKi+E58qNBlJ009wsTLh9dK1owWZ+CRE22qsdhDD
         5rbs1vEjWTnSM/Ulw6s41ZAoT+PWqk158J3vlAL16PyNFgCXEAzcquthJeIKOu8IcZLk
         PHgw==
X-Gm-Message-State: AOAM5335aefUBgbALtYcKn+1CapRIWyAtoG6QmYKNWjOZ/K709fMcp/n
        gtVkxRrC4AMtzic9skOcJawvM9BHhXlsg1b34wW3dg==
X-Google-Smtp-Source: ABdhPJwMsjW0y3O9JlfLIqwKA4BBgSM8ln4wbd7X9YqkDboeTHfbzmGCVzqb30lCKEbEeFCX/sSysWzTgCh3cDFnPVM=
X-Received: by 2002:a37:b6c4:: with SMTP id g187mr15630174qkf.162.1614078762141;
 Tue, 23 Feb 2021 03:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20210219181032.1.I23e12818c4a841ba9c37c60b3ba8cfeeb048285f@changeid>
 <20210219181032.3.Ia4c1022191d09fe8c56a16486b77796b83ffcae4@changeid>
In-Reply-To: <20210219181032.3.Ia4c1022191d09fe8c56a16486b77796b83ffcae4@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 23 Feb 2021 14:12:30 +0300
Message-ID: <CAA8EJpoCBe_5khmWPGvr35zBWdcoSJ4OeY=6Nw1diTsNtv7EpA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc7180: Delete charger thermal zone
 and ADC channel for lazor <= rev3
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 20 Feb 2021 at 05:13, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Lazor rev3 and older are stuffed with a 47k NTC as thermistor for
> the charger temperature which currently isn't supported by the
> PM6150 ADC driver. Delete the charger thermal zone and ADC channel
> to avoid the use of bogus temperature values.

Should we just expand the adc/adc-tm drivers with additional calibration tables?

-- 
With best wishes
Dmitry
