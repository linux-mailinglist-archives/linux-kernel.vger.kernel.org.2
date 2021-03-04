Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2047732CC7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhCDGLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:11:14 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:13014 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234733AbhCDGLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:11:01 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1245r0ch026326;
        Wed, 3 Mar 2021 22:08:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=yriayIX1agou/YSN6eaD5hcrFejztBuBHLt55g6cobs=;
 b=cdIRewCh27YJfKXXTL2e73T1xCi4AaAmT00WluWGrhxvdOTlnn3+jLkrCLzEdrlgreys
 jW4RRF2pygQh9l8gfq31v/61F58Lq4VvTvoIW8CJ32WrMQ+aRdNUcaX2EbNXrlrSxrYz
 malmqDTiHlgAk5dx0p7MEvo96FKJjcODTxCpbS+Sv0veSce1oDd5c3YP5tlf+ZCEBjaZ
 Mrc8rh+0mnTWdgBDDWnLxDYJTHUN2BBr7Mjy+l/3v6mtTZ/2Id0+TeQWk+sx96/Xu30P
 Bq/36rI/F8PSKEy1qnBIwyY8gvF7nTMEJVY/jA159/lgzoX3H4MIFw7ohDHlTu7+wz1U 1w== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-0014ca01.pphosted.com with ESMTP id 372bvqjsqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 22:08:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIeIKrBGc4PhaFflkvgTzqH51FtNVse2A1we0EnUwm2B/dZvmD0vQSrcoQxhYR+TDCTttC2Q6volZI30Jx2Cd8e/3uhRi6qY2dJgZS4r40elExpWfAZ+tlqBrHyFwBlsfaEWHzADfx94bNth9YS5TVwaYQxpcNG+upFXpiRn967WEMaYc5NgHf13zlqDHgaVHV9JdQyrWXZhU0F0JrEFK2MhCNSFn5QsLDy8S9FOE7ar2cQIRNWzv5+rkhc2AdSYTyqwNFu9nGCl226TkHHHs9itz3mfPUUKxk56jVptFO0ULpH27E9eHHX1mY4KPu5BqYre70i8C/BBWtUeo1yThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yriayIX1agou/YSN6eaD5hcrFejztBuBHLt55g6cobs=;
 b=E1vhqIetpQXLyrWRoaAzQqO8iZDX+sYI+FICPKjB7EFaSLxCgQctCdaeksLbQIR3rHK31HI3od9GbqLkqbkLAK09sIUe5QooO/XXQ+TuOq2wpK3CY4i90UXCrmbj5VHJkDriuOvBDn2cRHSXOBBb1F+bWX/twGupAgMhNE+voRxbNZrTiIJda9VJSK8bfuhYGthx3tw2PmnAHllHMgQowG4mgIS31zMZSDuo0/+ulTRE0BSi6cybeIvXbtr3JL8z2FF9f+smis51GwSOQsQik5V9HrLG7OsM3XxufM4xMplD1oUa/vsY6l2EJ+jgR2r4d8rsm50xh5npv7KyQAWTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yriayIX1agou/YSN6eaD5hcrFejztBuBHLt55g6cobs=;
 b=ffQXokchSjh0qAnW/4UXQqSm70oxme5XxXCYXdf34OoR+i6BikVcyGUIUKv4JRoqBJdcg1MozdspmjrWMn9lENO9hQM18E5mM43DBGYzNXy+uc7KwGqEecczEyojnLpULKPssE+ADJiIRxFEJkOAuKW4biovulFWxuDdX0BUhRE=
