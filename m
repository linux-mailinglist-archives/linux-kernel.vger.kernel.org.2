Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2070B3B2828
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhFXHH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:07:58 -0400
Received: from m12-16.163.com ([220.181.12.16]:55212 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230082AbhFXHH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zjkqQ
        N52wzFdh750Vozx5cE+u6eZ1+BH6TyLQ1QVPtI=; b=lSsRdTTkxlREONmj3Hwat
        lZGIQA2yOC1NXlyhRL/D93Fg6/ZTmjkFguOJTL6o2e8Uvzw7l2EbnbMhNZ8/b7/e
        hsBu7b5XOpYYjTurtnDNk8BXdl6W5o4j57eLLjsGF+YWZulaA/QWmeOtFuls3A/y
        tmf1JQEvy1fkkDVYbjbjUw=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp12 (Coremail) with SMTP id EMCowAAHDlqPLtRgfXzjyw--.24430S2;
        Thu, 24 Jun 2021 15:04:48 +0800 (CST)
From:   13145886936@163.com
To:     tglx@linutronix.de, bp@alien8.de, x86@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] x86: eas should not be NULL when it is referenced
Date:   Thu, 24 Jun 2021 00:04:42 -0700
Message-Id: <20210624070442.34291-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAAHDlqPLtRgfXzjyw--.24430S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtry3uFW3tFy5GFy7KFyDKFg_yoW3Krg_GF
        nrZws3JrWSvr4Fq340yFnIgrnru3yIv3yfWwnYqFZ7try5JF4UCF1vqrykK34Sqr4kJFZ8
        A3s8Cr1Fqr12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU59Xo7UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/1tbiXBC7g1Xl0EcB3QAAsP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

"eas" should not be NULL when it is referenced.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 arch/x86/events/intel/uncore_snbep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index bb6eb1e5569c..836aa78cd0f3 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3826,8 +3826,10 @@ pmu_iio_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 
 	return 0;
 err:
-	for (; die >= 0; die--)
-		kfree(eas[die].attr.attr.name);
+	if (eas) {
+		for (; die >= 0; die--)
+			kfree(eas[die].attr.attr.name);
+	}
 	kfree(eas);
 	kfree(attrs);
 	kfree(type->topology);
-- 
2.25.1


