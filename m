Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3D37253F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 06:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhEDE7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 00:59:09 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:43617
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229724AbhEDE7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 00:59:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naFl037XYg131wpLWo09qSprszsXRey3igM0kZU7tOkUyWewjW3PQCTgUdiZTItzyd0aH9U3dSe/DGOnKSX0s3ZCCFn6JOUH+fU6WLuchZFLaGXLg2tQmlJHbYhfSV1ydNeq4iK5HhJy/iJMA6RTRszNdONgeXKkme1xUgdHBf7gxsi+56OyMJymjCBwtTV+Y+fFKTXZAYUAbuW+iymf5S5pMHclO2NVSVvCWKq49Pdr+3XDGaIYF3mHcsyAYWNtq7j/24mewe+lzj+ZH1lWuhFEU9WG0aYcMTZSH7ivKgPa250J8DChwkQou5Ds36wZqMUxHIE42z81ECbWOOEDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HiXxifFrPQLeS9dQZjb0iAq59Yds2V987MIRT218YY=;
 b=TJxFUz4Yf1QUR/5eRR5qPOwPx0gOw/Q/dYq1tDA9XpWelGJ+d0F6Rt27s3ONt0FM/yV+2hCrKdGBrMGgDoRtAqHxSvBeQbqiawtd4XAvXpQoUjnqOsK3JnEX4YlNpFj82HsrmNZcLKI+0pPHLMz9G2nWfm2mKdfxlVz/SQ9+KNCZacjMRLeUOyXBbhEI6z07PqUDF58y9uG29eDQxh87z0PSOAHgQLKF7VqvFCHfWxS8/iqNs3jC9cuV4WvCtGYaPundPXGoHdiQ1oAbRvyaFUTCSrYRgH+UMBG5POap3ZpTAZQBcV0xhgeg+F8i7pTwuuHD5iJ3Dtg4Km8S0qaTmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HiXxifFrPQLeS9dQZjb0iAq59Yds2V987MIRT218YY=;
 b=nufe82xBbRgIfS/YZzaaFfz/+jsJ9PzhM1eE7mv4QQu+00ICcTVUnbbGWjuJJsPpY6ck7q2YG6bSnJMW3p7JZU/4gmedbdaDqEV/+XkZrfPFRRuXqrlUjcesbmaCJMdMvpPiWulF4e3lrp4CpsqWe/PC5vO9zcBRoTo8DDF+msM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15)
 by CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 4 May
 2021 04:58:13 +0000
Received: from CO6PR12MB5412.namprd12.prod.outlook.com
 ([fe80::3508:d33b:5c53:c961]) by CO6PR12MB5412.namprd12.prod.outlook.com
 ([fe80::3508:d33b:5c53:c961%7]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 04:58:13 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH] xhci:Add reset resume quirk for AMD xhci controller.
