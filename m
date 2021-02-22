Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85500321300
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBVJYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:24:25 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36636 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230107AbhBVJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:24:00 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11M9KlGt016260;
        Mon, 22 Feb 2021 10:22:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=selector1;
 bh=CEx+dJ33M2OiDJi9X3qiBhe30dtWSWB5g83Cp50fZwo=;
 b=SPezn6Ht4XYEb6ypx4NcpjfSKDUoxH9t7hs3mdMsQ7MmKdt4RSveqAbhYkBBCyoOHRbY
 vfrMA0SbCiZTs+WUJhv3vmXA4RzvXAMYSGrNDXYwXpRxutrPXka73iN8Ebg/9Jo5CiRJ
 8tE5oHCUh3TBGjldR8e0zMkJXCbZO4Tc14l5xL6F46/ezS2bydlp4/8SOSnSGx7/oZD9
 PKt15Ns7tEg5lhEvcIoHt1uuKujNlWsp/f1PDbRFwUciVEXCXlXFZzhrc2BoDiD/erEL
 ZjOxXQO5X7jdc8L1lY4Df0hTF0yPb2KhWjivfinODJo7zEMH8Y63rFErZoxOCs+9D+Ac wQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36ttn6tneb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 10:22:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 32CE010002A;
        Mon, 22 Feb 2021 10:22:58 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2342B21F0A7;
        Mon, 22 Feb 2021 10:22:58 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Feb
 2021 10:22:57 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Mon, 22 Feb 2021 10:22:57 +0100
From:   Raphael GALLAIS-POU - foss <raphael.gallais-pou@foss.st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Joe Perches" <joe@perches.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yannick FERTRE - foss <yannick.fertre@foss.st.com>,
        Philippe CORNU - foss <philippe.cornu@foss.st.com>,
        Raphael GALLAIS-POU - foss <raphael.gallais-pou@foss.st.com>,
        Raphael GALLAIS-POU <raphael.gallais-pou@st.com>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>
Subject: [PATCH 1/2] drm/stm: dsi: Avoid printing errors for -EPROBE_DEFER
Thread-Topic: [PATCH 1/2] drm/stm: dsi: Avoid printing errors for
 -EPROBE_DEFER
Thread-Index: AQHXCPxOHztlhOrGKUWaJgLQSaRSdw==
Date:   Mon, 22 Feb 2021 09:22:57 +0000
Message-ID: <20210222092205.32086-2-raphael.gallais-pou@foss.st.com>
References: <20210222092205.32086-1-raphael.gallais-pou@foss.st.com>
In-Reply-To: <20210222092205.32086-1-raphael.gallais-pou@foss.st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_02:2021-02-18,2021-02-22 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertre <yannick.fertre@st.com>

Don't print error when probe deferred error is returned.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw=
_mipi_dsi-stm.c
index 2e1f2664495d..8399d337589d 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -363,8 +363,7 @@ static int dw_mipi_dsi_stm_probe(struct platform_device=
 *pdev)
 	dsi->vdd_supply =3D devm_regulator_get(dev, "phy-dsi");
 	if (IS_ERR(dsi->vdd_supply)) {
 		ret =3D PTR_ERR(dsi->vdd_supply);
-		if (ret !=3D -EPROBE_DEFER)
-			DRM_ERROR("Failed to request regulator: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to request regulator\n");
 		return ret;
 	}
=20
@@ -377,9 +376,7 @@ static int dw_mipi_dsi_stm_probe(struct platform_device=
 *pdev)
 	dsi->pllref_clk =3D devm_clk_get(dev, "ref");
 	if (IS_ERR(dsi->pllref_clk)) {
 		ret =3D PTR_ERR(dsi->pllref_clk);
-		if (ret !=3D -EPROBE_DEFER)
-			DRM_ERROR("Unable to get pll reference clock: %d\n",
-				  ret);
+		dev_err_probe(dev, ret, "Unable to get pll reference clock\n");
 		goto err_clk_get;
 	}
=20
@@ -419,7 +416,7 @@ static int dw_mipi_dsi_stm_probe(struct platform_device=
 *pdev)
 	dsi->dsi =3D dw_mipi_dsi_probe(pdev, &dw_mipi_dsi_stm_plat_data);
 	if (IS_ERR(dsi->dsi)) {
 		ret =3D PTR_ERR(dsi->dsi);
-		DRM_ERROR("Failed to initialize mipi dsi host: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to initialize mipi dsi host\n");
 		goto err_dsi_probe;
 	}
=20
--=20
2.17.1
