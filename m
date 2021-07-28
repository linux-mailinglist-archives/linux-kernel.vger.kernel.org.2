Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F503D92E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhG1QL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:11:26 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:34584
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237457AbhG1QLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:11:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCobs78WxTI9lRagfe/95GYp7LtdadkyYWNbV25zvvaBhJE1mzVF8tddqbm917Fy/TNt/nvDZPwSidbQ/ZIxxpW2YMi7F8QFv3ZNvTGRqB4KTxNjExncjwZ49J0t6BmBLTYoCqayBtgHGw2G+ZeFSLHReGlMGM3j5rD8GREHOJXeF4AqJq8k1n2gJQTNwzmhRDC4S37BF1vaJ3PvNMKGiPsQqkieU522hwHKX82BO5dsR1lr3hWS8SufqJex7vlV04fwotXjtCTvYtoGtX2k/a/XKgh3HIyWnGH8C0v0plitS6OmVRkKrDMQ+phX5yzTU1Lf98bKYDTBZ3zxVTNg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7vpeveFsvko040aRTqY92mRDEUqHenzQobsA01HLkc=;
 b=Ctswai0KsmlRmaI6Hz/DkF1WU+nKg0pv7zIDzAYbkt2uzFRiezKiBCSdVXqaiw/DhDjQpoQ3+8ptJmBV8hXBSiwqovmzcuD5zCKmqv3A9ROK4BacD6hdv8/tM9VtqI3Ee81/nrvzWi85c1EG1rwYtzqNRsO7DVN2QpP0MTxj+coo6QHR029pqih8XNOPtu83owZLs5PhmrdrIqJS7JIvH75n8v/WC57A+TrsXC3srhhivmc8RFHp8rtaUUFiYQpVtD4iZh3eY1U2fgtpJ6OrYJqf0HXo1gbk/we4wl8pMg1JQF2O7XQY/QzYzL5OEqjvpHTK2MRC8XS9Aq2wxnlWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7vpeveFsvko040aRTqY92mRDEUqHenzQobsA01HLkc=;
 b=bdmMTDcbkRIpJTjs+8y1m/oRDDFtwhQDZvd9si7lRcojuoLMrpvLxOm5irglFaqmVqGHTiJang4evf4wvU1WckNZdD4c4AAnpbrfaQsovq3HwH0YUpr8aMpV8BBAxfdyqfceQkBdbEWl4ZTq86btZpkOvzXoUPwkUuU3Be14ANI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DBBPR08MB4268.eurprd08.prod.outlook.com (2603:10a6:10:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 16:11:01 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 16:11:00 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>
Subject: [PATCH 0/2] add ethernet support to rk3568 dts
Date:   Wed, 28 Jul 2021 18:10:18 +0200
Message-Id: <20210728161020.3905-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR0502CA0068.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::45) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by AM6PR0502CA0068.eurprd05.prod.outlook.com (2603:10a6:20b:56::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 16:11:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9629992-950f-4841-7347-08d951e24aad
X-MS-TrafficTypeDiagnostic: DBBPR08MB4268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB42680A04405EF78D86D97B0DF2EA9@DBBPR08MB4268.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZKMBtFkdVvbjXvkn8mxJF2hHf8j5emEKnvSTEvljHDCqO/lTWKhv6EkwzmlwPcjjqRGzF57pTzZdQ3jtsJPPPRM9MZs+lDnGVRJbK3SIAm5eUoAY2ZDQbyhkhFhi4QaVYYmVxu/7KtSNucsLSZqwQw/8KhuszCa1E6hm1ws1eRwTBhPY6IRQeM7kDxKaeBqW4kUXEdmomXoXwS4+tFTvBtavnRHaeWz7go5CCWi/UzkECpW2uRCQlzampvXYgKYnXinmEwMfAEpNb6+zg7DYhVkeI29yAWln8GVSVRaW21EDLqPfpWE0rcxlFE0vP1XoqTZSLNTBLTfIS0S4nR04eCTFzf+5m9zgDTwtlKXhvrqizqP3Sz5OQZUJULUWB09O9j/0QVh6hyEqiG8f4J0pC8QvPI2nO4rg84SYEXwm0+jBYMU5IGn9W0K4eOWsxfzOQ/304uuuwWuqANRQLmYgf2THlwtPBdYrT7novFcAwcbjpz9CVvvce7iDmtbPuwf4okbctzV8aDPQOl+UIx+LS6fFUmLNG/lEAetyVhQYoxnQc7dMA/CUsbpRNWmVEVZkn+gjzCf3+7i7sdDXSTf8HUbdi6fMFCPEUnFAGchgzQfBaudFZjhjyC/XCqXmLImAv62fCQpJLlU7qMiW4EJEqRmkesMcH2NNOUFgH6CgRXAaFvSqLAd9CcN5TiCSgLZAjSCFQu0Cn6sDfq4AdJBEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(366004)(346002)(136003)(396003)(186003)(956004)(316002)(6486002)(4744005)(38100700002)(2616005)(66946007)(66476007)(478600001)(38350700002)(2906002)(52116002)(26005)(6512007)(6666004)(86362001)(5660300002)(54906003)(44832011)(66556008)(6506007)(8676002)(8936002)(1076003)(36756003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BfBNQ1Ky1gX1PkYXK9nc+dudR/nQa0QBAS+EIQbQjTdHyQXypIru6vxKskEj?=
 =?us-ascii?Q?zCjptxzxdwxVYoQ7vOBogeoCgjU1imP3H5bbIYDx7shHCG8IfPd8GeVeaOI4?=
 =?us-ascii?Q?WGDY9FNRlSwzdpucKPkxtH4eAcrfAdzM1ToJtDtZD1s2TjPCrNJPebg9eoBv?=
 =?us-ascii?Q?raxcvVFiA79RuqHWKV0KCeCXSWEW+BlX9SQW3g97LDPj4k6ogtK2ab6MlcQr?=
 =?us-ascii?Q?ulYQLskzYA6M1KR4A+OqcMlmHbPAPHBjhn2XBn1tUi64j5FXZUYHbQqKxALh?=
 =?us-ascii?Q?eWJrb7j3TivGYc1tmLY64xmmjLhDi78QhZMrefGa7sqHlDFbvfI6UzszmpSI?=
 =?us-ascii?Q?FiRgU0MLhOZduUePiNd6Lx+sANhGiYFvan0KI7G/ZZUCEozzEPvh6CIF9O8d?=
 =?us-ascii?Q?GltGpKa21MwmKPN8+6Vo14yqPLHzbRZWGCNTMdkY+oV03RJf/M8I1kAXJJzp?=
 =?us-ascii?Q?B0G57KGhlf2Ac7N2W8gKwKqiAbZR08WWFIa5fW93+yItIdFSb5m7hQLkceFB?=
 =?us-ascii?Q?/UiaHKdkZfIh6s29crbhXTL+KTcKXgHgt16A/o+Ny2q2hQ3XsRWxAILK05bH?=
 =?us-ascii?Q?xyu42VaDB+yskl9yxfvjoz01eF1wROY4bzCbyqSapADBqf0GD8K96cOEn2xx?=
 =?us-ascii?Q?e11Glrsi3eo+8rVU+3odbDQQzZgwqf/WFLVTjyrEbrYHE7d4iVlNJJUX5QQU?=
 =?us-ascii?Q?+Zq6Rxcl+yurVbmkF44HCi10FH9Su4XXdbiZhO45tcHGcjVaoPkaCDmZ6fgg?=
 =?us-ascii?Q?KiWYXDVjnUAAP7/CJtEf6kdS8znSHRSHGQ3mB0GrKzEr9pVrP1CaaquWc2CH?=
 =?us-ascii?Q?hcCJTMjweLOn4hlejsroBeCOrvgEaY7N0N6ktTMfh3iU8kN4GEIc7j6z+kEJ?=
 =?us-ascii?Q?Ppve4bqqZp7eCGNwReHPcJPT4SY9NLOcO0GTOnwYls4GH58fVfQCnpj4CcOE?=
 =?us-ascii?Q?jW9yM3ZmLLbBIocRJ6PhF3T1Qnnbl9u7Wb8uYY8FwS9f9WSUS1CkVi5Q/S1K?=
 =?us-ascii?Q?19OxcFApbvFG2QvMDR4HLzcpfg7jMe+ESzcfFJDWnlcIdWPJd8aF+6jd/4Ox?=
 =?us-ascii?Q?JumAA4l23uYbyLMQslu70Ol2ptmfOjo+YMx5aQ+jrWt9KnwJcrWuDfEJxdAS?=
 =?us-ascii?Q?SpIigjPpdiR30uibqSzqFsH9GzwP4XTh+AQFdOQiU9kUfToHP5ySdLTfmL1u?=
 =?us-ascii?Q?Gnr0FWdpvM+PM92ujB0/pXtGRBkE8SiXXBp42Vq6/jlNQlLEeFKyL+bbe2po?=
 =?us-ascii?Q?ba1suPs5KWT+GR5FgN7dW+sLtEnNIgDtZtqkyqrdCn5HMKH6itQOx90aiZam?=
 =?us-ascii?Q?Hyf95ADxh5DMXosLdzjB21ZE?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f9629992-950f-4841-7347-08d951e24aad
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 16:11:00.9174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwQL5GXcwzhYFyh2Vl2MBjDYHv0R2u0XDYjaI4b7ldr0bv8ZsiJ8cd10Neq9vMMzaf6FFudPo/LIwvBFjvKI7Hd0gpcV3i2wofXUKfv1byg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4268
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

these patches should be orthogonal to the ongoing work of Peter Geis
that aims to introduce the GMAC1 node to the common RK356x dts.
The GMAC0 node, which is exclusive to the RK3568, and the Ethernet
phy nodes in the RK3568 EVB1 are introduced in this series.
The second patch bases on the dts in barebox by Sascha Hauer.

Best regards,
Michael

Michael Riesch (2):
  arm64: dts: rockchip: add gmac0 node to rk3568
  arm64: dts: rockchip: rk3568-evb1-v10: add ethernet support

 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 69 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 51 ++++++++++++++
 2 files changed, 120 insertions(+)

-- 
2.20.1

