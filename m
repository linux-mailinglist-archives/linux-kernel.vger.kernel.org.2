Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AC536DBD3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhD1PhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:37:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32722 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239786AbhD1Pgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:36:54 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKnmD030215;
        Wed, 28 Apr 2021 15:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=J1HoW6hyhv8U3SorWHVtSH8/tWwhrChtZ3HbAW8lASU=;
 b=MY8OSEeHNUj/UZhnVbPnksyPYW8Tfirqjp7RZTapWpzDqYpc7AKYx2HN9nDocmtuXXJy
 dN/ubcjN/oVTH5TmLSNt/TSPWigHIDTPNuRg/HaniV0bdiqmfrz0HSbkyw+exnGiKDyc
 GyYKG2ZM/lm2fhXB+mKdjues+LFuN83DCHeG4OluEmIXVO/+o0w3hzLH7g3qF9lAB0XV
 FLKRpjeFANybGMoJ69xNzJQqY1PGeRhSaTficdsYneuhGPPeU1v+hENtzo5OJHpwTWkR
 4LHg195w88wgw0migcRryfTXL3icae8jbeWn5WXkcPiYkLaoVAn0ks5/Ondyvo36f2GI Tw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh61h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:46 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAN003673;
        Wed, 28 Apr 2021 15:35:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVNIwSQpBWYuhfCcQ12TntJFhFpT4mZyoxJdsmNq6KXUIVR8cdvaKjqgvIusH/LWEdaw0+7U1U/4kNy3U3FzKYZYD27bX2GW3NsX+VcSonB3a8qxfRrLRfdskRIQfYfrvUDi3qVR2p7uppaXdSLSBUQQBW09rtUcBspNBUxN5eJ6zhTCXR9eGFR7O4nHgTHihJE2AWMlUUsAQO4xHfBioXFWMtlz3ZWEDZCZ+WdHacOOEKAw1nRhuE829oSu1H/aluN9Jj4XQ4jPkyecym4Z5K7I8UXydq2om9Zjp/nW0Xl9wCsV61i7JUMLqAaENXiG7ih9BlPJUn8j3+bm7rUOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1HoW6hyhv8U3SorWHVtSH8/tWwhrChtZ3HbAW8lASU=;
 b=DBJbOXDO34qTdwG3D5S9Z8xqjz32uNG3+AR4gqKMBq5S2nCv8GCUURPoF413TRGbFYMnwE2WjtWGoJAwuBxQgWDhCCr+4qri9bP2ODxiYseGrTzvvwk9WPLUJquG/JINES8WWgL0DU1tFA1YcqZ7zGXFUeV6wGKSob/SFqD01GaTa00X3MhbcwmNmU2H0T9sDz6jZwuEKYvqy46FpS8P08LpN5hMIseZ+yrEBweOc8dhh+n1K9L3qQzm+UzHhFYuzh80V5BCMkGsH8xia9jZx110nf/lSJdAEg5beLcJ3EcngMSn6j8NR246R20DYbIz3J34LDpiDtzc+Rdtg6cKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1HoW6hyhv8U3SorWHVtSH8/tWwhrChtZ3HbAW8lASU=;
 b=kCUZBmw/KjaY8/VSItqNZuX9HX3vMYoSVmnXCdrcLAlSijXj2BBmU2VePmxaqW7SUJ2ohSUyfObgr2XqjBYVw7F5Gvd3o1feI46DqmHgnyta/GI5s3Ae4e+Q7mjMKzy0GjSWiKqJCr76phzbFt6ByFwfcHzKRqX+EFw04ryKI7Y=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:43 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 00/94] Introducing the Maple Tree
