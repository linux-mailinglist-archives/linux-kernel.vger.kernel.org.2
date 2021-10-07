Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0B425A7F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbhJGSRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbhJGSRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:17:47 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E449C061760
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 11:15:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id d131so15396112ybd.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxNCZni7OLjbLUM2oQ+zPYdyzTwxKlKSIw1gMRbxwKc=;
        b=HaA4A6Ta2mUHIBcxZL2CKjoRtG9GcR6ieEqiqwqdPenP1IGuK5WthHbwO3ou61Tnh9
         IdZm+AhwWUzQTSCgHbQKPmWzZQYr/mbmKac8PrBY5Lc/RuCrMSXsaua/89j3JLwStEy/
         xgH8m+0bsbtYNUN/XhdgaDjnNxH9xWtwMWdzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxNCZni7OLjbLUM2oQ+zPYdyzTwxKlKSIw1gMRbxwKc=;
        b=uLZQDBcMIhoDI4qaKu0XQY9oUOVRWL3z84bgob+ELzQV3PWYPYFr9KOcK/PCmMYgI+
         ZfPGWkeUMI3g+pM3tZjQZZVq/WlI33Talug5oGfOKBVxx8VkRbtBf6285gshEya5hWqL
         OYKUm8s1rZZFieAcnuWMOxrbAhfAb2e/V4Pcdxbx0Tb7bIUjoNvJfPKBd+PTDspTPaNo
         LH1kOiIJbwYkxFhtWOoQaM3fDNzg5F2NcZidgPTDAcw+26zzUF6chAf3z4wNMiW6/Pvj
         OINdVoXxI2SVNqdPhffWgUqZhATvPqPyoPEgFutNqmsGtG6GmzNPUCP0NG5IQqsrqkya
         PFfQ==
X-Gm-Message-State: AOAM5335gdQE3ceRI6tcmY9YduYmu/U4+Xfkt6nty3hIqJypeRubyC3P
        SJEbLv2T2u07a9QA1ssKP/I+eVTaXlrrDITINEwJTclhBjErvw==
X-Google-Smtp-Source: ABdhPJxonSF0ODbOA/KcRix4iq6ySNPKYDrYvWJYF++/VLTpja7FfdjmRMXdslLNYtDIGSEpvodrSddisABnGwahNNI=
X-Received: by 2002:a25:54c5:: with SMTP id i188mr6584598ybb.43.1633630552920;
 Thu, 07 Oct 2021 11:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210929173343.v2.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
 <20210929173343.v2.3.I630340a51130f4582dbe14e42f673b74e0531a2b@changeid>
 <CAE-0n53EBvKv-RdMwiiOsUkb+LOKAKwrpP7cDavx4meA2vbvcA@mail.gmail.com> <CAD=FV=XoOhSNP2EXurkA=G9iG2BnH9VzkvSEiNJ8W71s8N9bgg@mail.gmail.com>
In-Reply-To: <CAD=FV=XoOhSNP2EXurkA=G9iG2BnH9VzkvSEiNJ8W71s8N9bgg@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Thu, 7 Oct 2021 11:15:42 -0700
Message-ID: <CA+cxXhkM9Gzc+0EVapZVu=pJZ3WZawgucG5J2=bokYEJXFNKCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: sc7180: Support Parade ps8640 edp bridge
To:     Doug Anderson <dianders@chromium.org>
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

On Thu, Sep 30, 2021 at 9:22 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Sep 29, 2021 at 9:02 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > > +       pp3300_brij_ps8640: pp3300-brij-ps8640 {
> > > +               compatible = "regulator-fixed";
> > > +               status = "okay";
> > > +               regulator-name = "pp3300_brij_ps8640";
> > > +
> > > +               regulator-min-microvolt = <3300000>;
> > > +               regulator-max-microvolt = <3300000>;
> > > +
> > > +               gpio = <&tlmm 32 GPIO_ACTIVE_HIGH>;
> >
> > Doesn't this need
> >
> >                 enable-active-high;
>
> Looks like it. Without that it looks like it assumes active low.
Thanks for catching this.
I'll fix it in v3.

>
>
> > > +
> > > +               pinctrl-names = "default";
> > > +               pinctrl-0 = <&en_pp3300_edp_brij_ps8640>;
> > > +
> > > +               vin-supply = <&pp3300_a>;
> > > +       };
> > > +};
> > > +
> > > +&dsi0_out {
> > > +       remote-endpoint = <&ps8640_in>;
> >
> > Should this also have data-lanes to be "complete"?
>
> That's still back in the main trogdor.dtsi, isn't it?
Yes, I think so.
Plus, ti-sn65 dts doesn't define data-lanes for input either.

>
>
> > > +edp_brij_i2c: &i2c2 {
> > > +       status = "okay";
> > > +       clock-frequency = <400000>;
> > > +
> > > +       ps8640_bridge: edp-bridge@8 {
> >
> > Just bridge@8 to match ti bridge? Also, is the label used? If not
> > please drop it.
>
> I agree with Stephen about it being "bridge@8". Personally I don't
> mind labels like this even if they're not used since they don't hurt
> and it creates less churn to add them now, but I won't fight hard to
> keep them.
I will make it "bridge@8" to match ti-sn65 dts.
Meanwhile, can we keep "ps8640_bridge" label to match ti-sn65 dts?

>
>
> > > +               aux_bus: aux-bus {
> >
> > Is this label used either?
>
> Yeah, I'd get rid of this one since there you didn't add it in the
> sn65dsi86 dtsi file and it seems exceedingly unlikely we'd need it for
> any reason.
Sure, I will remove "aux_bus" label in v3.

>
> -Doug
