Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C05441586B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbhIWGsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:48:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:38126 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237097AbhIWGsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:48:09 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MJpfT8005849;
        Wed, 22 Sep 2021 23:46:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=RPoL9dDWpdmj3UEL9LPpwNY27ZRyzolQFJJVB3RZPyA=;
 b=n4cOdEvIo9bkaswUlZKf7lROe+TGymTLgFhl7BkL49BApnhEdejBjfG4CbZke/Z5Q5Ed
 chsg/IW9vK0R4Uh2OcrozqY0K1U1l1JCzld19sirwNTwFtrojhGABrFk/rhW1jPQLmvS
 1E0iqfyD5oWBwqW9ORr9Gy3WDPFk7H0OnQPTtYszJk5XgLddyJaT6yOkgQj0z/7m+X0Z
 ZMuzm6s7qs/dANEez2qbptmKCe9RnGYTYUkCSdqW7pRc8rmalpNMoBbQxEjYymtHQDRw
 7p9WTLA+sIykBIQtYGml4yQ+67Eca+c8CIXox/dq45JLVrwF3IFoVIeX0vLUEjSpfmZ/ qg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0b-002c1b01.pphosted.com with ESMTP id 3b8b1290g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 23:46:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPSFtWIM63pkXA9siv6Zjc6NuU8XhrJ0NJs8hD1caKXMiUkFRlcyPzJ8AgaL9/XhTwRnGe+CfepvcSX6M2cF4ExSeOM/8W38cPOEkuIOdlpPSWOmXyHJSK5yywvneEz9SyvUU030LWbEyL827MNUYnA4JNypg3T4LXHMHhQWXLwfWBlKgerLGtkXOoWtdDWBeogP4nBgBLKymS7G7K8jjZ/CJK/v7emADDsZKb55gc5jTSZglBWzfirEg40t58TkIQYsBqdGFRizifHgzazXpCQcfSVCG7dS0nAkvTpl0adp/iNb3oT8DVjRPCPYFPVccIW7IGmwobGtoAXDxSVR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RPoL9dDWpdmj3UEL9LPpwNY27ZRyzolQFJJVB3RZPyA=;
 b=kX2+WbAxHK1DDTlWemPk00XMQrCdluSwpjeJroSVe6yRGUO2BASN5wdD7mJu2Tij00bcPpUZ4/wovkOBREz0XgJqK+xgCAtkW86wWRT+otWPMiG0qmnkKqfTJIPuBKxfSrT9pLFUwVCYA1GsTtW80PVK9IQpHZLDutsD4OD49HhvGE7/T8pn4kvuTogQMgNYsANnLmg4J2IQ/HyDNI2LeJpRYOCnbjpcht2YSUb0o1SbV5owaMsqGgF3qGZkVfMjRFxQAdUTB6R4fFs9G0enMYwC1nrBB3jZT8eLBN6RmminpS7KVGidlbBtCfp/2P0QGnTCQCutLtyyzVLn+2XGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nutanix.com;
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM6PR02MB4924.namprd02.prod.outlook.com (2603:10b6:5:11::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Thu, 23 Sep 2021 06:46:33 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e%7]) with mapi id 15.20.4523.019; Thu, 23 Sep 2021
 06:46:32 +0000
From:   Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
To:     akpm@linux-foundation.org, corbet@lwn.net, peterx@redhat.com,
        david@redhat.com, linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     ivan.teterevkov@nutanix.com, florian.schmidt@nutanix.com,
        carl.waldspurger@nutanix.com, jonathan.davies@nutanix.com,
        chris.riches@nutanix.com,
        Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Subject: [PATCH v3 1/1] Documentation: update pagemap with shmem exceptions
Date:   Thu, 23 Sep 2021 06:46:18 +0000
Message-Id: <20210923064618.157046-2-tiberiu.georgescu@nutanix.com>
X-Mailer: git-send-email 2.33.0.363.g4c719308ce
In-Reply-To: <20210923064618.157046-1-tiberiu.georgescu@nutanix.com>
References: <20210923064618.157046-1-tiberiu.georgescu@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::40) To DM6PR02MB5578.namprd02.prod.outlook.com
 (2603:10b6:5:79::13)
