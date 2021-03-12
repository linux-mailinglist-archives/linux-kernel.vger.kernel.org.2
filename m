Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F18339076
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhCLO4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:56:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231827AbhCLO4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:56:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7754864FE2;
        Fri, 12 Mar 2021 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615560963;
        bh=dxhHQ4+Tj25cN9LD5py5bcCli70KK9AazUdZGS4VzAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=BAMTp2ZwbkOUL+l7vDFjopGEW97mrBAo0hIf+MsUuLykpkFns1zI7Q1Vb7r/zGRJa
         t3agooFlZdJ/rx7cBckFj1vMGDG8lEuV85QzTq2Y0tmNBD/iXRMdnwgUB2/LkjFJZe
         kSouoo2BQ65GjT363HHRvtcDcDssx2Wmzu1rU6hdjF2VgWeR3e+djcKj7CJ3SCNthd
         q9Zom7r8/Imi00MQgs5s4Nc76rYTaPCEAH4KIiiB+z0vHPlXltaGArYF+qVgsJqm0I
         WAAe6X17qcyDREI4uk2Gmm1Mp/SxnrKkPL5ZbZ6kQ+M+v+PgdH4spgoQno4ziguhF/
         4GShn/t/uW1uw==
From:   matthias.bgg@kernel.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 1/7] dt-bindings: mfd: mediatek: Fix regulator description
Date:   Fri, 12 Mar 2021 15:55:39 +0100
Message-Id: <20210312145545.26050-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Having a separate compatible for the regulator node is redundant and not
needed. Delete the corresponding requierement.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---

 Documentation/devicetree/bindings/mfd/mt6397.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 2661775a38251..28a69728e6fe2 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -33,11 +33,8 @@ Optional subnodes:
 	For details, see ../rtc/rtc-mt6397.txt
 - regulators
 	Required properties:
-		- compatible: "mediatek,mt6323-regulator"
 	see ../regulator/mt6323-regulator.txt
-		- compatible: "mediatek,mt6358-regulator"
 	see ../regulator/mt6358-regulator.txt
-		- compatible: "mediatek,mt6397-regulator"
 	see ../regulator/mt6397-regulator.txt
 - codec
 	Required properties:
-- 
2.30.1

