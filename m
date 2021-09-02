Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E0C3FE95E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 08:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbhIBGjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 02:39:08 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43936 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241529AbhIBGjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 02:39:07 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1820SmEK026453;
        Wed, 1 Sep 2021 23:38:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=mGDrWFv1tvAuC590QaNcuy2mILVjYVkKhfKgKZc1p4s=;
 b=RccalMK37u7wYGv3qcXSq4PbWyBLDfQ3+sEm5pHvEzS9jUqBnVatKL90/Tfo7MMJ4ARq
 ZW0zIYjpoY+3KJgiwUX44v5GcxYOsgTFKsdqLG1W0t3aSrylq46UaApUUFu26tqDqbwK
 kczGJLL4jWmFxlqoQklj4Gip/6MEZEcL2O3kL9nRp7ChNtiYDC01j4V6s8ME5743JZ/V
 FIL4uTV2mnGzT/FmAJdekG47qq9fe/fpZCtSERAq0CMc4HZQCpgdgjqsjlcate+7zNtb
 t1InyHAZ2i5CWclNb7Qwxe81IeMVNjiQe6KJ/low2I8t5YMDH1Gs89RWIoBDe/CrbBBx 3Q== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3atdxta4h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 23:38:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXVuM0uIxXys87mngcRF34qpBUbDEbv3iGtckaigs2IlUpAsib4DWM3cgstU9vqijFjfxTHGFOZl++1Hsxddkpe9V9tUJHsgPIKuYMtCRHWwJsThxmu3AXIbxiCsFA5T05GDcQW6kS+BEF9MJRyIGjSEkcP9ocfp5RTrWEeb1Cs+O9OBGKDdXrwnZTqV946tpNYex08yftmRo39fM9dwlXraeXgpcjShUcut9qda5ZtML3Yv6rFqLcksUslnDmlr4fnDZN8nSJ1c90lqRNgGtOY0KNB+SBoS+DzfAnUFhrWDygUe6JLMiqUlsnZqG+gSRnW8G2YQuS009S80776liA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGDrWFv1tvAuC590QaNcuy2mILVjYVkKhfKgKZc1p4s=;
 b=F3gdpAl7VvwjcGGE12aLh5is5jhAbsQYR2VBbkc6632izo4C5QQWmGv3hisZSY809D7oyIMAxZcehb3cqoQkhfQJoxKOuHv+UG2XUaoRfbkG6d5k9xgmkdavHP9N3MY6ssFrYcss6F/+4J9jUe1nTryGiqhMg9KgNqBLdWy/mngI1cnv0cNwiCqp212hYasb15bryw/7/5tlC0AVFXsF5fpwdgbmhjMFppQYVfJaxtqf2Vbvy3aizZpOASRIOE5I7xNv08UjPCvYIpBhz8eGpi7wDLLBiOkoOoOGuOf5DupQKMU1o7g8mYuArtT9LPn5OkKdeCg1fws0VCVgYQ9/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGDrWFv1tvAuC590QaNcuy2mILVjYVkKhfKgKZc1p4s=;
 b=X8nzHsqxLBoe9Y/nALig3zC64X+QF/IQtB2GRJJ3W45f0Hypq7blb0Whm4nArcLUOapZniIb0ybJOTVDw97+dkdYHYH0TU4dn+eCDQoXKtcVKWt0c5KWUH3jw01CKFpbcNGer8yRV6X/rLSI40tlE49lGMLuEhcErli6+p/+bTQ=
