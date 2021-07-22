Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653283D2181
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhGVJTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231282AbhGVJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E22B6124B;
        Thu, 22 Jul 2021 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626948020;
        bh=kWygC16sLbe02fKl6pMFM67STwqkZ83b7YaJBxq4kqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDq2gCZ1VG0MRH+O6XXysqWPn0vmAzfQfLyop9zWSwgQTCDGmTHoz2098vEezphLe
         0J8cjVOjly5CsgULlF/9yyIkyacRzIzqXGWplef2BK4FfezR9bysvK9dwPstcVVDP/
         Vh7IoJmwv7eRC285o78hz7nuwWqJQLaV8dO16eqE7PgVCPhNpHncyi+zoJL6a/hk/d
         XQAvk/OYCXhrCSCohaFzZGFt2y5pYn2e+WMP5q2eTa3g9m9LHQRtxpde2jJqMWfRRb
         PRwEiIInhzqjch0x+nDcVkFp6tbsljbaqiWoTaKnApJq5OxQrFf4dCkGGrPqQ+2eZW
         wVt9NGDu+47TA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VV0-008mHx-4H; Thu, 22 Jul 2021 12:00:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] MAINTAINERS: update ti,sci.yaml reference
Date:   Thu, 22 Jul 2021 12:00:08 +0200
Message-Id: <c285b1d5308c13d3c888b4b97f713c5e6811c09a.1626947923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 5a9652f6994e ("dt-bindings: arm: keystone: Convert ti,sci to json schema")
renamed: Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
to: Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml.

Update its cross-reference accordingly.

Fixes: 5a9652f6994e ("dt-bindings: arm: keystone: Convert ti,sci to json schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9853e5154bd9..76236b2c1d7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18355,7 +18355,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
-F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
-- 
2.31.1

