Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC21130DE3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhBCPdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:33:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53590 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhBCPch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:32:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113FSv2w021635;
        Wed, 3 Feb 2021 15:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=8YbUxyH6xSPh276jP15yJyl4G7X5B81CnPlnMd9IiDQ=;
 b=l7YoIS0tRdW9uFmp2xE4DX1RQfJLQbULNZU35rK2jymDbD6lAcyY0EXWmQZN5heljVJi
 3Wc3pr6gtu63jWBNGG0yF1e1ovwllTdUUgC1KBv7jxZl/RKeSGcdz3gHjzXtdnmsKKj0
 Kn0t2mNRD5o3MEHxYd/GUD9hXMcMl8Pv4iDD/ekuZMfaioq6SVD6N5qM9zylAtAlVhwi
 HyDbs1TqcuwjeUfTdunQ5hnl2E06/78t6tRwv75t2c70SB127kERb9n6lz6Bt929guD9
 898mzOM+rl+UPUpygn9qrskSvMHbYZGkBsujB0DKyjmYz6VqqJcAlinlznsfp/ckjiH8 uA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36cydm0m9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 15:31:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113FVYIi138873;
        Wed, 3 Feb 2021 15:31:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3030.oracle.com with ESMTP id 36dh1r19fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 15:31:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghCEPCx11dgqS+J+2h2MYPIjFQ1Ora0rz/bIMCSs2J5gQ6ituFQyZpITKTvbtTFRKiH5Pl8O8Rk8WOkP5dM7IXpf3dsyxvd1SjR4L0rtJ/9wAabSAhkDYvkhzpX1K1RydedMX7Z83KhoV/HGjla4R17YKIWrGO4DdzaNy0kGqRAf2bUoJWAg0lZ41cF3Nj1PVkMZlYhMvvZtCOYrTdyoQV7pGR1jzDwgs5gK7mvYOG5OL+Fx3aYqjCYv0gc2yvN5QLTv9ZW+EDt0juSIoV8AVIVTHDIp/SvQwGd5IhFfWY+5khVOx2td83qc09iY2Yj5D8Y29grHou6Yd+TT+2hXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YbUxyH6xSPh276jP15yJyl4G7X5B81CnPlnMd9IiDQ=;
 b=P8qR5hBlaNlJsY9r+KnMbLTugPxcPod6sCQ6OMY5qmolc6jbv6SVG+0e3R56dsagslRpV3++4KaBWaxk1Ye76Ag5+tz97pKHB0pOMqgxx+Hlcnkdz166t5geJMcU6/Ze5HfF3IEUC67DDgIFEhSzooaRIRbbehMLD5EuOfcosYE9YIj4fH81QfU9NiwXmAyZozMHkl+5UAXamxtTyzaXejkYbcPLOapc3oEHE0rtsZUoae8vBn3o7Tp/gf4IcJfkbv6RBniSAC/VNoLHLw9CaKX0IzyRdmIlLU0ndg3jy/nD3EUEhQN/y8Y1mpI3SmALaK0SE25lpZO9edIivsb7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YbUxyH6xSPh276jP15yJyl4G7X5B81CnPlnMd9IiDQ=;
 b=c3M0C0temlt5R/z/9JWMaqBvO96m6pWLX0vFcpoH9Zee61nj83/VXXSy1xiCPFWDWnaI2UwOlfsCDS119yrND46JrDlRKEEsf4S8LEtrNBn9sAaWokaRh94UFtkHAf7PVUIO0GXm5Ed29QcrnSxuB9cJ41AhNLYU4dGJbmx3OFo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4803.namprd10.prod.outlook.com
 (2603:10b6:303:94::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 15:31:25 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3742.015; Wed, 3 Feb 2021
 15:31:25 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andriy.shevchenko@linux.intel.com, bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH] add support for pci in the pvpanic driver
Date:   Wed,  3 Feb 2021 16:43:57 +0200
Message-Id: <1612363439-26656-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: CH2PR14CA0016.namprd14.prod.outlook.com
 (2603:10b6:610:60::26) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by CH2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:610:60::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Wed, 3 Feb 2021 15:31:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c83b11b6-4eee-469f-e84d-08d8c858c465
