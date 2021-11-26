Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9630A45EEDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbhKZNNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbhKZNLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:11:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA684C06139E;
        Fri, 26 Nov 2021 04:27:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a18so18293613wrn.6;
        Fri, 26 Nov 2021 04:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WveCJzDdl0l4mujHAZT0CFJQL1dFWMtBRgbLVlZUP+I=;
        b=IzyJSpDdodNAlKNmlR90BQJ5l4tpvEZ0kwc43qEk93WVIkE+efu5gBF+jsRPDOClqf
         U2xBWJN13j3yAUqeTXy38pv8zF0hlifdBpo53iFycnZ9Xm54T1j/X3jjSAfGbXH8YWof
         D/qrMQxUnIsSLbBF6XhjsnkshP0b5DpZ23bJC6+2jRQLgvDKuTrmOy9zVwRcXRqDzSzl
         i7TbAPwcgxlf4XkbH/R6q/RQfCeNVudCW0GNYjhoeuuo62k+9+r4WqbuskJ+c0+Ob4SF
         DmSzWyoFI37FDqnTT0yjIX3FcyFrV57nIXb6c1vb4lkqttde4LnxzkrxOaiM17SPD+3Q
         K0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WveCJzDdl0l4mujHAZT0CFJQL1dFWMtBRgbLVlZUP+I=;
        b=0/mdbVxpEVQhJrufl74CXMQF4uTo5nkvQjaiu2TasOt8LdLbGeDBLxShcyL7296xbN
         5YH6sljsnz/a+wJqVUJnDqmsGb98jSo9QYpFEmsQYUTRXf7WoODKMBShlIIXMFkwmWym
         BYxw+zddGfWvTkIO/9DdqFr0Jz0dMPcws68kW3GAx3webXRGuyhGBwqjRp0SbAukO0JQ
         7OrNarwEcbwL8wjf7OM6vK3yyPjWTkOXrl8pyHLfFLkdhbNG4wXt1mW/r3TD5PElPS7a
         Y8bO7tUO9ealGJ2CDgxPRRx7HrqLhP4csEe8xvylFpB7oClSwgYxIR4ztOfc89o+up2u
         yMfA==
X-Gm-Message-State: AOAM530STkOT+XCFT2jI+Bv6+6Lm+dOCaw2g1hINpBeat0J3PtKPCGna
        oOLKex527iyVs4T+iNhi1Ls=
X-Google-Smtp-Source: ABdhPJx54lWgxLYEUOC+es5kBFdEmvYdXvy16mln+hQlaUlaFl31L6MyfZMZLsAIUBBva9tq6zuH2A==
X-Received: by 2002:a05:6000:18ad:: with SMTP id b13mr14244388wri.195.1637929654549;
        Fri, 26 Nov 2021 04:27:34 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id l7sm6821130wry.86.2021.11.26.04.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 04:27:33 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] HDMI Audio on RK356x/Quartz64 Model A
Date:   Fri, 26 Nov 2021 13:27:16 +0100
Message-Id: <20211126122718.631506-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables HDMI audio on Quartz64 Model A, and the RK356x SoC in
general. The patches require the VOP2 patchset[1] and my I2S/TDM
controller fix[2] to work.

i2s0 on the RK356x is connected to HDMI, and only has one DMA. I've
confirmed this with the TRM. With [2] the driver now handles this
properly, and does not try to register a capture PCM in this case.

To test this, one needs a video clock, i.e. there is no audio if your
screen is off. I've found that running kmscube momentarily is enough
to make the VOP2 keep the screen turned on indefinitely, which is
a pleasant quirk in this case.

Changes in v2:
 - reordered nodes in rk356x.dtsi to conform
 - reordered properties in rk356x.dtsi to conform
 - add Michael Riesch's Tested-by to rk356x.dtsi

Nicolas Frattaroli (2):
  arm64: dts: rockchip: rk356x: Add HDMI audio nodes
  arm64: dts: rockchip: Enable HDMI audio on Quartz64 A

 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  8 +++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 33 +++++++++++++++++++
 2 files changed, 41 insertions(+)

-- 
2.34.0

