Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1E43A2D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhFJNoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:44:37 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:34509 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFJNog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:44:36 -0400
Received: by mail-pj1-f53.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso5490268pjx.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K1AvvpV3OiA/4B8+pWc+Xv481sT0ak/P2KNEQVpoy08=;
        b=DjYSNaCTPkUFI3cTdgL+Ht1kCZQE00mbw8z/E32X3iCfmDFMiOLPN7Bliusmr32K62
         I9SYUksBNQDr0P7+Pd3v1Ejy4+ZfgSbX5gTkRzAz/VwifSwMVlCq9jaUuNb7wjN+wtP0
         typq0WyZXMOdmtju+HuLmBdkt5L/21uLUBUim7SjWNgxClA2lXzK9iqJq4eD88zC+XnQ
         uXIav4xddsj9rlKinuGBXS6iJYP4TK1ArKGKUbN91dAgdnTmA/PZ6ZxyopXZPWAoblrF
         VOiIUQVGBicFeGJ+7ukpIR0ZdLRDxx0vXMZYEff3zQwd5AfCGVHOvtQV80pu0vDVavYM
         6YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K1AvvpV3OiA/4B8+pWc+Xv481sT0ak/P2KNEQVpoy08=;
        b=G4qwrTM2DaTuWVZiRoWeTVjvp2e1rrnUGEPojIxN8uacoWBeG7iwhZ/lrzd3uDoxL5
         nuNmoXI04779+bx7x+WcVpsMqX3AUJq6C73Cuk2oihO31Yi2/lNaIw01ZbR+ne396dEH
         eGpuurla5naDnmaj1QbOxYHM+410smYqMCayA6xG/aTrVWkBKjgQ8fDdNS54ihCw381K
         ymBmwjcPr3WSrkYl7lV3mv0UobV2j5h/3g80Wm5Y16eJBJk69klXNdFj3A9eHBGRU60E
         OVsKljLncLa2VYICPsQbhT5Gv3suCZP8+mnhzywhN0HQVw1ItaOtiHRTIMCE4apQiTU4
         BoJg==
X-Gm-Message-State: AOAM531qVgmC8asEROO0fzAIGMjqCmkyleCqzOgErWHw5Kek3YFE3zH3
        s6ZoiHKbNuKYORmzoHigXojdjw==
X-Google-Smtp-Source: ABdhPJwps/Q/j7guVLuqLX/fjO0zbAZw6iLDY+z2sQRJ2j1TGp9KO7mg5dc7KO3zmharxbWFXEHOIA==
X-Received: by 2002:a17:90a:5a4c:: with SMTP id m12mr3416363pji.229.1623332500466;
        Thu, 10 Jun 2021 06:41:40 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id q18sm2703406pfj.5.2021.06.10.06.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 06:41:39 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: hi6421v600: Use regulator_map_voltage_ascend
Date:   Thu, 10 Jun 2021 21:41:28 +0800
Message-Id: <20210610134128.2477821-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the voltage tables have entries in ascendant order, so use
regulator_map_voltage_ascend to speed up the mapping.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/hi6421v600-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index c5f41651223a..b5a19938fd3a 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -166,7 +166,7 @@ static const struct regulator_ops hi6421_spmi_ldo_rops = {
 	.enable = hi6421_spmi_regulator_enable,
 	.disable = regulator_disable_regmap,
 	.list_voltage = regulator_list_voltage_table,
-	.map_voltage = regulator_map_voltage_iterate,
+	.map_voltage = regulator_map_voltage_ascend,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_mode = hi6421_spmi_regulator_get_mode,
-- 
2.25.1

