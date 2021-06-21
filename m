Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303113AF92D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 01:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhFUXVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 19:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232064AbhFUXV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 19:21:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D8756128E;
        Mon, 21 Jun 2021 23:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624317553;
        bh=EYSEiTRNCJeziu2InDx+K6VGSnjU1txVEGEaZ6iYlE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EALJRLLpGbQ0ysosvYNsYGhLN94XGwgW99Tyxah/VjbhGto+G8K0xtHfJo85MpjI9
         paLLIdrZ0Sx6/WI5qL0xasZuhUblrr5+xrTeRO4EBTmZF0Uiyn9xFCreS5y4KbfLZz
         Ebx3uYHhMxvYRodwqRDRIOYwVTmgZPDuQunGJVyLNwYrPBUYTBjRtjUtL5hcKMUB/k
         9QIeAhMk64hSJdVlS9+TiEKlQ+n0qG8vb5jt5MFpqPluO02UbkXswBavQ44x+U2NQ+
         iMqfjlTD0BG/VkFAU/nnqm1xY+wFb1R1fnEs8wmVVpYvd/EuckxisM3U8D/fMc8Ec6
         mStAmAlNR/YQg==
Received: by mail-ed1-f53.google.com with SMTP id df12so18712555edb.2;
        Mon, 21 Jun 2021 16:19:13 -0700 (PDT)
X-Gm-Message-State: AOAM530psCsXxZaCHMB0tmOlI0BO9CL2muXpWmWFrRAR7wWz1Ck2U5MM
        0hEnlLAZQZQ3turdgEHfdRxN+Fb/SecNrMfkqQ==
X-Google-Smtp-Source: ABdhPJykf9Ft5YqcKGjPM3wPlxn/4+rWt3HORmIC4fctiHfo0+mQC67N4pJ5C+6RaNYUOWIPmgDOnSsLJVPawxHLBgk=
X-Received: by 2002:aa7:ccca:: with SMTP id y10mr1021381edt.258.1624317551768;
 Mon, 21 Jun 2021 16:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210612094631.89980-1-martin.botka@somainline.org>
 <20210612094631.89980-3-martin.botka@somainline.org> <CABb+yY3BYYC2na8EFunEeu0XCfLXrUQon=hF3q5p=+FUoigoyw@mail.gmail.com>
 <CAL_JsqLWqtAtqLRF-MAnq80NMfD0a+CfWPv8JWjjNTJFgMjCxg@mail.gmail.com> <CABb+yY0sdSinTm788pMFrqEZ6QMC2OwCP7Kkto+pG9h1aGMzwQ@mail.gmail.com>
In-Reply-To: <CABb+yY0sdSinTm788pMFrqEZ6QMC2OwCP7Kkto+pG9h1aGMzwQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Jun 2021 17:19:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKdoMwpL_tYC7VQRAG2AC5nR4diShMQCgDseObcgU+egQ@mail.gmail.com>
Message-ID: <CAL_JsqKdoMwpL_tYC7VQRAG2AC5nR4diShMQCgDseObcgU+egQ@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] mailbox: qcom-apcs: Add SM6125 compatible
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        jamipkettunen@somainline.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 5:10 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> On Mon, Jun 21, 2021 at 2:46 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Sun, Jun 20, 2021 at 10:03 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> > >
> > > On Sat, Jun 12, 2021 at 4:46 AM Martin Botka
> > > <martin.botka@somainline.org> wrote:
> > > >
> > > > This commit adds compatible for the SM6125 SoC
> > > >
> > > > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > > > ---
> > > > Changes in V2:
> > > > None
> > > > Changes in V3:
> > > > Change compatible to apcs-hmss-global
> > > >  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> > > > index f25324d03842..f24c5ad8d658 100644
> > > > --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> > > > +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> > > > @@ -57,6 +57,10 @@ static const struct qcom_apcs_ipc_data sdm660_apcs_data = {
> > > >         .offset = 8, .clk_name = NULL
> > > >  };
> > > >
> > > > +static const struct qcom_apcs_ipc_data sm6125_apcs_data = {
> > > > +       .offset = 8, .clk_name = NULL
> > > > +};
> > > > +
> > > >  static const struct qcom_apcs_ipc_data apps_shared_apcs_data = {
> > > >         .offset = 12, .clk_name = NULL
> > > >  };
> > > > @@ -166,6 +170,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
> > > >         { .compatible = "qcom,sc8180x-apss-shared", .data = &apps_shared_apcs_data },
> > > >         { .compatible = "qcom,sdm660-apcs-hmss-global", .data = &sdm660_apcs_data },
> > > >         { .compatible = "qcom,sdm845-apss-shared", .data = &apps_shared_apcs_data },
> > > > +       { .compatible = "qcom,sm6125-apcs-hmss-global", .data = &sm6125_apcs_data },
> > > >         { .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
> > > >         { .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
> > > >         {}
> > > >
> > > These all are basically different names for the same controller.
> > > The 'offset' is a configuration parameter and the 'clock', when NULL,
> > > is basically some "always-on" clock.
> > > I am sure we wouldn't be doing it, if the controller was third-party.
> >
> > If newer implementations are 'the same', then they should have a
> > fallback compatible to the existing one that is the same and no driver
> > change is needed. If the differences are board or instance (within an
> > SoC) specific, then a DT property would be appropriate.
> >
> The controllers (13 now) only differ by the 'offset' where the
> registers are mapped. Clock-name is a pure s/w artifact.
> So, maybe we could push all these in DT.

Why is 'reg' not used for the offset?

In any case, we can't really get rid of the first 13 instances though...

Rob
