Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6B40F73B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbhIQMJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:09:15 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:42434 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbhIQMIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880445; x=1663416445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R9dm/LZCckRk6wJfIOlCq9hs1HeKlKJFOmWdXSXIfm8=;
  b=A8j43u2mzbrVKLs/RqtVIvI/8wN/fCcjrX9uJ7lv16kE+VnVRpX+gO6+
   ifuDS2fp7zpVApxGhCHx93deJP2r35WaG5amDgNmTblXP7c/8obObXjPQ
   yyEXvTnWRWEJ4/L8aGHq6sEW5YfJdMKX+PfjhXxxIZYQ9fs8n6q8I0IAm
   GvOmmhp97PvTXdXtmfZkMZt0THrHUGLBCjs7Bs0vt0Xs67XVP2uDK+Nbr
   GFtJIc58ClaXUU6lZkxn+v2GJxbb1QualsJ2Dj8wb/Pbk7rGTaw9eNWb+
   VQSr9biyUHBHhayLoKQUC9WKE95suBoBG4vw5McqMXI6bSoxN+SeDr1lP
   A==;
IronPort-SDR: 1wpC/Ll6uTbnfr9hYE+yko02NPZxL1PtCBXJcGsaO4er7jbiOu70lcIapFVvEZ0giSixsFDUcI
 SKq/T1+xEb/S1QSsaCohxgL26/Q7eSwa66J7ULbhtEqR8k9F35/FRSzevzxAmV/6dhiBZR7JAm
 NpmCqtdJkvhn9ji1rA5VXdaEx38R888kzaEeP7TVhjHc2KT2CnkhPLbihBgGO/o2geeQV8cJJU
 DaIRj0tniVhj/5e5jw0kFGFLJWVH/fMCBmqEVQlAThVqouATEpwGBmXcNDcVLNxVlpk1Zhv398
 6e1ChOD7lv8G/dV6iNb63zAI
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="69664832"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:07:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:07:24 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:07:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 16/17] clk: remove extra empty line
Date:   Fri, 17 Sep 2021 15:06:41 +0300
Message-ID: <20210917120642.8993-17-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra empty line.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/clk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 64838754cdef..815fe5f6651e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3574,7 +3574,6 @@ static int __clk_core_init(struct clk_core *core)
 
 	clk_core_reparent_orphans_nolock();
 
-
 	kref_init(&core->ref);
 out:
 	clk_pm_runtime_put(core);
-- 
2.25.1

