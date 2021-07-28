Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B313D915F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbhG1Ozp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:55:45 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:16910 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237320AbhG1OzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:55:24 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SEk9ZT024616;
        Wed, 28 Jul 2021 07:55:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=wk/fW4Di+bNvCMF/ZpQrwTWhc/tbb+1I0T4pPOeRTq4=;
 b=HeEydH01N7AZvR6lwOKQ4l4CGv3PhQLfouBK5P8OVYsiaHWkqRh+fstbR6fR6A4dN3oZ
 xaLl5I/im4a1NIzzXzLeLEOoiZdC1nuLW4qIH4ecU5HJTnFWkGRRSI5Ai5BVao2Ua8/3
 /lLEzFY30rRrjk8sV7Zx3pf3+R/oNI6Mr4gfhVGPbXwaE9O34x9vF+VpB4JOBg4YvDob
 psM9P4yh1wxB0WV1WISoTd+cevDFv0d3i7+CmdXMzFnF5GdGr9m4oiRg9PgdGaP3c0aj
 Es3p9zhntUk/ENZZYnLbU7rW/Rf9DbLCAlwKrEQwlErsRgp7YhqUT+lzEM9XLus0+bdD Vg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3a234aysbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 07:55:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqnwvCTndYx0hcxdrgabrsxV/NWck5moWJJaXaEukD7ZZKh95tJiashlGXZS3wo1KWypvqWcfbN7V2nsO95S0z4Mei04ankc9ajoXIfMH+M/2+9TsaP0+7R5QGbrZhXwLImmLC5jL4S7OlMCz8lKlf2DwXz++rLbv6eNN1cVhNenT57dHE5kl4QpyEiz0FD5GotmYLtrb3f0udq6MNZKUsjB+ICCQf23Z7CtgDuzDWIJFNEKtISbZDe5U9Pw8WHue6d0Aw/NTgGIgYN24oOdqIAgOKqB5Q5HGtPWw0Pr2HthCuZYzj5fvUnSGOARW1ktRwD1j1E7Ka5sbEDAdzG7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk/fW4Di+bNvCMF/ZpQrwTWhc/tbb+1I0T4pPOeRTq4=;
 b=gR0DktwpI68NyhvwBhJf7idrO2P3J/W8OJfxqwvxwpj+hx7yg8xyev8KxkDDPqcSuP5Jf+4ndZS0sF+3mh5Iz0wOzCGI6JGnUS61IwWX/gM3Q736SckEe1sGmTkP1t9Cm6/dA2lTwCmM6sIZPl82xF5QA5cIxP7Q62AZO88DbOGfRlKwS7sAMvY3Sb+pXK+hjOnjMw4CR37NpWf24jJgeZxQ1EoRgE5T33NkqV+JZW50ZWY1056I5tN3KSfQd68NpETuhVybpC7C8PYUOpjd8zVi9WZOrVfJU9GJDUmQ/IucdodRirk8Vplr52u/0emtBYnADdwVrwuy/nDABYPSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk/fW4Di+bNvCMF/ZpQrwTWhc/tbb+1I0T4pPOeRTq4=;
 b=5DpRmNwIsVqw3Tc3ZHe1+tze9bq1tyxQQGvfeDAkJE+eT+4GLHQ8khPg+SmY7s+IQEKw5YRwdbXWp+AVQ4tv5I+QjZWULX2ZClldmmcQbArIWoCoimYR/giXRKU+6PfjiEE11gw7LfR3GN4fImXxD1GHFUhbMr0ufg1zbtIT04w=
