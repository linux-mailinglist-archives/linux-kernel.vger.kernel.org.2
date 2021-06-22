Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AD13B095A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhFVPnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:43:01 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:59406 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232360AbhFVPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:42:40 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MFWP9v031503;
        Tue, 22 Jun 2021 08:39:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=BE2RYMDGJC8Y6xT1glzNsBqr+Yil0S6Ql/uv4EUjuQ4=;
 b=EfbgmRuXp2WDba+wjs+4F56yFuGv3y45A7g9OA1lC3FHlc1jfUAlIEtlK8sdwEb6uTnW
 T+EXq9BKO3/Vz8LW5YygvMhxp4jt/2hD17o8ul2p0hohyLIYZZn+kdbdL0BlgNOtP7Sv
 TPteQyY6vSEW7dfZvQM/DKxr41o3ISl0U2Bh9JaonbLuXjMJJ90cNJDB7qWn8b0d0sCg
 U3p3dTXvvODuFYH9swMFXuUpIYRkV7REErNNpufMlfO2zC8dw6ZLsmKoGfLz3AbvU88E
 As3UFAkIej+Nev/ENLaKBP6HcPYWz7zl1DU+/lO9kWH9NOGxYRWrCp4EwgO8TaiBNIMe OA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-0014ca01.pphosted.com with ESMTP id 39apms59tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 08:39:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJYAzJdq7KhVppQFwJlPomEp7fV+Zn3qY8vUUVZydmBWbqKu3qJEp97qoVst47PHE/pHElV8+3Nj1zrf0wWNdpmIXoFzseTwTG3m8/fWfedgdKz1CuvOh994sv4I8FlXbi2aBMrOZTJzPUbCFQ02dqvQi9uT+yIoosxELnBJoRA3PxVFA4SmZqId8tMIiAIAm0Lo7wQIGjFS3VGd25vRT7ncaYRJZClI4Fr5D96b/HpDHRuxW+vKH3vFWEdwxkWVg0I3y+DWuBxPMHhvozj3wbdOZs7NW1Yv3q4a3nQolvNlIrLXH2ytAiPAPPErEVFYEn2cW9Hu3nmQKtQ9RMBXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE2RYMDGJC8Y6xT1glzNsBqr+Yil0S6Ql/uv4EUjuQ4=;
 b=Dgl2Gn7jRALc0hdFMtwBiXa3Il7agC+G57xJHSMAJq1TOJ/AOuISKRCDczUlnGkcrTS8RbBaJgHosYEu9bfdEKW3BK7FRrlma8P5IBthkU6T0a48FR1XxBzr0Qp3SzvkpU3qEJnEMBuA/nZ3ZPKrJLItpOh2P07aqiCz+zCYdDEtjsku9B/9rsWQDe/+N/Xz49wfOGiUDUv1BPO03nd0rP3h+GpI8AkicVDLPamxExftU86YZimKPCMAtCPfhJNcFH8t+uwm4WhK0awpc9kj7sZnhoCpbmAq7cJ7jh9GAehyxBTkSGZ9rykVEo2oD2SjQWfAgvdNi42j/MsSsNmXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE2RYMDGJC8Y6xT1glzNsBqr+Yil0S6Ql/uv4EUjuQ4=;
 b=lsrV0yQPbn8ev0/IDN0TU6JymNNG8WSWtLYEu9a6KioyiBfIrfWI1uH8QQI6RbrqG5TKyl69UpUOdaVUMSj+PSgdcTjoKVZdlpHtnvt+nN8Lx3Z5BrMk6bveWwin8J/IBJfd2I88Dq2d6YEaPICQCfziCIn3aYUHTqX7u+NJMbA=
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by SN6PR07MB5488.namprd07.prod.outlook.com (2603:10b6:805:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 15:39:55 +0000
Received: from MW2NAM12FT006.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::a9) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Tue, 22 Jun 2021 15:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT006.mail.protection.outlook.com (10.13.180.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.10 via Frontend Transport; Tue, 22 Jun 2021 15:39:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 15MFdpjB219509
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 08:39:52 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 15MFdoWK002298;
        Tue, 22 Jun 2021 17:39:50 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 15MFdnCv002296;
        Tue, 22 Jun 2021 17:39:49 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v2 0/9] PHY: Prepare Cadence Torrent PHY driver to support multilink DP
Date:   Tue, 22 Jun 2021 17:39:40 +0200
Message-ID: <20210622153949.2215-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac337e9e-ee72-4d98-f0c9-08d93593fb55
X-MS-TrafficTypeDiagnostic: SN6PR07MB5488:
X-Microsoft-Antispam-PRVS: <SN6PR07MB5488E2600C25966244B4DC68C5099@SN6PR07MB5488.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAafXbLii+e4nrsmVtBtWf5Qw28daO9E1tGdfhoFxhLuxlaOfi/kCt2mut2fw5cJYv56gDq95dSpES/Cwddtl+oWWt1CdHvvUycz5yK+11FqO7D+UvKfxHQarbyzvhnrjq27KPq4Xvqe6m0hV2xt3e758NqYAb/n1MJjbpOk6rMYfz7V5k1dSWt4VW6DMGRLXvy+0/GKO837cImDTz7Eh073bkYl26ulwgZkWlliEGuTttXAHkXhQc+zU8MxgldlNnuqJjdtaKTLhduauQyW0kQku0zWYrDH9KDV4LY3geZoXlwmIvj7IQCmj+7BvotVxAqCxaEh9GrGt712xBpe0DnmsyVDnepSzP5nlnlk69CNC5D/MKiZ8tvjfuuXli5mA6PzPtq8Q3cgJu3QGCbXsSfDLR6H9oVqm23fSK74K+jbrCAKWW+FPAGvzH6hrpr6Qn75iXAOSYD7MDk4zKPECUKLRiUIMCxITD9dbnocLXJDitmBY+veQKupEABZAR3d0XGH4kyg9dFrdgwcHq89J/sWh6R4LME/VyrdbxmJt2lRe6GZGI6ax10MQwiYUbPdoWAUuhQJkVAmShrmT/iC0MW4vbIp1yF8MGN8GyZlVYKkVS3zfM7PtMb2WQkW8ObKUJSMvECPiN0pI056MOvGszqYKE5ajpdyRGIPc7iStqBmGxzYFbKFiN3TXOKCaFEBOo5+C0oO/UK00p9mZn3ueoTkHvNZ3Va6qW6sFi9FdNSNJAXb4CaqqNlfD0pQpVGnaOkMuAjQzo6qjc4jcBc/sdLqGgjXdMbfoEGducbkuwYhKgWt/UfZUeiurEYVHloOawJTpqhZKgMH+GzWus7SJYjcEYAUXRVvR3cL3D/6PBs=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(36092001)(46966006)(36840700001)(54906003)(86362001)(110136005)(2906002)(70586007)(70206006)(42186006)(36860700001)(336012)(5660300002)(316002)(6666004)(1076003)(2616005)(478600001)(26005)(186003)(47076005)(82310400003)(8676002)(426003)(966005)(8936002)(81166007)(82740400003)(83380400001)(356005)(36756003)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 15:39:54.2284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac337e9e-ee72-4d98-f0c9-08d93593fb55
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT006.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5488
X-Proofpoint-ORIG-GUID: YFoErwN3gBdviFXPMYyKXnmyoe4kX18g
X-Proofpoint-GUID: YFoErwN3gBdviFXPMYyKXnmyoe4kX18g
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_08:2021-06-22,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 mlxlogscore=849 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106220097
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

