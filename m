Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2129C421BE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhJEBdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64898 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230452AbhJEBdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:01 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951OdX7010252;
        Tue, 5 Oct 2021 01:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=3dh2fyeFStJ0eoL6s+os+346cUUPoHSm+i7flt4yF3w=;
 b=PFoR3/p9y4rFyQmPFSSNJqxD7PRfsL7Olp+3H7itZuc6Z1FPXD3KQT/tAi/FQIlh8sAw
 eCVxW2TxDKZwe6IMshZkXxBDZyn2F9DKJ5MCEa4sN1muCDUZcIizbfpPSLN2yT9mlIOw
 2I21t5S/rI21DG45ZMv1KnNq0Q8+UVO3vhmnIMbmP9nwBo37OTnm9u7rjB3f/bIbcxFa
 t+nVuxvktxVu1NDv06wtA9sRd2gm31Mv6bYmaK2QZ4cwSqRZIv9+pQsFaJGQdQQW8eVP
 2DvQ5xdzvKexsHUYMmlvjevcUO62SQ73ysJzCmgMBjvhP2Mtiq/dfczLBl2g5ci6ecx1 +A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3upv32m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHf0178354;
        Tue, 5 Oct 2021 01:30:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3bev8w02af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0iWjp93hYpuJX+8v0As3LJCx36vwdAjob4GmNP8hOsTVyVba60bEaYBCErM0qUL6CBcIn7sORyDfhb5XI6r1lj/zKYDZfTmHO1rPlE4xZq0RqPWw4jEimfPANq8FrgJfEpusS9CqyOGMPEyLGg+Fkf7N2z9fBpA8hXeRvLnT3pE7mzGVjM1SigUUGeZYEeTAlsyw1hfF1TGOx2jfzCpSxr3NxnTXTRn33eVhILidw3A5wNnN2gaU1rpcWdva1gb7HWIeXl6+2v8UDNd0vaA/DGqGvnGamp6PVJyixlCkaub8xyZdeUWT4bEf20lgILc7VFXHbRBipFvP6pphJzfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dh2fyeFStJ0eoL6s+os+346cUUPoHSm+i7flt4yF3w=;
 b=ehPM7YKDWbFdXbvwVNZ8zlv6DG53K9j5b1I1BlcjI4e8ly8Dm+WxemDEzT/CemTZ6oj3Hip8f3QLQqenShNNeQk7JRaX47ySHdwgLenHyGbpRONreGHkoWEgmHfu3iFu6N8sWdNr2z4hGXMZZ6jmv2VrOfrhRK8pYqTkfeqLT7QzL4D/H2vuqBLQkxowkPmEi1hj6JiX/xEnrO8ta+KxtoLACf8ZrecTZROXG8oSJsMyyY2qwz3GwoRgoo4bQtYb0wG4M3C5PjCsQt9vcWPjoqXWdfVxyCy63IaUeN77YQ9X3B5O/vU6l9Qeo696u6gGYJCIjfRCCSCxUfbCExwYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dh2fyeFStJ0eoL6s+os+346cUUPoHSm+i7flt4yF3w=;
 b=Jy/t32PBzLL1SmEoifY8RMn6n9wmlxxYfVmK0bGVQW38TsRU7hh4q1JAEAjtLyLg04rWFOKdfK/H1M/RedapsVnLnefXwqsaZEUt0RIgwcZW3Gg4YiZOO0tooG8v6PqCPQ9IIm06l10rAna+riHV17wFmaYQSY+JR4R+ekVNW18=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5218.namprd10.prod.outlook.com (2603:10b6:208:306::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:25 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 00/66] Introducing the Maple Tree
