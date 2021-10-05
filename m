Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DCE421BFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhJEBfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55782 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231739AbhJEBdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:42 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19508Mde004481;
        Tue, 5 Oct 2021 01:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RhRtWCLFuf/IjKzlpC9PkvRZhp3YFOKb5O1vM858NFQ=;
 b=yQ6HQtpDQaRbcsv9/dPWov743wm0GhmFbbUz9nirUBuWOErAO82l2gW8bXhMGxRnK0OL
 MYmBklTowlrRoJDlVI2nryAg2SSMzWZIsNu1KJ+NgtRx+TreMUWhWgx4yT85rvUAFDZB
 /mZs61fBtsmh7+XQU3nAG186uN/uYkMnH6jM98USxYw6pCHXusgprv5sGm28eznP3CCg
 mu9tjwwEv+hkSY24bTA1F1my3qk3v+YVdi/YonY7ajLAJGfVCsP/Idul88pYZK7yqgkk
 DjCDjNH2BoiZGn++noZkKpxh9X3XnRGt9egE5fT/fZzQ75BS2n/rEoH9Vsp3IdRG+hME dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdG0141646;
        Tue, 5 Oct 2021 01:30:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXW3rBU4X1UmuaVs3hhKZy80aYRAOvvH1TfwBvHBuvDy/J3u2syzcJ/EGcbxQ2mA/tFS/Cs6Yg3T9wGmB9pDVDFlDt/27DV4v8dm8wTT72IJonpn28lZ1n7LDp6EUPQpL7/tgtu3fbweSaLrYj6/IlkPHX8NQoCTscCfr56c2E39J0dZKDjddVABIqbvYudAYBUwVjkqv8lND/r+CZV39PLc7s4jEG8Tz/f9ABOnOU7EJL3gK0vElNsgfmlHCcDkMgv2k1TVHKqXbBv4EMc1/wAHcWY27injnILGcbDxfzMqwOfjENjziuLdkdgvcNKE/KC7tuasL+aofjCJTD936Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhRtWCLFuf/IjKzlpC9PkvRZhp3YFOKb5O1vM858NFQ=;
 b=ESeyPCEIGG+JNnCy/KJR0/GWhXx5WXnZDK0WFtgBSbAZsRbKld8MhNtYbH3jcp+pz75nU07NRCFDyIWFOXqdEpoAG/pAQHmYIn+x0BAOJXZ1Yhqa77ZrufGicPuB70QqYb67E/GyOOc2uAQZ7kvwNnP9TDOB/R2jPR0IzifSJHYwiOHjWSt9/0OSy6wSzLKUKnOR+I8KbHOP5ZdEdnS8HFf9RWZKcOm/yveFeyOey5d5dXucEyuAOqZSnD0Zk9jI6EoBqv/33B6ttHpuVj8CCVUw2dagOX/VfJGH1TDLBeVrLP1ZaWdBYxzqo6RA/axkxt+TIMKA2rP0FXkmFsIHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhRtWCLFuf/IjKzlpC9PkvRZhp3YFOKb5O1vM858NFQ=;
 b=voaFRLIQFSqiCaJD9KPR3yTvVwyFKcAZXjxV7romO+xRRVsF4LU5OYxxKi6XQa5xn7TU0rodcGc1NjbY0wHZQ6uA5+G5j2Z+LbALvOBvA9yxOwku4/gHKq21FVnynWAgOpZCYrR6C5hBfuB+U6iDRcChUuPc+49Gx5RVC1tIETU=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:37 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:37 +0000
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
Subject: [PATCH v3 15/66] mm/khugepaged: Optimize collapse_pte_mapped_thp() by
 using vma_lookup()
