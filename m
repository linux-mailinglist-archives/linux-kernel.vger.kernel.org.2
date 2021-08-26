Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224523F8E33
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbhHZSwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:52:36 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:22678 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231453AbhHZSwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:52:34 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17QGxZeg010409;
        Thu, 26 Aug 2021 11:51:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=BHuLM5As/aSO8GDjY6uZUgeFih2/ulZZBxvLtbSxZbQ=;
 b=DINZITjZx84BGjikyfYVAjBNS+lrGotKLH1i6gc1zXWE/VVKEMcWlK+DNcVORX+l14H/
 2diITzQc7lIK3fmB6mudAphEtqKyZW3K1pOO8X5/l1KS+WoQbMUzkDeT+0H0ZGf8glJ2
 IG89b1OGUe9EotEIAlWr78TK0Hn9B0BOFJJx4n0PEUFYkP9FPqVxo76rIJZEunuvw799
 gSNV64GW7AGdwg0NoHKrYqfOZkYfH0OSNX+BjZxRuAKX67PAdxKG11nEgAiWcRfERtQK
 DajRHYr18NB3fws0i16zsiFYDmszYJJAMTwVpZIF8ifB+vTLx9W/kXuIM7DvDjxSRuhL 0g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3ant3a5bt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 11:51:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqNtWGOVQzh0zjgfW6Fd/6YgLZSpKE6J2rCE7jmW5DqzcxvWbigPnuJspcyzhpcs8m23Lgd+Jfz1wkoMbrBUkcGiaF3fQtwvGcJ+ryYLj/333Nq0Kkmn7T5jL0eCEHqU4cRkMeN0wfQDwmkuV2pGWmdWAMsMI//JsItsKkLX/ouZSdklwrswekXvl3itczvCkKOifNPagZh1YZJC4waFAHBTrDXmp7uNPOwyu964CdOEM6lrkiRVD9N+TdGMKHqo91GSjL+mlrohc3MSn8ydJNAKqgzKxWlVMLVIm84uJELTcyBtM/LO4ArpcKthoI+7eU1VNFuankv+S9GKScghxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHuLM5As/aSO8GDjY6uZUgeFih2/ulZZBxvLtbSxZbQ=;
 b=jmGEtKCEkhbVAnU+9yHcctr0NVZZaflIUyqpX+0GmKH3kKSAm2/GmCvSscpok4q95cZ63RAbqfEDduDz/da0mkbcm9pgM4VA/oEUvUlNt7YmumBStB9nYIuxROLbOomb8BytxmLuvWrBVih7RAX0NqFeBAq/0UeBTkR1M6lxEIF6hWS4hHyvmBeBB3SwT4946LbJAyi752idL7UxrpOPaxHjAAMc6k4ty2eFuj5c8c8E6VwnO2fu63DnX9YQIerphiiO7EFj4KU666OupHrerRiouy94wdZrzA2RAWSzZvK3nwOU5tAJk4jTNrV5fb2CqMlkIjvtnG3RIyxDaxCZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHuLM5As/aSO8GDjY6uZUgeFih2/ulZZBxvLtbSxZbQ=;
 b=AiyUb4V875TpStxxPtMF5lOTAp0gP5QMJ5HCrJU3PNePbltpCTZ5MZY/Wkn6B1/Mez1GN3x/Jg/Wit+J5Lk1gD5AvrGOyHWwMTIRRvOGExZPr/jsPlfc130KtIhQBxmQZ41Lq061pIF0YPaz6wqRqw5W1mAECVZXJmx4u8jr8pQ=
