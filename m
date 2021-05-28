Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711B2393E79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhE1IOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbhE1IOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:14:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D76C061574;
        Fri, 28 May 2021 01:13:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v13so1259528ple.9;
        Fri, 28 May 2021 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21xAaUHWeHof2ecP/y/d30huoLiokvMxn5AYQcuGXfg=;
        b=YuNG0cSnJzP07WQH1cBbi/A+4+mjzR3qehA/1Mv7hmmSGLgeHWMmEu8F7RVgdM7qVx
         mprinDFWUuLOVsQyAnS74xwQNRJXdIS97S87KcynFgYCSKidRKtt7/JzlH4DYeVJfQMR
         cfYtRa5bCFUz0lNu3FclM9I9B1ogqM/H8ub9J9hrI7e8N2DN607JOOVLyK+ZaKznQR61
         ehamUCFqbnOEKprduupYQSKLc/B74TYVdp+UkJzfbffvradmooQlXk2qDxWbefTGEwU5
         kUm/cLT4uRP6AAsPkL0DWGdXf3Zlay5NsdAzTXJ5iQ775k5IMOJ4Tq5AqPfkvJdYRSCj
         fJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21xAaUHWeHof2ecP/y/d30huoLiokvMxn5AYQcuGXfg=;
        b=M52JjSYzvsmnVgx3VtbOw4EJtbtpU1NW40IeBFy0Bg3Il0WT1FONPUb2IKcvR8lI8+
         gRDS/dlSS0eJvJNQ7WiAIkJAztkZrDYssTFAghlsBn12nPWrBLgl5stGsk4caI/0eKRq
         5YrHwJnluZMAhB5HEpg/SwlfOtMrzFz46F08V925dWSWZBsoYjCX2reY9mFZSOPu1qu6
         Iz54tsziD39fxaz1Yz9+DQKek9qm06kcU8wu64pB7tpPNz1n320VWCq+3+SCcpOQ19U7
         TWR9LT7Mcqtku6Djk6AOPb1EbvtMkHe1HRnQVyiG842bpzgOstHDkI4EuKFynnTZJQB9
         ZIYw==
X-Gm-Message-State: AOAM532xTsQI1knq0PphiJZTQZrqWPBttztZadZcSjuu5rAPPnSC3vBy
        JfvpnrMv2ptS8fF0ds4S3mw=
X-Google-Smtp-Source: ABdhPJyyvweGFW8Eh8bd+eKcXVC2wzxMqNaQ8UYzWiDHmVDfiTCarncao5MD1si6ap7/KLnwBjFjtg==
X-Received: by 2002:a17:902:d2c5:b029:f1:c207:b0fd with SMTP id n5-20020a170902d2c5b02900f1c207b0fdmr6965759plc.45.1622189593759;
        Fri, 28 May 2021 01:13:13 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46b:3194:b541:419e:4878:8a93])
        by smtp.gmail.com with ESMTPSA id z18sm3846594pfc.23.2021.05.28.01.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 01:13:13 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        inux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: [PATCH v5 1/3] lib: add linear range get selector within
Date:   Fri, 28 May 2021 16:12:58 +0800
Message-Id: <20210528081300.64759-2-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528081300.64759-1-gene.chen.richtek@gmail.com>
References: <20210528081300.64759-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add linear range get selector within for choose closest selector
between minimum and maximum selector.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 include/linux/linear_range.h |  2 ++
 lib/linear_ranges.c          | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/linear_range.h b/include/linux/linear_range.h
index 17b5943727d5..fd3d0b358f22 100644
--- a/include/linux/linear_range.h
+++ b/include/linux/linear_range.h
@@ -41,6 +41,8 @@ int linear_range_get_selector_low(const struct linear_range *r,
 int linear_range_get_selector_high(const struct linear_range *r,
 				   unsigned int val, unsigned int *selector,
 				   bool *found);
+void linear_range_get_selector_within(const struct linear_range *r,
+				      unsigned int val, unsigned int *selector);
 int linear_range_get_selector_low_array(const struct linear_range *r,
 					int ranges, unsigned int val,
 					unsigned int *selector, bool *found);
diff --git a/lib/linear_ranges.c b/lib/linear_ranges.c
index ced5c15d3f04..a1a7dfa881de 100644
--- a/lib/linear_ranges.c
+++ b/lib/linear_ranges.c
@@ -241,5 +241,36 @@ int linear_range_get_selector_high(const struct linear_range *r,
 }
 EXPORT_SYMBOL_GPL(linear_range_get_selector_high);
 
+/**
+ * linear_range_get_selector_within - return linear range selector for value
+ * @r:		pointer to linear range where selector is looked from
+ * @val:	value for which the selector is searched
+ * @selector:	address where found selector value is updated
+ *
+ * Return selector for which range value is closest match for given
+ * input value. Value is matching if it is equal or lower than given
+ * value. But return maximum selector if given value is higher than
+ * maximum value.
+ */
+void linear_range_get_selector_within(const struct linear_range *r,
+				      unsigned int val, unsigned int *selector)
+{
+	if (r->min > val) {
+		*selector = r->min_sel;
+		return;
+	}
+
+	if (linear_range_get_max_value(r) < val) {
+		*selector = r->max_sel;
+		return;
+	}
+
+	if (r->step == 0)
+		*selector = r->min_sel;
+	else
+		*selector = (val - r->min) / r->step + r->min_sel;
+}
+EXPORT_SYMBOL_GPL(linear_range_get_selector_within);
+
 MODULE_DESCRIPTION("linear-ranges helper");
 MODULE_LICENSE("GPL");
-- 
2.25.1

