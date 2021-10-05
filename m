Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E55421BEC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhJEBeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18526 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231543AbhJEBdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19511nti024407;
        Tue, 5 Oct 2021 01:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LyNbhXd8/bp3QLzv1D5hi2iSlLg2YxMzE3gibNIb20o=;
 b=H6wkK3sVyUv0fjqSxS1uWPxaWqe158uFdHBjQbY8BbmaqSMXzguAxQrr98DzzfRMllOP
 AgoyxPBxGmdtbPZXaZlYJiAMTjLx6sla/zslD3f4W84RDlQCqdg9a8htAAAQHuIGihM7
 +Md+b8X4l2xiwigEATIebF4yMB+dsM6SZ38hMGcQnUq5FdvYnngZoQktPX7ml/RZGB1o
 Kcxca+zchFVBecI78AZd/mx0exRHw0BFUga++Ffjp3Bk0UqjuJCu34AaeSsHrX+Yr4Z+
 cZEy3FraJA6JJPhVENfZT9ZGt7PdSzDLKPYmybNo3gmV8+ay3RiWOzKVnnvfaHSVVt43 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg454bvnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3m056799;
        Tue, 5 Oct 2021 01:31:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ludf6ToKa/W3jkMoc7bJA72g15dtjrvdWZxnvbGLE+QYdlxLqbu3YfcvA8aZ0+p25HKDOMbiJu38I8wxrLYJ9JcbQsYuLd0eAXDgRx5YszgJMP02UOp/IJAsqtqdPekeletDcfpmsxChmcE2SyRpJsWB0ntdH/9/jsqpQT6acM7xYdfQBmINyBl1WZ9m10kzMvVGxl/Wu9JVshlyflyAIStB9IJm1I5xga+HpmdiHoL43GSCA5MpMwQ6y1OmlZOUthU+yq/iOZET9P5qVBE8bV3O02nCC0vVKS1s9tPCgyBfF6w6pOwDc1Pfj2ySZQztrOWGk2GGOEcHQViUnTfA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyNbhXd8/bp3QLzv1D5hi2iSlLg2YxMzE3gibNIb20o=;
 b=X9STCAfeh0gYBn1gcKUZGx+VuacPt4qY2g+CR8cOiMG1zHKTzivp+mUj1aI/fS7A9bRJAd9LWTjQXnM32al/VXvrQT86F1u2p9svEYogZOQ+Jq2nnVYFZnLHleuOjUbqu98UyQEZBEPDvff5XGwA97bBb0EMUi1cSyToY1xv15HfvbhJ/OgHiCJdFjWbAdBwx5E9JRWDn0tR8bFgpVuS9YfBEFPCB2xSgI5slkJonSBgRO9GjAkXUc9LrK5nKQFaZqroSRxk6zSxIMovmbko8Arqg9BLeQuI8vZCIwmlsudR1mPQ0IrXowgWXdZb5P4pzmH7mM+d1uszidugKUqJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyNbhXd8/bp3QLzv1D5hi2iSlLg2YxMzE3gibNIb20o=;
 b=lHnpgQ4gJTO66eEk+172sEUVPPeLmuxeAF2+pe+RwCpnFhPZG5vkZ6vxVBlxcN0bjEi8DwG+Tehdzt21ztoMfah5+Y/XrnxfCtXhBDyODmqwB6j8SlrEEyGq7tibDMYndfTW808BqLjcdZmYxDDt0yUCfoA4yb5MoJjnHrddJDQ=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:21 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:21 +0000
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
Subject: [PATCH v3 34/66] fs/binfmt_elf: Use maple tree iterators for
 fill_files_note()
Thread-Topic: [PATCH v3 34/66] fs/binfmt_elf: Use maple tree iterators for
 fill_files_note()
