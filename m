Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD1D39C640
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFEG1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:27:00 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:43850 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhFEG06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:26:58 -0400
Received: by mail-pg1-f169.google.com with SMTP id e22so9548731pgv.10;
        Fri, 04 Jun 2021 23:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9YWDGtwFEazMTgKTgnhtKVsR9Lwj2c+5ANH5SB580b0=;
        b=VU4xUvxj8Ka6QbKD5Z8P/ZTYBq+bi0uhn/OBxmqhK09ENRS7GQaO3mD2QbsRorzUHD
         kcRgXoI17RZNV339weqOAhYVX8jhf3JV1EzrI2AsSb+cm2xlB92IIAbpDVcBLsxoWTLq
         0oVIMxsLv+Bxl438VaMqyA7+gjMmW2DKE12jJTNlwTU31K1NJkQqJq6jLQiXE58KiOYJ
         roRG3duuuZS0VEXKRQZg0ZttpgIQlkRClHeJz6r9wdLSqBNmmfByWPuUc6+23rgMKOx2
         KWmayYhL42H1olyOvnJNkrd9AGZpXS/wrpygWapmezeWgSn/tL8xitBwjfuzWeh5Wwkm
         pciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YWDGtwFEazMTgKTgnhtKVsR9Lwj2c+5ANH5SB580b0=;
        b=i5nGZot15wm4Cqym5J1w8vfLMYg8UgvD8ZGGQjc/MpZQ7RB/FwYZWcKRACYe7F+KnY
         DubNm1zWjGAWFDsRA3L2u1I6GVq2gqzOY3ORteNgAqximtfSnWvqPrcjxLtdRWd6GY26
         RsjI6sfamDLf1Hx6Ix7+XPN/5JSaA00JzUbjwJmMLZeYYHMpkIN6XNzHAueFC2Q5V4M5
         zbepgU60KY+hP3qyggIk0Q/+XsW12BEtQ+nr8J2AIkf45T0XsiAd0zjp7uxN5dPgrWIm
         ILaWB3eAbojvSZD263f/Y2hVQ5Yv95kAFc3v2KDK6+xhf8/FYERk7V0j69cILdzwqNuC
         Cx6g==
X-Gm-Message-State: AOAM530MxkQUwrB+zf68jIYEd9lvae3XQguN9z26HZ+HZd0pUa10JUIc
        dSA9t78e70LvBSKuS0ogBlc=
X-Google-Smtp-Source: ABdhPJxzjyCLmeG7YWzhB4ygUvxNMzHtzR2iTYMCJCHuKnOungdYiNLMgC3rh5xTGwy2/15OBJPQIA==
X-Received: by 2002:a63:4c66:: with SMTP id m38mr8471520pgl.157.1622874235243;
        Fri, 04 Jun 2021 23:23:55 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id v14sm2800870pgo.89.2021.06.04.23.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 23:23:55 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH 2/6] arm64: dts: meson: vim1: update serial aliases
Date:   Sat,  5 Jun 2021 14:23:09 +0800
Message-Id: <20210605062313.418343-3-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605062313.418343-1-xieqinick@gmail.com>
References: <20210605062313.418343-1-xieqinick@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Update serial aliases for Khadas VIM1.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 60feac0179c0..f116a9d91633 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -27,7 +27,11 @@ button-function {
 	};
 
 	aliases {
-		serial2 = &uart_AO_B;
+		serial0 = &uart_AO;
+		serial1 = &uart_A;
+		serial2 = &uart_B;
+		serial3 = &uart_C;
+		serial4 = &uart_AO_B;
 		ethernet0 = &ethmac;
 	};
 
-- 
2.25.1

