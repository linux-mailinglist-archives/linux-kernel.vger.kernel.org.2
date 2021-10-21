Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D4B435FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhJULIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhJULIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:08:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B85C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:06:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u6so163021ple.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C6rC4fdbQUv8/KQ2zxz0/9Y2n848bAt+XoEZOMW8dKw=;
        b=Fm4qWATM2292BRHuf5t+F6ra1MxRxm6PWheZJWNfX7g6LQevdsYpF6nMIFPWR1lMqq
         Kj7kd/IJtJfhBrdBSChs/nzK3uQSNJhyPITOPUtT1YfdspFxSF8fCd3CDwAlLYzRbYFi
         x9e8Im+zL6xxi6VSrNwL6Xt+MZBaiMHzVA+EEk2XCcbfrP37emHUQgF3jcCinPZOxYIa
         g9CXiyC2F3nSuFN+FiBNbV4MxTuT5Sueis3MuOx+aBVd2F+TMM3akzYAhCWrSYXiKb8u
         li4xQlIi/nEhhy/+MICmQIAi8sQQT9XK7FQ4wTcuPmwz+eJ2MZ52TKieScCfwBg8XPqW
         hOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C6rC4fdbQUv8/KQ2zxz0/9Y2n848bAt+XoEZOMW8dKw=;
        b=USfmZmF0pZy/kazN8m61hskUez3XQ+36vlHD/dS5tLT9QBFnCSO9uHqtMCHjJYxCg+
         yFNvjz+hR8I3Db99Zvb69zzonqWLTvCKS/x5vFfLac1FyBHrnz8ntRBuKYlIwlljLjqi
         M2KaOVTCg+u3eURwGMbATLTSNA5tQmRXjANVzYMzgpuJ+CniHjvMhR7IVreTg3taf70t
         3x1ZQzPDZNqlcVy9TAUBQSuEqlqEalJ9+1ryPt6VRNojLeqqrBOhjipDAxkovamoi6KL
         GhtoltmL3DYKitTb6lEsvKc85OXLwy5Oa4ABqPXPjCrHjjeYNBwpjBFrGuhkA5e5EBE/
         h3Qg==
X-Gm-Message-State: AOAM531KASuap+4vs9r+x4dlirXCgOK3nEd5OwBUxnR0ydpTVBP1Ye8a
        9UruVMD1UQILqSrGza5K1GbZL+bELj4=
X-Google-Smtp-Source: ABdhPJyFK/rD8960L5354F0bbizuGHAXS5CvWk01rynNxygpo2vaU/12feZSofefCXv6kS2PneWE8A==
X-Received: by 2002:a17:90b:2382:: with SMTP id mr2mr5975071pjb.186.1634814384610;
        Thu, 21 Oct 2021 04:06:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j3sm5777308pfu.218.2021.10.21.04.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:06:24 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] char: ipmi: replace snprintf in show functions with sysfs_emit
Date:   Thu, 21 Oct 2021 11:06:08 +0000
Message-Id: <20211021110608.1060260-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING  use scnprintf or sprintf

Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 drivers/char/ipmi/ipmi_msghandler.c | 20 ++++++++++----------
 drivers/char/ipmi/ipmi_si_intf.c    |  8 ++++----
 drivers/char/ipmi/ipmi_ssif.c       |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index a60201d3f735..deed355422f4 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2716,7 +2716,7 @@ static ssize_t device_id_show(struct device *dev,
 	if (rv)
 		return rv;
 
-	return snprintf(buf, 10, "%u\n", id.device_id);
+	return sysfs_emit(buf, "%u\n", id.device_id);
 }
 static DEVICE_ATTR_RO(device_id);
 
@@ -2732,7 +2732,7 @@ static ssize_t provides_device_sdrs_show(struct device *dev,
 	if (rv)
 		return rv;
 
-	return snprintf(buf, 10, "%u\n", (id.device_revision & 0x80) >> 7);
+	return sysfs_emit(buf, "%u\n", (id.device_revision & 0x80) >> 7);
 }
 static DEVICE_ATTR_RO(provides_device_sdrs);
 
@@ -2747,7 +2747,7 @@ static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
 	if (rv)
 		return rv;
 
-	return snprintf(buf, 20, "%u\n", id.device_revision & 0x0F);
+	return sysfs_emit(buf, "%u\n", id.device_revision & 0x0F);
 }
 static DEVICE_ATTR_RO(revision);
 