X-MS-TrafficTypeDiagnostic: CO1PR10MB4803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4803BF59AB4C5BD0F0D01FCB88B49@CO1PR10MB4803.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gFHsdjNJHIUe8ap3RKQ1cF+GnDDuams6MMOkJFVlSEpGC944qK5WJoPj/80SU2LFNcN03izB+Lb45m9alWm9CLb15v0SZJwFmzbxEj8RQDyCeN9vGHDzshnv5sxo04Of3Q5BtCoMxaqZ9pn3qoKuiwConlFMJEMJfodEIRbm4cMPlMkSUhWrFgoeg8OV9r46g7nAAWL5thzil5Osq4z6UZX+ZRc11MqccRTczdtIR+0BbpmafUeBwa6Kbdy5JGZr2pvW4qb8NhUgaE0kyOT9HuB2pHcxtZHjnOcgfq3atGGMYmdSBCHlfPrKDIAD8ZoP+YVDZIs+K+lvJigi4GBCQ8aJO7jvU7rIvYs17IrnoAkmpx5DndAbRxIS7aqTaq0o8OAnQhEpksjsRS86BWLotTf/MrgFWUvpY8Dzd8hDtQmqEslKDS7ZHIBxRh2X+gVkoyihA7zkbN6mK5iyzWxFWRWt617Pv5ZEUlIg3zGzyp3AY5nE+Z31N/qulZnGe9g8tRBjP4a6dJ4l8xZNxRI5KtBoGf4pyugCWMOHBa6CD7qWKWTOS+cSNQ6lFl4WiKvu8EIBe77QEgWiY3AtCrfdLNRr3VFHCUo0SZSWq+DhwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(136003)(346002)(39860400002)(107886003)(8676002)(66946007)(6512007)(66556008)(8936002)(186003)(66476007)(86362001)(83380400001)(4326008)(36756003)(16526019)(966005)(6506007)(2906002)(6916009)(26005)(956004)(2616005)(5660300002)(6666004)(478600001)(44832011)(316002)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BAonFgEUd6P8XYOt9Wzbe8DRrKsls4M2E6FdZ1rJwQTf90dw6c5eFlqfQwXn?=
 =?us-ascii?Q?riDopPPlNt1SH2h2IICvAvcGKj31XXuNpvw3SM0g5WkCpAqOSUmtTg54vT0D?=
 =?us-ascii?Q?pWla3JV779tzNrn45M+f/7XF5OB9vyEUnE4FWQPfQByUjWRw7LWNP/98RdRq?=
 =?us-ascii?Q?H1LKnCASBGLpZdY+i9DeYPoxhw+dF5mr21QPaS1Vs2qBbUaOUci1u8njd2BV?=
 =?us-ascii?Q?rD25DCgjBuohjkYSmCYCowAB8wS1aA9k8FO7hl8yNwgAzGD6KMNaKqJwlyxG?=
 =?us-ascii?Q?SnHq5ssTQ+IHoLHRj7CrOtiA4SQDQ2QmrCO25Fmwj9SySurvOrz9Z25XI6oP?=
 =?us-ascii?Q?GqR33HTlfWmY10qoG1PacU9YrbzY4W7XDQptXja3b+4gDu7KPrO/q9qL4Ike?=
 =?us-ascii?Q?wp3t6rlZx/Ho5FbScjeSeO+GdsNeJkU1x3cv01XETnXZMDN5/wN1FOnuaRyH?=
 =?us-ascii?Q?wnCDKpMVR/rA+r/fTQShhsRfEZaBApvVuouoawWgaGRsCwzh8EatEvtpgqlB?=
 =?us-ascii?Q?Vm56zJUfWwFzsWOHIInB0otiRUKY/D4gaNTNPiRzAlWXz1dD2QAeYifyvWmE?=
 =?us-ascii?Q?wgB+U14Hleuwa7/R6/XjzYL5r6SzQV843YrRk/xjNeFggJsPvIkUi5yuVjvL?=
 =?us-ascii?Q?/M2P74SXP7opIp4TCFVZElNaBmEMXNVIWQa3ufN6yIeSddlgJpZyjKlopA/T?=
 =?us-ascii?Q?I+D5KEpgaW/83wbSWPSrRTRkoTUHt1NviJMwdEi8+l+syzId6Qwz2qBVbKeI?=
 =?us-ascii?Q?/yjTAIP52xDV0mprS9VbHdCARZJ0zE/+Be48LwF0+bNNaysNfD/xxM4wpQ1K?=
 =?us-ascii?Q?i38RqaZvRZzL52EJMANo1sv9itsHiDXfP4hYmk7PUrdPfvPufDN9iy7sWvKn?=
 =?us-ascii?Q?DaSp0LDLzrtRKLKbzoWl5c84KQ0ZPCJPTkhe3I6ssd+WuTWxBNQ18ePsbODc?=
 =?us-ascii?Q?/gmjeSAa0T2RMbFcCYEun1L4epeMAWV+Ur2+ALLs1L0T3sdgwa1g5TTu3/Bp?=
 =?us-ascii?Q?ktgPwHtUE9TIqs0zessLkJyWQQyuG0ywBK9J79w7C4nyXvLC5RdqI8XfBRC/?=
 =?us-ascii?Q?/O2sfuNP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83b11b6-4eee-469f-e84d-08d8c858c465
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 15:31:25.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +A0doY6ePRtMDKSg6oJZHfD/knkxsrHaXfPPMvpslOqQioLiNEnWyT5r5fqrv8XdX7WxwLwseYdfTs7C5Eunugu5eYPuuk0lbyAM9Q2RRmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4803
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for pci in the pvpanic driver. The device already
got in qemu [1].

[1] https://github.com/qemu/qemu/commit/9df52f58e76e904fb141b10318362d718f470db2

Mihai Carabas (2):
  misc/pvpanic: split-up generic and platform dependent code
  misc/pvpanic: add pci driver

 drivers/misc/Kconfig                |   9 +--
 drivers/misc/Makefile               |   2 +-
 drivers/misc/pvpanic.c              | 111 ------------------------------------
 drivers/misc/pvpanic/Kconfig        |  28 +++++++++
 drivers/misc/pvpanic/Makefile       |   9 +++
 drivers/misc/pvpanic/pvpanic-mmio.c |  83 +++++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic-pci.c  |  54 ++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.c      |  59 +++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h      |  17 ++++++
 9 files changed, 252 insertions(+), 120 deletions(-)
 delete mode 100644 drivers/misc/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 create mode 100644 drivers/misc/pvpanic/pvpanic-mmio.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

-- 
1.8.3.1

