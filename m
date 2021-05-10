Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B11379861
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhEJU3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbhEJU3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:29:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F9AC061761;
        Mon, 10 May 2021 13:28:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e11so8862490ljn.13;
        Mon, 10 May 2021 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBkfnFQmSEpZqi85sXEZYXP16HRwJqEgi4fbLpsogpE=;
        b=PeX8nX/MQPTReBgAO2iahYc2TaEGHY7AN8X/W5eIhMlN6ggpZJr617dbdHqRfLaKiM
         bsYVji9AuVjsUWjdCpBsRC5+bAVh3/rOCbtg2nnM2nUJ1yuBcwpXnA0H5x2kHJfss/tE
         2Xc9O9GHTDzHZuasikEJ1Jw/VaTuSE5jF4S7E0jakl2c2RpBeweB4Om3DWuoi24tfbsr
         Fgtciw6L7eKnhfgG/Q+Q8AXrKSXUYlEwolYa36r61MMr3Sk52VkjvNCi/ohqB1AiYOxw
         6XoT6DijszsLLHTk4Mbw0oxRAlX22FJETmigmKQUZlESJzNT7KVYZThw8WxQF3cNdATq
         JIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBkfnFQmSEpZqi85sXEZYXP16HRwJqEgi4fbLpsogpE=;
        b=QWnqbJizY4vmuNqFfGUneJkWP982BaYZkhUrHjmZAg3/j5aXAAjx6xPGAGYJaVLvXc
         vBJ1jXrIRC9uM9AS59vIcmUYl0mDAG9pir7SwQrr+QIchCy/Q9SyrWbo8Glgna53Hzpz
         vtEjNUA97NG1uL43r1aDvZQPensJ6PhrEzUl+lw05fEdsX9Bqh6fnBhWqUwiNQxixFNu
         hPuSLdVkaDspMThcvmAI51Q7rwZCHJ6R9UTkquU1XOeBhSSCe48vH3e7COsQovBG5ePG
         0YmdeJXHHWad2G0tJhH+TUFO73QwAtLcPKz6A8dI+nEbzufV3FdBHPEnadp/xQ0puY2v
         cayg==
X-Gm-Message-State: AOAM533mgDtq8b8aR+jnAM94+9zxwIV/H3sVEtGFfl8jluKxQaGe+52h
        4OUbgHVgAzwTDdq1I6ja3P8=
X-Google-Smtp-Source: ABdhPJzhcmgH9tsfhWys55S1LzsM+ZKKqPLtaD8q/U+EndPPFI1ueNixzs4seWmaU8wjhUSpTk3xiA==
X-Received: by 2002:a2e:9787:: with SMTP id y7mr21457811lji.65.1620678489154;
        Mon, 10 May 2021 13:28:09 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id z23sm2360662lfq.241.2021.05.10.13.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 13:28:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Agneli <poczt@protonmail.ch>, Paul Fertser <fercerpav@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/10] ARM: tegra: nexus7: Improve thermal zones
Date:   Mon, 10 May 2021 23:25:58 +0300
Message-Id: <20210510202600.12156-9-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510202600.12156-1-digetx@gmail.com>
References: <20210510202600.12156-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused thermal zone just to clean up device-tree and set critical
temperature further apart from the passive cooling trip point since
during or thermal testing of Asus Transformer devices we found that CPU
could reach the critical temperature in a certain kernel configurations
for a brief moment if critical trip point is set close to the passive
trip point and then device will be immediately shut off without getting
a chance to cool down using passive cooling.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../boot/dts/tegra30-asus-nexus7-grouper-common.dtsi  | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
index dc773b1bf8ee..3376d06facbb 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
@@ -1252,13 +1252,6 @@ sound {
 	};
 
 	thermal-zones {
-		skin-thermal {
-			polling-delay-passive = <1000>; /* milliseconds */
-			polling-delay = <0>; /* milliseconds */
-
-			thermal-sensors = <&nct72 0>;
-		};
-
 		cpu-thermal {
 			polling-delay-passive = <1000>; /* milliseconds */
 			polling-delay = <5000>; /* milliseconds */
@@ -1274,8 +1267,8 @@ trip0: cpu-alert0 {
 				};
 
 				trip1: cpu-crit {
-					/* shut down at 60C */
-					temperature = <60000>;
+					/* shut down at 65C */
+					temperature = <65000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
-- 
2.30.2

