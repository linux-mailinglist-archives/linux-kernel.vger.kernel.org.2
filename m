Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6ED3212FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBVJX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:23:56 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36602 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230107AbhBVJXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:23:53 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11M9Korh016507;
        Mon, 22 Feb 2021 10:22:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=selector1;
 bh=c1aebQ0l+1wgZ6Yg2/4eGkGmBoaVEzzO8QSq6ZSd5Uw=;
 b=vhiV8BnoY5HnAmz5KjdyLzuugaCLOUpfsjXwve1YovHu0WR8Kzx7+y6fK37tY+u8MFdl
 PWf3Tahu7cLxeCwMIlGuIHbenHb5Yfqu4tmHzZXUcoQ+NcfYmviFY9w3NiweTrpUv3CQ
 6oGZ+XtAuMe7okQnu80BF3mP7dUpGDmuRlDmgG/6wfzUZjEWDvJGrmcl/+pmhFQcFBui
 EixY5FfWrXF6P/tr9BAak35JXu7VSgkcJuAUrhHECFPVvXPNBGJOVJfM+wvYMNGvDU84
 UwZYeiz9RoYeMsSVknXWTw2dWz9WyoOqV0fyQGF7WWs2u9GHkLNPNj/Bjm7uvVHUNf72 lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36ttn6tndd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 10:22:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 025D4100038;
        Mon, 22 Feb 2021 10:22:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D2CB721F0A4;
        Mon, 22 Feb 2021 10:22:43 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Feb
 2021 10:22:43 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Mon, 22 Feb 2021 10:22:43 +0100
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
Subject: [PATCH 0/2] Standardize DSI driver logging system
Thread-Topic: [PATCH 0/2] Standardize DSI driver logging system
Thread-Index: AQHXCPxG7Aav2VLZYkepVFMirMgYKw==
Date:   Mon, 22 Feb 2021 09:22:43 +0000
Message-ID: <20210222092205.32086-1-raphael.gallais-pou@foss.st.com>
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

The use of DRM logging macros was removed and dev_err_probe() replaces
condition, showing errors but not EPROBE_DEFER.

Yannick Fertre (2):
  drm/stm: dsi: Avoid printing errors for -EPROBE_DEFER
  drm/stm: dsi: Use dev_ based logging

 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 58 +++++++++++++--------------
 1 file changed, 29 insertions(+), 29 deletions(-)

--=20
2.17.1
