Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF2F36DBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbhD1PhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:37:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31270 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231384AbhD1Pgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:36:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKha8029931;
        Wed, 28 Apr 2021 15:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eKpAQ9AOCMqOga3JPON6F6N5e96xaK85MgMiZGnb7z8=;
 b=iTjm/JZBYKoakK2ANTYLD3B7FGnxbCvHgCIuiibgBOf5eTnra0K+FAPHLO6zZrUW6Qot
 DgxeqPpbP6kqYDR4G49So7mz00mT34AFCPyuMsg576E3dL50AT+R+fFRvNpT/6Cl1LlI
 /qz5vdtsnmzz/7e6sViHvIX46c8F60pQAsyBCbz8+t+ytf8CjvkfrEmME/8XgtLmwtmN
 kB75EpqR36co1tvndLj5o/kMktE9Xo2RFhVaDM1rYc4dKh+iRB+RN0FpSxuT8YoQsYZf
 J6QeZg4Dssyyznblr8AkmLHl1vSCChEfGZCzyIcE3XKXIQfNfn1BRUpi4mnagasDoVvv 5w== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh61k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:51 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAT003673;
        Wed, 28 Apr 2021 15:35:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdW2WlzO0Ej+qTljhUDLWirnKpJAE4l22efYyO1I2WUaNWRLOq5mCTHlZ2KHKeH9AXtba8FJ3SUJZfgMdpZQN6hAdVh6W/Qsngd+XkQCgVZD8tFrsGAkbSt9HW0z1lbGl6QYk5bOdXvoPgvI7Oa0ZZX0Z6YX7/W7RCRS3n4tQXNFsdKKI9sDXpfeUL6M6DRaloEJ6GGsIB8/zafu+AT4EMXgDBAsUWIcqI562Kz11xPcSiTf4RuZmCEgDlZjk36BAWFdv77jLVe7e4YAUY3M/GEN38XOJpGAqyUMYE/yGES5bnFgVg1Oa60vuxIBnDnXJVbUTcYJ45DaE99SotY+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKpAQ9AOCMqOga3JPON6F6N5e96xaK85MgMiZGnb7z8=;
 b=mNX6Rsx4LUjgnQwBViqcAD0I9XpcY1ss3R6AXbarCFU0Fr7BS5pfVe/GS7GTCzMbr//ZTzpQ8s7PqZHDHKBJB3Wnk+3AIE7F3W7HgljXVRkpAEMlE3HSTwWvLLOq2Oj9Gdg/ln8FgwMyZuEWV7q2MSJUWxJiuNBEgHfNTZ17z8YRddyGs1WfquONGAO4zNS/6eSXogj1Ho+aXHeYafmBrZQDGkYnfF5i0uDt3MpiOG/ky6XaHLUZEBcTs3CstJxVypsoioDXAN3n8OrZ3FfVgKirwjOTmvfnByZpD6EA+3D0hmfWW+96jUi5ZKmuQcNxS/80JAxZfnBsn6FngyD7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKpAQ9AOCMqOga3JPON6F6N5e96xaK85MgMiZGnb7z8=;
 b=XGRYJz/+E/EbK5xultfDnVUCfSVrLhdHvCFAhpMR4qJ38LgCNji6FhC4GJeiu9okYQ2F8XKvqzpuqS38KLdSzWDI6T98/h3xjsHQq084ErYBqZTLPY0KNSU610Sw+eeBXcp8eccB695Kz0e626rwHNnoh+hbioksRlsPbe5md3c=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:46 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:46 +0000
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
Subject: [PATCH 07/94] arch/mips/kernel/traps: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Topic: [PATCH 07/94] arch/mips/kernel/traps: Use vma_lookup() instead
 of find_vma_intersection()
