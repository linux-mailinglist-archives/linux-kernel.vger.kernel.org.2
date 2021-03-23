Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF8A3461D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhCWOsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:48:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41526 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhCWOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:48:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NEi0vu188226;
        Tue, 23 Mar 2021 14:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=XvTPcsTk//SzzVXha7U/2d2O6x1yPg8RURS6m/7JFs8=;
 b=GBpfC9knd3LkZdPxjhbh9mK03RXAOfLLbmHFo+yxrZ1DKb8HgOSchf9EcOh42EYNkWf4
 kD3yBQK53yHBGyqNkAcyiJJ4S2YUmBEfw2E6QMZ5tyI/nGzariWvc1Vm/HRTDV5nEXKr
 YKKH413PjndIp+s+Yu0c4r+kczX5LfhSfQWmhvX7nMAdRcVIyMmHTxZjnQNgUjhNAxSB
 iDUc/Hc9rGIwMEqQpy47f126q7iBMmRuHT2ZnfLiQawz4baxTQEXgfxxxC1glBgdM0sw
 nhkOam6rD12Oj+gBdFSAkLZrQFeLh4HprntvN3VPhybau1i4LwrETIYVQY+PjYYh8Lzn XA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37d9pmy8v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 14:47:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NEij8m126464;
        Tue, 23 Mar 2021 14:47:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 37dtyxhf8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 14:47:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPu7krilwpWXocNwhKK7fWfloSBOBH9U0jMJC4Tb4vckXbk6XhsqCvqmKQRrqfkAkgdfI0tphAT1TiIJJVwG8pdkxqG+RGNEQjGQFIGXV7jlU+zqOx/2tVhFl7rUrAc8aNdn9fCIz+brKmoAyV+nPtnYRRgK4uRgYfCQbPjkL1+j/o6+KqnWEepZAme05Jr/haUeq2iYSjnnJdepsgS4536EUA9AdSDtp49573i7Y/e0GxtfxxA+kKG0gr2fpS93BG0sUKra1UClkRJZuoDpa41UNn4ygNQG8edPsv1+D+rJy2iyKM4l5OgJnqq5AJ+ZJJvbeVVd+e6+KNpshaA0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvTPcsTk//SzzVXha7U/2d2O6x1yPg8RURS6m/7JFs8=;
 b=exGw1iSeVrqLjKDMm/FuFAwTSo3Pi9PfiwJw+GPGIIZkWMS2DSLS2ZJ7NLAePqykS3J87c4pTmU3vwTzW44REhuagTLa1V23GkUT91p6eox6bwpf+16rlAYYVIjzAwvj/V+XUvOlnorUuquMQYMCIyA7csr3oySl/PLq9W3GvEUKBPgG6P2ja32D/6+FAl8jIF6zOwTUW3vhYqiO/m7tbWFl9NGlOghbokuzWjKi0fKAAYqu2521wQduqhngQarGmatCqafqh1x3ZeMOo2qy8V2rnBi4HnntRUgWjgnOAV/XZn8E6IcsTvS+C5D4WXZaLG0cU/I2C2QegA1JySig9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvTPcsTk//SzzVXha7U/2d2O6x1yPg8RURS6m/7JFs8=;
 b=jFpCa6nLzly+ALWB2ctEptbXjFQHy6wuq4RoGpC9apPSLPG4xyeyN8Z++JPCu+OtyKB1oUmlNBBAaCneb0wyuEk1t6FqE6RiD5QndaC8uCT2zdx+qctOxSh0B6njQgePo/ElQ/A7Mn3hY3bZm5WaW/J4p2bhn/ZhRaWVjgZ4GRk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2304.namprd10.prod.outlook.com
 (2603:10b6:301:2e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Tue, 23 Mar
 2021 14:47:34 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.033; Tue, 23 Mar 2021
 14:47:34 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v7] add support for pci in the pvpanic driver
