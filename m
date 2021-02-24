Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941C03240C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbhBXPZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbhBXOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:46:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E65C061797
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:40 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d11so2123721wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EgUEnyJu/P3709V222xt9PUcmOUvMnUAFsY0bMwnwt8=;
        b=eL6+4Xb1pR/CPkBOwcJnNsjuIt00pQ1rGiBu5DnyjFAKDikmDdWGVspex8LNluYyK5
         RlRkVeKiJwToE3Tc6NvinhMotYLrZoRuqa7XlYdGA/jqeJa66w3IAgSnSgithdBOZ5P0
         IuBP+S3s70OiyuAgClsdvDkDq+mfPQhHdsd6cgrPL08qB47aGd88bQxPDzH9Uy2YxKx6
         pbmHFlhzGP7LECKn9J8iA0PZpmpAn1fRDfm/kPLiFNmLHsBEDuBwhGMWt867qN29kiGw
         lI/fPHMR4Xz5uXoC5wKbltFUAx/LdwxHAt3Mj9RaX53blgUuo1PpyxJLP40/QO4Bqkv/
         TUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EgUEnyJu/P3709V222xt9PUcmOUvMnUAFsY0bMwnwt8=;
        b=tBAQBk0Uzkw1qsNnHvl46VWelHT+SQyRseI2y+/e8U0RGCE8DU+WBIQiyxd3uynZYr
         7xEqnQbBOtMYY4OFTgXd7xQNtQ67nlTkeUuKeRDahzxJyZ+21p8r9gGeSL/IJCYJ6gAL
         cm6XZy6Erl8QRGh6E3Ec7tAt4iMiYxAjhVYmLSjw+P2be82fMASUm6WWQ85/jcBGXVSQ
         7HHFEuACPvBh8UDsqm6ctxU5yeYGZ49CMYl1ZHhE025pqqnI3Np+boP2K4XqsbyM4jup
         d/YRia19Wd9qwljcfLrFnnVPXvleYawRRgob2y1c3IxtDlHnlQ21/6R40JUqnKmQxef3
         bAAw==
X-Gm-Message-State: AOAM530JLCjmvi5DC5Na7qtrSIGYEq5IjxdO8Qec2sSGjTgMiC+0jSIV
        jbKmozzOrXQF1dyuQ94rMRy03t7quejZww==
X-Google-Smtp-Source: ABdhPJy6oa0zxrD392i6w4EiM4SUJqNf2xFVfiqJEZ3cqLJqPenbPKYlB587VlgqsGQlXKDEaP3Zsw==
X-Received: by 2002:adf:d088:: with SMTP id y8mr30526431wrh.101.1614177758831;
        Wed, 24 Feb 2021 06:42:38 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id p3sm4170669wro.55.2021.02.24.06.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:42:38 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v2 5/9] hwmon/drivers/mr75203: Use HZ macros
Date:   Wed, 24 Feb 2021 15:42:15 +0100
Message-Id: <20210224144222.23762-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224144222.23762-1-daniel.lezcano@linaro.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HZ unit conversion macros are available in units.h, use them and
remove the duplicate definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Christian Eggers <ceggers@arri.de>
---
 drivers/hwmon/mr75203.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 18da5a25e89a..868243dba1ee 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -17,6 +17,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/units.h>
 
 /* PVT Common register */
 #define PVT_IP_CONFIG	0x04
@@ -37,7 +38,6 @@
 #define CLK_SYNTH_EN		BIT(24)
 #define CLK_SYS_CYCLES_MAX	514
 #define CLK_SYS_CYCLES_MIN	2
-#define HZ_PER_MHZ		1000000L
 
 #define SDIF_DISABLE	0x04
 
-- 
2.17.1

