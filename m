Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8632369A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243329AbhDWTAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:00:17 -0400
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:9292 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhDWTAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:00:16 -0400
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NIw2xx004721;
        Fri, 23 Apr 2021 14:59:26 -0400
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2054.outbound.protection.outlook.com [104.47.61.54])
        by mx0c-0054df01.pphosted.com with ESMTP id 3834jxgqvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 14:59:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjEXChzMuvOLQxUxt3JFsNUc/IQ1R/N8k59ApDf4v/dUetbh8QQ5sizbbjyKF8KZFHpqTXBtpDH/mV5kQ3eolla15BjrHlypIgPWVl5XGKoFlq0021XYVL/I2I0YeTOZm+76z8U0FByikwsRT5hd93fwP29H5lg9b9lco+71I9vOQSlr61rt62ACzGZHlge4PyNOhASRSZewgbH9fmFSztV5P1YE0Zc3lYSQAYkHh2WzOD8CI8FM7NUHJIpFv7aJiX8J8xLDxpu2p1ylnuCMNcHuZm7z5pz5Nc0ML0mEe5iy+3vI/iJFxIHdbkn1UzTf9z0sXvjcbFT8kf242Uvf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys9RHRedlllb8OuRZZuSDhj/RpPOcy+7OaAq4dH1BRA=;
 b=mG5wD5+5g4aEqSSBpPJaxZM1P50uXbrw7UgNvahhC3VV6SmA40+58Kv/9BsuXuuEh17d37gEoZZDJ3m6Tgv0eeXD+kzPldy49TmG9Ip8wruo/EkueIsYPZCzXu+p3vUpGrI0l511MQoX2EZ3AE0GgpQbJPCy10i1AnK+N54UrY9f8lu2LIUgQsxjCAbX+FXhGWdWaU4eRivUStn9qMEgXSI+j3NUkH0yM/Z0ae/y8XRYMI/0NKsoYXKzh6I7HVOsqupMHQTY5LcGP/d0TleVGBoXQMXZqDeZ/5iF7DPZtpYpbMSZsT5OGD0grBknsjnWJF+d6ICgaEuf3LgAcc4f3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys9RHRedlllb8OuRZZuSDhj/RpPOcy+7OaAq4dH1BRA=;
 b=Hp3nAZr0liFaanmTIEb+y9dz1O7sTOAuzO2MoVpdrYSFrVbTS7qSHuAFi1IZTONsPjs63btY05944PLzALDfh3mRrb8YcYqq0NzhaUP/erK8zKfDBVZEPJCg+ExWFfiIxA9hWdHn236w1dptLWFZOBVl9Z7IWR3YVC0MOybJBJE=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=calian.com;
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f::20)
 by YT1PR01MB3705.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Fri, 23 Apr
 2021 18:59:25 +0000
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90d4:4d5b:b4c2:fdeb]) by YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90d4:4d5b:b4c2:fdeb%7]) with mapi id 15.20.3999.038; Fri, 23 Apr 2021
 18:59:25 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        anirudh@xilinx.com, Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH v3] irqchip/xilinx: Expose Kconfig option for Zynq/ZynqMP
Date:   Fri, 23 Apr 2021 12:58:53 -0600
Message-Id: <20210423185853.2556087-1-robert.hancock@calian.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [204.83.154.189]
X-ClientProxiedBy: MW2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:907::39)
 To YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (204.83.154.189) by MW2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:907::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Fri, 23 Apr 2021 18:59:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f9e8fec-d6d9-4d09-9f50-08d90689e9c1