MIME-Version: 1.0
Received: from tiberiu-georgescu.ubvm.nutanix.com (192.146.154.243) by BY5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:1d0::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 06:46:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac50f82f-fddb-45ab-4718-08d97e5de0e6
X-MS-TrafficTypeDiagnostic: DM6PR02MB4924:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR02MB4924A998682F5A5A3ECEABF3E6A39@DM6PR02MB4924.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 617iAT4OBUaUd4YE320R6KFc/Pd+MIxDz8Xt6W3TarnB09b0plcg4exeeFuzDi/B0cwKG0awiJy0kdQwZ6DmPaE37SI8jKdi9kD3PklxIvkox1WiWonoLz+ud3B6HWoZRWZpCtPrbzd97U/ecWiFlr+SRgS2m6DXrRNizynEo0pqe4DkvzX9SDwjXy34CzJZBWblfC6OgFHpxS/yal8WmMZGrbrqKcTEVwcXixdk3p8ZbdltCOl8/QI+Ot0yKH7yVAvXh4XN+qIvu63nb3d25YpaQmuDqqAASjC1x9ApgBmRJ91PSLaMqGyhNR70R5cjZyiz5yS2+3wANKuToYlA+W12grDTlTXyD+DHaqkIF3GfGywu8a57nsnVRyehqaxlbRcAUG3wpa/CiWz26MV15MaU7FIBKzi3daQ2o2kI5NiEPvT8RlwzUPwQpIC356lzFlEmVdHVOlIN6mkmB/sW6tLN3xuQmRHnn2mX+V26BPNzk3kCfdg75eHkxeSd9G/8u+QPmtJTPutAXdzyNRAZOvWOGJhtSh5NVAI/5GVekfuxLEO9l4SMrd3ukatgbiq0Pg9YMCCLWllsaGDaYo6X/IzwudLGWRX7fBTQTlFtV0nhmy7fREYfFbgpD3rN83p4Bp4PtNdwEIczTmu/IRDOz+8KfOBsBXcokL9cHbWPyZ0NeDcSFH9s9kzsE1K4F75Akni0bPYzjyIgmlBMUHU4xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(52116002)(4326008)(8676002)(38100700002)(186003)(6486002)(956004)(5660300002)(26005)(6666004)(36756003)(107886003)(66946007)(66476007)(83380400001)(86362001)(1076003)(316002)(2906002)(508600001)(8936002)(38350700002)(66556008)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iCTGBAWgbYH1tN675kor0ASoOt190EztscaZnDcjZMvgVMY9n6oNJ5wETkdD?=
 =?us-ascii?Q?/gu9Wu54Rl+4LOq4jbtVJzwHMzF9/21JM0cS4Z1/eQfc8Lh5KrcmI1T4/l4H?=
 =?us-ascii?Q?5O8WyQZWXzKZ90i5fRtXXlAKHz1ej8cBSCTAYlpACzH2eXBr94KwJ7fd/O/i?=
 =?us-ascii?Q?a8lRJTTgOTlKDedCglYQL8fyAWXiha4aUFy7i8wbuE3Vn/e6iFNM9gF9s6+m?=
 =?us-ascii?Q?Zo338yeXah6BfijlWkkUJrtuED6iW4X6/u42v4reSxqiB0yoC0BZJ4/WYtZv?=
 =?us-ascii?Q?MvNtTuozFQoonE4kRYhwwdCB3QVUgWoVPxZBXrQ/k8H1xWcjsrI5wKQb2Cgx?=
 =?us-ascii?Q?fDXPzmSmQXzKOYytVkrU6gM0PCqjS4Wlza7ZdK7cDmT2FKYXyBAk+L5l17CW?=
 =?us-ascii?Q?qfUqqea2iNVQCdInz/9XcUeKj8HTfu9AGBJEd5z3SII+63V9B+mfe2C5MVjG?=
 =?us-ascii?Q?O602xzWwjybAikHal5LNxc3vdBWq/1eLx6GJ3aVnXR1ad+4WMlh2rbHWX7En?=
 =?us-ascii?Q?11oUGREht47r8Pe2frot1XTyDKPjuHI0l67jW2yc0a3HdASEc3i4FycsEW9N?=
 =?us-ascii?Q?BsvCNrDUL4+MKill8iJXZ2Ux4adIKOsqfW5RERS77oopZMhnD0xmb1+eVviK?=
 =?us-ascii?Q?awncIl2bNr7masq5LrwmSB1W7dlhWZ9oJP6K4txms+X56awoGDI8p8NemZNC?=
 =?us-ascii?Q?yVuDjrM925CUv4Ut9KBJ+lO3XugLH7Oke4eqNxFYl3oPNN5MsOUgj4nYp51o?=
 =?us-ascii?Q?jxPnulHeegxni3+oaxFfgjvl4uPXmOIC9fYVHG4sajOGtK57jY7DKwJZxSTL?=
 =?us-ascii?Q?ZxpwwNoMXXsxsW/k7ct8Hq9EEA7mwEnfutysmxKEzWjXoYMYbdzo/G6ZbCBY?=
 =?us-ascii?Q?mK4EeHGI7+pnjan98TY7rOvvn81N4xY9RgEabKWZ6wHH2GNIaMcu07ba7tpo?=
 =?us-ascii?Q?oZZPSSVrKa6GXQdO32TuD2rFrBGVW8IFfW1pan5N5ukWlB2VB2SN1PKZLq0E?=
 =?us-ascii?Q?DxdbMoDiR70hFMOdV12/BIhxO+r2igpSESqvhuic6JAy+d4j8VKOdlMK2HDX?=
 =?us-ascii?Q?6ZV0dxmk0EqCegEk4e36QMlNvGE2EXGxVMJglvxM4v1SLftSwUfvJQjIqI4D?=
 =?us-ascii?Q?1Biq7FCg2O8HMwrGI0IsCza+RG953+7qZkz+qXjdQT7srjnwsO5TxpxQkGky?=
 =?us-ascii?Q?RJGcjrWjGFfA+xPniUf3ky9YLwtiasnx6Hwmww29v2YhKHh5AJGJpKAnyBCQ?=
 =?us-ascii?Q?h30v4ut3mwYtqfWr0WURm+VX8zYeGr8ihzGXp04cyQks/Mt6G/cAnkD+J3s2?=
 =?us-ascii?Q?rISZBRFQjeK8UVZWni1FJBm6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac50f82f-fddb-45ab-4718-08d97e5de0e6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 06:46:32.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0D+P7sshR839e7Vsz03QDifN604C30DIitkKnj1VP/uwsYdkpYkBgkE1H+19otDExarJpKh2qG5RkzrlTrpTPAqqPgg+bVfN2LJtxEJrbSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4924
