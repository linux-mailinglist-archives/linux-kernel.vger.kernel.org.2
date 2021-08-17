Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9353C3EEFB1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbhHQPz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9416 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240291AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjXnr006885;
        Tue, 17 Aug 2021 15:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IQUuOXV0BPTaisQDA5CvHkcKoxNd+WUTSmAazLctrhc=;
 b=EYuCh0UvOhQUZIDeZ53qq0dfervKrJAWYcHZANTdCi5WotM3qnUR2TbOx2j7FwhpWR2W
 GBOj5cWphT05uIXqZXQIIN+NTjdFhnxemSWEnQ3BEK1zTnblHT3tK8ZVwDjRWzhHuUrK
 NU4RpHiUdxkuP1Jah3zaNGV1gkeETtceirlRHy+iEMrYUqc2zoGzjDqoyr8AqLCWL6xr
 0k9va+B8drfOrxD3iLETP34Ztu28BRonqjf8IvD94A0+NHKYCLJczGk3/ifs69mdlTKL
 g0PRksG8CZKenB+3EB+jdhcA/VIjifNvuk9shSRGyPvvuCGiT/2ZkU8SN9DkZ4yMRiik Dw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IQUuOXV0BPTaisQDA5CvHkcKoxNd+WUTSmAazLctrhc=;
 b=khz3zoSOgs26Az0C8qFyEqAJe6iqPjmqiiBTUyaf6kxu92u2eyZ0aH0o1Je1he0PYUHf
 gFfqKLVyoy8GM3Ae9DjlhxS7ZCTq8tXFWjrZIFu61uiYxYIl8pDGVylp/O1bDJDJ2LBv
 bK69vH3ZgUgkH4yK6+fe7fksHpTg6kqxRX3dc/rFVCt57cEdEfr32+JoMsFO6mKUBHvR
 vDKj9mamdugFUsWPoNN7VlcwsG+TpAF97yHtBhlwOeFsdene3eqT2zw3cQddLdtwBapy
 EYySdZ5jkf4tlxn25DTsdUdzvTJU6TD6V+bew7zIpW4MiTepxw2kkUJ7Vgm7AHTXShP9 PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbc9w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3OS174039;
        Tue, 17 Aug 2021 15:47:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/vyYpjm/U5okgA2A/HqYFKeX0+HjNRSn5xcnnKCbRmqgDUB9G8Vji5wfbUJpKOAIH6VuiIix9cb/rJmym+BBgzSRBAq4+qgEZFksYbzDK5gdTl7ifyZVqU3UbqQWbURz9HBqIUt2xm0n0h2UHZVwenfVdnuZVBGT+FxRhRpoosL8SDjQbVPkl9AlktDUE5FlzhddoGWD3WWe0pTo1GkP/NxbSC95whAAcd3SaCgkI/c+FueHKZ4z00YT7Zt3xI/9Vak/oln9rFgvTAhYtbUvvUK1wTnf6xvxICficT6rVPvXV1pgsMt4fvR1kZjN5Suc+2y47/cxWSkGg+Thisbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQUuOXV0BPTaisQDA5CvHkcKoxNd+WUTSmAazLctrhc=;
 b=d7Fg0lchsQg5Q0VY4+HIuKNdKueB6nnbbzqfLJABT730iHzaFUs8tm/9HIgEbhDzOLGhw+sz6J/vtQs7fGIijn06YBThcL1aEuuRs8JTxE+SkHjrAwv125YAP4UhQ+i2VuFyoMOhVtZiMJliflsFAtYl9ckL1NpTzyE3dBGwxUIhD9gPKXk0TFOf/uNffGlqkdzKpwbGTwTkH4AgjvCKfL7eSxaqJk3hmIMh4PJzmnLi861UjPjKTcjtRVdRlu2BrUI/H/eBwcGBjL0De7bRPRlOkWaUUqqljDxAAUHAjLleV8/un9nOLZcIOXgkplzEr3V6MVJ1lRCW6IfTseQIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQUuOXV0BPTaisQDA5CvHkcKoxNd+WUTSmAazLctrhc=;
 b=nOiCygp0xbIpjJnElDhO3gvyiwYa3YkQhM3VTg03W1XEi9OiiVNGNvxGc6MSxzwpBD9zx2EGZz6tUUJMQoWVK10Z+u+b4R9iAWCA0mxeSs72rCSuvZv8CU9U9fkPDu7hb7og+oReU660pI41pqFLiLlClLn2PMiF95vejj3Rghk=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:52 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:52 +0000
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
Subject: [PATCH v2 31/61] drivers/misc/cxl: Use maple tree iterators for
 cxl_prefault_vma()
