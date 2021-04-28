Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B4736DC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbhD1Plq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:41:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19802 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240614AbhD1Pid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:33 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFTUtr018934;
        Wed, 28 Apr 2021 15:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=A83uCb8tl7mopQRiEbdtfPrySBWBUu2NcXnzu1Q+n1Q=;
 b=KzELjSJ2gDYBDmMZcrjiCIuxA5ucdPTURm9DP8ZQ1juPY/O/M2ej0SQUQkkFKb+ZkH98
 tfu9f8/jllKJDvj2C149qtijfDurBe0GBo3mJJqwZ9M2ejFOdPSnhPDSqk8TFxkfKBh+
 R2FlCirzq1ZyiBuExtn9KH1ek3LoyNabaNUstBXL0g+7WvJ8+RsgKrCr3DVNLEML91VL
 AOxbjmi2Ah1NU9SrO8egjU/lYE0lcWcb7n6vc3NBx1/Onei5OsDRiCKk1vgVU4JiVS5q
 u9z+sWfP6cuo3h0viCUrjnlWwAjMhLFoC0792wwWSdrDGUbYVobUwXsDcTO4HBr1Hk31 Og== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:29 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbQoW164727;
        Wed, 28 Apr 2021 15:37:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3848eyqyn2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StL97y47JfggiqJNA79Dkxpc8bsCCrvvC9LLEWlfvlsnhU71p4+7S6IMbIJa/AumyFbdJl324awch/k+Wcewdqd93FZJ9kmsa0k7WmUE7R9wNNjJ2NjgHLkQ1H3N0l55nd6En4ns+uKP4sBxryGoXV69YdaIBR4RmmCi9BOD9SozAqZsLDwFmL1PhAOL3y/FkUP9qK/NMMb7joEGbUGl1hTW/dE/VeQdq9ayxPBOYWyFjuq/3ovYgTUHc6+49S1HgNtnb7WApGn8LpQk3Z9k5EZwWlg0ffm9jeAYhVz+ECld8p692ZNtfoJd7KZvstI3fBMW+PxG6V6ycqAaReOSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A83uCb8tl7mopQRiEbdtfPrySBWBUu2NcXnzu1Q+n1Q=;
 b=nx8Qmm8hDlqd+QnpLFoVoAbVzLMqGB1CQAPbYNpOypZ3GJdhndJqu6vSoaLLfvxWUYIPAbL6BrXptXEzGhxn+7cF51cUdRsxe+hgtQb84166Ey5UbWGIMR7p2BodsyLLkhkftyXmyZbh7gVH8zrura+4/RHue1rz+DvU0Sl4QWLq+/uBO7zc07EW9Zh8AJ7YX1qifLUViL4E5e2YN0/X2GbRIan4dcIDMOpDhA1tJr9UdGYRSXIPLnxXUs2g/5iKXdXPe1USAt9OrwMlSH321jTJgCVZ83qHEWDXUG6jBJiYZWopxtyNdumTOr0I2LEPxQQfKcq48tdW4zC7PfObFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A83uCb8tl7mopQRiEbdtfPrySBWBUu2NcXnzu1Q+n1Q=;
 b=QmMx6vjbzUuqcxA0BW+RddqMTGvsg8OrnG5sZC0SKlECKsmJAcV9eBJW/H7cT+4nOODwmwlCzyWWpOt45qiY47+mLeICs1iwlTPUkBCeCCC45dvOONQAyoXAFlqqrh4WkrRnllh0/ubBNuOTM9QDVWJN+LbPazz0oimHzliSfQI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:37:22 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:22 +0000
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
Subject: [PATCH 70/94] kernel/events/core: Use maple tree iterators instead of
 linked list
Thread-Topic: [PATCH 70/94] kernel/events/core: Use maple tree iterators
 instead of linked list
