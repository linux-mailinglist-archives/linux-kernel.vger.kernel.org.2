Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED358421C03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhJEBfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3286 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232137AbhJEBdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:52 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19508Mdq004481;
        Tue, 5 Oct 2021 01:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cdxTr/4wZGvSNvNGJmWUPSav5cHPr8YVCcTtWirbX9o=;
 b=UleLUtfKrOyAI5GFgkWSa3UQ7Ifwgah+vFfkThD6k5cCujavg/UmHM77RTfTTqTEMv+B
 CyBr0eJh3xOKZ50iorBFeyDdLILbLJdrAx3TWRM0XV47wcp6spL9IJzjWvH1XsIHljpC
 mxzQ0DSOFAvM1bqJ8pjVo2mttEWd9eCLoe0NCu0Str9blhuag6/q3m53HQZAQ4iiJ0da
 0qPSqoYKjWaGIlP5hHnaXfZ7GzYRABDyP8UA5D59ITYE4CnjWhiHhgSAbBky1kBfZUvp
 yjzGMUZc47cgg7UEVvMCvg84RBJKcBJOawxOrBHPjtZqrjlzGbNx5iQqB42WXLHavchF Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UICl178521;
        Tue, 5 Oct 2021 01:31:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 3bev8w03ek-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZrsY257lI3tHSZ8EdSzqi3dNftHNMQXf9LlqGI+gXkuE2Icad1LTN1QYolMcDPF+4z9NEQtGUOeRAdUDjr/S+R7ng0LkRL+cQSQAOkzFz1o82xNeDm1FwUd/5G3/PGXH+Fg4h+OmD3fU9OZ49zuAz7Ay5wbL2ELXbmirrnay6VHkfNXN40HELEQKArTXre7qcTWs1RiP4avUbd5nvtTeaQn6YOUC64K/DayCjlsBvOPLOrpc9qilj8R5Xs3LNq4EvC71SACH6oGgLL4d6B+IzOkWNBEzDPQFZdTARnabPJZKu24n4RSciglLMAZEAGC6oD2oEDsV+AxMewEVMSiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdxTr/4wZGvSNvNGJmWUPSav5cHPr8YVCcTtWirbX9o=;
 b=JYGEvkt86SnywRBbq9cauNOKAb+fsDttZctgGWWhuPx38YdYyqm1agwGLffwFEFsEKz8tJW+wIGSK5rIq0Cf6VfO2As8GH3koer39qg7zlYo5Dl8A06NalIiGciZmx6iktFivKXW1QhUCleUUAfsr/sGg79R2eKYh5tJA0dGseKRRXUPOJCsX+yw0yIY34VRSRrBeJdJCidSjY21I9rfC5jk2ypwTiuMWA5aT7XAtnlZC357S60U6d3qk251ofZiInnpwFcATI6s4TIj8i6YiXneMunAtlr3Eq9AeruXrKoMAdRWTKMLurvk64inHDEJ50MODpmeVere7nbMlL6OUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdxTr/4wZGvSNvNGJmWUPSav5cHPr8YVCcTtWirbX9o=;
 b=AZMnBaPzucBYpmlAiq2BQ9+AQqm6MrK5iCR+XJGN0/pRmvNGDcvU4bhW7D1cC8nm3Izuk6NcxBZuFrLhe0vrdS779+rz0tkR0SSFUPs7amaJJ2G89e74Et+g1NJg1yUP3izgNHgMMSTCX1M8z5k8pa2Wo1vcdIBLEsvv/KB/sM8=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:24 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:24 +0000
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
Subject: [PATCH v3 50/66] mm/ksm: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v3 50/66] mm/ksm: Use maple tree iterators instead of vma
 linked list