Thread-Topic: [PATCH 00/94] Introducing the Maple Tree
Thread-Index: AQHXPEQmhSip4cMgQECx5qS45RMOUg==
Date:   Wed, 28 Apr 2021 15:35:43 +0000
Message-ID: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aecc9073-78a3-4782-b8ef-08d90a5b492a
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44975CC1E86172010A88360AFD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xojDspMpJqyVcRz2rddp1x52b1qhiGreIULDqiEnuNn/mmV8XJHvF1V0OhxlwDIiDn922TKYHh00R6VOV/0sUx33UgH3rS07dVUNiNHrlZt4c0l94AQQqHpvr9IetyyDi0kKJ5K7QBhHsI4CH1ZBFYX+r/KPEf7pPj6QfDhl+okfI97AOCP2fRZywyR50wUSPQ14hVmCMtD1523WyjZfJdt0UDWVnVFzHtIKZ20s5FhG51xPHH+wdK9/4OBfSjcxseHDoA+CVDWAbD5qDA02xU8hRy1ogax4FIBF6yfv63Ux0LhsJxQnXSusAUjr6GDyjNMo6SfrzSxxtSjWS3fUSjRNV5NP6SN1Egfm5IDQHTD9dsblBGeXqzW9HgRC7qkLq8GKFFrqPbkKQVdgYiqqxg1UM1nnrR/Tc/5TARoyooOpDiiouPBsF96OTivpGJtPG7G+03aMK4Qn7DJDPuJa7LKu2gSqwmT065VKOtZj52s7K2t/thDScOAqYinZ2a8EVtzG5n0abIZtJvfDZoE1uTyaq4A4PlvbI7nJnwHezpuNsnyDzi5Tzw8np7nyti8w69CnYPOPmtmlYOPEpbyAg5XnzISaDwtyuCLalCAg1FTya4kRDT+nvRvxYwpTeE/H7VELeRyaDRTdwaw0zbWm74lWlQO8N/lj8CkW98HD7AIYzUYnYTQCviBfGlKcrwjC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(5660300002)(6486002)(30864003)(966005)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?r14sUAQIgiWgvAA3JyKVY4tvL/v5SQ6Ort/lfpUR/eweY1dQgDL4ny2ajt?=
 =?iso-8859-1?Q?8KV1/mRR79fXeiXGRgvYMbpN2Dlp2WuY42sipJrooASxTfHqPUESrWupbY?=
 =?iso-8859-1?Q?JqRcurMmrW9OHD17Rbeh8Y8k6UybMkp9saMyOasv6Ri2N5g9CnlKa6S8fy?=
 =?iso-8859-1?Q?j1QnpVqG+Bdhs6m1EqpF6OrXxj1O/PUCHuXuxP7eZXn47QGPeEnfKEPi1q?=
 =?iso-8859-1?Q?UkkKhcRqiSwARXNnEEfUxAaHj/4ld/3zjy46Iusw/g2UMinpyM3Nmy/x2N?=
 =?iso-8859-1?Q?OMCshSFrGRP25u/46Lu+BoUihz9AplYO+e0BkC+RDC4wd0qYzgx8d+iFOQ?=
 =?iso-8859-1?Q?jK633Q9PYZxVo5oegSEqK0Bl8SpKv2yruDnWneddAbE8bBBGq991ex0jrx?=
 =?iso-8859-1?Q?4yZeIMcYF57sgkCE4rrBbZ1Np6+bNKAkc3KOFq7+yKwFuWCVE2nDACDbNi?=
 =?iso-8859-1?Q?3aD+hF2p0uhpPBoagQWyYiRhthLxTJg6RhYmM90ET7NIlkV99QedKZuZom?=
 =?iso-8859-1?Q?j0tqcOC9VJqxOr2K8T1jdfdmidc2DpSgtvQRIZ1qV4oaiG+Y/ivhtPkh2/?=
 =?iso-8859-1?Q?Aoq4UDkcKAwftsHFCenI9jLoBQU2RdCWn/LZY7/KtNaRVR8MigU9mI4OtW?=
 =?iso-8859-1?Q?QclWJDJ84dwjilBhON51Ne4uiwec3qxsz1jGaV0T25k0YW04VcKIf771G4?=
 =?iso-8859-1?Q?9pDoOzrKkt/8JzYReW7WKBixVeZ4zGHfE+0KeK7Lb+krYeP9hse3bpp6m4?=
 =?iso-8859-1?Q?Bl9u18bsZ61/VktvkEBU7NYjIEs4GtqfNcYK2CE7vdKnrk5cwYLqIiHEfZ?=
 =?iso-8859-1?Q?HE2B0wQbc+qCj41AX4taiOa2fC0bNZ3VQK1oCuFv/qjFbfyaPUhYOppx23?=
 =?iso-8859-1?Q?b5UAxFWqHC8CSEIasZNnYS9rJ/GFygbXEuWqAZ6rChb5T7lbMUIxBjwCF8?=
 =?iso-8859-1?Q?SuKJyBBuHaP0pkQyQUfhBXf7b7oeuhOwHkcqjszK/6PKyUQp9wyOePfnw9?=
 =?iso-8859-1?Q?33iGyS7SwmFyNABNu+qpoMWqLmhsS5ro66fBUj4H9BqRYWQ+Eo5SldardH?=
 =?iso-8859-1?Q?jCaBefdjP+OJZsEGjp4XT/zN7nbmVUw5c/bF6Es0a/TtD+mehdBYhPq/65?=
 =?iso-8859-1?Q?fd9BH6ZryfT0HZHpj7WOsdKmrhqee18/bhz4OA2WgyAPegiZcGHWq9ZyFi?=
 =?iso-8859-1?Q?jq+A3DFXC8CUlKJdVRwGvbpCkXpsaAlDL8JJCq+xtfwO3XNPle9Zq3FV9i?=
 =?iso-8859-1?Q?svGOfTcL5gmkGU06uiabwY1FaQKYOxnnsNuhcqOpt9NOK+xXKnWsTBV7lQ?=
 =?iso-8859-1?Q?CaCutw+cLiOeHdUkPYxbPPbxpobVbHtpNkEBZrQIsyUAcr/ugV6xu7XmAe?=
 =?iso-8859-1?Q?lLavdbVaIzmeL0Q/NUylfEP6vgvVHmfg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecc9073-78a3-4782-b8ef-08d90a5b492a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:43.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WB/0i4RxWDtT2/krefNdq2LZGRIg5H8lNVtJqtk1br0PQFWcxmaiakqX3H/ts2aQJfHcdJ7e3+ET2VdtCDY7Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: mfdbRxDP9A-yoHhmBBilHUHFznrY9lgg