Thread-Index: AQHXuYihhMmdaYHnqkWDFnRa5fSZ6g==
Date:   Tue, 5 Oct 2021 01:30:50 +0000
Message-ID: <20211005012959.1110504-35-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 7e64bc8e-1286-4096-ba27-08d9879fd622
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50445E7BBBF5BB9316E60EA0FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qnbMrI4l7TqAeC47XrNvuXPFWP/2gfiKLkwKsCKiYV+CPzkzHYBdlGKGLOsvXyNwaqfm7RvOc1LRRBu4yAo6e3FaZi4z82ZeoWy+/I7Pw6MsYhGXRMFJqYLmyze44nxcgDDEBC39gku1VJJhNOzaWrB8YHphm9u8EgXeBK8hxmphD93y9BFy0ACMPUDRs9i4ANxr8NXgS7QnTepki0+rUulAIHfLiEPNLjRcVMQho7w1F+C580xoTCNtDRZn7aBDb9tyjOxaVk3HTjdHwK2TIi+UVwIs06BJgi6N7OQq5v1XcMi/Vajo0K+CSF6KfHJgKuq2N66/FnYpIK+ILbixX0JLeZDzz/E4NyUtRMHrtVce7YpwSwBzXSCV+8jLGk/YGecBrADtrYSCMm0b4R33589e8Qq3/TWL+j544T6rqTWljHmrlS7SdcZgIL/bdFxQ07GuS81B/WabrUmMjHyJvCWGPR3nVzq4mI2u8mX7o7koYLtTAyoD2Y53Erx856aasa1+tl7ajf2nVr/i9mXy2XBPtCtabifo3DZqPWh5pvgNNZ5bwGJgbWm8GnecYvZujLz/KAJunB2Mkcu7atJNkTbhd56ZEDVGJfboh3ilPNNljICAJQXLBd1FKoD1eBHz2vCZUaZ4pVxZozUzbGnUewHTWnw/Z1rYbt8c3zHtv3m4qfyaSc23EIJZD2+VKQbVmoO3rHcf6abccuVe3wMSng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?au2DVrENJUZaL1RHLihtmFRvC0NyW1YRdaPHabl/HbIhouUlLwko+aUEji?=
 =?iso-8859-1?Q?1/5r1j79Wy/imvaMyAzpnHArC0kromnvA5+S+bVOc2c8ggfie8vW611X/O?=
 =?iso-8859-1?Q?WlhaLB69IRmDvhp+suxS4xVJm8YGCow0crun9BxQ0dTRXIcODJTas0wzsy?=
 =?iso-8859-1?Q?wpbWQu4Ad0gae0jGStCcFMp8CAAM5Q0YaaS+Gad7FuWx/gpufTfwlmKnX0?=
 =?iso-8859-1?Q?XI21VybQneb0ZhCaA+9gGZR+oUo7WGJPxeUImQbATP9fZKOe7fU7eqYF5x?=
 =?iso-8859-1?Q?bVcDzjwx4PYkSQkMKwvrfDtadT3aLeH34b2h3/EApOoys2ubie0GPMPFEI?=
 =?iso-8859-1?Q?jeRvjg+kdYeb2rsw83qh2fFROlpVbc17ssHvcL1j26Ir/9mm4fFpFkxd/B?=
 =?iso-8859-1?Q?dMvt2LIBZwLtJI/w4ur4gppjoIGVGn48WNLPEHSyASAzv6VAAdGeHVzgQy?=
 =?iso-8859-1?Q?XEB+u3eYLfdifnkanba9es3SXXn0OzgCM5G3nOjI9EVk+7YSJzMbYzPw2J?=
 =?iso-8859-1?Q?pXu0nmMU7BB0jJ7XZ2ruY+B9/DGRD1w4ToHvc/uQt1uWExlek4nER1RIHZ?=
 =?iso-8859-1?Q?JzuFbtrHJ0ykoOwN3WU6kh1g43DqyH3FJEESVGOGZEZTLv9oBEYaDo9+F1?=
 =?iso-8859-1?Q?L28liBQXoaNyGvQP9y+dbggT4E68iUJFG5tWDhRGJe+9fJJEVI6kHmO50g?=
 =?iso-8859-1?Q?a306+R5W6lRTK+hWCkJoXpYbGdW0MYV+mC6t6LkzWz25L0e1gBPF/krniQ?=
 =?iso-8859-1?Q?/vTyMpnlV+zu/NsFuyWpQXLBtPmfRsRDIwuE+un/POEPjS5u9b18ApN/MX?=
 =?iso-8859-1?Q?LKPaqpgXjH9b8fO6Nf4ReqA9pXFwtCPttjCDz71vnPvPGUKA0C8i4NMHdm?=
 =?iso-8859-1?Q?dP72RZnZO1nWKWm/WADStXrePFVG3cUQvv6D076MXB7yV89qorq//5hQJ1?=
 =?iso-8859-1?Q?BIBGuzV2WqnnmVCvrWdfA8okboAMlV/R3wwbMoqT6fot12l7SQE2aZGCq6?=
 =?iso-8859-1?Q?DxhJPzYVeXxBORISBmsZPtK6c9VgPhQejLn8+nOEYDmGyGBHeGJqAJvGML?=
 =?iso-8859-1?Q?/Qzkm4ePdQUOB+m7ly+AwRE87yWsJVARP9/2ua1rFrKXDkqxwDyGStcJgi?=
 =?iso-8859-1?Q?74BKcUgOXqnltdQEUE97mOSXWheHz574ujOKEHgjcXrGpOI8yke7WgY/ym?=
 =?iso-8859-1?Q?v0GXI3P35x2170UnRWWZtG35ZcvdKObdR5J8Ccp5v9foDh0bvqEbsz1nbF?=
 =?iso-8859-1?Q?ZMGRLDEJdqI507JxpSxwMJEaqavAjwe4/ybPRK4bBX+1h5zwEm4Y2AC0Dt?=
 =?iso-8859-1?Q?31PEzUVe6ctey6qDacOOImAqwkeVM3cWdPuCGVW0R7ofY1fOJQvkfbatf0?=
 =?iso-8859-1?Q?WJVZdLtKcx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e64bc8e-1286-4096-ba27-08d9879fd622
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:50.8038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNn46RkY0ab1Af0cpzKX12zNh44bRHHgEQUEoKDdsOE9OSPGL6z0O9RYYeq0UFM7+1K8wNo9aLUUc1YBurxhzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: Krj5f1_z1nPM2ZuncAcWfj_aID8IFwRK
X-Proofpoint-ORIG-GUID: Krj5f1_z1nPM2ZuncAcWfj_aID8IFwRK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/binfmt_elf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 69d900a8473d..2954f5c5e87f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1614,6 +1614,7 @@ static int fill_files_note(struct memelfnote *note)
 	user_long_t *data;
 	user_long_t *start_end_ofs;
 	char *name_base, *name_curpos;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* *Estimated* file count and total data size needed */
 	count =3D mm->map_count;
@@ -1638,7 +1639,8 @@ static int fill_files_note(struct memelfnote *note)
 	name_base =3D name_curpos =3D ((char *)data) + names_ofs;
 	remaining =3D size - names_ofs;
 	count =3D 0;
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		struct file *file;
 		const char *filename;
=20
@@ -1667,6 +1669,7 @@ static int fill_files_note(struct memelfnote *note)
 		*start_end_ofs++ =3D vma->vm_pgoff;
 		count++;
 	}
+	rcu_read_unlock();
=20
 	/* Now we know exact count of files, can store it */
 	data[0] =3D count;
--=20
2.30.2
