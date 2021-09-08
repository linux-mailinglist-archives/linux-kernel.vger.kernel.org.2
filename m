Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3370403F11
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349914AbhIHS1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:27:55 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:27446 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233322AbhIHS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:27:51 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 188IOeax016935;
        Wed, 8 Sep 2021 11:26:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=6K+6h2LQn2ewuASmn89bSHxezoXmvzINqbB0MYAkCfI=;
 b=YbuUK82afba6bhQbt9GZT04+G3aM777J+J1pWDdpBssFn/Jb82uN8Cq2TR52mk1Q8UGr
 e3dPXFC3kewsnluX+IsL01wiRckaUjrmmgHHtoibBHgTY1xiDkbEvkhqqbW0gwjW3XDW
 kpmbH54zs2y+m5TG2hrMuG0nR6gfuf2XaryDLZHndU1UEzlmpE1WqymI3oPwesjHoDKy
 et36yBvEHHMWu76Vey0TasJt8dyj0DfdqxlWkHkd3boyvII+WxUP9d7+u70Tg8TRsHL5
 BpwTlSN1Z0Qfcxm9dci/7lr3iNoHB7F27hJcrQh1/IiiJw/HuU/o8w5O2lPBntJvBNkQ jg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3axcp9m75e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 11:26:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXO45/L5pbSJp2zQFinijUbP/mIaSOOj9sCn6i+fk+6EPTERLvf/zf14fKiHumzCtY8Ch1qTNf+SgXM0r/jkUdDVHPTaIC9DjdU75VLtTzZQzB/rcKLIcGTiddHGyV7BO0e57zATjsnxlECHCHrWNS+6/Di5w/LyErO+IeNJDvFuQsmq+qFsWuQZ8Ok4XB9dzzfBsY8bXEV6iI2ZvRwcaoiBJaG/MTzLbS7CfQedxHbf4rQLTUioSEfmHs64K8LnCkodWbUkh2ccfysZoOWnok6aC+brbFyOBCt9nQtnpHU99NoW+qVTj0+UAvc0z+jZZpKI0cHikf/OsFuZNqgbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6K+6h2LQn2ewuASmn89bSHxezoXmvzINqbB0MYAkCfI=;
 b=LlhA9d2Iw4S5UYIZvYOSxoaX8q1r1SlK8+MxvCQvrihnBV6tNgqUzDBSkIhGiUUGqgcKzrl8KmcDEWBFfh25mJ172DQD5Uw5L9be0Unm/lIY1MmoJeJ69uJy7dxciUncLVn7Ec2wQ5HrobyLfYjZDUOtpnfzYFTk4IOfzAwRdKqWYZOgTN8JG9W6+hWEQs8pFYKV8vZz/G2jWVaTzYPTann9y+eojkFXxDJMaZCVTex1yoS3RHd6jznwL7xo/zpPGwy7l6WoI8BjCqiFBrPLV0ut7eV2TRV/dc9oXuQayfSmn6FMDn1swqnHB+No+v3cOEZwcw+9xH1KdFV0PUlfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K+6h2LQn2ewuASmn89bSHxezoXmvzINqbB0MYAkCfI=;
 b=P2rJK5dztomeUnFPAUjIabIa6rSnycdxvCABCRSaUnPQMQDMX1KNt7Qb5J/dTxyiFVSn9srw0UAvK3utuGHC94naq3RHgqk8AcH5ZBMps6S/mcNTXWW2sV4WClpCRfSNMZlo07JyRcoRjTyReyBJ0sU+ihm/kxfancwAsVGqRwg=
