Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F019394231
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhE1LxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:53:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41062 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbhE1LxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:53:08 -0400
Received: from mail-ua1-f70.google.com ([209.85.222.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmb1Z-00044F-9f
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 11:51:33 +0000
Received: by mail-ua1-f70.google.com with SMTP id f15-20020a9f2bcf0000b02901f8fe91b89cso1829398uaj.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 04:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDDdDO5zT/FpNTH0UFvF0auYibTyw8ssCiY7hlTfIzE=;
        b=fpmsPZuXcffJNdNMZslcD4w55su64k5sCjFsxqz/Tn+U8UJsGq9sU+uSChd17mjErB
         /O4r52Kqv0J1cG7Hi7c+q7rbx5JxXhoxul2eFHOrP9bIY7hDQnuem3R5h8rRxNNDYtpu
         BKjJlrLlLuL9onOun8lvXTa/bgWFgCcWlVmXSDWnBctM741kb8uRHw+BBToysHJ1gJ/+
         QDAU+dF2ItnKzp3Q49dRsZ2Rim94zP6WTQ914IBfMgOT+0sJZAxeD8DoDBDEWngnZad9
         BRPYDbFSV12iq2ddi4MGuGAlN061FreYUBO9l7De4ORjT6PgWLc1PRhkL+G3yAOjWPCS
         mHqw==
X-Gm-Message-State: AOAM533Aozq5okFWLquZjDPkcxxYV1Oc9jtEVbiouspyW5LTXWqI8sDk
        9hj1TMBsfpI1xM56W6aFkGjzTWTo3YZlx6aB+R+8+M4+U9ikwwb5ljRDfkT+mIlqnlrjj9OWiPG
        d4W2To2NMz56ftON5awwnP/rFft5FvebxbvdcKc88WA==
X-Received: by 2002:ab0:356f:: with SMTP id e15mr2357763uaa.52.1622202692261;
        Fri, 28 May 2021 04:51:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi3BVn9RTHeqdJR/hqXHbAjq5i1bbLsv6dv1NoE6k/rYs7s/3DgGEJnIp6q5kA0YP8RgPKUw==
X-Received: by 2002:ab0:356f:: with SMTP id e15mr2357754uaa.52.1622202692127;
        Fri, 28 May 2021 04:51:32 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id 34sm657900vkn.53.2021.05.28.04.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:51:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [RESEND PATCH] mfd: Add missing of_node_put for loop iteration
Date:   Fri, 28 May 2021 07:51:26 -0400
Message-Id: <20210528115126.18370-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early exits from for_each_child_of_node() should decrement the
node reference counter.  Reported by Coccinelle:

  drivers/mfd/mfd-core.c:197:2-24: WARNING:
    Function "for_each_child_of_node" should have of_node_put() before goto around lines 209.

Fixes: c94bb233a9fe ("mfd: Make MFD core code Device Tree and IRQ domain aware")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/mfd-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 79f5c6a18815..684a011a6396 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -198,6 +198,7 @@ static int mfd_add_device(struct device *parent, int id,
 			if (of_device_is_compatible(np, cell->of_compatible)) {
 				/* Ignore 'disabled' devices error free */
 				if (!of_device_is_available(np)) {
+					of_node_put(np);
 					ret = 0;
 					goto fail_alias;
 				}
@@ -205,6 +206,7 @@ static int mfd_add_device(struct device *parent, int id,
 				ret = mfd_match_of_node_to_dev(pdev, np, cell);
 				if (ret == -EAGAIN)
 					continue;
+				of_node_put(np);
 				if (ret)
 					goto fail_alias;
 
-- 
2.27.0

