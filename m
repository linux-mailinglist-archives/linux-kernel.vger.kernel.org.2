Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E152421BF3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhJEBe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48374 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231649AbhJEBdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:37 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19508Mdf004481;
        Tue, 5 Oct 2021 01:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=d0VzRZaiQeSdT8N6oC1skt4eVt7VYljeglidL/JVJYs=;
 b=oPlqt6cvYVUUl8VPK4/HahgnBRH1WWq13f5XIWlutbYG9dHplKAS9wAxTrwzwz+PSYG2
 eq4bW5BmqKMyRiW8afDfZNGm5fNS8uoRJciI8m8w/XCPOHmy0V/DrvAQDHJ5i4FNJJ06
 OSY27tG23r5IOvtKw1Wa8ie3RtUsqqe5mV4zOBcgtinddTor9W0CiaNIbbiVCHpvuvcP
 Abc1q6ThsVQdNBEKYvsErf0sW43Ob50yj5d6kgfwaMJXpuO5OJvg/zKt/Np+wW0hc4l4
 c3xKO+tas0VGgABsuS01scZTGrvrQvhaqYjWsIZiRLZqlcs6mbqeQsLUOVl+rR9edWVi Kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdFw141646;
        Tue, 5 Oct 2021 01:30:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESuaOi87UU1kWrAh7aYnmz8QsWkUYZuyyXpg1Gbt/KypKb5aydj2lKuCNM6DuYCwU4iWln+5seJLhDrdeZRjQ8gNfxYbp98V9gQ1u7tANTv/x0c0AGKSKJVIhUozptB+Ww/Sq2hj/TnBKnLMzx0zNpMqy783BzdsO/LpqEnml6ZJv3n17IyzhmnGk3vffsMD1A9YH+qgMnG3UHQeXtPY2vI0lO0RAjRfa3Tl7tT4HkDIoEV5rAaLub/DYSEmv0d/Rtex8Fu05TR1Cr1m4gfB3Z8IkMEojoIZo5y7NLoW8VureErYOF3tKXjq6belPgwIu5dohmLp+OONCc2Mp/EioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0VzRZaiQeSdT8N6oC1skt4eVt7VYljeglidL/JVJYs=;
 b=Uy3vfIvhsDuuKes4GoKyL/oYm7GEOlEchFC7ByRqPlr9l9lOEHHohZNMI7Ro3eX3PAPiGpiqXBIb5nfMI06PKELYxxYhbNgSugy9MW1EpVyxuOo2xOf1/jlYPXiOqchrXAnDYYXDT70r//tO+IcRxUP4fP+X9njfp71t6VFimh6BmCXxh7gLInsDmqrjn4lOofE5h0T0aD9dLKBzNIjuniPC25hVIZ2/GBVkyp42O/YkmkGsyRTu2wnvHAvrxhBUyhg2J8+7wBRlb+lpKeg6h7asLrwAy2avUCn8cfDoXUytxMMLJJdW2UNW38CbFPW3gs9bqt9089jq8RAJ4qTbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0VzRZaiQeSdT8N6oC1skt4eVt7VYljeglidL/JVJYs=;
 b=N8gUH43tJ6+TkHcLpyouCca+Wt8oAu7EzV1UpTQUXm1wyYpx9YXcI3G3j/0fB7DbcNuyMYDninqNh9rlAvy37tlDQVIfDkhWsxMKbOQV83gWK3BTK6/WfvovZsuiZuia4BPs6pHMtZKViYtZDUOWvnMxRoHYf5J3Dwfi4L4GjKA=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:36 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:36 +0000
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
Subject: [PATCH v3 12/66] mmap: Change zeroing of maple tree in __vma_adjust
Thread-Topic: [PATCH v3 12/66] mmap: Change zeroing of maple tree in
 __vma_adjust
