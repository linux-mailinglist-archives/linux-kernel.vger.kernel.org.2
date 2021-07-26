Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9273D576F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhGZJoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhGZJoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:44:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ECCC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 03:24:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j1so12244647pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pW0eGkvQ6eOZmaZcz9mU5uP8ebeBjXUC4Tbu5TtON8I=;
        b=Pf/oHHWsyMOfHwINIhvXpjEhEwOeE9PeRie/VkzNGnEHP/KkrFliliN125xUn7Eyxf
         fyL3spoGDZaJT1UU4bqal9TEsW5j/iEToyQqoiBm1SM/cIHbZxiwnG5kKoSivqkP3hbA
         Kkqmey7iSxTWiVftZ89sZoYc3i4DRwUR+Qw9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pW0eGkvQ6eOZmaZcz9mU5uP8ebeBjXUC4Tbu5TtON8I=;
        b=LO+LptNnK0ahJqOifDKZ1ugrMb0ldPZAAyE83nF6fCxsTjPvwsp5+prSXuvzc8b4qR
         z4abnaDWrFq4cxI+kNW/MNrjzlreQnrOTlXJbl6cj6T5xkA0+u1gaUlzx/B5/ubuSSUF
         qUKQYVwrYF6eGOatMgIoPM2ZDpXWrK8YsjsREYp6vwT9Sako4w5ULboGbamptw3ejVtH
         HK25hsZE0dGJM6WKhVMnJHVOAV71Y+gkCs6dkwyBgwe9FvOkS5IkdvzTBE6AhS6uQya8
         uPJkaFlyulnvSbEa/w5M6kGOh5SEIMDC6myz7Q/4DB3wYekLp0TAorDKW2g/clt8jupb
         hPyQ==
X-Gm-Message-State: AOAM5319Cqt7KaEcYMULh5ouSjaxe2e2Ef66F3vropgmWIJirf/qZgWc
        Zzy/y8Cx5NetAKofUdiOSmk+pA==
X-Google-Smtp-Source: ABdhPJxIOaGVeR+yfNUna6akEQLE7MrP5EeQC6pHrJ4jPJeZoRuVEcOBBRAUmwhUFQUABa/w1ZkkOA==
X-Received: by 2002:a17:90a:5141:: with SMTP id k1mr24638415pjm.185.1627295087208;
        Mon, 26 Jul 2021 03:24:47 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:24d6:d449:2832:1652])
        by smtp.gmail.com with ESMTPSA id z124sm3113262pgb.6.2021.07.26.03.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 03:24:46 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        eizan@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: mt8173: elm: Use aliases to mmc nodes
Date:   Mon, 26 Jul 2021 18:24:42 +0800
Message-Id: <20210726102442.2119877-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use aliases to mmc nodes so the partition name for eMMC and SD card will
be consistent across boots.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v1->v2: skip unused mmc2.
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 21452c51a20a8..d5a2cad39c9c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -10,6 +10,12 @@
 #include "mt8173.dtsi"
 
 / {
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mmc2 = &mmc3;
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
-- 
2.32.0.432.gabb21c7263-goog

