Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87234414917
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbhIVMjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:39:43 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:17164 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235952AbhIVMjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:39:37 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MBEDBH011057;
        Wed, 22 Sep 2021 05:38:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Pn+ONRhDrN+XJuXdTErvrYgXtKA5TlomWd9kQ73TZDU=;
 b=WDf7J5SsIpzGrK6tEVcVkUnOwwr6xSuyKqjzx/upOzC/0MxyoFa3y64gDL2d5ypYKj67
 42GURN6Iodyu2AoTD4NwZ834gFcn9SipZdBwo/Pcf0mLvsBW8NkSmEDnhJ4VBMZSDxwr
 EAizir4JjxV43NnnekfrRskkc5FcIC3RYoBl3aPGmcNwlUqqfZ1XwdLPbNQr96x31GAS
 6fcE6njH/d9B52eOUKxgiLfEs03fPfiRIiTCru4Q/ahf0VaBqNjg+mZ8D0UVv7uLRQF5
 FX2A2gugXxSF4qLuUJBHOvaqQFItW7xadE9TxQkQcyApG/8Z0S9eTTiE6bp9w1HGxP0Q Qg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3b7q41a4yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 05:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIN5pXHdSgOfIz8aNsiXAE74SkAQt5gcfHYFOT8O9q4o850EaFrUeS0yt/UEaDhh5e+17VtDakM8RkLbGRsrzBvYebG6KumBmSIe7579RwP13EWtDuMBNXLIUe1Es3xKozxUe1EHMgWQK0uljqxgGGr9OFld3IRVtj2G4HidqosdwsIc668dSgqRMHgjT8eUoErgm05RQEFcYXADrTFgdbw9YKE+IuFqsBF9ON6njODsODAWRqyh6ZpQ/fdD0uRwdN4qrVLd46L7zzL+Txkdj0VkuQc2EwyavQzkoUQI9BrqS8mGvdCjtJ7PsJaB7nScEwZ3tgUkED8l5l8oSJkDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Pn+ONRhDrN+XJuXdTErvrYgXtKA5TlomWd9kQ73TZDU=;
 b=Y5c0QEMS7JI72RRhpCS8IkpdRmkgNOIjsBZ0VGihOzlYhJm1l8e3PIZgwEBPi4MmDAipK7iCtWLUqv8stiUV1Gp3/QJ/7qmGIYjFiK8JMrVWFjnWB3bWMj8IO/TAUBAwo42SyNSmONTR5UvCI6nKqjTC1NGDq4L1Hj6H4UfIKcoDQbpv2qDWUjUjUj1VmL8tsw4MbptGFHl1EOU5UzBQQn+kACs8rCEspQ9oKk3JThS/hI19corKmqD4PvdP2YaTnRzcMtkI6QT6NnsKVHd8AA4VUO4xnkIRCZR8+kMZJ/lxCq+jZb32y/224syJOEU+mE0M6vxlkknBlUoo6w7mhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn+ONRhDrN+XJuXdTErvrYgXtKA5TlomWd9kQ73TZDU=;
 b=iKcFpX8rQkLa2PDkdGUmXEwcPK48GKDlLYdW7ZmWYjUzdXDBkeX7IZ6UHJW5crGGx4rSyPcMeb02GvpC47Y2NPO4B4/vxhOUletnOLmCJ3xN065EVfIpvrgRVcNiCt2U7FuFu612B5mqxNz6WybX5Ew8nX3laH6B2X1QZ9mmnG0=
