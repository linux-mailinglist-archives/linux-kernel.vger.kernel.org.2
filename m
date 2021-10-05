Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC72421BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhJEBeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51926 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230366AbhJEBdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:39 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951BZjU010255;
        Tue, 5 Oct 2021 01:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=++gcCdGM8uVYpNf+4XchV9rALNJhncj8MsZUY6bEUY4=;
 b=dlkPCHOPdWEhn1aKnRwD6U7eTdqAc7hPKiOJ/d31KJqQLG9gJTV3O0CTOSE6lTtmNzE3
 MUmRUdX+YjBUDLeXjkLXyvI7vyXbkmg9gGaiOTymInVbuLGHffKwQxreeCaIEnEn1Qhc
 s2Aq0hLveIqC3cT1Qg5RepFHc4jw4bwdsnFWA9J4+xY+jBr2TVNhoW/lHIoOn26VsvNf
 2AjQCZepyNog5CL0dJHEKaglVXvNma9Wb3LsFwZsXwr+t99vXzvWPvzygs4pMqTOl+ie
 apDH6LVvwFXACvrXOg3Ps00ec1wTP9W4o9/UqBL1kJXdHP2zmGN32ACDZj269xllwg9J vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3upv3bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3i056799;
        Tue, 5 Oct 2021 01:31:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTTNR8mtbjmk75KC0nxJ2X1RQUkzBWRqOPQFGIHhJySqqTvZfddXY/NRl7aR3DDZIaJ5eeyniGpKRB+yqtDAzB8QF14ziMZiu0tXS8UrS4oiCArMkDcYYZHl3jZsMcgdfZxFpbVpEuygvKjwZZg3RIY7xIOLrf6W86BpIv+ZaKEcghZwvvpW7mxwKS9WjjJ0nxxAmk8cdehN+J+xfqqjT/oyho4KSjnBQmkI23gFW2enmwUd98ySHXXe7rgxbsfwYzG3KLl5m6hisfKEBLPdCnw9/BNUm/oX9zeLsegUauCAsGPCbl3h7iymaOJl62iCl4Wf3hwx82DABuPl6zZ3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++gcCdGM8uVYpNf+4XchV9rALNJhncj8MsZUY6bEUY4=;
 b=GZUxLIlmrbDv9F9kxFVBs6xKToUQxX/irFX/ZFichF/F6eqlirAHPBl6zNzvQHnGgZmYiMFC5tlxVCVzitcQO8HNUP4IU8EAceBYLJt4NTChAS1/M1tpHaXJ3dZt4sTHsYQYNhxL1aY7ePG6/jWIpD9rRbreHcO96MvTbYktxZbqMJiDj+7Qpg7cV1tQ0VohY/xlOBR3Y4RveXcVCgOxE0paFMTY4JePXAsFXrOk7/SuVyKunFdYQ+mBeAMggiB9EUuH9Nd/Q7qdqr6m9Gdfne9GFJY2gZ/J2OuBMY2jsUBVRP90Kpm9sUIEKuk/38d+uVmRCpJpz8XymRyQWaxeiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++gcCdGM8uVYpNf+4XchV9rALNJhncj8MsZUY6bEUY4=;
 b=FbSRz9jVATd1Jk2fTPo4t8DlpJtLKD1aYUzq7Nf42+/nIYgNz58JdLwYpIM1TomFnrJnhaiYOp/v/N5qJFDHULxKmOlZOjceGxloNCumYRAeEg4u8KjEBtjX4VKZPjf8E14fDJxoFktehXHFWdTgkjVQwxjxGy97/Cz9mas8BFk=
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
Subject: [PATCH v3 31/66] arch/xtensa: Use maple tree iterators for unmapped
 area
Thread-Topic: [PATCH v3 31/66] arch/xtensa: Use maple tree iterators for
 unmapped area
