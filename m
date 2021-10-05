Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED47D421C0A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhJEBf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6756 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232230AbhJEBdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:54 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19508FaQ004511;
        Tue, 5 Oct 2021 01:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IQUuOXV0BPTaisQDA5CvHkcKoxNd+WUTSmAazLctrhc=;
 b=aZtgku8B1Zwfui6pnyYdq944HcEJyHWheVbS2NgAWgMapCeM4xa87SVSH9VlahuIpCZU
 5vfBWC4cU2mVrtrH31i90yu1+3zLRcXOvNh3CmYw0EUI6zeYqcStd7atYAso6W0r88wN
 3DPdLvlQSLqlZdi9QcW+HUXb25K63Zfn7KY181gAk/IpW8mReGOI3RMEk9dtvGUIAN1J
 hLuTA3bTqU2oOdwNjbaEueRvziUdRYdFs3ySb5scuZlr16V31oaDnv33+6PKhQtPSStj
 HiEQFY5JJTR31YjWF3SxRTl7BAsnrUS1X3LS4Zc6RpC4m/F8eUOi4WNgxi5kx3BO4oba JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3j056799;
        Tue, 5 Oct 2021 01:31:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mY8z9KuQO2kXnyEZNa3ETHrtNSC+kMeLmYlq8YWmfLfdS5ytq5Amdta6oPn2l6cE4Ygd9k8VvmQsJjJDd2QZKpDLoLJygTBjE1UWyO5Wqi9RJvoRLrdi8V+Hs96WKYGJLfDLUCpVOwKRnSZ4e1G70peKAZlTDkTH5DUDSLq3G7hVF1w63T4kdmZRYxZI1prs8A+hWt0Pm5BgFN8ClGLH/x6MyjToPCLlDvnmaXqigNzXdTg7z41+4PThiDwfQ5uOMKJpjgOr9QozlQnsrlqK8BAirLACGMiAXuTjgzOWVeAgB8+4CSSnTZ9Ay3n6eRmw1a0x8syKcQj2ALZgiDkx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQUuOXV0BPTaisQDA5CvHkcKoxNd+WUTSmAazLctrhc=;
 b=a6rkCJvMxjPo31Sx9GNJ9DKzR4unN+/tX0YZ9pzKJZ3tMLXJ5z/WiqcypDWveERrDUTABMBAhnhgKJwrP9LYS3qr1eYr2zLgK+8JnQpxSnUcTjVgbC3r3LlRVzB26VYfAxwLSE/xH4A2Y6u6EpTqmeEh3KCh7nbgzPFkNrak0LJWXm3j97l2Sqhd07Wy8faQzXmMKVWo8tQGNMC03Rwp49xU3fE2vBFAaSZgv1VpOLfsq7BFTQJxEWx1KJ6ash5h4kmu6N+vrWvq6k6UA7xxjayQh5csQFfXBWYdRjnLw3HkYveCRIq/Edf0dGpEXFKzZi+ZQalw9EBEDEjnHe8/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQUuOXV0BPTaisQDA5CvHkcKoxNd+WUTSmAazLctrhc=;
 b=KKOqUkN0xwAt3wwUPhHvRMblbkylOZXiyQRUVNKuyHZiGy7NpKavLN4qWuUUM1Zw6o0ckZAd3K3eQ9bVzjecPCc+YawOOLLIdji08UPHHaVuuGYldQLiVdj3Gn5aq1RknudSqgXq439AgY8fCFO/vv67emhS0/dGApWyz82iN9Q=
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
Subject: [PATCH v3 32/66] drivers/misc/cxl: Use maple tree iterators for
 cxl_prefault_vma()
Thread-Topic: [PATCH v3 32/66] drivers/misc/cxl: Use maple tree iterators for
 cxl_prefault_vma()
