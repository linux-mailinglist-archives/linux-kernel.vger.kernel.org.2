Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E5F357145
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353984AbhDGQAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353988AbhDGQAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:00:20 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DA1C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:00:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nh5so7817890pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=coOtzj27Yebf37o5AMUnRYIVYeS6cfsp1xxfA349qYU=;
        b=rP2t6j4qxPAIr1WCjXuV0r1pFJ44M6KemfrPITng7AW/7ORoR5J680nnIjMbBtveKC
         anHhSjnx7knQoik/Bl6nXS7uzZX4nj0HW4vYuNbK9gtgOxnrdK+lHbBhAv780PbrMkJb
         DUjRBIub7R5yCUHx8kOXDVLtxLJIXYVsvIISyKq+1iDlztlsTgZ2wKALhyPiEosShZwk
         V15djAayQfdqfVMwC//KH0XEI8MkCgb/OjSB6ij8YmCJCNWSMjMBP9MGGgjSNzs0QBha
         25Umo/ojlIULBmaqyqZK2+mjSYPrrd+3xDXbHmLHm6WrIlG+RLPgtoSuddJ+RDvlmwGr
         qD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=coOtzj27Yebf37o5AMUnRYIVYeS6cfsp1xxfA349qYU=;
        b=O4fDGkJTVF5MjPtsIk21fD0dfmdbAl5enlK05RfQc7Tx3L2LHCqLQ0X2WLXY0p2NVX
         B/i3CsxNCSS5D/VnGrfcU4yrfnvzUHI3BGOjU3Bo3aL029jMTxovwP1A/7+B0nUJLevW
         iivnpaJxGwZDQcB6N+cM3vjDAIu/wb2/lav7p6H/Rh47k0d4Fq/Xq+1zwBoO8kK5+wQQ
         usNmpq3I3P0iSeRPrQNf5nfGLbuWvXyABRimgB8mrLDEHx3b3dz0vxlOIPqbuW0MvFrt
         7zL6KsERv4wSLcTMokHk5eCno3LhL+dUhuCv+XMk+v3Gb8n7M8hV32EsJZr+37GtarO9
         rZ+Q==
X-Gm-Message-State: AOAM530U1ZVvGQQjz3pGi2mUwBCgIgNS/dEIwxO0iTXq6+iFPtobdVra
        6P8yCqstgoHpecAVYK+EyXxunlWH3Rc8FQ==
X-Google-Smtp-Source: ABdhPJyG0ivbjdZM/65BdK2AlC/6+BBhRMjQd5m8pdJ4kyT+jXvOjMNeaEn2lkan2oqWaYF3fn5i7A==
X-Received: by 2002:a17:90a:f3d2:: with SMTP id ha18mr4128075pjb.214.1617811210544;
        Wed, 07 Apr 2021 09:00:10 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s22sm21464713pfe.150.2021.04.07.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:00:10 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] coresight: etm: perf: Make symbol 'format_attr_contextid' static
Date:   Wed,  7 Apr 2021 10:00:05 -0600
Message-Id: <20210407160007.418053-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407160007.418053-1-mathieu.poirier@linaro.org>
References: <20210407160007.418053-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The sparse tool complains as follows:

drivers/hwtracing/coresight/coresight-etm-perf.c:61:25: warning:
 symbol 'format_attr_contextid' was not declared. Should it be static?

This symbol is not used outside of coresight-etm-perf.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Link: https://lore.kernel.org/r/20210308123250.2417947-1-weiyongjun1@huawei.com
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 0f603b4094f2..bdbb77334329 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -58,7 +58,7 @@ static ssize_t format_attr_contextid_show(struct device *dev,
 	return sprintf(page, "config:%d\n", pid_fmt);
 }
 
-struct device_attribute format_attr_contextid =
+static struct device_attribute format_attr_contextid =
 	__ATTR(contextid, 0444, format_attr_contextid_show, NULL);
 
 static struct attribute *etm_config_formats_attr[] = {
-- 
2.25.1

