Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0DC3A1FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhFIWKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:10:48 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:37553 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhFIWKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:10:46 -0400
Received: by mail-ej1-f46.google.com with SMTP id ce15so40691163ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DmHuey4cBQMswlLLUPQdxLcQq4bcm4Xw89GIxtMTQuY=;
        b=kCpbBnD3FPXMBZhPjwjsn1hRdjXyvj7R1pPQ67vE4PBWKitdWy561xORxvaqA/xeom
         Gdy09gpnEA2MoLeI08rVfagTxl0xwbmajYuofLWwlykAxd4YqB8NRr0nSK9NI03C3OWJ
         VqTMoLDN4pWZXHpptf2pX5nY0czfddPYRLGC8XYMkEMkNSKAvy6CSK50qFhHmRcFDqjx
         1Nn1R1FZosA71CqCd3LtjSnGerjPUPSm9oPGf+7T9Av0Ydyr2FdND/rQdYzjgO+hS5XI
         ieYXIyBwxC3ntXgXIy4KxgPPO6z7TOaiirKeu1LXThSRTJAQZHlnKwYSlwrZRB1cuziA
         gtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DmHuey4cBQMswlLLUPQdxLcQq4bcm4Xw89GIxtMTQuY=;
        b=nuo0UEysFIjAEUREQ7xdTMBLGAKEZfO0LksCCmzAJWi+mjnSkYoK63okDR3OR+dOwK
         YfS7bcLqeVs6g0E8oscFhQfqQ/OPbfaR0m+hofgHhcrARQqrlRtBe+HLWs27VCcoDZgg
         U3TzvlMJJQGQcamhpq+SYLicRLUYVth8KwnHDWRjkRvlB8WY80rr7cVRq1GxRypuX0KH
         7quCaC/3VZHYrtbljqc5IHvjM+dmfQr/2CGb7O0SmOA2nZAPO0mKEfgpJ6TQGdIScYTc
         e0QsRD9lVTGYpfyaynqSaVLPFWUnr1Ce71BbYLuTI1IdE/4zHkPkoo+LB8EJYQzBSCpF
         mJGw==
X-Gm-Message-State: AOAM531iU5uGDAApC24tqkOqZHgcJvpGw4YgR2fDsl0No18TMSxL0h1O
        lVT8IPoMp2mskh3AVWa8QAGCOGhh4JtzWA==
X-Google-Smtp-Source: ABdhPJzWF/+YLbb8YQlYfbo9ySrHFfjMk/ow95h1OIOwtbJczccDo+PAk/42a+FOs/pxuavP2gQ4RQ==
X-Received: by 2002:a17:906:3b87:: with SMTP id u7mr1721897ejf.548.1623276456891;
        Wed, 09 Jun 2021 15:07:36 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-76.xnet.hr. [88.207.96.76])
        by smtp.googlemail.com with ESMTPSA id q16sm409770edt.26.2021.06.09.15.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:07:36 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/3] hwmon: (tps23861) correct shunt LSB values
Date:   Thu, 10 Jun 2021 00:07:28 +0200
Message-Id: <20210609220728.499879-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609220728.499879-1-robert.marko@sartura.hr>
References: <20210609220728.499879-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current shunt LSB values got reversed during in the
original driver commit.

So, correct the current shunt LSB values according to
the datasheet.

This caused reading slightly skewed current values.

Fixes: fff7b8ab2255 ("hwmon: add Texas Instruments TPS23861 driver")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/hwmon/tps23861.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index c3685b7e9e82..8bd6435c13e8 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -105,8 +105,8 @@
 #define TEMPERATURE_LSB			652 /* 0.652 degrees Celsius */
 #define VOLTAGE_LSB			3662 /* 3.662 mV */
 #define SHUNT_RESISTOR_DEFAULT		255000 /* 255 mOhm */
-#define CURRENT_LSB_255			62260 /* 62.260 uA */
-#define CURRENT_LSB_250			61039 /* 61.039 uA */
+#define CURRENT_LSB_250			62260 /* 62.260 uA */
+#define CURRENT_LSB_255			61039 /* 61.039 uA */
 #define RESISTANCE_LSB			110966 /* 11.0966 Ohm*/
 #define RESISTANCE_LSB_LOW		157216 /* 15.7216 Ohm*/
 
-- 
2.31.1

