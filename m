Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459CB3222A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhBVX0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhBVX0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:26:47 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB392C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:26:06 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id e15so10631934qte.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=la9ZqTZwDD/fbHYVkOWiL/ZTGoQj4SgcB++IQ81k71M=;
        b=FUztHfmx7VQcHhA2XN3r0/uBNhN4l0szMZEAOVqXPdfPSQoulotBk12hS+SQl3/ucZ
         2HJI0qAE3+YETwEcWJw/jEZa3W5IS5wKXmwkGso5kGtdL5hOz/Vf8nMT9zr40Sl1zyzo
         9JMlIiXnNMi33uHXuaCJPDwoR8KGCOr+UUeus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=la9ZqTZwDD/fbHYVkOWiL/ZTGoQj4SgcB++IQ81k71M=;
        b=tNL3zTfDWyJiEDEIrGZsu0Tv28Wq49MlnoeMhPPUgiJoEBNCFseG9X5FRMbA0peSty
         aauuiml0Jrs4dwFHh1jHkSffVrrmWVkh1PF75xYSN8VYDZ7VlLZ/XI1lSj4rApvzY+fl
         yonMsk5MhRHHv9s6FJ1sOV0Of9ZvSjrkoeVcfgf9M9S2CFxOLD7Yo94amlqdwSTQ/riG
         6tUECNd/xsFfHpBaDkMZZNWi4raFj5ILzIsOvr3teOe39XhZMoT+nN/V7UamPFqAmwW0
         L8KDtajA3zhW+R5pxCl5DeaZSHo59s+tMcD/th7HXtkxA/1yJAthsrUgQ1yn/1s4+ogO
         Mwfw==
X-Gm-Message-State: AOAM530l3THXr18MIeSo/Lh9kJoWvIhJQ4imogkPZ5woKrzrM9Nhgbr8
        D5vhJPqR0j6Tu+LzoqDphabiw8zIp+nxFw==
X-Google-Smtp-Source: ABdhPJx8EJ/KG3kUJwLyP0DOOCaUzF6XQXjQPvyVwViCfeTuUbNpJr4ZiXqdPlr9IjgBBO/iaIfu5w==
X-Received: by 2002:ac8:5a02:: with SMTP id n2mr22012495qta.295.1614036365912;
        Mon, 22 Feb 2021 15:26:05 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id q8sm13480952qkm.38.2021.02.22.15.26.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 15:26:05 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id d9so5744577ybq.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:26:05 -0800 (PST)
X-Received: by 2002:a25:4e83:: with SMTP id c125mr6137757ybb.343.1614036365019;
 Mon, 22 Feb 2021 15:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20210219181032.1.I23e12818c4a841ba9c37c60b3ba8cfeeb048285f@changeid>
 <20210219181032.3.Ia4c1022191d09fe8c56a16486b77796b83ffcae4@changeid>
 <161402520418.1254594.7435679604383921403@swboyd.mtv.corp.google.com>
 <YDQWVresOGZGLL6N@google.com> <161402672369.1254594.14091287979440332862@swboyd.mtv.corp.google.com>
In-Reply-To: <161402672369.1254594.14091287979440332862@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Feb 2021 15:25:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WdpEozoQjDo3s1+mrLD0tSk8DQsEAg3yw099nn=SoX3g@mail.gmail.com>
Message-ID: <CAD=FV=WdpEozoQjDo3s1+mrLD0tSk8DQsEAg3yw099nn=SoX3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc7180: Delete charger thermal zone
 and ADC channel for lazor <= rev3
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 22, 2021 at 12:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Matthias Kaehlcke (2021-02-22 12:38:46)
> > On Mon, Feb 22, 2021 at 12:20:04PM -0800, Stephen Boyd wrote:
> > > Quoting Matthias Kaehlcke (2021-02-19 18:10:59)
> > > > Lazor rev3 and older are stuffed with a 47k NTC as thermistor for
> > > > the charger temperature which currently isn't supported by the
> > > > PM6150 ADC driver. Delete the charger thermal zone and ADC channel
> > > > to avoid the use of bogus temperature values.
> > > >
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > >
> > > >  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 9 +++++++++
> > > >  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts | 9 +++++++++
> > > >  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts | 9 +++++++++
> > > >  3 files changed, 27 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
> > > > index 30e3e769d2b4..0974dbd424e1 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
> > > > @@ -14,6 +14,15 @@ / {
> > > >         compatible = "google,lazor-rev0", "qcom,sc7180";
> > > >  };
> > > >
> > > > +/*
> > > > + * rev <= 3 are stuffed with a 47k NTC as charger thermistor which is currently
> > > > + * not supported by the PM6150 ADC driver. Delete the thermal zone and ADC
> > > > + * channel to avoid the use of bogus temperature values.
> > > > + */
> > > > +/delete-node/ &charger_thermal;
> > > > +/delete-node/ &pm6150_adc_charger_thm;
> > > > +/delete-node/ &pm6150_adc_tm_charger_thm;
> > >
> > > Can we disable pm6150_adc_tm instead on <= rev3 boards? It would be the
> > > same number of lines, but is simpler to reason about disabled nodes vs.
> > > deleted nodes usually.
> >
> > For Lazor theoretically this could be done since it doesn't use other ADC
> > channels, however it won't work for other trogdor devices that will be
> > upstreamed eventually. Some of these boards have the same problem, however
> > they have other thermistors connected to the ADC. One could argue that it's
> > preferable to do things in a uniform way, but I'm open to do it either way
> > for Lazor.
> >
>
> I see. Can the thermal-zone be disabled then vs. deleting three nodes? I
> think the thermal driver uses for_each_available_child_of_node() so that
> would work?

FWIW: +1 to what Stephen suggests assuming it works.

-Doug
