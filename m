Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD3536DC19
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbhD1PmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25752 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240052AbhD1Pih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:37 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFOV0O009944;
        Wed, 28 Apr 2021 15:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wMfp4WppIg35KUBZ9tIzY5+Ltn3vQE/1TlJhDKw2cQw=;
 b=I/Z96fsaN8eqvN39+hYElfRG6u0e8c6bzG5oKlFFUwzwWwLv6StQsY8B9aM6XA/87f7o
 i8kRfTAgmd4/kcdlMYYCPibnMXuo2kNa92VmG0alyozg1licU6yQ/0lc1uG0wxHb5EJa
 JHFfju8E8I4lvLclp40NLaBJGMs0fX64VV7boH+gfFWshrqPKwFX2tqNVTl8QvtCKera
 /Gybm98iJmLfAjnYJSEBSz0BKFg6tT+1en1bNusinUZ7UEM5IAELegxIGpe/km2pSzgh
 i9dG/Hm4LdvHl0QHe8KWwwUIpH/IyzCCL5bYZ2K0kanx2LNXB4/a0q7DLQlobZsMXJ07 qg== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 387a2mr0vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:32 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbScs033031;
        Wed, 28 Apr 2021 15:37:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3020.oracle.com with ESMTP id 384b58qpxp-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmQ2YHbFPX9EDq6NfCrK1kPoswv/qEBRheFxXLDViINyDmZamNmI4AEAqMjjoT3kOhrIzSATlFKPxcUy6udSneeadFm5SczSmnh2qd3TPdMwbmAMQQq5eVIAG8Sg4P/MzBqDnJ2uLCaT5V/nbWqwcR7freA/14m3OTqFlRC+oUTJDdhfLLh7wVpTfaR1MGA0m9F/HV4Rp+fAtB0chZdsldGAuGklYzoZXpcnqiVzUokSZoMkXM/ifwtLGUNgrNjKzmm9FwqvtpaOwPjXZfru3OrUpXzhJ2eyBS/gB4kyZvjUzdZcp25XYg5x8guRY7HPd9uzeDwPTtwi3jPZ5zK1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMfp4WppIg35KUBZ9tIzY5+Ltn3vQE/1TlJhDKw2cQw=;
 b=LR8g8CyEqdakH/k6wFbffRgYk1DSLqrvxqsV1yh1Dw5G5nvQ5bLxuAvdsJRxjO06LS398D+J8W66pWjQlY/u6OJvRUipu3TJl8lVIUy98oxdtx3dd1nrMvGV5FTJcJN0bYeMlBO1QZKTmZlQdNkdOgYTwVVjy+RldME7PnNGDP+A3w/zrJz4wpf7KL9v+RC6dxgFFQzw77b52vUvNp4oYqGU4uYfMyuu9TdZ8KAfW28pdcAXK3Lc+mr1bl5TvkZTbJJpkpV3x71UiThJyJmlEYMdDg4uHlQlvmr+OQ2qE2KVhnNi2YPMBPnhDgf3jsFUUr5fnhelSoIKob3sZCsPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMfp4WppIg35KUBZ9tIzY5+Ltn3vQE/1TlJhDKw2cQw=;
 b=YwhYYkeUlMknEUAAzMlZfPn/O1Dokmt1Lkn6RUCIbhFitqtXgBl6xM+HjbG8bB7w/rtibg/JdnS4OIQnq1sf+h25NIgoIDwMirw8cdhz36jxZhYiUjnH16F3kB1JI+w65Nc9WcfGnT2lHBEdgw3/JFnTmim43O/e5gMtqlbloDQ=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:37:26 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:26 +0000
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
Subject: [PATCH 81/94] mm/mlock: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH 81/94] mm/mlock: Use maple tree iterators instead of vma
 linked list