Thread-Index: AQHXuYigBQj/x4OK1kiunwQ/38SMew==
Date:   Tue, 5 Oct 2021 01:30:49 +0000
Message-ID: <20211005012959.1110504-32-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 7db497b7-9a72-49c4-3f1d-08d9879fd5bc
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB504451CDA373E25B9D185E56FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W0ujm+SAkyZmAGbNv6T5tmssy+S3rjqcHR6Ow1ESeum7tNuUuH2Q14XxwMCJAEUNQKngbACOrcZzcrg8gn/ceSrCJz1iCsC6XyAh0eBYH8bTCKIwBGf66ztE2nFkA14lPG9c+yJK1U19Wq/IGMOP/ouq1Oa7rzx86nDaFfWR2dZTM6MIAp4LOP1b7s34CAtpxuB0J0hSbB6HoRgcPw5lj2EH3V9WEW4LASm2kO9lpEwD4YnC7IVfT6YB3aB3Gnoy48esVsbqiRLr5puSD3E0e7OMg8lqhccD6pSgAzDbiROQR+hKiPu6dEZjG8//D3DreZ3nUf7y83FShV2jjzz5409+tVpxTsNPWm1Hu3d0bxP6DlIrmj/RgyskncQQK8ZCyqo/nR/Ogv6KA25Tap7GzHlJvm4faE9KWoH9SmsYXj+zTJAFPFz9SByA8rBo49ADAXaIfVQcyF9SnsureL8NPxvgEfmjOZJYPpi4iAreMOVNdHY30F+rzJNUurJmXgn8gVAqIWZEpLgl63gf5Us5MoR/k5ZOViYZgvk0Zk52OsTCg+iK6UjVgS/IP0c/RWWawAI+JoxiVPphkf5opEynvu4VzopqTuMNETl8CjyxCC4LG84gIffSzCqDdrWRjnSAl525zpGyLHqXlGe+3bMZZLwcTPLf49xnLZ+zkVkLuIhjFbwNCkIogt9RKINGoXcJUlDX85YUh/U6Il/GfEpeaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(4744005)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LQj2jZVbIDg6S8HPAHAtQjXNjrbQETvz8WLWIue2wR2uMYKe/9AT0g1pn0?=
 =?iso-8859-1?Q?52sIpWVDmaav1k6OcnxIzG4k0rptO4xzBg9vIxKH9XMQp6q1DJD/4IlUM0?=
 =?iso-8859-1?Q?JHomtekpFQbJkfmmlpGOouWnzaMgm1ynIZnqGAdiop0OSwb5JRjftrHIcW?=
 =?iso-8859-1?Q?5MfR1t76XQVzESMycC2mQIZ1UVrz7jmfNGFACkqIEe945E2hIaY7SqKnLV?=
 =?iso-8859-1?Q?pYisvfVgkfuvRNARHfDrL2NDUoxMWSsG7Wocguowaw5YuWOMcU2vS0Re1r?=
 =?iso-8859-1?Q?UUTMGrCW2S1PfYe7DkiY9BQLHs8q4o6b8Ym4zjPEe/OugxlkCUBWw3LRnh?=
 =?iso-8859-1?Q?uLCt6fn1Ve5rns0Q7m7F/SDIDqq9bU1xhX6JhSEHiTc+nVVrlwKe8GxiN5?=
 =?iso-8859-1?Q?v8X9QxO2EGCW1TCAsKrtWP5hb0jd/xoBy+EDhhXzLuqbHVF8ojLLWnxx7F?=
 =?iso-8859-1?Q?jmDclBB1rqr+H9rQxHCi5/mDmMtUJgXqMlhRQTXI0sqrniZArJc7UcgnP/?=
 =?iso-8859-1?Q?kF/YDNVsd3kmYgSRz0lFDXI0JcZJz8GxqA8+sbasTCeN5Q62+lSEQp+Vvq?=
 =?iso-8859-1?Q?wTB/UDpM98vxwDx8GEw2UDQ60FD9upV/p+lSIFFtXWmrEvOKtdzwbmnvK0?=
 =?iso-8859-1?Q?411djoA/w5yVtAnZY3NjqJgfw+zVF3rSSWC+lL5NdAAQtrqCZoS0WOtUZu?=
 =?iso-8859-1?Q?DZxv+FWkx3pPFAc2fSzSetQEsV4ds7WmLJSN8V19jYStO9EIq2p8TXbcgV?=
 =?iso-8859-1?Q?lTimtA3Uj6wan9EeWMBbxvwx8AqKJ3953djVVgpB9avrCfMGN6wrY1SzXa?=
 =?iso-8859-1?Q?4FohreK3g3wbd/dF96cgABhtD46IkUiySjx+HKjo+HzO++70v/XbBLvqI7?=
 =?iso-8859-1?Q?YkjgU0tZdMDZh2ywyqVG2Su+Vpg/iPJWVFJBZYXgJKhmjfPGveMsPmOX6B?=
 =?iso-8859-1?Q?LaZAqWw1Y0WimfLuTsH8UhWzx5wpMjw6oDD1krZdPCeNDSA5ahMMEtPRTk?=
 =?iso-8859-1?Q?zrbkEtWUw/r4SbXuoG3EBglfV/B4HhSNhBeo2w/eUUM/EsPn6OsnaRwmVc?=
 =?iso-8859-1?Q?VQIIbVd4AjYMHx1fbSW/qQG4snBD8uRwedRLLyDKVw9JmctM1OnG7HN2pN?=
 =?iso-8859-1?Q?VqUXeqDgEn0xu/3SUvh+r38cn0qhvc4euF9aiTNCXkCOWXOoXzBEfGq1cS?=
 =?iso-8859-1?Q?UUAxGgamxN5WR1uqOoyv1uAT0xsSqIUz16/gbofLu+aW3EctsN5YomKdTI?=
 =?iso-8859-1?Q?p8u4XLNnw7so5Vb2BKas9UvtmHDB05PeQRqNR2PmfwqnKTuQpqFolzAxun?=
 =?iso-8859-1?Q?30RbbqNQDbCW8+WQ68wfEJ0pvatmMRZ4pEW3+xP88MzKGDCGoD8C4OcJk4?=
 =?iso-8859-1?Q?QS8rvgwHqg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db497b7-9a72-49c4-3f1d-08d9879fd5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:49.6885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+rtJ3lQzOYMfb0FRpBmpOhggsXZZ3FStH2hOctMyGFC1vOGNEaEx/7aFswN8r+hvUorpHIXTJnaRAW/V2kDfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=946 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: m2cIRR757TuCr2FfFBdSsHFn94G0nxyv
X-Proofpoint-GUID: m2cIRR757TuCr2FfFBdSsHFn94G0nxyv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/xtensa/kernel/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 201356faa7e6..118fe0ca7594 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,7 +80,8 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 	else
 		addr =3D PAGE_ALIGN(addr);
=20
-	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
+	/* Must hold mm_mt lock */
+	mas_for_each(&mas, vmm, ULONG_MAX) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
 		if (TASK_SIZE - len < addr)
 			return -ENOMEM;
--=20
2.30.2
