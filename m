Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A0C3594AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhDIFfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:35:23 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:19606 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231515AbhDIFfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:35:03 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395Xwe1028333;
        Thu, 8 Apr 2021 22:34:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=fpudZ8Er7OphgDd1jxf+B2mQW+6m74U5RgkRJa9wAdg=;
 b=eLeoi2+8t7gLRiTGY1cZrw768dI759ZCLL3BVQ6lDNAYt04tU6q+oOnlerWF6IQlPCFL
 a12wxwyI/HyYU3K5rB0Xxns6HlWl/iFJ6vkJ5QHXIxDJrjEgQWgXLwUQpH6GtpRDRjf0
 C2B78DgxpQdPf23ORD4uARV9uRjg8tWMWY3BJxTat7GiYHhKvRTqaZD6nYwCioPQidI0
 sl7VkVA4n44DY0XYDVIm4VXOYQRTq+PaKQAfEKY+KzY8BUhH77azlUUBrs1Zms5tseWY
 xtMptfpRqXKiwkXeKE1t2t31VEFZuD6j7aB5e2q6fJEtveVydV2B4UHqL00UQdDEJ7VG rg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37t6ns1sqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3HulAA1KJDX4OcYQpqETLXtrki9+5y8RBElsAo7plweFJoUyOuBCE0ugPsRXtGg9kZh6buozBYxTlPMpAExomB+JsWNHc8qsKtKEaCb3uDBslOOA+LI/vIrgVPsfrozWT4U28WMwofouIcaKnnnNougBDeTKMbOkPzrCJYCWx9OLIqpFbz5cEkCz85yMlUnLHDdrLhlHe75DN4xQfjvbr9Gqhl7R01cgklineuZ9s2uziCpQF/FRcbH5i+S5G19MEfq+JeucqxQvcuMmbpAEw8SavFk2NGNHtkup3PmI0lpVzAgsUdaZQyp54J80nCG0YGSXWXN1ThUw/NSYt1mjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpudZ8Er7OphgDd1jxf+B2mQW+6m74U5RgkRJa9wAdg=;
 b=QQD1enjz4N3JY20YPgo/rrx5SCPNt238wHdDP0Zr42H8he0z2EBjlpnWTU4Dz7aYzQwQDgUlbCMMRRK+/rCNgpMKaOQrhRY8irsNjBYgPut8A770pXx2cGgoWlBlcQ76b0d28LSnpo9JE18xRfYDkxOFqjSWbQvYf0Mwe0mQAhNS6LreNOdyIDHfJxDVtYQVEulk/oJwKyXZ9VGAiwrxfyMs+6V6JpIwxN8owh3mHfukutkZ9c9x/31eWjELq74jPOCaOYE4XXyR9x65sBSzzIzbf1imxxjRZRej6nvaOxDGFiZd4kkyqz2u/iaB9onvwtfWhmOf9Ac1N6Z/ALv0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpudZ8Er7OphgDd1jxf+B2mQW+6m74U5RgkRJa9wAdg=;
 b=iNg+A5XarZq3HOChe1JaYAP05WqX4wp4f0CCC+P/2b6xNwyO+ZhCTjxGy8u/4crw9o9kAky43k/eUWabIaq5gaG3vdUNYQAgmoL3ZyKRbAxisKWJpja/zMTmiTVf6LEa1GJ4SQd9VTIHnVmdQ7+7vHpsN/GSNWki6R2HFBuhcbo=
