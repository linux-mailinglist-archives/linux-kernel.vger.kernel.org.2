Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228503EEF76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhHQPxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:53:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38588 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240240AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkEMF023526;
        Tue, 17 Aug 2021 15:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=bt4QwNF/e8i5OAvoNdQpSi/xTkz4zPE0i22Zd2ovDMA=;
 b=OYHSeQl+qbZEn9kuqs5iyByXNcnJXlAgjxeBIWD27JkZ7ZewSys2TcDXqZDIN6iCdFzh
 xXC8/2oxbBWt0pjHKeNVVXOHnXJ5CCQPL+HVZ3P6XFOpu6lcA2QzPmWI/Q4AteSdytOi
 HTt9sADdYeXRCJet/rUkRSFt5B5UEIwVHSbjyFg8yQKJT+AcQ6iRLrzwujl1M2htoYKY
 OjfOzGqerQ2Hw+1sN0tse7/+tcz7Q4wQo8zIQm5eEPCxgsCXSEDbSXkV5mX9+L/q8Tx9
 +n030Z5Bl0OZwO8qrSA3Sz4DR/3bSDd3hsKPTv9QWcgUvlqsyFTO0yjbpY8NIZ5Ymcv/ Rg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=bt4QwNF/e8i5OAvoNdQpSi/xTkz4zPE0i22Zd2ovDMA=;
 b=lhgX9CAps7PmZlXxNB8Le9UMhP1ZPu0w9JddmQOpI8+zEzoU94FPxf/8+OxqENQgqHr/
 jJu6bG6VNsYiuSNW50WeofORZ/fshkm9dhR7dH1Pm1DLkaRFnwqkUZVL6v7ZKW+PO6XR
 Ed2xedDdk7+EdB6fJzb9tnePNlhWA1tVKM2FYgNB6WZpPN7L1xEF6Y74/abz+nt/ra/y
 Opm1EHkQDKeMG9DonWv/gptR2+wcAlfBGWR1MrfjLycqf91fZ/p8xEZ0SUty5XdDMxXx
 +0FqJHmWY7jVIhWaUL3lCtnArZpQpwaddxQxGkJHoEjqO2qWAqK0pGCIWfiwS8oxwot0 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd4kbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkt3W094574;
        Tue, 17 Aug 2021 15:47:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3ae3vftd2y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ+TymDg8eYj4DJxEjgxH86CWumbZwT/b9PouVaeXbFLTLnnnwERXpT8M3HM59iLppaBwzorhjfQfmu1QfVM3w4SlhqCP/RASIC8cCEmcYbalrSHB+nVtGO73ah4JH0KXHLwt1usUqYO0p0T7VKHqUjAkw4nV4+xHk7F1Pkmd3wppXCdKoqDRxxGLg+ZMSoCY1Gj86C1wrer7IyNjNgkX1XY7KNVvW59laj9qneTfJLB9OKr+9xm0WPZn6zA4dY9YE8tweKs1FYq9EucmV5bcx1dbtSkfNULZnhgp13zVfc3cTKb6khFZih1aFzcHZaCUZlh2yi0zxGe526xK3Pb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt4QwNF/e8i5OAvoNdQpSi/xTkz4zPE0i22Zd2ovDMA=;
 b=R4aY/1tJ8Inos9r/ENzu2zAd+0vsgtVgg6SLfz6slM9hYGSuQUlfYuqqBuyucxGZrp1Vqljuu13InFeehJpoKo2BrU8+UchHeMWJDWb1KLcHEFdCK70VklGniGme4BcdxmEgxUeAZlIGUaZvdO9yjXiYLVlVp65/131rqW10VJ+tEVqn3teILlP0UUqUUPlkcEYmVoHmh42rn6VkO99E5Uui6EtPUtfCtaf/T3MruEKLCZFGPXEyA5DwISJ4f028G6IX2/dfD/CrHJeGdc1zZuu9fivPJb6U9woWgRqhj/HVU9hWzToFH3vXpFhYwZYMNOSfaJQF6Xoz6JlU1MJydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt4QwNF/e8i5OAvoNdQpSi/xTkz4zPE0i22Zd2ovDMA=;
 b=p1Mjs8ieUdWh9vMgjDe59wP6jtw6S5TSH3nPY8qYTGUFAFm+8ffM0+fFIPpSC02TNpkYJ8nbKiz6b3aFobsToq94ANKOukUWZ4jKSImkv33CtqCEYhVdLkuIGgSQrKiUyLqgrU2w3rmUco6BZUxHTq/qzI8q8qIwu2cGxjTTkR8=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3097.namprd10.prod.outlook.com (2603:10b6:5:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 15:47:03 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:03 +0000
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
Subject: [PATCH v2 00/61] Introducing the Maple Tree
Thread-Topic: [PATCH v2 00/61] Introducing the Maple Tree
Thread-Index: AQHXk38fVEgoccVSbUqcYbGnQ4RL/Q==
Date:   Tue, 17 Aug 2021 15:47:03 +0000
Message-ID: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c739fbec-2a40-4a93-5100-08d96196424d
x-ms-traffictypediagnostic: DM6PR10MB3097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3097F0E9F7C98575EA7F724CFDFE9@DM6PR10MB3097.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EHeylXLA8IpunX6/0bRARrGHHT2cpoE0vJ2z7F0L/T69W2G2ZSIRuIye16cMyhAIt5Xc7uR2r3NNVpHJPXgkRsgQ/niz7IIXYD/MtUTEOS+HadNqD891GxLge6vK/LjMr0AMfMkkKDFxSvWX4vyQSe7oUuCpOh+6UWvORS5YkyLOxOTMUsvOyQFyFyPE8YQROfSN1OdmVYaHlaIGx+IRXQWtSpRwnqhGPmVVWsgVH1JaUNxtbulJIPhGCt5mLTSdxtfbAhtDfy8oBkbIJOThiQE6QPHG49RTJGpp/rZAAkcQOKlBTfHsihutlhjguhbwF5tvxluyMNrEXY74wh0Fp2FR3qbiM2i1T/X1vbuD8doNg9VFL9TCDPt5C7cyCm7OApYw/BxD0v3ZQPiBzRIIC50i+qWjKcnjt0qvNRyG2/+3jI4AgOe74tEfiaWmHyAK+h4AHeQCNpsS8Nsv/V5gHDx43TFcC91eQ36hvy9shfEPlqCyoKW24LGvYVGuv/s42aOPW0cOIwNYR+clA4VsyBx2/hvpuEXLydAsb9Oh74V1sW3LiHj7B2ToWURuCGkY205jxZVBHSjR1UXQ5EJ/UWPzs1xtMz3QzM8mwrnzMF6rPfXAJDe8DQsOU/KrZPzX91GpqndESswngzBQYy4hhAMoDtb0UJo+A3D680ZoGmI4CT61Opx2DZfMVz8C1wRof7hlXBPgI54MdLGBD1XE2x5xq+DLa/QpnjC/IB2HVw6rsZO5hOczd/yce/Xz61cVg8g39FiUHdKhlWiqmg32qYbusyi98iZ6lVWvcjWthMQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(6506007)(2616005)(54906003)(8936002)(478600001)(26005)(966005)(1076003)(38070700005)(110136005)(316002)(5660300002)(36756003)(30864003)(6486002)(71200400001)(91956017)(66446008)(122000001)(6512007)(38100700002)(83380400001)(7416002)(44832011)(2906002)(186003)(4326008)(107886003)(86362001)(66946007)(64756008)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DUMZdS4MNHQS3VRpqVqkaG4nuw0Jz+kwFW2aDQBRTXwA7dZJgw4jp5Mz0R?=
 =?iso-8859-1?Q?BwLERhsAxegsxEutHCz20W5h9XUvFZEce7NRn3XnPxTM7hv7jLm7kt/+Si?=
 =?iso-8859-1?Q?yqE/B7tED7CQFv6TC7sjJi61MRFm/ZBQJN5KaLVTp+tuDTucapCmGlguDY?=
 =?iso-8859-1?Q?M10p66DdxTY5OufXwsUFT7JkkVgt77ob7h3YVDI1ADIGrvhnm0BwTiTdf1?=
 =?iso-8859-1?Q?3ZT6r9mzqznmQIQhNbdCXZlMJ/an3cWI/RqDmrW9rpp+uLLmAP4tN+SqlB?=
 =?iso-8859-1?Q?cUWPoy6JtuXOUUV8IMYuImRfsUJYoargiUBJ+kdhIJpGEsrkw9lZWKAu8e?=
 =?iso-8859-1?Q?RtkK6Zpolx17QITYX734vXk3t05o8mBqd71Yyqxe/Wz/hu+545A4eHleWL?=
 =?iso-8859-1?Q?kExmBUNXv2GVWXDqfz7XezddHM05P/OgbsIVvBpyy7Toch9EZGarjkiCnh?=
 =?iso-8859-1?Q?FHtadrgFdIk5WyP/+kbF4Cesze1R5u3DJuBjMzBJWh062Pkv6Rghk5Imez?=
 =?iso-8859-1?Q?NpDbj5C/Lt/5ZgGd4mk1PC0i24o1Bwc1oZhOdbWiIY1c+eH2LTdoxxcT3h?=
 =?iso-8859-1?Q?VJ6X/KBBJPLNh/aqQdYU0NiuJJOPxw80YkaMATvBuiQJUIydGeV652ni2f?=
 =?iso-8859-1?Q?IJ1dkDpxvluADT6aVw4tlBQ0VM+ivAkhXoN+BhjzISum83miELOq/oArtI?=
 =?iso-8859-1?Q?SFMb+vKXqkTui/F1JXzeERM8/4Wi2iBAhR2mPaTLNeDMT4dLAc2IkDfiU/?=
 =?iso-8859-1?Q?q+6CAN16z+dixX/Bkuzg0JUXn0CoABGwer6JurpVcPjLUpWNWRYcRCibVE?=
 =?iso-8859-1?Q?mSSywLiOwKxehDIpAWVCcPgYwGXX/x05K8qpL848hiSPVSVPJP9brybm/z?=
 =?iso-8859-1?Q?Z1k4c0eYidHcvFcPIhDIDgYb0Di47abUitG7rpXgn4wNmEiAxb/DQ1BGy7?=
 =?iso-8859-1?Q?i311vdPkkuaY9kMqbXHZ73DKZbXwElZfK5C7Ax6iaO+6t/kIPKSvofvr2+?=
 =?iso-8859-1?Q?DmkLpjKx6dzU5NdUXiWKIvhk6rLSsJr3B3C5nX9lxvU+4HdrmYOPPQ2K/s?=
 =?iso-8859-1?Q?wcO71yj28LZtefHweIMXMu/++SEc0eOvRnpKPsJrZK5+3EHP5JVDMH19cj?=
 =?iso-8859-1?Q?JKMPlXV1CUchzDsyedu/7VnPrDI/LS7P8wJHq9/w+Nb31brHKWQl1X8kTw?=
 =?iso-8859-1?Q?skD0VVHlfxvD2t4/18m8x2e64w9jFM/+zgSmVvEDHYIcoGAYho+tXf3m7U?=
 =?iso-8859-1?Q?VkiU6xv28voEy9RBL3d+1P7OhDT2NHy12Vb/aubZ+a5IcCz5AISw1HsN/o?=
 =?iso-8859-1?Q?rbr3QeMqoCZxCzxTA/71HG/elQI+BB6w1sfPCEKzzeG/SuwSPIfLbDql0+?=
 =?iso-8859-1?Q?7R5sWfXSam?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c739fbec-2a40-4a93-5100-08d96196424d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:03.3802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTfGxCxei49hCJoI4sMzE1BaKCoLF+hA+e/LjfreBkz5zTYwgfYQNl9Te2l+AMRHvXKZ6rdRc4RjXN+1c3QiuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: FvTrQCpfX4JL5iWUYZtJxpVdDswuH7VD
X-Proofpoint-GUID: FvTrQCpfX4JL5iWUYZtJxpVdDswuH7VD
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

This patch series is based on next-20210811 with "remap_file_pages: Use
vma_lookup() instead of find_vma()"

Link:
https://github.com/oracle/linux-uek/releases/tag/howlett%2Fmaple%2F20210816

Performance on a 144 core x86:

While still using the mmap_sem, the performance seems fairly similar on
real-world workloads, while there are variations in micro-benchmarks.

Increase in performance in the following micro-benchmarks in Hmean:
- wis malloc1-threads: Increase of 13% to 840%
- wis page_fault1-threads: Increase of 1% to 14%
- wis brk1-threads: Disregard, this test is invalid.


Decrease in performance in the following micro-benchmarks in Hmean:
- wis brk1-processes: Decrease of 45% due to RCU required

Mixed:
- wis pthread_mutex1-threads: +11% to -3%
- wis signal1-threads: +6% to -12%
- wis malloc1-processes: +9% to -18% (-18 at 2 processes, increases after)
- wis page_fault3-threads: +8% to -22%

kernbench:
Amean     user-2        884.88 (   0.00%)      882.61 *   0.26%*
Amean     syst-2        157.38 (   0.00%)      161.23 *  -2.45%*
Amean     elsp-2        526.17 (   0.00%)      527.53 *  -0.26%*=20
Amean     user-4        919.90 (   0.00%)      910.87 *   0.98%*
Amean     syst-4        166.21 (   0.00%)      170.06 *  -2.32%*
Amean     elsp-4        278.01 (   0.00%)      276.83 *   0.42%*
Amean     user-8        973.23 (   0.00%)      970.73 *   0.26%*
Amean     syst-8        176.70 (   0.00%)      181.00 *  -2.44%*
Amean     elsp-8        152.24 (   0.00%)      153.33 *  -0.72%*
Amean     user-16      1040.15 (   0.00%)     1045.90 *  -0.55%*
Amean     syst-16       185.13 (   0.00%)      191.08 *  -3.21%*
Amean     elsp-16        85.47 (   0.00%)       86.70 *  -1.44%*
Amean     user-32      1189.60 (   0.00%)     1187.91 *   0.14%*
Amean     syst-32       210.02 (   0.00%)      219.46 *  -4.49%*
Amean     elsp-32        53.86 (   0.00%)       53.91 *  -0.08%*
Amean     user-64      1222.05 (   0.00%)     1230.00 *  -0.65%*
Amean     syst-64       213.37 (   0.00%)      223.57 *  -4.78%*
Amean     elsp-64        32.87 (   0.00%)       33.42 *  -1.68%*
Amean     user-128     1618.73 (   0.00%)     1614.52 *   0.26%*
Amean     syst-128      259.72 (   0.00%)      272.95 *  -5.09%*
Amean     elsp-128       25.91 (   0.00%)       25.93 *  -0.08%*


gitcheckout:
Amean     User           0.00 (   0.00%)        0.00 *   0.00%*
Amean     System         8.09 (   0.00%)        7.90 *   2.25%*
Amean     Elapsed       22.89 (   0.00%)       22.50 *   1.74%*
Amean     CPU           93.53 (   0.00%)       93.67 *  -0.14%*


v2 changes:
- Split out unlock_range() into its own cleanup patch, already upstream
- Split off vma_lookup() into its own 22 patches, already upstream
- Fixed locking issue when brk does not change but succeeds. Thanks Suren
  Baghdasar
- Move locking in brk much earler to match mmap_sem
- Fixed RCU locking issue in mm/khugepaged.  Thanks Hillf Danton
- RCU fixes in userfaultfd_release, mlock, munmap, task_mmu, and nommu
- Removed mm_populate_vma() and related patches from this set
- Removed inline of remove_vma_list() from this set as the function is remo=
ved
- Fixed comments to all C-based comments as suggested by Peter Zijlstra
- Fixed comments to all C-based comments in test_maple_tree.c as well
- Changed #defines to hex as requested by Peter Zijlstra
- Fixed whitespace error in mas_set_range().  Thanks Peter Zijlstra
- Add Asserts to mas->depth and mte_pivot() range check.  Thanks Peter Zijl=
stra
- Updated comments for mas_alloc_req() and friends.  Thanks Peter Zijlstra
- Added back the parent pointer decoding support and added explanations on =
how
  the encoding/decoding works.  Thanks Peter Zijlstra
- Expanded maple tree height to 31 and added a BUG_ON when exceeding that
  value.  There should be no way to reach 31 high.  Thanks Peter Zijlstra
- Added comment on harmless race in mmget_not_zero() - Thanks Suren Baghdas=
aryan
- Removed debug statement left in during testing - Thanks Suren Baghdasarya=
n
- Fixed locking in dup_mmap() - Thanks Suren Baghdasaryan
- Changes in the RCU locking in areas that may sleep.
- Added rcu stress testing and fixed maple tree specific issues exposed
  - Thanks Paul McKenney for helping with this.
- Large Documentation update.


Patch organization:
Patches 1 to 4 are radix tree test suite additions for maple tree
support.

Patch 5 adds the maple tree.  Test code is 37000 lines.

Patches 6-11 are the removal of the rbtree from the mm_struct.

Patches 12-18 are the removal of the vmacache from the kernel.

Patches 19-60 are the removal of the vma linked list from the mm_struct.

Patch 61 is a small cleanup from the removal of the vma linked list.

Liam R. Howlett (61):
  radix tree test suite: Add pr_err define
  radix tree test suite: Add kmem_cache_set_non_kernel()
  radix tree test suite: Add allocation counts and size to kmem_cache
  radix tree test suite: Add support for slab bulk APIs
  Maple Tree: Add new data structure
  mm: Start tracking VMAs with maple tree
  mm/mmap: Use the maple tree in find_vma() instead of the rbtree.
  mm/mmap: Use the maple tree for find_vma_prev() instead of the rbtree
  mm/mmap: Use maple tree for unmapped_area{_topdown}
  kernel/fork: Use maple tree for dup_mmap() during forking
  mm: Remove rb tree.
  xen/privcmd: Optimized privcmd_ioctl_mmap() by using vma_lookup()
  mm: Optimize find_exact_vma() to use vma_lookup()
  mm/khugepaged: Optimize collapse_pte_mapped_thp() by using
    vma_lookup()
  mm/mmap: Change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm: Use maple tree operations for find_vma_intersection() and
    find_vma()
  mm/mmap: Use advanced maple tree API for mmap_region()
  mm: Remove vmacache
  mm/mmap: Move mmap_region() below do_munmap()
  mm/mmap: Convert count_vma_pages_range() to use ma_state
  mm/mmap: Reorganize munmap to use maple states
  mm/mmap: Change do_brk_munmap() to use do_mas_align_munmap()
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
  arch/um/kernel/tlb: Stop using linked list
  bpf: Remove VMA linked list
  mm/gup: Use maple tree navigation instead of linked list
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
  mm: Remove the vma linked list
  mm/mmap: Drop range_has_overlap() function

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple-tree.rst         |   508 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/vdso.c                      |     5 +-
 arch/parisc/kernel/cache.c                    |    15 +-
 arch/powerpc/mm/book3s32/tlb.c                |     5 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |    15 +-
 arch/s390/configs/debug_defconfig             |     1 -
 arch/s390/mm/gmap.c                           |     8 +-
 arch/um/kernel/tlb.c                          |    16 +-
 arch/x86/entry/vdso/vma.c                     |    12 +-
 arch/x86/kernel/tboot.c                       |     2 +-
 arch/xtensa/kernel/syscall.c                  |     4 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 drivers/misc/cxl/fault.c                      |     6 +-
 drivers/tee/optee/call.c                      |    15 +-
 drivers/xen/privcmd.c                         |     2 +-
 fs/binfmt_elf.c                               |     5 +-
 fs/coredump.c                                 |    13 +-
 fs/exec.c                                     |     9 +-
 fs/proc/base.c                                |     7 +-
 fs/proc/task_mmu.c                            |    48 +-
 fs/proc/task_nommu.c                          |    55 +-
 fs/userfaultfd.c                              |    34 +-
 include/linux/maple_tree.h                    |   474 +
 include/linux/mm.h                            |    54 +-
 include/linux/mm_types.h                      |    31 +-
 include/linux/mm_types_task.h                 |     5 -
 include/linux/sched.h                         |     1 -
 include/linux/sched/mm.h                      |     9 +
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
 kernel/events/uprobes.c                       |    25 +-
 kernel/fork.c                                 |    61 +-
 kernel/sched/fair.c                           |    14 +-
 kernel/sys.c                                  |     6 +-
 lib/Kconfig.debug                             |    15 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  6779 +++
 lib/test_maple_tree.c                         | 37000 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/debug.c                                    |    14 +-
 mm/gup.c                                      |     7 +-
 mm/huge_memory.c                              |     4 +-
 mm/init-mm.c                                  |     4 +-
 mm/internal.h                                 |    81 +-
 mm/khugepaged.c                               |    11 +-
 mm/ksm.c                                      |    26 +-
 mm/madvise.c                                  |     2 +-
 mm/memcontrol.c                               |     6 +-
 mm/memory.c                                   |    33 +-
 mm/mempolicy.c                                |    41 +-
 mm/mlock.c                                    |    21 +-
 mm/mmap.c                                     |  2129 +-
 mm/mprotect.c                                 |    13 +-
 mm/mremap.c                                   |    13 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   120 +-
 mm/oom_kill.c                                 |     5 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     9 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 mm/vmstat.c                                   |     4 -
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |    13 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |   160 +-
 tools/testing/radix-tree/linux/kernel.h       |     1 +
 tools/testing/radix-tree/linux/maple_tree.h   |     7 +
 tools/testing/radix-tree/linux/slab.h         |     4 +
 tools/testing/radix-tree/maple.c              |    59 +
 .../radix-tree/trace/events/maple_tree.h      |     8 +
 82 files changed, 46975 insertions(+), 1639 deletions(-)
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