Thread-Topic: [PATCH v3 00/66] Introducing the Maple Tree
Thread-Index: AQHXuYiS9Xv5SJOepEyoMjh6+6izPg==
Date:   Tue, 5 Oct 2021 01:30:25 +0000
Message-ID: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 137a54db-0233-462e-d3df-08d9879fb4e8
x-ms-traffictypediagnostic: BLAPR10MB5218:
x-microsoft-antispam-prvs: <BLAPR10MB521871BEB459ABC3D561523BFDAF9@BLAPR10MB5218.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o1pYLHhYJH2T44yHoH5YKiKQzVVFmkvJxMU3MQaW9E29DVb7TGSygsZ6YTYFFwO4rOcvayZidjo2vQvRnhzE7zqcfpruYZVQHQgJeitLmXLvrYwwFkrYcVJxS9sFe+gVBeXmNDBkuMG1CWS3vlpUUHG2WxgpQw1RWXZywxDvGsSSN35ivJoME2KTs1jSQE9d3dnaozFVOKgo/y50trVPw24e8RrUScLnUbPqjtAfRqvAx5RtF220WZukE96e2asMnRs9vz9KeNHTKO5ygCDqoFK/Tx407QRhpmjdEQY51eONhTwCDZAbzA5qT/0S7y0ivGCjXwQT9EgOGWL97EBq1TH+tUJaqpvS18SUm8YlXdWsB+gmvRkgrnBoY/dYovkf/WNZd5RNwBwFcC3bq9wnbG92ehWiclTX3Dugg+67nLK7Y+rwJ69/IDAopLUvsKQERp32TClVl/k0q/TJIARUm8hySI6jrCKgKpscV5UYwAEXar7eBVOrTl741bUfIAjUvnwVntuRVlX5sDku8mXH+AuJTMxzdHh9rxnT2/PBwEW7WZ5oJO0N7jZTHoLKfB/q8DoCoXpGXBv9yS00YLl+8QH2PbO44cpzkGXMB2sKnb80rpV0PT7HjN2DHiH5Dsf/Hif/S5qOqpqqRRW3Glee8BSXhKGJRNpzcExqilqQwkeNNhQN6/SlQLemVPleA1bwK/R8S87KMG4rwzrI/1rWeGcbFXklDPAVCwveiGz9x5OJ3AmjV53VO1G5NRB8jU3bl4d4h3SKaIP4hlcPpbxuykeAC3ikYNtb0GHjHCFW7R6AiraUdms95tWSSjPDVowT37IslfLjklgyp+qtZB3IFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(5660300002)(6486002)(186003)(6506007)(86362001)(6512007)(1076003)(36756003)(38100700002)(508600001)(30864003)(8936002)(71200400001)(966005)(8676002)(122000001)(316002)(110136005)(76116006)(91956017)(2616005)(44832011)(7416002)(38070700005)(54906003)(4326008)(66556008)(2906002)(64756008)(83380400001)(66476007)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dgLIFrqY88gkdbaAAX6jUArq2uLddvciPwTeJsPvyyXq/CBo+IdENolvgu?=
 =?iso-8859-1?Q?Zgio+3WI4vLJQwA0gTTL9C/YDCxUFldt/vrN7FGx4EdWx32FlPsy9cvXEL?=
 =?iso-8859-1?Q?uG+7ktTzF8ERyO489jyvkPREe0vUAXaIwVs7Z8yIwAHH+M9G4BboyjOT+Z?=
 =?iso-8859-1?Q?daLanCr9iyE34jB8BtzuLxvzj+lMDfDHoNh4opPfqt0/8eWP63SL9gNYbD?=
 =?iso-8859-1?Q?t+cMOQmcUi445F4j3eDEO2am3w1gzRIk7lCb3XRSjazHhGuP/q+/1mRVuJ?=
 =?iso-8859-1?Q?GUOFm4zPlqu0+3Wsa/P43tKroypPWHDFdpXENB8z5xf+WUtfdQTWQLDek1?=
 =?iso-8859-1?Q?ZBbWhdnuF5MGFmDcbqnIJb9d2j2EaLaIHmpg5OINi09m+tQ6S9kmhmljUr?=
 =?iso-8859-1?Q?SE9cOWGfTmNZwjnOHtJG6WSE4L4zfzT9jj6hr/qZUiEzFfoAQhKrgeA2GW?=
 =?iso-8859-1?Q?HmLRG2f/bwfG8+6WOncOPchi0cEilBwsHkVMclu5JZT7jLUZZdqgQgEPR7?=
 =?iso-8859-1?Q?+vrQrVx0acES+7OM7ijgJYXXjKUC8UxEbykfFP01gG4zor6tKxtq3m/2cP?=
 =?iso-8859-1?Q?Y+FKB92Nd1S4RA6gQ8D+Q+rZ4k9rupocJDliGIaWo0U78NBmIWorPtleyF?=
 =?iso-8859-1?Q?BTtTSuBA6du16ZOrOUNa/ryQ8C3FMNRBywB3y7/o+coXKWA9Iz2Oa9zqhv?=
 =?iso-8859-1?Q?U7IKiPk5ZMIfgQpHE08ducFZxZ5ziopu1fr7n0tDBpzViZjL1gJ8phakUM?=
 =?iso-8859-1?Q?553PTW8aid0zihLUhzLzZw1vp1U7CaVq2PgU1EL+4mv0wpWllYtBa2qTBH?=
 =?iso-8859-1?Q?gMZzlx2rw6G+h4b7oEoJI5Ffrd7tpaeQ9MxTMQAA1cdzbzkHWrMiSPRR4h?=
 =?iso-8859-1?Q?+/BlxygwkAmAMPuEPqwa9oHg8Vgr3hJuQwW+kOIqFTW092sh7LfvZYzteu?=
 =?iso-8859-1?Q?FholWrlQsA0A+oy6yN821lFpznoFXOxjh+JAvAhIbhNXSa5l0uhlxFD/6b?=
 =?iso-8859-1?Q?5H50k1qCM0HXEz8yVUw3458TACNhI9YyAKKiYXpbjn5zBKRPjiSg3YpJTu?=
 =?iso-8859-1?Q?w8DrkakQNAAdY/lURYUjKiv8Y98CB9wL6iDajI+3nXhfH3MbQ7I6hpNnCn?=
 =?iso-8859-1?Q?+qmym86HjjHR+fohJNAbI0uFusmDwXkjju50SJDk3MYKojuMC6OJTZ5Dst?=
 =?iso-8859-1?Q?M37BVDxduwF+FUkgbXJPWCsLR/Z2eZnV4wqJ6DRdBQYkmPOraonaMo3TR5?=
 =?iso-8859-1?Q?WpiJ/cIStNM3xFZ08jvcrFhApntJqWmiDAfuUzUYjSWzaKYSMlp7ic+NK0?=
 =?iso-8859-1?Q?O6dJoGlII0L95avoG8QVn069JMvcygKluQcf3RUDacQOFl+YtnBQJwQqPA?=
 =?iso-8859-1?Q?CTs+88iF3U?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137a54db-0233-462e-d3df-08d9879fb4e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:25.2474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szDx47vjPojteSzUq8LEhiBn0q3yCIlfN+UU4da5Mcg4Q1g2SkKi/jnsIGro7Qe+3gAWR8HQyAT4s1d1xCByuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5218
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: 0FNiRpI7kUshPnHzPdCAw0QhO9zEF-NK
X-Proofpoint-GUID: 0FNiRpI7kUshPnHzPdCAw0QhO9zEF-NK
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

