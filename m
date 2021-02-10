Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64C93166D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhBJMfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:35:34 -0500
Received: from mail-eopbgr130047.outbound.protection.outlook.com ([40.107.13.47]:63322
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231891AbhBJMc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:32:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZA/eRqoSwk1OMkCoyGIVWxnG1ZqYFaihhFzhmOpA4dG0UsQnQ3Xu/W+e0CAslvSo6zHbNBVSuIuua1y1QsfKWUE9mQR5S+/+iCWXZIcfGlA6DNNEXni3UbyeuCzuPgx3Z1Etp7XvVBHCKfqbxbWBdvPrv94++ZwuphMCNBtPE5VCwdNEmoKPBd5oFf0yDy5b0s69zDTCF2VvManpHG+i11EwTwYpQTg/FeEuv2hi4C7pT7oHPAQp9mrruvwJWCVxfFDZt3WyZhiSxtxy4EBWmFsITMgZcX2IC9gDPhp7hiiK4p0InWqFqgiq/E2vu/NNaa8lw99pnYfC/WostQAQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3pp63NBq62z2yG3MivNKg/YIlE+0MdkAK+CszzhYD0=;
 b=Lo2ZmURC2KxG0cP8W/vpgLmqSbOmxLW7aOZRtpyzheNrvMEyVKVLYAO19FY3NjNwv6ZVCDlywEMy50Nbju0gmHiEDBz9oPHsLIE0Uz744O10FA5/El7UlAPc9ppjNOm0G1pnQvxHDGjfKoE4tIskRjSTD2iqfALykg+zDIdlJ30YzIRIWTywiQKNlSEC03zfkv1OpoAOu2VlzJOWaYjBJ6qpCRbUV7bpmO8l1rJAy7dpHqJ39slCpipOAHmTUMeytd4ha440xUXAV2xktmUIT8IQOIKI5ZHFzIA+hIDMYzG0vnpZBVa4K656Mi5aTv5D+KuMt0g6/uhZCV7Kn3K/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 91.118.163.37) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=wvls01.wolfvision.net; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=wolfvision.net; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3pp63NBq62z2yG3MivNKg/YIlE+0MdkAK+CszzhYD0=;
 b=p8i9c5+K6JnoiIF/k4fzdRFKjQDrSPO7xEi2dORD6ug201DHdb1HP8ttBS9ulz9GjRm0gqS6F110J2fKYsGYz9vvTn0ZXxfmDqjGm4VkS+//mX3b7tqKimfyytb8qIOp9sMHqbcsznRY0KchaUdfvg8iuXZrtoZ5xCl4bfuTfzM=
