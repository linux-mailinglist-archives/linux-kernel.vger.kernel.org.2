Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B9542740C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 01:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243754AbhJHXPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 19:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJHXPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 19:15:03 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3455BC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 16:13:08 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w11so8252847ilv.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 16:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAOBnpVSV4rGwJ/ei4hpXfaObGH3N5JtD18S+Uya9JA=;
        b=Vnm1IBY+xw/KY4WQKv3bJvQjQ8AY58QLqmTLq9E0R1DPWm9MMTmO9F4bfq4KkRlfhP
         zYRCo1q16cNumthc35KoplL5rFEBWL+m5tgWL6XOkAaHBLd2FgGyT1Po07dUVhaAVugp
         RiGNKvHfujiNfK+HLiT9FCHVW66AVPefEMvXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAOBnpVSV4rGwJ/ei4hpXfaObGH3N5JtD18S+Uya9JA=;
        b=Nn49hFAChb1uzj6aQbc2NMGqNUA4ELLfIKp8S1e47xL6oYI5wNBAvUE4seIanVFguL
         LqH2RNEp2gjRCQ0TKCYViU7LWWH9mGhnvii/MTxPzHn2n5vTHE8vZfxhO/STDa/Z+t6S
         Hg/9UVl5ppGHebzD/M4AYowmMl3FVVCDc1that1HnhLD7aNMs4jXRC3w3ockJDEAx72i
         X4ctfHPC/UgExeoeMaQFuRfmrM7fyxqeTBuoKwKCgCRdhvfVlvLp2TeUnHFXzTODVfO4
         OcZpvypOEEPF5xJKvZ4q2MMkDavZp9NrUuO4zw49WoeqmeAYdw5fCHROmP+5xFeaC2WS
         F7rw==
X-Gm-Message-State: AOAM533LVxR9Rod1xxPmWt3JtmGMco2/soZS/1I9nImor00CEhopi5kk
        M4hS/RgzeDYtJZwEPjCVos4SmmvRv9Zohw==
X-Google-Smtp-Source: ABdhPJzE2GefZg4SylJrfmvcIGQeYvu0zaDzYIuNkz8I81pfeROLngdc/URRh+EyUpsF2nf4judr1Q==
X-Received: by 2002:a05:6e02:20e8:: with SMTP id q8mr10822312ilv.0.1633734787426;
        Fri, 08 Oct 2021 16:13:07 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id l3sm285823ilg.54.2021.10.08.16.13.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 16:13:06 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id w10so11474664ilc.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 16:13:06 -0700 (PDT)
X-Received: by 2002:a05:6e02:1989:: with SMTP id g9mr9971839ilf.165.1633734786303;
 Fri, 08 Oct 2021 16:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210929173343.v2.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
 <20210929173343.v2.3.I630340a51130f4582dbe14e42f673b74e0531a2b@changeid>
 <CAE-0n53EBvKv-RdMwiiOsUkb+LOKAKwrpP7cDavx4meA2vbvcA@mail.gmail.com>
 <CAD=FV=XoOhSNP2EXurkA=G9iG2BnH9VzkvSEiNJ8W71s8N9bgg@mail.gmail.com>
 <CA+cxXhkM9Gzc+0EVapZVu=pJZ3WZawgucG5J2=bokYEJXFNKCQ@mail.gmail.com> <CA+cxXh=1D08O6EcC4Xq6+cCEthCtXfASOfGW38z=FhkmW3ce9g@mail.gmail.com>
In-Reply-To: <CA+cxXh=1D08O6EcC4Xq6+cCEthCtXfASOfGW38z=FhkmW3ce9g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 8 Oct 2021 16:12:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VfuxrrFbzZwCQr-6KYb2OXEPmrAH5y9UPr4V6Pud2h7g@mail.gmail.com>
Message-ID: <CAD=FV=VfuxrrFbzZwCQr-6KYb2OXEPmrAH5y9UPr4V6Pud2h7g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: sc7180: Support Parade ps8640 edp bridge
To:     Philip Chen <philipchen@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 8, 2021 at 11:46 AM Philip Chen <philipchen@chromium.org> wrote:
>
> Hi
>
> On Thu, Oct 7, 2021 at 11:15 AM Philip Chen <philipchen@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Sep 30, 2021 at 9:22 AM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Sep 29, 2021 at 9:02 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > > +       pp3300_brij_ps8640: pp3300-brij-ps8640 {
> > > > > +               compatible = "regulator-fixed";
> > > > > +               status = "okay";
> > > > > +               regulator-name = "pp3300_brij_ps8640";
> > > > > +
> > > > > +               regulator-min-microvolt = <3300000>;
> > > > > +               regulator-max-microvolt = <3300000>;
> > > > > +
> > > > > +               gpio = <&tlmm 32 GPIO_ACTIVE_HIGH>;
> > > >
> > > > Doesn't this need
> > > >
> > > >                 enable-active-high;
> > >
> > > Looks like it. Without that it looks like it assumes active low.
> > Thanks for catching this.
> > I'll fix it in v3.
> >
> > >
> > >
> > > > > +
> > > > > +               pinctrl-names = "default";
> > > > > +               pinctrl-0 = <&en_pp3300_edp_brij_ps8640>;
> > > > > +
> > > > > +               vin-supply = <&pp3300_a>;
> > > > > +       };
> > > > > +};
> > > > > +
> > > > > +&dsi0_out {
> > > > > +       remote-endpoint = <&ps8640_in>;
> > > >
> > > > Should this also have data-lanes to be "complete"?
> > >
> > > That's still back in the main trogdor.dtsi, isn't it?
> > Yes, I think so.
> > Plus, ti-sn65 dts doesn't define data-lanes for input either.
> Sorry, I was wrong.
> ti-sn65 dts actually defines data-lanes for input.
> However, since ps8640 driver doesn't parse input data-lanes for now,
> it's not useful to add data-lanes here anyway.

Ah, right. This one _isn't_ in the dtsi. Looking closer, I agree with
you that it's not useful. Specifically it should be noted that, unlike
ti-sn65dsi86, this bridge part looks to only support 2-lanes of DP
traffic. If both of these two lanes are routed to the panel then
there's really nothing to specify--that should be the default
assumption of the driver if/when it ever adds support for data-lanes.

-Doug
