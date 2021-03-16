Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A603133D499
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhCPNJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:09:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35348 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbhCPNIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:08:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GD3ZBD015889;
        Tue, 16 Mar 2021 13:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=YwzSaZTfwbxkFprwtM9kMdHw4Y1PUm2563uOt166LJg=;
 b=VHeimpizdEFb8TByTxxuQWPDmiTi/1atvxM/VBjoEMgFxkL4xrrIhvfsPDD4fRcyIzt8
 Rn5RbFqYdG0q1XQHcniDBAUzCHTgFkOG/A2sPkoTDsBh+k9KxJCzU/7MzruVZUlO6uqJ
 ZcTGt0eLl6hh1jYWg4CmZNThoBnjgzu7y09e9JJ6omEYczEJEVnN2zhvbCOsrjdqbJFR
 HhhL0mH6dcbxU6bVJt4z65QKckQIQe3X/InTfuDhaAj5fEMSlqxdpHW6Ikij7mYhwtEv
 s6pz/cIE6BPhVOApEYZ45rQFSQcMXBeaVSFP04+nN29vyA+Z/MZFOGeZ8+DVbCwPDy4O tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 378p1nr33g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 13:08:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GD5pqj091084;
        Tue, 16 Mar 2021 13:08:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3030.oracle.com with ESMTP id 3797b0246c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 13:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l16K0DjVQ7R8SQO17s0U+tFjIONnz4yd+CUtP9hIRyDWEAgNkDxlqUTNdrQB9GUdJQ8tPmqFVLnbTHBv/H8HnaR8O3Au9YQV4yPNwBwQJRKxfUeHv1ETxb2E6O/Gh9j/aIlCDDhsSfVvko9ubtm4fgxxLZHAkvtWSsZwfZy6DExzUplvLT+Wd3+CZiZS1JKjRdZRDDIV/VYU5xTTRV38jnaCse4bkjcPtnTUMIwZdzf+2L+NTCkkX6LqI2ApgIm1Yigu4fetEbdpFNzS7OUts1EAAAZSfsoVje15+5GyH7Un33s2Fq1GQoHPlyMf+L7iIBEB/6tp+7eWJP12MvE0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwzSaZTfwbxkFprwtM9kMdHw4Y1PUm2563uOt166LJg=;
 b=DxeOQUG60PkZnF41KsxcjVz6Zo1h0J0qHXIzRH3J2A/MTZoVnsK2e3ot1Wid6Zn1jSm4ZteVWrkMozM74rwgqQmza7l1tXqqDbgagBJ8r2UPcHGsGz6Vjx0hjMN2Gksx7/UkPt3eraDieBtSrcrGDIU8Zvwk505xp7vWz7ATXrla+ws/Fdra6yskSmdziQmVPKp9dsrNTKkmMA+73dJS609n9SPPVkEMkRFJXAHZD78P2/Vb3naQH+4rBayWNWCuop4WTSn+GnS1KdCWR7leYn/P2STSzIgGfZ/hBtzSmzuTIpYCK+rWGm9/ATJjDvAHw1vGkUHLBoI5VZ7DQb1MMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwzSaZTfwbxkFprwtM9kMdHw4Y1PUm2563uOt166LJg=;
 b=iMLpYyBgFuWo10gGLUTQw/J9OlG4nTAI3sW/H/VQsGyvsOT+kLDaYDpCbkqrxaQBMS8z8staYFhwpGzaScHawfzfzjWOllKGcSJF1yVxrZr3svhX01/FoXn9xV8h6xBLDV23gffvQeFDtioPZ1ZVaQ9jkyTnxS9Z54sGOtVlOGs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4435.namprd10.prod.outlook.com
 (2603:10b6:303:6c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 16 Mar
 2021 13:08:25 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 13:08:25 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v5] add support for pci in the pvpanic driver