Received: from DM5PR15CA0045.namprd15.prod.outlook.com (2603:10b6:4:4b::31) by
 MN2PR07MB6702.namprd07.prod.outlook.com (2603:10b6:208:167::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 05:34:23 +0000
Received: from DM6NAM12FT067.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::4e) by DM5PR15CA0045.outlook.office365.com
 (2603:10b6:4:4b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT067.mail.protection.outlook.com (10.13.179.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:22 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5S032749
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 22:34:21 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:34:18 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:34:18 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YIgn027822;
        Fri, 9 Apr 2021 07:34:18 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YGfB027815;
        Fri, 9 Apr 2021 07:34:16 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 00/14] PHY: Add multilink DP support in Cadence Torrent PHY driver
Date:   Fri, 9 Apr 2021 07:34:02 +0200
Message-ID: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95163274-a9c1-4e33-773c-08d8fb19219c
X-MS-TrafficTypeDiagnostic: MN2PR07MB6702:
X-Microsoft-Antispam-PRVS: <MN2PR07MB670210A36E081BDBAE0FE0C5C5739@MN2PR07MB6702.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRG2oJvjGqZr9d/TOVSoc87r//sH1r0o4e9m/8NfDQ1xCKvLHxwhbMXvWGL6T6AE4Oo9o0D9trjeRyxMMRXlEHo3hkQ5uU6+Cv/4S9+MCkoWeEMPG6JJ3wICqMzn1DRvpuncYFS8HGo7Zo7ZxnjP9VTUucy44+ULL507l0nYDowxAso31YZwF+3rgwSq0KMJzpGWyZxth8Y2Do4TSjAWcweOUk0gFmSM0l44CFC2mz9TTvv8QHZE64vLp7ciH3wv8Khc4cHKsdfPfmBDN2C8Bcol8ZnLJDPPYjSmIvmGq2BJna2Zvd0XS09XeEsts50P8phalQjOuqZeEBfK1YxP/PIdZv34qWKoK9VbFYAxEpwhRkUEyHth87PBaOKiXhPgsLgh/SU+g9cZgv6LWdO38du2vV4sQQ06GroBhLChFAiStv7RVwWeImgsMVUggT8GFDeBN4SPecnqrI0Z+4vqFwj9A4TgzAAkOe9EPUAAmuZN6VuzuTChIC/m4+S98zGKAQCTqYxTHXHtpn/xJeiAuK6NYU7AX4tWhnuLcM+Lm/6q678OkgDruQDrPv745DbGiopKx2yrgr2BR/RvKPh/CwypYHkONXzFXGMPSjrmFb1WK2xyew7XL+uigF2lF4KE+O+k0fHYZ+bLacr1ksgZVY6NzWisv6mtQOJ9OQ4lOxKbOh7ezsLaEEWoqt6Xokp/NaWcI/pRAebFunxO2yT8rQ==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36092001)(46966006)(36840700001)(36860700001)(4326008)(110136005)(36906005)(6666004)(83380400001)(2906002)(82310400003)(356005)(42186006)(316002)(26005)(478600001)(8936002)(54906003)(70206006)(86362001)(2616005)(70586007)(47076005)(7636003)(8676002)(5660300002)(336012)(426003)(82740400003)(36756003)(186003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:22.8502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95163274-a9c1-4e33-773c-08d8fb19219c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT067.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6702
X-Proofpoint-ORIG-GUID: F70VSoYLyzuxD_Wrs58E6NRkpt3zwLqC
X-Proofpoint-GUID: F70VSoYLyzuxD_Wrs58E6NRkpt3zwLqC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=830 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables Torrent PHY driver to support different input
reference clock frequencies. It also adds support for multilink
multiprotocol DisplayPort configuration. Currently, PCIe + DP multilink
register sequences are added.

Swapnil Jakhade (14):
  phy: cadence-torrent: Remove use of CamelCase to fix checkpatch CHECK
    message
  phy: cadence-torrent: Reorder few functions to remove function
    declarations
  phy: cadence-torrent: Add enum to support different input reference
    clocks
  phy: cadence-torrent: Select register configuration based on PHY
    reference clock
  phy: cadence-torrent: Add PHY registers for DP in array format
  phy: cadence-torrent: Reorder functions to avoid function declarations
  phy: cadence-torrent: Reorder functions to avoid function declarations
  phy: cadence-torrent: Add PHY configuration for DP with 100MHz ref
    clock
  phy: cadence-torrent: Add separate functions for reusable code
  phy: cadence-torrent: Add function to get PLL to be configured for DP
  phy: cadence-torrent: Add multilink DP support
  phy: cadence-torrent: Add PCIe + DP multilink configuration
  phy: cadence-torrent: Add debug information for PHY configuration
  phy: cadence-torrent: Check PIPE mode PHY status to be ready for
    operation

 drivers/phy/cadence/phy-cadence-torrent.c | 3422 ++++++++++++---------
 1 file changed, 1993 insertions(+), 1429 deletions(-)

-- 
2.26.1