X-Proofpoint-ORIG-GUID: mfdbRxDP9A-yoHhmBBilHUHFznrY9lgg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree is an RCU-safe range based B-tree designed to use modern
processor cache efficiently.  There are a number of places in the kernel
that a non-overlapping range-based tree would be beneficial, especially
one with a simple interface.  The first user that is covered in this
patch set is the vm_area_struct, where three data structures are
replaced by the maple tree: the augmented rbtree, the vma cache, and the
linked list of VMAs in the mm_struct.  The long term goal is to reduce
or remove the mmap_sem contention.

The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
nodes.  With the increased branching factor, it is significantly shorter th=
an
the rbtree so it has fewer cache misses.  The removal of the linked list
between subsequent entries also reduces the cache misses and the need to pu=
ll
in the previous and next VMA during many tree alterations.

This patch is based on next-20210419

Link:
https://github.com/oracle/linux-uek/releases/tag/howlett%2Fmaple%2F20210419

Performance on a 144 core x86:

While still using the mmap_sem, the performance seems fairly similar on
real-world workloads, while there are variations in micro-benchmarks.

Increase in performance in the following micro-benchmarks in Hmean:
- wis brk1-threads: Disregard, this is useless.
- wis malloc1-threads: Increase of 15% to 500%
- wis page_fault1-threads: Increase of up to 15%

Decrease in performance in the following micro-benchmarks in Hmean:
- wis brk1-processes: Decrease of 45% due to RCU required allocations
- wis signal1-threads: -3% to -20%

Mixed:
- wis malloc1-processes: +9% to -20%
- wis pthread_mutex1-threads: +9% to -16%
- wis page_fault3-threads: +7% to -21%


kernbench:
Amean     user-2        880.66 (   0.00%)      885.49 *  -0.55%*
Amean     syst-2        143.88 (   0.00%)      152.64 *  -6.09%*
Amean     elsp-2        518.11 (   0.00%)      524.97 *  -1.32%*
Amean     user-4        903.74 (   0.00%)      908.41 *  -0.52%*
Amean     syst-4        149.61 (   0.00%)      158.42 *  -5.89%*
Amean     elsp-4        270.00 (   0.00%)      275.83 *  -2.16%*
Amean     user-8        955.25 (   0.00%)      961.88 *  -0.69%*
Amean     syst-8        158.76 (   0.00%)      169.04 *  -6.48%*
Amean     elsp-8        146.95 (   0.00%)      148.79 *  -1.25%*
Amean     user-16      1033.15 (   0.00%)     1037.42 *  -0.41%*
Amean     syst-16       168.01 (   0.00%)      177.40 *  -5.59%*
Amean     elsp-16        84.63 (   0.00%)       84.91 *  -0.33%*
Amean     user-32      1135.48 (   0.00%)     1130.56 *   0.43%*
Amean     syst-32       181.35 (   0.00%)      190.54 *  -5.06%*
Amean     elsp-32        50.53 (   0.00%)       51.88 *  -2.67%*
Amean     user-64      1191.24 (   0.00%)     1205.41 *  -1.19%*
Amean     syst-64       189.13 (   0.00%)      200.28 *  -5.89%*
Amean     elsp-64        31.75 (   0.00%)       31.95 *  -0.63%*
Amean     user-128     1608.94 (   0.00%)     1613.01 *  -0.25%*
Amean     syst-128      239.32 (   0.00%)      253.50 *  -5.93%*
Amean     elsp-128       25.34 (   0.00%)       26.02 *  -2.69%*

