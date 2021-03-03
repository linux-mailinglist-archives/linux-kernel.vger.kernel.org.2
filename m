Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C7332BCA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhCCOVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842953AbhCCKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:57 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6687C06178B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:21:28 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id e6so15793745pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=5sgzs+e2k+RgTtqJplWFR6KEm78SgZsm88oW5JzXnRk=;
        b=Gsh5aV+FHnmKZJ7JbbY6hJOLx1kU0QPS/64NpmYMgkKRUjfeKdK8rR7Tz03hZ4xIOe
         WIsEzbhGzKOUdvlB8rscszrMSYgPhidSFK6E3q6aAods6EOnKRn2BLFGsaFmiJWU2GDK
         +nRtEB8GzY9NirzzrljR/cWUXKjbduPs/18lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=5sgzs+e2k+RgTtqJplWFR6KEm78SgZsm88oW5JzXnRk=;
        b=msTNyX60DE1nqKGcCeUm0ksNb9/FGWhUZUesV90M6/mP/Ml1nDAd/pvGqkCAlRXqVJ
         bzD7PGvMroVJH50Ig5qDNAsP6FFePrM4Xm6ZhvSx6OjitEt9gs+/FlIGjQP0r97eSFx5
         yeE1htlkyVM1FSesX8HrB2GsG9C9VaIK0VwdjjvV2UVDKzpEq/ymoQ6ZEIXhWkZqjvce
         XYyWXph1s6HCITuRmYsg6ZzdM7HPru6R6LHOfFIoc/La2KYtY36ZPPs+SrS+H3QvmO2n
         RCUIxPIMCFJQScy9awxsCHzjiA06PM8EDTOk3OyqSiaYJzDkZmv9ldB/A7d0GxOCNvfZ
         fpLg==
X-Gm-Message-State: AOAM533KkCGhZOhC/FP9vG4ojw5tRkp3X3zBZkk0ONO6M6fXz83mHY2g
        lXJdpK6NdksnEeFUx/eDEeRPug==
X-Google-Smtp-Source: ABdhPJzjVSYkQQnQXjf65ZJvtnHkb8n8lOPDn88s8QzhuX1Q+AGEXMCx5CKjZ7KQJh3JojpQLon70Q==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr6809504pgj.16.1614759688410;
        Wed, 03 Mar 2021 00:21:28 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id q15sm6726694pje.28.2021.03.03.00.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:21:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f58070ee-ff00-f8c5-6459-782562e903e5@codeaurora.org>
References: <1613114930-1661-1-git-send-email-rnayak@codeaurora.org> <1613114930-1661-7-git-send-email-rnayak@codeaurora.org> <161406618557.1254594.15985584772106947706@swboyd.mtv.corp.google.com> <f58070ee-ff00-f8c5-6459-782562e903e5@codeaurora.org>
Subject: Re: [PATCH 06/13] arm64: dts: qcom: SC7280: Add rpmhcc clock controller node
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Date:   Wed, 03 Mar 2021 00:21:25 -0800
Message-ID: <161475968509.1478170.5248506718236838205@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2021-03-01 09:27:06)
> On 2/23/2021 1:13 PM, Stephen Boyd wrote:
> > Quoting Rajendra Nayak (2021-02-11 23:28:43)
> >> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dt=
s/qcom/sc7280.dtsi
> >> +               usb3_phy_wrapper_gcc_usb30_pipe_clk: usb3-phy-wrapper-=
gcc-usb30-pipe-clk {
> >> +                       compatible =3D "fixed-clock";
> >> +                       clock-frequency =3D <1000>;
> >> +                       #clock-cells =3D <0>;
> >> +               };
> >=20
> > Shouldn't these come from the phys? Why are they being added here?
> >=20
>=20
> Once the phys are added, these could be replaced, that was the reason to =

> add them.
>=20
> >>          };
> >>  =20
> >>          reserved_memory: reserved-memory {
> >> @@ -174,6 +211,17 @@
> >>                  gcc: clock-controller@100000 {
> >>                          compatible =3D "qcom,gcc-sc7280";
> >>                          reg =3D <0 0x00100000 0 0x1f0000>;
> >> +                       clocks =3D <&rpmhcc RPMH_CXO_CLK>,
> >> +                                <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk=
>,
> >> +                                <&pcie_0_pipe_clk>, <&pcie_1_pipe_clk=
>,
> >> +                                <&ufs_phy_rx_symbol_0_clk>, <&ufs_phy=
_rx_symbol_1_clk>,
> >> +                                <&ufs_phy_tx_symbol_0_clk>,
> >> +                                <&usb3_phy_wrapper_gcc_usb30_pipe_clk=
>;
> >=20
> > If the phys aren't ready then <0> should work. Unless something goes
> > wrong?
> >
>=20
> Nothing would go wrong if we add <0>, but wanted them to be replaced=20
> once the support is added.

Please use <0> to indicate that it's missing. Otherwise we may never
realize that we should connect it up later.
