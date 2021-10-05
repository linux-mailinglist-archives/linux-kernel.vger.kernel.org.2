Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BD6421C1C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhJEBhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:37:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32626 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232772AbhJEBeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:17 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19508FaR004511;
        Tue, 5 Oct 2021 01:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=y0ZQvZ4Xn3sPJJeqqMBOrXGrsWGvvGbdveSIxKMztnw=;
 b=aa9uZcFMvWjKae5cWStxyOHXPb1CKfR0/K4WWDR6sPT6BcnMT6COSC5sa41ZRa1LNKvm
 Su6aV1s41iwvS8pNnQggbDSMZKbChHolyfrwO69EYvuBkkZ3sHA3LVHwf3Fa1KJSaZRE
 /3RGuC53uBAqnp9FReGRhHncL3rDuPVMMrgbqMFabLv90Ehsu1i6Aj2aDsIdD/D3rGov
 ymj03ikY9ChrEJLnnQPaBFLKxpa5B60EAV00WKTKi0LXYVisZ+05sPOKrAhmLJrvY7cf
 FaGkIVbFdRnZFRYUQhbGPJqWY4yz+0pgHjtxr1P6SH49M+FN/binTML+hG4xxMf6zjnb Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3k056799;
        Tue, 5 Oct 2021 01:31:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clUcRSeSVIhudNhJyQksI9bdfNJIGt+UcWky10rBHYPf4BXuE95sWccY7ffp59GWa5d1iNUBOQMPcrmlXPnekKXGuKiFRPr4lc1gEvjP8vXfGD/5XClREixH2lOL8wnInYxA9QXhK+ptyAgOU5R/qOqR8p2Z971lv9uiXItGGtkSs9HlH2enI+YzRjnAnEIuJ/eUsBxrWydZBRLCxiiNlk/8Kt/sScR4Uw9aH2cqV3TurulB7z8sUe21wv5sZESBd9LOIDqP0JmopMiYbX7+N2Dij4BsHg576Zl9H33ICXAzatbED8e9vy30AtdRb34I/HoE/tVlA9XGxsY7b5iUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0ZQvZ4Xn3sPJJeqqMBOrXGrsWGvvGbdveSIxKMztnw=;
 b=EmBUItOpUi2iqdgW8tPkmE1THlojXuEAERat/NPrj6+zfSqn+maMdyvDUztOSrTeNfo3j76xrtpekTtlSj7lXZeT0Oi7BunvtERsMtEKW1EBqwAsQzU9E9Iur7Bj9ViTsY5D4LI9l5kB1rUWsxtWfI6hD1shyqU0PYYhMloaoke9WrSj76J9cKkeX5cOxUt6seslZVnJxkLc/9Iq0DRMLEwuWkp6fAtfSKoGEHMScPpkp8kDkjs6y/0m5yEF3aBnfKLpEoObByBMlckrUWP29TwQMzH71xpPA2ah/wBk4g7OGmEv9GyPQsVLnd2riTIieW+96UWG8LEqR1tNeNxRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0ZQvZ4Xn3sPJJeqqMBOrXGrsWGvvGbdveSIxKMztnw=;
 b=Q7aEDGBdDXrkxpB7w4JCHJ4IrrU/Kv1jFGadC1sYmD62D4mPryJGZQgQT+WLJ8EEPFYyrhu3wKddty0HCSaF6DE1fFzQVqjBMMAK5K+8hVrFtP5zOziWqEDJt2GEnKhTYCWaP7CdxLqhwY5WIKwQGJktfy6W7TeVNQIKa5eSqE0=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:20 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:20 +0000
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
Subject: [PATCH v3 33/66] drivers/tee/optee: Use maple tree iterators for
 __check_mem_type()
Thread-Topic: [PATCH v3 33/66] drivers/tee/optee: Use maple tree iterators for
 __check_mem_type()