X-Proofpoint-GUID: ZGO1YwBE1xMbCW4AJZsGPx_Qhd5vJMNS
X-Proofpoint-ORIG-GUID: ZGO1YwBE1xMbCW4AJZsGPx_Qhd5vJMNS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_02,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mentioning the current missing information in the pagemap and alternatives
on how to retrieve it, in case someone stumbles upon unexpected behaviour.

Signed-off-by: Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Reviewed-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Reviewed-by: Florian Schmidt <florian.schmidt@nutanix.com>
Reviewed-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
Reviewed-by: Jonathan Davies <jonathan.davies@nutanix.com>
---
 Documentation/admin-guide/mm/pagemap.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index fb578fbbb76c..4581527c07ae 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -196,6 +196,28 @@ you can go through every map in the process, find the PFNs, look those up
 in kpagecount, and tally up the number of pages that are only referenced
 once.
 
+Exceptions for Shared Memory
+============================
+
+Page table entries for shared pages are cleared when the pages are zapped or
+swapped out. This makes swapped out pages indistinguishable from never-allocated
+ones.
+
+In kernel space, the swap location can still be retrieved from the page cache.
+However, values stored only on the normal PTE get lost irretrievably when the
+page is swapped out (i.e. SOFT_DIRTY).
+
+In user space, whether the page is present, swapped or none can be deduced with
+the help of lseek and/or mincore system calls.
+
+lseek() can differentiate between accessed pages (present or swapped out) and
+holes (none/non-allocated) by specifying the SEEK_DATA flag on the file where
+the pages are backed. For anonymous shared pages, the file can be found in
+``/proc/pid/map_files/``.
+
+mincore() can differentiate between pages in memory (present, including swap
+cache) and out of memory (swapped out or none/non-allocated).
+
 Other notes
 ===========
 
-- 
2.33.0.363.g4c719308ce