Received: from MWHPR20CA0011.namprd20.prod.outlook.com (2603:10b6:300:13d::21)
 by BL0PR07MB8145.namprd07.prod.outlook.com (2603:10b6:208:1c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 18:51:43 +0000
Received: from MW2NAM12FT037.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::25) by MWHPR20CA0011.outlook.office365.com
 (2603:10b6:300:13d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Thu, 26 Aug 2021 18:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT037.mail.protection.outlook.com (10.13.180.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.8 via Frontend Transport; Thu, 26 Aug 2021 18:51:42 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 17QIpeAb011555
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 11:51:41 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 26 Aug 2021 20:51:39 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 26 Aug 2021 20:51:39 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 17QIpdqF026643;
        Thu, 26 Aug 2021 20:51:39 +0200
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 17QIpc2E026642;
        Thu, 26 Aug 2021 20:51:38 +0200
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <robh+dt@kernel.org>, <dkangude@cadence.com>, <vigneshr@ti.com>,
        <kishon@ti.com>
Subject: [PATCH v1] dt-bindings for Cadence UFS host controller
Date:   Thu, 26 Aug 2021 20:51:34 +0200
Message-ID: <20210826185135.26599-1-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 472ab74d-33cf-4e04-9f2c-08d968c28bad
X-MS-TrafficTypeDiagnostic: BL0PR07MB8145:
X-Microsoft-Antispam-PRVS: <BL0PR07MB8145E82AA901213429A49186CDC79@BL0PR07MB8145.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qv0oR3ezb4Zv+tF74aX/K86AV6rDaRaoHpzAJAWfrG3fYtslM2xUluNvHC6bDtyFwZ4luJFRo1oBvsy5yGnEhiSletX7HYDZHJqufBl4m7pePKxX+FAsDl4e9N+IzrfF/j8C5xeJjOsp+pFt4wTyf28yBiZ9ZLenoLK2FBjEtPHN6vSSEpR2u99lA2tzJUm9980uBpnecz2AWlkjnYNUzSfyccC9nD60lfwk/2EC8qodEtbm2JwoMA45Oa0vvbbkLIZ3ONROZnr1Q1/L366ZgW26ggecjfywVCeQ5icdETIb9yo9ldC31d7aZ+M+DeMaQvHqegO63fTMcsKcrS78elZI4GSc0NL7chmAw0az7EGwaOQ0AEQIF1/Lzh7zseIDkd11lZTHFarG+nckd0CAbUQCZvincQnw9UKk9x4B4wjjC4mKYO2jqDPy8DcDG3bavFB57ZkVjJapcietnajTm6SnJcfkna7I4A9EGJQR0anqM+KeWcqT5wFNZvvuOsLJlt96jQpqIS07FnRJedcGf67eTFschlb9N8wd60NUu2eAao2zGxUyiF0NmdXQkGauTh3ak+agu4V5vz2rR6nlvF4onrW/I90RVFmzd6daCkwxefbPPnMI8x9PHqHGGO1oM43Ooo+D2dzBXI2aZLzX4sgHfy3KS0LkHI3qDZr89rHec1lrm7f6y7RI+IUSw8sZ5sG8zBVUiu8ZGWtnDtA3Gg8nWNemltoMtPn7kQLwV38=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(376002)(346002)(36092001)(46966006)(36840700001)(36860700001)(7636003)(356005)(42186006)(4326008)(47076005)(5660300002)(4744005)(8936002)(6916009)(1076003)(36906005)(8676002)(36756003)(316002)(82310400003)(336012)(54906003)(83380400001)(70206006)(26005)(6666004)(86362001)(2906002)(2616005)(70586007)(478600001)(426003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 18:51:42.5411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472ab74d-33cf-4e04-9f2c-08d968c28bad
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT037.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB8145
X-Proofpoint-GUID: c_9OJ3zbuo9iQroKcQl24Bkfls45gfz1
X-Proofpoint-ORIG-GUID: c_9OJ3zbuo9iQroKcQl24Bkfls45gfz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-26_05,2021-08-26_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=666
 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108260104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converted the previous dt-binging text to yaml for Cadence UFS host

Dhananjay Kangude (1):
  dt-bindings: ufshc: cdns: convert bindings for Cadence UFS host
    controller

 .../devicetree/bindings/ufs/cdns,ufshc.txt         |   32 --------
 .../devicetree/bindings/ufs/cdns,ufshc.yaml        |   80 ++++++++++++++++++++
 2 files changed, 80 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
 create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml

