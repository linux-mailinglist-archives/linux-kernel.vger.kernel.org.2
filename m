Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F4C32A16A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577282AbhCBF5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:57:52 -0500
Received: from mail-40137.protonmail.ch ([185.70.40.137]:62832 "EHLO
        mail-40137.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574962AbhCBDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:52:03 -0500
Date:   Tue, 02 Mar 2021 03:51:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1614657077;
        bh=6Lqc99WHAgZVxNlrSG4NdxKORMThqAvTsVgRaszZvUo=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=pow8k2LzpEfvSdv7fU6cmpTWqEofb0PWomerf42KjWf3J8T22fCLi8lmo4lWdxDAi
         ZycHNc0ron5tWGsZzdiVy1eK/8AydwarBaJ5NviNecVV5jpx/79a8A1PQ13toUDY6Z
         +8BZxztIVuYF7xqzg30eBqCxeV7axv0aWTngpjDE=
To:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH] arm64: dts: qcom: msm8996: Add usb3 interrupts
Message-ID: <dvfyYKA9vnJdunbQ1CL-dgjXtv_1wYpRnezdc3PHoCyrgmfi5KP0Dn4MtaumQEpHIQAHL9tTdqcaCK7YJWyrdWXCrPeGd4uMh-nFeu7xQYw=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hs_phy_irq and ss_phy_irq to usb3.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qc=
om/msm8996.dtsi
index 7eef07e73e25..b4b8d6305a05 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1754,6 +1754,10 @@ usb3: usb@6af8800 {
 =09=09=09#size-cells =3D <1>;
 =09=09=09ranges;

+=09=09=09interrupts =3D <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+=09=09=09=09     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+=09=09=09interrupt-names =3D "hs_phy_irq", "ss_phy_irq";
+
 =09=09=09clocks =3D <&gcc GCC_SYS_NOC_USB3_AXI_CLK>,
 =09=09=09=09<&gcc GCC_USB30_MASTER_CLK>,
 =09=09=09=09<&gcc GCC_AGGRE2_USB3_AXI_CLK>,
--
2.30.1

