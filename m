Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C393308AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhCHHN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:13:58 -0500
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:43681
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235151AbhCHHNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:13:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCZ9eZg9rMW4HKt+1dhNIv3GoZpzdr6dIJtJH42GHcU9JMkRPxwDzhOZk9yxtit4D3zstgdi5c9VMmOBbTyuApMfuQZn4nCau/jgfcpXJx0mmFqwM41nTmBbQh2uxgYiPdihWCTzxxaHmnMH9U2yyZdSMnA9Ggu/rk+Lgg9kM5SlNjGLFa/QoxefrbjRnUKTEqUQ9g5mXAEq/Qi7IFqoePrXHJtAcRKWbB1h3GLQyhOjkX/J9Vgp4fP+ayI383jmWvLaPt83+ezyG1tBjfzG9jtdAQ+R1l0donnjEgFAvvq5IUH3K4MMtPJes17GJhuEctVrtELGyo0i+1LhKvPDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDyxD3ejQMAzYjnmIh4yBVFE4BuMB6RYQdYSh1eLJec=;
 b=S+1DCApaAhgZr2Ow+aWOfgMe6FXDarH+rEh1PGwaKE5W03ZvpnsligGXUFMMlf+mIPoLY60UR3aSN4Bz3gnFRzLUReJqvYiJayCNaVN8VG7TpBtYP2evCirEevfKshxD0/7AqQflvRv3JdxsOAUfUmbz8Ehr0E87n47kmEz+nf6cimMmSVHA8rdkUVyLmM4NWMRiMAcGrDgiDmzUWcWm914bVTmBrwnltOZ5dVusm/o97pt4etqvLgpb9HViUhxAenyJqWJdwJsIM4muCGBwQ4NM8DLpWNkUmkDJL35xxjfwS5r2rThGAUNc5kB+Gcy4VmovIFAceDxguZgb8lfzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDyxD3ejQMAzYjnmIh4yBVFE4BuMB6RYQdYSh1eLJec=;
 b=Pmy/R1L5xwbGrksjwvbRivujv/tygz/xEeQrush5cqMMRF7/08/6lCy57kMsDjf2HaCqcforSGAv60zHVcYIxBShlVIZVSJ11KWZ7tNc5Z2KkWgVhqgXh3dWRwpceOOskhkTLk7icMvuonHhkdz9rRnQR9FLmH3RMV2qI9KC7gE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2149.namprd11.prod.outlook.com (2603:10b6:910:1a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 07:13:22 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3890.037; Mon, 8 Mar 2021
 07:13:22 +0000
From:   quanyang.wang@windriver.com
To:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: zynqmp: Add compatible strings for si5328
Date:   Mon,  8 Mar 2021 15:08:43 +0800
Message-Id: <20210308070843.2096992-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::8) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR13CA0063.namprd13.prod.outlook.com (2603:10b6:a03:2c4::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend Transport; Mon, 8 Mar 2021 07:13:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bcdfdc5-4d15-49d2-1fe0-08d8e201a818
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2149:
X-Microsoft-Antispam-PRVS: <CY4PR1101MB214906CB2AD07CD99DB32779F0939@CY4PR1101MB2149.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUSKpHtEv8uFVJwX9V5mFJ7P+6cibxO2LAfS4M0Z69ulODWQJB/J9/cPER3/MWJydZ8kHRyNPebkjyjP8clxptBWAi1XPmKb41waP5SefKEH06gpR5igZEUaVmezuYKkh8/4AHNVnSccgCs0YBg9p3f5GWKiYmETC5HDao7FDN9C9fLF7nT+tQrUpY5D0GBFwfLVHhZDNcsE3hOtkn2S5X9msVes1ZowBR9aSqQKXnDEOeirEoCxqKhxjGBLhqYwSTbH+2akamBhMrZxIW4lmdIAajBVNL9/tsWt54+Aet8/G5AaDl5UQ+kUWQqzCB9mC5P02Iyoa1nKvSakGwOc8iS8g9t5KrArIObxMjrPuAl0qEUpHBwZPmTcE5D14K1ZITzWELqWtgw04wul5RoYbZZJPyrsYkzuhQ4wo4drGH/iTEPwpjC1V52g2kpRAzRYiNsZUzGEMuslyzwoaiyx+NmE5G9xYVq9ikxWshbCLXwRuuNPd8FsE3/1Garff37OuitqBk/Vut2nNJClHgPFLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39840400004)(396003)(366004)(136003)(6512007)(1076003)(9686003)(5660300002)(478600001)(26005)(6486002)(956004)(36756003)(110136005)(16526019)(316002)(54906003)(66946007)(66556008)(86362001)(66476007)(186003)(8676002)(8936002)(4326008)(2906002)(83380400001)(2616005)(6506007)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bttb/n19unA3BWDHWnK+xatki4WlU6mLUy8m0KFg3gOJ46AzXK8agYq+3YR0?=
 =?us-ascii?Q?3rhRinzTQcMWYC7v4W9U/23OJr1+dWCi5234iPgyMOHdu1ga3uY/howAlorq?=
 =?us-ascii?Q?6R+848Ps+2Y4eDJLI+9QWP0tIvhebE45e1sb6dmB4KWjjzPNzX+uSUwpge0l?=
 =?us-ascii?Q?TMLMEPg05+xQpVTTk66PsspAWCdC59Hx6m0nwLhakPusuXFNCw7pERogEOtn?=
 =?us-ascii?Q?Qne9+ZxMVJsjIGOVVFjXg6UJUe9neyRTXu5DuiRus+AZvcnK2Aa7t9SImO6I?=
 =?us-ascii?Q?g2tJdFpC3A5aD55+lDzovgCedIJvnKYJBuuGBc5V/IX0Mh6Hav3Jta+7LWCC?=
 =?us-ascii?Q?fm6vxT6yUDF4wS7aI7+HCNc1X1+tAwAKJKoIf7wmFkVFU3px6ombNaPMnsC4?=
 =?us-ascii?Q?zGo8jXzSacBjyY+UuWjGWDU3JK5gPckdfA+qB9VDMu3cnAUHI7NGINfyovWs?=
 =?us-ascii?Q?crWw0ii/X8rWGUGHmXLvJjjvrpiojCcA92IKxfaltxPmUqd0KUP7TXHa65fG?=
 =?us-ascii?Q?booTsRnol0XjZlDEygLq+nHTgHTo+j2IXTgkD37LLo05Zqow883Vm/fkAqzu?=
 =?us-ascii?Q?3DK24tRtsLLU6YRdWv5H3inBFAOv48U7LLrzwE+pTU2cUQJz9/DB2U2A0qtk?=
 =?us-ascii?Q?+Gx/e93PuaNYYEUponSI+YRSjGtmdeqronHuVEHnUmGN4gLT5yxZzgzfk+JK?=
 =?us-ascii?Q?bsiUm89g+YMwRj5VD06SBG8tKEfz9YPELQ8FVNMm9LXIShZL/nxVxh63myOW?=
 =?us-ascii?Q?YoCiKHEh3mYOMCfsNiQQ5ItaWjru25YA9zg9Cdp3vQAxvLk/NPErPLAS22H4?=
 =?us-ascii?Q?lB+i70pPP0rtzfFz0lcD+AZaUlqm5WdNuE1hBKFbwa9RcmnV8c2UCBodITg1?=
 =?us-ascii?Q?0PSNqFiujMl+v3Hnu84TPoCi2pJZD8C7KGPYGncZxRSTHfGFrjAnAABz/CeP?=
 =?us-ascii?Q?+MYcS8+90efObhC1d4ckFd0xM2VObiMgFSz1hOuqLs9vm1Mp+7XMe4GAOY/M?=
 =?us-ascii?Q?E5eGAbiWOm8kYFNziv/QaNG5uGblTCGcXT9z8DRdM7JAM5iLzbcT4yOr4yst?=
 =?us-ascii?Q?6c8pJfBx+Qgb+oNVZDoyEMIpObzrnWpzGwDBI9oQJBvVqCbILCqekEdtIw8p?=
 =?us-ascii?Q?/wN5V9m7ul98YiRn+Q9zF4VZtENVN2gKDDvpAz8LsW7+s/FrPeKub1z+DByh?=
 =?us-ascii?Q?I+YClOqrIaiGDneSUud72dSf3CMdGR5gQQHxjU1vbTKs9BbAv89RGBsR25jc?=
 =?us-ascii?Q?vzWtSKXwJvyP73P4CJoOVtoz8QWtBJnJQYVek67XgaaO6CYPKZljkeKCGPNv?=
 =?us-ascii?Q?aRNa81LnFfVaoU5sX6V+cVaK?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcdfdc5-4d15-49d2-1fe0-08d8e201a818
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 07:13:22.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biQvtoQWn1arTpOrpqLFb51aZKS0A/4qto35OvbqYmrMgCylfYUsFAeis6RNSX9M8Wd4qir2P6TOXasEO9NPTVoGp0wCxSH1E/48UIseQhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The function of_i2c_get_board_info will call of_modalias_node to check
if a device_node contains "compatible" string. So let's assign the
proper string "silabs,si5328" to clock-generator@69's compatible
property to eliminate the error info as below:

i2c i2c-10: of_i2c: modalias failure on /axi/i2c@ff030000/i2c-mux@74/i2c@4/clock-generator@69
i2c i2c-10: Failed to create I2C device for /axi/i2c@ff030000/i2c-mux@74/i2c@4/clock-generator@69

Fixes: 82a7ebf00224 ("arm64: dts: zynqmp: Add DT description for si5328 for zcu102/zcu106")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 12e8bd48dc8c..a73841ad24ce 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -590,6 +590,7 @@ si5328: clock-generator@69 {/* SI5328 - u20 */
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#clock-cells = <1>;
+				compatible = "silabs,si5328";
 				clocks = <&refhdmi>;
 				clock-names = "xtal";
 				clock-output-names = "si5328";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 18771e868399..24ce64364d63 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -591,6 +591,7 @@ si5328: clock-generator@69 {/* SI5328 - u20 */
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#clock-cells = <1>;
+				compatible = "silabs,si5328";
 				clocks = <&refhdmi>;
 				clock-names = "xtal";
 				clock-output-names = "si5328";
-- 
2.25.1

