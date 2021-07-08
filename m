Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145873BFAB9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhGHM5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:57:25 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59240 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231774AbhGHM5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:57:24 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168Cl4Z3015034;
        Thu, 8 Jul 2021 14:54:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=selector1;
 bh=u4Ke3f/StqxwDJ/DSjNimnJWqaj5zW0D0V5m4kxombA=;
 b=wxFfkVlnVqjZ2Cop5EgW4pluJDoJ7Sbj19PKraW8e0ppzRP2frLDFEzBwAASUCBB0NcD
 3P8hZfwS5uEmYA8tOwcX3VlIyGw/2+xvNidE4u+B75jNSGgeVEszcQJmxqOMgcbTn2Fs
 5h2I4TTcX+0GdwX2dmfIPSR/nPxfnOihE7jcuY6BfxvkRbEhdZgHg/JsMIf70l8ujxX1
 ucAm2VfqjC7W6MOoMAHBV0E9lyZq3HRyDTRnmT3f8rUG64A5OyyEieuDEetS/L+wM9q+
 vLA8sOi49YmsR3U1nirYbvpSb9dIbhFqsm59BQBQFw6J4gHtLuQJrF6mP3uOxc5c6kPt kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39nwkf1uqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 14:54:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 93B3D10002A;
        Thu,  8 Jul 2021 14:54:29 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 79FD7221F7D;
        Thu,  8 Jul 2021 14:54:29 +0200 (CEST)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE1.st.com
 (10.75.127.4) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Jul
 2021 14:54:28 +0200
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1497.015; Thu, 8 Jul 2021 14:54:28 +0200
From:   Raphael GALLAIS-POU - foss <raphael.gallais-pou@foss.st.com>
To:     Yannick FERTRE - foss <yannick.fertre@foss.st.com>,
        Philippe CORNU - foss <philippe.cornu@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Raphael GALLAIS-POU - foss <raphael.gallais-pou@foss.st.com>,
        Raphael GALLAIS-POU <raphael.gallais-pou@st.com>
Subject: [PATCH] MAINTAINERS: Add Raphael Gallais-Pou as STM32 DRM maintainer
Thread-Topic: [PATCH] MAINTAINERS: Add Raphael Gallais-Pou as STM32 DRM
 maintainer
Thread-Index: AQHXc/hjJp54kpJbp024lT+8TOrwPQ==
Date:   Thu, 8 Jul 2021 12:54:28 +0000
Message-ID: <20210708125217.11784-1-raphael.gallais-pou@foss.st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_06:2021-07-08,2021-07-08 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Raphael Gallais-Pou as STM32 DRM maintainer.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f1171ceaf8b..4fa3bfc00f57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6165,6 +6165,7 @@ DRM DRIVERS FOR STM
 M:	Yannick Fertre <yannick.fertre@foss.st.com>
 M:	Philippe Cornu <philippe.cornu@foss.st.com>
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
+M:	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
--=20
2.17.1
