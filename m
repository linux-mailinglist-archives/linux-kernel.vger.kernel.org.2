Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB1E421BF1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhJEBeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24444 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231290AbhJEBdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:36 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951Ooiq023948;
        Tue, 5 Oct 2021 01:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=K6VJbx47UAuxQh1uv/AvQYfO3oWnwIbn2TC1qgqaEO4=;
 b=iaS/LQF5pSH2UgbNOXqv+CWsQqEuXsN4ZbelwtsqfUk+5EkSiKEYpuMV+scY53qGegSR
 KORxrD4eD1Ck76W7TaKq1AIe/E7BQX2x8xubLfQ36jrg38+hHvvSlDkOpMearAnucveP
 j2IV2JKu0+UMLyhdnRMfWPvkMdZ9mJifq85SJ/1fGUTTtxNAj3L0qmVKkx6WqP7luEIs
 o5TB5jcZZaJBnDXWvTA4Or6EyHMQ2RV3R9YWqXVURycxC8CfYprVH8bNv8cJE+5rxDog
 QOEOqeVWARMLDKMcKp09keaY0HlU3rZLLFwQYOv+e349aO6476WlTKgVxGzLYHId7eio kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43gkphp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3t056799;
        Tue, 5 Oct 2021 01:31:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWZ65ZTAKymy8sTeNt4OCMYuqqzcGe1+S9RcX9qisdaNjFKsm/PCgqWKewnq7vfArgomgKd+K6k406T67diNIAiRe+5uXpU4PcO7ASGQQtDWh5piGDhhRRbE3dFPOru5hExiJ2h80p3xZpU5IO00t9FHxJWYWeyXouM368ZmQNWkcD9mZVV3SO4cOCBtBmsXce8f9xmoSEGI8IWOA7Y1z6Y1Q0A75CtoiTo74NzF462uyMOQ7V8B0l1AETThNzM6smrgON2wALqBw0HZIyTZ4PP4Ukmfkp3ZYZCMnew1xtLoW0DtGe0LD8xBiN7pMMpr8TD1cOZwvDNqcLI+YVJcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6VJbx47UAuxQh1uv/AvQYfO3oWnwIbn2TC1qgqaEO4=;
 b=nBRUR/Uh7S7XRq6F+iQuQpwb0+OqOZeIm/oNmdQhxtdu+Fl3oFN8tPMUavZt5tl+A+VTTfUoRSi+wFdhs+KVToKtwm8eh5A2Y5psPSLDDSiHjyQzpH7IixHjmpZOLcIN8fwBx+XGzTtXXzZMKn+KKNYjJfo3WJbeF4GFj7qyaP0HFkbDYQvWo/Z/YEvs0CCB+jxzAUgdsjAbzVhOURPoDIDVpYo6Ob1XHuEeuSMY0zCls3wgDsR+hVp09yoriSWJgV2O4G+PafdGrFE3FuZsdKBmh+UxMt+11JMfzdsUPNxqwZu1bP6x9cY7q4Hfev2OCxpwxw3ennDovv65MmFwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6VJbx47UAuxQh1uv/AvQYfO3oWnwIbn2TC1qgqaEO4=;
 b=NVxbkyJL7kXReeAG9xTXNMfQlkVvX4VSc6PCl8jsXn3rkCxVGQXGk0/rRrLM4Hv+9J/FMttJTT3pcsI6N/xXsF+zTu68KZUqZU9fm7imzrtsb5mreWq72xKmZZyazs8eJgNZyYWoeCtjD+IUmxiRpUAWQgi4XRPsP62bgl4TP9I=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:23 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:23 +0000
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
Subject: [PATCH v3 45/66] kernel/fork: Use maple tree iterators instead of
 linked list
Thread-Topic: [PATCH v3 45/66] kernel/fork: Use maple tree iterators instead
 of linked list
