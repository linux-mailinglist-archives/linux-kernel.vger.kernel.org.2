Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995E1438DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhJYDNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:13:25 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:58888 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhJYDNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:13:21 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 19P3AkJG029970; Mon, 25 Oct 2021 12:10:46 +0900
X-Iguazu-Qid: 34tMYeBbJpTnMiSq5g
X-Iguazu-QSIG: v=2; s=0; t=1635131445; q=34tMYeBbJpTnMiSq5g; m=0kK2KeKeCPteyKNpiXOb0Bh0vrBX1TcQ0n8a4ygQPTs=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1513) id 19P3AiB7013326
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Oct 2021 12:10:45 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 3761110009F;
        Mon, 25 Oct 2021 12:10:44 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 19P3AhQN015756;
        Mon, 25 Oct 2021 12:10:43 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v5 4/4] MAINTAINERS: Add entries for Toshiba Visconti PLL and clock controller
Date:   Mon, 25 Oct 2021 12:10:38 +0900
X-TSB-HOP: ON
Message-Id: <20211025031038.4180686-5-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for Toshiba Visconti PLL and clock controller binding and
driver.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---

    v4 -> v5:
       - no update.
    v3 -> v4:
       - no update.
    v2 -> v3:
       - Change path of DT binding files.
    v1 -> v2:

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..2a682d28bb83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2736,12 +2736,15 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
 F:	Documentation/devicetree/bindings/arm/toshiba.yaml
+F:	Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
+F:	Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
 F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
 F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
 F:	Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/toshiba,tmpv7700-pinctrl.yaml
 F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
 F:	arch/arm64/boot/dts/toshiba/
+F:	drivers/clk/visconti/
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
 F:	drivers/gpio/gpio-visconti.c
 F:	drivers/pci/controller/dwc/pcie-visconti.c
-- 
2.33.0


