Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A220E36DC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbhD1Ple (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:41:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17362 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240604AbhD1Pia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFPXv4015928;
        Wed, 28 Apr 2021 15:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3n+DfcOjhNqqmDHW2mb4Rm/1Iut02SCmxHRBXI/6Zp8=;
 b=U5dH0nx1HP3OO9r979jqE7zVQUb121HoCScCOURd4mV8ODD+rMnyJ/TYtlilBQL8e6F2
 tBo3mn3JKV2dWy0qLISPcSPE+u2yx9g9HBtDSd8hiNwgfLIIetIfwEGKGE5ddJp2fhoN
 NB2fKPcCyGHkHe/SwQAXM8FIMoCsbqwJh4aYLkj7wfWi0jvirf9HN7dJT7wZI2h9MQOL
 BhO3D6h7SmE2MP8vcAazAuDjUOKM7qEvJ7seASOd3tEDYVWr90R5+hfnUdPVrxf1e+qK
 OZAwRexR5c+1fwhnshTL2Lf4dzLGnrBrgxtVwrEXGpvZr4m885c5Sq/komJV/siBFxm8 ow== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:24 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWZKN146776;
        Wed, 28 Apr 2021 15:37:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3848eyqygy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1dHlPU1NpkrbIv93zD3vYRppQNIBR7r9yIMPWMszYNnWkYKSYYrQD8QCs4E7xsdNXqknotOWyM0udoPst2GeXx/AqEFRkVMDm7f2c4TNUh5s/32m3DfASjFTs3gLaewSrOwwKqIqmma+/zDsB8WSXpaQuIWfkIiwb36CJdkbpWi33gvRv2YKuxdN9q0Y7Br2rCeSKJJTBZpR/Y7Z1Ujhq7Iae5N5QMA1hGIFoDVNlC+YvxdCHLnYq4vBHagqZX273FdQiSdtNQPqKZ01bVYYWkvzYtrmESyqlq+qDD8q0hjtxyCxrpeJ/LsxfPfQR5/wp808g2y41JDsla6I54Vrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3n+DfcOjhNqqmDHW2mb4Rm/1Iut02SCmxHRBXI/6Zp8=;
 b=ZMg7MmI0tHOtR8eeutDR1RFwMcu+NDgL4D9OrC309dSV5n7cEbAvSbfATVMTUOJcxHt6lefbOrrU4Iw30mM/eKx+/eoQDpEfU6KhByAVWufZ3UFN6NuYt/Hw//cO5lhSFc7rz+DZxcsP1WIa/Awz8GSqVdmWxD9zHL8wWDei1ogiW/l6TljDXUJr/IlnZsaaOyIZoOL8aGxki9u/+CRoCRwg/zKu0dClIbSshhT8ckcD0SckZh171T42e950tT0aj+GZr3kU5czkKSLlNwVVZsxHo4LuOJdq3A8Z4Azj1gSo6m/5ex5vBJppuzCLIJPoKqnMLV27d4KWSaHja6Uvtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3n+DfcOjhNqqmDHW2mb4Rm/1Iut02SCmxHRBXI/6Zp8=;
 b=od9Ff1bdm855bCKW9nYdDeeBx764xXEFwm84Ta9wny3iMngkQDgBUniaxcgb+mr90oWIazJBwSRlKxtXo9lqNZKN11FVsDveakl04NAGybrhyUXTRPi/0egMASjlAbDZmd0Mj6Vdupdqzw9jMXgJzFcxcFUSFy0Y/PPXDIPx674=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 15:37:19 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:19 +0000
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
Subject: [PATCH 62/94] fs/binfmt_elf: Use maple tree iterators for
 fill_files_note()
Thread-Topic: [PATCH 62/94] fs/binfmt_elf: Use maple tree iterators for
 fill_files_note()
Thread-Index: AQHXPEQ78tnKIMhDQk2BxDDWZrK9FQ==
Date:   Wed, 28 Apr 2021 15:36:19 +0000
Message-ID: <20210428153542.2814175-63-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 9ac689b9-fb0d-4e35-a078-08d90a5b828f
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB18714DFEC89FAB74F1212109FD409@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T//X1r1ToYxpJ89YuAvJskQA7AyvhMrmKlU3RrBZs7jLYf+STcjB3NtgONjqlGA4BxeAJSg/mTOj6+5A+MyXJQS7ID02FWgHeh1oSpCOKjyXJ+VhYJ/RMDf4WM/JLXv+Gdd/HrkKzAyMHrgAg+86RK3qDJ2D69OFRjcopMdiokoxmPqVubHruCTM7kEGVXlQ33kAnjvRvhm8NEo610F66CHv3t2DQhq1tNo03XgQu/GfTNDxdW4t5bj5uVph7VCkXpUMSk7VCOMegAiafUH6oDH/V+b61nB16ajCPoES9SKHpxrSKsgvLDk34Wr0DGgeJhP7AZVUMJiF4RtMLM7zbYeiI55gOrIwk4gpAo7l/sVsVl8zfC7hfLZuLrK1nKUf8jImB0LmLt6ZpeMB0rdcSRG8F6NduqKj2mtGtxdmhGl/yWaoZrD2g7MJT3Bk3dNrSAz//eLuCo/N2QqIhGcFkkGmhsfhx5luX/2ZYOxF5nJ1/CDYTrtHXuYM758Fjmd0VPiTdkFWhZpq5w2x9ueUZrUEjXLwZKWXbf+YH4gOLb0ErJiqfeXMjY5bu1m+HH+UnX8JlQSDhsI/ROKFKz50nhNkaN635/eORCpmm99xmis=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(186003)(6512007)(66446008)(6486002)(66476007)(316002)(107886003)(5660300002)(66556008)(71200400001)(110136005)(54906003)(478600001)(44832011)(76116006)(6506007)(36756003)(7416002)(26005)(2616005)(8936002)(1076003)(122000001)(38100700002)(83380400001)(8676002)(66946007)(91956017)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?2j6j50GJNrFn1Y7xSc6ObPi/d8/+Sg1O0DDEsI0RaA8qKpWgm3tzwwFrxM?=
 =?iso-8859-1?Q?7/r8jllSJAYAZP3lAiGLtcQXWekUhaKQs46om0V0SSEUQcIdK3Lu5LfB0I?=
 =?iso-8859-1?Q?uApv+1zwJ9RrVXW9UF6JwKP7sAO2wRM/SplSwOSpSR9k91eaeE/ZNpcIPn?=
 =?iso-8859-1?Q?ONAGnFR10SQqXulIUbgwPoLXHyycd/Q2nR/00a+xyoJjktvXqCfCfIFWl3?=
 =?iso-8859-1?Q?qcR1Ehsprlh3kz7yspqrd0YAS1xKlvY9zl/HrE16MS70rngNbTvceebQt4?=
 =?iso-8859-1?Q?3mh5xhqMvAwePNsnn3//e7ss1KWe5QhgAhe1D1VBznzqe62vE2y3Uv1RaF?=
 =?iso-8859-1?Q?dg9EHqkllnMWAdSze2uzLAWdKo+ufXSzjHp3pV28hxZIxtYN+ezLuXr9dR?=
 =?iso-8859-1?Q?Es2XnR0PWXf0jn/Rr87eZdHVVqe7m47x427opFgYrLee7x8DUNCkgpFwOJ?=
 =?iso-8859-1?Q?yQ4gaurbo/hlt0yZFlEUtYOdMxFxifFCfu/yuFatI/Ob+SMtLC4QHhXwXE?=
 =?iso-8859-1?Q?cOCFV6kYE9X+BsZ+FlDGxiJc4qf2rvvwg7ykcOKGFnoJVcZOK4r1GtfxEZ?=
 =?iso-8859-1?Q?9U2kq0i9oG2gNcuz+lCiT0rqLS2OXPEsXa65tN+KPnDi/2XS5C64glfMYg?=
 =?iso-8859-1?Q?ZYawXfZQLZxrzmLM5uBa7KBrJrrFiVc39fepNsl5PZYUagPXVQ/Dcjc9He?=
 =?iso-8859-1?Q?SA13dBI54H+hcvrR8JvQPHXRcvkt6f4Or89p/5Fi/iwDo4NVN0nKejSkmu?=
 =?iso-8859-1?Q?gA3ef2bsjg6TKoRAXnLLZSb1TEfmej+EDVI/OklCsJW14dpFyDHR9A8UIs?=
 =?iso-8859-1?Q?e04j5aUzROo17mTyZwmle5WmP07UkbSC+MSM30YxoWMFKdfHVcTEpcA3lN?=
 =?iso-8859-1?Q?fwZlndylDsCcNiUuXCaMiH/K4OCd3ZOFXSB/XnFiaLzFX5VnL1m7ztgBPN?=
 =?iso-8859-1?Q?VweKtNk24k3GbXwxF1rUov4JjEmZ1Ri7ZHzNsanFK1o5Upl3W2wiaNl1Yu?=
 =?iso-8859-1?Q?15dYN4emWKI4TSGKVj8VNDDTBD3ooGg6r1V1Wv/NVixjl4gmG7NlgowxII?=
 =?iso-8859-1?Q?Htum+asMgsM73eogP0QCllu/wCEqex61+iUW1JnBtAB9TSjrm3XoZLBFxK?=
 =?iso-8859-1?Q?Sjkle1Tnix3P5QX5sbnmTv837gV2Gsgcp6Jh46Je/X7hcGffKjTQS8n43o?=
 =?iso-8859-1?Q?0mM5RbGb4cuCm/2iKWQgzxxU4ox9q4mcENqUoZhA1y/z9WXZrp1Oy9Fuli?=
 =?iso-8859-1?Q?ieIRn/Ez/XhlOIbUfN5sPHn20dSIZx94iLlCUSgYHcbff2uCJ7lU9kkm06?=
 =?iso-8859-1?Q?/dabOmhYILjFvZXVjcMfIPNzRXSMPcDlrd7hrq9zlLNhQ9jWs6PNJnN6Bc?=
 =?iso-8859-1?Q?SP5+OGH12F?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac689b9-fb0d-4e35-a078-08d90a5b828f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:19.0876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXZU2NTR+V3NEKa9ZK6kZl+o4PjSY5+bXGSYYskKF/mrtESsPO8Y7JPIN8hZU27Z+rteY09aoEO1NNb8R87+BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: tznVsksWh0kr0of-etp3Zzp0XlrzfO2s
X-Proofpoint-GUID: tznVsksWh0kr0of-etp3Zzp0XlrzfO2s
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/binfmt_elf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 187b3f2b9202..264e37903949 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1612,6 +1612,7 @@ static int fill_files_note(struct memelfnote *note)
 	user_long_t *data;
 	user_long_t *start_end_ofs;
 	char *name_base, *name_curpos;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* *Estimated* file count and total data size needed */
 	count =3D mm->map_count;
@@ -1636,7 +1637,8 @@ static int fill_files_note(struct memelfnote *note)
 	name_base =3D name_curpos =3D ((char *)data) + names_ofs;
 	remaining =3D size - names_ofs;
 	count =3D 0;
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		struct file *file;
 		const char *filename;
=20
@@ -1665,6 +1667,7 @@ static int fill_files_note(struct memelfnote *note)
 		*start_end_ofs++ =3D vma->vm_pgoff;
 		count++;
 	}
+	rcu_read_unlock();
=20
 	/* Now we know exact count of files, can store it */
 	data[0] =3D count;
--=20
2.30.2
