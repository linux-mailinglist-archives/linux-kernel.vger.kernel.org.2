Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BA137FF3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 22:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhEMUfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 16:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhEMUfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 16:35:11 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:150:448b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BCCC061574;
        Thu, 13 May 2021 13:34:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 06506222534;
        Thu, 13 May 2021 22:33:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LLacQCTOWs7v; Thu, 13 May 2021 22:33:56 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 0/2] ARM: dts: sun8i: v3s: add pwm controller to v3s dts
Date:   Thu, 13 May 2021 22:35:25 +0200
Message-Id: <20210513203527.2072090-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the pwm controller to the Allwinner V3s dts. The PWM
controller is compatible with the one found in the Allwinner A20.

This is v2 of this patchset.

Cheers,
Tobias

Changelog:
 - v2: add compatible for pwm controller of the V3s SoC

Tobias Schramm (2):
  dt-bindings: pwm: allwinner: add v3s pwm compatible
  ARM: dts: sun8i: v3s: add pwm controller to v3s dts

 .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 3 +++
 arch/arm/boot/dts/sun8i-v3s.dtsi                         | 9 +++++++++
 2 files changed, 12 insertions(+)

-- 
2.31.1

