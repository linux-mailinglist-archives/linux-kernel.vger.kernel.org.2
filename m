Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2485B34DE21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhC3CSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:18:03 -0400
Received: from segapp02.wistron.com ([103.200.3.19]:36572 "EHLO
        segapp04.wistron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230122AbhC3CRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:17:34 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2021 22:17:33 EDT
Received: from EXCHAPP02.whq.wistron (unknown [10.37.38.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by segapp04.wistron.com (MTA) with ESMTPS id 4F8Xtx1NKyzJvXF;
        Tue, 30 Mar 2021 10:09:13 +0800 (CST)
Received: from EXCHAPP03.whq.wistron (10.37.38.26) by EXCHAPP02.whq.wistron
 (10.37.38.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 30 Mar
 2021 10:09:09 +0800
Received: from gitserver.wistron.com (10.37.38.233) by EXCHAPP03.whq.wistron
 (10.37.38.26) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 30 Mar 2021 10:09:09 +0800
From:   Nichole Wang <Nichole_Wang@wistron.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <small84206@gmail.com>, <Ben_Pai@wistron.com>,
        Nichole Wang <Nichole_Wang@wistron.com>
Subject: [PATCH linux dev-5.2 v1] ARM-dts-aspeed-Add-Mihawk-GPIO-Line-Names
Date:   Tue, 30 Mar 2021 10:08:08 +0800
Message-ID: <20210330020808.830-1-Nichole_Wang@wistron.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A209195456C77E93CE25DE9BA20A1C537DD5B25BCA20237EE8026C67F0341C2F2000:8
X-OriginalId: qf12UA9Der031919
x-msw-jemd-newsletter: false
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wistron.com; s=security;
        t=1617070155; bh=ev2eTOrIiGjIzU2QaBKmHLXjTGkioOahZK3Z2i0AYw8=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=XosfzUhPtNg8Yv2K+P/eRdT31T/PU7KF2boZ466ZYAkLC/T51XGtptBNot/DlCObb
         Amu2GoVImU3eK5J4lcwy/BbrLBrPzPXCKTTuBfhtGikdb8FUXJ18Gxv+xGNrCqtmeF
         ReIERIgQ2IPCopa4SuIi4M9GlKKwSEe/TfyCj1C0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Name the GPIOs to help userspace work with them. The names describe the
functionality the lines provide, not the net or ball name. This makes it
easier to share userspace code across different systems and makes the
use of the lines more obvious.

Signed-off-by: Nichole Wang <Nichole_Wang@wistron.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
index 577c211..15c1f0a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
@@ -383,6 +383,39 @@
 	};
 };
 
+&gpio {
+	gpio-line-names =
+	/*A0-A7*/	"","cfam-reset","","","","","","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"fsi-enable","","","","","","","",
+	/*E0-E7*/	"","","","","","fsi-mux","fsi-clock","fsi-data",
+	/*F0-F7*/	"","id-button","","","","","air-water","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","checkstop","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","fsi-trans","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"presence-ps1","","presence-ps0","","","","","",
+	/*AA0-AA7*/	"led-front-fault","power-button","led-front-id","","","","","",
+	/*AB0-AB7*/	"","","","","","","","",
+	/*AC0-AC7*/	"","","","","","","","";
+};
+
 &fmc {
 	status = "okay";
 	flash@0 {
-- 
2.7.4

