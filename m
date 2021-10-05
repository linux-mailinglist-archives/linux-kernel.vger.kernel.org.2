Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E14421C13
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhJEBgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62946 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232507AbhJEBeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:08 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19517Av0029426;
        Tue, 5 Oct 2021 01:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0f8m6ud3eAj9joiVS8nGmMuLdSf/JTNcLnoXv9Oqaw4=;
 b=T646vzjyamBNwk32VG4nRcbH/7vNCQ0mxlI7sJA4Ls0d4eRXfuozBg97mRYgYwQpXfX6
 3nKZDYWCQpOJt/L+dFzwi8ZOY5gxtG90okhvYtSnEP6+xRMnKxnJVKhSaBN9RJjMgzUP
 VIEs38cqMMbxSfaTBC5FAiptTY3/WBHFmugtHDbO9DPxm9h0eDwKdLO5aiYLTgnaxro1
 hkcMGLHBiNRZ6cgKYgxMstI33db3Wyg26HSk6zH9JO7kv4MQQSJ2vP4PLq7bETtBgRlL
 V0m6q3srl0BcfpuXJ/Vi63PK806/gWU+ZFn4mO8GFRZgKcbF+vldAsMw5eWdi3ygkST3 Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kkyj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:32:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UIEh178435;
        Tue, 5 Oct 2021 01:32:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3020.oracle.com with ESMTP id 3bev8w03ud-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:32:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEBMfiVDp7Qibj4hU/ITiMQPnluoJYhkvlMy8z82Pegg1hdhBLSfA8RL8wlDMcdgnipdp26BykWT0mOe+TBGAlMkYRpVC4VkJC/MRIbVA/lC0SGdzedFYglVm+69exbV4D/ikttrNyhJJAOEucwVYMFfqg7u8QF0NAVxyqTG8QsInAHKj5PWqDfuCdjPhp7U6kP2AIHo3LkN+IW3tX9fJ3BhMRQ1JWhK9INPWW/YnJaUCFYsSXy/Wdr8rchSuSugXxQ5LHF+1dC75cKDit8HSUsAQBmYMcIw5w6hCKK2yey2O1GN0zvL0WdF/wHSKsKMgY+VQ/HKQ2YRY9g1J5fNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0f8m6ud3eAj9joiVS8nGmMuLdSf/JTNcLnoXv9Oqaw4=;
 b=H8JgCq+GGCCMNeIjeDL4RbQq2XOm75Xz1YAIRZrjVsaVuqg37mMj7rvyRXMeVE4wNUZqcCPgQ1lbVWAI29Y0K2LO5LSHNnagbgp3tUkW6pLLpM1lh9koQIwlb6y/3KqDK6PgBvDaeSHnJYYEO5U640+YOt3Td4kshObf7dYXN9dNcLbDOo9oAkEpdxsTPM8NGP48uUGbjatYaLZ3fqaFoMSFpEdaBteQM+W5rgSqIFIAGXKtCsCu1QqmDc2+NPcqRS4N2IUGS7JYzUgDEOLU0bk3FYgjJJuZlMU5KHCmqRZnDDJr7n5qzXFeCvt1LA9mAiQR4IXtYEzX7mBxjv+7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f8m6ud3eAj9joiVS8nGmMuLdSf/JTNcLnoXv9Oqaw4=;
 b=vB2ipYW321I3VZXJhnGwcWMWaj8A3ZEpSFpSEZuRECmuwi/CselF4QqzU56ozu6Nj89hWZI2A+DzTZDyHxtVf6vhdMlC4gflcNyca45sOfx1281IBdjBs0Dn2fbRfJZwA+YozhfDMJcuLncAqIzjO8NWel5r3+NS1aV4l+MRWcM=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Tue, 5 Oct
 2021 01:31:57 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:57 +0000
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
Subject: [PATCH v3 63/66] s390: Use the maple tree iterator for vdso
Thread-Topic: [PATCH v3 63/66] s390: Use the maple tree iterator for vdso
Thread-Index: AQHXuYivwAYb+k6u/0auHS7iYjc0tw==
Date:   Tue, 5 Oct 2021 01:31:14 +0000
Message-ID: <20211005012959.1110504-64-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 5f17f406-99b1-4c69-0daf-08d9879fec11
x-ms-traffictypediagnostic: MN2PR10MB4288:
x-microsoft-antispam-prvs: <MN2PR10MB4288E5EDA60E67848C661EE8FDAF9@MN2PR10MB4288.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XccgBKYFbJdkNdRh4aTGwsDYOisEKlKMtl2VDIjczexLPb7x53nU0nbN9uDHK1PK6yr1uf9gSSvQWYTTIOSESgrv2K4UijDUJhRyzYHULHb5xS8H5/lO0DIiGUatmqur8vne4ok/LGb67DN1QTX7VjdN9ilkI8UrUJAEfF7IPdlz4vfN6jCKH0pdhfoUMw452KNtbUoPYj03qRsbgbJbgdSfweSo0c9EvSNmU2/vE5WThn18q0aE2T/WxjbF2XgdeeMKW9fwby6YrKuHUM25LpA7+BwnxY4yP/+YDs5UueoOm2kom9Ps4r84J7aFN3qwvplmi4LxBAK2xzpVpwMvRgcfrXdS+amZ20eg8mvHQrVkKkuKmVoftsVH9CE7Du+6PdmbLP3OrGbdB+fR5LGIo0qcK/RDYyd1eJO7xfdfcSQGl1a2z64WKsfDDSwJ/CohBagAEZY4/3wb0Y2Ed8eK07+pmZ/AUsbZvPKuPUS4FnWcW3yzcAy0r0qqdu6MtfQUEnEY7brM4TQSOfEcRvxIgjs0FE6kUjeH38CsT1Exm15F4miuDzBI6EySWpWE0Ru3ABe6mIGrdReOhfhvLVTgjBbDofcF7jbGKbaFmxbCDD74+ma58sKMnXFjEeDP8f/cBuS5hyjwfwHkwmZtVBT1fVI2sv150TTAV5VjSczsMZkEqXTqyJRrta+kOaSMcA/osFlnrQZveGp91CSMJg3Ofw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(38070700005)(71200400001)(8936002)(76116006)(6506007)(1076003)(122000001)(316002)(2616005)(44832011)(6512007)(6666004)(6486002)(38100700002)(508600001)(66556008)(66946007)(66446008)(26005)(86362001)(83380400001)(5660300002)(91956017)(110136005)(4326008)(2906002)(66476007)(54906003)(4744005)(36756003)(7416002)(64756008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5bh9Pacm+O6TSy/+OuJ2Un3V4QUnaXvE5pfWfoSbgvhNEKaqsZrAATyhQI?=
 =?iso-8859-1?Q?7thCJS0fY+fLo/5TeJcl07CIzna9UQys0gygi+A5N/SZnh7ACl1WjPlTRh?=
 =?iso-8859-1?Q?ObTuQvJDNcGND4a3VAdcaa/jMiz/GbqMdtEm1D9wQD1sL4sJy5fXls14+t?=
 =?iso-8859-1?Q?k7HPmxPBsLytSQXl93Xhtr2+yzXCvNR7GCUHJRUlk5GBuug4ddlrvmRo5z?=
 =?iso-8859-1?Q?QWfgeDCwPXYgmx2Nm5P/IMUMTXcBYMhF4+v11cTY3ABxIuop7weWlnYcCS?=
 =?iso-8859-1?Q?+FvORdgH0hktN0I3GN3h5oR9x0H1nKQGy7ubak9G9AHEPIahTQ8eUjH2Zt?=
 =?iso-8859-1?Q?GQoX7Pb8TdEWiUY2tV+KuQ/d5BcWvVhCU4mAa4E6JpkaLpHaOd3ERwKcQ/?=
 =?iso-8859-1?Q?W4iNY+tf3KdMyzq1Vc7pyP9ZmkTz0DJb9YesbXBket6pd2EvUqF6w5MAAF?=
 =?iso-8859-1?Q?avzKQ9Gf0mK22R8MzzSxjzayjN+wr6CsHE32Rhk3fVtiI3FvqpHNxCk+3U?=
 =?iso-8859-1?Q?u4z6p+yXkVBgcVkDUUsMrndUJpxugRlCU4aTXWAs5+7kgRkLHxw5HK/hea?=
 =?iso-8859-1?Q?IAVgBPVeXImGZhf5ubzyoRGiyQgoMvhg5Fz8YZLqDTl/+iOP+ZteRHCxZR?=
 =?iso-8859-1?Q?PUK0LvA3FgwYHHQioBIUIwuozKVL7K4Sfnjn1LE5AilL09QWc7xWsiL8kr?=
 =?iso-8859-1?Q?ezhodVjzN6wIZ8mWhqhy1Ywy+BXGje21GYq3wrL8qxMrgzk0w9UA/TJCnm?=
 =?iso-8859-1?Q?yywu3542njyY4FdCiRlcJZr6MB6ms39cnkB2go+Yjta3cvp1uH9egrnmRT?=
 =?iso-8859-1?Q?wh3n+eJWlw3IREQjDaVu+MPZ/dz6vraszfgEh9+Y3TkD2uzoXOBCOrwVF6?=
 =?iso-8859-1?Q?6MoQi/UIDAn9qfnB9rDk+ignEPH2ZLVQXUQe+pBFGFtpsSd7aX9fONHyl1?=
 =?iso-8859-1?Q?rkPrPJ8vuz/vt5E9A+0s2fUX4W27m6iDkh8p9ltKKV0LBUNf8revLosL7/?=
 =?iso-8859-1?Q?zzGjbYtFZFSciB4Akl9SsbSvISTvPZoNA5djbJFHP/KrVqesyvflJYZgX8?=
 =?iso-8859-1?Q?PHkKB3QE7YW3UAzwUBD4SB36S0Kzr68oIov1APIuQ+XJKz5pvbtxfhEnkY?=
 =?iso-8859-1?Q?VLu8lo1AlBD8eDLYnsHpFXTqIrxr+5deKwxg4XYClon19aIusxiC7ou8HS?=
 =?iso-8859-1?Q?+S4VZ7dCB22ALj6+no4W1iS4LMAqsX1F8wpm7M9//1tR8mb+0F5cZ/8Kts?=
 =?iso-8859-1?Q?0auoSeq+Uuo7LnrINjsf1RkyI/gEaG7DN6fhKmwvXV9psPUPvoJLJ96EYt?=
 =?iso-8859-1?Q?17LqUgMGbMfg03JFj2Vd+Q2SRxOtRCAetrhez3jiF7LoLXjI62aQsNx7qd?=
 =?iso-8859-1?Q?HrEowFZi0G?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f17f406-99b1-4c69-0daf-08d9879fec11
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:14.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J31kESMy770+ov4on6CjzIuVIYtX016+k09AwiglOdWChwb59Tje2uH1GiNqYXTwUL0y268KQ0b7mjcgyuWt2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: ynXWBUNhVrS-3uTdeFRaJ_yLd076afaS
X-Proofpoint-ORIG-GUID: ynXWBUNhVrS-3uTdeFRaJ_yLd076afaS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove vma->vm_next and use the maple tree mas_for_each iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/s390/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 99694260cac9..26be77ed45c6 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -68,10 +68,11 @@ static struct page *find_timens_vvar_page(struct vm_are=
a_struct *vma)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (!vma_is_special_mapping(vma, &vvar_mapping))
--=20
2.30.2
