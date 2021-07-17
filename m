Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E7C3CC24F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 11:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhGQKBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 06:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231716AbhGQKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 06:01:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2726613D9;
        Sat, 17 Jul 2021 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626515903;
        bh=TrKiNGG3MVrXPbPPtaEXCeirrwTh8HLZ1ZlEna+hyoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqA7T2VWNlgMpC0qYZYNdqeC9+v4mBOD25BZ5d6AWb9ZCrfk8vCTUCjxcGApvhEVj
         dc63lOwLlxh3HF9KUpv9fTYA3rEEkrkcbNhd6pTQEnteF++SNHUixIERmS684rH/+f
         GLVEmKuTjTBEgNJVEMHUlje27OUqbNtAT6qZgqSBQnZrn0gJiBOesqH0qPAEsul0y6
         a1IhZaGWUhyvBzRUL0HTA+Ggui343N1S7DkOpc7Awi9otEwJz4k4KDSeehJeZZIwCz
         /DzTuVuLpjT3P7SJcnd6XZwAD4bugpri3mwPoaaLky4WOfBRM69AkhbY3VUDTTkF3a
         JQ1KmSb4P5nHg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m4h5S-0007KK-1Z; Sat, 17 Jul 2021 11:58:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v14 6/9] staging: hisilicon,hi6421-spmi-pmic.yaml: fix patternProperties
Date:   Sat, 17 Jul 2021 11:58:17 +0200
Message-Id: <46b2f30df235481cb1404913380e45706dfd8253.1626515862.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626515862.git.mchehab+huawei@kernel.org>
References: <cover.1626515862.git.mchehab+huawei@kernel.org>
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
index 63f49080001d..cedf9d99a34b 100644
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
@@ -39,6 +39,8 @@ properties:
   regulators:
     type: object
 
+    additionalProperties: false
+
     properties:
       '#address-cells':
         const: 1
@@ -47,11 +49,13 @@ properties:
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