Received: from BN6PR22CA0054.namprd22.prod.outlook.com (2603:10b6:404:ca::16)
 by BN0PR07MB8245.namprd07.prod.outlook.com (2603:10b6:408:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 14:55:01 +0000
Received: from BN8NAM12FT025.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::d8) by BN6PR22CA0054.outlook.office365.com
 (2603:10b6:404:ca::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Wed, 28 Jul 2021 14:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT025.mail.protection.outlook.com (10.13.183.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.7 via Frontend Transport; Wed, 28 Jul 2021 14:55:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 16SEsvro095664
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 07:54:58 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 16:54:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 28 Jul 2021 16:54:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 16SEsuK3016331;
        Wed, 28 Jul 2021 16:54:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 16SEssoP015985;
        Wed, 28 Jul 2021 16:54:54 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v3 0/9] PHY: Prepare Cadence Torrent PHY driver to support multilink DP
Date:   Wed, 28 Jul 2021 16:54:45 +0200
Message-ID: <20210728145454.15945-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e92ace10-6dbf-426d-6b3e-08d951d7ac99
X-MS-TrafficTypeDiagnostic: BN0PR07MB8245:
X-Microsoft-Antispam-PRVS: <BN0PR07MB8245302CA6EE806C503EBD39C5EA9@BN0PR07MB8245.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hh86YBS8Knuj8pFKY3InKbJWl7L7Ajl0ova4W/OpbDEI9I0sliKAmR0UPfgvHkrG11Bd7FHODK01tlYNdb7wxfpPbI7ZSh1YRlacwmJ62oyNJ7mPS7JRIlRhwW+WoSqXUS2ccGO5s1CLJcTDOZsVEQQ6Odmz6x0Gz9xi0MIf9D001dG/Qk2AUd2ywd5fXb2jtGlUycA4AEgPoOE1ZuJYCzgWrGsiXNKMRgaUVZY8VrrFl601GCks5C7guJwwAvI1TyNWjgv7Ui7XMfvP8A7CYMZxeX0V80xtOG4CK6Q22rqdGUNYAhkFKVhGPe1+mHyzs6TVgIYSOSiQnAAfMGPF3ijZBt8eaKBhfjZ2h7KEQukplpCSFYxFQcYjQm/OiNK2pMZTSzV5PE1c+6tMHTFxiZysgc4P9nTA1BQOis/k8oYeajkP+IBGGeACeEzofz33iVv/qYuNQcr760lc7xXlSBCDkhU8/rXZLC2xDSo0obFWDqaHCLAMOR7FFX8pyU4mWLu7ycAnIh5jngGMJy+KpB0XQILF9s+BSt3XSHqLeEtOL6rX9CiXXWT0dPwaRiGA3NWeYo3y59pnmjx9VrHcV+wxyrMoVW6fe73JwEqivntLs2Hw/mRuWeJjd7weEQIi1pPTkTo3tBUrXjm7nc72ObTYTGhaHej1L+ZtsQM47iPizy3pg3Db9fhnTd/M/F3LDT3W3qAQLFl0Y7lB/vv/o8jAPu8tDZfyF7z26TmKNn/vSMu74fzsUQ+Wo6Kgsz9iueBGkhsbVtQtIre9doFG0kKs4iqYFujR+DevRnfZpirtk6JMdPyMa5cO+5NDgDNCy7OuuBt760JXroO1bpu1eczeQ/7FO0WPRHxtypJK5r+K6W+EvOhaoMnWNIdh4BJH
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36092001)(46966006)(36840700001)(5660300002)(478600001)(4326008)(1076003)(316002)(36860700001)(8936002)(110136005)(336012)(2906002)(42186006)(966005)(86362001)(26005)(426003)(8676002)(47076005)(82740400003)(70206006)(83380400001)(6666004)(54906003)(2616005)(81166007)(356005)(186003)(70586007)(82310400003)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 14:55:00.2721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e92ace10-6dbf-426d-6b3e-08d951d7ac99
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT025.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR07MB8245
X-Proofpoint-ORIG-GUID: 65Sr5Ts5OWkq_hVF3aSJkJjGRyRzAn8S
X-Proofpoint-GUID: 65Sr5Ts5OWkq_hVF3aSJkJjGRyRzAn8S
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_08:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=967 suspectscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107280082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables Torrent PHY driver to support different input
reference clock frequencies. It also does the basic cleanup in order to
add support for multilink DP configurations. The multilink DP series at
[1] will be split in 2 parts and sent separately. This is part 1 of the
series.

Support for DP multilink configurations with register sequences will be
added in part 2 as a separate patch series after validation.

[1] https://lore.kernel.org/patchwork/cover/1410252/

Version History:

v3:
   - Fixed register offset macro for PHY PCS lane registers in 9/9

v2:
   - Removed multilink DP support and register configuration patches
   - Fixed v1 review comments
   - Added Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com> to patches
     1/9, 3/9 and 7/9

Swapnil Jakhade (9):
  phy: cadence-torrent: Remove use of CamelCase to fix checkpatch CHECK
    message
  phy: cadence-torrent: Reorder few functions to remove function
    declarations
  phy: cadence-torrent: Add enum for supported input reference clock
    frequencies
  phy: cadence-torrent: Configure PHY registers as a function of input
    reference clock rate
  phy: cadence-torrent: Add PHY registers for DP in array format
  phy: cadence-torrent: Add PHY configuration for DP with 100MHz ref
    clock
  phy: cadence-torrent: Add separate functions for reusable code
  phy: cadence-torrent: Add debug information for PHY configuration
  phy: cadence-torrent: Check PIPE mode PHY status to be ready for
    operation

 drivers/phy/cadence/phy-cadence-torrent.c | 3181 ++++++++++++---------
 1 file changed, 1750 insertions(+), 1431 deletions(-)

-- 
2.26.1

