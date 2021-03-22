Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9667344D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhCVRde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:33:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33528 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhCVRcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:32:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHU3QL079588;
        Mon, 22 Mar 2021 17:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=3aV+WchaCNV/O1lpv6Fa2Ms7ISysX7FXMKp4oUkJ+34=;
 b=MC4tDixfbKft1rLHhLTiwUMfT5l8idUOscV+B8nJEY2Dchjpou0cISlCj+oxAIgycQ2f
 lhWL98n21qCuYywMa8HoMInwqHRSIzFx54qjz6fuWtQmQP1mmBSwhgwnWN/P4aDWrLiS
 ucchm8Y9jyInzdD0zrgDdkwKbXVFd4hG2ek8JgHkC8AnzPB6bctNf0UmSUd5luuobZQ4
 FrQRu2ZVbk5LXqVNCNoxqhhYAR1T+UNVk+GUSMJwqxlZeDD48eskam1y7Fvd9t/WQTnK
 NMQnDv7EVNFZ7YnYHAYV+evWVdVyj2G7O8nMn55ska1PA7ZB28fNNme4a9JS4jcpll3V sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37d9pmv7vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:32:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHU5gL033319;
        Mon, 22 Mar 2021 17:32:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3020.oracle.com with ESMTP id 37dttqv7e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0O0K3yOZ3s+d65JxfygD2IJkyqIATHhpeMgUXPbxqNpMML6FNLhmKzMa+9I1q5KaPGgfzATtHBqSqE3RmjevFfCRy0zdk1YC5kRypAJS6l+fQF2PNLURB990A1CpsgrIKaopkIPNwfBdtDUsGZpZqYdrpHthv3hlK6NHLmpZ0KNQfo9+OwcV9PK44lA2oHtXkNpzto/oaURGVTRAvU5MKZPoaUeZNiKzPBrFM46hpjMUlEMdyB2VH5r35qnyK0yO+q6wy5+DF2xZs5iZOGLn6eiHyibWpVP4ACuyW7ko1Ihz9bxueaBun4oYZkE2ad11W0Cq/5sD4YDzteiXtUSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aV+WchaCNV/O1lpv6Fa2Ms7ISysX7FXMKp4oUkJ+34=;
 b=LWrQs+GmZpFqCpZV01B0ztSrbxVkilR/wkahyE+MAaP0ab/yBn2iqKvhHNb7RwepGWvXdKx7SmHkbT9D+maaQkFGeLK6XhANH5x4sbqi5N5d+amy0w+Qup96pQpuAAseJkfMsxQQBwnOePm6wuLH/7VhMucAe9HJD1wtVUyJ0Ebcx/XuXX2J1W7JhUf/nele+xpIOg0B+w+6Yx9IGtXAjfay1qIqJQWxq6p4X7k/JjC2Sp58SZeKYo9oXr2xpW0Gnl9TO5l30MAeQWzvrKxLnHFgWDf/1BDvSZRzMJWGZW/qPjJ9n15CeqGWnMx71Wty/1nsBveHrqQ4n5YJ3bt5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aV+WchaCNV/O1lpv6Fa2Ms7ISysX7FXMKp4oUkJ+34=;
 b=oG/u3f/YAhMjOazKzr+SS5WtA06RT7TQ0cpdrDFX8Tq7nP+Ufk9pfL4BGT+9Prp8BAGq/zPkbkvFKYKDuPomHWo15S2sR2Xr6mkCbXhDTbC2sTAEqt9c86FOzhpTeGf/mjsNRFz7ZjXqCcdaX/VPuCzkfFlbslTWMKlspc7AhlA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4451.namprd10.prod.outlook.com
 (2603:10b6:303:96::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 17:32:27 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.033; Mon, 22 Mar 2021
 17:32:27 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v6] add support for pci in the pvpanic driver