Received: from BN6PR16CA0032.namprd16.prod.outlook.com (2603:10b6:405:14::18)
 by PH0PR07MB8576.namprd07.prod.outlook.com (2603:10b6:510:82::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 06:08:25 +0000
Received: from BN8NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::fd) by BN6PR16CA0032.outlook.office365.com
 (2603:10b6:405:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 06:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT017.mail.protection.outlook.com (10.13.182.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Thu, 4 Mar 2021 06:08:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 12468Jjn067409
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 3 Mar 2021 22:08:20 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 4 Mar 2021 07:08:18 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 4 Mar 2021 07:08:18 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 12468InS032341;
        Thu, 4 Mar 2021 07:08:18 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 12468G7r032333;
        Thu, 4 Mar 2021 07:08:16 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <nsekhar@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 0/4] PHY: Update Cadence Torrent PHY multilink configurations specific to TI
Date:   Thu, 4 Mar 2021 07:08:12 +0100
Message-ID: <1614838096-32291-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56387495-d731-4083-d1a9-08d8ded3eb54
X-MS-TrafficTypeDiagnostic: PH0PR07MB8576:
X-Microsoft-Antispam-PRVS: <PH0PR07MB8576AAD8FA7FFD283A227792C5979@PH0PR07MB8576.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: br+2PhzRE+aCu5g5/6ykiSpX+JKKEY6Kf/LgE8Qz5yC7wTcMWURMXqtzfu9mwJESMoMtUa2xHIH/ETpVSZwf9Mow4k/Le5aUQ8LnHRLHvx0DZQXtKomCaXhqwRpEkdnM/hX/qqBhMdf4+qbZ8/1rP+MdyoS4+eixNde4IiTagTYf8gUnSt5EtEktTXJQnW48V9wh13oIiMwKbui8m2RbYEL7g/gB+BJA8ruaU2ph7donGjoArHBewGq4IaTXlNrCqU3l33j1P4mh/nkux7CYL2JJ2Cv5odnGDa+zx+OPnwVwuvzCvKZDsYveUeHCj1V8sBerZj4caSMtxIT5nGZNv9zOufGSg1m+YEB2q26ROgVdWJfA6RWdiyRv6kAvxYRsymmRhhLJ+P/8GSCHR1dtOgJ0ZfPsvfar669rwOnG9iv6s360eJBvcDwuD8wGeU431PMluGhJLG4JKCPvBOrEv4t3aq3K8L1e8T6OCEYxop9UMm2fRKTYtAAhIBTQ9qmyEwjZAZm3f9cWQ8aNN6yJssRcMu5cOQWV95RKMTUM2k0p0MaWoWPZKWsApH9hlNOBqn2JFe47FRcTMfxBQV41jOBjtDfBe8+LE1JAqTktSAjnpQkHywYm8LpG2Ju58eqFWY3XE4zXEPSzAiq2+qh8s0vrD0caBmEQxIR9TLa20IFYVCaJvCe94u/Kp39WVhkrp8fn5rAubtsXJKFoxPmnmoMnBFCOqbLRlyz0jX1VyCaQMnqTxWYwvEHdJDIis0iv7gKZyaejTQDfn4t4Mq8jXiy5CyUUCsKnA1bFvwNQ5s0=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(36092001)(46966006)(36840700001)(316002)(966005)(36906005)(86362001)(8936002)(110136005)(36756003)(42186006)(36860700001)(54906003)(478600001)(8676002)(4326008)(47076005)(2616005)(426003)(5660300002)(2906002)(70586007)(82740400003)(186003)(6666004)(82310400003)(15650500001)(26005)(83380400001)(4744005)(356005)(81166007)(70206006)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 06:08:23.9106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56387495-d731-4083-d1a9-08d8ded3eb54
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB8576
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_01:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=887 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series updates Torrent PHY driver for multilink configurations
specific to TI platform. It also adds support for configuring QSGMII in
TI Wiz driver.

This patch series is dependent on [1] and should be applied on
top of this.

[1] https://patchwork.kernel.org/project/linux-phy/cover/20210222112314.10772-1-kishon@ti.com/

Kishon Vijay Abraham I (2):
  phy: ti: j721e-wiz: Add support for configuring QSGMII
  phy: cadence-torrent: Update SGMII/QSGMII configuration specific to TI

Swapnil Jakhade (2):
  phy: cadence-torrent: Update PCIe + QSGMII config for correct PLL1
    clock
  phy: cadence-torrent: Update PCIe + USB config for correct PLL1 clock

 drivers/phy/cadence/phy-cadence-torrent.c | 182 +++++++++++++++-------
 drivers/phy/ti/phy-j721e-wiz.c            |  64 +++++++-
 2 files changed, 186 insertions(+), 60 deletions(-)

-- 
2.26.1