Thread-Index: AQHXuYiqXeCDqSn200+jDvcxOUgcfw==
Date:   Tue, 5 Oct 2021 01:31:05 +0000
Message-ID: <20211005012959.1110504-51-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 89843487-efee-4c04-48a1-08d9879fd860
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50440A9C42F3C2E5B3EBA554FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qIwpSj1fsbH8H4u3YPP6W/No7IWap1b+7WSDmET3W1wxIyT5QNBGb+E6XZbWa/EMBThgHb4sO2C4eGak3L3Nub2N4MBZvUyrXXBZpQfqsAAIjkV0KvzUNMrdgTrjW32y2GrJtwO/jjXqWY4D9SkShVr/eHi3KCc4FY99D34jhkw207W3A88yH9qEU3L8RYdAcVojhB037EEr9lizv5jDL8P9ps4ZsVFG0KqiC1fsqL+rObJ7+7DgeUaoqNtwxhNEjDPYS9v9tbbLzFiQcOKU4lFhjNKBmx+m+7G2/K8Y7HVnJEd05m5BVvueCC32rCeNB9YvdM4/+tVw0+GUprm5xQiDxIeCkyW0VE8gaYs8P3Gb/L1Hdf0pNTypvQYIK+2HWtcy0d7ogmwXlrk5vT3KxXQYE+UBsYAJdUTanPYN6NnZHqHlgMFP3eKxgObWjMdEXO/tovXm7AbQ7ktW9UV+KS5UeWEduciEcmcY/5wCp256Hn2StOEH0yaAAZ3Sh3c6na1njvEgPrNSI6Y4mMJnE5FU23llWb50sXLKZCOU2DVHy61XnyfdwjdpkDn0hEW6F+vu3WdYJhH6rgZHOpDRkz46awXIRWzptUr+9ti3laMYnmMEWUJJaFEwW89+HhyPAOfXo0tK2CxVH7nJIu8tkIFvedjO3LU3S0ZL85TXafT55Nlq7Qc42T5SkFcdu1pYfurPqgQixcmGB+2ZIn97yQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+c4Vwfa0p6QGPPxP6d+lwryeGF2ztWizrjYBaJefB0bTVOiD2xJhsr7a01?=
 =?iso-8859-1?Q?5dv4wOFPrTrhmnkMxT3mV4Lltu/aiw+UaWjwPsZL3VZ9PidNkyywK7BEkK?=
 =?iso-8859-1?Q?3uTJDCXAD13QZ354HK+0mv6DdPLO0zDjjulgTmaiaY4WIGJomT/PkwPXcR?=
 =?iso-8859-1?Q?7ItdiHpct6gy9c8Nkq7SRVDgLlydjUGIyVrGc3D32MufOtNTfjQXsg+50w?=
 =?iso-8859-1?Q?dMWx2vugE4slyRP416dc8zB8KGI+EMIVQd+TKqeIyH3GnzAU0SJcOZURN2?=
 =?iso-8859-1?Q?k/L4i/beuvmCG4twAzq1BmMRY3G3b7zdffd9gWi8UXwUIvcV4pPmQPkFCF?=
 =?iso-8859-1?Q?RF58iCo0JjRO5DbIO/7n8MoyaCbe3g0WSRelewcJ1dFJL7mCkJe1Nww04f?=
 =?iso-8859-1?Q?Ipv0pcvBpVwKjy7Qloitvt8QALGVRG15Ll0M2XbTGZpAPbTYmTb5zhO5Ge?=
 =?iso-8859-1?Q?24QxP5GvgIHsgQ96xkud2kIYNdMwymzi5I4LrQbaANelGBt7nMNpUgIU00?=
 =?iso-8859-1?Q?AKjqd74ZsgBRD6cCGaPSHVlinZ/dAqLwI7bkej4hsFNg+GKRlSyrfhCLX6?=
 =?iso-8859-1?Q?J4wNr9VcbAuvBw5GY7c7/1DyxQOhephq6tIjOFiwwhRJNbK3Ehde0jrK4N?=
 =?iso-8859-1?Q?6JEzdJ2xgFOs3cy9T6LNjXcljDRFSrxT+ivNN2KWalRaPI0SX57Vfh4WHD?=
 =?iso-8859-1?Q?DtXoWJ2+ELsMBvj3IOi6PxKd46HhF/P7k49649QLlt0vpzSSH4H1arYBCL?=
 =?iso-8859-1?Q?xISsCCpWfkHXKSilpGX+ef/EixXdHyFyH1dQjMAhWcGIIOoxw+kwfuZqJo?=
 =?iso-8859-1?Q?iAg5ybRLUBdb63ilWOu1699APHaDjTwOVYjNA+/lh9atAF2dCOeUMZEya1?=
 =?iso-8859-1?Q?iPJePRqVMs56oxcYpEjYCVDuFGOfOkwh+CaPd/Wnl3u1GqaNlFhrL5xvI3?=
 =?iso-8859-1?Q?+EFfFyLNsPgQ0d+QMp6R5inURKWeLxciz+OJE0OXpGUy1JORAWNZ57VT86?=
 =?iso-8859-1?Q?EPWSTyY++X4iBQrq/BQ+k6cMPXX3UjDLvHoYQBlMXX+53ucCgG1hvb7PnE?=
 =?iso-8859-1?Q?Swpi2IXkm8YnAS0FUGkgqchrrK85PZ6RvJA7aY611YZUmmZEI9K/weE60M?=
 =?iso-8859-1?Q?YPfEIQp0AnaogW/MgEZW3eGjUQGzfcMBmTROudzh2bdf9D77Eu940jpzle?=
 =?iso-8859-1?Q?ocuOysOlJAvTvTr5k67+WLdxvZGV+f85IgHkCsz/JLG8BoTk0qQ9dY3Bco?=
 =?iso-8859-1?Q?wgH/mlHnJBGxuUYzyLWmqcOcXBcyUrHMhse1R9NGRmC4qN6Wdrdg1anP+U?=
 =?iso-8859-1?Q?4h/gr9auGtRuD6RiW39tRhCDFb1vNdTap/9byhTfMaA6rXXVGIdJUB/3dL?=
 =?iso-8859-1?Q?WX0+WZmT4M?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89843487-efee-4c04-48a1-08d9879fd860
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:05.5124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zzEc2xGOUh8byU2XRU+Rq0q9JgJw9S5Gnplcbk4BAK68XJej/35Drmp3EW/kjt+s1/I8arAROyouZTOMuYykfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: vqUr1ZZ6J67oiUUGbmOqltLC-vofpcfA
X-Proofpoint-ORIG-GUID: vqUr1ZZ6J67oiUUGbmOqltLC-vofpcfA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/ksm.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index a5716fdec1aa..fe93a55f5158 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -968,11 +968,14 @@ static int unmerge_and_remove_all_rmap_items(void)
 						struct mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	for (mm_slot =3D ksm_scan.mm_slot;
-			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
+	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
+	     mm_slot =3D ksm_scan.mm_slot) {
+		MA_STATE(mas, &mm_slot->mm->mm_mt, 0, 0);
+
 		mm =3D mm_slot->mm;
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		rcu_read_lock();
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -984,6 +987,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 		}
=20
 		remove_trailing_rmap_items(&mm_slot->rmap_list);
