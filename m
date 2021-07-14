Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47CA3C810B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbhGNJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238141AbhGNJP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:15:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67D14613B2;
        Wed, 14 Jul 2021 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626253985;
        bh=CvgsRWOvpdhYc2CPuXHiO8KmPrKQY0raxwB2Nd36tUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9cMCc2cJBYPljpqMDkwoetrYHG5ivgwEK3JamQWYeAbDJGM6pDI6geQtXLn6iLWI
         LtFFNdzLE5qA/vmIK8FGCQdACeYh+9FLzcvmZhvGEFyMa6DFPmr9Bf4vUv14EhuVcD
         7kxs3zSsAkiKK5vE+CcHeGj9GuJrqiLYMd0tV52JTcnhfJJoEjA/++bQKbgl0PgzC1
         QgD6CJFFOaTQ1u3NUExFmZOm4InkPwlQt/aM46P2y/mnEWdxFcvw8XpKgyOB1jEciF
         lNFHN/Rws+ll0HkIstST5wEK8Z6RV8QvLd4oB5TFNoyB+KKcEORmJsqAwn+UBK9UVC
         l15QOggRnoybA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m3awx-007q2b-Aw; Wed, 14 Jul 2021 11:13:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v13 6/9] staging: hisilicon,hi6421-spmi-pmic.yaml: fix patternProperties
Date:   Wed, 14 Jul 2021 11:12:58 +0200
Message-Id: <223da345b9f27d5e8f439b7d0594cb0128edcf16.1626253775.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626253775.git.mchehab+huawei@kernel.org>
References: <cover.1626253775.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regex at the patternProperties is wrong, although this was
not reported as the DT schema was not enforcing properties.

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
index a2963bea87ea..b06131504d75 100644
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
@@ -41,6 +41,8 @@ properties:
   regulators:
     type: object
 
+    additionalProperties: false
+
     properties:
       '#address-cells':
         const: 1
@@ -49,11 +51,13 @@ properties:
         const: 0
 
     patternProperties:
-      '^ldo[0-9]+@[0-9a-f]$':
+      '^(ldo|LDO)[0-9]+$':
         type: object
 
         $ref: "/schemas/regulator/regulator.yaml#"
 
+        unevaluatedProperties: false
+
 required:
   - compatible
   - reg
-- 
2.31.1