@@ -2763,7 +2763,7 @@ static ssize_t firmware_revision_show(struct device *dev,
 	if (rv)
 		return rv;
 
-	return snprintf(buf, 20, "%u.%x\n", id.firmware_revision_1,
+	return sysfs_emit(buf, "%u.%x\n", id.firmware_revision_1,
 			id.firmware_revision_2);
 }
 static DEVICE_ATTR_RO(firmware_revision);
@@ -2780,7 +2780,7 @@ static ssize_t ipmi_version_show(struct device *dev,
 	if (rv)
 		return rv;
 
-	return snprintf(buf, 20, "%u.%u\n",
+	return sysfs_emit(buf, "%u.%u\n",
 			ipmi_version_major(&id),
 			ipmi_version_minor(&id));
 }
@@ -2798,7 +2798,7 @@ static ssize_t add_dev_support_show(struct device *dev,
 	if (rv)
 		return rv;
 
-	return snprintf(buf, 10, "0x%02x\n", id.additional_device_support);
+	return sysfs_emit(buf, "0x%02x\n", id.additional_device_support);
 }
 static DEVICE_ATTR(additional_device_support, S_IRUGO, add_dev_support_show,
 		   NULL);
@@ -2815,7 +2815,7 @@ static ssize_t manufacturer_id_show(struct device *dev,
 	if (rv)
 		return rv;
 
-	return snprintf(buf, 20, "0x%6.6x\n", id.manufacturer_id);
+	return sysfs_emit(buf, "0x%6.6x\n", id.manufacturer_id);
 }
 static DEVICE_ATTR_RO(manufacturer_id);
 
@@ -2831,7 +2831,7 @@ static ssize_t product_id_show(struct device *dev,
 	if (rv)
 		return rv;
 
-	return snprintf(buf, 10, "0x%4.4x\n", id.product_id);
+	return sysfs_emit(buf, "0x%4.4x\n", id.product_id);
 }
 static DEVICE_ATTR_RO(product_id);
 
@@ -2847,7 +2847,7 @@ static ssize_t aux_firmware_rev_show(struct device *dev,
 	if (rv)
 		return rv;
 
-	return snprintf(buf, 21, "0x%02x 0x%02x 0x%02x 0x%02x\n",
+	return sysfs_emit(buf, "0x%02x 0x%02x 0x%02x 0x%02x\n",
 			id.aux_firmware_revision[3],
 			id.aux_firmware_revision[2],
 			id.aux_firmware_revision[1],
@@ -2869,7 +2869,7 @@ static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
 	if (!guid_set)
 		return -ENOENT;
 
-	return snprintf(buf, UUID_STRING_LEN + 1 + 1, "%pUl\n", &guid);
+	return sysfs_emit(buf, "%pUl\n", &guid);
 }
 static DEVICE_ATTR_RO(guid);
 
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 6f3272b58ced..64dedb3ef8ec 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1603,7 +1603,7 @@ static ssize_t name##_show(struct device *dev,			\
 {									\
 	struct smi_info *smi_info = dev_get_drvdata(dev);		\
 									\
-	return snprintf(buf, 10, "%u\n", smi_get_stat(smi_info, name));	\
+	return sysfs_emit(buf, "%u\n", smi_get_stat(smi_info, name));	\
 }									\
 static DEVICE_ATTR_RO(name)
 
@@ -1613,7 +1613,7 @@ static ssize_t type_show(struct device *dev,
 {
 	struct smi_info *smi_info = dev_get_drvdata(dev);
 
-	return snprintf(buf, 10, "%s\n", si_to_str[smi_info->io.si_type]);
+	return sysfs_emit(buf, "%s\n", si_to_str[smi_info->io.si_type]);
 }
 static DEVICE_ATTR_RO(type);
 
@@ -1624,7 +1624,7 @@ static ssize_t interrupts_enabled_show(struct device *dev,
 	struct smi_info *smi_info = dev_get_drvdata(dev);
 	int enabled = smi_info->io.irq && !smi_info->interrupt_disabled;
 
-	return snprintf(buf, 10, "%d\n", enabled);
+	return sysfs_emit(buf, "%d\n", enabled);
 }
 static DEVICE_ATTR_RO(interrupts_enabled);
 
@@ -1646,7 +1646,7 @@ static ssize_t params_show(struct device *dev,
 {
 	struct smi_info *smi_info = dev_get_drvdata(dev);
 
-	return snprintf(buf, 200,
+	return sysfs_emit(buf,
 			"%s,%s,0x%lx,rsp=%d,rsi=%d,rsh=%d,irq=%d,ipmb=%d\n",
 			si_to_str[smi_info->io.si_type],
 			addr_space_to_str[smi_info->io.addr_space],
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 20d5af92966d..0c62e578749e 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1190,7 +1190,7 @@ static ssize_t ipmi_##name##_show(struct device *dev,			\
 {									\
 	struct ssif_info *ssif_info = dev_get_drvdata(dev);		\
 									\
-	return snprintf(buf, 10, "%u\n", ssif_get_stat(ssif_info, name));\
+	return sysfs_emit(buf, "%u\n", ssif_get_stat(ssif_info, name));\
 }									\
 static DEVICE_ATTR(name, S_IRUGO, ipmi_##name##_show, NULL)
 
@@ -1198,7 +1198,7 @@ static ssize_t ipmi_type_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, 10, "ssif\n");
+	return sysfs_emit(buf, "ssif\n");
 }
 static DEVICE_ATTR(type, S_IRUGO, ipmi_type_show, NULL);
 
-- 
2.25.1

