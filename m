Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB29B30F535
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhBDOlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:41:09 -0500
Received: from mail-eopbgr150092.outbound.protection.outlook.com ([40.107.15.92]:21991
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236854AbhBDOic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:38:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMepqI2S0GOoLRAqfX6AlSkRY4O6v79FLpHGOZf7fAXmNW/R+tJ8cMSoiqZuU5ZT1HMKOcT3zCuLXqigM2AKT3p8R4vJpm+Au0Et4GcKhr6R7ArevniJGTsnfIHKn7e43D1M6NbTtHjTZOsK6LN9IoX8x2mPiTDUwWuWlVUIGzwXHUCt1MXy7uU5tKlO4lj68atSVXsfPLmAPoUxArQMbL+ywhPQMD14r0q1gWbi6lxAhC8jffT6NJciCL5bBlARFe7Ty1tv96k6e3xFn8E7Ex8nnbvb/bdpJEMOeVXoW7vsECENEGQ/cbM6y4AT3fS8yAAdg2vqjpMWCTmny/5zfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8hwsuotRJyFZlNoGcVUj+0hWqgZSxHdgSkrE5F3vSI=;
 b=Zp7v5oqtCnN6pQXFJ0qLCe4m6sL6Z5p03w5u8xqG9im3hdqEEChItiZRPUvv3GGmlOyKECuNxS0XI/kazY7o1ic2w12s10oiAlzV84gsHl1bvXKFXoMV/sDiLHiBq5+BoIrPRlUQtI8PU9je6I0+lsLc2BJ5WiVcCoHnghQXITHByE0aXEAd3zLXtun2bFPp8MXcJ9kstcUVMRIkXIHEOGj/E8t0LS/aTSskS3i5XB6II7YIrhFWjAQYxcHtgAshOjZ+gUX2FXBmV4zLHy/ttJwjngvMbZRd0lWO3ulzTSFpsqEC3af97JMfYOcEpJy1JMvkgEkjuy4ePG4maY2i9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 62.153.209.162) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=schleissheimer.de; dmarc=none action=none
 header.from=schleissheimer.de; dkim=fail (no key for signature)
 header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8hwsuotRJyFZlNoGcVUj+0hWqgZSxHdgSkrE5F3vSI=;
 b=XHx35wpjaF6ncmCPrAcpH64RfW717kLpYZHQByx3q0BNRwVSHovKPhqToGXjlgZA8uQBgoSpMiH5bdPUDqIB2G6JjeTQsDnbc1w1S756f5jPsDvPj3SdU2pGhDPwfrfC5Cg5jAJy/GfosEjwKq7ImWRj+L691E/ik5VSB3Gi/8Q=
Received: from MR2P264CA0173.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::12) by
 AS8P190MB1317.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17; Thu, 4 Feb 2021 14:37:44 +0000
Received: from VI1EUR04FT021.eop-eur04.prod.protection.outlook.com
 (2603:10a6:501:0:cafe::cf) by MR2P264CA0173.outlook.office365.com
 (2603:10a6:501::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.18 via Frontend
 Transport; Thu, 4 Feb 2021 14:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 62.153.209.162)
 smtp.mailfrom=schleissheimer.de; vger.kernel.org; dkim=fail (no key for
 signature) header.d=schleissheimer.de;vger.kernel.org; dmarc=none action=none
 header.from=schleissheimer.de;