Thread-Topic: [PATCH v3 15/66] mm/khugepaged: Optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHXuYiZfye87b8RQU6Zh6yYK1qXOQ==
Date:   Tue, 5 Oct 2021 01:30:37 +0000
Message-ID: <20211005012959.1110504-16-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: c762357e-8976-43b4-30cb-08d9879fbc24
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50441512A05C0CAA21D6502EFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1eiSqmWRhN0dvo16FMYwddN3XzdgSRoNB+XeKqOKGb7HXgU15f9Af5e6ZoL5PuA4Luz1em3Pb5MEM2OqLVlE7yeCuVEq4fxB4GGUWIH1nZUWrt3kNhhUx9wKxg8IMa05JooOShrtPdn/3ZNW1DMqMY/nueGwqthh+MY+b68MCZHiJnOQld1MIepjcrcfmOjEMeaLpE8SSd4gqdWq8SlADnLq5dfKTVockboPS453J2mJgsDeSN4YHzQqC492NBSHElzSoes3VVWHQCyVmLNv+vmQrB/nhZuxzOoGhkJnIyjSQoPRgXkfKH/v6kLg0lNY9Uyk8JC6WwrCI54fax66aFzlkQFfOZm8DPnIOCLF9pCGfGzATNKXyPzTTwEL7eu7IojbvGtyeBdrDWyTg/Xwx5Mh2xxjlSNyzQQbe4jdtq8aFQ/YSMbNP0tKQH9b58H0dDdEB30gg0s1lhUZ2Wg0ZR21FZ83GQnKncYc7Ha8sFMeao1HXIfzWWu5qe8YVNU+PayCkqQjvozx3gfjBns5dAsg5nh6/wQgUcjqigJJiNGrl9mSgRB1wdMTxte6xQndCGgCqB+5FFKmL+bxU8smdmpdl/RhSUlAkqBFUQH9wSfPYuAt937tPY4CoVQgLgmf7rMxJDUEGH0h+Nv+o2SCHT6jxC7Y7RN8gA38XOghrWs6g1VjJ+5DNyhFg9EzfvzxFd8FMF6vaGU7DLcLr3DUAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(4744005)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AkVte0HrPInQ/3NsyiwFbmVWzmZtXrwUwJ5ZzD5m+YrXsfH/gBNrp1JHag?=
 =?iso-8859-1?Q?66b2DjoTjeMfnHpe6KaDbGp4Xl4goyLNjSXe9JgenByp9OZO+dPpHO8XwU?=
 =?iso-8859-1?Q?hyIpt6p/BrvPwMzwK3hYaYAw6SA0KBPadRfLkzEUSt/Beqjtmg27QFjhj2?=
 =?iso-8859-1?Q?3BIVgoVJj5AG1UCCAe01IUoCF9rJ69hyXW2X1wBKtlgimO6aXZVM3Ng9uU?=
 =?iso-8859-1?Q?2T42j0LRLEOJ1v7VnE0YTyOOc4Yh8aBjaK7ZmTBPG+BfBBTr9Pg490xfrT?=
 =?iso-8859-1?Q?CwVJMbm++vhxR628nlfmJIBXn4dA8N2wRyANbbeXK1KvtfcjjiNUmTyRp2?=
 =?iso-8859-1?Q?GWiymV+vi31S86GiPHwx3LGHFrOiJ0nX8hy3BbJ0r3Yqt8+namufW8F/k1?=
 =?iso-8859-1?Q?jiQ8Ro6afZ7WKXi79oIpmMDZyfam262yW9oxjRZGU1k3A/47DDo+wlQNF1?=
 =?iso-8859-1?Q?QcDd25Thx06NDo1+rX79TAS0NqWzCuhAAg46uHoh31SxZA0FLmJ7wBnrzl?=
 =?iso-8859-1?Q?gQAKHMHHzJqoLVTAzf3RP7kKOcKryDuZq3ZsDGb2ggLs510tpR366FGtpK?=
 =?iso-8859-1?Q?1etvplzVEJGRpbUC2fFIudBvDKDG6xgia+ahlPYCHoh6Q2fO6BUtBvhw4S?=
 =?iso-8859-1?Q?xVHSjpEdsLzH95IXkusPzeW89BCAEfeUjQMDbxSCSGvH5CrTD+6vGq88um?=
 =?iso-8859-1?Q?okb7pyDF9ZZT4agogZcXTGaeodLOEGtW9VV4pbNY0G7cMmEH1JtvX5Ygmp?=
 =?iso-8859-1?Q?iEcM8RpA7Lj9SbkX4uwKHdTQXgUaUyWnyfYA7nymNYjjKtpkT/w8a94dfu?=
 =?iso-8859-1?Q?i0IJNddMMbiquGBPLor560k8wRhZbNKs1W+wyhC8ikLVqDMd1muS3nTl7K?=
 =?iso-8859-1?Q?VQL557GOqdkijwstHN+mL4mttQa5wbERxKl00wKCm6W692Pj0EqBuyFXTU?=
 =?iso-8859-1?Q?gLi/3JWo/16g1opP765uCDTpHR/VSsZO+AND4HVm/XNI9PcbKhjj4Rls4l?=
 =?iso-8859-1?Q?OrUa6s2YFSSz50D+InKkFlkAIX22fdLYjhL6G9EDNSpmtypElnZfpUCrlI?=
 =?iso-8859-1?Q?BZFX6THYBSbPjdaqCsFWGSqe/WuTuJjrcbkzhRhXeHIDOkJzX6LgEWTAhz?=
 =?iso-8859-1?Q?gTxPJOOUk+bTIuJT2gZHW1gL78i8fcxu8s35qXKXKvsJbh0tu4TbtzMNgD?=
 =?iso-8859-1?Q?0utUoVWWxqNnNsjEKA+3IXQk1oC5dLCTS7nmzqbB3QVTJPCrjUpNTsevMb?=
 =?iso-8859-1?Q?ulWDH/1R9vU1eOyxckIHEqZ8EQzM4P5oUkcv2G3fN/NK+FSWPdMwD9v8GF?=
 =?iso-8859-1?Q?WWoRhWwBjoBHp9+CLd+14KPMzdeACxli3MOUr7mBpR+v7gGrog/kdFnYw/?=
 =?iso-8859-1?Q?WoLu8J/J9i?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c762357e-8976-43b4-30cb-08d9879fbc24
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:37.4434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IyiWWnoftEQstVsyCtOh2lf2eNgSSTIYZ3D9W0SVqoP1Z4GRpFHpx0ap/07dqk80Uih/3H9AhEFmiQif6UiJWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=842 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-GUID: TF-Omg7vV-kOAiNjTtfAk5ht09WBb4_j
X-Proofpoint-ORIG-GUID: TF-Omg7vV-kOAiNjTtfAk5ht09WBb4_j
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() will walk the vma tree once and not continue to look for
the next vma.  Since the exact vma is checked below, this is a more
optimal way of searching.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 045cc579f724..f27673c596d2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1430,7 +1430,7 @@ static int khugepaged_add_pte_mapped_thp(struct mm_st=
ruct *mm,
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
-	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd, _pmd;
--=20
2.30.2
