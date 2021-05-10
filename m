Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B0437978D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 21:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhEJTWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 15:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhEJTWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 15:22:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2699CC061574;
        Mon, 10 May 2021 12:21:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g14so20056302edy.6;
        Mon, 10 May 2021 12:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EFsFb8pMI8UH4jNijLN54heTyN+8V4Uo+MBIc8sUxEk=;
        b=B3BkgcsmCDDggzaQBqgSezKwkbbqsZfGSGHotgPFSo6MlhFi5AZI+EQJXmxL6ONXIH
         +XxT3brBTzKMIl2XB5AaK+hb0YNx6DinOhsmfRc/nInm5YEIeiDMltiuAI/bi+dp8yMt
         zHuHR5wg0IXhjq6MWHo5Xcp+bDr/7B3uOhlAhI6fCyybriz0X6gcBQooJh7NLRl4CXGN
         GOUXbAg0vOxhKZgOIPf8VsZfG5SSHaqQvy37N8Am7RUAM/0THSJ9jPG16/Rf49WDc4/n
         PvK3s+s0stZSfOozyYcCckeD1l1NRYuJErP3JiX0MuL368RMCgV7KZK/6RNqoC6j4Jn9
         5RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EFsFb8pMI8UH4jNijLN54heTyN+8V4Uo+MBIc8sUxEk=;
        b=G/jHuUToc5ADxZnQAFandO8oab/q/3gpxMyHYdZm/iOkyXLG0qAXmRdPLkqM3PaJij
         F2knkos3Y45/E4qDKpTyEZOl7HiBYOhdggjmCBy+EITLe0yxdpUrBtzSBiK9XvQ7iQDi
         quTvFJy/ndledJbEaitE12g89WI9DHkCbZ2+xGrpxITkrMabO1Bwq8V/cg3WO5KZeO8V
         X0lbzRQBRUidnY28leT+mi/KKx+vCknQ2lJKrvVChK0/0Shw75UMlUk7BBll7vgXOJGV
         iF8GRyRN92TCn2R8Ly42d+dq+u1winHAyM54oxM3n70I1AWMPhpIldzgMuFl/SH8FqE8
         fsIw==
X-Gm-Message-State: AOAM533YXELtPbYzu6AkPNElxXb0PGs1UrVTSwquEQwMpwZrkZKpYMBF
        eG5xYgk5narkbiM13YNWjYdp3Mxs6qY=
X-Google-Smtp-Source: ABdhPJxsLinSeYfgg7lxOp4j3xHptYRQPXsgIzFgXp1XDQN7tfLYAzTCO0Vru0TAv7NHrcaunEiqIA==
X-Received: by 2002:a05:6402:4383:: with SMTP id o3mr31312889edc.333.1620674461780;
        Mon, 10 May 2021 12:21:01 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id da25sm12588723edb.38.2021.05.10.12.21.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 May 2021 12:21:01 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: rename vcc_stdby node name for rk3066a-rayeager.dts
Date:   Mon, 10 May 2021 21:20:54 +0200
Message-Id: <20210510192054.8876-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

/arch/arm/boot/dts/rk3066a-rayeager.dt.yaml:
/: '5v-stdby-regulator' does not match any of the regexes:
'.*-names$',
'.*-supply$',
'^#.*-cells$',
'^#[a-zA-Z0-9,+\\-._]{0,63}$',
'^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$',
'^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$',
'^__.*__$',
'pinctrl-[0-9]+'

A node name shouldn't start with a number,
so change it to 'stdby-regulator'.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema
/schemas/dt-core.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-rayeager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
index 309518403..a73e8900c 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
@@ -58,7 +58,7 @@
 	};
 
 	/* input for 5V_STDBY is VSYS or DC5V, selectable by jumper J4 */
-	vcc_stdby: 5v-stdby-regulator {
+	vcc_stdby: stdby-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "5v_stdby";
 		regulator-min-microvolt = <5000000>;
-- 
2.11.0

