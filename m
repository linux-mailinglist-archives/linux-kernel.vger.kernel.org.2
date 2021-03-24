Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0E347CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbhCXPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:38:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55396 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbhCXPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:37:41 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OFYGR3030406;
        Wed, 24 Mar 2021 15:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=iGAOF0rpNAjTdcSSkvf4Epjx63buXRTPxDHAX6zRk7U=;
 b=jVXXIx7pX5r+JPN2v13ee/7sjMx0dJhkd1KPIWrPIu05QyIySFAjdxfN9Fafj/raKJ+u
 u8wYKC1vBrWQlwcWX1DuTJc/GyTky5akgg4SYojHp1gvgQiX1DnLnhjZUXjyXihkj2dG
 /ubEQPpqP1us2fX+gVV688nJyLnjhYfqw7ktEJlMIT4NxPpHMXhYTat1XmwYPtxGcXRa
 ijc+i8fSSlfUAASEjbEI4tkAkA+Kfssbg1g0HGroExCbikEXXCwpMGJGwy215CdzvUYY
 viJ5Dia8RkMo6SISL53J1C0kI3GjKB7DRiJAREnAWTWBuBI9steQggcSWWXKXV0dB6mW LA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37d6jbkan0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 15:37:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OFZGtn157900;
        Wed, 24 Mar 2021 15:37:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 37dtmqyg00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 15:37:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6qLK/YYC9YjMoeUJkeLFLsWROIGdBAbnW/8DI6LsZo3H43I1FLYBXny3IwVZmCicH72mbIEA1ynFIucF7xG1qAPE1u+vXysGC4CGStgi2hFV1mJRgQ1+b98EzTKE7LmcwA9LFTuJAhtSfQRhLRBl3+hRgNS3wpJ+qWA9ZTtDyXeXTs5RA1jjAOF/bxKYMdXELZd27ZxATpSMxheZzD4ZYSOPqKdEsAPQCX9BUsq+ufTG2fGgPj3rJaYigG1/s+k0RnXTfXNVnRFUXkkaZOuxPTJ9CJuG9fNp8n1CIeBwzuXg+CpuZ/qrpljkf/EazINzvsy1gOUvNo5cclIRyui8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGAOF0rpNAjTdcSSkvf4Epjx63buXRTPxDHAX6zRk7U=;
 b=NLz6ayIoT0PR/Auv+A4p5PpCk3ayeL2viz98i3tk82VICZ5Wxs82BGqBGHSCp8JUdjfn5N4OB+y0mgZwpmlyr/2V6RTugeZ1fpiczqwJ0yY6eYqwHBbognq0sq+njUJEXkITFaMkjM0mqji06ZhToboxfgRtoGSx4yJhfg4/ag96bJNdtCp9oxfif3i4Xe4HjQOSLeyrpVBEzMzLFXKpsV+ITiYISwhkunhWwVZuvv7gKAINLK1fiEcjrtiAt+OHIleS3NDUcZxSFgPJO1utg4PW8y+Gf5DpMBLfXxg8EqtSZWhEeUlbV8WFZTFbyBe9dbuJbqBgK1W/KgNSErZl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGAOF0rpNAjTdcSSkvf4Epjx63buXRTPxDHAX6zRk7U=;
 b=xOtII9gyneF2y7qDK49v0d74eTGGCcG6El8zWe/GfUDSXpAEwIII21Td71qAtBCSzfbmZFpSyy3BBiwtL1qRz7DllqVJCpzitHOmpv7YC+PNktz0kESvFKiWgmAoAFHF69PMhEjFcFm2ilwMVNq7nVCxkzXUUlR06qxYAM7jo9w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4465.namprd10.prod.outlook.com
 (2603:10b6:303:6d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Wed, 24 Mar
 2021 15:37:22 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.033; Wed, 24 Mar 2021
 15:37:22 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v8] add support for pci in the pvpanic driver
