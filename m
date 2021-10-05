Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48EC421BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhJEBeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53976 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231688AbhJEBdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:41 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19508FaD004511;
        Tue, 5 Oct 2021 01:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kUiEckR6EEySlyhV+g4vK9p9TrqI8+NYjXrdZVd3NLI=;
 b=VAe5fqtxrmF3FOfz06Woh4xgwRfxgcmFDMsQybiZpInngzreAwnB0+7s3IlVlIj5pZY6
 Zn5dbQ9JT14scNa5lnFVMLC/MVvYjG2xmRedI2ECZPUcA1hdu/zlblOFyOxAVHJvfn9V
 FWfBVOfj/zaiIKazZ4blhbO0ozUQrGF0pHhEFJ6PB2pkRbzeu/PqvMsY8h8smHnyJ88S
 tYnIUDoEpNw2iYqSqQ5fu7zYcaCNQw2mWMqk4B1N/Qs3eoxApObni7EO1jwk3Vykx0aA
 3L+vjKvtam8qpsdBFTgr5MJ36QJdKu8fWhKYN9Ped65KfAEv2iR6cbfcEbptI5u5raJ7 HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdG6141646;
        Tue, 5 Oct 2021 01:30:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVq4MygUjzVAM8iKXQ5KNpYCyPCfeSQfbjGiTRgaWmwXHjq52HpFciLy+tCp0jWHnrKsW8xt0V3keRBZRrrsIm/cY2FZcGnrwRQX9xOLzp4NW7d3jXQv0YjUB0pe1lTVw76T8po1nESVphg+SpUSsmV8Kp2Iy9ap64ozosFf3m+OiwSgBHB6zlXliz4SyVag6+XH7m7m3Pp1ofGED3hRC51cpP5xEEQZSDn6xVT92ueMs/R7JFhQv2kWYY/ogK52htsC8u5YWCsaaTTlIccAhuIAKGHG3HAInYpU1Podhok4eAKOQOIHx98leqlQpEba7a9h8tAcxtRiOSJmxV73qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUiEckR6EEySlyhV+g4vK9p9TrqI8+NYjXrdZVd3NLI=;
 b=WIGUY7tpMV8LtX+ECwNQVqd11byZbBAhltcxmL9BDu/psoKPkO6CIXqNDkOKfVUqkluLdbTehnkFXz6qlVGAvIl54PrJ6oisaHKVWwlOrd8jHMcGkGWTPlHa/FUKFaiycXvQGGMZ1NhesxlGDsfRPV7aS3d6v8oc0BTV8C5d2tlSULsHUth1gWaTWB0ohGBFZ/YsFjvOOepIaEOOMJtk5dfV4UYHun0h5O+sjrQNBxW0Rxj+nnMefIbOU/LqlOYCapiwAhL77/OCK+/X6jTF9IGxKZNJzOdzUuptIdrSm17zCdkliPXhXP3VB7hVBwCfYV64l2hBCe9LZjdNjTuDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUiEckR6EEySlyhV+g4vK9p9TrqI8+NYjXrdZVd3NLI=;
 b=kz2CqBbB13ARcUDMFKcvy+GwcJXnpc+cfopiVTykTFqNdDRvQeFE6HduRFxvTvLH4f4V1Ppe782lWxqUnpSMaIr+TP025MqesojqRxxKymMuEeNY8cqXxYeW6yRzmMeCOzryoNphQefLO1C/+vAPJYsUX+631dKepedQKlzkZVM=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:46 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:46 +0000
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
Subject: [PATCH v3 23/66] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v3 23/66] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHXuYieZ8Fo1p7OikOJegMnHJ/mPw==
Date:   Tue, 5 Oct 2021 01:30:46 +0000
Message-ID: <20211005012959.1110504-24-Liam.Howlett@oracle.com>
References: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffdf753b-6b5d-4e6d-c672-08d9879fc166
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB504413B99C28072AA229558AFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ByaK5q1Q7VNv13JVW4G9HdwMtiWLcczuqIsyMAztmwCdBNq5TyAHx8tMl5PfnSkzEPewJXqfNHjBKVuCBe9lMatMU9XfAF3Fc8LJmvSDbEnFhiMa4Wqm9JK7fZTAzowLjPjF9vq/UKUcWykTuueloVC5qGlfHWZsXq+2rKb9mjz3KGCy8v3+r2m6YozM0wSjEyvs3tfI5FSuS1H6si7MxduHeA/JVocfTl9Aola3UEuTu6Wy5LBr49gZxnJbhT+MlT+IEjBzanEBBoNWdnpKFCKpnLaPd+HT//HEjX+I/G7YuwvNq9ju2Ukh3oxjSmh5gwIeC2bixfFc82bqtJWHSQ3Zz5O+RExoEfWEEdOjU75eUY/lUboyTFF0sj2ScOofBt8ujDLhnEBkThJGo4ojxMpNzIIh+Kkh0A8urLQ2PN9E4j2ZKJSQXtzILOaNIz1jbPiHECxb+ipuimt5lw3OENH+R4OogF3f8LhaHVLM+WVvxuH8iVXzrAaEBFVkeILw4fXGt2vsCgbxQdxBFEV8WR6Nhg7H8NT5jPjx1rJ8oDVCfCtVlSx08r5UshnPogpQO7dfT0JcXQUtpyqtQG2jUMgvMtKq+3hiv/0b/PPP9y0GHTkik35JN6q1WpMUULAFMtcHBOpXlguku45xuxi5RH9l504IAV5cwaNJZkR7ynM8+IdAqiyODU4Um2PWANA4bzhPxNPSwQK6xmL2LKToyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A4hUpdxut9BWub3V/7YgrnojfUxxfJU8NsNSv78eHSlPkkvEFtO5BWcL3D?=
 =?iso-8859-1?Q?oaH99F4IjnCJe6pX4wRT7cEFcurB+ldM6qcNMT/oVOCp23zKLBICMsThVH?=
 =?iso-8859-1?Q?s4xhiXOH3KIjU0hB+n89FvN9x02oZiivbWx3WtzxEN9lPrNX5JKi0PuAOd?=
 =?iso-8859-1?Q?GAZI6r8FPI+99fJi4ra7yHddAeGNSJL4AKEa2zk/7gFTHIbaoeQ7WniiQh?=
 =?iso-8859-1?Q?X+G7x/owOP7xT9epv4XF4dfjnwDfH8GfKRSuPCEHVqP/09vrUnaMp7jtbk?=
 =?iso-8859-1?Q?Wsjyv1EJqr5D+yFtwOcIjyeto5zutIq+lU7rw81A4Qvp91so0UMfRRbSKr?=
 =?iso-8859-1?Q?YDTOCAjG6etvC/FNMpY6UNjAs5bhe/dJXYJ+/VyX/fWSg6GTgTWtaTDXWO?=
 =?iso-8859-1?Q?dFHy5H4GQYSmjv2OUHwKl/g5D2Cpp/5Ta/U2MdkNgtCpKXQZeUlKtaLmb/?=
 =?iso-8859-1?Q?F6md50PTavL3/qtqfrkgk6ySB+3KqGJDOYgRv2XqeUWY0UBFhioc+Ecq11?=
 =?iso-8859-1?Q?1MfUmlyblSlw2LRGUNWO6U26fZtlwJiK5GCOGf5PlVICITzNJl0eoWfzg+?=
 =?iso-8859-1?Q?TLWUz/OjasMpCxYlJTTwpff0I4eXjftb2QqmFzMZ/r2Wb97/VOomfcpV78?=
 =?iso-8859-1?Q?kqmT/YNyPw26cdjRRp3aOH2Ht0JFFbcLzpusJvr3e3tZYE/Pst/rjYAymQ?=
 =?iso-8859-1?Q?LmgaZX4GTnJPfngYLmF1YsASNnVYGHxx9tlLNwXQbaBcbjWTuaLPZ5wAh0?=
 =?iso-8859-1?Q?n9fRrZITnEv2p6CkkSP/YNNhQZn33FtbYfDHW6pnFHF+533n92CQf4Dp1p?=
 =?iso-8859-1?Q?3HEzvofDJ0fP7k0+1EIwLCWqaQXHW30S7yFCWJEj0sxLFt+9l+RWNl34aZ?=
 =?iso-8859-1?Q?ZszLQ67e/zAW5It4GIHW7RHsVK+kJlf76oMIMMiQSYmAhXmNY7HY37Jz1M?=
 =?iso-8859-1?Q?WmPXE/RWz0hc1dBaxKibV+LjFeiIr0xWs4S2S2hNS6MTdilGgF+RnpGUGW?=
 =?iso-8859-1?Q?30KRb6fChwO/kTr/BI50efnsxWYS6eFUkkQ/+QYdVfdsWMgsRkt1JJCR2o?=
 =?iso-8859-1?Q?ezMiJYICNurZYNFEX62/XTxRR1Eox1sIM5Y4HYjwvANjpWRwSC1sub0I+F?=
 =?iso-8859-1?Q?RKrqBU2w5314aafHJGHALq5pP3T5tDaucv4CSn4JAixsdphe5PmEoa6pHA?=
 =?iso-8859-1?Q?VGw5Q+dk2tF7+xJoXLkVuY1txhP2Wc28w4epelMrPqAiwtkxZKRHeJHnkz?=
 =?iso-8859-1?Q?7tRyCDRdf7bKQh6aCLlN9Lb4EWanUQT1+DcfhNjI0MkM6j6K0lAYsGuYlM?=
 =?iso-8859-1?Q?SWKGymtvtWC8ESPg5Fcg+1CyqOh5Xj7MFHdHUypy0vY03u/5Jv9y9MWXD0?=
 =?iso-8859-1?Q?JfO/tKO/pR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdf753b-6b5d-4e6d-c672-08d9879fc166
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:46.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7lR4xpxEltyY4BHul1SqkrK1iR6w0niZaaZTNcTPnHANjYt+ObjRrJ3+hdVQzBzsFhMyunZZbesOAGlHCXwOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-GUID: a-FkpSLlwuicYCJwEjxIIAFW_yVK9haw
X-Proofpoint-ORIG-GUID: a-FkpSLlwuicYCJwEjxIIAFW_yVK9haw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

do_brk_munmap() has already aligned the address and has a maple tree
state to be used.  Use the new do_mas_align_munmap() to avoid
unnecessary alignment and error checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 25fcdf2ff739..56da5a23e293 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3009,13 +3009,16 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct unmap;
 	unsigned long unmap_pages;
-	int ret =3D 1;
+	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
=20
-	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
+	if (likely((vma->vm_end < oldbrk) ||
+		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+		// remove entire mapping(s)
 		mas_lock(mas);
-		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
+					  true);
 		if (ret !=3D 1)
 			mas_unlock(mas);
 		goto munmap_full_vma;
--=20
2.30.2