Date:   Tue, 16 Mar 2021 14:20:26 +0200
Message-Id: <1615897229-4055-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: BYAPR11CA0045.namprd11.prod.outlook.com
 (2603:10b6:a03:80::22) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by BYAPR11CA0045.namprd11.prod.outlook.com (2603:10b6:a03:80::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 16 Mar 2021 13:08:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c1ca79a-e46e-4be4-25be-08d8e87c9519
X-MS-TrafficTypeDiagnostic: CO1PR10MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44358A633439BCE5588A169D886B9@CO1PR10MB4435.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +L2EkcJPkXi7xFvXeeRKKQZKkTyRGCH+jLNRnepUrZEnSOoU26nTmEgB+2K4HriWtPXr/ciUYyNszFu9+GOaIqOvDzbwslTj0bE/3KWcaK1Fi3HdYATKovq83l23/87TIg54ZkaRJvEFec+VzdQLW4CLEEOAFgxpzGZ9Q9AqUfc131d63v+G8NFBfAkH5F97ZPzUhxY8Rh/2b0kBYOfon6JR+hgdMkS5CuueiZKwsv6Sa+EEPV52x2n4jK1ebPUkuHYptLRlz8HbteGOkJzCpCLxzlnPSag4fc8VmcQ6Bm/2KGbTsDX46aCLidH6xdxQoDkQztRy+2ZAqlXm+Y1LG13Il3kkUgHvD6zD1guP75tzAjYpYugYEPb5bW805eE72iW7KU/MZRT3cv4xqyaGadB6AZxWJPPOlXkGP03HRrzsvDiuoYw0AeQ6xc/qA6vSplqsYjTOL+p8Nz12w0hKF2lFbBh6IxVOjcErUzxFRqUKnAo+eGr6/FxjLW6JVDdEm9EFuGoWHpJrT73oxewtRZ0XoGfSH+IvR5Zn34871wn03R9e+2OL8OcbJqM2EqS0HxI0TLE7h+rRoQgBKk0h9opqzai7UdA23UgnbKdY1nVWSWqSlJMUQnpZ7lHLZnmdNYil1S+q+0pHTTHW1RqPnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(36756003)(2616005)(956004)(44832011)(8936002)(6916009)(107886003)(83380400001)(52116002)(6486002)(186003)(16526019)(966005)(6506007)(66556008)(66946007)(66476007)(478600001)(86362001)(4326008)(8676002)(26005)(5660300002)(316002)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LrNjDFPkd7tecwkvsL7QSMO1LHN3i9Sj4KTVV5R5TVT7droU/Q3RXp2k/Xg3?=
 =?us-ascii?Q?mGbYT3sOoMTE5mBRFX4jjWuni7hs+dwxrWFdyM/0TkyAs74gx7HUh18SH4v0?=
 =?us-ascii?Q?UUPDuIZJAPhTGiAFeV+UmIBgBYz7NCk51HatZ6Jo4okmY5lVgIThDx2Dl9p2?=
 =?us-ascii?Q?fifaRNeBO7yA1vzz33EY2nwdtRSy/kHJmkfnl3TENjTBtzlEQfNZDzhQXR83?=
 =?us-ascii?Q?1puHoSZxCH27qi7Y2AeEviqrr01DRWsc/yUqOpEwwppU7+WUCW9HMLmXI07C?=
 =?us-ascii?Q?mwjnksxkKpKifIr5zKjYEsBCmQaO/QH4aEeCsYdA0w9IOJ1kOQjYJR9yH4ep?=
 =?us-ascii?Q?/SFPY/EvSaRujvafg67CvdyqfKL0dfx3/YMzX10zqhoWZ/ln4Zh7zZfUcDwT?=
 =?us-ascii?Q?sPbGSSUL378DJMTTk5ZYWjx20aRsyL1PMfcbv+UX6xXyw2Jkhec8Mtrs+dum?=
 =?us-ascii?Q?V0lPQ47Gk03kDc7Sfrt5FKI1SRttg/uXkwFYKZOIa2XFz303BbUftYY9u7CY?=
 =?us-ascii?Q?g+SgmQAAjpo/f4QY6dUfUx19Oascat1bLPSs/xalgWb6JVEHIYt0a0u+oYIF?=
 =?us-ascii?Q?n3JpAldNL0C5x+SCqX84sn1/jshEbr0HMImEYfQCMfr835elBbT140VijVZK?=
 =?us-ascii?Q?3E1xoUIieAi9tXIVLIwPDJKnIC7z+meJqAoepG8Z0Hfv00TTBkpDJI6/Z+up?=
 =?us-ascii?Q?RvdxQYvXwZp6eceWH5MgtMYSUcvRMRNpndKMYP3S2SeYzfQPhf+RbxZAAleD?=
 =?us-ascii?Q?0oSRnSL+90zrn8yGWyAfGuqj+4Y78DmBKbBF5QdN4QP3QCVPIv42EdG1O9hn?=
 =?us-ascii?Q?zRW6IX6FipwuacufI4KOqMdJlKLTq9EXyX++XO6Uk3rI7MaynltbBJ17ixQh?=
 =?us-ascii?Q?wm1q8gx4oTTjZ1fRP/vKZ74AgD8J5QzqLJPgD/S3MXHuOJTcNLCOvS3cAdjp?=
 =?us-ascii?Q?Oa9I9RwOu0bf7zSenMbD1Vr1aKR6PDYG8dZVGofwpz0S6/iCfca0A8GSRqua?=
 =?us-ascii?Q?uf7r82Sd1fEacy/tS8iet3ER1MsWehMeyM9JwvuhBr+wnP9EH4T29AXwtx5E?=
 =?us-ascii?Q?QITDgnCFgA+4EtUsWzN0x60iGswtW7q2uLwZHXjuMx70IWYlZl+l6qTH5YIo?=
 =?us-ascii?Q?Ev66SbVe1NuwE/iL+JmfAM5+9eZsrp7v4EHW33uMW/F7Xv0shm2GhnYxTlCU?=
 =?us-ascii?Q?OjZJPlLdzzSbiK62WKPDz+mTUqH9znOBjMpDar1ludX0eEayhF+xwr9lCFjN?=
 =?us-ascii?Q?rKuPBjfMtcceHyn//ps59NQ3LlVIqoDHQnAEXZiM/SOje3aooXH0wPiPzShN?=
 =?us-ascii?Q?SY8irh3ghl4J87ZbUXJQKMuO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1ca79a-e46e-4be4-25be-08d8e87c9519
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 13:08:25.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JVZYq4Oe3bdeEupSFFopSJqeysTqc6AB96Zw7DDuZ93HKFa4MVtbRilqCqHoqP5uLEBGhWUjXgSMRrqcdnTlP6kX6kKj+QMgIQ0hKvGon0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4435
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for PCI in the pvpanic driver. The device already
got in qemu [1].

v2:
- mmio -> MMIO, pci -> PCI suggested by Randy Dunlap.
- group pvpanic-common.c and mmio.c in the same module. The intention was to
  have only one module and the common code splitted up to be re-used by the
  pvpanic-pci module in the next patch.
- add a new patch where add the licenses for the new files (when I moved the
  code to mmio.c I preserved the original licenses there)
- properly clean-up PCI device when driver removed.

v3:
- drop patch 3 with licenses and add them when creating files
- create a new patch (2/3) which allowes multiple pvpanic instances

v4:
- fix Makefile in patch 1/3 and 3/3 for pvpanic.o as suggested by Arnd

v5:
- rebase on 5.12
- fix a warning caused by one of the patches

How to test:

Run a VM with latest qemu which has the pvpanic-pci device:
qemu-system-aarch64  -device pvpanic-pci

Generate a panic in the guest:
echo 1 > /proc/sys/kernel/sysrq
echo c > /proc/sysrq-trigger

Observe in the QMP console the panic events received by the device:

{"timestamp": {"seconds": 1613122186, "microseconds": 141729}, "event":
"GUEST_PANICKED", "data": {"action": "pause"}}

{"timestamp": {"seconds": 1613122186, "microseconds": 141833}, "event":
"GUEST_PANICKED", "data": {"action": "poweroff"}}

{"timestamp": {"seconds": 1613122186, "microseconds": 141896}, "event":
"SHUTDOWN", "data": {"guest": true, "reason": "guest-panic"}}


[1] https://github.com/qemu/qemu/commit/9df52f58e76e904fb141b10318362d718f470db2


Mihai Carabas (3):
  misc/pvpanic: split-up generic and platform dependent code
  misc/pvpanic: probe multiple instances
  misc/pvpanic: add PCI driver

 drivers/misc/Kconfig                |   9 +-
 drivers/misc/Makefile               |   2 +-
 drivers/misc/pvpanic.c              | 160 ------------------------------------
 drivers/misc/pvpanic/Kconfig        |  25 ++++++
 drivers/misc/pvpanic/Makefile       |   8 ++
 drivers/misc/pvpanic/pvpanic-mmio.c | 129 +++++++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic-pci.c  | 102 +++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.c      | 144 ++++++++++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h      |  21 +++++
 9 files changed, 431 insertions(+), 169 deletions(-)
 delete mode 100644 drivers/misc/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 create mode 100644 drivers/misc/pvpanic/pvpanic-mmio.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

-- 
1.8.3.1

