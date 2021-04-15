Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E160E3616A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 02:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhDPAFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 20:05:04 -0400
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:13951 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234874AbhDPAFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 20:05:03 -0400
X-Greylist: delayed 1870 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Apr 2021 20:05:03 EDT
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FNXH74002899;
        Thu, 15 Apr 2021 19:33:17 -0400
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2053.outbound.protection.outlook.com [104.47.60.53])
        by mx0c-0054df01.pphosted.com with ESMTP id 37xgw48d6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 19:33:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9IlHv3DC4g08bcQy00k/SXMUCDVVkAAt1wTjBZpOXn0izRpd7XwZTmWUYW6wqRhuZosRJFyoF7b/gHBTexxuxmUFY1CC8bxJ0GcJgXFzFFHBbKpePUHvosCB3BiY7KY3+8CXbWk0A0NV9UXXvpAJhNnq1e49v+ZUKORBJ2mHn4H/kHhCFRXbldVYUHGLjRACjWkjXbEN9eRNNXkaTY7+P9cS6H7P+3jLURn4AgnQwBE1iFbwr8cW9qAHKnKPkyvPj8kd1YTqBArRGi/KObQmcOQ7VMUc1XI6/92lZKrTcjknjf7tNt7pdq9AXIEkKH64TH2BEE885w9k/yDfrwgMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5BXJD+ORU5n/5W166Jvdv619cd+KiieAJ0rHMj/ae0=;
 b=mm63EzSviWMtjZmgBZd4J5AGuNQVFwVdujWXJ+60wxWRWeXtzY1IB9DZfyPZiHBQzpUga8qtgKlu0TWSqge+o5LhYhHAU9/tflPapiUjw22uOhuebow1uaOY4ug2Xjvg8dB4fdot7TuzkLQtXjLg/PpU08gITXMMp1cp+M1FOy7MDElqOB64QbMMzA0Rdm3BJfwatjOXa0HqLgsDonQCjQQ0DsM1OACcU7g97HUGEULxLWxgO9+v0eato5l/uG44EVO2om7fR5FxcSaY4/lHK/7SYb+fdfG5PpS7PJgGxIUaY5noG5/OBiI8FBAxoUiJQPRSJwVvIXQrilMcJk5R1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5BXJD+ORU5n/5W166Jvdv619cd+KiieAJ0rHMj/ae0=;
 b=vgpnqq9JKP8GBnESJ2D1NBYT8r/d7PXIaO8p8bL1XKVXCupgLeayggVs34Dz8Jd3zFtiYbFBNxeQO4ry+ZKrZ+xlKaQwcxdTnOnri8NFafPe41Xq3JD852qTl0qPXokuJj27514AwKhuuclGJy49i56CeHspVMNO90jjQ77KV6Y=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=calian.com;
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f::20)
 by YTOPR0101MB1755.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 15 Apr
 2021 23:33:16 +0000
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90d4:4d5b:b4c2:fdeb]) by YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90d4:4d5b:b4c2:fdeb%7]) with mapi id 15.20.3999.037; Thu, 15 Apr 2021
 23:33:15 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH] irqchip/xilinx: Expose Kconfig option
