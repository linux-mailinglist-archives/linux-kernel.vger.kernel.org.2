Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430A230A462
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhBAJbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhBAJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:31:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99786C061574
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:30:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d2so4552214pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 01:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SZcY/cTYAV9gOjki0HAFY3HZKWSO9Da4wkrASt2n+fg=;
        b=aec/wnh2CcGmv5nxwMrpLOQBmerb5Fu3IzWR/PpXxLjrGgRryiPQ/qlWm5/DCprmfu
         7C/Ll7kJF2q2g4UaNgqNJZzHZF0RFj+UvN8AJKgh+K+OVxE97o75UAAAtCeekWQWglYH
         4kc8SSSFUN0g42mVhohVV9JXga//uR8CqY+6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SZcY/cTYAV9gOjki0HAFY3HZKWSO9Da4wkrASt2n+fg=;
        b=ccWYv3lMJq+yVkGbyoGZ1PzHrhrL+vvwEO4nbErdQ2LGM7neOzoG5NFtj7htUGVQra
         hxQgrI5INU73YJGSHslhNR8shYrU0qQ0xZFg5ojctv3znHShogi6r+QahNlh4wfCWAZk
         7ED6IkwtfHpEZboCM7shajDVl6wbksOrWUJQ2Hwl0WpyeuiEBhSkLmPuZUEaVL+ZSWw+
         9suzvysWPDbcHdfklHSDJU952/qjD5pAQwm/uhbFBeWTxzY7Qiol97zSxMIfCbLwkhiy
         NH96IGLWxLYWHbbOco+/2I9jbVCxnU92nVTehWIvp8OWWeRR6esPueKL4siOAbfW+phu
         oGPQ==
X-Gm-Message-State: AOAM530szxaWlaQ5+/Y0JKPxic68P/dEESmhaiAtMf4zmzVFwB88goQn
        vJy8pufpTc0HjzvNSK7a3oSYKw==
X-Google-Smtp-Source: ABdhPJxlY5GAiR+f+jEr0JLHTYBTgvbf08NYkoVhdvX4Ghl+NlkGXIzxnkudGQXWytfw9ulrOzgvKw==
X-Received: by 2002:a17:90a:5410:: with SMTP id z16mr16139042pjh.110.1612171855027;
        Mon, 01 Feb 2021 01:30:55 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0cd:1b84:6d56:68e1])
        by smtp.gmail.com with ESMTPSA id md7sm14890795pjb.52.2021.02.01.01.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 01:30:54 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8183: evb: Add domain supply for mfg
Date:   Mon,  1 Feb 2021 17:30:49 +0800
Message-Id: <20210201093049.87285-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add domain supply node for mt8183-evb

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 3249c959f76fc..edff1e03e6fee 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -352,6 +352,10 @@ pins_pwm {
 	};
 };
 
+&mfg {
+	domain-supply = <&mt6358_vgpu_reg>;
+};
+
 &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_pins_0>;
-- 
2.30.0.365.g02bc693789-goog

