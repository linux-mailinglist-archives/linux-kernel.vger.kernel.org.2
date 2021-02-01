Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C991030AF59
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhBASb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbhBASPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:16 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBB2C0617AA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:05 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gx20so88514pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gd0PQfLiLT7Acbpyo/XJTh4r8nkghnLD/diEbX5F5ZQ=;
        b=B59LKz+MwWXqeMaL+5RpXeL576dApBmts5cfHft/pgZF3G6rPGK2NqQEieM7CySch5
         E99UnO2+6U5BB6sCasWYqSzOM2T+ED6cuA35DgHYnzQ1RRrmj8E3jHuQ9RcmOjZU3xlq
         qBCvFXHOQHsuSpiIKeJM+UnT3pvuwmaDP2WwFcXRw24ifFNOxIAWZx172yXGAAQ/5cGk
         YYuM4Yo0DUqsritpjuj4LpT6hHzNrKYNQmMBn5SLoY7bP3E/EdnaWPupQYtyuvbykxm2
         lRq9qXOu38qsSFcKm5FNqxNXqlbOinuMGMN0T2hrI5lFWCHtcG72nWw0P6qoWf8MO03j
         rUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gd0PQfLiLT7Acbpyo/XJTh4r8nkghnLD/diEbX5F5ZQ=;
        b=AEubzNESMMlyTXFXK1nG+T6G4h7FOBATOz7JwlS+Ttc4pPp8PePlG6Nw4XL0Hn9pWx
         VoDWBwXp0JKG7DUV39DukLXCpsh3MSlOjgbTK6Rm8X327WGh51HsKB9PODmThCISW2Q4
         noRkcDWNDQD476xFoDxUr84shgRBHe5S2NER4zs2f+a6hC4bZA8WtkBNyvK0HnbhXLTb
         CXPwlFwtKHFXox/5R+OVn5z18AcDMt0HUSRyUZfNrCT+8lVXJ4PaUPJaUsxWSPNRQH8q
         rkoln9+Nl+rpf2MFO6KdpDngeg3mbnRL2QyNUnK8/d+Kwg5YLQO/COAFz/HRfVuI4o4N
         ICDg==
X-Gm-Message-State: AOAM532NwEAeiMYjSGz0NZUBMKUor8/CXHBbeO7lYIjqfyCMhH2EKvaD
        aVVpwZVKWYzifll5Nc5ZRfVf3w==
X-Google-Smtp-Source: ABdhPJwxLQyX2AF7jmnsqAcCgLAnHPeWdsKBKaRupGzJYOyPlnPuxZVvTC/mN5/PlsIcgdWVbG8SHQ==
X-Received: by 2002:a17:90b:e8b:: with SMTP id fv11mr127682pjb.5.1612203245395;
        Mon, 01 Feb 2021 10:14:05 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:04 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/31] coresight: etm4x: Make offset available for sysfs attributes
Date:   Mon,  1 Feb 2021 11:13:31 -0700
Message-Id: <20210201181351.1475223-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Some of the ETM management registers are not accessible via
system instructions. Thus we need to filter accesses to these
registers depending on the access mechanism for the ETM at runtime.
The driver can cope with this for normal operation, by regular
checks. But the driver also exposes them via sysfs, which now
needs to be removed.

So far, we have used the generic coresight sysfs helper macros
to export a given device register, defining a "show" operation
per register. This is not helpful to filter the files at runtime,
based on the access.

In order to do this dynamically, we need to filter the attributes
by offsets and hard coded "show" functions doesn't make this easy.
Thus, switch to extended attributes, storing the offset in the scratch
space. This allows us to implement filtering based on the offset and
also saves us some text size. This will be later used for determining
a given attribute must be "visible" via sysfs.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-10-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-sysfs.c         | 115 +++++++++---------
 1 file changed, 57 insertions(+), 58 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index fce9df16bfb5..ddbfeb24fc3f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2331,9 +2331,8 @@ static void do_smp_cross_read(void *data)
 	reg->data = etm4x_relaxed_read32(&reg->csdev->access, reg->offset);
 }
 
-static u32 etmv4_cross_read(const struct device *dev, u32 offset)
+static u32 etmv4_cross_read(const struct etmv4_drvdata *drvdata, u32 offset)
 {
-	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
 	struct etmv4_reg reg;
 
 	reg.offset = offset;
@@ -2347,69 +2346,69 @@ static u32 etmv4_cross_read(const struct device *dev, u32 offset)
 	return reg.data;
 }
 