gitcheckout:
Amean     User           0.00 (   0.00%)        0.00 *   0.00%*
Amean     System         8.33 (   0.00%)        7.86 *   5.59%*
Amean     Elapsed       21.85 (   0.00%)       21.34 *   2.29%*
Amean     CPU           98.80 (   0.00%)       99.00 *  -0.20%*


Patch organization:
Patches 1-20 introduce a new VMA API: lookup_vma().  This looks up the VMA =
at a
given address and returns either NULL or the VMA.  In looking at the VMA co=
de,
find_vma() is often used to look up a vma and then check the limits (or
incorrectly assume that find_vma() does not continue searching upwards).
Initially, this is just a wrapper for find_vma_intersection() but becomes m=
ore
efficient once the maple tree is used.

Patches 21-25 update the radix tree test suite to support what is necessary=
 for
the maple tree.

Patch 26 is the maple tree and test code: 36,152 lines are the
test_maple_tree.c file alone.

Patches 27-33 are the removal of the rbtree from the mm_struct.

Patches 34-44 are the removal of the vmacache from the kernel.

Patches 45-51 are optimizations for using the maple tree directly.

Patches 52-91 are the removal of the linked list from the mm_struct.

Patches 92-94 are to do with cleaning up the locking around the splitting o=
f
VMAs using the maple tree state.