Received: from BN9PR03CA0500.namprd03.prod.outlook.com (2603:10b6:408:130::25)
 by BYAPR07MB4183.namprd07.prod.outlook.com (2603:10b6:a02:ca::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Wed, 8 Sep
 2021 18:26:34 +0000
Received: from BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::fe) by BN9PR03CA0500.outlook.office365.com
 (2603:10b6:408:130::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Wed, 8 Sep 2021 18:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT068.mail.protection.outlook.com (10.13.182.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 18:26:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 188IQUwM017985
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 14:26:33 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 20:26:30 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 20:26:30 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 20:26:29 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188IQTXb028413;
        Wed, 8 Sep 2021 20:26:29 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188IQT28028412;
        Wed, 8 Sep 2021 20:26:29 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH 2/5] dt-bindings: phy: cadence-torrent: Add clock IDs for derived and received refclk
Date:   Wed, 8 Sep 2021 20:26:25 +0200
Message-ID: <20210908182628.28364-3-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908182628.28364-1-sjakhade@cadence.com>
References: <20210908182628.28364-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ad8c531-07e4-4e5c-5138-08d972f62fa0
X-MS-TrafficTypeDiagnostic: BYAPR07MB4183:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4183E6339630393654FCE1E2C5D49@BYAPR07MB4183.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZUwjDfJSGmTWYy7SAZzRJSryq+vEVJaD35laReZptg0V7pUxLvlfZXykuHqmvsBS4Qnj0l2z5e17kLcdYZpd/Y2w1NmE9SsdkVCvFED82P7i8CoWBx+U6+w8xed2B2Laio66xPeMNs2v9Z1ynHARbYapH2zIZsBw01LmUjkm0nIZCd7OvJEgs0AdwjQcFL3Hn9JBTXHiI01pILstHjsAHI/tPOdD4CkJ3oUptj47gvHponxT7xfabjD2Q5dWcjHtJ5CMmhKuf3x9YvYF6Ws+96yJImKFoHc2D3c/+UZ8ygAVysB5LZ2OMSgv+i7FiMKMAiLjb1ScGt75ucMBtTLGTI6UgJlfuvaJDDhnbj7ObJ5tWMKKTYDp4cV8hXbVsChJ35KK3oWSNlHxuiHeER8Dy5j5kZs/Ic1YoLNTXEt49tWRTVYWfDDeFcplu85jI6PZ7dt8YXNeGMvuuPOp5qkTAmvyPedtwXqRlvRrmyc0KfuEeoLKq+4bnoR3oJ+To2ZP7nkrRr44SSAeFjIUqxE9tAcg0600pq41vwilcyV6QlfRqo5qkEdcGqzQM4dMOz7uP1TXGzZ+7v3qtXj4Vwq6ztI/OSd78OrYLmQF0kuO7VaM5oH26Deu5I1N83YXwUW+fZpNQ/8+R91WLg4xyTi+PEwun569dQloHFrTqaSoxazfsu8dFKuqRKkEm6QftmwEVODz3Hdk+lMWWG+RCBlrlyBr+AkOyV3BL/eisPUlRfjkvkn8eOf+/Fbv41BLWYzVt0poqkCUs2MNK26s5lvqNealqDGwoMQJxqrVeDZmgU=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(26005)(83380400001)(336012)(356005)(8676002)(426003)(81166007)(316002)(8936002)(508600001)(36756003)(2616005)(186003)(70206006)(70586007)(86362001)(54906003)(1076003)(47076005)(6666004)(110136005)(4744005)(2906002)(4326008)(42186006)(36906005)(36860700001)(5660300002)(82310400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 18:26:33.5902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad8c531-07e4-4e5c-5138-08d972f62fa0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4183
X-Proofpoint-GUID: 6JkMD01yUggI9E5LnFLCKMCEbHDc8Gk7
X-Proofpoint-ORIG-GUID: 6JkMD01yUggI9E5LnFLCKMCEbHDc8Gk7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=899 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock IDs for derived and received reference clock output.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 include/dt-bindings/phy/phy-cadence.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/phy/phy-cadence.h b/include/dt-bindings/phy/phy-cadence.h
index 4652bcb86265..24fdc9e11bd6 100644
--- a/include/dt-bindings/phy/phy-cadence.h
+++ b/include/dt-bindings/phy/phy-cadence.h
@@ -12,6 +12,8 @@
 #define TORRENT_SERDES_INTERNAL_SSC	2
 
 #define CDNS_TORRENT_REFCLK_DRIVER      0
+#define CDNS_TORRENT_DERIVED_REFCLK	1
+#define CDNS_TORRENT_RECEIVED_REFCLK	2
 
 /* Sierra */
 #define CDNS_SIERRA_PLL_CMNLC		0
-- 
2.26.1