Date:   Thu, 15 Apr 2021 17:32:50 -0600
Message-Id: <20210415233250.4071772-1-robert.hancock@calian.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [204.83.154.189]
X-ClientProxiedBy: MW3PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:303:2a::28) To YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (204.83.154.189) by MW3PR06CA0023.namprd06.prod.outlook.com (2603:10b6:303:2a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22 via Frontend Transport; Thu, 15 Apr 2021 23:33:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5eb982e-ae7d-4b2e-0fb4-08d90066d7d4
X-MS-TrafficTypeDiagnostic: YTOPR0101MB1755:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YTOPR0101MB175515A10AF43459D54ABFF5EC4D9@YTOPR0101MB1755.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1g6Pfe5AMPAabU7hX6AeRnbqee5LGckuYIc1o8hboAQvuchCyfFWoIgVDYQx/DyXYrV/2worJuzE4hhgmF4hip6uMTk9XS+LZaeZBNNiPjlzl2s9xN5YY+oTXXUmnROpz+e0ZtStdXuHePWrlOEwhtvS9hj9Alf7jW6CvszACP2zzHAFxxs+5SrLBmi7Z5bTpqZaYS9t9xpnYIrYi+AnLRiaDgDuJZoa6YQPkkrsXK1NW6gireEda3M8JAwqF+k045paaKG7EFomYBds+ZaEqBRa7gv0a1f+vLp2xbWZ3GUCECmbf3ZtsU1PeQfeHfNs0y1DVt5+67rZ497ItC3rvapLQPPRQ8Dg1KTOYzY9HHJNnXEThSByB/oYRCHklxZVuw7divAoaq1j846tqtu6rxU0s2Drwg9qbUA+/JYcodSAsh85tXMzkDbuUiaVQDDV0KAW8+MGVwl+HjiSX6Zobc5ctXBsA2gJ0D3tAYTmOp1hHHQtX17QCUPcU1WbvfwRQnofe09Ft8M0KOjEFnLTy6DdWvkl5ygw6/8T5xVyw+Z8HIHtgxWEefwaWYA5I4+7elxtFc8zw4XHrZ1s6c2SfGh75NRT/ilYCqwxZmcyEHEkU1YxJILoQXNZYtvNB3x/6QBQrenLZWsdi8DbWIt86B+Y1Hv/jBxHkDc8pNJkov4Bvpu94tRHSy2vpApEU6d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39850400004)(16526019)(186003)(6666004)(69590400012)(26005)(1076003)(4326008)(4744005)(36756003)(478600001)(2906002)(83380400001)(6506007)(2616005)(8676002)(66946007)(8936002)(5660300002)(52116002)(66556008)(38350700002)(86362001)(6486002)(6512007)(66476007)(956004)(316002)(38100700002)(107886003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Fc5FNGuvJh8dyTtyXpfXvMK36VgQJPLpHXrI3VKAl29tuZuYNNIl+thOKqA3?=
 =?us-ascii?Q?oI9e0xghIN43BCbAc6EA40h8DI0h2UDC3eu6BBhvQOPnjDuNfRz6tGDNpAD4?=
 =?us-ascii?Q?3D+eivfMRgQA41pNNp2HXVtmFeF5e4rRSNRK6nc2QJK5gjoVUpmDVFcQqrNx?=
 =?us-ascii?Q?bns4UZZvU+ojzc1c3Zkb4pWL1bUPpPZyadujYgomO751aLn3LvMU8AVRUGio?=
 =?us-ascii?Q?J9K+/NfC2Xl0GBgRGhAhQRf5lnbmT4tYIft9AIg1gbJZqZxjJpgUKfWkXiRy?=
 =?us-ascii?Q?EXKHyTXzs0DsM/psYa18iV3uFMYo+aLpAhNUEJEzAUoP8uAMTyOYBWwnlEE/?=
 =?us-ascii?Q?ic5PTP3b22LM0mJFh1x5FKStQJbiI6y7Akz8Ng5ObDX5cub8/4BjERkb3jic?=
 =?us-ascii?Q?uF8uT3vlQZKT+7VTX+RQ+vbRTdhwBZb9Dyn7WE2PQ3CleKuu5GhqHrRPPK/9?=
 =?us-ascii?Q?2gFXhOnpq3puZ8utvyxnjOmyAEGcc+t2MGiiAqzpg2TqXa9SDuVQZk4vUKKE?=
 =?us-ascii?Q?lu0bd8/J2b2NKaokB+E708VT+C7F2NGB2GKV5QQXA3HWyLjW3+fi4H1px8CZ?=
 =?us-ascii?Q?j3xYu++mF51nYZScIqLdF0fJavM6eaosWc+LX18PSQwvRZFmLupnlZNfsGeU?=
 =?us-ascii?Q?6u+8UKT3Rm/BsbGL7Ul6a1MNR/WIpl+b978IKxDaur91pdd3y9hRukXKm03p?=
 =?us-ascii?Q?ywegmBo8NIC5N6dirHkoqu6Sok/bNGxA+iEvqn4GbMBM+bVKvT4tL799+mN8?=
 =?us-ascii?Q?LynKHQmWZeHMb/VZTj9K5vZzgXvfUQMflT0sRCZFl8U+QRlb9BJqbClhF4P+?=
 =?us-ascii?Q?oLcM5FZQqJnuyQl+lf/Eo6qEvv+uz7RW34Jj2Em4G9OG0nYSLW+zMj9Jlyg9?=
 =?us-ascii?Q?ApOeV8IqzmAeBUBc6e5j/FhWGzwJtXG2Rvqd7CkSONpIaZKuuhG4imjU3U75?=
 =?us-ascii?Q?yeSlCud8YdGOYnCGMBW2o/8q+nPhvZWX4xwkJDXGGcvDo7vD/XxYO9n48pev?=
 =?us-ascii?Q?hih3/+ch/JofXZ5Zfg5UqMT0fkZn9ayNB4xbFpUyQssKULy/cH0nCA1CIQRz?=
 =?us-ascii?Q?qOjSq4yFSGrMWhuyq1EvHXfOgvUARLGaHwvKu87nypK2wkBFpm3ATEG/Shp6?=
 =?us-ascii?Q?fU3SDYQm10LAfPW4E2Y1/dEgBZHteCZthUved7JFwYhUybY7EA4Hn9C6X0t1?=
 =?us-ascii?Q?/W0LxHjP1Qyxjgs9JerY/SGoYsxVxXDQntN98mH2OBzKKM0XpbBZxCmk4aRN?=
 =?us-ascii?Q?auNHgS0ypLqfx0oqBFLLp1cPzkspGW1PDmQBsTObX26m8R+Ar4ZYtV75Tws9?=
 =?us-ascii?Q?S68VLlg/t4DTDMYgv3NBhv0F?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eb982e-ae7d-4b2e-0fb4-08d90066d7d4
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 23:33:15.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RR369oAUU9uFvBoydN0kCOVhzRaezdIA4wWgD7oz3X+GN76F5QJ2uD3YABqufzKH/UuNXJY3lveAx85GV032TqR9lqqv9qUV9epR0xlJLVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1755
X-Proofpoint-ORIG-GUID: BhOdSyp2AqsyRTbzE7QdHYWUEvGSFIyo
X-Proofpoint-GUID: BhOdSyp2AqsyRTbzE7QdHYWUEvGSFIyo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_11:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=543 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150146
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the XILINX_INTC config option was hidden and only
auto-selected on the MicroBlaze platform. However, this IP can also be
used on other platforms. Allow this option to be user-enabled.

Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 drivers/irqchip/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 15536e321df5..cc24f1bd3ca7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -279,8 +279,12 @@ config XTENSA_MX
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config XILINX_INTC
-	bool
+	bool "Xilinx Interrupt Controller IP"
 	select IRQ_DOMAIN
+	help
+	  Support for the Xilinx Interrupt Controller IP core.
+	  This is used as a primary controller with MicroBlaze and can also
+	  be used as a secondary chained controller on other platforms.
 
 config IRQ_CROSSBAR
 	bool
-- 
2.27.0