-#define coresight_etm4x_cross_read(name, offset)			\
-	coresight_simple_func(struct etmv4_drvdata, etmv4_cross_read,	\
-			      name, offset)
-
-coresight_etm4x_cross_read(trcpdcr, TRCPDCR);
-coresight_etm4x_cross_read(trcpdsr, TRCPDSR);
-coresight_etm4x_cross_read(trclsr, TRCLSR);
-coresight_etm4x_cross_read(trcauthstatus, TRCAUTHSTATUS);
-coresight_etm4x_cross_read(trcdevid, TRCDEVID);
-coresight_etm4x_cross_read(trcdevtype, TRCDEVTYPE);
-coresight_etm4x_cross_read(trcpidr0, TRCPIDR0);
-coresight_etm4x_cross_read(trcpidr1, TRCPIDR1);
-coresight_etm4x_cross_read(trcpidr2, TRCPIDR2);
-coresight_etm4x_cross_read(trcpidr3, TRCPIDR3);
-coresight_etm4x_cross_read(trcoslsr, TRCOSLSR);
-coresight_etm4x_cross_read(trcconfig, TRCCONFIGR);
-coresight_etm4x_cross_read(trctraceid, TRCTRACEIDR);
+static inline u32 coresight_etm4x_attr_to_offset(struct device_attribute *attr)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr = container_of(attr, struct dev_ext_attribute, attr);
+	return (u32)(unsigned long)eattr->var;
+}
+
+static ssize_t coresight_etm4x_reg_show(struct device *dev,
+					struct device_attribute *d_attr,
+					char *buf)
+{
+	u32 val, offset;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	offset = coresight_etm4x_attr_to_offset(d_attr);
+
+	pm_runtime_get_sync(dev->parent);
+	val = etmv4_cross_read(drvdata, offset);
+	pm_runtime_put_sync(dev->parent);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);
+}
+
+#define coresight_etm4x_reg(name, offset)				\
+	&((struct dev_ext_attribute[]) {				\
+	   {								\
+		__ATTR(name, 0444, coresight_etm4x_reg_show, NULL),	\
+		(void *)(unsigned long)offset				\
+	   }								\
+	})[0].attr.attr
 
 static struct attribute *coresight_etmv4_mgmt_attrs[] = {
-	&dev_attr_trcoslsr.attr,
-	&dev_attr_trcpdcr.attr,
-	&dev_attr_trcpdsr.attr,
-	&dev_attr_trclsr.attr,
-	&dev_attr_trcconfig.attr,
-	&dev_attr_trctraceid.attr,
-	&dev_attr_trcauthstatus.attr,
-	&dev_attr_trcdevid.attr,
-	&dev_attr_trcdevtype.attr,
-	&dev_attr_trcpidr0.attr,
-	&dev_attr_trcpidr1.attr,
-	&dev_attr_trcpidr2.attr,
-	&dev_attr_trcpidr3.attr,
+	coresight_etm4x_reg(trcpdcr, TRCPDCR),
+	coresight_etm4x_reg(trcpdsr, TRCPDSR),
+	coresight_etm4x_reg(trclsr, TRCLSR),
+	coresight_etm4x_reg(trcauthstatus, TRCAUTHSTATUS),
+	coresight_etm4x_reg(trcdevid, TRCDEVID),
+	coresight_etm4x_reg(trcdevtype, TRCDEVTYPE),
+	coresight_etm4x_reg(trcpidr0, TRCPIDR0),
+	coresight_etm4x_reg(trcpidr1, TRCPIDR1),
+	coresight_etm4x_reg(trcpidr2, TRCPIDR2),
+	coresight_etm4x_reg(trcpidr3, TRCPIDR3),
+	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
+	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
+	coresight_etm4x_reg(trctraceid, TRCTRACEIDR),
 	NULL,
 };
 
-coresight_etm4x_cross_read(trcidr0, TRCIDR0);
-coresight_etm4x_cross_read(trcidr1, TRCIDR1);
-coresight_etm4x_cross_read(trcidr2, TRCIDR2);
-coresight_etm4x_cross_read(trcidr3, TRCIDR3);
-coresight_etm4x_cross_read(trcidr4, TRCIDR4);
-coresight_etm4x_cross_read(trcidr5, TRCIDR5);
-/* trcidr[6,7] are reserved */
-coresight_etm4x_cross_read(trcidr8, TRCIDR8);
-coresight_etm4x_cross_read(trcidr9, TRCIDR9);
-coresight_etm4x_cross_read(trcidr10, TRCIDR10);
-coresight_etm4x_cross_read(trcidr11, TRCIDR11);
-coresight_etm4x_cross_read(trcidr12, TRCIDR12);
-coresight_etm4x_cross_read(trcidr13, TRCIDR13);
-
 static struct attribute *coresight_etmv4_trcidr_attrs[] = {
-	&dev_attr_trcidr0.attr,
-	&dev_attr_trcidr1.attr,
-	&dev_attr_trcidr2.attr,
-	&dev_attr_trcidr3.attr,
-	&dev_attr_trcidr4.attr,
-	&dev_attr_trcidr5.attr,
+	coresight_etm4x_reg(trcidr0, TRCIDR0),
+	coresight_etm4x_reg(trcidr1, TRCIDR1),
+	coresight_etm4x_reg(trcidr2, TRCIDR2),
+	coresight_etm4x_reg(trcidr3, TRCIDR3),
+	coresight_etm4x_reg(trcidr4, TRCIDR4),
+	coresight_etm4x_reg(trcidr5, TRCIDR5),
 	/* trcidr[6,7] are reserved */
-	&dev_attr_trcidr8.attr,
-	&dev_attr_trcidr9.attr,
-	&dev_attr_trcidr10.attr,
-	&dev_attr_trcidr11.attr,
-	&dev_attr_trcidr12.attr,
-	&dev_attr_trcidr13.attr,
+	coresight_etm4x_reg(trcidr8, TRCIDR8),
+	coresight_etm4x_reg(trcidr9, TRCIDR9),
+	coresight_etm4x_reg(trcidr10, TRCIDR10),
+	coresight_etm4x_reg(trcidr11, TRCIDR11),
+	coresight_etm4x_reg(trcidr12, TRCIDR12),
+	coresight_etm4x_reg(trcidr13, TRCIDR13),
 	NULL,
 };
 
-- 
2.25.1