Thread-Index: AQHXPEQoPgGZavX84UqTAudtapKYAw==
Date:   Wed, 28 Apr 2021 15:35:46 +0000
Message-ID: <20210428153542.2814175-8-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 0a864fcf-c0c0-453c-37a5-08d90a5b4aea
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44973F54FEAE56F742C335EBFD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1VhPqH0hFgVNpbGRt9X9A51ueXCaihz/DXEkbjObMzl8EAzcYtU6vn3QyBFkPwCZ56JrC78aRPgfkA43eijhfYvWfrPm5i1b2QXXuG5x9E8axlxzQxcpiMksW6WUyqfkTOjUpa6MOwkVM7q78vNP955jpU54IfmGY9iEAVYuWZdD41EoWjFFWaKwEKgAUaI+rLANKj9L2Q94ndrk1nVJHyH31cuPZrWiw+RhAIcHT2ncDh3Dqb5d9+AHnT2v6teDIEdKbiiSALKoFaq8hh00guhpluGgXfaDOL0PSSTbD9BXWoGWsD9gGEZuHp3LcUT9UZXKgIexR7bH9w+8ew043n+s/ojFKJCuK4pEBn34hm0ESjY7RHJDTWa/Terwf/8ovJ5lIXabxUpB2yB0GVY8DmqBrDIfB+lw8voUA/wvSOwfnJYZh7vkGXm8PKWhMpxTQPzX44V/yKckSsVUGitwxla6Ui7poiJ8KAqSX2pFv/Bm+42IDtcndKgQAp8Js9t1MidS5TCKK4IU56inK6KZOleDcz8Gosvapze56sUeZydoJiFTQw4EkxS3iJz3dlov44Yxh371gUkHzVFMdRJXOUBarLtUfPRDtjWvqQQsQu8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?LrscCmCNJ3JO7eQjf41GgA6wFwQKoZC9lS/YlRWMdjwphBvzJacbaGWq1P?=
 =?iso-8859-1?Q?89TbuIxBjlim+HFRTJJtq/iIC9462FWWNL7qZw+QST/6byryMJsLieWrBC?=
 =?iso-8859-1?Q?vCZniWL9PWEpnAW2ue9/rpoUrJSOromlR46KPveqa1c/5evYajmW/AkFKG?=
 =?iso-8859-1?Q?4ETSLo27sUM7mGT2ONt7KfHhutOZNSflei8vLH8qP9ZsDAEs5wnhOZjU8Q?=
 =?iso-8859-1?Q?mK0NkHXGrQG9/sRhFUEcbkKy1/HPWUot8LqUZ2Xl59/rhDcI2LTWaSdNzj?=
 =?iso-8859-1?Q?fBPz7p6eI2T0Mezh67ZmEt64m76ZrxIrvcEQwkfzWT238+OsvuwJ9kZm3S?=
 =?iso-8859-1?Q?IM8GBP6Asq9w6XyL6Bh33aIZ0OlYl5UKyL3dpjnReLj6p2mWLJk8GL1dLF?=
 =?iso-8859-1?Q?X4iw1edaOa9nNLhM/HpMkRUyzYUj7dZ0OuEnwykV3NIZECXej5yNM1SgT/?=
 =?iso-8859-1?Q?ELGj4r4S90spLbfIwAU+ifpKFgHD9/J264L3/UWizdWPXW9y1lsrRM8jc1?=
 =?iso-8859-1?Q?7VrrN/TV/+36NqY4pIEyWBXRRF0urO/41SXN80unUqHVPija4mEYAgbBIy?=
 =?iso-8859-1?Q?LYoRR9uSmR2TSBK9SXotfrPHexi/cBM2SQmF63zzp50fctj6+qj1ppGX05?=
 =?iso-8859-1?Q?zkQHRfLacyeBIzROt5xVZqVKCY2M2xWZpjbagb4H0wFadXxp147uS5yBTU?=
 =?iso-8859-1?Q?yR8dXtdsNpBmxniCQIIGvH/WJFwJTTi49s444viXiBG8NhDQwaPeVkg4TS?=
 =?iso-8859-1?Q?Lg4vgxvHz2gHTu1cxWRK5PfHFnhv3KgZy5JRY9PdM4qwf6oiqcckQe5H1e?=
 =?iso-8859-1?Q?kXQzSxuF/eO1TNWxfnwBwFSJWBf+87d7eGN6LF7vWYR4Ib0kBk4/PIRq1R?=
 =?iso-8859-1?Q?4w3k14Ig8vlLg60zvP5f1CdKIOngo4LmYthLhlb/e1jOHr+FVxd6IDjicD?=
 =?iso-8859-1?Q?iRssWx+YyHM/OMK12tQbMjB8LyUoMfF8pNZa5LQlI0nmDOCMMnbRJsKHE9?=
 =?iso-8859-1?Q?GykHsT1HcLYkGlBJgtu1PK1BJS3vNa6CSsXYYXAwxwgrx40snQ3VCpSgsB?=
 =?iso-8859-1?Q?2i+P065Jwr1lfLjecemacimsSyUtJdDdsGZ5SkZAWK5iR6DOhUZYTUhDpr?=
 =?iso-8859-1?Q?UtqhDzvzj7BkPRfoEauM0YWWoOCPM/71fWpKlk0IfIrwb5z9OJwOokbvou?=
 =?iso-8859-1?Q?nldyWxXfQb2N1kPMFoN4OvpcMOwHz6OS3nQhkGUocjWwM1W8Pll3MB4VjH?=
 =?iso-8859-1?Q?sIOep0P3o+57rx8qC9Wb7AZaXH+xCCmPV16okF/eNBnAwgqtUYR8XMo10i?=
 =?iso-8859-1?Q?v1syj1CmLAuOolgVFLHLfMZakWyU3g2TEqgLcyR/GNGeByT8SQjFHSVbAl?=
 =?iso-8859-1?Q?2R9NFeTTfgr7DyDQ+pbRPWd3KyzlAHvA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a864fcf-c0c0-453c-37a5-08d90a5b4aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:46.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+f9mFcP0s0QmZgFfkygmnFY1K7+MbqrpDh0oc5q6hypumUritbwmUsR5Mi8VFUPu95Soqu9LqPk6Lgzbkd6eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: 2kLSay2X_4GjxiEjCMyWyhcke8VnJPPA
X-Proofpoint-ORIG-GUID: 2kLSay2X_4GjxiEjCMyWyhcke8VnJPPA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new vma_lookup() call for abstraction & code readability.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/mips/kernel/traps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 0b4e06303c55..6f07362de5ce 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -784,7 +784,6 @@ void force_fcr31_sig(unsigned long fcr31, void __user *=
fault_addr,
 int process_fpemu_return(int sig, void __user *fault_addr, unsigned long f=
cr31)
 {
 	int si_code;
-	struct vm_area_struct *vma;
=20
 	switch (sig) {
 	case 0:
@@ -800,8 +799,7 @@ int process_fpemu_return(int sig, void __user *fault_ad=
dr, unsigned long fcr31)
=20
 	case SIGSEGV:
 		mmap_read_lock(current->mm);
-		vma =3D find_vma(current->mm, (unsigned long)fault_addr);
-		if (vma && (vma->vm_start <=3D (unsigned long)fault_addr))
+		if (vma_lookup(current->mm, (unsigned long)fault_addr))
 			si_code =3D SEGV_ACCERR;
 		else
 			si_code =3D SEGV_MAPERR;
--=20
2.30.2
