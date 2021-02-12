Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD49319D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhBLLTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBLLT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:19:28 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25605C061788
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 03:18:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d2so253286pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 03:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5biKq7NugFH5645R57SKe1mgC1BP2ckBoaTjbO3BPZE=;
        b=NCgoSjY/AMkFT1Q+TOjkW+QtV2Tgv5rRg6PXJ7EnfbP1PPBhrvLSMGJ2tMnLqGjvtS
         hTZ1DG03+SMrZ6Bs3yBMlN5TnazwJrXYZNZvBQFot6TT7ndKRG4QylMsD6ASbF42Tyfa
         C5XqIi0RdqUAiQAn4klCJX7wGydhpLNWEQcTuBnZ5R4vEUyVMTGeagoy3iwV2HTMcwB4
         TnR1Ic+DM2P4BmPExrCFrXBZA/JS3eH2C3/Mn+gkULvE3kuz+Ujw0N0KntqfdXAwv1Iw
         ilwczRfJcAuISVv6gcIH2Xjd9fH4xaIdiRqDg8rWPfEmvwHn4cTepuwpoG++vZdyNKKI
         ur5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5biKq7NugFH5645R57SKe1mgC1BP2ckBoaTjbO3BPZE=;
        b=FUl7TVifMq5JomVqSgnMOATnylnx3hmGoKcm5/kjUgoE7EA6WYT9DLKA9miKculidt
         OTKeZ7IbOiLuP67gtyXOYUTzMgLPGsk2NOi3KzY1m9LKp0IbFp8tlx7nKioi7mRRhjLP
         2cz9BvdV2eUYS1h/ed7FmNXmwxINM25/NTjFerUoWGmw4tGRhS4jNco4snpt3pcT3M+O
         pXLIcrBfxjsGuzY2CaKTLP0Xpnn9arH4np8H+y5gpu0uGv1+5OS5tIaDNacgmK0p00hB
         r/0JtSjr2jHGDakURGBgpABTHDHUeE6wXK4iOttAZNiyLThz8nUK7B8Urcw+A/82V0Qs
         4Z+A==
X-Gm-Message-State: AOAM531NL2z5LUkNR8MigkLD6l9D3XQneUVompE7bZe8zouuTl2Y/Y10
        IKqqKhC31WPtPaFjOBLAC98kXQ==
X-Google-Smtp-Source: ABdhPJyr0neNj/pWhovDa+tl5s6PMfst3DzFfGPy4e8YRM91yRqkJguQKnyhNg/rIjo/pWUi7h9VHQ==
X-Received: by 2002:a17:902:c9c3:b029:e3:12d4:f2ca with SMTP id q3-20020a170902c9c3b02900e312d4f2camr2433994pld.33.1613128727728;
        Fri, 12 Feb 2021 03:18:47 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id a37sm8763963pgm.79.2021.02.12.03.18.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 03:18:47 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anmar.oueja@linaro.org, Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH V8 1/4] kbuild: Simplify builds with CONFIG_OF_ALL_DTBS
Date:   Fri, 12 Feb 2021 16:48:35 +0530
Message-Id: <cf35bc364da56fb8f1ea3677340508e01e411976.1613127681.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1613127681.git.viresh.kumar@linaro.org>
References: <cover.1613127681.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We update 'extra-y' based on CONFIG_OF_ALL_DTBS three times. It would be
far more straight forward if we rather update dtb-y to include all .dtb
files if CONFIG_OF_ALL_DTBS is enabled.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 scripts/Makefile.lib | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b00855b247e0..fa0db696120f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -81,14 +81,13 @@ always-y += $(userprogs-always-y) $(userprogs-always-m)
 
 # DTB
 # If CONFIG_OF_ALL_DTBS is enabled, all DT blobs are built
+dtb-$(CONFIG_OF_ALL_DTBS)       += $(dtb-)
+
 extra-y				+= $(dtb-y)
-extra-$(CONFIG_OF_ALL_DTBS)	+= $(dtb-)
 
 ifneq ($(CHECK_DTBS),)
 extra-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
 extra-y += $(patsubst %.dtbo,%.dt.yaml, $(dtb-y))
-extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtb,%.dt.yaml, $(dtb-))
-extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtbo,%.dt.yaml, $(dtb-))
 endif
 
 # Add subdir path
-- 
2.25.0.rc1.19.g042ed3e048af

