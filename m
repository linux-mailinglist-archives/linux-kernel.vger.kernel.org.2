Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2800C31ADF6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 21:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBMUdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 15:33:17 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44058 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMUdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 15:33:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DKW4Po172078;
        Sat, 13 Feb 2021 20:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=dxqNT+UK1greK2yEn0glrE2IboRodFm9ysfs9ffY94I=;
 b=pQlIdKXpWwPNbowZNHyMJ7IGsaY6oNNs2UD9cGtFRZegZKei/YzC7JdUg7A2imbeWxWz
 tnuAb9sXe5IRyPwh5MQi6Pz36PElWqc7X7qiy/YQtXRgcFYdAnASqr/usppbSTSIvsv4
 7IMk2tb5O5K5ZGuw0l1DsX0BrycfBE5gEOjEcuw5hzUE2sLr44M+KTC1HcpYnEEjmDWs
 OJhPQl53UjGN0D6s1MV1zfzXgJFlZy5DHxy6U5Q8Dt257hcoVcmMAiynuHfBo8XdRVst
 9+VMtLMSey6hEiOS8rYDgLm/P+oalfCrgbd0Gi4y9iMCxeapsoGcf37VU8evgfKwMUVx cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36p49b15u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 20:32:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DKTuCp093952;
        Sat, 13 Feb 2021 20:32:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 36p6k0225u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 20:32:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZ0qhEgBQhMyy+Q4avD/nLcThAXnC9NbZQdeyEXNUUxSzYOvjCySYvOFXQ9xko/3Wcihwb5tkLK9yX7AC93wOlE1MnIThLaibUfO++dmu04swvc1NMX9qBKkyuWRi+PGwQeMFB1nlP/2E3yXkzpg+YM2A+XWpN28U8Q//uN6KEaOE8hcEWWqg3rIqcNkHS3LvyibPQvKVq/ugIhtaEh/IGAoeBFsVnEu6iMBBa/3ED/AtTqUwIKzt4vAXp8hua8Rs8veihei4ww8/aa1K27Fa9m+MhzXRd2hNyBpERMh1m+fq1UdenkyFwANGYJEhVrX/JRGfYXSAUfS+APbjJSJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxqNT+UK1greK2yEn0glrE2IboRodFm9ysfs9ffY94I=;
 b=WksXW98WN0qrPbo4EJ7SLpTAJhkCzpkus5SKdDUeB7goQoas8GjhmL/FwSUSdS844Km1EP8Q1nWVI0PV+ZY2v4ALBGVVdqCrcbRLI8aLJ/8/QQ0tuaqnErgWN7+ZMlq793bRLAAcRi1pB2ZQjgvbzaQhZhPa28J3sC0XmWrbegXMEE3Da7PiB523+Ardg1TI/+otRPF9LP6X8QPrgWdkdUUJWn2haAn2KyKQJFKZSlyKTZUYqGF39AAiJ0L2jdFOM5W8eLfiTqrXrJNRnIKschqqD1KOdsRMKVLr3ldWqhDy46VLxJycor1A3IJap/KvDt4QvjJLgyJ3pQg3Ke+Idw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxqNT+UK1greK2yEn0glrE2IboRodFm9ysfs9ffY94I=;
 b=FV7xhw6IIAAZVj2IcaIssSJGR1lNloEPfwluPhHLoD591g3Osg41rSSZ4ZUYuQu38BCTC8LgRbaRiForRYcVbUWbjho/NbB5WwThnTlCxAoZi3yJCPYR43X30tD+SCxqNvZiZs4GAf/clPRC2xGaJan4ptao1npqew3VPYehPTg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2286.namprd10.prod.outlook.com
 (2603:10b6:301:2d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Sat, 13 Feb
 2021 20:32:01 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3846.038; Sat, 13 Feb 2021
 20:32:01 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v4] add support for pci in the pvpanic driver
