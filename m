Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D773431A5F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhBLUVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:21:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41974 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhBLUU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:20:58 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CKJEBL111693;
        Fri, 12 Feb 2021 20:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=k9uVOgOe1l7jrjKdxBLoq/u4Qtng8iJ4lonfxuhXtzc=;
 b=fXnYfi8FOb0JWPwm0GTyO5RYBa1il5KFBL0mcfOTXsRlmlv7PMTrSFxhHTfd5J2a9hk3
 8HrpRZeqq4cgVIn9ZFGhqd/NIecI3XsMoeEkyMYsB7wHsOvl5e2FnGQmkQjEhAmldxHI
 jx8hKQ7f0NSlp7QEdmznzmzZDjfQkvcwRuBPH6F9QYFlJBlNK2vWKvReESeMjWMv9tuo
 ZTG0ALb2r073K9iZfqr8mLg/0qV9g3RmZ4u95lcFYGQby9cR4f799FXUkUzd9JR3KvB0
 2rxfo36pfkXtmPZC6ATrsR8aLo3AlLjoGkpTlrTUh7HdgZbrLm0LmEo38LAKhuuMERQX IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36mv9dxqfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 20:20:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CKGoaw175506;
        Fri, 12 Feb 2021 20:20:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 36j4vw5k9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 20:20:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBpWyjsxseFvshVSNzDKjVvGXfZ+yxyjo1xUgarQkWK49d7tw5FHNJOIZwBtSI76FzOt/iezRutXTr8tGBDC176yR0exOu0EWke8L8OmmZENwkpG4BPdo4kucN2V1EEoUL53TEl9IiyWzDLUwZ77i7esd3IdXpjkuIGwgYqBXYYm/Ifo57hBm4KOTFMaKdvT1k8wstdNCGdka3+Kf+ivEcLoJkJMJQ5v66iJFMaWMDIyqHKRRkGwGgjX31G4UKwzGpQW/zKE4Hb4a1H/TJc8+NDUVx80D2GcO/dWybgBSafooY5kqo575Chf3bi4kAN/Eu9oqqW7hKh6XjzKmSXiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9uVOgOe1l7jrjKdxBLoq/u4Qtng8iJ4lonfxuhXtzc=;
 b=iB2LYLEvh/XyBrOSjJZg0bNgpAlRkTra7VJuY1LXbxm8fGvgiVWLY+XsKzHsiK6abD2jPa9bR9erB8bCnFEnIGkWWdtmkIPysEUyX5/k7wpoLPFru1H+q3uLgh6FDr1T9LiWFc/akX6M7nJ5uHhP9OZ52tPEFHcUAy3mhDmpu+9JTSsQdHYYSvfKpYITQfMWxUk+HGgMKDQ0+cbLDUJJxE0yyHyRX7qPGn7iP2c/hCBxW/ZZRc4Ts8N73HVSwpfqopU6SFXVQLiPpfvuchYSKqc/La2eUU08n2hm1YuNC6r/o/YEb2VmQjumcKqmPTAR1Rdt9Ys3Gu8D/PmImf1+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9uVOgOe1l7jrjKdxBLoq/u4Qtng8iJ4lonfxuhXtzc=;
 b=RR6DIHccnCA4ccEWMAjmLPhrStQzO4ypsWSoyAd0dCq6+i/m7JiuRgUVM3C/YEcxcQaxtfONsZ1qz69brNDYZOfODV9RAqWq0UWPnHDu9KeZIoz5QAKf0Se1hd/zva5ClaVEghp424WOQZPml9OXctZ9zC/UevmH98zK7GMEWqs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2176.namprd10.prod.outlook.com
 (2603:10b6:301:30::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Fri, 12 Feb
 2021 20:19:58 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3742.015; Fri, 12 Feb 2021
 20:19:58 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v3] add support for pci in the pvpanic driver