Thread-Index: AQHXuYih3D0A8efHNUG/VTJakzWchA==
Date:   Tue, 5 Oct 2021 01:30:50 +0000
Message-ID: <20211005012959.1110504-34-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 49e94cc4-8e20-430b-9124-08d9879fd600
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50447DA9303495D3FC6BAF72FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FPteeB3D754W2R6OJm68sTzq7W5z/QD/ZYs8xIFCCR1eXLHeHc69Jgv7EH5TeXaumqJGctgQ6UkGSJQfB1tA8hv6jNuIygYnwHCzyhcctQ0IHRRLCrDd7gjP1UT6L9ymNQD/c7Jk9kCgG5A6B2KzGXgq/A9+9S73TvjEFJ6H+Vao1O/YqMFRyEyhh3nu92EfxKNt/FDHskREs5OOxpCM87F2ZMoZC0ftzcYDOuwaiGln5BQarBJtOPtg8JYMtlHFqjXq4SiESlWE4BNjPMrusbLvVJ7ll1SUf+IiY/kEkOLKJxfj5xjabYzELcLBInnESZK8vM8kqFJgpGrSfnjureTfrSsPLyLH9rdb8EknBXaXt3QS0+cSeceVb3J5+uL70ilfn8cBaMLzy8juozb94J2Ek2+CDxekymlNXYdGrNjBHCBv0jCUCwEXJ/Oyrgouy0VI/bX8zOIA6NwKb4+KR4K8Ph96j1c0UPPF95KqH91u6i+Ndsm2SDt9sJwXuBENSSsJF3VPAwx2NmIUifvPcDjeCQLSKk5gUmehSV6UTwTxvuoC2rfK4pGR+qU57twoVW4XUYo6g2zulVXSb8RHTRujP2CrQR47rYf6uwE85JHqnZUP0l2uWB+NlgpqTAg/RTAmLsC0s/EXaXhaSr/SYRp70Qs2/kpdeRNpGRRBQ573VFpU5T25t7UJKH7CO/m71IQ2e0aTHG2YKzsgRFDwYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(4744005)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RAnCs63IEolRl3hvWDWYInhx56anTLJyP+SKFvjQI9N0C4WMs5nmZNcXsy?=
 =?iso-8859-1?Q?Ee19jciEex5tszs5tZmskRZe2Ayxk6Nq4rpOLceF5qYydbXSpnpxTeODTZ?=
 =?iso-8859-1?Q?+Fg5EZytNLtDWUoB2joAmfJk5bxGah0rckJAu9yCloZAECmYbnB+T0a3A2?=
 =?iso-8859-1?Q?sA68dJUsmMHuMmxhBkaqOMskCB02sOVH4tijSIxCk6YF2h+1TnHgbkP63o?=
 =?iso-8859-1?Q?9Y0vlcDEB5zvdIGTsSYqi+34RtdXqkY/r/H4Vem2OCFKw9GJ5lIDrpDoQi?=
 =?iso-8859-1?Q?FQaQGqbDKYXILjdCCp6OUGwJIe6ErKyTIIGCMynIVdHyTUE57P1aCCmiga?=
 =?iso-8859-1?Q?1ztUXjvP9f/0+/sQoztzNzbhCLLAkBstjSvtTGEY9mq7UL3GmFv7Kii8iT?=
 =?iso-8859-1?Q?hphMuikSImwIstOk4+dx8F3HQCg+riOg+uBim1iBtCjXh0YZrK+gmOQCIS?=
 =?iso-8859-1?Q?cwuCToWKFzKkLLswTkvNE/oZczhckdw0KjkALXeG9J8hEBvvT2LATdCyuk?=
 =?iso-8859-1?Q?m4TWuSFsCz5gNwC+7u1F/JA668xr6w3xHbU/+31JMoGeWp1HLPUoBB0NW1?=
 =?iso-8859-1?Q?TynMKuC6WD54nhDuSDZp4lp9yUJWn7FM9dbKxUtzWu7TAw4rgHyo94YBdq?=
 =?iso-8859-1?Q?zfrWsXKXk9Ql9s/OHAqiwAjqLxtVSa+jMUNoA2GHhgGxkAnBMLev2PwpD9?=
 =?iso-8859-1?Q?JHYUTJ1ii6naajQCo5CJMR7mhwJrJM6H6sAo8C8h72/mo5NeshYjr/vs0B?=
 =?iso-8859-1?Q?0pMMCo/fXjZpbi8g4J6DqtpoEzXS/R3sBaa3vZVKIBn+kcE2f1ijYsZrdU?=
 =?iso-8859-1?Q?WFyewn8ou2RezTuNHfsFTZ/zwrGmHFxTPwIUCzAJRb/M/jnrub/Q7mMW0u?=
 =?iso-8859-1?Q?wXNf41KK9vLMDOyQTQxZ8Ytm6/FjgTA4FbuH2ZPN/FCm6CTpnoTs4P2Qva?=
 =?iso-8859-1?Q?+ROxTKkw8nAeBnZTlY9bSvZkG+LR5XwBXmIiLOiLv/TyQO133obeth1SMx?=
 =?iso-8859-1?Q?lki6hLlx8laHO4WWysvai8JhJyr3lBcsi5i9PjvqZT6y+tK2sEGJbymbDs?=
 =?iso-8859-1?Q?G8EsRI8hQiKtrnsP465yQFQBB2h2M0K3R2BNUyxwBVf9qc1KuUjdH45aOG?=
 =?iso-8859-1?Q?zeWbgH3IO2pqTmIxdy8D0DStfv/gpBBQINIgQz6NOUGAiBtedo4YMEtMO2?=
 =?iso-8859-1?Q?ZuNwQhQDh9BDeEUxQN3OCKZWIQctK/nqvdY/RVhmT3IX3J27HRv0I9JdM1?=
 =?iso-8859-1?Q?L/h1JjUZKz44nKwbyn7TBABrTB3lwFxHymBeF0kCZ9RjN/L7fbNQh18/v1?=
 =?iso-8859-1?Q?kFipBYdtOyTR13Iqv+sCPLjo0pE9Gdo6MUsJGFETO3dPobEfKJQPlZUR0f?=
 =?iso-8859-1?Q?oMEfmmyeOr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e94cc4-8e20-430b-9124-08d9879fd600
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:50.4340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8gLGODZqnnL65+QqdAq+cCTS1R1vtMHNEW/uRrwcO+aIMaMn1Ob6zwSckKfhgR5186n21kPCe+5pAicBSdeAiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: 9TU6TS69197eViNjA9d4p2yzHDr57OJj
X-Proofpoint-ORIG-GUID: 9TU6TS69197eViNjA9d4p2yzHDr57OJj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/tee/optee/call.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 945f03da0223..071ff5d9c059 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -582,11 +582,18 @@ static bool is_normal_memory(pgprot_t p)
=20
 static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_start, vma->vm_start);
+
+
+	rcu_read_lock();
+	mas_for_each(&mas, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+		    break;
 	}
+	rcu_read_unlock();
+
+	if (!vma)
+		return 0;
=20
 	return -EINVAL;
 }
--=20
2.30.2
