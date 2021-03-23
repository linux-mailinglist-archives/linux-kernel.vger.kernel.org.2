Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FA2346BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhCWWHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbhCWWGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:06:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44858C061764
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:06:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so141937pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=8BWo86i33iioKOqmV9jmlpLM238hwKZcbsQlqWFESLQ=;
        b=SRyH0LMOFeDhLTkyt07Fac/cikXZSsPnUOK51gyyB8ilGHXP+rPOfv/H9+0peOLovh
         WipjBkkj4EfAAhS9/jOZIBlsDKjACD5o51gIU94JtLJEleoZs7l6ABj4/yYJg5mjk4pw
         A2t2eRw8dh3Zwys/TZPEd8ix5v9gu2xzEoqog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=8BWo86i33iioKOqmV9jmlpLM238hwKZcbsQlqWFESLQ=;
        b=Bwrp+B0aWnE42vtXigPNyclLY3NWXfVKbzDclu9mbuoHFCArwrK3K/JlU3sVf/R6qC
         83KOWU1yF7zOEDD9tYaCXfinu2y6L2TMWKV9XaUIDnsLkpuJYoZyTNmSC7H3aGKO1JlM
         O+3sEto8sv4dSM4yytUr7+goDcl6yjfjh6gb5stbd6gWdVpC33P1AYAdwIP00vTd1h40
         aoxvTotEuYRrQ0rP1QtwPpAPtPw2hN9Y9m0pZ+f3TJJhhLfN4xNainRmj/Au+NDn81Oo
         a/nT6Nr0SzI9wAlRtDeAg+WaEMcKHXEx7ZG/gKTTh5arAbf4g6D+g7M74WS/pRXpH4TN
         rsaA==
X-Gm-Message-State: AOAM530vkfIsaO+Goq16EfZhSSsWzBNn8M3+j531RW20jD3A8ohdqizT
        z0WSGiqj7H1ksJfm3N7cqyxhEKkSLoHuMw==
X-Google-Smtp-Source: ABdhPJx3BSKJkGqKncxsCX7h4oQjQSZMLIt2kP+1EHD/sHhFBU6e9vx8boqNaD/PvJjEUtCfSV2mXQ==
X-Received: by 2002:a17:90a:9e7:: with SMTP id 94mr193837pjo.117.1616537195704;
        Tue, 23 Mar 2021 15:06:35 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id v135sm161428pgb.82.2021.03.23.15.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:06:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YE2OJz1pI81Uj8DA@builder.lan>
References: <1615269111-25559-1-git-send-email-sibis@codeaurora.org> <1615269111-25559-7-git-send-email-sibis@codeaurora.org> <161567197220.1478170.12600358804299446135@swboyd.mtv.corp.google.com> <YE2OJz1pI81Uj8DA@builder.lan>
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sc7280: Add nodes to boot WPSS
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, agross@kernel.org, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Tue, 23 Mar 2021 15:06:33 -0700
Message-ID: <161653719350.3012082.12055201782488576903@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-03-13 20:16:39)
> On Sat 13 Mar 15:46 CST 2021, Stephen Boyd wrote:
>=20
> > Quoting Sibi Sankar (2021-03-08 21:51:51)
> > > Add miscellaneous nodes to boot the Wireless Processor Subsystem on
> >=20
> > Maybe add (WPSS) after the name so we know they're related.
> >=20
> > > SC7280 SoCs.
> > >=20
> > > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > > ---
> > >=20
> > > https://patchwork.kernel.org/project/linux-arm-msm/list/?series=3D438=
217
> > > Depends on ipcc dt node enablement from ^^=20
> > >=20
> > >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 143 +++++++++++++++++++++++++=
++++++++++
> > >  1 file changed, 143 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/d=
ts/qcom/sc7280.dtsi
> > > index 18637c369c1d..4f03c468df51 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > @@ -244,12 +251,131 @@
> > >                 reg =3D <0 0x80000000 0 0>;
> > >         };
> > > =20
> > > +       tcsr_mutex: hwlock {
> > > +               compatible =3D "qcom,tcsr-mutex";
> > > +               syscon =3D <&tcsr_mutex_regs 0 0x1000>;
> > > +               #hwlock-cells =3D <1>;
> > > +       };
> >=20
> > Is this node in the right place? I think the node above it is 'memory'?
> > In which case 'hwlock' comes before 'memory' alphabetically.
> >=20
>=20
> Thanks for spotting this, as it's no longer acceptable to have a
> standalone "syscon" node I was asked to rewrite the binding for this a
> few months ago. So the tcsr_mutex should now be represented with a reg
> under /soc.

Oh nice, I wasn't aware.

> > > +                       #interrupt-cells =3D <2>;
> > > +               };
> > > +       };
> > > +
> > > +       smp2p-mpss {
> > > +               compatible =3D "qcom,smp2p";
> > > +               qcom,smem =3D <435>, <428>;
> > > +               interrupts-extended =3D <&ipcc IPCC_CLIENT_MPSS
> > > +                                            IPCC_MPROC_SIGNAL_SMP2P
> > > +                                            IRQ_TYPE_EDGE_RISING>;
> > > +               mboxes =3D <&ipcc IPCC_CLIENT_MPSS
> > > +                               IPCC_MPROC_SIGNAL_SMP2P>;
> > > +
> > > +               qcom,local-pid =3D <0>;
> > > +               qcom,remote-pid =3D <1>;
> > > +
> > > +               modem_smp2p_out: master-kernel {
> > > +                       qcom,entry-name =3D "master-kernel";
> > > +                       #qcom,smem-state-cells =3D <1>;
> > > +               };
> > > +
> > > +               modem_smp2p_in: slave-kernel {
> > > +                       qcom,entry-name =3D "slave-kernel";
> >=20
> > Do these names need to have 'master' and 'slave' in them? We're trying
> > to avoid these terms. See Documentation/process/coding-style.rst Section
> > 4 naming.
> >=20
>=20
> They need to match the naming in the firmware, but I would welcome a
> future change to something in line with the coding style and simply more
> descriptive.
>=20

Sibi can this be done? I think it's still pretty early days for the
firmware so hopefully the terms can be replaced with something
different.
