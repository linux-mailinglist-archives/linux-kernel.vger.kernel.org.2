Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA9D3FF9C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhICFCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:02:23 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:61142 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232717AbhICFCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:19 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 182NR9oj011844;
        Thu, 2 Sep 2021 22:01:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=6A2NWcm8JfjVZfdFMwz0rsVXmB5JfJB1tuuSIGqKyBM=;
 b=S46nIG6BCib2WVRCf6CPuUw2dKYvVD8Ms/QNEmEOJdUnSI1xG09bfpCCgyGn+NQRytfV
 I9akCMUfW/0KIoXOLA09BBfi2Bp4URlhITKkG59O10J/PSBKhjWGduYglfuP5U63Suq+
 Sp8W+J+3Itru7QksjF6FYgwrUuKJd7nm4tSoRyPWgBMNWcFRv+XZj1bRAtjWUDdpKOqV
 7ySBvsnQpkzX3gZbLbOfEaQC2Dqono5Ecb7nTzsqV/UjTpBKtXpE/WnavQmS7FskAyeP
 tU2c3QG8rocepZoUznj8eKSC8xLCp4cx5OnjyW/37xxrZIJpVDC0C2tlY2Bug4C+u+T0 2w== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3au8a18u3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI+Cf7a+LwdK0LxqxJcuIfob3xGb88l1rRRfFwH1SX4xyP3x9b38QJ6GE9K3HsJKy0+qdKFjPBfmdJel3L1cbe2zHBNxRZe+sSMY6bY7rILyu+oZaw1IcQ7b1qDb+5BeFWfyJWZGT1FVvl3V3MdNi/DSkzopOpi/ytdDQ3e2GHeFe08G+IzEJh9nD32qbULpObbQBok6rJJ7TcN98tRbO2D9SQOnE3Wre70N8Dc+4MZxK38csm6h/BSjh7mU0uSL+SLqPdd2yjPjT8HvQZuS2Iic/Cc7lS9SRgHfiPhUtOEBB+w8nP6w06WyFU1qdpA9Uucb3WNWoP3siLMa3QoebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6A2NWcm8JfjVZfdFMwz0rsVXmB5JfJB1tuuSIGqKyBM=;
 b=cL5uP2ajKZ0+MeYGUX8Gmh+3/C+DfteF7BHdDbj3qHBolQRp6CsohDKCckzqcKLmRhm0nnB2zkbeHF+v37JoNaZyYRAgq3DA3uZJlqNQK1dTt/PMZIewPiEvNvCxTU0Wc4hfqM3IvhmdX9hsnaOQWA5fPr/CKjHdQvMzehWzcAUWtyxCu0Te57Rv47ohRzXw2O9NYoo4youcyyKh3ToslHZTvB2lxkIjXIEnfhyfxXpZ0ic0McwYQIA0JvRwDxiOt1hnWTCG/+y2ISlOgqRl5zdJlLVQxeIwTwVzWuTX8T1QERy2IJyQolRvYvapI6vFsoCqP+eeVSu6CdbqF8U+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A2NWcm8JfjVZfdFMwz0rsVXmB5JfJB1tuuSIGqKyBM=;
 b=PfRfMmFb0AKY2/NDEBHgeM3Nkv0WW7yYNHcqU6hRrNWs7W+6YOPylyfj61pMqOk750FOV4VclwExOeP/zUtP9Dk7LVkqiwMiyE1axh8uTSFGMsIXB9ZIEBskuvtBzvtqUKJ82u35wpVgVKU00H8aXbi/P80inbzpga2ffo6iqFI=