Thread-Index: AQHXPEQ9ib8rc318+UOGu3FUsWsgCA==
Date:   Wed, 28 Apr 2021 15:36:22 +0000
Message-ID: <20210428153542.2814175-71-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 9257af8f-f481-4bc9-a749-08d90a5b8423
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB451595B37690DE35106070E6FD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTJuJ3yZYNFWhWgTWpzrTUnENC1EqbDf1HiPCspMb1C9NWcVAfjKEIRIxCqRUD2ZdwW4otpIZ0kQ99WnSS0jOOjDioUhPlM5V8WpcwjsOGeqpgGLAMSZG5otWmz3K3TAl7qszQoEdYuJuCx6qDD2SuEi1IEvbfwY7iC+Si28ODJibPMQNrFtvpX573FSIyU/oLdYGKjWVJbNB/7Ai7KOR+b1dLb0Xwv7wu0myDB9B+vVcbbeJpmNCIckSqjrdf4q1e5S8aY2Rq+4PDXnZGz55HEFnUb3R3++0lm/MSSCw6YHSkX8Bkj1Z2b9piHcCkNcuNy6TG/gqhMVdidGuByIja4NWnbrbyRReg/StxrWX3yaiXNnmRvtBvucpsa0vKao44MHxj6xbWRhV79cOTUpVa28x+4W4gzcxu2W0PawXA2H6k7rVi/OUv+E0TJahfSVlsMcpZlyhygROkuY7KlvMhL+PfI0/3n+sp0UaT1dLodX8uxk4Hf99RwPvLs8FKV3K27t/mJ7urDKRjP3goYK6pX7aQr72kL4tD8PhG73xC3zAYnxcPDWn0hOQ5DO4t7w/e/KLtv89ceRcHaovslVQ2Oui29A14VEL8TArwP9thk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(4744005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?53KFtVqyyihUVfOCYehJVp44HuuuCcwKRoO/CsaEZXnwRzKfjBQ6WSwY/g?=
 =?iso-8859-1?Q?ksfE7Kk2jjaKBWJAWAYO/Mrr0jAKXAR8TlD24ITJyiduc25bOs4vkvHgaX?=
 =?iso-8859-1?Q?XlgQoOaQxvbCpSRGLEPB5ANZXU8txKZSYmm5UoKYSpQow+diWUE1ytg4hB?=
 =?iso-8859-1?Q?jls1TY+E6JwjAzZDnvu/gvOeaiXp/1x4QYA8GfasbFoJR6WKuoEvnwW9/8?=
 =?iso-8859-1?Q?73NxYHMkej7CBbj46f8wSeq4IVf91wct4rqTQHHm6ir4CcFHeYgbCom1PX?=
 =?iso-8859-1?Q?twvWhS8XBcfaMEfyFkolDJNqerMk6Go5STGimd+eGU92VMy+0B3gnt/63N?=
 =?iso-8859-1?Q?zlJgzIDbgY9OeiGoAg0odwWn263dKayNtsYk/3yvgvMJ/GFTrs/dxyz0KC?=
 =?iso-8859-1?Q?KaYwpMvp137qeE5dqEtfHQ0LFPuhckpn2cazflZMBFdc4DdMi0aKfwq8QV?=
 =?iso-8859-1?Q?VF/YD/Kkd/f4Uow6w9nLX3Y3toY0rnkf95/iaoY+H7PrPhIvbQNgQw3UNL?=
 =?iso-8859-1?Q?VZWUSy1e2U/X5xkDVcFtnBzFrDK3Dx8ndyAayleTuNKQzGYR19U+aTZrvY?=
 =?iso-8859-1?Q?CTgakLNeu5/tzPoAQg2jhvcItaiqsrOlaKlWWbqS8JZFku1txzh0ss4vsN?=
 =?iso-8859-1?Q?EiLqtXg9fvEJcT04nvE2vYmJZBniFInC5eXkQAdGDAlQ97IJCIM3A+LkuH?=
 =?iso-8859-1?Q?5hCQ2fxNesH3rmT+ltu/QrZbdHWKs9NhgW9fs17SqBUq4iDZe7p/A1dTSc?=
 =?iso-8859-1?Q?q1oGsB4Juha2lvRqPnJpdYNq1JBLYnDQTV6mFupad5mvSMQy79utqQ935I?=
 =?iso-8859-1?Q?Erp2iEW8Dmp87SFC/ax5MVSOeM6GdneM0YvflHAZPXcbgBydHznNy7txBc?=
 =?iso-8859-1?Q?JPXd/gyaCP1ywePjczikqkazl/qL5qeHN1Ccfl5g47koOJQ/dDciBuZrMP?=
 =?iso-8859-1?Q?bDKuWbeMeWG2dvqrhk0gtyy2TfV8X6EnVLWntrEgc+OY9qLXlAO63YGl7q?=
 =?iso-8859-1?Q?jieXhO1M1WoxeSggUy9oQpm10jBA6m8rmpJy2zz+S9XY5NozLqDdk9nT69?=
 =?iso-8859-1?Q?vb81EuKFxElT9jXa184VZBdUQ5VTbxSEWmwjCNf8hxdtq7ucTCB1U3q7MZ?=
 =?iso-8859-1?Q?+CPYimqva0upuKODrowvGCjz0Ry7kBuqRk6nMCii+t1ZiRFO/NqKju8Jaw?=
 =?iso-8859-1?Q?5jjnijcBAXq1PFdiJZptEjEtdq0lx8bvJ+SBNv29xKAKxoTMR7ypLW5cjX?=
 =?iso-8859-1?Q?Hk2dUoJYC2LM8gHxTs4Jzc+ruZFJO0QfLr6POzT+QDJuyW/tRdSleVtay1?=
 =?iso-8859-1?Q?Sd6OYmMuYkZ8yU1RClzOAALj6/NnYJ3CaDHaJLoB9qxE50bKWA0tkiOqzK?=
 =?iso-8859-1?Q?xkSkjPXdq6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9257af8f-f481-4bc9-a749-08d90a5b8423
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:22.5271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydQ2QsyJyOZTuzOBfAqA3XSQqacvy8fYbEPHBp2TRjD9uu1awyTElT1+rJFwf7sNEN2iSyrh29fSHc8fRNiipw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: -71xFwvK2srfy_mACF9Z8FN0i7t1ZoyN
X-Proofpoint-GUID: -71xFwvK2srfy_mACF9Z8FN0i7t1ZoyN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/events/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f07943183041..73817c6c921e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10041,14 +10041,17 @@ static void perf_addr_filter_apply(struct perf_ad=
dr_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
=20
 		if (perf_addr_filter_vma_adjust(filter, vma, fr))
-			return;
+			break;
 	}
+	rcu_read_unlock();
 }
=20
 /*
--=20
2.30.2