Received: from MWHPR19CA0018.namprd19.prod.outlook.com (2603:10b6:300:d4::28)
 by SN6PR07MB5629.namprd07.prod.outlook.com (2603:10b6:805:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Thu, 2 Sep
 2021 06:38:04 +0000
Received: from MW2NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::1d) by MWHPR19CA0018.outlook.office365.com
 (2603:10b6:300:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend
 Transport; Thu, 2 Sep 2021 06:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT019.mail.protection.outlook.com (10.13.180.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Thu, 2 Sep 2021 06:38:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 1826c1RV184155
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 23:38:02 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 08:38:00 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 23:38:00 -0700
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 2 Sep 2021 08:38:00 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1826bxWd009557;
        Thu, 2 Sep 2021 08:38:00 +0200
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1826bweP009554;
        Thu, 2 Sep 2021 08:37:58 +0200
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <robh+dt@kernel.org>, <dkangude@cadence.com>, <vigneshr@ti.com>,
        <kishon@ti.com>
Subject: [PATCH v2] dt-bindings for Cadence UFS host controller
Date:   Thu, 2 Sep 2021 08:37:53 +0200
Message-ID: <20210902063754.9509-1-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210826185135.26599-2-dkangude@cadence.com>
References: <20210826185135.26599-2-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d781c620-6c16-4f2d-2cef-08d96ddc3719
X-MS-TrafficTypeDiagnostic: SN6PR07MB5629:
X-Microsoft-Antispam-PRVS: <SN6PR07MB56290BB4F98795E72FA84BCBCDCE9@SN6PR07MB5629.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmfK07Uq8tkTBtjdf/B8DOiWGX1Qu5PlAx6oiKELVZC2rW1rAlCKozaueyGB0Q3q1YemGDjzjEUZ59wlThUocXwy+7nxEN7yAAfIrkRtnEr5zSyOEg0GC+TnuVmY1CnlpOabGnDDh72Ak9KmAuyF187YBXy/QIo91B7Y24XDxfq934i7mbDixpuQJX7IickrRAm1o3NkL9CzAHDpz+eGcm9CW2adELeu/oL4QnW99CQDAY1msUXnFxMyZN+Hm322ceRM1ffVrJeKz9QD7c/V9Pa2D0NfZ2b+SYrjcCkikM7PCyE8mVPUklcLtBpOWGB/Y2M5heWz6dNQYwqGZ1Xm7Y9XNbDxwW+M1JjpGOHwjD+gKCQB0uMFUJHlPhgc9Kz4cgPJ2+CZRb2ER2fAg+iLwhKAfbz0LkSJyHjheJAUGZEVu0B3i5X8czI5G5ktbt+LK7HSLAHFP8eQb4CdDXJKi0usKUwJwv1FGBmG4o4tkaOURK0u6vzEyVE73/QJf39ecWPDoNYpofD7L/IQO7l7EV4W+uK3HpJ5RUa0Z+j7OjvJlwUmHIbc+GBJdAiSRtHxLz1d2d3QflEsaBA6YAIIs85+JY3en6UwU1U4o88QeEXEDOv9gRNMIhCmXX5mIl1jzqSZzWObg7tlEw2zrSFcip370mqZbfV4l/fFYhU24qgkYOctYUG6xA9MVfNQ1SWKv5u5RAIN7K9uDPTtMvBjW+1N03R3zqrgFJeJ+tv5wzIYUxKKVfuvMM4xo+4dhgUSCPCHyowcDvVGi5noB8NBJw==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36092001)(36840700001)(46966006)(478600001)(4326008)(5660300002)(6916009)(316002)(70206006)(70586007)(81166007)(42186006)(6666004)(2616005)(36756003)(47076005)(426003)(336012)(8936002)(1076003)(36860700001)(356005)(2906002)(82740400003)(86362001)(83380400001)(54906003)(4744005)(26005)(186003)(82310400003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 06:38:03.3745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d781c620-6c16-4f2d-2cef-08d96ddc3719
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5629
X-Proofpoint-ORIG-GUID: EyFcGtzPJxqRqd5AlTH1gr-MIB37QZGu
X-Proofpoint-GUID: EyFcGtzPJxqRqd5AlTH1gr-MIB37QZGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-02_02,2021-09-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=702 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109020043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converted the previous dt-binging text to yaml for Cadence UFS host.

Changes since v1:
1. Corrected reference to cdns,ufshc.yaml in ti,j721e-ufs.yaml
2. Removed power-doamin property from ufs node

Dhananjay Kangude (1):
  dt-bindings: ufshc: cdns: convert bindings for Cadence UFS host
    controller

 .../devicetree/bindings/ufs/cdns,ufshc.txt         |   32 --------
 .../devicetree/bindings/ufs/cdns,ufshc.yaml        |   80 ++++++++++++++++++++
 .../devicetree/bindings/ufs/ti,j721e-ufs.yaml      |    3 +-
 3 files changed, 81 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
 create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml

