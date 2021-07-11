Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7E3C3BD5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 13:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhGKLYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 07:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhGKLYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 07:24:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AF8C0613DD;
        Sun, 11 Jul 2021 04:22:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gn32so27332512ejc.2;
        Sun, 11 Jul 2021 04:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pPMmWhd2NgDyTJDkPom6RenStkxv3xOr8isEdZrof9A=;
        b=qsMmuoGCGEd0t4fQfNoC8iD4mxlcgfc2qanHZJzHGF1fEykMVgLNyGkmfgxbxkeRf3
         ot/pHLoT/ucnLDK/P6kK7TH4EwofDsZ4B7kxPHazINiGUZHJDAaaY1gsQK3znACrGWHi
         lQEJPVct4UJ8Y+RKVQRn+j0iJE1WeYLOtqz2/mgG57xxelFWZZj+uQe1dBS0JuGgB/Xm
         WNBimqn44yRK4VtigFdIDcAC+xGUA7EXqjsYR818vpjWNlYycOgok2J3JYVs2nssAVtv
         XRRRv+7IrixR2bbi/+OmjDQ+RQoNiqzvDBnzEyw5FxLeaSLP45eGe6G3onFa0kRi7IJR
         Rvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pPMmWhd2NgDyTJDkPom6RenStkxv3xOr8isEdZrof9A=;
        b=ldw88tAPHp/R0G/V4nMM0/L1lI0v1njJhKKzoLGKIAhGmuVTLl0V8eYzKOqZpZ0G3G
         TpxLYVHAYXHWKy7vCxYPcGTUs8NMMrdNUDJwhawQ0iYJlANm3Xv/NbnKbHql9XJ/afyR
         1x+4SXfRoB/xIgmxxSEJLiNM6CgLoUtGbBV8onG5cAmy76B9Hg4AK91IN1uUi8TbnUDN
         9FAIfRfEkBOFxdXT+RW60Imlbb9CoUHV75ekPBEb+2q6kuBV6t98XSQJBgYFgzfruZBv
         +qvYJBKC0aGSQL9W8WPBge8VhPK7YSgyckRWYw2832xqtyfEfpg2Yc6vHduz6p7medtj
         QoLQ==
X-Gm-Message-State: AOAM531fLR3U7TZegWp1FaceUeXAkZFR7bnRgBv29jhJ6BJQjOBRQ42G
        6EJXF3jdbvvuXxq12WnEBlAVlZegUAyzFg==
X-Google-Smtp-Source: ABdhPJyjy6QnfSD6OM4I4cOTs1oT2UIedE4KbEAeSsuRoCk0ZZXeDzPUkvSmCvpR076C9VmQxr6uXA==
X-Received: by 2002:a17:906:5d13:: with SMTP id g19mr48824982ejt.90.1626002522410;
        Sun, 11 Jul 2021 04:22:02 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g11sm5989505edt.85.2021.07.11.04.22.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jul 2021 04:22:02 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: rename pcfg_* nodenames for rk3066/rk3188
Date:   Sun, 11 Jul 2021 13:21:54 +0200
Message-Id: <20210711112154.5287-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename pcfg_* nodenames for rk3066/rk3188 to pcfg-*,
so that they fit in the regex with the other Rockchip SoCs.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 4 ++--
 arch/arm/boot/dts/rk3188.dtsi  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index b52ef9254..659c14795 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -368,11 +368,11 @@
 			#interrupt-cells = <2>;
 		};
 
-		pcfg_pull_default: pcfg_pull_default {
+		pcfg_pull_default: pcfg-pull-default {
 			bias-pull-pin-default;
 		};
 
-		pcfg_pull_none: pcfg_pull_none {
+		pcfg_pull_none: pcfg-pull-none {
 			bias-disable;
 		};
 
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 6764776cc..b46967ccd 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -275,15 +275,15 @@
 			#interrupt-cells = <2>;
 		};
 
-		pcfg_pull_up: pcfg_pull_up {
+		pcfg_pull_up: pcfg-pull-up {
 			bias-pull-up;
 		};
 
-		pcfg_pull_down: pcfg_pull_down {
+		pcfg_pull_down: pcfg-pull-down {
 			bias-pull-down;
 		};
 
-		pcfg_pull_none: pcfg_pull_none {
+		pcfg_pull_none: pcfg-pull-none {
 			bias-disable;
 		};
 
-- 
2.11.0