Date:   Fri, 12 Feb 2021 21:32:25 +0200
Message-Id: <1613158348-19976-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: SJ0PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::31) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.14 via Frontend Transport; Fri, 12 Feb 2021 20:19:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92dbc3d1-61f2-4656-a26f-08d8cf939150
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2176C97D03C991D9AB822B13888B9@MWHPR1001MB2176.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eNVcEJx88Gi3QVXV/px63x6zUf7vaL+P32zOYZGaOhQj3Te5TJdMr0kN07ac/fTNM79ZeDVxdJSBI7mTQQQoVNQrzMSua8RlkooStms6K5RAKwSu76ikuhXDO1M3puxK555YusejE2WbaYbmiEooVYwTDsa9avuMDsrQcVhFXvccfdxFozgkp/8lm9P+KUiDprxCdxzeXYeCv+dp9wzrqyJcSrhBL6N+ph4RUKEAvYUgpojCNvQGH3WpH0WJLvNWbKVlugw2FWGmCFctni2dUoG+1iGwpl3mY4pPceFdxPU4lttz6jC4+4DVC+hICD2GSHxOxbZiDtcEEYma0hPZVL7Xor7ekJKvOr5Cd0OY2q5SrsRZfJgskqerKU4q2rggJbK05N5+cCbjrIH1j5fBYtRPPdSLbEta0L0ljJ9Qt1KAPLMxCLpNJ9GIGqLaoh1aaLRTP7fVOOUqw8AzVnNGOOZovrPTgT0cjFJUxzAB3jHToLbGrV0qKxcHkOIFLTbfCz98jTI7TjWDYLcHBiah0d4FblpcMEzORaLHh7qOrOAwUWr78CS11yHIYD3wwMLpSt5lZ9Ieq9aICkTGBI/3b6Iffgo13Sxo7XpIwk4dAdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(136003)(376002)(6486002)(6512007)(26005)(316002)(956004)(44832011)(2616005)(966005)(16526019)(8936002)(186003)(6506007)(86362001)(6666004)(8676002)(6916009)(107886003)(2906002)(66476007)(83380400001)(66556008)(36756003)(52116002)(66946007)(478600001)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0ArxJgd/eJyuz/X9zjKXnnKfiKHXlL588HB+1XWbQZyT+W6ffe7nD6ehiEc1?=
 =?us-ascii?Q?9nwa8j3Vsp4jIB0xF6q8E6SerQ5oTNP0le5Iy/PNKnaa5MM4jtolTimtPlME?=
 =?us-ascii?Q?iPXqCrHSA/9sVflnu/DoY9S+gnlP2eraGKQVMth2kQlXR0Ib/ZkK5mFyVxKi?=
 =?us-ascii?Q?52XkPcZSVsPBnJ7Z1YFT16z7z/c2CUE7O2XfWzkfR1yYwjv5jti8R0P+aaUT?=
 =?us-ascii?Q?+1gHF3g+60Ko3n1fbt5wk1a5Qxx2bVvgEr7ruwghUuyRcgSjc+SEIkuHNO9t?=
 =?us-ascii?Q?sN621OvXnRNP7YbroyzhSIseVB6e6oIM1GKsNfDUljp/b0p1WuJIVOKJNJlk?=
 =?us-ascii?Q?9Ky8q9j2ohQjM3vi/9hU26rndOp0KXrjRzZht9p3RSbLBdlp4Zxwaqdk8nHS?=
 =?us-ascii?Q?wU/kJjVGwZDEgAtZ38cjAXxV0BoiJOjrdBy2VRgvZm9Hrh/IFGJxD17D2W4K?=
 =?us-ascii?Q?FY0ESuCf3PCJTMSm8u2ZA8WSzIsTUaSjSujoDcWIg+6h+ITVsNNOIaCzQG4a?=
 =?us-ascii?Q?/l5KQUnNsPNZxwiIqyC/iEQHK0hIXkn2fzLjCjkdGhvU2v4EVO6SoETuXs1K?=
 =?us-ascii?Q?EYiwR5lYTy/leV8494vn1xj2HxRtTmXU4cHtENvc0Fn82Y0R3q7LXut+Gnhv?=
 =?us-ascii?Q?9oYkkjNPMSU2S3QML6XSdQ4q44oyDekH4VW9RTSfuscYaas2+yhNFlak7Ry8?=
 =?us-ascii?Q?8FqiYcJa35uh7g2fq2LWX7DUyBiG0BeODo4cYVpwt8QbUC0Swy3Yz/WB9Fun?=
 =?us-ascii?Q?H+YA/pVpXukdr1ZnCcPAxz3h/mrxl30xcPV0ueAoWv4mtp4rNFkkA41+0Ohf?=
 =?us-ascii?Q?9Pzu/C3Ken3ObNH06LQdIQw5lBSMCP/b7MlTlzsZeqCqBhtD5wOhtwa7wdww?=
 =?us-ascii?Q?btqtes13/PuyOUaj17noXe6vJTfCCTg4p9ETvMo53U9gpu+T2AFz5Vtf1e16?=
 =?us-ascii?Q?zJxsltv3XgmAwWUv0vJkwFZrV0Xb49JqFOk/fsMflSaMt5RVYu9Fv9XN9DCo?=
 =?us-ascii?Q?m1WpVXIruIGXnWpuCEWNC6KmKb3/0KmudoZYKVhvvSGidTeGOHjIp0Y/TCHJ?=
 =?us-ascii?Q?yyuZ20b09U4gOvJk+mMCi/N6EaWFJ4f3BGIPdW0TQ8BlhOf14a8w9m6YZpkQ?=
 =?us-ascii?Q?xVJ+nvR/CbuRQcqr6sTLJPPxglN+oD00GdXNE0e3FzpTfcS6zpas9OtzjUr6?=
 =?us-ascii?Q?VszVgIJGojV3AhWiZDmelotLbuiw5dXp596oIQC2hCt8eVbDYA/Jpgjpd5rn?=
 =?us-ascii?Q?XXs/cqgY3IH1mLE7zTtT9TENa4XdbIneClukmZQX3NcGnsTLhgzcQ3UcfSjO?=
 =?us-ascii?Q?szODs+fLW3/eqSfiM0VNlvbA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dbc3d1-61f2-4656-a26f-08d8cf939150
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 20:19:58.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w05elt1ENO47IoKFoqONUKO1i2wNgUpjs3u3bIHiOvprQmEU0m4V1GJ+VNr/yN8k/AAnLtQGXpQLduZsYEof/ioRYOE0QOMgMujoW2L9WY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2176
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120150
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120151
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

 drivers/misc/Kconfig                |   9 +--
 drivers/misc/Makefile               |   2 +-
 drivers/misc/pvpanic.c              | 111 ---------------------------------
 drivers/misc/pvpanic/Kconfig        |  25 ++++++++
 drivers/misc/pvpanic/Makefile       |   9 +++
 drivers/misc/pvpanic/pvpanic-mmio.c |  82 ++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic-pci.c  |  54 ++++++++++++++++
 drivers/misc/pvpanic/pvpanic.c      | 120 ++++++++++++++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h      |  16 +++++
 9 files changed, 308 insertions(+), 120 deletions(-)
 delete mode 100644 drivers/misc/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 create mode 100644 drivers/misc/pvpanic/pvpanic-mmio.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

-- 
1.8.3.1