Thread-Index: AQHXuYiYHZqiXtCZlUqrX04tG/Pk8w==
Date:   Tue, 5 Oct 2021 01:30:36 +0000
Message-ID: <20211005012959.1110504-13-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: c7666e38-cfc7-490d-d772-08d9879fbb4e
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044333BBA62832EC7410724FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tYH19cG6Dl+odjW6H3Bk6qMFXp28HU/bGqwU/OEaWaZa4WWhKqiKHIJwvgmpPEeoryYYRo0iYwBGRx+/Zw/5VIrfHX7tC+j5COGDLFLB3ZlvraR6T9JBxftWj3M7m+ujfDsRxVYeGmtHzARJxizfTGAgSJBh9jWRTjtXBSHxOoQ5dypmGvKXA1ZtIcxriAs3gEjpTi+XNDT9nuVZ7blZVF2AxIvOXYtlcdzyxkZ5w3HUeHrrS6jDl+DvMUwe+cMKfX/49XwD5mXBUmsRgfLNQ92Oxw1nw08nqv4rhAKZsul6eJ3aWfJFUXBZvXeiYm/pHw4fJdOqHsQn4ptixJiViKwEqwGjdHT2WuOUltBZ64EhbP7U12sHk7SNIHtFjzf0YCKxJd+o44PSxwsfrK/2Rs10zgO1YTMSiAbrClci/y/qWckGhVrkjrquLrmtwJ2BO82RDubhh+9z5sGLDoa3+ZaI/QpPvAU1eugUlOVk7OCUScVCKKXoGjiKetkBBA3CYpEliKAs+wWUIvEzj9As/fPbiT9uHum8pspUSQW4N68SX+BVUVqOvBMoEWR8IZBkyb4bc7M0HORhPnCcpnZKtGEV2+fM+CMdyi+FRJ8isp3zAp8fMZlPow6Y4UwmQQpcAnbFiR50IlrdUoJyJegyYCtt2wbxcKSevyo9fvOGdKcQLgBqsuLYdy+27JavutOJKkzFlRWVLI1vdL6LM4t/Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TzF9zYUCSysOzSm+1a0ndFI4aNV3SDSOZ7mIkgmhWeVGJAnkYDMConwCzW?=
 =?iso-8859-1?Q?GxSPY/9ehRuL7EhLeQNvYDui4FHQuNeMqaz9DHLibahAQcsqKq9sOFfU6/?=
 =?iso-8859-1?Q?TQLTaaOVmKW7Ll1XXJob/koYNXj1YSzzz7y0ShWAYkn3NjcttRI4drNenm?=
 =?iso-8859-1?Q?++Caym8N6Mot5IMeMw9z8/so1Z5qTwpJYEwzB0nQ31OS3Xdy6iuFqJun9P?=
 =?iso-8859-1?Q?C+hOeNFaBGWJs0/z7Ojabg8FMc9FwZHyHFj74Fr9x28e+b1WSVEctS4F9R?=
 =?iso-8859-1?Q?Z78EC3mYPE1XA1K1IUcwtgNGChVquLlbeVrrcnvjG7mGnISGmVEONAH9WV?=
 =?iso-8859-1?Q?eMBQY2z/dQyROI/FPW/kNxoWzLorVkEW9AWj7qzA7uQ1yPsPPsFcHYOSw5?=
 =?iso-8859-1?Q?+YQHdHEfIBpHwqckkQtPnj3/H/HPMs5KMVnW90USPlBDI3airs0+f8lhIR?=
 =?iso-8859-1?Q?o5nn0MEkGOMm9rMNlPz5DS/TE3zVVBx/1pNZ5+6+bnVR73i0l79jd/mRLi?=
 =?iso-8859-1?Q?YoZlJ0RE1krUC3HIghFzTNzi1gphKVmqcrsF9V3ULJyzMu6Jbyh6Q4y2Yh?=
 =?iso-8859-1?Q?sa/KToWsuV+EnzEJSAPkiGfkZgQLvN5xDbGEeGZmFdkMvN0aLXFm2ykng4?=
 =?iso-8859-1?Q?Wot3bPbatj7crmymYMoFtEDC7I/BLGim2Xcxg8f45BryYO3IVDeiq5vR9L?=
 =?iso-8859-1?Q?8zhLDw8G18/TCJn5YEP+03zPnJW/D9GFr/EoQ5oJl7r/L/FLa9nuNoridD?=
 =?iso-8859-1?Q?0sFtCOVdWdTKG0Zbegih5s4T5vDVTJEeB0iz3Lbiwqs/luGZD9N+pmPuxm?=
 =?iso-8859-1?Q?QyWc4bEhyeNsW+zjorygY/lfCkS/dhXge0LPTfujhhUirrVUbwbRYGGCh6?=
 =?iso-8859-1?Q?Pmhm+E46vjhzZX0s63bbMpv4DEo2E3kmAQREXkChtCGNXo3Bw1X01pBbLW?=
 =?iso-8859-1?Q?7T73pkRuVNsGMQk7O5lXBSW5VxHZwvb1pzzZG5sBEBhI+5s140kXCvo+Ft?=
 =?iso-8859-1?Q?9PjE6TB7aumx6YAynBU8nv5thOgB5x/apx2DkHi/arg2TKHa7rIparrXJc?=
 =?iso-8859-1?Q?Dv8g6/AcWxHtIyOOe5YZAUZC308aNcVY6FXK9I08JueZi2TO/CtCVVeKhj?=
 =?iso-8859-1?Q?H4dAVqWPhIXjwD8TjVw3t9/fMB+WXAGmPVkdU3A3dypBg+AoUng7m+DgbG?=
 =?iso-8859-1?Q?LEpTbNil5KIcnlqQvMgUmmjlrSjGbmZZaBzg+l3nHN4iB3W4hMLXPMcEHR?=
 =?iso-8859-1?Q?BkTVA0ErWtjll0J2UyzGFG1GuDp8IZDXsaW4dCERprOIAEXNy6Ej3cw7iG?=
 =?iso-8859-1?Q?ov7IHov0fn29/qoDFGIHdETt17/TqJ1EWNC6LqhqRMqIMrFkK5dNv6/en1?=
 =?iso-8859-1?Q?yIrzNe4zYj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7666e38-cfc7-490d-d772-08d9879fbb4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:36.0702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/xHFLSsz7ptVgkDPsoKqeKvFdZ0Mq7DsvfTfEpqXErvBqF1tJMhVpfqvLOSXhfilJLiQ8lcokjliwbP19C3/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=943 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-GUID: jroqx8bOYpruuZUDinot_U7r9iz9ZkuR
