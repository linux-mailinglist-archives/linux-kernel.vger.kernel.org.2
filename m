Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA2E31C672
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 07:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBPGCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 01:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBPGCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 01:02:38 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 22:01:57 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id m2so5586806pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 22:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MvOw0Ff588/tu4QKvASlxFGu1pPr+mLDUaTBEi6kKFQ=;
        b=DUfzscmQzTgAwzpztM9K2GbtX8KLV2SMfUHBYNtidPcyg/BwYWSZo7oDrYjhKrnYQp
         AkSrgHyOlXkWkFmYiZZg/E5zlcKcT3jRGRTHsLEt04tEdxd099aki9ByYiU8qbREEr3X
         AINXGNKSyCHQ4dRAfIlJePW0Q6x0vbbH7pyoU/AsFlKyhBvDN9ZDo9S2qxAnbyzA7CVC
         eBDgzJv7zWPbNvJWRYlcJY2FiUZSXRN1oNtwQy57J60pcUliS9uAa6AdmOAaXeL83PPZ
         fLkxt+CKLyPHFm9gGVNQWqKubqFxuB8E6MXOcjhJDkkCAkROpdqj92SExBRmrHcRAF+8
         HmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MvOw0Ff588/tu4QKvASlxFGu1pPr+mLDUaTBEi6kKFQ=;
        b=joD61OEPTh8Hlw3zbrljmbfovIxsFF/Ppz0mDE1Sx46Dci5KxJHin3pLWry7UZJ9ow
         kQaZtzKthDX+ejTATI0eO0SDDOxdNcD0waZ/JYR1CZsVjLD2mJfhLrT8ZBuxlggrvfbA
         /zZLhD5zJiwNfiCS5tbmV8a/5vf9Fi9ZQH1YgaIF4+GvRyBGDRHr7HXsR73yZfk1b1dc
         fsWHKzzCpnbG4hA6ZS20vMvBC7sboFpySfk+8cpSENTPKKYVsJO9ud0ewM+bXC1yeppb
         aJ8hr0+d4DeRJDglqGSxudEFDPDvawBqBgOcDM78f+m2cHvRqdYmzqYBkbrKD78ILKCP
         /H1w==
X-Gm-Message-State: AOAM530R3vphVVl5+Nrfn8oLZdyIdaVBFIRuFbUKj/kHwSQG7n/R9ytQ
        dkIETmDVvJNBcjDzrYRlkZUfug==
X-Google-Smtp-Source: ABdhPJzDOdjC0BnS5wTWY0fZV/zrirrlMNe14bZ2HulTVbOFnKcV6Z2qpvDnW0GfFT2roPEJ7Rs1cA==
X-Received: by 2002:a63:5703:: with SMTP id l3mr17795055pgb.344.1613455316082;
        Mon, 15 Feb 2021 22:01:56 -0800 (PST)
Received: from localhost.localdomain (36-239-219-87.dynamic-ip.hinet.net. [36.239.219.87])
        by smtp.gmail.com with ESMTPSA id c11sm6161369pfl.52.2021.02.15.22.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 22:01:55 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: pf8x00: Use regulator_map_voltage_ascend for pf8x00_buck7_ops
Date:   Tue, 16 Feb 2021 14:01:28 +0800
Message-Id: <20210216060128.126938-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The voltages in pf8x00_sw7_voltages are in ascendant order, so use
regulator_map_voltage_ascend.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/pf8x00-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 9b28bd63208d..5d319fb81288 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -359,6 +359,7 @@ static const struct regulator_ops pf8x00_buck7_ops = {
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.get_current_limit = regulator_get_current_limit_regmap,
-- 
2.25.1