Liam R. Howlett (94):
  mm: Add vma_lookup()
  drm/i915/selftests: Use vma_lookup() in __igt_mmap()
  arch/arc/kernel/troubleshoot: use vma_lookup() instead of
    find_vma_intersection()
  arch/arm64/kvm: Use vma_lookup() instead of find_vma_intersection()
  arch/powerpc/kvm/book3s_hv_uvmem: Use vma_lookup() instead of
    find_vma_intersection()
  arch/powerpc/kvm/book3s: Use vma_lookup() in
    kvmppc_hv_setup_htab_rma()
  arch/mips/kernel/traps: Use vma_lookup() instead of
    find_vma_intersection()
  x86/sgx: Use vma_lookup() in sgx_encl_find()
  virt/kvm: Use vma_lookup() instead of find_vma_intersection()
  vfio: Use vma_lookup() instead of find_vma_intersection()
  net/ipv5/tcp: Use vma_lookup() in tcp_zerocopy_receive()
  drm/amdgpu: Use vma_lookup() in amdgpu_ttm_tt_get_user_pages()
  media: videobuf2: Use vma_lookup() in get_vaddr_frames()
  misc/sgi-gru/grufault: Use vma_lookup() in gru_find_vma()
  kernel/events/uprobes: Use vma_lookup() in find_active_uprobe()
  lib/test_hmm: Use vma_lookup() in dmirror_migrate()
  mm/ksm: Use vma_lookup() in find_mergeable_vma()
  mm/migrate: Use vma_lookup() in do_pages_stat_array()
  mm/mremap: Use vma_lookup() in vma_to_resize()
  mm/memory.c: Use vma_lookup() instead of find_vma_intersection()
  radix tree test suite: Enhancements for Maple Tree
  radix tree test suite: Add support for fallthrough attribute
  radix tree test suite: Add support for kmem_cache_free_bulk
  radix tree test suite: Add keme_cache_alloc_bulk() support
  radix tree test suite: Add __must_be_array() support
  Maple Tree: Add new data structure
  mm: Start tracking VMAs with maple tree
  mm/mmap: Introduce unlock_range() for code cleanup
  mm/mmap: Change find_vma() to use the maple tree
  mm/mmap: Change find_vma_prev() to use maple tree
  mm/mmap: Change unmapped_area and unmapped_area_topdown to use maple
    tree
  kernel/fork: Convert dup_mmap to use maple tree
  mm: Remove rb tree.
  arch/m68k/kernel/sys_m68k: Use vma_lookup() in sys_cacheflush()
  xen/privcmd: Optimized privcmd_ioctl_mmap() by using vma_lookup()
  mm: Optimize find_exact_vma() to use vma_lookup()
  mm/khugepaged: Optimize collapse_pte_mapped_thp() by using
    vma_lookup()
  mm/gup: Add mm_populate_vma() for use when the vma is known
  mm/mmap: Change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm/mmap: Change vm_brk_flags() to use mm_populate_vma()
  mm: Change find_vma_intersection() to maple tree and make find_vma()
    to inline.
  mm/mmap: Change mmap_region() to use maple tree state
  mm/mmap: Drop munmap_vma_range()
  mm: Remove vmacache
  mm/mmap: Change __do_munmap() to avoid unnecessary lookups.
  mm/mmap: Move mmap_region() below do_munmap()
  mm/mmap: Add do_mas_munmap() and wraper for __do_munmap()
  mmap: Use find_vma_intersection in do_mmap() for overlap
  mmap: Remove __do_munmap() in favour of do_mas_munmap()
  mm/mmap: Change do_brk_munmap() to use do_mas_align_munmap()
  mmap: make remove_vma_list() inline
  mm: Introduce vma_next() and vma_prev()
  arch/arm64: Remove mmap linked list from vdso.
  arch/parisc: Remove mmap linked list from kernel/cache
  arch/powerpc: Remove mmap linked list from mm/book3s32/tlb
  arch/powerpc: Remove mmap linked list from mm/book3s64/subpage_prot
  arch/s390: Use maple tree iterators instead of linked list.
  arch/x86: Use maple tree iterators for vdso/vma
  arch/xtensa: Use maple tree iterators for unmapped area
  drivers/misc/cxl: Use maple tree iterators for cxl_prefault_vma()
  drivers/tee/optee: Use maple tree iterators for __check_mem_type()
  fs/binfmt_elf: Use maple tree iterators for fill_files_note()
  fs/coredump: Use maple tree iterators in place of linked list
  fs/exec: Use vma_next() instead of linked list
  fs/proc/base: Use maple tree iterators in place of linked list
  fs/proc/task_mmu: Stop using linked list and highest_vm_end
  fs/userfaultfd: Stop using vma linked list.
  ipc/shm: Stop using the vma linked list
  kernel/acct: Use maple tree iterators instead of linked list
  kernel/events/core: Use maple tree iterators instead of linked list
  kernel/events/uprobes: Use maple tree iterators instead of linked list
  kernel/sched/fair: Use maple tree iterators instead of linked list
  kernel/sys: Use maple tree iterators instead of linked list
  mm/gup: Use maple tree navigation instead of linked list
  mm/huge_memory: Use vma_next() instead of vma linked list
  mm/khugepaged: Use maple tree iterators instead of vma linked list
  mm/ksm: Use maple tree iterators instead of vma linked list
  mm/madvise: Use vma_next instead of vma linked list
  mm/memcontrol: Stop using mm->highest_vm_end
  mm/mempolicy: Use maple tree iterators instead of vma linked list
  mm/mlock: Use maple tree iterators instead of vma linked list
  mm/mprotect: Use maple tree navigation instead of vma linked list
  mm/mremap: Use vma_next() instead of vma linked list
  mm/msync: Use vma_next() instead of vma linked list
  mm/oom_kill: Use maple tree iterators instead of vma linked list
  mm/pagewalk: Use vma_next() instead of vma linked list
  mm/swapfile: Use maple tree iterator instead of vma linked list
  mm/util: Remove __vma_link_list() and __vma_unlink_list()
  arch/um/kernel/tlb: Stop using linked list
  bpf: Remove VMA linked list
  mm: Remove vma linked list.
  mm: Return a bool from anon_vma_interval_tree_verify()
  mm/mmap: Add mas_split_vma() and use it for munmap()
  mm: Move mas locking outside of munmap() path.

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple-tree.rst         |    36 +
 MAINTAINERS                                   |    12 +
 arch/arc/kernel/troubleshoot.c                |     8 +-
 arch/arm64/kernel/vdso.c                      |     5 +-
 arch/arm64/kvm/mmu.c                          |     2 +-
 arch/m68k/kernel/sys_m68k.c                   |     4 +-
 arch/mips/kernel/traps.c                      |     4 +-
 arch/parisc/kernel/cache.c                    |    15 +-
 arch/powerpc/kvm/book3s_hv.c                  |     4 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c            |     2 +-
 arch/powerpc/mm/book3s32/tlb.c                |     5 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |    15 +-
 arch/s390/configs/debug_defconfig             |     1 -
 arch/s390/mm/gmap.c                           |     8 +-
 arch/um/kernel/tlb.c                          |    16 +-
 arch/x86/entry/vdso/vma.c                     |    12 +-
 arch/x86/kernel/cpu/sgx/encl.h                |     4 +-
 arch/x86/kernel/tboot.c                       |     2 +-
 arch/xtensa/kernel/syscall.c                  |     4 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |     4 +-
 .../drm/i915/gem/selftests/i915_gem_mman.c    |     2 +-
 drivers/media/common/videobuf2/frame_vector.c |     2 +-
 drivers/misc/cxl/fault.c                      |     6 +-
 drivers/misc/sgi-gru/grufault.c               |     4 +-
 drivers/tee/optee/call.c                      |    15 +-
 drivers/vfio/vfio_iommu_type1.c               |     2 +-
 drivers/xen/privcmd.c                         |     2 +-
 fs/binfmt_elf.c                               |     5 +-
 fs/coredump.c                                 |    13 +-
 fs/exec.c                                     |     9 +-
 fs/proc/base.c                                |     7 +-
 fs/proc/task_mmu.c                            |    45 +-
 fs/proc/task_nommu.c                          |    55 +-
 fs/userfaultfd.c                              |    43 +-
 include/linux/maple_tree.h                    |   449 +
 include/linux/mm.h                            |    62 +-
 include/linux/mm_types.h                      |    33 +-
 include/linux/mm_types_task.h                 |     5 -
 include/linux/sched.h                         |     1 -
 include/linux/sched/mm.h                      |     3 +
 include/linux/vm_event_item.h                 |     4 -
 include/linux/vmacache.h                      |    28 -
 include/linux/vmstat.h                        |     6 -
 include/trace/events/maple_tree.h             |   227 +
 include/trace/events/mmap.h                   |    71 +
 init/main.c                                   |     2 +
 ipc/shm.c                                     |    13 +-
 kernel/acct.c                                 |     8 +-
 kernel/bpf/task_iter.c                        |     6 +-
 kernel/debug/debug_core.c                     |    12 -
 kernel/events/core.c                          |     7 +-
 kernel/events/uprobes.c                       |    29 +-
 kernel/fork.c                                 |    50 +-
 kernel/sched/fair.c                           |    14 +-
 kernel/sys.c                                  |     6 +-
 lib/Kconfig.debug                             |    15 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  6393 +++
 lib/test_hmm.c                                |     5 +-
 lib/test_maple_tree.c                         | 36152 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/debug.c                                    |    12 +-
 mm/gup.c                                      |    27 +-
 mm/huge_memory.c                              |     4 +-
 mm/init-mm.c                                  |     4 +-
 mm/internal.h                                 |    51 +-
 mm/interval_tree.c                            |     6 +-
 mm/khugepaged.c                               |    13 +-
 mm/ksm.c                                      |    32 +-
 mm/madvise.c                                  |     2 +-
 mm/memcontrol.c                               |     6 +-
 mm/memory.c                                   |    45 +-
 mm/mempolicy.c                                |    44 +-
 mm/migrate.c                                  |     4 +-
 mm/mlock.c                                    |    26 +-
 mm/mmap.c                                     |  2271 +-
 mm/mprotect.c                                 |     7 +-
 mm/mremap.c                                   |    17 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   135 +-
 mm/oom_kill.c                                 |     5 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     9 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 mm/vmstat.c                                   |     4 -
 net/ipv4/tcp.c                                |     4 +-
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |    13 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |    78 +-
 tools/testing/radix-tree/linux/kernel.h       |    10 +
 tools/testing/radix-tree/linux/maple_tree.h   |     7 +
 tools/testing/radix-tree/linux/slab.h         |     2 +
 tools/testing/radix-tree/maple.c              |    59 +
 tools/testing/radix-tree/test.h               |     1 +
 .../radix-tree/trace/events/maple_tree.h      |     8 +
 virt/kvm/kvm_main.c                           |     2 +-
 100 files changed, 45347 insertions(+), 1699 deletions(-)
 create mode 100644 Documentation/core-api/maple-tree.rst
 create mode 100644 include/linux/maple_tree.h
 delete mode 100644 include/linux/vmacache.h
 create mode 100644 include/trace/events/maple_tree.h
 create mode 100644 lib/maple_tree.c
 create mode 100644 lib/test_maple_tree.c
 delete mode 100644 mm/vmacache.c
 create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
 create mode 100644 tools/testing/radix-tree/maple.c
 create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h

--=20
2.30.2