Date:   Wed, 24 Mar 2021 16:49:13 +0200
Message-Id: <1616597356-20696-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.201.25]
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.201.25) by SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Wed, 24 Mar 2021 15:37:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f104020-0040-4336-5977-08d8eedab747
X-MS-TrafficTypeDiagnostic: CO1PR10MB4465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44652118EFA0F752018DDE2C88639@CO1PR10MB4465.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwtD5xdNu3iU7tDooDLx6nyTco0Gukw1Cf+iGJXyEED6MkJo0whDvnJ2pg2B1tUCmiMX2gzLkBtsSgJzsze90sY50jMwr1kslj0+Bx0Wp0yxZibTTSKyO+3e6FOF5wuU9zZJUDrKFGJmaW9tgJdXFt0R/rZwYyiw8NBL4GdAlcQHoVIZZCp6an3HcJJnvPqhgA+tCV/f/aWRS6n/ny3ZFpSZ1BTtoJVuCRbYPR3HhxXlWOcrXAZ15cklwxz4bFuGugQDaGijsEOiBDq5Me0GdjVQ7y9H7MxbBim3pxkJzDpY4cEVnh14L/i0LzGEL3F+wc8WnXZVf4RhSOeuXjqEU/4K7TSvzFZu9/o+7xAruq9KJ8RNWCKdSQ1YNG8FoZgXeV7rIxLl1zw9AWzGgLoNrE5GDhSNRdzm6M6eDzCozEv4wPiQ5lL50q/1+2A0xuqAIzhjF8lApXmF+nkuqWuFkPrJ9fpDV9zLfIs4erVJ49iwQGhHDtS/OgLlH0pBv81JzvpiBGAjzEAu/gcvcLbDIf9XVqF0MdgxFxx3kEdT/5614MYy/CvBGgpmufdzqQQsqUjK8awdvFFVdCqVi+oXVD5mIdDTOoXfxXQTeeZEYmUM0Z1UxHV6Z/Fj0b9iu+ipxlRVcH36m+YO48Cfhvi2+BlCrGsN0lDG9WzO7h1mWRnHLSOh91O6d4dWxSsgEq3dhZpoNorxDiALugQxm5soORE3kkzN2hQ4KVvmkHTnGvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(346002)(39860400002)(44832011)(6666004)(6916009)(107886003)(6506007)(66556008)(66476007)(66946007)(2616005)(36756003)(2906002)(83380400001)(8676002)(966005)(956004)(478600001)(6486002)(4326008)(8936002)(26005)(6512007)(86362001)(5660300002)(52116002)(38100700001)(16526019)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?INZprjOBC8/6tVSqWZojG8iNcWrtmcjUkscoRHYkaWtxEh79RsRHS7DFJXNV?=
 =?us-ascii?Q?2leAficoxQYnCV7xs+aYjndnFzqW6vxaoq/dgqBsNbT2W3UxSGa1f9LAdilS?=
 =?us-ascii?Q?3folgwPQIjYgJqFfJV/0ucm62Ft46VhbzUd9krG1pLslgd/DckGux3CoGGku?=
 =?us-ascii?Q?kPa2ndKowwJ3XLLHGLrxFfaNR4uNkqL8F3fH4mmaHLN5q6/zohf09J7rFQd3?=
 =?us-ascii?Q?Xx5h/KVVq1b8odcTKI50aFft/2GZt2ezQfTfcOFBikX8y0T7B8mFDe1roxIJ?=
 =?us-ascii?Q?Tdr7K9wdZ5AGQnIA9ref0r1nyUXWLcYqrjfHJPWaxelBpIMg70yhAJlt2GmO?=
 =?us-ascii?Q?PdtliinwUlj+nf2xaAwknYpZBClsVSWDXu1gv2o/0dFuCJSEsPmU7ve95kDc?=
 =?us-ascii?Q?zQdzm/qSwCKa+7hTF2VGC6Uag6mCkTGopUidmsRB08DzB/VksHES8AfkQY4N?=
 =?us-ascii?Q?5B2zcib13+DLSsSq4CC7rN2xSZGNjVn0myi1AQDqmaF+Ic1W+Q+Tw76CWwB9?=
 =?us-ascii?Q?E0s3Ygfr9p+/OAt1m9eiBnELxkG/wglHXJMalvERj3aleMs3ILxA10Ss9Moz?=
 =?us-ascii?Q?cP/fptTHD6zOUIPueUkYIfy4cRW44oOtIOCWYS9swqzxeTPqgAEgrSDwUC8u?=
 =?us-ascii?Q?CrqnKduJZrHwkto1P4DCDOyEOqBu6DWXhWYtUv7fPNPyOjVen/wI7OCOesKr?=
 =?us-ascii?Q?684GMP1JZlo+xRtfMoywpvAZICK9ovPx68GZ1rT9a+2H31/aKCX+96rYRbIt?=
 =?us-ascii?Q?WNgb5dUb2LBh8TAoToHyf5kQFNIcBDY6FnMifScaqwTmFXW7eXpe8v59goRS?=
 =?us-ascii?Q?dUKWF2QuyfH2ScZ8ovUDvwCL6IBAfSbPombzPDaE/PM7jhA4SoP2BI6ef8Pv?=
 =?us-ascii?Q?6tX7q4iyzsiqklRLmylnKt8NgQCKuvNpptPAvFnBRzuKfrBGcOYEcmS0zJhY?=
 =?us-ascii?Q?pMGVuNVkkseGWjMQfn/CGxRZMZ30/ZZ3NtezDlohu+rHArMDxZPebZtCuTiw?=
 =?us-ascii?Q?Faj5ivTbQG+Je9Zz8sRRuO7aqtxuIRK0SOtJwHCJDqze09fWyJijHerJ7hft?=
 =?us-ascii?Q?9+5Dzt/Y3CI92WpyCWRh5bjefdf4ZJIOYaPOXAkUYsk4Xlk5HRgmRnAyT33C?=
 =?us-ascii?Q?rPk/8Iv9PcDIp9/LAh/DOrKHiq4XzzHfNvd/4iyjB6C73UGpxmE6oomO9Xqi?=
 =?us-ascii?Q?Qv5TrzcoPLcjX+spDP2IN4kn4IBscBx4bqxOp1+Qw3G9X+sC9L3popj1dvAN?=
 =?us-ascii?Q?/VgOTtVKA9oABKn+VHP2LKFTZPLs+nXonK0NqhS8xd0fYE3+VkvhrmKFh4lY?=
 =?us-ascii?Q?gM4CyYU/O7nTM3b/r9+xoO7d?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f104020-0040-4336-5977-08d8eedab747
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 15:37:22.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHlwbgtMyDKURd0FKYsBaT1Z4fW3T/COtvVZYuleN2LdtEPOoRdQOSSQpg2v21rlyDRciCAb39wTyZ7y6NAktCm8XOPt1l0Sfk5jiISq22Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4465
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240116
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

v8:
- fixed build error while compiling only the first patch (accept
  my apologizes Greg)
- build and tested pvpanic functionality after each applied patch

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
 drivers/misc/pvpanic/pvpanic-pci.c                 | 125 ++++++++++++++++
 drivers/misc/pvpanic/pvpanic.c                     | 113 +++++++++++++++
 drivers/misc/pvpanic/pvpanic.h                     |  21 +++
 10 files changed, 443 insertions(+), 171 deletions(-)
 delete mode 100644 drivers/misc/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 create mode 100644 drivers/misc/pvpanic/pvpanic-mmio.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

-- 
1.8.3.1

