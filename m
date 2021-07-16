Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C857E3CB56B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhGPJrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhGPJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:47:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC0EC061762;
        Fri, 16 Jul 2021 02:44:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j199so8457484pfd.7;
        Fri, 16 Jul 2021 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21xAaUHWeHof2ecP/y/d30huoLiokvMxn5AYQcuGXfg=;
        b=PkF4Bg+X6thh6odEagABVHDS93zgXLYDVuXIgHLpLRgWKl2eO6mUsHpQDJR0S/TR28
         GTdWg7Vk9m1FrDcL6LfpBkfCt4r3G8kwVlaaXs5jOgKAsMmxCa1aawox/6i0KWccDA2T
         s+qMhsESxwmJLgdDY+QRH5Rv/s3Sa76UIS8JoQo9JVsV1al97fXBhXnK+nlNorvShxxq
         mjQGjCoivVoCawVYwFAN4U5DovjTXqBw/LpjcPfLtBLXO/RCbHWZkQtIg0n+hM/rLrX1
         +prcbMatEmrETpXuir6be+pMXM4cLoeNW8xwzeHD2zr/gLIbTmDgL2m9RQKBAs+j9z7f
         bhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21xAaUHWeHof2ecP/y/d30huoLiokvMxn5AYQcuGXfg=;
        b=tHST1nZmOPlgReONF1OaQYz5VyBSz7/RmT2l5oz/C8/m89cQrslJwSXZBI5nuRig/G
         WjNuVs8snxsEgJStFfet2iRFQysrqCZzCAut7WDTj0N5JxRKMX9gE609YTbvxo7WX6FZ
         H20DrXKAPFU9c/DznlZ6IRHzmwRz2TAIm7Ti0NyHN2h3HdWgAe4aPF/zuCR/QZbm9zoo
         3b6+DHq+76bgtSKqlwAu1t0IpS9aePreii0jck7NQphp1IOVNay6VvsiKtk3WXFf4830
         IwnjnuXUdL31RTJLHIfoRZcP6Lg7Ily7Yj1/li6FJ3KJLLTDadZepN1OhyWwkecvNW/7
         cxeA==
X-Gm-Message-State: AOAM533TpB1uzoxGm3+H4fNV+AmsvmySmSsoG77A2f/S8s1XtRIBt0n8
        VPBz/20y4CHHHH8HvUgnz6k=
X-Google-Smtp-Source: ABdhPJxGn610wcvIiaFktkXpBqAtlLzue4VdsC1KNppymkvBjMHE8VESjy/S1QW4XHusNkvKXdh/pw==
X-Received: by 2002:a63:9d46:: with SMTP id i67mr9152288pgd.225.1626428646322;
        Fri, 16 Jul 2021 02:44:06 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id m21sm9508800pfo.159.2021.07.16.02.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 02:44:06 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        inux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 1/3] lib: add linear range get selector within
Date:   Fri, 16 Jul 2021 17:43:51 +0800
Message-Id: <20210716094353.140536-2-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716094353.140536-1-gene.chen.richtek@gmail.com>
References: <20210716094353.140536-1-gene.chen.richtek@gmail.com>
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

