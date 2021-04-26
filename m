Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DFA36AF59
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhDZH6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:58:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:41280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233462AbhDZHxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:53:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8EF9EAF9A;
        Mon, 26 Apr 2021 07:52:19 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH v2] arm64: dts: ls1012a: enable PCIe on freeway board
Date:   Mon, 26 Apr 2021 09:52:11 +0200
Message-Id: <20210426075211.30467-1-ykaukab@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ls1012a-freeway board contains a M.2 2230 slot. Update the status of
pcei1 node to okay so that the pcie controller can be probed.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
index 6290e2f9de6a..e8562585d4ac 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
@@ -24,6 +24,10 @@ &i2c0 {
 	status = "okay";
 };
 
+&pcie1 {
+	status = "okay";
+};
+
 &qspi {
 	status = "okay";
 
-- 
2.26.2

