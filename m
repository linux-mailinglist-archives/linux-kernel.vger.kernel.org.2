Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3A1395085
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 12:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhE3K5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 06:57:35 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:46794 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhE3K5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 06:57:34 -0400
Date:   Sun, 30 May 2021 10:55:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1622372154;
        bh=6jm+6wTigi9ldKgrzP69sM9k3h3qwi0SM/gGptN1yXQ=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Ttvy3DRcXk5WuLcar8xdavKs8oekI0mhTqfqYItRHLIZH+PBpE+GZJZVyMrCo9T40
         TsgFGHP+d4hF2697Nnr7OmIanTPWWGnVFnKpauV/hayidoDEtyxwJbS4pMWWXtxDPF
         nqiCzEdthmSCh0EujtoabMpyQ7wsiBvksABsBHtI=
To:     Krzysztof Kozlowski <krzk@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH] ARM: dts: exynos: Disable unused camera input for I9100
Message-ID: <20210530105535.4165-1-timon.baetz@protonmail.com>
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

As the back camera is not implemented disable the second pair of fimc
child nodes as they are not functional. This prevents creating the
associated /dev/videoX devices.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exy=
nos4210-i9100.dts
index dec223bbf4eb..4a669abf4842 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -296,7 +296,8 @@ &fimc_0 {
 };

 &fimc_1 {
-=09status =3D "okay";
+=09/* Back camera not implemented */
+=09status =3D "disabled";

 =09assigned-clocks =3D <&clock CLK_MOUT_FIMC1>, <&clock CLK_SCLK_FIMC1>;
 =09assigned-clock-parents =3D <&clock CLK_SCLK_MPLL>;
@@ -312,7 +313,8 @@ &fimc_2 {
 };

 &fimc_3 {
-=09status =3D "okay";
+=09/* Back camera not implemented */
+=09status =3D "disabled";

 =09assigned-clocks =3D <&clock CLK_MOUT_FIMC3>, <&clock CLK_SCLK_FIMC3>;
 =09assigned-clock-parents =3D <&clock CLK_SCLK_MPLL>;
--
2.25.1