X-Proofpoint-ORIG-GUID: jroqx8bOYpruuZUDinot_U7r9iz9ZkuR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only write to the maple tree if we are not inserting or the insert isn't
going to overwrite the area to clear.  This avoids spanning writes and
node coealescing when unnecessary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c51d739d7411..9f047204fa93 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -626,6 +626,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
+	unsigned long old_start;
=20
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
@@ -751,25 +752,29 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			vma_interval_tree_remove(next, root);
 	}
=20
+	old_start =3D vma->vm_start;
 	if (start !=3D vma->vm_start) {
-		if (vma->vm_start < start)
-			vma_mt_szero(mm, vma->vm_start, start);
-		else
-			vma_changed =3D true;
+		vma_changed =3D true;
 		vma->vm_start =3D start;
 	}
 	if (end !=3D vma->vm_end) {
-		if (vma->vm_end > end)
-			vma_mt_szero(mm, end, vma->vm_end);
-		else
+		if (vma->vm_end > end) {
+			if (!insert || (insert && (insert->vm_start !=3D end)))
+				vma_mt_szero(mm, end, vma->vm_end);
+		} else
 			vma_changed =3D true;
 		vma->vm_end =3D end;
 		if (!next)
 			mm->highest_vm_end =3D vm_end_gap(vma);
 	}
=20
-	if (vma_changed)
+	if (vma_changed) {
 		vma_mt_store(mm, vma);
+		if (old_start < start) {
+			if (insert && (insert->vm_start !=3D old_start))
+				vma_mt_szero(mm, old_start, start);
+		}
+	}
=20
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
--=20
2.30.2