X-MS-TrafficTypeDiagnostic: YT1PR01MB3705:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YT1PR01MB37058D425D656DDBC08C65C9EC459@YT1PR01MB3705.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbDRLg6Y8gOvhyWwOziwmCqp4UMjNhHAaA7y5wdbqKtY/FpnaF7Oj4WbazQHtRrR9p2lW8ivwG7n34GoOwjJoMLizIxjRDG8a3i/DXgrrUBqPAiscLePYSJRaN2ywLJkX/LFkKKhfrqhT8ZR/oIzdDtbNA1H9Ox078vCKQ+hRA0/VeX2drVvOmFAb4Mp4ie2YAFW7TA3Az56YorxvU/XvrQFlFj3oBjpLV9dDbMqiqUcou4om/qIieLPDABSyzpBJdgxwgC4VNZ9q2pEWd8goqPn0mfJglzvJpRu1Gk6AB5k8NkzBpIVlkHDfHBlGjGHFTDxo4eFd/6+YKuiQqsNTLHvfc4v621B7hfHd2XaRXWgOllg684X2WlEAhd6B1E0jiHvZJxMFX4Xr3FtwbvY8CDZBdIbYgzymDywLuLkRAQNfx5y+yVbSwFsxZbzN/Jel0DNVyHGPwk3lD7S3gud5I0MFd9N0PCFuYbS6hKbR7OvIdDcESE7zssu1lJpNzpxaRoythO9i+iudglFJGjHLHH9fPHSWeKcGn7InhWTISL2pr+3EK0bztpIM/iGWwfN9nbjys1rOxaNfl+3vdmjO3JQCx7CIbqiN3BmmvpEa5BHN8Dg5a0StQQFDAms+eLFUh+DY71r6x+fTlmF3s0xjpPbRgjAQPhfOF/wghiUDKX+6NRNH+gQtQvtJwSqhwlq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39850400004)(186003)(6506007)(16526019)(6512007)(316002)(107886003)(4326008)(1076003)(52116002)(26005)(86362001)(6486002)(5660300002)(956004)(44832011)(2616005)(6666004)(2906002)(38350700002)(38100700002)(66946007)(36756003)(8936002)(8676002)(66476007)(66556008)(478600001)(83380400001)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?03NlJ62kuz6vkZmSsg4s0LO4lTpcgpWK0veDrtJ75rcTd2gqeZg2YZXMugMs?=
 =?us-ascii?Q?k3sZmIymBopOo4jWr3ZMmpwLgVKHohCSwmS31c403IoS2LNqCLVtP8hia/Iz?=
 =?us-ascii?Q?fPfwf3FqI56AARl3q6VZthKCNI118NaJRks3h1x3nrzl/kuTe9zu9tMcayfq?=
 =?us-ascii?Q?Pt+WWpvuB1uxtUsXFrQTN3eGRLTlo+UQ39UE0SjbjXXlHeAEKGsGskho6fg0?=
 =?us-ascii?Q?hyCrRVvgO5R1fMFSneSmsvSU75fOVVpMjNIr9752vejr1Fz+LXwKQFQNimQx?=
 =?us-ascii?Q?usPStu1QC/KQ+q3abF6Cv0i0jYs74e7WkDzSToVucCZUsa6Y5t4CWOmBY2rw?=
 =?us-ascii?Q?sB2spj/tW3esw/PVrlSpQnmBl69Wa4go2bS3ZTDDy4vH+A/bkP3h8U54kif0?=
 =?us-ascii?Q?VvymzsC027JwYcD/dFQMv+rHnYbVaFN9cqnUlK7Zl1rPNKmLo1ejc7uRVkwg?=
 =?us-ascii?Q?Oz7XdI7A1IeZH7LGkGpJkEVI8rbnax7EDu7h4aVQZq/YwJIPrR9TIZrCZmOe?=
 =?us-ascii?Q?UxSo3qJ/fD2q/7/hhgxSXMAm9qwmxY+DztMbnU6OcTzGzwoODwHxy+oFE8F6?=
 =?us-ascii?Q?dY3LujzO3v8zf6MJhd1zBwmcQSRa0zlUItfWqex/LFsJIVbHJ5Rnx+mx7dLL?=
 =?us-ascii?Q?67i+RubOOZDFihxjbpIP4fD2eLq41G2pvuZqR1en7sRED/iL9q/olHbjCQPA?=
 =?us-ascii?Q?wgWNGJnGU4G29kbnC2NSENSgBurOh+bDy+zs6iK7ETjNrOBFRwp35ugy9zZN?=
 =?us-ascii?Q?YYZveSePaixMyyfVIpylSxNhbaVV5jItaSP6OujlDRlxIaNqPTkX72kfvzN4?=
 =?us-ascii?Q?aoru1CoJuilukusUFyntQuvOfr3yEXuvBLGOPZERis+Ej7PP3M4O+Np3TJNW?=
 =?us-ascii?Q?HC+cwKJbq1PVsGF0M0uz1ywkRGvNbUeanrMN+nE2QIqpEDe2hVmQaD7lGt+q?=
 =?us-ascii?Q?+w7OsjkziKTtTR43ZZySETXRVLGQN4ovoqrkeAJCNnzMbifCc8K9CqH0PLpr?=
 =?us-ascii?Q?t6uFSAwV8S2vb9OMj1dw60Wu1qrDrXsTnstmNev8XxPJYuOxOKNGcrrK5DHR?=
 =?us-ascii?Q?/P43UyW/XP+Nd02DlZuv5APxbL6LEyREOLB6r/keEHHFCsHgxwihq4nwP4IS?=
 =?us-ascii?Q?Q62t4t7b3MIfFr+Y15OW4nCgQxGuI+MmJLVWUWX5IA6vO3K7aS7V/Cg8gWhH?=
 =?us-ascii?Q?dd2vduKo7ciZivFBLFCl0uP3JiTLgEMy9ZvoVP4ZGymizsACawdUioZXuzrm?=
 =?us-ascii?Q?81d31oYOOrjL7Npgs//3MIrVcil6AE0ldWH19ZX/fbhSeic+mDaoEv3LRFCc?=
 =?us-ascii?Q?KZ2hzT37Ze26FdtRZZwuFHGR?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9e8fec-d6d9-4d09-9f50-08d90689e9c1
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 18:59:25.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5Cr/cxCkp77nh9zSYfZEpN4hTQYQQhX/+23Dp5zS1VkA7VTL5Q8UuK/j0XVPBzWq4BmB/iR8yvZzgXAnkkqFn7u4oYKtLSXAigTwaFtVJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB3705
X-Proofpoint-ORIG-GUID: xick86VO3CSnn9EDvt6vxLu6Wk2YAhKM
X-Proofpoint-GUID: xick86VO3CSnn9EDvt6vxLu6Wk2YAhKM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_07:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 mlxlogscore=483 mlxscore=0
 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the XILINX_INTC config option was hidden and only
auto-selected on the MicroBlaze platform. However, this IP can also be
used on the Zynq and ZynqMP platforms as a secondary cascaded
controller. Allow this option to be user-enabled on those platforms.

Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---

Changes since v2: Removed COMPILE_TEST dependency

Changes since v1: Allow only Zynq/ZynqMP platforms

 drivers/irqchip/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 15536e321df5..53f81a0d161e 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -279,8 +279,13 @@ config XTENSA_MX
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config XILINX_INTC
-	bool
+	bool "Xilinx Interrupt Controller IP"
+	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP
 	select IRQ_DOMAIN
+	help
+	  Support for the Xilinx Interrupt Controller IP core.
+	  This is used as a primary controller with MicroBlaze and can also
+	  be used as a secondary chained controller on other platforms.
 
 config IRQ_CROSSBAR
 	bool
-- 
2.27.0

