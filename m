Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7453A1FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFIWKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:10:32 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:33703 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFIWKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:10:30 -0400
Received: by mail-ej1-f52.google.com with SMTP id g20so40753915ejt.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=huNq8zmvWoHj/7mX4452ngkraIV+X5LPemMUygCMxm8=;
        b=hgBnGnfItYVgT5nriZbB0awvzlm/Y0OnGqaFvrmrMhLayljVz6MpfbFb1vDi5elTiW
         ZnNFsmL499p8pjS6d5GlOegvwFdtnv8frb4HUR+XZpxWCy0V4FTQgr1N5pg+M/r6lwpm
         0xNyTe/qWVkOoT0Y1glmWBzvQjIcX3mue7U6tcMkEI9U0kNXebcEc6xkBY/IMwdYAfOu
         0lyuxp7bzR36Va0EwPv1ylvw4/aG9XJgZbrIQw4ZW7H8wCspUmz+AYrVHR2OXWFvN00t
         bBKWe2VM4k/N+Uq8cBOqIG5mn+ClUmhamrz8ANyvM/IpW2ditKaF4PYqN/oYMRTJjQPI
         zijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=huNq8zmvWoHj/7mX4452ngkraIV+X5LPemMUygCMxm8=;
        b=k9yrmrlkKtwwEeHKonTLGolntkzs0bL3E2XU3fB7wgQMO1mZX5NPItkE/unjyP32//
         iVNjj12qi1zsnHyeYTOu6lHXgR9hhWUw+NwuhWy0JSMQdWWrt7M/wMRt78hQ92b91qzJ
         5METc0pp2KN7OIm2XEQPuhj3mvTqTksHBLYPHXprPippmYdtYn7Rsyk3B/BCdeSJ7Dmt
         LkAEr6HIdlK6lFEey2swdvrxcyx5KJLbWtCCHTs/S7zWVXphEYPzTDeJ+jECnFxMKVu2
         4DZTTuzakqYLftr3RF2737DR+hpehpSdYMbCszQhpZ18IK1tYIynMOWF9za/OEpRXESN
         aHrw==
X-Gm-Message-State: AOAM533foJ0h78npD82vCYB83hYVGjPnlkN6pC5QTkK9kY8nsBZAknk+
        QNF/Jyh+Ab1P7MwWUycc5uGEt3k0ckZF1g==
X-Google-Smtp-Source: ABdhPJxUs7A+2kn2ss1y8X2MuWMFqe4tr8KWiOfHP/1frCLYVaynJFV7hn31iqn35kevXzXOt6e77Q==
X-Received: by 2002:a17:906:2854:: with SMTP id s20mr1678505ejc.335.1623276454157;
        Wed, 09 Jun 2021 15:07:34 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-76.xnet.hr. [88.207.96.76])
        by smtp.googlemail.com with ESMTPSA id q16sm409770edt.26.2021.06.09.15.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:07:33 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/3] hwmon: (tps23861) define regmap max register
Date:   Thu, 10 Jun 2021 00:07:26 +0200
Message-Id: <20210609220728.499879-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the max register address the device supports.
This allows reading the whole register space via
regmap debugfs, without it only register 0x0 is visible.

This was forgotten in the original driver commit.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/hwmon/tps23861.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index c2484f15298b..fd0be8883829 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -117,6 +117,7 @@ struct tps23861_data {
 static struct regmap_config tps23861_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	.max_register = 0x6f,
 };
 
 static int tps23861_read_temp(struct tps23861_data *data, long *val)
-- 
2.31.1

