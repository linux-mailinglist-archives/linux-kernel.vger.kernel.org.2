Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887C836DC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbhD1Pm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51240 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240643AbhD1Pii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:38 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMkWP020210;
        Wed, 28 Apr 2021 15:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=D66KGl/cizY31bcyrrVL5Mg9jzEnGDf95H7P5KrUvpU=;
 b=hDS5igeQggjJ/bXM/wq9H68BPgyvZ/pda0zqqAM8cHcfI32QmXQwPbiGXWbcCTcUcodw
 tTSNoMnLfZA6UVcjhuIIA6p9e7mUpCwfhDlx/eFoi014qRu84yLr0h+AG19JSq6x3a+Q
 RFmZoZoUkyDYE6Hxbo16HzoBuofFRjbsvWGT8Is3EPAObGZ7WS0/1onVWbucs29TSkZX
 TuNNDKfNtNYzRGYxLugNFhwpKS17K+x5FAhQZxzPmRiPgKAxZFm7XabkKe2YQRd1D6Ht
 XmCIH63VPKAplLPG6f0j3/hI4WFZBTzcLmMmCjrpWI6cuatLDJ63Ht7VKssLydxHZzlb LA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg531-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:30 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbScr033031;
        Wed, 28 Apr 2021 15:37:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3020.oracle.com with ESMTP id 384b58qpxp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFBdwrqq0lg+Zi5Qr4kS68rmk38sdgv9DSEKZriNmTUipi3qnt+oGA6NWnjCZhpS++hOi2yuf9gkTMhWbtp8OQrJVgfm9SRmyE+B+XCnRc2vGpWh7PRZC272XSK2SDv4QE/0SKPFq1WP/CF/2nLf6yR5zvDn3blRaAX/g3CU6oVYhnU7U4z3RHJrYZetcf9JmgiK3k8fdXHdedWIpxNPDgU+SE7eSAtiYbkykgcdOHUzZy1m1D4C6O9Rp4Jssond5S93R4xmA26PNBKq6ITHoqFF53tTNKY/RWG282KvXzpryLHrjkuNwcsMXJOHbm1xcswLp6UYDb/875gpaK6sFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D66KGl/cizY31bcyrrVL5Mg9jzEnGDf95H7P5KrUvpU=;
 b=SDqvnldKtP5cVr7x9hpY7yKoCb+Pvzd9/sRapkVVjpxMBkYFgAPixACkKz7rNK4f3dGlvjMN4k6WeEblVSVsyAq4Tb3HO/IElsy5n0r+iu3t9u7bypTK08q5GIQbfdLvF6J1G1PFmWm49VzTAPyzVkKMwLQGimAHG6DNhCLL7+lDNophcjGhX3Xqg589b1MLzvgn8DiaAiiXdCYsTlgFTUT7w6H0VwbnpiZt6IrQ/u4JS4cK8XO54VLhqn696LxIVB2+8TY2bMYTE8U6u1sOjM92JVLLzTKL6ve6MOIVBxETU4E7a0ONEzl5Oi3jDgnzZ8Js9U0tRfShkYnt6COgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D66KGl/cizY31bcyrrVL5Mg9jzEnGDf95H7P5KrUvpU=;
 b=RGVj2XvOuFlSJcMDMNWZdZodqYqlyCH9/+EqB+u/vwJ+mjXTf0ld8RzjLfppSHW4pBFl2LSO7f0fGG05huw8t/LZrJgf41lCsR1EoiLiRrO7rh/4IftWm9kuqIDbvc+V46WeJIbJLbrLUzxYnskGFmgoCXg8k79P0XP2mFDMNbA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:37:26 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:26 +0000
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
Subject: [PATCH 79/94] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Topic: [PATCH 79/94] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Index: AQHXPERAIRV/cOdwQ0O2j4t9Yvl2yg==
Date:   Wed, 28 Apr 2021 15:36:26 +0000
Message-ID: <20210428153542.2814175-80-Liam.Howlett@Oracle.com>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 15968c9a-641c-4b82-49b8-08d90a5b863d
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB454814DAE4B71B770F7C84AEFD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hSTPwg+l6Kq0uSngX1MCLkKe6ViTKX2COGrTSgHu/fragEMQJcXhEItRAigfVLFimVu3CXtCCnoWJZQMbHFisDa/qbNCYUYAMfWyE66RKjTbEVr/DWvSP0lQSnR/Ik8pVTq2GKKz7+OKce3g67SE95HyFNDwo1rMaIztLJUJe59hnkSiw3h5Y17JtwtJOZkr5HcMzwfbpBCJPtPQUO5urSWL21GNEpmPkn8c3Blexfs1FFaGGPO6LRHBxPs3JPgQRuyAK8hIq/5G+Xg++5NohooZXiM9G2bzIcasCMzFgFGvB6vYe7Vfowkfnw8bc+zn8xEQXLusD+8dw8vomZHJPvto9bHaaote+gsz6087qholYhHcXAJTXmeE5rs3xJ2gdFl42havRWOAvdftpVw5xMtwYHlR51WDzYTDRi7UMEvwb2n0MtgTc6AuhTDgoZJ17Wn1rU5hh9xb/U1WcyT9E6/hYx+Pbc3zISPJ7nD3jLAVlT4ke8tEYDO5Y47JwYLnZQuKaShvNVW1IDVZ6TzWqTJTAF8oN7we7pJh2AGFdljtsn20EM/nyfQblVNSTtUOR9jk2u6admqTybyVr0py/c0RLvFMEwkENujGx/qYfk4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6486002)(71200400001)(5660300002)(316002)(4744005)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?W3aU2qZdfgaJicQS3VEADZK0piHyJck16fUNIqaFgv/sr3i6JAI5fpGMcm?=
 =?iso-8859-1?Q?OQFBbBfH4eM6oBaTTRJGEMCTrXIHuETM1fRODdCoHWVIi8YsOlXyiVpbSo?=
 =?iso-8859-1?Q?7hxL4xjqR8ZSVyCNjivcVMCEE5M3JxFuwZt0jn5unPfzGOQeUeBh8y2rsZ?=
 =?iso-8859-1?Q?Xml6E5v7kdu9VPkz1hUx01INI/wsliJ6xGvs7l9DVkfBKvciWFbUX+XGMw?=
 =?iso-8859-1?Q?tQJRYjT7wvgNrmJByPUz4OY1iLcS/4TgXXCdKKo28xiUvNy0X5fqf0RIHG?=
 =?iso-8859-1?Q?lJLo6GQ7wFZlkmzKJ+9e7aOAqtRU/+kqgpglfcojgVOOlAy2vmBL7nxiue?=
 =?iso-8859-1?Q?47EL89VkV68VJKKDmnw5T7cUM1wIudfuJpTSrQWQy8Bt8L1S4nVw+t8CZv?=
 =?iso-8859-1?Q?qlZcWFanl0J2/LForZhpS1rvKBSiDk4S3o2mGZ0roSuudOjQ2Gef006cif?=
 =?iso-8859-1?Q?MIYo8uSdWSK/hsk0o7A1Fy0X0CYP/X/iwqGRlK1BVhWTVAqdtOxfhBkfFe?=
 =?iso-8859-1?Q?pOgY9d7VFtuUqyyqsszbpF77nz/DCU8xyqUJ4unU19xAL/uqrP0EisRikR?=
 =?iso-8859-1?Q?FPdWqP3OEZRzBnmFdqDn4QrYgu4KKYZ+CSapO7ybEcYVUXSt9xX3nHyDEe?=
 =?iso-8859-1?Q?ALY5l62+G+/4xlB6Kw+9gKbzWgC+J8srXMtwOtdBwrBTeXNvdVeGttz9wo?=
 =?iso-8859-1?Q?TBuC5axLolQ6MsS/hyewrWxCPc9FCanILrwLtlw3cignUJ/X21LRp1E5kv?=
 =?iso-8859-1?Q?NzcqVm1OeLtK8nDz20gotE0NXOhnjJVnADcv/+q0QFRqb2t2wayjKZXXyG?=
 =?iso-8859-1?Q?v7To3bVGTG2iRCcz0nIXkIkGHclLIpQP3okXf8omCRrmhQn5rv598+a2Rz?=
 =?iso-8859-1?Q?GFpWMkkrwm1zrwaOODFZZ1Z5QbdB3Ywc6kBuPM2lGnMI0PU3iJkesN10mt?=
 =?iso-8859-1?Q?/tJ1rslfmwf9KRmbM2DcEs9vNhF/NHiBVZCiwfKr1DMViKrtwv+oYf5lV7?=
 =?iso-8859-1?Q?Z4uoKq2L/Oyd1GIy6ysVQQ2s2Q7uMxgTrn1iZymnxTN76NNVGCWy4hHy34?=
 =?iso-8859-1?Q?i8z2CoJVKsk0das2R/IOwCmG3vKBEUpXkiUeSrc0WOsTx7GzvJA5jHzKrt?=
 =?iso-8859-1?Q?XF2NAoS+nwKzYi4+6fEtSJufzXcYCH+czBsMCJ2OdUubcNnd4cAxUL9web?=
 =?iso-8859-1?Q?cTMu1yzcd1fpxoyytdtzs2l2YGhcaStrs1+QeT+U3R5/UfJRhXQg5tO/GY?=
 =?iso-8859-1?Q?EGhTfk+j1xuRHpnYcDguq5w8j7HY+86NvBlnP4urdpPLEIHNpUUnVznMYN?=
 =?iso-8859-1?Q?YRxmudofamOhDJJOa6AW0XyerT7i1NK2wfI1FNbxNelH2pOociVAcRHWEE?=
 =?iso-8859-1?Q?Qs3L1hxPMe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15968c9a-641c-4b82-49b8-08d90a5b863d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:26.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DR51K9hdz+8lR9mpvOAT5BytAfw4HL0XyW5SDnvDILDOrOIXZzwkWGw5boFgZVT5BhbmKxf2w8BUsgARXzNT3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: E8ZQxysg2UJMhDcqd-jPzvty6AQEpu6h
X-Proofpoint-GUID: E8ZQxysg2UJMhDcqd-jPzvty6AQEpu6h
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64ada9e650a5..0272c9466502 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5666,7 +5666,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, -1, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -5964,9 +5964,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
-			NULL);
-
+	walk_page_range(mc.mm, 0, -1, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
--=20
2.30.2
