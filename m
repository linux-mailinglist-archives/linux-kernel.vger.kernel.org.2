Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE3B42099F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhJDLBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:01:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:21452 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhJDLBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633345190; x=1664881190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BpQgW5b63Xc9jy5x+2rM9IFRudy3AWvmQ/JHB4/3Ldw=;
  b=vuM95EMOeDlIM2Wvt+hfmNneli8km8fi5VYunXechK7NXOHIswt9TIZN
   l1ogJXB84ugAlwHd4qLceq+my1LIf1De0TiKxRp8SWLApE3aBJxxfrfO/
   cxhqiO/IhjbXXtgn2rlABUA9Vjn/EVMRVnh/nWWVKurMCT4VXk2FcIFOK
   mM2cBp2xoZAfvNUI6UebEQ4TD1puyP3fRI2zwqx8E181bxbDSRkiSN1br
   yWUgooXvvMbqTj/i/hxgbp/tXGvQAvuARJIx05fLRVXlsSpWPAOsUEFym
   T/H9NxrWMmw2U6F72+NB4gimZUSuNM9Zdsb6rw0ay40LxJXHM9tpAYQrp
   w==;
IronPort-SDR: sblJec5xdzLs1vrHENIMEl7XTSzorjq1Q3zPazFPs3eIHTa6+HLUFhnfIK0NScyY8Q6gVldarB
 DQgy+cozjzPirrJBERUua+X64JThHljD69hA1S6pmQbRUNSXtk5zZ9qfQB0XLFCnAbWRTSWJ1U
 7w4Sq3tyJaAyE9ioMx285EwfCCTuVutkzuv90S7Eh+xADqa01AGHyARAiX3osfaTVim3MjTTh8
 GV6LTcsvjA2iqDyH1p6DOuLxFIp34iaeCUH6wcL6MUbMR5skGFoK70Sd/ksuznqCK5TvMy89e4
 pgAIzUqubmywi3exXGsZBWf5
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="138939028"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 03:59:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 03:59:49 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 4 Oct 2021 03:59:45 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <corbet@lwn.net>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH 2/4] ARM: at91: Documentation: add lan966 family
Date:   Mon, 4 Oct 2021 16:29:24 +0530
Message-ID: <20211004105926.5696-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004105926.5696-1-kavyasree.kotagiri@microchip.com>
References: <20211004105926.5696-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new LAN966 ARMv7 based SoC family from Microchip.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 Documentation/arm/microchip.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/arm/microchip.rst b/Documentation/arm/microchip.rst
index 9c013299fd3b..29a06a921eae 100644
--- a/Documentation/arm/microchip.rst
+++ b/Documentation/arm/microchip.rst
@@ -175,6 +175,12 @@ the Microchip website: http://www.microchip.com.
 
           http://ww1.microchip.com/downloads/en/DeviceDoc/SAM-E70-S70-V70-V71-Family-Data-Sheet-DS60001527D.pdf
 
+      - lan966 family
+        - lan9662
+        - lan9668
+
+          * Datasheet
+            Coming soon
 
 Linux kernel information
 ------------------------
-- 
2.17.1