This patch is based on v5.15-rc3

git: https://github.com/oracle/linux-uek/tree/howlett/maple/20211004

v3 changes:
- Reverted unnecessary change to mm headers - Thanks David Hildenbrand
- Fixed 8 typos in the documentation - Thanks Douglas Gilbert
- Reduced the number of walks in do_mas_align_munmap()
- Remove unnecessary resets of the maple state
- Reworked mas_node_store() and mas_slot_store() so _mas_store has a more
  shallow code path
- Added support for metadata node end markers to leaves and non-alloc
  nodes
- Fixed lockdep complain on detaching VMAs, mainly cosmetic
- Added maple iterator for powerpc, damon, i915, and s390 VDSO
- Changed zeroing of maple tree in _vma_adjust().  Just overwrite the area.

v2: https://lore.kernel.org/linux-mm/20210817154651.1570984-1-Liam.Howlett@=
oracle.com/
v1: https://lore.kernel.org/linux-mm/20210428153542.2814175-1-Liam.Howlett@=
Oracle.com/

Performance on a 144 core x86:

It is important to note that the code is still using the mmap_sem, the
performance seems fairly similar on real-world workloads, while there
are variations in micro-benchmarks.

kernbench, increased system time, less user time:

Amean     user-2        881.41 (   0.00%)      879.51 *   0.22%*
Amean     syst-2        147.52 (   0.00%)      151.16 *  -2.47%*
Amean     elsp-2        520.65 (   0.00%)      521.30 *  -0.13%*
Amean     user-4        904.92 (   0.00%)      905.51 *  -0.07%*
Amean     syst-4        154.76 (   0.00%)      159.14 *  -2.83%*
Amean     elsp-4        271.53 (   0.00%)      272.52 *  -0.36%*
Amean     user-8        957.37 (   0.00%)      957.04 *   0.03%*
Amean     syst-8        162.09 (   0.00%)      168.37 *  -3.88%*
Amean     elsp-8        148.01 (   0.00%)      149.64 *  -1.10%*
Amean     user-16      1037.05 (   0.00%)     1034.01 *   0.29%*
Amean     syst-16       171.22 (   0.00%)      178.27 *  -4.12%*
Amean     elsp-16        85.17 (   0.00%)       84.98 *   0.23%*
Amean     user-32      1202.17 (   0.00%)     1164.72 *   3.11%*
Amean     syst-32       189.54 (   0.00%)      195.18 *  -2.98%*
Amean     elsp-32        52.93 (   0.00%)       52.41 *   0.98%*
Amean     user-64      1236.16 (   0.00%)     1244.45 *  -0.67%*
Amean     syst-64       192.87 (   0.00%)      203.73 *  -5.63%*
Amean     elsp-64        32.53 (   0.00%)       32.81 *  -0.84%*
Amean     user-128     1609.20 (   0.00%)     1608.73 *   0.03%*
Amean     syst-128      237.86 (   0.00%)      250.98 *  -5.52%*
Amean     elsp-128       25.55 (   0.00%)       25.89 *  -1.30%*