Date:   Sat, 13 Feb 2021 21:44:04 +0200
Message-Id: <1613245447-21495-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend Transport; Sat, 13 Feb 2021 20:31:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5521a4a3-802e-4306-555a-08d8d05e6aa3
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2286D00BF53074AA17DD154E888A9@MWHPR1001MB2286.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWEQ2mIOO7CDQrsU39GwRgLvyLrbmTvpCe6LzE98xKalPxcSb12WxHCI8BrcoNS+hj4g0Nh5ZoCkHbDUOVTL11mSNdFlyOZMnMUiSkOxtF3PwWlbL3iLuLg5fY8IhgSKVafB5UWSkMGsN4F0UoGEintvoxKS27D/yaLwrA9EDPQEQYtKzS4lpMI7ZlHC5Tvy0+d71Jveqmx8m/dOOmktSA8SZEFhWsrQYEloyaWPy3jIkyTKvTp/rMMjPjL0+jOzevPwmWC8PWugvv2jwMU1z8qVJrS4mbMFDPgsY0U0nzpxMksajYBYR12+8+xraeuqpAIw5l5NtEsIZX0Nq5DjBQQ40+vM68EEsHXeozHq7VJr1EwMFoSqjPvTWWLOiGfNp8oB+dkrbOogwbYeYBsUZ4Np0oVoowk61tx7bAOT4jFH7R0/WW+ygM1Tmdq1MMl4U9PH7mioD0mLQfy/jGFokfkrYM1KCLm1iLDLrXkyOgSTGdXtL+lQdKc3V6KZR6uPGd3U2EXPizHTk6fKm2oMkozKEkWAJtPW80GrCAlMfFEEwWcktTJ5Ng/fCC5QbyVyk1w6ZQk1KEqF8Ot5El1xuU0jhyGLzTPBbRUaJDgqQxo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(83380400001)(6916009)(66556008)(66476007)(52116002)(478600001)(966005)(86362001)(66946007)(8936002)(4326008)(36756003)(16526019)(26005)(186003)(6512007)(6506007)(5660300002)(316002)(107886003)(8676002)(6486002)(6666004)(2906002)(956004)(44832011)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dYpNcBFRXu00yM6yWkNguXrKNLGEZPBhSi/a7znXn3S5MuiB5DolMQ8w/oAO?=
 =?us-ascii?Q?WTGDkgK+8Qtzdu0js4FmDYadDQOEZWtGWZogQM+mDRbo2CQXateQRfRRpsvn?=
 =?us-ascii?Q?whTY4MmRf/l7FkyCKOBU5v0pDEwaF6XQ/1CEtOjL2wYONF4kXXpATkFhXEWD?=
 =?us-ascii?Q?KugRH2D3goY489i4IPCm5TryRhJo+p7r+yBQ0fLeKQN4t+kO5Fuq0olQ1lxh?=
 =?us-ascii?Q?ZdnO+reTyH7o0IOVxmU6B2lN1GEHoQU2ltiuj8EShOTKNK6Z9brYeb95vMZ5?=
 =?us-ascii?Q?6XqkiUbOR7HZ6q9brZpf8ukW0BP0Z9sWIXD9WwPM2idz2p1vcgoRseTgocxG?=
 =?us-ascii?Q?JGACjuZCb/UJfWXdX3W0GHORWPmJYKjl5kOfHQgKqu13G2KC8B8aylRERzDD?=
 =?us-ascii?Q?KK1M17u64AqWScWToLApEanCTuAOWVZFTpjId2iKkP/ELoZywItvU/WYf1tW?=
 =?us-ascii?Q?5nq3By4K07RGYZ5Hddy1nnJn0oeJbqJ3vcj1wuR0cTNQkPUMaj0nqRW9IWjT?=
 =?us-ascii?Q?G/wlYCYrJIiITLl1TuitKTlCmHtKxbPGsCt91iz5ZyuDQ9BFnVT6905yluIl?=
 =?us-ascii?Q?qdqN1ZC7/8X4epTU6B4GVY9yhOWzjxXtNHEig27o0whWYrOALZHp6rKHZqub?=
 =?us-ascii?Q?gfgn/pCX2PR3qtrouT0FVIMAJfDb7Io0vsy/QfnFkgrubuspajlEwiSoyuI3?=
 =?us-ascii?Q?8jwQ765wvz1imG96lhVsvlYGenYRxHJZJgPbd11vEyhBR+GuGrvDqv3Jkkw8?=
 =?us-ascii?Q?G02mp3RWg6eBv9EmKnQdzS+V3y7xYt2z8Bp4BOkxdpqKVyQCIIAAgjXeh21/?=
 =?us-ascii?Q?cvcjANzsjnmBifcn63DZ4oyxsYmeMa0IEcnPbZylDagtw7T0360kRDv0SwoQ?=
 =?us-ascii?Q?X43YgxMkhH/b37mFHfxVkELlxdSlMiKbhZuDyFn1ft7JCAP71vKV5Moh55no?=
 =?us-ascii?Q?R3ezk/9o0u+w6RhCQgmVwOs6eZS1hU0g6JHLN3Zo36/uXwYeeV6li1qiiRvf?=
 =?us-ascii?Q?Bnhwl1HnibHcF9cpgAw1ycHvx3ftWyzvP2dzlz55H6bDsskDjYdv4NI0mcJy?=
 =?us-ascii?Q?GUoIhlpwIlAi1DofeuOj9LyzfiYt2JvKCatGi6ymXr8oKzxHC464dI60GjvT?=
 =?us-ascii?Q?jV9EE0RTBDzhlTkDjYhhWfbnKrqsL+WlnMFOEtITLTmCOvRLogJbhFxfI7d+?=
 =?us-ascii?Q?Q7ZwFHqjKYBbE/yxo8XQo/hcpAmLlIV3rVLhxcctERAL1pd/BbgqzPKzqYNi?=
 =?us-ascii?Q?qyXMr43o/UnOHqt5QoFsfrz8qeKLk4YWZb9vVMPP7uMT5hJ7Nv4KO3o9oMIx?=
 =?us-ascii?Q?+NlOZ6z9Hi4+wcOHvHIO0P7B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5521a4a3-802e-4306-555a-08d8d05e6aa3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 20:32:01.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mddrGcY4LdCqvjhgzaus6NgNoj0UR76GCJ6EanjmLGT73A+mFD/ciQzYTbw9RJUMxte2zvRtx3en1vt2bPzBEDZi4YwDqRkszJ+hR+hOi2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2286
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102130190
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102130190
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

 drivers/misc/Kconfig                               |   9 +-
 drivers/misc/Makefile                              |   2 +-
 drivers/misc/pvpanic/Kconfig                       |  25 +++++
 drivers/misc/pvpanic/Makefile                      |   8 ++
 drivers/misc/{pvpanic.c => pvpanic/pvpanic-mmio.c} |  43 ++------
 drivers/misc/pvpanic/pvpanic-pci.c                 |  54 ++++++++++
 drivers/misc/pvpanic/pvpanic.c                     | 120 +++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h                     |  16 +++
 8 files changed, 232 insertions(+), 45 deletions(-)
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 rename drivers/misc/{pvpanic.c => pvpanic/pvpanic-mmio.c} (67%)
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

-- 
1.8.3.1