Date:   Tue, 23 Mar 2021 15:59:35 +0200
Message-Id: <1616507978-15661-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.201.25]
X-ClientProxiedBy: CH2PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:610:52::21) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.201.25) by CH2PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:52::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 14:47:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f587ad1b-4d9f-4a2d-dd9a-08d8ee0a97c5
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23040D3B697127C963F46E6588649@MWHPR1001MB2304.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYhhi79tIdaJMGinZ2P5u9KDnqcyJefHQADBNhnH77x/ljkW0zmKoDHuK9Q7nGVak4Mr3DYUCID4Imglz+UzzyfIXKiwQx2HCqMQrGeOWtPGOYPHy7TuCG/5OYfLFq4nfKYyyNr8TRpgWEFKpv1KJxLyZ09+BzZt0SxX5yQE0RZYmWBvZtDQiFGGk9HGTkuHyfG7TDJqAGbBBd/EhfvfKMyEJKF4+hh/ueWpuBNjhWE3grLOJBe2YjF59XVw7HaP1fsTbdwIhA2adm1KDp3ij/sRlnBe0t1fUf4UNlKMtRqmqbI7InluFhNE/tjrSUQOUdCHZz+budCACGDwyGRBlff5ktKqdtPQWkFI6C0Jr9NR1VmVbbV1jdJG3bzqXyErLtd+JF9aeQv9Shw/O+4aWxqSKOr04M1fwzqCKmLfEJJhRWkSU3iKICYKNcxWjiifUxo0qaS+w/yPZEMKB9aBDpqYn8oFVDNnE5qP2EEHJWGTuDEbzG8tQNwOO4REe8qViDHQEnq/dbgHTFUIbmg7qQxyoSlec7oTMCTmpIAJjnRCNiAnDCA79DogZPcPMwDzAJypgDuteNdVWRG29fs+M01XpRHgW5hk+not25mhTKVFqDP4Q9gq+w6/STk3DDvQyTIsbEyemP8gAbcAuF8HNXxK7yXStA+mzJQoLZz0K+XPqCHlJLmvc+j1vWcOc03draJAQmNmT8bD3Be9xVt4NYeL6C0qIs22+rzlvaIjepY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(478600001)(6916009)(83380400001)(66946007)(5660300002)(6506007)(956004)(107886003)(2616005)(44832011)(6486002)(4326008)(2906002)(66556008)(16526019)(38100700001)(66476007)(8936002)(86362001)(36756003)(966005)(316002)(52116002)(26005)(186003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8lRlvuYr64GLgkhO8Aiwq4ryUd6GRZfhrvXg6PDvBUKHfbEMbadXHqNgvRWf?=
 =?us-ascii?Q?JJAN+s7b3QffoVc8y38qR2fENoIolevsc+BzU2cIGrEcy6RhGOHWgV9f8KI3?=
 =?us-ascii?Q?VgGX7xUevfcGMH+qKVMlhy8XFaBHvdZJejwMT6jkdiAZSkvrB3D15bCNbWL3?=
 =?us-ascii?Q?cduXlD8A+U72ZLYQbTCLUxn+MnTHr6/YdVVacP2TuZjDyl5UnwhReECgr6wr?=
 =?us-ascii?Q?loZxtNMuQYai68rVHWe9IHugb00jd4wntz17Lkwyd+4y5v3uRYCfw4+P6n1x?=
 =?us-ascii?Q?7gqa53DJmvMfK1fT2/c2FYRKoSKglCHq1RcWQJQ1X4c3fL0Gs1/w6RMDhGnA?=
 =?us-ascii?Q?9qsyZf0Is3Txaz25W+a1Hjro/Eh9AuofYb7IcdnhLvmblH/lCBMALGnMyk2z?=
 =?us-ascii?Q?+auNL+uBwk0B4f1/TlEiqmGFds2nj2ZxzE+bJn1xC2K3cR4liOHVNaz60XCb?=
 =?us-ascii?Q?WizuQC/BeAtbNRbI6TMVzBkDOXyk2f0LVL+rIw8bGvljsvz+DAMRIojZsuM8?=
 =?us-ascii?Q?6uQepq5de05O0UAte7XmO4xv4bBmw7aFtbtHJ4G/aU5B88KmiRC654GsWapD?=
 =?us-ascii?Q?pWOGA77TyIFAPMuXRb5csby+TBFsxDyULDqIrNmO83R3URFsv2998Xu5tPg8?=
 =?us-ascii?Q?GiTLYb8X/PkadmFF5WqmbxDGKBPC9BN9UDBoPz4pk+bweuAHz2YUeLO2Xunw?=
 =?us-ascii?Q?l2vEOaDgh3yCC7Rg1lIIn6kVyRj3YkWaSecg9SslsE8CKywuLwcINQOGvtpI?=
 =?us-ascii?Q?LxSyTa4VgdxuBZ4am0UNXQuMA22VkMeG5xSC/W47IgYyF5oTSSxYdt19JAMW?=
 =?us-ascii?Q?bZ+Wn1wYqgiTAAHK3V7Pv7tXRsJLtdE5IEVhLdMGwtU/iME2GhJzGDcuyZ5J?=
 =?us-ascii?Q?+ORgK92+dhCrVAwfCSpYQ5qMUk9t3W9yHQ9aF9QBgqdGNo6Top/A3E4u3l1j?=
 =?us-ascii?Q?u469HBZAlK2YMzagdZQ+rz2Vh72bA3LHNv95hUJh2PVW8d1jJv1+BmVNqPSP?=
 =?us-ascii?Q?DgPfxJKQnp9TYnSjwx+pXmnHslnl+qtB2NuLNnbE28dmQ209rN4JUVOtv1Uy?=
 =?us-ascii?Q?bJ/S8wuEG5IiOxRXco/fOJ0H8jPQO37yTJ156GyzlbA7eIn34OYB61BYB39S?=
 =?us-ascii?Q?sB/GFat1OabkCXFA2GwTqfEJ/gxpoSIcC7NKFDGtdgGeOv2fBemEjwaDgH1g?=
 =?us-ascii?Q?+co8DsJBdvblbNE18y6GyxPtwhQdfOZ5aX3pwkQBGy5FIylqNyuYyD3K/zx9?=
 =?us-ascii?Q?WH+peJZvMo6RbKE8dBaaNeP8Q8XMkzaMtAF2zIjaCh+sy06CFxtqG9JzwOcv?=
 =?us-ascii?Q?xyEQ4jF3FAg+5GkFs8THK603?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f587ad1b-4d9f-4a2d-dd9a-08d8ee0a97c5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 14:47:33.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT6Xv9QalkYRRWBTO4XvqiZiDh5of5RSw/O0nkxGWbcOB/OY3uOH4FHzBL7WA9fYVyLqAaIsJlxGO1YOsXfdpjaSg51nS3GbaUabXEGJUEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2304
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230109
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

v6:
- remove pr_fmt as were not used
- "remove" functions of type void
- moved events/capability per-device structure

v7:
- rebased on char-misc-next

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

 .../ABI/testing/sysfs-bus-pci-devices-pvpanic      |   4 +-
 drivers/misc/Kconfig                               |   9 +-
 drivers/misc/Makefile                              |   2 +-
 drivers/misc/pvpanic.c                             | 161 ---------------------
 drivers/misc/pvpanic/Kconfig                       |  27 ++++
 drivers/misc/pvpanic/Makefile                      |   8 +
 drivers/misc/pvpanic/pvpanic-mmio.c                | 144 ++++++++++++++++++
 drivers/misc/pvpanic/pvpanic-pci.c                 | 121 ++++++++++++++++
 drivers/misc/pvpanic/pvpanic.c                     | 109 ++++++++++++++
 drivers/misc/pvpanic/pvpanic.h                     |  21 +++
 10 files changed, 435 insertions(+), 171 deletions(-)
 delete mode 100644 drivers/misc/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 create mode 100644 drivers/misc/pvpanic/pvpanic-mmio.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

-- 
1.8.3.1

