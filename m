Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3065B382A48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhEQKyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbhEQKyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:54:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92229C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:53:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so3467531pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NU7SKZFv6P5n9CCzr6ai9JbfYNeocnzVULOAORKdLVY=;
        b=0QwT+xF5x2/oaqN+8TVviuT8zlpVOrHwrRTF7NK/mpLajDXg9keaFwJ2BZyrdjqEGX
         bL6BhuSMwAZ61nPHZCP0/0Wi5b7AbN/qL7kGXnu9DD+3g8KZa8xtZYgVFg0yHvTIsXXQ
         QHS1WHXXj9Lcrx27byb+B9j66DcDxnjzer9On/IzMBqRRlDh3Y+6huBy4H96avG5WSNL
         C2CwugDet944AYyVzlKrISSJKRqn4HKvJ6btIn8xaFOR+YQpXE51rWnFS5UenXBn1xd9
         +nPdE2rs+zBDuchtJug+dZbXBofCO5brucPBxt/9SEb9DF21MHqL2Zy8fNCmPOonIRhg
         oKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NU7SKZFv6P5n9CCzr6ai9JbfYNeocnzVULOAORKdLVY=;
        b=VOZIaC4kb1lT73bE/cN7DnEXi+0t/8m3QV83omMJtYWAasojYIJVN/iCyN1kOu5Ige
         gAXpCMtfCHj3QA9zEqqr5WjijdpgTK+JC20QT9Y1nvLwk9yGeUG/tfOB5mvv9+elxjgI
         bSaWg7Je798/J8qzrg//rbk8PKGrMwPbB3azEqozchc4LyLMnvquBqHLidbt/xWD2+eD
         7WSgsW4ZDWNhL+EqSts/1C1FnVog8YbSPh+tbE94D96Jj1SpqOSQZVTZ7WF6WMTQZsSx
         X6fjm22GWMcib915jUoCKB5mqYi7nYTbVgO0UzKt0sPbXMs2YKFZjltxNWoeeAo/KQqX
         K/eA==
X-Gm-Message-State: AOAM533juJX8hZKDOQA1FKWpCRrUCawpIjwBPyvKhe5b/CzgnbKGfKPF
        JGOvAGPphDlVTaH1dkLOVcmz3g==
X-Google-Smtp-Source: ABdhPJwkdUSb7CEqykAEuGOHmmuA3yYxtcJKB1OHF5Pvf4cCPr1GoUzlrSvKrr3rFrdll/WZgyn3Dg==
X-Received: by 2002:a17:90a:4288:: with SMTP id p8mr28687108pjg.42.1621248816128;
        Mon, 17 May 2021 03:53:36 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id 187sm9511700pff.139.2021.05.17.03.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:53:35 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christoph Fritz <chf.fritz@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2 2/2] regulator: fan53880: Convert to use .probe_new
Date:   Mon, 17 May 2021 18:53:25 +0800
Message-Id: <20210517105325.1227393-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517105325.1227393-1-axel.lin@ingics.com>
References: <20210517105325.1227393-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new .probe_new for fan53880.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: no change
 drivers/regulator/fan53880.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
index 1684faf82ed2..f3268b4d5066 100644
--- a/drivers/regulator/fan53880.c
+++ b/drivers/regulator/fan53880.c
@@ -114,8 +114,7 @@ static const struct regmap_config fan53880_regmap = {
 	.max_register = FAN53880_ENABLE_BOOST,
 };
 
-static int fan53880_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int fan53880_i2c_probe(struct i2c_client *i2c)
 {
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
@@ -177,7 +176,7 @@ static struct i2c_driver fan53880_regulator_driver = {
 		.name = "fan53880",
 		.of_match_table	= of_match_ptr(fan53880_dt_ids),
 	},
-	.probe = fan53880_i2c_probe,
+	.probe_new = fan53880_i2c_probe,
 	.id_table = fan53880_i2c_id,
 };
 module_i2c_driver(fan53880_regulator_driver);
-- 
2.25.1