Date:   Mon, 22 Mar 2021 18:44:24 +0200
Message-Id: <1616431467-14173-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.201.25]
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.201.25) by SJ0PR13CA0092.namprd13.prod.outlook.com (2603:10b6:a03:2c5::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Mon, 22 Mar 2021 17:32:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9db70bf-39cc-4a5b-c5ab-08d8ed587612
X-MS-TrafficTypeDiagnostic: CO1PR10MB4451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4451EAEFF6DF6D88628660C988659@CO1PR10MB4451.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIxFcPSV5nP1Yn/eK5gCp3v5YieCQz4pG1d0CWgBA49w5FDSVTUHzkaNmjqvOyvyzebMXA5ekyHCsskCmL2tfzErnAwWgiapMTyAUSlOz1sL3haeUp+fIXd6pKqrLxaStsBh21BnbKRCWGrU3RJQHFiPFvF10tiO7f1q3FCAx7ATHH65/jH2dK1thN6DXmCcWbNjy8UXxnUeBG5cBOlY03A8bysusT8Q6hGjs+VVQijrrPOEdsY8ZflFjycHacUNypbSxNLQ2ACIYSZ8PcGXuVfqaEgaCpMx5VdnuM0/ztZw4XnG8f7s6jnt8rTv/cNy0sIk447MCEYnfNjLFhLnyp/bZ5SeINwe7SilH2VXKtYjDzuVFJUpVWodSIctYBz7cz+pxgW7pHxUOyDvs4eBJ9b8LyCoLF/Ep2mKKr+d1Hr8wwh4CZjg2+REj8/DXtwssx1yqeNeXx7sdI2wOqbsgzoSr2bJKCidVXhJ/bLW9uI3ElX7e62qiMwdlQEKcjhi+mqhNl9fL9zvv/z6SNQubqlU5WkjC7U0R54UGjqVukeVMffBtHdrtaeF7SoXvPE0gY/xfHU2BSmWlBEingRv3HH2BdCjiwGDzVHzAZSedR7GdJAAAnearD9V/W4Upj1GuPuAv/Nlm0nW/YVSGxw2TuuHkLRpDI+xy23dDbhroo2HTTcqrO/vsmuxIdLJmtrE9suQUF3bMXevki7+z8mFKYPgPpMBTjlU4MQVK5Z1XUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(4326008)(2616005)(956004)(66476007)(66946007)(8676002)(107886003)(83380400001)(498600001)(8936002)(38100700001)(36756003)(6916009)(186003)(6486002)(2906002)(16526019)(26005)(6506007)(66556008)(52116002)(86362001)(6512007)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FMl481J92EBGjjEV0b20g72usGs9mJ/U41fgzFl95M9S8naQpfR0Po8F55Kh?=
 =?us-ascii?Q?5eFFZwidS04mPgjqTAogKqxuO2oYRXjcv7H+f3S0SVjiYMPvrbeLnLHU6kup?=
 =?us-ascii?Q?PW1rhZegBmXvKYQBJaAxeqvTun3ArMvCcylMJLqETSQHqzQkP8K/w799InQ7?=
 =?us-ascii?Q?hBVRQil8RDL4/2sdlHKnsUFs8dtZIQBSWg0N27oyVzkFnOcMpUFiw9NXWJVQ?=
 =?us-ascii?Q?hi7IaOxznNsKrbsanx0Y3d2FE6uDVratXu04gyEQ7n0v0tZbMQEoic+Qvsfa?=
 =?us-ascii?Q?Lz/AgR9R1Hul7SYgwK5ZMg92tPIq0+AMpbRObcBjaWrtaAZ6k92Vk22pvdT+?=
 =?us-ascii?Q?Ze5N/sI7RwycvJiVZ/4mpnHQ9J6KlLQD+eD/mewfaDPnmdccKi67El0PbBOe?=
 =?us-ascii?Q?W0XQ6jJvfF0nTqp8Sp1zPi+/7iTSJ5N8xMMYmoTpw28CehCwgsUpgC4WJia9?=
 =?us-ascii?Q?75UNOKiqnoIP1ozlSWYhnfBmysxO8s2E8h/n8/O97m1aTlbWKY9XjCz9NXp9?=
 =?us-ascii?Q?5ihSZpx7lesRWwipzr7ycz8LCHgqYvDOfpve5UwXqcwZ/tkMBoMTwLtX0SGB?=
 =?us-ascii?Q?yMrkWKB7GyJ26H+jggttwaxnhHbWaD21q+pql9d8ywVM7rw78OoNNTXvdVI5?=
 =?us-ascii?Q?LSooF8Yka4a9f3teHUDnxZXp9B2Twxweiosp9nBDscP4+T5bBIZCnEw6VY7M?=
 =?us-ascii?Q?uXQJDT4COEt96T6/mU88EvyajH8+sisYEH0XR59CKTHOf4eCPpgZooaNbm8m?=
 =?us-ascii?Q?Ver8HeGUwzOy7+6hG755sKbTK5j94ZVyYm9kKyuTsb2Y8DYoQs/klfdABBTE?=
 =?us-ascii?Q?PQEo0Xd3TKdNeAFrxDU3P4nHFmQkVM7efiZjsDlKbwv+3eIGxgMeHXnlE0gX?=
 =?us-ascii?Q?eYUqNnPCljcSTEYpm5IcOWoxT2AE8dDpgYnLp4MmNrbNsUyrs2JLE5wewB7G?=
 =?us-ascii?Q?GaejKZ2EHyNZeQeV7l0ZWGDgIbzejdtdmCQ4JVpx6Fd1Xg47j2jFHWCgToLe?=
 =?us-ascii?Q?ZYpXBhpU5vhbnQ9fUZdi96nM1crNrWCfPaFFc5mcpErkfkFfEP9v3Yy+cfoF?=
 =?us-ascii?Q?r4ji4DI0nCksV+HFyeMjShyv5+qptxpN3mypG707A0o1/NMiq2kYPyvPQxWj?=
 =?us-ascii?Q?1JPBgdfJZb73V9p61M5QwcgL8Ty89hg+bzCpgPXJAq5G+ubt7tPre7KwB3po?=
 =?us-ascii?Q?PaJUQtsUX0R0mPv/AFqh6vaFOpzorFNvYVFxh2EzdLNERp66y4Ip3WV0poKL?=
 =?us-ascii?Q?JWyDluBr+noP1SwZk5y9lkMa7p3RbRhZpn0TTk0+2ipyD9zsGJJrxZEhUMJB?=
 =?us-ascii?Q?iqYrXR6Pqwn0YW1nqDU+Qbg/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9db70bf-39cc-4a5b-c5ab-08d8ed587612
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 17:32:26.9820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwTi2bdAhxrWPmzTy1HMNyM/bRtL2L1hXUbZB54YiFtxTELiXNVejbBIx3DFhbi/CaeogNIxDB7rRm4jUOnFrT+vmwXlH7IWPEfYr1G/CaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4451
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220127
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220127
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


*** BLURB HERE ***

Mihai Carabas (3):
  misc/pvpanic: split-up generic and platform dependent code
  misc/pvpanic: probe multiple instances
  misc/pvpanic: add PCI driver

 .../ABI/testing/sysfs-bus-pci-devices-pvpanic      |   4 +-
 drivers/misc/Kconfig                               |   9 +-
 drivers/misc/Makefile                              |   2 +-
 drivers/misc/pvpanic.c                             | 160 ---------------------
 drivers/misc/pvpanic/Kconfig                       |  27 ++++
 drivers/misc/pvpanic/Makefile                      |   8 ++
 drivers/misc/pvpanic/pvpanic-mmio.c                | 143 ++++++++++++++++++
 drivers/misc/pvpanic/pvpanic-pci.c                 | 121 ++++++++++++++++
 drivers/misc/pvpanic/pvpanic.c                     | 109 ++++++++++++++
 drivers/misc/pvpanic/pvpanic.h                     |  21 +++
 10 files changed, 434 insertions(+), 170 deletions(-)
 delete mode 100644 drivers/misc/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 create mode 100644 drivers/misc/pvpanic/pvpanic-mmio.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

-- 
1.8.3.1