Thread-Index: AQHXPERAPgLmUqJ3Y0SZvfyMIeh0Cw==
Date:   Wed, 28 Apr 2021 15:36:27 +0000
Message-ID: <20210428153542.2814175-82-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 568bf43e-4a9b-400e-0493-08d90a5b86ac
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4548E4F348AC7AEAD7A8D121FD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxyq4E1RPDbXQ/NolVgIXbFJq6LKEjDj2HUEoqP2thQgzc2lLF4pXW5VCSJWznXraakLpjOQtuX5/DSu/VynXNva/AvudqbQqqZ3SKgB86btNLfK8DC8E9Q1KHl31dsqg4GJoV92tTPz6j70uWA8fZUo1dZMbeMcDNv6aTTzqWZP42CNJPD1aqFm0mciMY2Ef8EaF+zC5baZTHHpyPw7J+RjmMW5R6OmAo5E6a9HqU2DqYiG5NxiTuf6RS7qy4ALnqVgcVs7uod6Sa07J/ENwnCGxo4NCoLq5YOsNawSV6Ieeak2nnoydUX0gIk4lnDdwmxOk2sVu0eer3XESMQssIbCNQTIhUPI/abKGWy8JHa8K9ilZyqJT4ykJAolAMU+BB1k995gX7jevjHkipju3FDIFs44lz6H0g3Y7HOEhHxBsgk05oSFVlVcgfn6Bap/VavaCgjYkGxiJ4HmOb8DmHGTZkWDI3Y+2cqIRD/9EVF8c+ay9YmJ/TXMRGHrpR4pJgpop4rmmZdoEjvTpdbf305Kc0YYpk5QCpSyRUSvYAyX+WDAX1S5QX6EeK5Xgplrixr/5ujgTz7LBpAuq0hPpIQrzuMAqL096kuCWMbJG1E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6486002)(71200400001)(5660300002)(316002)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?jiT2q4wtOWEwAqD9cI5WeRhLm798flVw1OaZBV3/iqYFqveFC3SmhmOfcB?=
 =?iso-8859-1?Q?+wzglVMAVtkc/Cyl4kjwcUD+jWdAbwvDgUSfnSLCpVvAHDIAwh993RYz1f?=
 =?iso-8859-1?Q?H5t931fgwR/cRDjN46ZKyT5h3HTaEUKlvwXafqRnt4dgptv5w123AUK6M6?=
 =?iso-8859-1?Q?R5vTtEMSM9bVeiatkUdvtrd/1ojmEA1dt6icUXpSXkISK6K0VuvrGA4aIA?=
 =?iso-8859-1?Q?SbM+adJCjTnw4/1e5D5vaj2vNCd8zZfS/+Dr47Mgg2Kb1i0C3muXIazp0N?=
 =?iso-8859-1?Q?ihEcJJljm8yBOwnoirUTRAHrKhSVkIsAXudcLz2CraGx/YksInvU5Esggh?=
 =?iso-8859-1?Q?r4UChjyNR3NeadsdSNLIww7SZgI47USTzvuMz9rNvLH98BiKMFdIe4CgLd?=
 =?iso-8859-1?Q?TsZCCI3wZcTIf8MgrXGv7oIPVi2MGGaSHuUrHuOpXm6Pwo+hbXv5MGtIRX?=
 =?iso-8859-1?Q?8/kx3KRmb8HZYjaQWmCzXAQv/yggzYE4fNn/KPFyPfcJqy+wkbg9z8e9Ia?=
 =?iso-8859-1?Q?rUAODkReUotxYQizS005l+vpOvCeGW/tiAPY2JuJDGXo3uSYMWwAzPLAQj?=
 =?iso-8859-1?Q?pttblJ85qjBag+NTAEjIRIm9CsIGvBZthz5EX7i2XC8pjIHfjlyUfyv+u1?=
 =?iso-8859-1?Q?rcRJF0F06+443Fqq/HL+q1z6utAl8+Xy+Rd3UTyqkhAftYBXtDSvSStET0?=
 =?iso-8859-1?Q?B2m1ql4KfDIWJJ352FQdPO245K7avp7wGwn5tqnjzX5ItaoRnvqNyPpCuD?=
 =?iso-8859-1?Q?P3w/8kuRIv2BQx6F2z5IKwShMrcVSDdxLYhVvd+xQXx0rYekJNCrXxwT0y?=
 =?iso-8859-1?Q?mkvsKcdHTPh8vY75YTKyyIdXhEOgKreiTmnvqNvuk8x6XJ/G1ar/oK5xUL?=
 =?iso-8859-1?Q?imWVYtVo0gq+njxn2cvR7Rxv8WVgfhRxbp+aki1V4ecEafv700WcGWNLOb?=
 =?iso-8859-1?Q?hwtquqiNYgTsMEDf/oSp3rtSDW91Zc9ZqAAij2j9bs6PWOA5O/H5xNJVMp?=
 =?iso-8859-1?Q?YxOUxN16kNsMcrSQJQ1TMSHbqxahGudq4HLR/rJLZCViHX2cwl0jPliWKN?=
 =?iso-8859-1?Q?k9fN51tdyowY0Nsjv0cIJdJIQmdiuTGfL5mLjxpnfoOigGh/J2AFYlMaH9?=
 =?iso-8859-1?Q?imLZ++3N/nfxjjf8LfV1UjdC7sK4Lzd6qbRgAllNr8yuFTHbQlgRmyIq0u?=
 =?iso-8859-1?Q?ZtFjNpK9Z6F/NKTi2HP8FgotHp9MuG4jhRU6/39qfH4FnYqh14Tn0SyPgO?=
 =?iso-8859-1?Q?+bSxFzyjheR64EMfoW1jELRoMF1rgEptH87Do8i5k+jKMh7s0sUKhrGnHf?=
 =?iso-8859-1?Q?JTglZVkxyMCO9blSx6Bkp3AUvBG6EnZRC9zjlQkdK/Hd+a6acIFqookGbD?=
 =?iso-8859-1?Q?SHkQofH0bR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568bf43e-4a9b-400e-0493-08d90a5b86ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:27.4190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQUMR2RIdwnAwZnM9SthXVfb3Z/8eSkC4kMf85ILRUsnPip2z33EWEeGAoydcE5M83J9CAoxzxsAOtjBi/G04Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: YzhuiqPgsm7UjRDPGhJq10kF9RH1AbeZ
