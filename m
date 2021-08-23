Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009D43F509F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhHWSqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:46:21 -0400
Received: from mail-bn8nam08on2062.outbound.protection.outlook.com ([40.107.100.62]:51279
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231578AbhHWSqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:46:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuzaJHfpFBuEQLgKVkHJM+QFxf3495PSPujCWrGolBose8boiaZspDp1Fp+om5Ct++rZsULR4C12SF99VppfD0ia9XBPA2zcYuE387rOtK7nGEzMIMgplzljuItSNOFoW8CgVd8P86SaK56UlzR0UWW/Bx5votJQgeOqKM4BTQuzrBVP3V3s3DLqnlx8nREMPHfMZVRW9kELxWyn1+A3xc8xdiWrAVYh+6j7SLnxMMZXQPDrxdylc9RMjgQTw46pj+Cpgqs/Ch98nqLYqPutUQl6fe6vX14yksfLAGki4H/VDLEwNmy0KNYS03jGEMJT4egEEx7dTe/bw/fs0mF5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSSVg0JcalUKTOYpor3Vjk/k4DvOVXXcJyTlti88sRo=;
 b=TMyWxSl2z2mmM5bQQqNWwqmzCYM3VHIGq72w+rgwSwoFMXu4aQtxRDymU0T1MOBl4Hp5KrTebexOdlOINCiOTyU3kAwtYXkKxcKVc7vDmlP+D8xD2WQW9gginBuEvLukOedUq+QSIClcoLuBNf5M+7QQYf7M2bXNpZ9UgM6xxVlkHg8nScIyDHfdhaGAxy7Uz/E3//pfrhPCPVIiOe24XB0n0bYHO8K8XgJY7yOIIuKDKJZy3MJWsGtDNj58ewmif4Vgti5CxVZoh6ySMAZhbf7hDdttc2eSBR5XwPm/GLTshO68IBhIbIBlFeg3B5XCpghsjtRINAZhtuJVgBPK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSSVg0JcalUKTOYpor3Vjk/k4DvOVXXcJyTlti88sRo=;
 b=k8E79uRCzQQ4juIsQRdLDNBLFL27AfqAYXELXJJ99sfGdKz93U5iDbN+krJ4Q3LgdOtExEsdVXmy3XLC+8E+xH5jcSsQKN8jrUr0rq0DahwLOt+aihd2Z58TgmWMUWoW9+4KHxk4O9No3/cLnMOTamJnuzuPuvgqVGUZiNmZV5Q=
Received: from BN9PR03CA0793.namprd03.prod.outlook.com (2603:10b6:408:13f::18)
 by BN8PR12MB3556.namprd12.prod.outlook.com (2603:10b6:408:41::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Mon, 23 Aug
 2021 18:45:27 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::5f) by BN9PR03CA0793.outlook.office365.com
 (2603:10b6:408:13f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 18:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:45:27 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 13:45:23 -0500
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kun.liu2@amd.com>, <alexander.deucher@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Subject: [PATCH 2/2] usb: dwc3: pci add property to allow user space role switch
Date:   Tue, 24 Aug 2021 00:14:49 +0530
Message-ID: <20210823184449.2796184-3-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210823184449.2796184-1-Nehal-Bakulchandra.shah@amd.com>
References: <20210823184449.2796184-1-Nehal-Bakulchandra.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83070f26-2dc2-4370-c3c2-08d966662cd3
X-MS-TrafficTypeDiagnostic: BN8PR12MB3556:
X-Microsoft-Antispam-PRVS: <BN8PR12MB35560DD7961E30E250A61872A0C49@BN8PR12MB3556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fozJsgT82/8i7Kdl7kv9m+zPhcphk8Q1wJOd7mv5a/U2Ga2oSb6e874lPB5mI+FP7ZNhoZLDcO9EOlwMFuSYorIndU2AwBCQbhQ4U2g9kd9wbjHVCsP0HBf1PcbU0IKfNTXgbgQ1pNkahZw8/RLwkAHck25mKP3fqOj8vseucya6U9eksYjB6AK79CzpTf+eZc7hZGj/d0jd6InE+6/ZvLcb1vM1oPDQqDE9g0sAIc87nyqme87NVKFnYlAMxu69dc7njCKR+H1Fxi3pEAoRNvq/63bMAxuBGa4qNC5WG2Kpo4l4phRZkpgI+1YhZt4q285lAyVlO+mdNiBj6hHRA3GiQ7jAnOdSEwg++RDLttLEwkSQ3rEVey19Z42HernLhz0N8AOBKaI7Wta9975+gPcnMr4+eCYVFukwlIHoGH0F07p4NcgwS+UWG0dlTT5rx7p0gH831BdbaDStgWfnTeZSKYw9XtxvjSTrrvP86W53DzAoA/MUimWmgC5EwlvQYeVLpFpx7GHwY2Sz5FqdBgfvPmC73KRe7iTn0aKq9kMYFLYHNQdJhaZTKLieyaeh+A6KA2Qp7SUFq9eA1iahEMxaFk5sElxEIS8Y8EMQDzf/3kfa+1ZCC6jGKlayXe22nYzsb5JCKD3JyaoQ07N7+vhX8LQAcPycCYIIrBwHHlSQMrrimML1DPraRzjFgjF/RF6/BJVRyBiGAnp3G5ngSU9TmL6qQ1QR2LhXjkcCrtX2u20ysJG9BynxIiXrmR0T6jjpPKBGX3bvk2aEHw9nhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(4326008)(26005)(2906002)(8676002)(110136005)(7696005)(16526019)(54906003)(86362001)(34020700004)(36756003)(336012)(356005)(186003)(8936002)(2616005)(478600001)(36860700001)(70206006)(82310400003)(5660300002)(1076003)(6666004)(316002)(426003)(47076005)(70586007)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:45:27.3969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83070f26-2dc2-4370-c3c2-08d966662cd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3556
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For AMD platform there is a requirement to enable user space role
switch from host to device and device to host by means of running
following commands.

HOST:   echo host > /sys/class/usb_role/dwc3.0.auto-role-switch/role
DEVICE: echo device > /sys/class/usb_role/dwc3.0.auto-role-switch/role
Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
---
 drivers/usb/dwc3/drd.c      | 2 ++
 drivers/usb/dwc3/dwc3-pci.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 8fcbac10510c..6d579780ffcc 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -555,6 +555,8 @@ static int dwc3_setup_role_switch(struct dwc3 *dwc)
 		mode = DWC3_GCTL_PRTCAP_DEVICE;
 	}
 
+	if (device_property_read_bool(dwc->dev, "allow-userspace-role-switch"))
+		dwc3_role_switch.allow_userspace_control = true;
 	dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
 	dwc3_role_switch.set = dwc3_usb_role_switch_set;
 	dwc3_role_switch.get = dwc3_usb_role_switch_get;
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 7ff8fc8f79a9..c1412a6e85b6 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -153,6 +153,7 @@ static const struct property_entry dwc3_pci_mr_properties[] = {
 	PROPERTY_ENTRY_STRING("dr_mode", "otg"),
 	PROPERTY_ENTRY_BOOL("usb-role-switch"),
 	PROPERTY_ENTRY_STRING("role-switch-default-mode", "host"),
+	PROPERTY_ENTRY_BOOL("allow-userspace-role-switch"),
 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
 	{}
 };
-- 
2.25.1