Increase in performance in the following micro-benchmarks in Hmean:
- wis brk1-threads: Disregard, this is useless.
- wis malloc1-threads: Increase of 13% to 992%
- wis page_fault1-threads: Increase of up to 15%
- wis signal1-processes: 0% to +10%

Decrease in performance in the following micro-benchmarks in Hmean:
- wis brk1-processes: -42% to -49% due to RCU required allocations
- wis signal1-threads: 0% to -5%

Mixed:
- wis malloc1-processes: +4% to -19%
- wis pthread_mutex1-threads: +21% to -8%
- wis page_fault3-threads: +10% to -28%


Patch organization:

Patches 1 to 4 are radix tree test suite additions for maple tree
support.

Patch 5 adds the maple tree.  The bulk of which is test code.

Patches 6-11 are the removal of the rbtree from the mm_struct.

Patch 12 optimizes __vma_adjust() for the maple tree.

Patches 13-19 are the removal of the vmacache from the kernel.

Patches 20-24 make necessary changes for the removal of the vma linked
list.

Patches 25-65 are the removal of the vma linked list from the mm_struct.

Patch 66 is a small cleanup from the removal of the vma linked list.

Liam R. Howlett (66):
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
  mmap: Change zeroing of maple tree in __vma_adjust
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
  kernel/fork: Use maple tree iterators instead of linked list
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
  damon: Change vma iterator to mas_for_each
  powerpc: Use maple tree iterator for vdso.
  s390: Use the maple tree iterator for vdso
  i915: Use the maple tree iterator for vdso
  mm: Remove the vma linked list
  mm/mmap: Drop range_has_overlap() function

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple-tree.rst         |   508 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/vdso.c                      |     5 +-
 arch/parisc/kernel/cache.c                    |    15 +-
 arch/powerpc/kernel/vdso.c                    |     4 +-
 arch/powerpc/mm/book3s32/tlb.c                |     5 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |    15 +-
 arch/s390/configs/debug_defconfig             |     1 -
 arch/s390/kernel/vdso.c                       |     3 +-
 arch/s390/mm/gmap.c                           |     8 +-
 arch/um/kernel/tlb.c                          |    16 +-
 arch/x86/entry/vdso/vma.c                     |    12 +-
 arch/x86/kernel/tboot.c                       |     2 +-
 arch/xtensa/kernel/syscall.c                  |     4 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |     3 +-
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
 include/linux/maple_tree.h                    |   485 +
 include/linux/mm.h                            |    54 +-
 include/linux/mm_types.h                      |    28 +-
 include/linux/mm_types_task.h                 |     5 -
 include/linux/sched.h                         |     1 -
 include/linux/sched/mm.h                      |     9 +
 include/linux/vm_event_item.h                 |     4 -
 include/linux/vmacache.h                      |    28 -
 include/linux/vmstat.h                        |     6 -
 include/trace/events/maple_tree.h             |   123 +
 include/trace/events/mmap.h                   |    71 +
 init/main.c                                   |     2 +
 ipc/shm.c                                     |    13 +-
 kernel/acct.c                                 |     8 +-
 kernel/bpf/task_iter.c                        |    10 +-
 kernel/debug/debug_core.c                     |    12 -
 kernel/events/core.c                          |     7 +-
 kernel/events/uprobes.c                       |    25 +-
 kernel/fork.c                                 |    70 +-
 kernel/sched/fair.c                           |    14 +-
 lib/Kconfig.debug                             |    15 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  6811 +++
 lib/test_maple_tree.c                         | 36996 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/damon/vaddr.c                              |     3 +-
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
 mm/mmap.c                                     |  2094 +-
 mm/mprotect.c                                 |    13 +-
 mm/mremap.c                                   |    27 +-
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
 .../radix-tree/trace/events/maple_tree.h      |     3 +
 85 files changed, 46908 insertions(+), 1632 deletions(-)
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
