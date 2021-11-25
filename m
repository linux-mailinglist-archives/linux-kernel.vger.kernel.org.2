Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C50045DC9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355814AbhKYOt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:49:57 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:51516 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355787AbhKYOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:47:52 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AP9OCMP002618;
        Thu, 25 Nov 2021 15:44:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=8TcwlTK97rQnX8N3x7FHRcKkfLTqnGhIJuDXv5FUVZ8=;
 b=Uk6l0ezKrfl9hNDCNgbbup2DhSsUP3mFmeyjs4nnoiw7sEISxDV+5yMrJbXy7d0Uk9TO
 wKpeM6MHGLMkbWWIMKOHsJxp+/cErXhceXd0UkVVrQmz8mCOKveDPpBB+uwyRerc6OQ8
 xUASM40h6LrYEHGZT0y3l0kG4YYRocJb6JmOaZCE7OKZD53dIrKcUEPx5mbFoA0RxESO
 ND2yWgia0QKkuKH0Sid84kYUXRrfYNrq9GYBE7xjDNil6di2hcDnCoErIuihRIH/TqA3
 HNM97ddr7G/N63O4Lr8Oii4Ly67npCEE64VIaybu0GxcQm0D3e4T+aEVaRHFG7uNpDHB ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cj3cykuvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 15:44:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4537A100038;
        Thu, 25 Nov 2021 15:44:22 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3D788237D97;
        Thu, 25 Nov 2021 15:44:22 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 25 Nov 2021 15:44:21
 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        "Rob Herring" <robh+dt@kernel.org>, <arnaud.pouliquen@foss.st.com>,
        <amelie.delaunay@foss.st.com>, <alain.volmat@foss.st.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
Subject: [PATCH v2 2/4] ASoC: dt-bindings: stm32: i2s: allow additional properties.
Date:   Thu, 25 Nov 2021 15:40:51 +0100
Message-ID: <20211125144053.774-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211125144053.774-1-olivier.moysan@foss.st.com>
References: <20211125144053.774-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-25_06,2021-11-25_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32 SPI peripheral supports both SPI and I2S protocols.
In the SoC device tree the node describes the peripheral as an
SPI peripheral by default. This default configuration can be
overwritten in board device tree to use the IP as an I2S peripheral.
In this case the address-cells and size-cells properties from
SoC DT SPI node should not be checked against STM32 I2S bindings.
Set additionalProperties to "true" to allow these extra properties.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
index 64b70ac539f8..33ba15363c0f 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
@@ -73,7 +73,7 @@ required:
   - dmas
   - dma-names
 
-additionalProperties: false
+additionalProperties: true
 
 examples:
   - |
-- 
2.17.1