Thread-Index: AQHXuYihSewkv4fOA0WKzobUnCACOA==
Date:   Tue, 5 Oct 2021 01:30:50 +0000
Message-ID: <20211005012959.1110504-33-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: f69f1cf8-f4dc-4c2d-dd3b-08d9879fd5de
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB504495F02DA269ED24CB874CFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jh+UyZ8SsA1Wn/Pr+yH4k0BmDZ3wwyl0BMSBgM23GDPudHhtvMvYODmyEoqS8Mws0Wm9NSgwwKTtWfq6ohxXWNt5dg7H+Pv5q53Ml0RwcFB6niY6M0dOzqIXKzFwqnLawSdSotcUmf+BbfPffzRI3xa0q+mXyxWev15RbbmZqSUsxfF5/USc0F6bQWCBZvWyulUlgmrNrQc9UuAc9rkrsUfEZuEDgsqh9mAPOQ93tOeAnuPwhitQPf5Iq3WrDlWwdrnMU3Wbmfhv0tX/70yydzXY7NvJ+IkZxoHupYlMpVMxPObMciu9fiW4F3Zvse00VW+HZ4QW3GplCzP2nVswmPqrLwVExPhZxAktZroJgBmWhHX9hSe5pmqT5QBmEvcuh2HOX10eKRHEUxU7J29q7EGmh90BJKKAmzI+cW8cOMbxFVHUkiU7ioHLFZwBqO+x9T9hWb2tzsWOAIRSZj5rTUHYKOqMFb2XO79aFN/CHppm2OMUGcZ+qUf9nH+JgtG8KsYh9V/p6QK72Rxy6jLYnHn6viTLZNEBbrmXqqp5KyDzaaexBkm3FHnG+aOL7mXsppozeTl/n+DhnTHkC4zHkYVatfFmlvoxUIe9zSNz0JodhnTLslJgNtXQjKPoHnCVK5yk1XiAuP3wPsmMuYS53jr634hpDfHW1RNApojz0u5kdzbXPSrNgjIijVXJIrsYAdkoSVaJssViX+rC0pRSQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?s/LfXQ/X5beAuWmhTavjINIZ/Fi+PsOKqU9PqND2BHCtBXBy1/d/2BoLtd?=
 =?iso-8859-1?Q?hoy0VtMN3aTUAUDyCwkQBtpTNsRPpIgNsd68vWqa5YPgd05qFHjgKkEaik?=
 =?iso-8859-1?Q?xRGoEDaDl08pzXWLAHt8LJCeQtB9vgqYLr/F7X8YVxU28p43GYcDty2kOT?=
 =?iso-8859-1?Q?BtYIuXqWaxSQJyiPySp0ChWS0zZMPXq11Q2mJfeCKYHuHnYMySJ8l7WLDA?=
 =?iso-8859-1?Q?SiqzTnbRd6MCd2W90lvg9NCPTQ9wovUO0zk+jDDed7VoKwo40vEZRRoKpF?=
 =?iso-8859-1?Q?h6WhWxNo7io4tfJWH5wEhQWQf0Hgq/uDZ/0nNW8zY8hlMqLJeEtPCNb3kF?=
 =?iso-8859-1?Q?1c/JxRyYiHD/pqopeBZb2Bgipl5NbLkgI5ieBZANpF9zy0RK3UlD8Q0vjp?=
 =?iso-8859-1?Q?M85/R73ydGJj5XQ9zordgeUjvxjAwk7vXCH13OrcLmhkC5gRf2K6NTaJ+N?=
 =?iso-8859-1?Q?blVu8kmK1epJaKnk883MVnhMNwPLtxvOAEnQuA0CuajH5fSiglByuvKN5G?=
 =?iso-8859-1?Q?wYEU+XjRZIs83GOshGuh10KR7xM/IJZ8liCuDKEps6qMEmqSHDXSCyKBG6?=
 =?iso-8859-1?Q?zi4Ln0UyDSNEbUslsL6JR/qYthuRU3GQf7uIPCt1a0x3CQ/b4aQ0mL9ta3?=
 =?iso-8859-1?Q?Kz4wCZHTkax3QY6aM01nCo2sZBMq5E/N1lGBa8TUNI/hUnsD7LbtypLTU3?=
 =?iso-8859-1?Q?2C51WXEV+PV080PxrJX2/glQRtWWSkQHO/6yannW9G8zFBCHD4rNgcKLIB?=
 =?iso-8859-1?Q?ieCNu5f14h6CQNcMaBJ8JKavuxjm72ESHE/Jw81NicnnOpD8W54yD41Fyg?=
 =?iso-8859-1?Q?lANYBC5XSI3b6Zv4o2pDYJixyvmXrIkSX2gFOq5l2uNUvLtOpqlQhWPBgs?=
 =?iso-8859-1?Q?Fc0Y/L96ye4UA+VnHohQedFjdJj092bKE+sxk4pC1JaFcnkOABLFRgVzdg?=
 =?iso-8859-1?Q?KKdq79aTYfGSpZ02SABGIOP+MimE2iUNxD60f9WoneRl3hop+pdNWYQWLC?=
 =?iso-8859-1?Q?TIDsZqxP1wo8dEQnyLPAaoGuZ+j3ZvqiHOuAXjHOV3OKOrCJ3NqGBo0PQc?=
 =?iso-8859-1?Q?Vh3CgiFwIGvDptuKTaybjKccgUWaZrD5cXFN7urcs5n1DUK/QN7KSS/02u?=
 =?iso-8859-1?Q?bIJNz0hHN6/9WTTt2i+SjR5HJIi6dvxEj9qHcJ2xFDFYNlx+foNS4cmLMg?=
 =?iso-8859-1?Q?SzVxabM1BIl5wB9S80QpK+9o73Ea5ORjMIg1HatvU1JVIRLcDPcnoUTO8S?=
 =?iso-8859-1?Q?ELb2v3wCIBx5/IFcrwArPJFPXCowgBMBB1TDnJ3BzvZZj8yuGueB4ofazR?=
 =?iso-8859-1?Q?OpIxJ2RJ271gURhhljITG8cWjxweDIq56Fom59VNbPVYE4EpCSJt9+dKef?=
 =?iso-8859-1?Q?VFugue8ZL4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69f1cf8-f4dc-4c2d-dd3b-08d9879fd5de
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:50.0542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9ufDyx4Uru8YwHH2R9bN/aoEjUWaPvStIjrWKCzo7EGOKx8xN2vWa7Zzzi2vEvyURnm36wXD1n5i2bGMp8/7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: Njan5bV67Pe8chfnsjTDVMOaKaV4HCkt
X-Proofpoint-ORIG-GUID: Njan5bV67Pe8chfnsjTDVMOaKaV4HCkt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/misc/cxl/fault.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 60c829113299..60a33b953ef4 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -313,6 +313,7 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 	struct vm_area_struct *vma;
 	int rc;
 	struct mm_struct *mm;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	mm =3D get_mem_context(ctx);
 	if (mm =3D=3D NULL) {
@@ -321,8 +322,10 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 		return;
 	}
=20
+	mas.tree =3D &mm->mm_mt;
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		for (ea =3D vma->vm_start; ea < vma->vm_end;
 				ea =3D next_segment(ea, slb.vsid)) {
 			rc =3D copro_calculate_slb(mm, ea, &slb);
@@ -336,6 +339,7 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 			last_esid =3D slb.esid;
 		}
 	}
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
=20
 	mmput(mm);
--=20
2.30.2
