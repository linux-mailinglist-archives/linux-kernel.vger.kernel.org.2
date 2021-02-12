Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA8B319C56
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhBLKGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:06:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50904 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhBLKFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:05:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11C9nr0A040293;
        Fri, 12 Feb 2021 10:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=pfBzdhFzhIsN5tvsMRhbp2WcygWOPWQHE91s7t4Mg8k=;
 b=Cu9HtJGkcLyMiGAzQIek6lEM/vJFgcJf3mMSVKZLSgOZ+g74E0H66C4Rzh5VBXMWxLaI
 2E7QazpjNJiPuwxxFigYo49zrTdZlF8FuCZ4z3h+rY5f1bHb+Km8j3ftPZuMgiO5YVZW
 0j3UYSXsbcXDz/TMzUr2JIZ7xXVQo5RSXaogvUs3sDMbRmiBK5Iqo7DAcruLsEZDz5qV
 rfvQf+FLJP8BTqlBGX8Xwf0WbH4vqzUdxuk1LZHLUeurj2fkxpTvFrVJ98/LvDPAqVLM
 +cgvatpWoo/k7DGNKhkjq2nVOmGqPaBpeAKFlQ9lYgzshrQyvOdc1hOzyI+wC18n2T4m dA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36hkrnakvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 10:04:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11C9paxi163609;
        Fri, 12 Feb 2021 10:04:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 36j515a2pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 10:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnYyfZMdJZ9GApNBiw6UXI7RNbDC3e2j2uv4TWPdwOEFoioC8CxkMhhL/lPCfHdRXpt2DslikX4iy9Jx26nECA4B+GQG0l5+YDoGbPC107Ioik3dmySpZO5uqAyUz3jiEpZ9gHYGFtJRc5Y82sA+G6X44VnMVJzSGVhSN64o1QP4+9NS+u/ZiFnwHdE5j5vpqPU/vivOP5gPosYLb/mqey1tWzIlIadXqjfsKCRyog2128R4Q1kX4cdNCUpnUK9zY0lVeEAK6/jR3EFVyr2tkx/IsavxCA0NrIQVUFPadoxrEe6wwckaacKxVHhOoINNj8mnSDb3Gb1jTCEd9vGvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfBzdhFzhIsN5tvsMRhbp2WcygWOPWQHE91s7t4Mg8k=;
 b=UDGNttWQR4yi59rq6c3qPxruiH5RxW5TX5qL+E9pNJd7wOVnPaU9WeyY8S3YV7sZLco15qnaFZVrCm7EP+uw2a0rJagXQCVXtO/DcQ09KbZj0lB3RmLkDNxbjNIBFSWPlOiyf5qKqhYK2gtSMfYAzcj28PxtMEXt86KBQtfENDtt5cK++3P38uGAdQifQi6PoLw+euJ9pStrb1diBZjJmGC7BVI9mGvQd0fjxxjtPG7bmmX8mWj35XmSBq1df3P/1yeqXupTJNKP67TbyMFJ9xW85XQamr2hW9PZ/SCQusp09qRLqSisj2Q9sEb9qbDs/WHI/kqNCsniJckeCw3oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfBzdhFzhIsN5tvsMRhbp2WcygWOPWQHE91s7t4Mg8k=;
 b=G7r6X1jFGI669+489FZ1U2xbWNOJjTNqAMLw4eRXwwgu5Iwfmtm9uOlcntG5d0+Vp83MxawDiHhssIwXO5g3wNU5MhejhpPTDTGwm2ia4UHzcbqVceR6rjay6CRDu6cFmQsYogtGaIrhLmqpXofHx9T1FTv2lVDbGtv0bMmpXpw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4611.namprd10.prod.outlook.com
 (2603:10b6:303:92::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 12 Feb
 2021 10:04:45 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3742.015; Fri, 12 Feb 2021
 10:04:44 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v2] add support for pci in the pvpanic driver
