Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F20410BE7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 16:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhISOfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 10:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232248AbhISOfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 10:35:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14CEE61242;
        Sun, 19 Sep 2021 14:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632062022;
        bh=EGb7aFL1cbaippKD8ab9xqV+1S9s3vTtwRNulkkuGfQ=;
        h=From:To:Cc:Subject:Date:From;
        b=sCCk28EjmpnNDzwLKVOD1q5FkLVgJnBDjWWGc1pH3F2lgHSqrwwh+G1mKY1Ui3UTT
         11dTw8ZyewlgI2DmbCn5Mu7F175vCJxymWYwQa0AXxEGchxsjBQu2GEMww2Relfl1M
         zh4p3wrr/V0dMqnEjpnHBLeQvYx1So65Tzi3aPTTbDNi1k9UK9JCe+td3pOhKCiwdI
         YO/vEokbephkm8qnul5W6Uv2uCYtB/UEDJ8t7G8KjAtf0KPtoUviqqaFVYSuvtAh+/
         LA4MoCAH2oVrUaa1eCFqNXh4klbOb9p+WViloLaKwVKvkPuQ+1jdriks2nz9eLijwu
         BnzqBfNlRD1XQ==
Received: by pali.im (Postfix)
        id 93E3F879; Sun, 19 Sep 2021 16:33:39 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: arm: marvell: Add 88F6040 model into list
Date:   Sun, 19 Sep 2021 16:33:27 +0200
Message-Id: <20210919143327.24289-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/arm/marvell.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index 56bb592dbd0c..f9b09b06e1d6 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -212,6 +212,7 @@ EBU Armada family ARMv8
 	arch/arm64/boot/dts/marvell/armada-37*
 
   Armada 7K Flavors:
+	  - 88F6040 (AP806 Quad 600 MHz + one CP110)
 	  - 88F7020 (AP806 Dual + one CP110)
 	  - 88F7040 (AP806 Quad + one CP110)
 
-- 
2.20.1

