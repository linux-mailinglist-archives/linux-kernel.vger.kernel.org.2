Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECE6316501
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhBJLTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:19:41 -0500
Received: from mail-eopbgr60073.outbound.protection.outlook.com ([40.107.6.73]:19455
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229683AbhBJLMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:12:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCqDx7Rq1pjhXeaKyQA1wdkazWOfYURoH3Wa+TPgnyJTgoefUQm6hrtN4p/njcgg/gjFvfwbZMmoo1Do/TmWdDv+ASSHO0AadBkfqrwi+djcZ3fgcjLt2J/DOYvYZ/Y4krDSqmRpl03lgMpHLXqxEfEh2ZdEh/8jHGjVwQAoqf1yCJNjxEVYknqVXv2Y2+1muBVLTwL6qUnfH2fowBuLJWcIDaAXja8uwJq4EdvfpFDL15pZBmTLutM5wLV+/tflPsvKwDkigx9f13mssYsEP2wc0LPWnUreQ6rc75Mgcz054D40Ktw/q0NiVmd5GwXIeqV95F+R4QLr7K2hurdRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WvRrs4uBXqMGKQRRPeQ8x4waA+zKkmJaUNkZgbsSFY=;
 b=Ijtry7gConspa7Gs9AsRZca8tdlrCeObsTbleiyuEeFw17BgjQhsRpLhp8/udxrTtbcwhoiDnU3zhZCIdicN8ioaPDk6cLq+V3x1ersMvjkQ7QZER4Rvfii4gNi+D5Y5SCirexey3bToexdYz+3VmDVElMg+Wb15eJPIqEYCGJedweu86i3a7OzVOjg9xlN0y6f7qifC5Y0pNQT6O5XqBChYQBcdV8deBIGfmsMuVYLSS7y/dgAyZ/LXR76gqq6N6iuPHUx6A/y6lWN/mmo93BPtChfviro8XPXoKAXAPBbJ2WP3qkCLJCcj5E8uiFYI+yJtpfcQlj4GBfo9QbEggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 91.118.163.37) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=wvls01.wolfvision.net; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=wolfvision.net; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WvRrs4uBXqMGKQRRPeQ8x4waA+zKkmJaUNkZgbsSFY=;
 b=aaj/xOQn1ge4Ht2Le1H+JRexRP7/476TbpJK1XHLJOB5WhxDbL9GveVeIaMFIjErNM+wqtB9w/4BNI7Otl5o/7N/2sw1bJxHHdX2wrIS3YTl5jxTYS//LO070NSvHGzKDAtEMy4psxA8Ub9ldWHrScIp1SWfamIeJwsbxyktCUc=
Received: from DB6PR1001CA0026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:55::12)
 by AM0PR08MB5025.eurprd08.prod.outlook.com (2603:10a6:208:15e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 11:11:38 +0000
Received: from DB3EUR04FT040.eop-eur04.prod.protection.outlook.com
 (2603:10a6:4:55:cafe::1e) by DB6PR1001CA0026.outlook.office365.com
 (2603:10a6:4:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Wed, 10 Feb 2021 11:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 91.118.163.37)
 smtp.mailfrom=wvls01.wolfvision.net; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=fail action=quarantine
 header.from=wolfvision.net;
Received-SPF: None (protection.outlook.com: wvls01.wolfvision.net does not
 designate permitted sender hosts)
Received: from wvls01.wolfvision.net (91.118.163.37) by
 DB3EUR04FT040.mail.protection.outlook.com (10.152.25.181) with Microsoft SMTP
 Server id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 11:11:37
 +0000
Received: by wvls01.wolfvision.net (Postfix, from userid 1008)
        id 02CBB4A4037; Wed, 10 Feb 2021 11:32:29 +0100 (CET)
From:   Stefan Ursella <stefan.ursella@wolfvision.net>
Cc:     stefan.ursella@wolfvision.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Jonathan Cox <jonathan@jdcox.net>,
        =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz@meresinski.eu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: quirks: add quirk to start video capture on ELMO L-12F document camera reliable
Date:   Wed, 10 Feb 2021 11:28:20 +0100
Message-Id: <20210210102821.31779-1-stefan.ursella@wolfvision.net>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cc6c01cb-f6f3-4646-1513-08d8cdb4a2b7
X-MS-TrafficTypeDiagnostic: AM0PR08MB5025:
X-Microsoft-Antispam-PRVS: <AM0PR08MB5025917A10C914D3867D98DA878D9@AM0PR08MB5025.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9En4eAttDrkhAMTIRO0PFQyyZOyr8jKu8u2t7+/spG1t8GGk7pypsS6wm05SwVBHKnDp/UCNBANVgMSySHYMlW4A22oBo0OIzlx/SxbsCtReihciPi9/OcdVJzruinmlA1Pbs2rc1eGirhWFMh8fk/vFEj1vYz8WakNsmpzQm8sYavdcnSNdgXP4FCC6taS8Yvp8iMlRiKqr2VJgqDU5QA+B3UBeV1SPD6RoUH2GjRxqUmVBLrV8Gl4+024cQMsCesBTgqnXnuNFdhZM0f3VcbPm/Wn1RY/ks7shHCEs4x1Q5nNccQopuGgQH/eQSmEafikEjjGRT5YlMslNs5Zu1xqL4DG6lbTer6WMkNQdrsZW4JMtjLxvVadCWHR+iuMVwPXaDjwiy5kBQ6k810nxcqYezdXVPpnmMxSBamLr4nfPZZURDVfAu1/xORUg8q1QLigKxYHtKDWWTaZMJk+PTL3lw6q31i8M92A5zaVfu01ZTbhwzS3IUdDOGaDN2n27w0TBwPB/0OiaGECyTQoC8T5oJfregT19kEhG9rFPuPVYFz4tBS3B/KcPW1leeMUxKbcmnrCsa/8JCuz4LVLhkfdbrOamVXoZo+0ayxWDNOzXyLaBivm+t5BdW23fEvPK2h/49xH5boayicoABcJDGuZJbcUFiZQJClLRR8GWB4UB0MEcwHDOF2MmSEqXCLqR
X-Forefront-Antispam-Report: CIP:91.118.163.37;CTRY:AT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wvls01.wolfvision.net;PTR:91-118-163-37.static.upcbusiness.at;CAT:NONE;SFS:(4636009)(46966006)(6266002)(4326008)(6666004)(109986005)(47076005)(8676002)(2906002)(44832011)(70206006)(54906003)(450100002)(356005)(81166007)(83170400001)(35950700001)(4744005)(336012)(1076003)(2616005)(498600001)(5660300002)(26005)(8936002)(70586007)(42186006)(426003)(82310400003)(36756003)(266003)(75936004)(14776007);DIR:OUT;SFP:1101;
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 11:11:37.9170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6c01cb-f6f3-4646-1513-08d8cdb4a2b7
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e94ec9da-9183-471e-83b3-51baa8eb804f;Ip=[91.118.163.37];Helo=[wvls01.wolfvision.net]
X-MS-Exchange-CrossTenant-AuthSource: DB3EUR04FT040.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5025
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
index f232914de5fd..f888deaf7bab 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -480,6 +480,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* novation SoundControl XL */
 	{ USB_DEVICE(0x1235, 0x0061), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* ELMO L-12F document camera */
+	{ USB_DEVICE(0x09a1, 0x0028), .driver_info = USB_QUIRK_DELAY_CTRL_MSG },
+
 	{ }  /* terminating entry must be last */
 };
 
-- 
2.17.1