Date:   Tue,  4 May 2021 10:27:39 +0530
Message-Id: <20210504045739.3786551-1-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::15) To CO6PR12MB5412.namprd12.prod.outlook.com
 (2603:10b6:5:35e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26 via Frontend Transport; Tue, 4 May 2021 04:58:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8a6efab-89b8-4ce4-8a18-08d90eb93872
X-MS-TrafficTypeDiagnostic: CO6PR12MB5476:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB547645C7EFF79FE56F0F8A82E05A9@CO6PR12MB5476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILcvECKBClE1C5bHMoWbSe+zCk4R5XhcSHk9VXwvoBrlUIRbgvlnnL8OqW6xa99Q1gdwA8QvSRVQylYiejpjqBjl7Q6hjqWQpFXUcy41OQrCVhLWqG9o/g6pNidtqyVzjSIxEWlcof+AZ2W4RN6RvT7VQmxp4/ODpMgjs9WTxImnDo1YBqDJCpbB+ofBnCimVpo+JG5NrYljdWztl91FlEbAu4609KCAW3mb/1w9093PTKOa3qwJDGOBRIkWlGrgwJKr7X0jvo9y/NY2biTZYo5VOaZmCSjHgG7OpCRdrK3f+s7lTkFJPb8GRGKuN92NJd49TY88zfXTUl72KdoHcw7igqs1zRRT6EhjvjVs8OgAB7oPwoXcc1yjZf4z/TnNR7Nvu4v6u/1PIu4KKCQmQfUjo0QzZn9gtZRWHw4d/mdPh9uTJAgfqCSMC7a4oejp9p91d+uFJs1JqjlewH64gXmGF6k5rcNqyFP3v2QlJQs+tunTB9UAuq5DLcUMtarHwZ/GatDE7BjzuLYJMYJ5JUI3gIB6DCNhKgSFg0okHIjk1ROzNXYnGFh78qLKunQWCQbpSLU73n/5PpXRWm67FD+xIoG73VqQLJVPUxh4WZOUj/XNoKYi1mnzVB6mQuwIFHGZUuM2HGU8I7QUUfukyhO7WtxuDDPxNIfhezpfLbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5412.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(2616005)(66946007)(316002)(86362001)(478600001)(6486002)(8676002)(956004)(7696005)(4326008)(2906002)(8936002)(1076003)(83380400001)(26005)(66556008)(5660300002)(186003)(38350700002)(6666004)(66476007)(16526019)(52116002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qcQ/fp/mwdqWNVO2DpepFYVzAME2XSoN45rnJa4RpaO16VvsWWAe1CndmTW4?=
 =?us-ascii?Q?owdwxxITyh0a9wA8/J5rBj3/nzdWnw6uSk02fuBzMkeyeJnGcMLCxne+Q73x?=
 =?us-ascii?Q?7Mdx8nZiN/Nuq0pVOTFyj6h+o+lFhBq7tfV5+1XJiFpLrKhKfAqPtcAR/Nl3?=
 =?us-ascii?Q?OFzkDl7hnLgRCufyDUZgYCNKiFbCgcP6wT8yeCCTE4723qr7A1mDWMUDfwyJ?=
 =?us-ascii?Q?GPLkAlNeHOBIaTjcGIOzJoVbWQ+Iy+DW2CRwYCMdFXa1Sz0sjxrBNq9DAzj9?=
 =?us-ascii?Q?J1it0ArZNLOWNCsEViPAbm8bj8hn5Dqz6FUpa+xZu0E2Hu2gjhziMb2640m3?=
 =?us-ascii?Q?KvvGpSYgXY6mjDybpN8MeVzuaKmesNc+ycmHyB6lWEBTmdDrrVTPWRIigL4U?=
 =?us-ascii?Q?wnXpW89iajw4Iw7sSNo2dSQQfxWbDKNxaZobd0dIsxwJVQf+Ww7CIdWmqp7i?=
 =?us-ascii?Q?jlrF3bCVTRnK1+QTY2mevCGmy+opa9rC1wyAed/qpaVNM6WXF14Cr455DYOp?=
 =?us-ascii?Q?ePzTVqod5vY0kCq5lzET0YLj8GqsvudTqg821VejJARnEliJ3MddBfvwQ7XF?=
 =?us-ascii?Q?DqZvrO8lo/UEz8DJOklPpLDJnuc8aJCcPjGIz/gQHyZzhEYWGTP9hxSuzbkz?=
 =?us-ascii?Q?nORuVTL5FADE4xgBqhLv7wc4WB5PdiNUJ3GzVqdWM1Mu7wrkjxC9BQN6umE2?=
 =?us-ascii?Q?tkJ4fc4Xge6qVVzRruFH0FflMZHEzyqB77/MiE4kfFXE7SOIaxPOmTd5u/2L?=
 =?us-ascii?Q?S5SK9hmYCowKkkvea01jK7Jd2PLIMbDi8HoVXyku6Zh5LEddKTJg1nikLyiL?=
 =?us-ascii?Q?mb+KLU1S5xmyxbWyWsm6g9cZZbzGRYsBOzCsNhhf7Y+S4OnLhucKD9zVmOHV?=
 =?us-ascii?Q?0VLu4FVPyD4+4lXvO7AZgx4982Ys+rnm0bDquYXACXMPdO7LfJPLk/heewss?=
 =?us-ascii?Q?xHRbXxg2ie9h7sOC8nU+or7cOqD6Y881qmvLbEqPDD7PWwnlW0+y4f+S//sb?=
 =?us-ascii?Q?Y15SGEcFSDIxwIRsaofrjYMnrKd2wUZkCDGLk/vkbiVLhmfTLGSgpqeVWw8b?=
 =?us-ascii?Q?BW/No1SSUoRj2ZmTHDV3qgydejuIN1iCXYZ7U6HtLIFkA1xJNuX6UklhhRd0?=
 =?us-ascii?Q?3Qe3n9WUu5+xegzm/E2zuSIr3pcG1fDDZ2gzpX7/i7JNelt4eGplyZNlYauS?=
 =?us-ascii?Q?sMSbEHji0UFwJX8J7jDIomVlznbEE8SMlEr/+LAwDegldzNmjX6UMM2N02ck?=
 =?us-ascii?Q?niD7JIF44rzDV2NmqleOYQMaC76GeTRq3CxKXzDs0/1bsBHzaxrKEP51Teyv?=
 =?us-ascii?Q?zQ8k87qM+Rcv92YFv07bgCAP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a6efab-89b8-4ce4-8a18-08d90eb93872
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 04:58:13.3004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziyxPmB/pLgBe2TiQax8Un+7DhafRrAK/oaZmIUM5KGNDJxBFL9cVSKfXz2W/HrO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

One of AMD xhci controller require reset on resume.
Occasionally AMD xhci controller does not respond to
Stop endpoint command.
Once the issue happens controller goes into bad state
and in that case controller needs to be reset.

Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 drivers/usb/host/xhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 84da8406d5b4..c8c468271767 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -165,8 +165,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	    (pdev->device == 0x15e0 || pdev->device == 0x15e1))
 		xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
 
-	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x15e5)
+	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x15e5) {
 		xhci->quirks |= XHCI_DISABLE_SPARSE;
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
-- 
2.25.1