Date:   Fri, 12 Feb 2021 11:17:03 +0200
Message-Id: <1613121426-15585-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: BYAPR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:a03:60::26) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by BYAPR07CA0049.namprd07.prod.outlook.com (2603:10b6:a03:60::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Fri, 12 Feb 2021 10:04:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be94e5cb-b09d-47b5-5168-08d8cf3d9f32
X-MS-TrafficTypeDiagnostic: CO1PR10MB4611:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4611AF666B8AD136D8072D5A888B9@CO1PR10MB4611.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWp4mZ1JLnJod8f+EpLOfdQc1JMdkCcR2vDwjf4SbeOTOctIEOeJhQEyVuo0SRBjYDU3QsfCuimBMJcxx3VOTVjMOrrpvEQFGFb9ArsW+BLqVwujZIvD2ZUcjtwBl67RCTuc4JzAjMCr3Vxp0jNTHtf5PLCzuXyyPBs9PI+dALmsjmTbKbRJbsFFiiCbxY8Nij3wmcKFtJKqvOsjEAQJM8gChDcOUNYqcoWkXa+wuYX+uNeUDh2otBZiYoDvPQdLHAoeT1W2/b8K21O3i73USIuV0AscYvxCwNXsS3QQMwqM5FZpCpye0i6be2GFt8Z9atOGXNaEUT/NLb5XH7tsMIHD1IoCZ7LD/Xa/lktZIvGRbufggTjabNuzCJW/XnuyLqkc20ex5+Kc9Tk6V/LlqbgrnrlyczP8/DmBM4LOxpnkF8KjUgE3enczKGaEdnppVj4ly0RCQy+LJZbWNzKh8DmFgQvEhPNLeAzkNAV+OT+Ma4hPkXWRtvisdbB5dCNNXapR6kIEDPvl0gkQfkLH+3r4ANeQPjPQRGj2WPu8qMjpMliarBkzII8PrCZL8xWh04Nf8FoOuxl2suYRWb7EogpU/rlTeEZp3guM25+6BDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(376002)(136003)(366004)(86362001)(66556008)(66946007)(36756003)(66476007)(52116002)(83380400001)(478600001)(956004)(2906002)(966005)(2616005)(186003)(107886003)(26005)(16526019)(44832011)(6512007)(316002)(8676002)(6506007)(6916009)(4326008)(8936002)(6666004)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jU6NWlW/fnzMrd5YJQ1nJBVmsFdDOTgWAlq4hmfgdMpSDtGtSrVZXZAfpDhK?=
 =?us-ascii?Q?ALbSyKHDePkWy9nOOhfedggqRPu51vqpy2MrfnjLfShpUv9AUGPLmwztyLB+?=
 =?us-ascii?Q?XqJPwkgSUaNq6vQvuDcQHutSwqBki269Mf9MkbMDrTbTHIYBnLnO+LxcRQV6?=
 =?us-ascii?Q?KWqOsWeAF3dG2kqJj07wFKjW2iOcvFGWqFizd7xps2EIvGffU05iXeifA7ta?=
 =?us-ascii?Q?4oOcnXrx9PQX72gXiDzopc+8VfH0jKmvfdY1HBdnjrCPbX7jP7mVNitYOe71?=
 =?us-ascii?Q?OxImy0oohfg1x/YBxyCIvwcG4ri58cfkaa5MmyqjFDAfAyb91ZKQbYnPF4Ei?=
 =?us-ascii?Q?3+Uk5c8/nPHwTNAklRl6Ah+o9yHeq8ykU/ODZRkfehaRaQTzioe0ztc/HzdB?=
 =?us-ascii?Q?pfaRZ7JzthrUbwDiEIo3iVXchG4yyrrtQUDoF6HQD6If+efXy5NiK0k4GgCs?=
 =?us-ascii?Q?52+GH0hUPHJhpThWrsHzusx2TgiW+czSXXPqO2yTjCEERAj98buGbbSrdL/Q?=
 =?us-ascii?Q?Lv5eqD1YXOQ8W6fDnHzTp/vTtItmxVDb8SbDWbVQdOmYDtUgVe6xQz5CXUqV?=
 =?us-ascii?Q?Y+TN3fEbcI8fa0mOswvVoR0K3e2q/JWtNWGOtbOyTEylFguaLp89UBlcKMcI?=
 =?us-ascii?Q?xRusOPfSp11PrRk906nnvrdcelEPjjEuI3HxjUdcexcPiPbRprwO1Te0/EqT?=
 =?us-ascii?Q?HM4RuNsM4TIwhWmCKct+U60um8sI8ukZFf5prxBsxgyYfIdiS8+JaMPwqHNJ?=
 =?us-ascii?Q?HHfnMXyT4/RbkoXujHta6TcJ+B/kNZXi1vezftfZBMOy2oqETWUQ2nLF5Z5G?=
 =?us-ascii?Q?LWBT4qMHdNbIU0LNIWm/yUC++K4EP0vzJu5gq9AGNP8Nu8rARjapkXMpx325?=
 =?us-ascii?Q?0T5Yuvd8koR7hOJ3AwDvarAedOrQIksnjsWjZR6fbhPN87GXv0QgBvVIkKR2?=
 =?us-ascii?Q?ExMUb4qgs6uO3i0pwck/mxhIrCXNszg6sx0mFUEOAeuiJ/L0vtWppzqnN9S8?=
 =?us-ascii?Q?W+FBepti0LFjvR+iQZ5p2khP6gtiDOZPZX8RIENiciz7WEOV8yGF3x6318bK?=
 =?us-ascii?Q?UJrqa2VIr7eNZbQ1pjJWWhE4bXi6yRx1adqsyFi59381Al8M0tM4o/eD9581?=
 =?us-ascii?Q?SSuVFW0ABs/CBLVad1D82RsPXwxMXRFKgx1716zrX2TjWyDG+MWalD3/8OeO?=
 =?us-ascii?Q?QLhaXO+SC63Gmo/jfrqGMOAL6+ez916twC3t0cAVaaTsRchv1hZ5PaABQHUB?=
 =?us-ascii?Q?OE2+IdljBZ7u279sY7XE9exedbEkAV9/c4g8oP78DgOHnDTn+ReSD0RAZa74?=
 =?us-ascii?Q?hH/gXW2U7rJUgA0LBUuySQQr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be94e5cb-b09d-47b5-5168-08d8cf3d9f32
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 10:04:44.8392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PqCyJNvAvk9kbRuV5hv2g6fhVpq5ZSdEL/j5TM06F4X0znKvWlFsVZ77HVzF3aQlcNetd6WDBOUtOV9bHJzjjJo63J2TVZyvARXthZARR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4611
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120075
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120075
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
  misc/pvpanic: add PCI driver
  misc/pvpanic: add license

 drivers/misc/Kconfig                  |   9 +--
 drivers/misc/Makefile                 |   2 +-
 drivers/misc/pvpanic.c                | 111 ----------------------------------
 drivers/misc/pvpanic/Kconfig          |  27 +++++++++
 drivers/misc/pvpanic/Makefile         |  11 ++++
 drivers/misc/pvpanic/mmio.c           |  83 +++++++++++++++++++++++++
 drivers/misc/pvpanic/pci.c            |  56 +++++++++++++++++
 drivers/misc/pvpanic/pvpanic-common.c |  60 ++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h        |  17 ++++++
 9 files changed, 256 insertions(+), 120 deletions(-)
 delete mode 100644 drivers/misc/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 create mode 100644 drivers/misc/pvpanic/mmio.c
 create mode 100644 drivers/misc/pvpanic/pci.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-common.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

-- 
1.8.3.1

