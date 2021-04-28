Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622F036DBE4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbhD1Piv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:38:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65524 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240076AbhD1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:01 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNiXO032601;
        Wed, 28 Apr 2021 15:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jlxn+dsZM3tFwX8r9kfzQ53xb9MLFcFLT/KXC6Th5zo=;
 b=HqBHz8nF5Aban7ZZnykHis+oWzX5vnkEb/iqsGw9BZnz4XwRiOuBaQ5br2EKoolDjaVv
 LM/jpq9v0iqYwcCC9wLLc2Kext35NZ7vpiYbsPe3SNpJMrOXCF7NanJK00X91CpHc08B
 MwVaUtSsAf/FwrtXmWuOlEnRt9nsQAvBfnJr5O5iOQJUVnlxvEsVPVgZk6gxTLdet6rj
 8a24hi8H9oCsZL0NTgBT6+R26xex47Nq+rvVH2GnxRf5VplCxmqw9sbWfyZOZYSqMrtJ
 aIzA6qBHAe8uyJBxm6lMqimMsvzJWWt+wKrRfx7ezDHff/3EOjpNAiNm3odiWnqBh2Zo 3Q== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0ep3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:55 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZorF158269;
        Wed, 28 Apr 2021 15:35:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3848eyqw48-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIOAG72PmDa7nr0dlfkXllaTicuJW3/z1FhHf4fhVvE3AJf/yQ5OcGEdp5GIjOK+ZevTvuIyIStOG1w/rafPLsWssmMwvP4Yj8tEWPuDkd+6cpEBGU7CNcmDzYFkXVsSi/nURiJd07E/W8g2VBgjr8pGtq4ZumAEetP8RT8dmK8BSlKdk/8eRD8Cki4NQg9Vh57cmRr4y1XHE986TfSN6ObcwLm1Q5/ZeKSZLg6xlrDzx+MrylpY/20ELVC0HEIkGHbLY3McHceztmb0cPoB78YilR4lHh31x8NCeMvSzpDt83diUZ8yrCEOBRrrUFjM+eg8vN/qLpIg6aXViGZirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlxn+dsZM3tFwX8r9kfzQ53xb9MLFcFLT/KXC6Th5zo=;
 b=g5NqCLeZJiYFY6vxzpFcrUobUT10auvwyl/wzZEgi73aGDERHAwTGy31QODYsp0mpq5/K9tTeVnwb8zaxcCeBynTKIruX5J6k+uA2CSWDWS6wb7TdMKUmIdG7NrwkFIwSTROYjjKtHMxDCZWvyW3ur0DgxLX7s56mCxCbLkQ2vqfXcxEAiwcUAEjadFFw3lhIu+of5aFDbnxU8omRM9VZvCM4Q4UxV5KSHxuJSEwfYKQpY+D2Kh6/WkZjYjXhzSMeavz/AZ0KGVWXodIGMweZj0tAgX9j7hZfKF1thQR3dkVF9iVVA+cYcC0blYid2ncYVXk8tBK+S8cBFXgt4ChSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlxn+dsZM3tFwX8r9kfzQ53xb9MLFcFLT/KXC6Th5zo=;
 b=RQlu0TIkEPemvImVb9TT7Ojr3VhIINPGFCB2kY37mioq2L3UamdD1sEtrOg10+RX2XAHHc832gPMT1wTah/KueoaOa1hlVmUXicMd4/QysCs/XP55QG9gSOUmqAJTH95Tlu32gDF5bqcsU2M9UwYwwmCc2NtArp00cilYk9qrzo=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:51 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:51 +0000
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
Subject: [PATCH 17/94] mm/ksm: Use vma_lookup() in find_mergeable_vma()
Thread-Topic: [PATCH 17/94] mm/ksm: Use vma_lookup() in find_mergeable_vma()
Thread-Index: AQHXPEQr8PhrPRAu5kGefREdnRv3CA==
Date:   Wed, 28 Apr 2021 15:35:51 +0000
Message-ID: <20210428153542.2814175-18-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: c005b094-fb9c-43e7-328d-08d90a5b4dc2
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44972AA1946F45A65FC8CF35FD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wuHS47dqWrQvjplEXe/OPKeJZGiTwK17DPC73F+uvDafOebs3i3MrZfyGpHr6uqukAmU9B4PdK8J5IPp36iZogDPHHhUnTSMc6iUPb8aMsfbyXXdu5bi0QxAqwK+LP9rw1TmLIvHW3l5kNb3G4I9EC4caj7BGdXcfb90AYHtZgER3h9HFL1v1fS7CxeQM/gkM4byEzX78SaI8PNSmn7SREHTa+bmy5ZFLeUiVhA3ktB5NJFRGOFCkVR/+XLY0Rao72alR4A12kQrfydTlCKpXDt5K3F+8gU49jR1Jum+HGzKQbRvBP/hxwIDMaf+ydSBYGd5lPbNh7+X0KRULs3OMuGKjRMpbVoE2DpfeE+bXSbaYPzNniytlxbfJZGxV83ctiw0JtfVRj0hxNF0l2MvnHk6XpKC25Q7sMACbtefY6sc35f6r3Cb+oS6WNp8oNwgeVFR4iOgLpKwNb1MXonXYDfscxWpRV6SfISdNjCFZRXkQZ7M8y/eHVNyv2vmN81zaDie0aSBX2dBmwwl/kOpB4VMfrQJ8V6Iw2kk2Uc94oPYdaSqKFlTNLYrJrM20cZdQyBv5nfhJeZssa4Ti5LK6o+ECUewZVf+aQxNOe6EoFQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?3UsjijL8TiUgndwkYO2OGU+a+Ro5NIfMQn3W7Tp0bzLvAw5TpYlWbdiqRT?=
 =?iso-8859-1?Q?7pkMzKxZOSqjwBo7U+YkvsY2XvADt7hllaPkGo4mnNlvSTWWkEWjxI+HTJ?=
 =?iso-8859-1?Q?Bmpa7gnw27B+fRFau/vgnxT1ZUXZsgYaWjZLl69vBKgZHSudZ2Yogz1Q3z?=
 =?iso-8859-1?Q?dQBCZ3W3QHXjIDPWmhf8UDG/ZTEFV16q0JqJQhqz9i4ispZkhlg4ueDILm?=
 =?iso-8859-1?Q?zqYhgEGYS1DbANCGR1H1FTsQsHo+w6BePE3oAa28EmX1e2jAr5wMioGhlp?=
 =?iso-8859-1?Q?1Jx4fRXQCd5DhtimMMcn1a6fRUZ2q2jPZoVEotqc1QIJ0dzsDN7rSnBw1c?=
 =?iso-8859-1?Q?zjrhVyEnFd4Pvz5dOF6f2VBJfqXm9+IfK7Wo3OuB5jcg5PZfWVGh/YtBK8?=
 =?iso-8859-1?Q?JT3xGHyAWZN8Ok9utB7awcUJL6HKU/wZIxA/wOSWM/YwKE7QlN9TSZSk/O?=
 =?iso-8859-1?Q?RZuulSdgGrUpLUHFhZj4ZbpF8Z15MIhDVqxLBoyYTu2L/QQ6Xs5SEWBp9B?=
 =?iso-8859-1?Q?qiWpBzPFqWJ32FCxUj8r/FlpjlUQt/rJDSm6XxvLqDbd2VynmfqhthiTN5?=
 =?iso-8859-1?Q?sTsRZUPygpqHxQMGivZn/CnJCmj9Uh0rw1PgEfz+SIB0CtzEOudaNJ8q9V?=
 =?iso-8859-1?Q?C03My0I2hCfg29x6KW9un9FDOyBTIzynNQ/hTgnqXulUvMzlxbKQbx/bMZ?=
 =?iso-8859-1?Q?2OMowd6Uwj5z4uRiwV8eGuHwTU3KQkL0c8t++a83iN2dVIDWRdN/CdCNAD?=
 =?iso-8859-1?Q?YN8tbnPFKZjQx4hcUXI+g8wc3dJ94uuDU+sTT5p0Ov9Mc36XGHRleMOq50?=
 =?iso-8859-1?Q?ARG9IFnlOpVOcOU2Z+8T4Rn/ZR3RPQIPZZQ4MfTqU71zxNOGd/9CcMwDpS?=
 =?iso-8859-1?Q?1pSJOsGssCDYx7f/ECPEj02NOa14xTyo5VftwSHRvWJZBMYUCMTQPZWT3Q?=
 =?iso-8859-1?Q?P8PZZXhPdipnwZMfxEbHF43EkSsdAvNaD5NcUNkyh6Tldd2rKGgCaZQqgq?=
 =?iso-8859-1?Q?aJiqVJC/yR8iLmu/6OjaKMOg0lQJFbh3vgdBwC0PoJgbSJ1Vlzl22RbWO9?=
 =?iso-8859-1?Q?4AAaxULMXmZkwVRmDBlezba1iFYytuutQdXklLAD6cauPvEkO8xYlK7lU3?=
 =?iso-8859-1?Q?AwXOpzLNJjIaW11COD3TfgvLcVlZdjqcU4kUtHqTadMxZQq9zC3c3y26Kc?=
 =?iso-8859-1?Q?LLgbSbgf1bB3ZFFhiMi58h0pZVBAFwFk6NL2zBI3bVCd5ASmGsdzRGsq1e?=
 =?iso-8859-1?Q?d29k6Ot0aNyuSfrjiWC3nFOjmP4WOR/AqcJX5pM3BLClpNvjQ3To8fQnME?=
 =?iso-8859-1?Q?52v9CTzdoMuGdQRz/Fly4R4FvCBN8xPhGHfPkbwKSCVPsVz/oJgOD7dvsW?=
 =?iso-8859-1?Q?D2uGPMfM9Qv43v36DWQVTkNRsUoPfENA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c005b094-fb9c-43e7-328d-08d90a5b4dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:51.0980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3XdQOzkhAnGvs1JOsRohplQpnB6m0MgC/Sx2xRXUaHc9qaEH5U07KAwCp7gHQYZWUS3yhu/GKuciXNKOGmd4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=905 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: -UT0ReVhAREC8wPhJoIin8SQOomyd0pa
X-Proofpoint-ORIG-GUID: -UT0ReVhAREC8wPhJoIin8SQOomyd0pa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup checks the limits of the vma so the code can be more readable
and clean.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/ksm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 6bbe314c5260..ced6830d0ff4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -521,10 +521,8 @@ static struct vm_area_struct *find_mergeable_vma(struc=
t mm_struct *mm,
 	struct vm_area_struct *vma;
 	if (ksm_test_exit(mm))
 		return NULL;
-	vma =3D find_vma(mm, addr);
-	if (!vma || vma->vm_start > addr)
-		return NULL;
-	if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+	vma =3D vma_lookup(mm, addr);
+	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
 		return NULL;
 	return vma;
 }
--=20
2.30.2