Received: from BN9PR03CA0146.namprd03.prod.outlook.com (2603:10b6:408:fe::31)
 by SN2PR07MB2735.namprd07.prod.outlook.com (2603:10b6:804:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Fri, 3 Sep
 2021 05:00:59 +0000
Received: from BN8NAM12FT060.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::ad) by BN9PR03CA0146.outlook.office365.com
 (2603:10b6:408:fe::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Fri, 3 Sep 2021 05:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT060.mail.protection.outlook.com (10.13.183.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:00:59 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ufT020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:00:57 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:55 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 07:00:55 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:55 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350tQK025668;
        Fri, 3 Sep 2021 07:00:55 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350sMh025667;
        Fri, 3 Sep 2021 07:00:54 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 00/14] PHY: Add support for multilink configurations in Cadence Sierra PHY driver
Date:   Fri, 3 Sep 2021 07:00:40 +0200
Message-ID: <20210903050054.25627-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55a969a4-c675-479c-d7a8-08d96e97d21c
X-MS-TrafficTypeDiagnostic: SN2PR07MB2735:
X-Microsoft-Antispam-PRVS: <SN2PR07MB2735CD719339FA527E29C11AC5CF9@SN2PR07MB2735.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vitKwSU2FZQNxvE6OBeEXognJJdJggv4rPECxid2gvQPw4ih45LoYmyXyuTDYWwey1zkbloOnzsedP1sI+xo9xdm5pG695ecPlWEEy54XE52xsgTjELxgskNthBKbZ057bsyMC4xgJWc58IqEow022wM49mukikH1JVryH7f8/TItLUwEXdLDxfZRPBTlHadtoYWa0x56fLNYVrNiRxNv595/L4t/5pwn8C0p6s+8WOk7sNGjidupi5YyehSeklr43soN9jTmLTGutu2OwqaV2vIoBtYDSgZEcQfCXuQWeb+rG57h/GEatUzDt4iaonISB59INTBDrPsTEONnauSXqipK+UqNq04y8zA6uMddgqWNMsDMuW8ClsHoEktStvpzuWfgOQf7NVws8MgiQh9662lWdFq/SUX9bubPcqWzTNKxgTR0qrbAtrtYV/5B5ClHSxBf8bHKbLN45b7LyRxBc1/Ga8/cUD3pK8N0kttmRkowZA7xCjj5Ke0souqD6hTOjdVkzFqBGWlmkwZchXiNoBquR4KbvahkxLziNAIvNXdJb9/NLaDE3RBgs15w5C+gD8mOKwSa6gl6iiC520hNPibBUZaoS095vpUaISotfZ3yke/FTTW94qtdte2TlE3xaa4zGOq4nL5xkZP1kwzZB6BbS1A9TPLV8brxr7eQgSnRBj27b0/th8vbzQ0MktuBpEiVqPEtUyUp8SrhTUf3FkpQhipWMskZqmR7nPbW0A=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(26005)(5660300002)(110136005)(316002)(36906005)(186003)(42186006)(54906003)(508600001)(70586007)(4326008)(70206006)(8936002)(8676002)(36756003)(2906002)(47076005)(86362001)(7636003)(356005)(36860700001)(426003)(2616005)(83380400001)(1076003)(336012)(6666004)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:00:59.2579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a969a4-c675-479c-d7a8-08d96e97d21c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT060.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2735
X-Proofpoint-ORIG-GUID: X34uS_FmtTqSbBEV-p-xJFQG62k1EJPW
X-Proofpoint-GUID: X34uS_FmtTqSbBEV-p-xJFQG62k1EJPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_01,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence Sierra PHY is a multiprotocol PHY supporting different multilink
PHY configurations. This patch series extends functionality of Sierra PHY
driver by adding features like support for multilink multiprotocol
configurations, derived reference clock etc.

The changes have been validated on TI J721E platform.

Swapnil Jakhade (14):
  phy: cadence: Sierra: Use of_device_get_match_data() to get driver
    data
  phy: cadence: Sierra: Prepare driver to add support for multilink
    configurations
  dt-bindings: phy: cadence-sierra: Add binding to specify SSC mode
  phy: cadence: Sierra: Add support to get SSC type from device tree
  phy: cadence: Sierra: Rename some regmap variables to be in sync with
    Sierra documentation
  phy: cadence: Sierra: Add PHY PCS common register configurations
  phy: cadence: Sierra: Check cmn_ready assertion during PHY power on
  phy: cadence: Sierra: Check PIPE mode PHY status to be ready for
    operation
  phy: cadence: Sierra: Update single link PCIe register configuration
  phy: cadence: Sierra: Fix to get correct parent for mux clocks
  phy: cadence: Sierra: Add support for PHY multilink configurations
  phy: cadence: Sierra: Add PCIe + QSGMII PHY multilink configuration
  dt-bindings: phy: cadence-sierra: Add clock ID for derived reference
    clock
  phy: cadence: Sierra: Add support for derived reference clock output

 .../bindings/phy/phy-cadence-sierra.yaml      |    9 +
 drivers/phy/cadence/phy-cadence-sierra.c      | 1299 +++++++++++++++--
 include/dt-bindings/phy/phy-cadence.h         |    5 +
 3 files changed, 1224 insertions(+), 89 deletions(-)

-- 
2.26.1

