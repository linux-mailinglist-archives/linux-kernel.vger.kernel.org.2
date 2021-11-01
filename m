Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF68644156B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhKAIk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhKAIk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:40:56 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3122DC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 01:38:21 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id b17so7286315qvl.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W5iL3+eoKbS84xTEyR7TxVppPMdNEFILvD0eLgKwoyA=;
        b=BO4tHqfgPWBckmR3BGljghc03Dkez06FoZwf63r9USLkffnp3ZSRyqDn3IJxevxfvP
         GLMWbDQENmi/MsOZhT4BuSMbfddqr8Jv3m3Jqo9Cc59a+dorJ73sw4wf2gil9TGwfANp
         4uWoQ9c2hjrO5bIE+w9jVT6T/wbA/BFcsszjmbUMTKTbLh4QasOPtkkqYRL0O8TllejL
         P4JlAUejGSdmNh6vjbKtFHPSGsOTBPai3sNQgRaLxNuM4G9+Jlz+kQ3FFJZ5fowMqnoe
         o10O9LC852g0ozBaOxslajzhRrRrTUXfQ5hlbLd4d6j+/Az1WnhNEfqizTyN23ng8uQP
         tPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W5iL3+eoKbS84xTEyR7TxVppPMdNEFILvD0eLgKwoyA=;
        b=DxmYp3B2PaDEhtYKE3HJu/ij4nhNazWZLBXw5mTHAISq06hWVC2d9r4sKJLrrITWgb
         kMSvbaZVGsteZLyHnYA7w2ST7A8ToBxIQrQZ66EPxEJApCCho+9evXyIUgk5D33Fe1Kg
         H2l7JGtl6VBRaKWJJa+UBsHleu5dP39gV/o6cH8h6IGyRpDCoqQrqe4SMQgDTLqr7jjt
         jzhBG5ymTuYlF7UjMoWpgj1qGpqW4J+16lTs3t6vaKUYT3TTXlM6orcOHeUd+1fcYHsy
         GTZXzcxk2Wwnh7FVOu4VWsgdY/tnj108I+PZo7+ImbGmpYN8Tx9i2V2oK6UmjWznOLW4
         Q7AQ==
X-Gm-Message-State: AOAM5316WrDSVeqtAzIhg9EnKJ+U9lw7Ej596HZI14uw+NHs8rQt85mU
        nsWg0gcPX4uG4HEBLwZjb1zPTel5UCM=
X-Google-Smtp-Source: ABdhPJy25NpiKSYb9rWTo6sa7VoH9zlUk+yd7HUg11Tpp9dmCOLbcLjamRN3F8jqQv60+wFHCLiFiw==
X-Received: by 2002:ad4:5dce:: with SMTP id m14mr26446985qvh.29.1635755900171;
        Mon, 01 Nov 2021 01:38:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k19sm3203354qta.82.2021.11.01.01.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 01:38:19 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     deng.changcheng@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] most: replace scnprintf in show functions with sysfs_emit
Date:   Mon,  1 Nov 2021 08:38:09 +0000
Message-Id: <20211101083809.36406-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the coccicheck warning:
./drivers/most/most_usb.c: 834: 9-17: WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/most/most_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 2640c5b326a4..0760fd141e4a 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -830,7 +830,7 @@ static ssize_t value_show(struct device *dev, struct device_attribute *attr,
 	int err;
 
 	if (sysfs_streq(name, "arb_address"))
-		return snprintf(buf, PAGE_SIZE, "%04x\n", dci_obj->reg_addr);
+		return sysfs_emit(buf, "%04x\n", dci_obj->reg_addr);
 
 	if (sysfs_streq(name, "arb_value"))
 		reg_addr = dci_obj->reg_addr;
-- 
2.25.1