+		rcu_read_unlock();
 		mmap_read_unlock(mm);
=20
 		spin_lock(&ksm_mmlist_lock);
@@ -1007,6 +1011,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 	return 0;
=20
 error:
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 	spin_lock(&ksm_mmlist_lock);
 	ksm_scan.mm_slot =3D &ksm_mm_head;
@@ -2221,6 +2226,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
 	int nid;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	if (list_empty(&ksm_mm_head.mm_list))
 		return NULL;
@@ -2278,13 +2284,15 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
 	}
=20
 	mm =3D slot->mm;
+	mas.tree =3D &mm->mm_mt;
+	mas_set(&mas, ksm_scan.address);
+
 	mmap_read_lock(mm);
+	rcu_read_lock();
 	if (ksm_test_exit(mm))
-		vma =3D NULL;
-	else
-		vma =3D find_vma(mm, ksm_scan.address);
+		goto no_vmas;
=20
-	for (; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2312,6 +2320,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 					ksm_scan.address +=3D PAGE_SIZE;
 				} else
 					put_page(*page);
+				rcu_read_unlock();
 				mmap_read_unlock(mm);
 				return rmap_item;
 			}
@@ -2322,6 +2331,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
@@ -2350,9 +2360,11 @@ static struct rmap_item *scan_get_next_rmap_item(str=
uct page **page)
=20
 		free_mm_slot(slot);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+		rcu_read_unlock();
 		mmap_read_unlock(mm);
 		mmdrop(mm);
 	} else {
+		rcu_read_unlock();
 		mmap_read_unlock(mm);
 		/*
 		 * mmap_read_unlock(mm) first because after
--=20
2.30.2