X-Proofpoint-GUID: YzhuiqPgsm7UjRDPGhJq10kF9RH1AbeZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mlock.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 5e9f4dea4e96..c2ba408852f9 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -562,6 +562,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -570,11 +571,11 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D find_vma(current->mm, start);
-	if (!vma || vma->vm_start > start)
+	vma =3D mas_walk(&mas);
+	if (!vma)
 		return -ENOMEM;
=20
-	prev =3D vma->vm_prev;
+	prev =3D mas_prev(&mas, 0);
 	if (start > vma->vm_start)
 		prev =3D vma;
=20
@@ -596,7 +597,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D vma_next(prev->vm_mm, prev);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
@@ -617,15 +618,13 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count =3D 0;
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mm =3D=3D NULL)
 		mm =3D current->mm;
=20
-	vma =3D find_vma(mm, start);
-	if (vma =3D=3D NULL)
-		return 0;
-
-	for (; vma ; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, start + len) {
 		if (start >=3D vma->vm_end)
 			continue;
 		if (start + len <=3D  vma->vm_start)
@@ -640,6 +639,7 @@ static unsigned long count_mm_mlocked_page_nr(struct mm=
_struct *mm,
 			count +=3D vma->vm_end - vma->vm_start;
 		}
 	}
+	rcu_read_unlock();
=20
 	return count >> PAGE_SHIFT;
 }
@@ -740,6 +740,7 @@ static int apply_mlockall_flags(int flags)
 {
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	current->mm->def_flags &=3D VM_LOCKED_CLEAR_MASK;
 	if (flags & MCL_FUTURE) {
@@ -758,7 +759,8 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -766,8 +768,12 @@ static int apply_mlockall_flags(int flags)
=20
 		/* Ignore errors */
 		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
+		rcu_read_unlock();
+		mas_pause(&mas);
 		cond_resched();
+		rcu_read_lock();
 	}
+	rcu_read_unlock();
 out:
 	return 0;
 }
--=20
2.30.2