Received-SPF: Fail (protection.outlook.com: domain of schleissheimer.de does
 not designate 62.153.209.162 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.153.209.162;
 helo=mail.schleissheimer.de;
Received: from mail.schleissheimer.de (62.153.209.162) by
 VI1EUR04FT021.mail.protection.outlook.com (10.152.29.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Thu, 4 Feb 2021 14:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=schleissheimer.de; s=dkim1;
        h=Message-Id:Date:Subject:Cc:To:From; bh=U8hwsuotRJyFZlNoGcVUj+0hWqgZSxHdgSkrE5F3vSI=;
        b=XIa+P2RRW7UyamNm4sr8MiWKyRyPniw+zSDXBZYeKiIPPuMWTTnmHbtaVmgMerK8zXRSaZ7b7BzlNr/0pz70lAJrz86Pf80v8SEANUfzQVtsDmLxMudfm6gCMmKL3dZiaZPihDbBUTOjUZ2FaEM0gSt0YAM0/KaAt+p32ApTivU=;
Received: from [192.168.10.165] (port=41972 helo=contiredmine.schleissheimer.de)
        by mail.schleissheimer.de with esmtp (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <schuchmann@schleissheimer.de>)
        id 1l7flL-00040F-1q; Thu, 04 Feb 2021 15:37:39 +0100
X-CTCH-RefID: str=0001.0A782F17.601C06B3.0090,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
Cc:     Sven Schuchmann <schuchmann@schleissheimer.de>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] leds: lp50xx: add setting of default intensity from DT
Date:   Thu,  4 Feb 2021 14:37:38 +0000
Message-Id: <20210204143738.28036-1-schuchmann@schleissheimer.de>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7adff074-655b-47ca-46ec-08d8c91a6e61
X-MS-TrafficTypeDiagnostic: AS8P190MB1317:
X-Microsoft-Antispam-PRVS: <AS8P190MB1317369DD9E81C3F70FD1FD786B39@AS8P190MB1317.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqqtNRmPA1PA4l1w/dM3DN/yucOW/w35Rd4kxE1cG285gVVTBqO8e+/4W8vYTWYY2tV18W+MhxQhUj7+UY723a7vR3C4EPvugQ/g2g2AcN/UczZhrxk+deU5xwPQ9qtRG7uXEi8nTs5cKV+OzbEfDzYieg2EQLKrAn07h5jwpcmkXcL1KOfm6UXOvXJIuX+Qg6bnQwf/pbp7KS54NPkvJvy2EdDhrTmmDEMISUzKJ1AUPv8tQpHhHLgVSjdX7UUiUYX1XOS1g0Jg0oQ1nDrGYjj27YebTLkGMf/Kn1fOtLCjhwy21RLOrg/GOUom0C4EFmHcWYGmNy/hP8BWZ5KgAILJ43Gg7Sx6a8LEJ8VIkO80vfVeo9t77A6O+ugb+nhmGaU7jUyhSdyeDiSrSjDxoyA9rUU6vJtC5Ptq8Vb2MCa96nsAW9aqYOXLH0dLPk9k8zcMLFms82QAXRSm5x3d2Af2V8EoyB5N3E73Ie45bIh1/cAAra0S7EGlvYhzUH8mtA0wOaL3X//hrq7+MXLSTddFXyjy2FrP+nuyWDJCe2DRxqAyF5RoDoirn1lNj2gGgbLb2Mz7my2I75tEUOgVUsccN+lXYKZerhm0wo18dShwv+tD2jpn2n3Dyn414CTRtjm5v8TckOzM3So48MxxuZSIkRbEi6aAfPiBfe/4Aco=
X-Forefront-Antispam-Report: CIP:62.153.209.162;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.schleissheimer.de;PTR:mail.schleissheimer.de;CAT:NONE;SFS:(136003)(396003)(376002)(39840400004)(346002)(46966006)(36840700001)(83380400001)(36860700001)(109986005)(4326008)(7696005)(5660300002)(7636003)(356005)(7596003)(70586007)(47076005)(82310400003)(54906003)(8936002)(36756003)(2906002)(70206006)(336012)(426003)(26005)(9786002)(186003)(1076003)(478600001)(316002)(8676002)(2616005)(266003);DIR:OUT;SFP:1102;
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 14:37:43.0367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adff074-655b-47ca-46ec-08d8c91a6e61
X-MS-Exchange-CrossTenant-Id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ba05321a-a007-44df-8805-c7e62d5887b5;Ip=[62.153.209.162];Helo=[mail.schleissheimer.de]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT021.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1317
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use a multicolor-led together with a trigger
the led needs to have an intensity set to see something.
The trigger changes the brightness of the led but if there
is no intensity we actually see nothing.

This patch adds the ability to set the default intensity
of each multi-led node so that it is turned on from DT.
If no intensity is given the led will be initialized
with full intensity.

Part 1 updates the documentation.
Part 2 removes an unused variable.
Part 3 sets the initial intensity to full.
Part 4 reads the default intensity from DT

changes in v1
 - fix dt_binding_check errors

changes in v2
 - sets default intensity to full
 - adds the property to the multi-led node

Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>
---
 drivers/leds/leds-lp50xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index f13117eed976..4b40bf66483c 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -267,7 +267,6 @@ struct lp50xx_led {
 	struct led_classdev_mc mc_cdev;
 	struct lp50xx *priv;
 	unsigned long bank_modules;
-	int led_intensity[LP50XX_LEDS_PER_MODULE];
 	u8 ctrl_bank_enabled;
 	int led_number;
 };
-- 
2.17.1