Received: from AM5PR0301CA0034.eurprd03.prod.outlook.com
 (2603:10a6:206:14::47) by AM0PR08MB4371.eurprd08.prod.outlook.com
 (2603:10a6:208:13f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Wed, 10 Feb
 2021 12:31:38 +0000
Received: from HE1EUR04FT013.eop-eur04.prod.protection.outlook.com
 (2603:10a6:206:14:cafe::e3) by AM5PR0301CA0034.outlook.office365.com
 (2603:10a6:206:14::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend
 Transport; Wed, 10 Feb 2021 12:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 91.118.163.37)
 smtp.mailfrom=wvls01.wolfvision.net; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=fail action=quarantine
 header.from=wolfvision.net;
Received-SPF: None (protection.outlook.com: wvls01.wolfvision.net does not
 designate permitted sender hosts)
Received: from wvls01.wolfvision.net (91.118.163.37) by
 HE1EUR04FT013.mail.protection.outlook.com (10.152.26.126) with Microsoft SMTP
 Server id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 12:31:37
 +0000
Received: by wvls01.wolfvision.net (Postfix, from userid 1008)
        id CF3644A4037; Wed, 10 Feb 2021 12:51:47 +0100 (CET)
From:   Stefan Ursella <stefan.ursella@wolfvision.net>
Cc:     stefan.ursella@wolfvision.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz@meresinski.eu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: quirks: add quirk to start video capture on ELMO L-12F document camera reliable
Date:   Wed, 10 Feb 2021 12:51:43 +0100
Message-Id: <20210210115144.17014-1-stefan.ursella@wolfvision.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210102821.31779-1-stefan.ursella@wolfvision.net>
References: <20210210102821.31779-1-stefan.ursella@wolfvision.net>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6be17388-33fe-41d9-3057-08d8cdbfcf5d
X-MS-TrafficTypeDiagnostic: AM0PR08MB4371:
X-Microsoft-Antispam-PRVS: <AM0PR08MB43718DD43DC46DD79B5A8200878D9@AM0PR08MB4371.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iwk5EpciA1IGnqAgn4auk+Tn1POxMvt2cpDWtXh8BfqaWV+rmBZedKdtQQt8H1Ek5f+IWxGYwlBD7UrHgaOd6oMp5GTiz4yq5Kzs4yITHpwKR0pv/AIgK6H3KNgu2GgL5AdlQEheS74xnJb1dpAfzPVigccx6lTXsFfmAwGbjXi/lgNA44yDYs7VSUZkA7FIeBHu8XQ6bUl8K7X7+uk4xBVz4YJm6Qwe4qCVrJS1pdJ5P5e7TU9w23uijhWMUT9aiV3RvOiYQkTPWh6qd4vkd2exbPx9qzXj/lQGwIH0Gc3zyGOf1J35kuz6k8da+8uyKpAUHfL+WE+RDYuWZ19ZXoIj0rtTgKda2v3HekLQdsMrwuD3DzxiWUNPcG8umtEY3z7HSmwo3erxj4td5Fyr0LcnpjaKeBCTQ4wglC/f/dMjjNTBMqwkKwPQlM89ntCNnB91XU7IwDE0pbKt6FcIH0K/f4xHUSMZkEKqaHqhCGJckIMoQ5oFhGlAA6c4LfZ+ZlI/nFfFCFIPhFQJl7+Sv61vL1xg79FOo5CbWwfRuOjrFD07jHY75MfdLWpHOsFutGKICwBFw+9jI/IUhu5UVlTwnxJaoTQ+pbX4JS8H8fAKR99b69DWshw0crXEItJlXHJSVJCpJE4kfwMbGikjaNah3wQa5yi/gVru/BRyvGn9BjzOGxxnfasjv99TMEol
X-Forefront-Antispam-Report: CIP:91.118.163.37;CTRY:AT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wvls01.wolfvision.net;PTR:91-118-163-37.static.upcbusiness.at;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39830400003)(46966006)(5660300002)(6666004)(70206006)(4326008)(44832011)(83170400001)(109986005)(1076003)(26005)(70586007)(450100002)(54906003)(6266002)(42186006)(356005)(2906002)(316002)(2616005)(35950700001)(8936002)(47076005)(82310400003)(336012)(498600001)(8676002)(426003)(4744005)(36756003)(81166007)(266003)(14776007)(75936004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 12:31:37.2734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be17388-33fe-41d9-3057-08d8cdbfcf5d
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e94ec9da-9183-471e-83b3-51baa8eb804f;Ip=[91.118.163.37];Helo=[wvls01.wolfvision.net]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR04FT013.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4371
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this quirk starting a video capture from the device often fails with

kernel: uvcvideo: Failed to set UVC probe control : -110 (exp. 34).

Signed-off-by: Stefan Ursella <stefan.ursella@wolfvision.net>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 84b5da0a26a5..270ad082d3ba 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -381,6 +381,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* X-Rite/Gretag-Macbeth Eye-One Pro display colorimeter */
 	{ USB_DEVICE(0x0971, 0x2000), .driver_info = USB_QUIRK_NO_SET_INTF },
 
+	/* ELMO L-12F document camera */
+	{ USB_DEVICE(0x09a1, 0x0028), .driver_info = USB_QUIRK_DELAY_CTRL_MSG },
+
 	/* Broadcom BCM92035DGROM BT dongle */
 	{ USB_DEVICE(0x0a5c, 0x2021), .driver_info = USB_QUIRK_RESET_RESUME },
 
-- 
2.17.1

