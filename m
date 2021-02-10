Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11109316961
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBJOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:47:36 -0500
Received: from mail-am6eur05on2084.outbound.protection.outlook.com ([40.107.22.84]:19489
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229888AbhBJOrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:47:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4PmcVmH4PTaKVZabba/UkFmqRYcPoTeJ+qHgBrUpHkanoGMqWpJZvaZLuS7EB6dDULxxqSyYEdQMoRLFs2+8QlbwCXMComC5VqCZGbqOLcjUWrSfjI94qbZWEgJpe3KeFu+Nr8ot1S+BslK8UY3OeyVQ12BpBdMI9zsgb3gmXyLP7da8BhmnvAeDRGqVwk88voUpYj0mkuDg12sw5tQBI9jw7CUli+hKjnCn3qnqrvbJ6vWKLcoBw9wbxLH8ff+jwjJHj4YQbK+54voKncYVkQOVizDTZL/2+FJgBz3xJtRVCsODwxfzkKc4q/EMERG14RefBLuxmRx4Q33NmEgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLT8wE4t28/AtEksVp6qiVvnQHx3eLWekzipsAgorsI=;
 b=Qhc9RK+CTQy4iwsqA6xPh/u98sJuxlfPbbmPuG+Ne18OuDfauI85DknQLI9pnXJnMBsnyhFhmMPQRSduiodsxeriCN/EchpHNR/6unM8Dvv1SNEGz5E7ZdJMvpJW77Hm6IbYwlRF47YS0ogjHuBe3iN2NQk+g0n4tyXLLBl3LvfWpigofLPotrIgP3fJN2zCtsa5QHrhBa1f5+QU1/jgFAfL2TDjSs33D2QXK0mhLELp2q/brTbyK/tPVXHG6br6FURBYDg7FyXCvwT9CpsCMD05Yf2WFZEHGzlQcVnTQxDOzYl721zEu8uRVTlXkJ7nUuF25RflAyCdP2vRHcAieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 91.118.163.37) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=wvls01.wolfvision.net; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=wolfvision.net; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLT8wE4t28/AtEksVp6qiVvnQHx3eLWekzipsAgorsI=;
 b=GsCImwnU/832X4g4ePeOSkC7PfRe+DjFZY4Rv+nRP28DUJcdUrxHVCA+PV4gyc65lchDxwZoPfUSKTg0qFoyQfsVqer3WintgbU/Iz56q65vvJvy0bVsKMo9PvmtAz51a97m0qadf2/aw3kRlCVeoflWQYPamK9nA6ztyBJGczs=
Received: from DBBPR09CA0015.eurprd09.prod.outlook.com (2603:10a6:10:c0::27)
 by DBBPR08MB4556.eurprd08.prod.outlook.com (2603:10a6:10:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Wed, 10 Feb
 2021 14:46:38 +0000
Received: from DB3EUR04FT049.eop-eur04.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::c) by DBBPR09CA0015.outlook.office365.com
 (2603:10a6:10:c0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Wed, 10 Feb 2021 14:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 91.118.163.37)
 smtp.mailfrom=wvls01.wolfvision.net; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=fail action=quarantine
 header.from=wolfvision.net;
Received-SPF: None (protection.outlook.com: wvls01.wolfvision.net does not
 designate permitted sender hosts)
Received: from wvls01.wolfvision.net (91.118.163.37) by
 DB3EUR04FT049.mail.protection.outlook.com (10.152.25.39) with Microsoft SMTP
 Server id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 14:46:37
 +0000
Received: by wvls01.wolfvision.net (Postfix, from userid 1008)
        id 1798C4A4037; Wed, 10 Feb 2021 15:08:31 +0100 (CET)
From:   Stefan Ursella <stefan.ursella@wolfvision.net>
Cc:     stefan.ursella@wolfvision.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz@meresinski.eu>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: quirks: add quirk to start video capture on ELMO L-12F document camera reliable
Date:   Wed, 10 Feb 2021 15:07:11 +0100
Message-Id: <20210210140713.18711-1-stefan.ursella@wolfvision.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210102821.31779-1-stefan.ursella@wolfvision.net>
References: <20210210102821.31779-1-stefan.ursella@wolfvision.net>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e7a829d1-166a-462c-f8c7-08d8cdd2abad
X-MS-TrafficTypeDiagnostic: DBBPR08MB4556:
X-Microsoft-Antispam-PRVS: <DBBPR08MB45567239C5C43668E4BC8A89878D9@DBBPR08MB4556.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5K1YIA2cxTarE08g1CVscZsmk1sJEvvcC2GtP3/Jx8faPD3P6UvCgTU29ye5WAx2CJ2MTMrQLMw2kDBx4Tk/127u+Y7/tMLfngeJm5xMnW6qn3/tQMWGFuvBYzOghlu/AqvU+Fu0/gxUCU8qcU/6lEBsEVwvCg24MRAchKI7O+Zd5OdjK0o72wcq3k8gLYM93MrZz2vwoLzDP5TUDfJJt7MB8H52x87vRo43YDLsKe9gu+9MPEqCtDxz7OHSun69I3M8Ew9IAza2U05Jl9qHgSjJV6IxHJgnNEUGN8EHU217vgwuhsRAqxig0A3TYsfCx9cBrGYvP3P7nA+KfGNIYuD3+YF1ssy6FotSPiw9u17poMwDo/l7KiBcufp2tUA/d1CmczSW+mumxHDK5aY11tFkK1Ng3iKMDu8O4uFXs6L9hydQLMUmpUZNNKItAq+tmV7TydmMT0wbgfiQ3898wf+giyUaJtURFUogabj7C46t8wvhHwXoaJ9oEzNJAVOjmLh8wOdCufX9TMIMmCfCGM1vSFy9FPoaWzAj9kvqZNJvmAI4no++tyeBbpKwXp9isBu26mxpDqMT/S6pobgSN1gQsakGVs9uTeQ3jiJnYVsoqi4zid4oZebXu+pFMAvSVT2YXGJWmQFCH9ROcW6D3X4pRRatMIVknYt/LLkC/Dqpvt++iFr5B7VvE02eMda
X-Forefront-Antispam-Report: CIP:91.118.163.37;CTRY:AT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wvls01.wolfvision.net;PTR:91-118-163-37.static.upcbusiness.at;CAT:NONE;SFS:(4636009)(39840400004)(396003)(376002)(346002)(136003)(46966006)(5660300002)(26005)(498600001)(336012)(1076003)(2616005)(4744005)(426003)(36756003)(82310400003)(8936002)(42186006)(70586007)(316002)(54906003)(44832011)(450100002)(6666004)(6266002)(4326008)(8676002)(2906002)(109986005)(47076005)(35950700001)(83170400001)(356005)(70206006)(81166007)(266003)(75936004)(14776007);DIR:OUT;SFP:1101;
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 14:46:37.8767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a829d1-166a-462c-f8c7-08d8cdd2abad
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e94ec9da-9183-471e-83b3-51baa8eb804f;Ip=[91.118.163.37];Helo=[wvls01.wolfvision.net]
X-MS-Exchange-CrossTenant-AuthSource: DB3EUR04FT049.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4556
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this quirk starting a video capture from the device often fails with

kernel: uvcvideo: Failed to set UVC probe control : -110 (exp. 34).

Signed-off-by: Stefan Ursella <stefan.ursella@wolfvision.net>
---
Changes in v2:
  - Add empty line before signed-off-by
  - Sort entry by VID/PID

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

