Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87AF3DB3A5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhG3Gab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbhG3GaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:30:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A1BC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 23:30:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mt6so13759937pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 23:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzDlSOdZWBlt4r0PCKAXsvwu2THC00Q/tjyRtcnCkig=;
        b=OOgZP6Oqb/0lQi+naETsZINCyn69JBX0KhAPYrUlGcNLUA9JofTT4VXgCmw19NSy0U
         cxYZB9l7EpUH0VLFoSVA2jccBk+9ILcdSGFV8eraPhsrwn3/KN2r2YVgbzVdiJX7+wb7
         07ZeajZsy4ISjS9LTSbml9mN6ZC7qw36D/76DwNqUcU1Y7rjRoVzh56fI+c6DGP8MDzq
         LzKvomG7pWJv2GFFYTKFcIihQnkyql7mqg+UxI7MFKTw9Yvi6G/DUs5t7FKlCKx3QNdd
         WpLZ8yp4glMlEJbC1FxC/YViPNoT6Z7kFs/n1dIq1RoB237TjAcL7EoXYc9vVHn/uVoy
         0K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzDlSOdZWBlt4r0PCKAXsvwu2THC00Q/tjyRtcnCkig=;
        b=k2RnIfelKnTlWekBmpPWFa/Co0eexPGD9V/69Z+sdXucwf/e54ZFkW7LkiQvLfzlAs
         p1BqVp5jQLrAQ9gug4H0a/kNkt1q7mvXKvBhUP9UR+04gDnew3cpqzwpm/16A67SwgPM
         HIih1HNLJ3T4mwRu870XTrKzOCl74GOhNPqBw9dwi9cyNqvhOu+EdDAL0c7CdExkpaUy
         0wo9pjTLEPL1koEaZimmB7e/dmQW3/EzPRPnBsuLF03w+R8XPw/GOUz7YRMDTIZ+uMbZ
         kRYasLsbiTJ5CrO8l0kKgkqdjZwYUzkgIfamVHcuXWIh7xn62/O7M1j/wHe52jtweylp
         P/tg==
X-Gm-Message-State: AOAM530tbVcTeXQoFBevGMZQxHKpo8ZD66thucEbB6qnvlw0wYeKHrZw
        uLIP7Z/5L7wb0gayxrCuzOc=
X-Google-Smtp-Source: ABdhPJyU3pq9iF2msSbUGcXAYJuUIGuZSubDIuzBrR+tD3BLD0bxGNeN5leV+0YBY5TlEErbEjIaZg==
X-Received: by 2002:a17:90a:5b17:: with SMTP id o23mr1374451pji.25.1627626619339;
        Thu, 29 Jul 2021 23:30:19 -0700 (PDT)
Received: from localhost.localdomain ([49.37.50.31])
        by smtp.gmail.com with ESMTPSA id g8sm937913pfu.30.2021.07.29.23.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 23:30:18 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH] char: ipmi: use DEVICE_ATTR helper macro
Date:   Fri, 30 Jul 2021 11:59:51 +0530
Message-Id: <20210730062951.84876-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open coding DEVICE_ATTR, use the helper macro
DEVICE_ATTR_RO to replace DEVICE_ATTR with 0444 octal
permissions.

This was detected as a part of checkpatch evaluation
investigating all reports of DEVICE_ATTR_RO warning
type.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 drivers/char/ipmi/ipmi_si_intf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 62929a3e397e..1cbc6a6a3ef4 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1605,7 +1605,7 @@ static ssize_t name##_show(struct device *dev,			\
 									\
 	return snprintf(buf, 10, "%u\n", smi_get_stat(smi_info, name));	\
 }									\
-static DEVICE_ATTR(name, 0444, name##_show, NULL)
+static DEVICE_ATTR_RO(name)
 
 static ssize_t type_show(struct device *dev,
 			 struct device_attribute *attr,
@@ -1615,7 +1615,7 @@ static ssize_t type_show(struct device *dev,
 
 	return snprintf(buf, 10, "%s\n", si_to_str[smi_info->io.si_type]);
 }
-static DEVICE_ATTR(type, 0444, type_show, NULL);
+static DEVICE_ATTR_RO(type);
 
 static ssize_t interrupts_enabled_show(struct device *dev,
 				       struct device_attribute *attr,
@@ -1626,8 +1626,7 @@ static ssize_t interrupts_enabled_show(struct device *dev,
 
 	return snprintf(buf, 10, "%d\n", enabled);
 }
-static DEVICE_ATTR(interrupts_enabled, 0444,
-		   interrupts_enabled_show, NULL);
+static DEVICE_ATTR_RO(interrupts_enabled);
 
 IPMI_SI_ATTR(short_timeouts);
 IPMI_SI_ATTR(long_timeouts);
@@ -1658,7 +1657,7 @@ static ssize_t params_show(struct device *dev,
 			smi_info->io.irq,
 			smi_info->io.slave_addr);
 }
-static DEVICE_ATTR(params, 0444, params_show, NULL);
+static DEVICE_ATTR_RO(params);
 
 static struct attribute *ipmi_si_dev_attrs[] = {
 	&dev_attr_type.attr,
-- 
2.28.0