Thread-Topic: [PATCH v2 31/61] drivers/misc/cxl: Use maple tree iterators for
 cxl_prefault_vma()
Thread-Index: AQHXk38qA1VcrmyApkm/rage0Fy7Mw==
Date:   Tue, 17 Aug 2021 15:47:21 +0000
Message-ID: <20210817154651.1570984-32-Liam.Howlett@oracle.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
In-Reply-To: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74221ec0-5033-4faf-7a36-08d961965fa6
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4236F9BF0CE3A9F475586F14FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7OpidLxcRG9a6CeTTc/Fm5OQkUklpQbYU9kmSTDIejqP/49NJ5rD4MCCkIM8jXhQigW3qjfmk04Q1fuZLd42X/vKDekd8LkZTt/X/uy+2wl52JY8IEIYw1vPvqd9X59JWv+7eRilH1x/rdA71sbxecEhhNFgz+s4emddM4uYKmUh+X2nc5I9mZ9TDfJ/DQ5hrvJBdzr+/h/pzWI196X4C7kCADX6TUX06bNANK+xL6u9xBAihnHIauZ2PnUGOH2Km4gkco7qSjXQDUNS1jCnBZVTv+Nt6vwaRMP3NjAlJcMwAwGHbBEyatXgKcA2R9gVgrIhegGewT7ZowdxTJbUmn2FuiC/yxAEKq4Jvy3tf8CNZWRpC/aD+E0PBpL2jFHRod3Zeyp8HHfbeAeKuewwwBPBf4L86DDh2RghcK/nly+3B5J23LLdLn6VHo0YQtIKg2locs+O+6/7RX7XvMPkt++AjFX/Pw/J7npu2bkttvZZLK2ZWc/ZqRwARguKNRA0ykZbC6eMk3ToB+NTXbHmR6VyUr9xZmcA04QXfYOiKvrl1y0OwzIWaxXxhKELR1HKBuW8i3DK8JfefqauWZU7gMFI7K9Evmj89SYVUdUQM+hf7StWN4VdoH8TBIR7/lCGjthVynp+nMM09o4fi5z108XWMKk+LtqM3JS+dS9yoCHA2L2lYIcSmvQW8ffqTKq1LzfjU5qqg5IMYPTqgV3lmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6666004)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bdAjnA3NHkE5btDBzHMFEpjJ4AirMNV+0mUb23Y8ox+kgzywRFADmw93FQ?=
 =?iso-8859-1?Q?atAaYlQYiKIjOsSHnC3WRT/K77lr92r1602ZxrdI2VF/T0pZUgibswtWqx?=
 =?iso-8859-1?Q?wiJ1v8ydj6h7CODb3rdOlSD+P4l9/hStuwPy01tx4d2wXWJPTd0/5Hb81i?=
 =?iso-8859-1?Q?Cje+5NmV6dZ746SsRN8qRn0ZBqyF0eGi0K0fqQMZKtnniE/uDmAhEjspxM?=
 =?iso-8859-1?Q?7Zc7TY3HjwH/kO4590kjXsLuUOIRKZiHinoggujXnMvzps8418o24JZ7yR?=
 =?iso-8859-1?Q?duFIaR6FikMuCK7gAPa1bDSJcTw1ZZJGjXLf4We4inaS1mj8eVkiTv0Bbf?=
 =?iso-8859-1?Q?UickGkp1ZRvMUtSSzrhAvboUUyp/AXXqxcAXfbmx0PNv8P4IC9YyHY/oOK?=
 =?iso-8859-1?Q?rDGLHBxgkyjoX6Lljgo8fmYjnaG/FBVNf7YesiYyB0ltWHs4JCSFtBYMDh?=
 =?iso-8859-1?Q?Hxn3XY3TWOrV8JEQgW0TDECtSjrouw+ouEfD14uaxM4A8RyGMMp2npoev/?=
 =?iso-8859-1?Q?89wGVm8jw3Aq3HN9h1D+gfQF5ADVSlRK7iIkWfoF8G52ew/73GWrePmqj7?=
 =?iso-8859-1?Q?pXLXKYkyfeqIbgawW8ThQj1J3fVBaMbzGzRMx06U/3UuvGWt8CaQbRmzc6?=
 =?iso-8859-1?Q?Ns5KbYclihkiPHVb9sPlWzjXQ4uVm/yEqQG7s5aCuMmTnPwd5KZxd9fgPV?=
 =?iso-8859-1?Q?Fm/oDk35UCihxCTBUi5inMrf/rR2auZ9cqthSLfBjfm/D0eNx8IOeomiKV?=
 =?iso-8859-1?Q?JCmxTb3SpNOf0jxl4wNp0mpQd57Ez8mnUETPvZwc5Utv3tDcK95yriBs36?=
 =?iso-8859-1?Q?Z6NYKUXOhLMafNsfr6gClmOH3h4qyLa6pBsAJx9Z15T3oyICAVyAISmP+H?=
 =?iso-8859-1?Q?UwgRMOZ4UBenX9HPDh3FxT6DLaBwYezjzK/i1m1UCgN72M+FXHO44YrWSa?=
 =?iso-8859-1?Q?evxvKpwFtWVqueObqQ3O/jXHtdT6MGBSnxQjZO0lVeLJ/u38L8wpTc8Gxt?=
 =?iso-8859-1?Q?kDjWbBKiBJeReGZC9CIUr31gYoh7eWNDTeEsmebiamW2YEeq0n2LCOjQev?=
 =?iso-8859-1?Q?JmZMJkZ/gJ7WYCOWvrUPbnw6KF14axbXu3rpOH21/H8Y779yeMCx63IN+w?=
 =?iso-8859-1?Q?LK6yRBkgkQfs0x+8CTX1Bd6bzO2B4PTt3UgUEdCL0fWoolBdRmn5hhpuIS?=
 =?iso-8859-1?Q?1IXQCQWa8ZIoQ3ea+7C7jE82/uEk5Kq9BVZ+1rAFOu2Tm+xk41S77hxwd2?=
 =?iso-8859-1?Q?tCJ1eWsGVfygQBgOj2tqgiwOmhC6fngCNWzRP6+4n1kJ9C7sS5rRtcIefX?=
 =?iso-8859-1?Q?2BtdKas9TC/usPl9IR7ajzqvctghbUCCfvM5KhJIFNv/CI6vubXVJKTS3e?=
 =?iso-8859-1?Q?iVInyr8+x0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74221ec0-5033-4faf-7a36-08d961965fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:21.8533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkStU+6xT9Gg2M276LEqLRFxNtGPomuq+CvmPGB/FHnUjCS4H/7xiPJPvq0wXUbmtguYs8sda/btthojLkiJZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: sMPD5VBTfduLBgoNi4qrycbSatOhz9uD
X-Proofpoint-GUID: sMPD5VBTfduLBgoNi4qrycbSatOhz9uD
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
