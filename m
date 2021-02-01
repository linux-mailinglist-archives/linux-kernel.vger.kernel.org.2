Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D607730A4CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhBAKBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:01:21 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24628 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231992AbhBAKBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:01:11 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1119aXJ2030768;
        Mon, 1 Feb 2021 11:00:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=0OHT/KLCuvN+f9RwKM/ud/dFXHBYEnWKpIcB3tlYBfs=;
 b=jOI40WdRKGctPn1+GwHJ9dpkkaX8RM7PknIPny1H8PcdSFJpsk5iFd6Hz2AVMyARkjZF
 IiZ6xtZh5gne0pTaLDFwNUn+0kEITORKzo6FQDSBz4EJlB0K0ZBlZtzwIQNCd9ovEIs2
 YqaM3GP5hLIbqlvPQPXGDKoQPzZPq6Qu6N8RumyYOGmVgyqWC1kWuSTT7BhDWMcDyazj
 dkpXN3rynnGTZEZC5xiL8yF7PQS9hwGmmgwZBmksUbn5O2/fbh35CEnpJ7+B/TkOD2YV
 GtenP74LhXFzRy3HMF/aQ7dITfUakTcepaSMECTjwIMHZWe2/5abWAVxtPZyX2HPNrKV lw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36d0nrjdey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 11:00:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C470310003D;
        Mon,  1 Feb 2021 11:00:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B98CF22D602;
        Mon,  1 Feb 2021 11:00:27 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Feb 2021 11:00:27
 +0100
From:   <patrice.chotard@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 1/3] MAINTAINERS: Update some st.com email addresses to foss.st.com
Date:   Mon, 1 Feb 2021 11:00:21 +0100
Message-ID: <20210201100023.10985-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210201100023.10985-1-patrice.chotard@foss.st.com>
References: <20210201100023.10985-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_04:2021-01-29,2021-02-01 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Update some st.com to foss.st.com addresses related to STMicroelectronics
drivers. All these people will now use this new email address for upstream
activities.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 MAINTAINERS | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d3e847f7f3dc..8222e50a9902 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2504,7 +2504,7 @@ N:	sc27xx
 N:	sc2731
 
 ARM/STI ARCHITECTURE
-M:	Patrice Chotard <patrice.chotard@st.com>
+M:	Patrice Chotard <patrice.chotard@foss.st.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://www.stlinux.com
@@ -2537,7 +2537,7 @@ F:	include/linux/remoteproc/st_slim_rproc.h
 
 ARM/STM32 ARCHITECTURE
 M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
-M:	Alexandre Torgue <alexandre.torgue@st.com>
+M:	Alexandre Torgue <alexandre.torgue@foss.st.com>
 L:	linux-stm32@st-md-mailman.stormreply.com (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -3149,7 +3149,7 @@ C:	irc://irc.oftc.net/bcache
 F:	drivers/md/bcache/
 
 BDISP ST MEDIA DRIVER
-M:	Fabien Dessenne <fabien.dessenne@st.com>
+M:	Fabien Dessenne <fabien.dessenne@foss.st.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 W:	https://linuxtv.org
@@ -5042,7 +5042,7 @@ S:	Maintained
 F:	drivers/platform/x86/dell-wmi.c
 
 DELTA ST MEDIA DRIVER
-M:	Hugues Fruchet <hugues.fruchet@st.com>
+M:	Hugues Fruchet <hugues.fruchet@foss.st.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 W:	https://linuxtv.org
@@ -5974,8 +5974,8 @@ F:	Documentation/devicetree/bindings/display/st,stih4xx.txt
 F:	drivers/gpu/drm/sti
 
 DRM DRIVERS FOR STM
-M:	Yannick Fertre <yannick.fertre@st.com>
-M:	Philippe Cornu <philippe.cornu@st.com>
+M:	Yannick Fertre <yannick.fertre@foss.st.com>
+M:	Philippe Cornu <philippe.cornu@foss.st.com>
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 M:	Vincent Abriou <vincent.abriou@st.com>
 L:	dri-devel@lists.freedesktop.org
@@ -8196,7 +8196,7 @@ F:	include/linux/hugetlb.h
 F:	mm/hugetlb.c
 
 HVA ST MEDIA DRIVER
-M:	Jean-Christophe Trotin <jean-christophe.trotin@st.com>
+M:	Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 W:	https://linuxtv.org
@@ -11101,7 +11101,7 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/dvb-frontends/stv6111*
 
 MEDIA DRIVERS FOR STM32 - DCMI
-M:	Hugues Fruchet <hugues.fruchet@st.com>
+M:	Hugues Fruchet <hugues.fruchet@foss.st.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
@@ -16813,7 +16813,7 @@ F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
 F:	drivers/media/i2c/st-mipid02.c
 
 ST STM32 I2C/SMBUS DRIVER
-M:	Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
+M:	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-stm32*
@@ -16944,7 +16944,7 @@ S:	Maintained
 F:	drivers/block/skd*[ch]
 
 STI AUDIO (ASoC) DRIVERS
-M:	Arnaud Pouliquen <arnaud.pouliquen@st.com>
+M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
@@ -16964,15 +16964,15 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/usb/stk1160/
 
 STM32 AUDIO (ASoC) DRIVERS
-M:	Olivier Moysan <olivier.moysan@st.com>
-M:	Arnaud Pouliquen <arnaud.pouliquen@st.com>
+M:	Olivier Moysan <olivier.moysan@foss.st.com>
+M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/st,stm32-*.yaml
 F:	sound/soc/stm/
 
 STM32 TIMER/LPTIMER DRIVERS
-M:	Fabrice Gasnier <fabrice.gasnier@st.com>
+M:	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
 S:	Maintained
 F:	Documentation/ABI/testing/*timer-stm32
 F:	Documentation/devicetree/bindings/*/*stm32-*timer*
@@ -16982,7 +16982,7 @@ F:	include/linux/*/stm32-*tim*
 
 STMMAC ETHERNET DRIVER
 M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
-M:	Alexandre Torgue <alexandre.torgue@st.com>
+M:	Alexandre Torgue <alexandre.torgue@foss.st.com>
 M:	Jose Abreu <joabreu@synopsys.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.17.1