Thread-Index: AQHXuYipxj3truUFLEWKF2FLqcXjvw==
Date:   Tue, 5 Oct 2021 01:31:03 +0000
Message-ID: <20211005012959.1110504-46-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 77bab529-c5ad-4dff-ceaf-08d9879fd7aa
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044ED2F16FEFCA78236248DFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: caCFRYL/YHEiyTe9FE4RjLPcW2XnpstEP6OXTdfPCOnkSe7Xwi3EvTpWl9dsTkkn4PqYgjDAFUJ6Cot2tfkMSG7UkoKuQSCtP4F3hnA6FKSDoiaWXf5tld8riLbos7Lth/8M2Ih+IW0/b3JAMnN2xFS81D9EeIZqEHMTW8b8yQEo8bZnbfsv4+Rj7IIMsZ4i6sAvfv3PyStzi/GSb99z3q8xW+4HLRBEzStC28DpyL24Ubmm5haFFIGSBUHcH+EIm2Dlr8BaviosC69fVAQK5JZgZrxzQ/UGGuZgW5eub5FC2YlIrLGX/O8CYl4UBZK/JU6YbeG6qKPd4b94r7QRnhHbUUaHIen87PL7h8XTJQAcfoqKaI9RPX3YAX4UhB+eP+TTwuU5LqygzLXg/JAMtdxVEgZY89MLkO1/V1E19Y8C8VOEJHdh0DvP8V6ybtQYnFGt8Mrp6dipNQMlffjgIq4GwOAgPorkXI6gv7+s3NqXB2GsrejwBSDuAs1eIsoGewB5N4f67bryH0H5b+XI017v8PMmovVO/zTWBMvsql6Il44V4qJD0ElcH5sX6if5aXquQjbZfGxbddQNGHiMtu1K+H5XARcg9mOuDTxGNB4QVy0UKovzAG6bnz4jkbxqZf5LqN3EjFuEhSiXj/d67XDL0y4Zeq4DsfC1msjokYexC1cVN+EwidzhRDVRtqn5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(4744005)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b9BBebx9kJILocV8GlW8xH2vHIIuzoTdzBuWndaKwBrQMUu1yN3Lm/OM+y?=
 =?iso-8859-1?Q?vIeawtcRKhDvUQpEMhRYqhk6lP1OcVW5+8REJBb6ISVanBpRAId9Kv89XJ?=
 =?iso-8859-1?Q?5meeoblIjpwzc2pN21bj8GQJVHjFvObmyKGrNIY2gO9rfj2i+brpRFbIwn?=
 =?iso-8859-1?Q?kD+EsRJYCjKDgeU8PQYDu63eteoVD0JP8KvtTNdnaeLDusbV27HxGQGxbr?=
 =?iso-8859-1?Q?+aCguptT3fFAc/P1Msdrs8IrBtrGSEkS1gUUpGdRu5quSEWTpwvL15zadj?=
 =?iso-8859-1?Q?sCfS0xbpQGtF/5Fl8YFcwHjzFC6y/c8KDRiSXPZglBDttKTDKzy1cf+tKB?=
 =?iso-8859-1?Q?/AgSZNJIWUnP0o9eDyOmBu0aUadleXF1K+8ijAl4mSMfvoElHfNMlH3abR?=
 =?iso-8859-1?Q?3lt2ecpJ4l2UMudfJf/Be7D45+kmGP01SAs8UMLOOkjbqc5rL27C8VXLvE?=
 =?iso-8859-1?Q?ynu6r/2LEusP5VLBVcKGEnUcCExPVa7O0rwokY/2CF6eG/jhyGBhyF9NnH?=
 =?iso-8859-1?Q?jf5LFkkt6e3yIvf0a3u6a6zjAxHTZ6BxZXnmXAehVqLuEWfVfrVrWxxdqO?=
 =?iso-8859-1?Q?Bd/K4lwL0pN5CmgFmVLgNdI7Lp/1II+zADocB53/yIvIvJZIUfKFbgBVGC?=
 =?iso-8859-1?Q?fQ0Av2Q/vGwBXbBVesi6iA+cVmuyYaKWpHxuwXEBIQAdUWgXynNLuFecM2?=
 =?iso-8859-1?Q?SWJQaNGS1CmyAQm2cslSYTVM5WqAwEV7Ykm35F4a7ztmE4CrylTO4YcaV3?=
 =?iso-8859-1?Q?va3dYJevOcTwv8/wh1OnELBgw/fkW4rNSzGDi/mPVcCbCBUo5CpfQ53dvs?=
 =?iso-8859-1?Q?uP8KZYaGPVfOacqO4ySXq66y28U4xpSNBAIhdn2a9SNnoeKW8E4DDBWSRz?=
 =?iso-8859-1?Q?OcePC2ztEiC5wOzIH9fwZQroooz2yvcHAEbxdj7w71X+EeZDX2izx02fhC?=
 =?iso-8859-1?Q?GJTjF42FE12DbZJ7AufaMlB27yhFDABuOrRWuCwGYJgcIYl7KqLl1P9x6w?=
 =?iso-8859-1?Q?6tQ81cuBrgAtookLt2h8A6Z0ZLcuZDLLajevWWgGuFfYAcNQyyaJSTwRnM?=
 =?iso-8859-1?Q?MFLAgC4cf/fvRMoodvtG6Z0bTqXawOXlSPwLhi/uXv55vS1oGEerdqyQmT?=
 =?iso-8859-1?Q?qRpRnXaLEHX9a8ZaSgnX3lHKWemOfR12swyBAq2YA2Ya+W3MTLEffvhYFf?=
 =?iso-8859-1?Q?GL+Pnv5OndY8feIZEbjZj6usmHOLk+BRKeX70cCGcsBrr+lWkhx6Tb9JPJ?=
 =?iso-8859-1?Q?emGpcDxyhyqTtyeQSQnGpC482glKIMTvEbUYjo+f8jks7vH38ICi0BQXre?=
 =?iso-8859-1?Q?8wlDduzUpCzlLkSPjx++fvfFXRdHdDgQ8CHMUGoXBVhhnXXwcXI6V+ZB8k?=
 =?iso-8859-1?Q?hT9zZztVnk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bab529-c5ad-4dff-ceaf-08d9879fd7aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:03.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRzqJfyN6END20HDF4aAbORKzPv2K/Y0UdMIWjY0YGLzibwgCHQIFABKT9bJAbdHiwCGEmVdIvYjuI5oYVvYcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: PMrOieIUVl8ga38ZoStl6uDOOmmL3kgi
X-Proofpoint-ORIG-GUID: PMrOieIUVl8ga38ZoStl6uDOOmmL3kgi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/fork.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 3c14f8aef01a..d995ab62002b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1229,14 +1229,19 @@ int replace_mm_exe_file(struct mm_struct *mm, struc=
t file *new_exe_file)
 	/* Forbid mm->exe_file change if old file still mapped. */
 	old_exe_file =3D get_mm_exe_file(mm);
 	if (old_exe_file) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma && !ret; vma =3D vma->vm_next) {
+		rcu_read_lock();
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path))
+				       &old_exe_file->f_path)) {
 				ret =3D -EBUSY;
+				break;
+			}
 		}
+		rcu_read_unlock();
 		mmap_read_unlock(mm);
 		fput(old_exe_file);
 		if (ret)
--=20
2.30.2