Received: from BN9PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:fb::34)
 by CH2PR07MB6789.namprd07.prod.outlook.com (2603:10b6:610:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 12:38:01 +0000
Received: from BN8NAM12FT055.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::82) by BN9PR03CA0059.outlook.office365.com
 (2603:10b6:408:fb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16 via Frontend
 Transport; Wed, 22 Sep 2021 12:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=temperror action=none
 header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT055.mail.protection.outlook.com (10.13.182.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.6 via Frontend Transport; Wed, 22 Sep 2021 12:38:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 18MCbvKl003390
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 08:37:59 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Sep 2021 14:37:38 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Sep 2021 14:37:37 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18MCbbfA021969;
        Wed, 22 Sep 2021 14:37:37 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18MCbaPL021967;
        Wed, 22 Sep 2021 14:37:36 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 0/4] PHY: Add support to output derived and received reference clock from Torrent
Date:   Wed, 22 Sep 2021 14:37:31 +0200
Message-ID: <20210922123735.21927-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86849e35-02ac-4cb0-11dc-08d97dc5d01e
X-MS-TrafficTypeDiagnostic: CH2PR07MB6789:
X-Microsoft-Antispam-PRVS: <CH2PR07MB6789DA515F0D4126052DB69AC5A29@CH2PR07MB6789.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oOlg5+mSflnG94v1OZIrRZCV6rJ85pYdjF7eV/wXOr/pOvtS/1q6jPgZ+8qZNcpTj7gQltBFvjsysKTPnrZR1yiELahTCRgB66/j3waz8r32h8/G3I6ULuXuwWtD05wT+PiYPIMZSwlWbDTD96Zf1fzKi87LTfKJ1PL52O3aFfEzuymO5PCtX4g/2iTb0zLmYtPBqTesXF2MgUP4QLvd0cJv+pbglzFTrYMDwVyveyX+r/0bCIxCqgXLJHcXjEOSbz0ojSP7/fI0hi7MBvYvjOoY+6TOSmZtI+DeTffxjf2UklG1cUNhgphnn8QPyemuCgILgaeMw6BF/WWN/SnbZg8La6vnh4PSwX8QgZH0jS9La0p0EGyZVh0ZGQ5IDb7BIejO0QExqzSK2mD5GIojhoJrm99ykWDSMdOJweUX5D4vN8rLZ6nTfjR2MgDBT95SQYshQ+Gb3Zy6I23lZ90iMEHYFkKuwmFzrUWYY8wSSdJnI8zyq9kb9saNNxKi89INTDr0FuKd12/oc1nrxEM1SHZysuIX8Gnx+oXG8L0P5V1JjujoE1D4DjCmoI/sofkh5oPN/kGI/Et3wJ9ZRXAGRjSrElvnzKCpaR67avRtoO6N56XFV7ZrP3M2EnV4NKYMbWdNpVti0GZdHxHSgeqPt02eyFkkU2ksN/h95VeUbm5bwMAFnQFV1+b7LnD6+RO1PJ8p4/4KiOwJ0Lu63GGQ7hsw6JEhGLd9h2x2IaGuKU/2eDYUIIPQ8TEPJplpgBZQt5YjZwvg9c5m584HeDRrC30dg4+RS0G2YJJVItgvK10=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(316002)(42186006)(8676002)(36906005)(336012)(6666004)(110136005)(54906003)(356005)(36860700001)(26005)(70206006)(186003)(47076005)(81166007)(5660300002)(36756003)(2906002)(426003)(2616005)(83380400001)(86362001)(82310400003)(4326008)(1076003)(70586007)(63350400001)(508600001)(63370400001)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:38:00.3016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86849e35-02ac-4cb0-11dc-08d97dc5d01e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT055.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6789
X-Proofpoint-ORIG-GUID: -GQ-TgFEg-hkl95c-oDX__9QozcpU0CJ
X-Proofpoint-GUID: -GQ-TgFEg-hkl95c-oDX__9QozcpU0CJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_04,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=663 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109200000 definitions=main-2109220089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series updates reference clock driver implementation for Torrent
by adding support to output derived as well as received reference clock.
When reference clock driver is enabled, either derived or received refclk
is output on cmn_refclk_p/m.

In derived reference clock mode, cmn_refclk_p/m outputs the refclk derived
from internal PLLs while when received refclk is selected to output on
cmn_refclk_p/m, this is the internal reference clock driven on the
pma_cmn_refclk_int.

Version History:

v2:
   - Removed patch 5/5 in v1 amd merged its changes to v2 3/4 and 4/4 to
     keep TI AM64 functional and to not affect git bisectability.
   - Added reason to move to clk_hw based API in patch 1/4.
   - Added Acked-by from Rob to 2/4.

Swapnil Jakhade (4):
  phy: cadence-torrent: Migrate to clk_hw based registration and OF APIs
  dt-bindings: phy: cadence-torrent: Add clock IDs for derived and
    received refclk
  phy: cadence-torrent: Model reference clock driver as a clock to
    enable derived refclk
  phy: cadence-torrent: Add support to output received reference clock

 drivers/phy/cadence/phy-cadence-torrent.c | 316 +++++++++++++++++++---
 include/dt-bindings/phy/phy-cadence.h     |   2 +
 2 files changed, 286 insertions(+), 32 deletions(-)

-- 
2.26.1

