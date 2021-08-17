Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3B13EEFAC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbhHQPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22308 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240304AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkqVK017407;
        Tue, 17 Aug 2021 15:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FtyEl5NZhjZ+FhhIWdmDBh1zTttjtNQnxaSNY802czM=;
 b=I/PoX710af1xcvb/UOwA1BjNgxWJNejdcVOJIIjUrw1v3JYm3/hBVFRAfVdMspECQML2
 4/WQRdxnL8qTZXz6msuR35BzH/3LfMqsU5QmOD5K+Ra2j00p8AcpFZaJTui+CmsbNeo5
 /PJrQxHD87TbBYSfx7YI6sn4m1IZ9l6zXvi6562cJUL3M87ObiKX3a2H3s3IRDMIMBBS
 da9mH7Wk+4TS/zQ41hUPMjc7cELg81WtJPQlyAJoLeXUVHUgn8cixquVbgu02SPYjU+3
 7ii4V9QAdFjcVNXrmWr6/4XKSmHFiVk0DZe/wVZyI+rxbf3nT1lSHyhdYjbxVkR1qtHE wQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FtyEl5NZhjZ+FhhIWdmDBh1zTttjtNQnxaSNY802czM=;
 b=Mf2+A9RilKBq4hM24Fla3tYoOnDcNuGMj0tv9+XpZGcl9MPUfAJFBqXTuOQ72BU6MNgn
 5zI4jqHs0Eb2GtnvfVlj7xBg0xkJVKUw+XJhTfnf+FxcE/YdbCKmefR5xN/YiJl37vD3
 rGrfOfXGv7Ln2deu4jxphQn+BtHhR+IM8GOqwtmdZOHYl0Uda1Pp6LJKm0oU7oIS1sRv
 xD8KHl+emUxhUgNlZwwiGK4xyahotq8SRqgIMJ/AcevRoJsJ6lZXjJYDKICgEUVCvqT0
 CvyP/lRIKNYbJCdzO8OS6TuWHCvkGLqftxitV7kTnayrm8egildULHK+T+fQ2vEFDJq+ Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf0g6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3OU174039;
        Tue, 17 Aug 2021 15:47:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2r9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgHRU/vydEU60koAVeEor2g6tO7Mxd2RMBOwFwMqECK+jKlASeGkcZWyukVSXprGcZiR+NqUQft+tZY9n7vU87wd0ocLBCDDgGg3pQMBl2CgsUiz24nGU8YMn72ImkQk1ML43HzMp7tNQXfUrj0FfUkJHeOqrzL0obd3cACiVCyDOmZPLrPRB65TXPXVl+/fwAfEIO7r7OLI0atNcr7K7ZcJH7LbTQOEXOqZ26Uk9tX0hIm2QnF2mT7mc7dEfLUlh7NT21ozm2Y9bTKXXwXKpv8Bs0vYFydGqzrVm19YZRTZYv0nRhtqJptESWtuN5P5W6qhEDYLy1uwCE4sDcGQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtyEl5NZhjZ+FhhIWdmDBh1zTttjtNQnxaSNY802czM=;
 b=jbrfpjFg0qMqsszTWxFjskvX3iNKGZlFkqprfnAOvobuoRUJaYDt00ScOLYhr1oLV/yA7ub0TCeHVCLCH4BrjVQMtNA7DUddIjRdyaupqdsXV33SzwxhhWbfof7H6Ib/lt//2CgV0IT5NYlAbAVqs1qr6PEn9X7++bpx6exR8EQ1myK8kwdPh6GiHt5dcJ88m60vH2saBfpJx+KQWt5g8v6paSyT2GOEzSHnFQa2ZZJ2oQqp5tdD4M4xxjoLhDj4h+GglAOm3gaiha/4GhYys0E1QTGfo5wsKM5oQVDX0QgtDiQr+thpR73W+7nIRBrV35B8G4ej+hsQmHrWigrtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtyEl5NZhjZ+FhhIWdmDBh1zTttjtNQnxaSNY802czM=;
 b=WH5pnvxocJVhBN8XHUS5mkql2XNvO/Cz+mMTCHd9Ehr6FrpAJDRnApBIi0MVbWSwpAM+nM2hHRIq5ziqv2bFLFR/F3AIqLiwTpVODdW0e9Zaa6VClVcU3FI7+OzuyJ9+3eWqVGR3YiQpu9UNon9YkoToNMQ8EOaBM9YhQVAfmiQ=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:53 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:53 +0000
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
Subject: [PATCH v2 33/61] fs/binfmt_elf: Use maple tree iterators for
 fill_files_note()
Thread-Topic: [PATCH v2 33/61] fs/binfmt_elf: Use maple tree iterators for
 fill_files_note()
Thread-Index: AQHXk38r+bIWnCuiAk2dn4LmhHXjbA==
Date:   Tue, 17 Aug 2021 15:47:22 +0000
Message-ID: <20210817154651.1570984-34-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 8ecb19ea-ad27-4522-420d-08d961965fdc
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4236C16187475DFB925A4BEBFDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q6MqAnOlKByw7EAjyi0Z7ph2s1lV7sHbV236Wl9trse0H/IB9xt0C6rYj8HVskfLEX5xWY2Heg0v4MvzDDjJZAdWw6mkDEmvS+um8NPCeSyOxb4nTo91I77NRLRnG9nObT7Ib6iTCKzqYFx/bL47/YbbyVsqIITUg9LgbBkn3+1Qfdxf2+gGUPH91uitEORfLQGzk5y0dO/rgnvxjvuOD4MD2IAwDR3ufPLmBOHEan9maZlnTKDwJNQdGYmb1Y/qnUjqMkjKjCgc/xyag7jWqEEZR0ITo63UGhfi33l5PrrqL8G8wJCK+3gXnOAlb1bBZbkodRQ0dZE9s8ga9veXm/NVO/MFvaFiAwwoGTqfwtR3uKYcDoWbP5vvpDBV05qhjACjNAYfV+eaabSi5ZYWw8jg0FZqN5ed/EqNcxkhxrBGqGTagCLJtIU7BLATbfza7deTz/AC5vMU8UVG1pkwAgM8J8imA8r1M8q+V0VkI8KZCwsjLaRgRGIXHWsCvE19Xj5xJZqy6SIrBh9zS3Y8oGndXZnRLV4/+8TjJ69WUR2HWfwhUEoYBY0M9aPoq9MsZ501C6H38l4ODB2L14v9h6xfwC5vkYv9ZZxwYWlWrG5i1Hc4rBcV/wOtJauihCb3PEGtb4bGwIQmScaZSkp8lgkhWA9hp2RLisZUat7Tucs4yU0GYfLTxfrin00P3w9NMSGgpJTi2QpHBDP4SKtAHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6666004)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GxrxVYdZvchRAbV6AA6YvwyBvQR+sFaBGUMcVQsxeylB3sJWCGXZKUhMZZ?=
 =?iso-8859-1?Q?zYo46ArweqLRD55TOGir++hsqzjnsLVFSEBrXkAUtY0402H7pKEJgxIR55?=
 =?iso-8859-1?Q?uPgss8qldN+NjDeV27t8caJxu/OdSIyZH57dKO4ktv2ZOAZQXPpRfBNOuD?=
 =?iso-8859-1?Q?97HSKxNjx6YLBwlWAw44KSgbDv9x+CgLxCumk9skvpAhjTIiRWQr0S8zTE?=
 =?iso-8859-1?Q?tWPmpwOq2ct2fAmEBMxgYrruD4/4R98RscUFT8zVpDHv9MLXMSWzlOl8N4?=
 =?iso-8859-1?Q?FuNFrXPc8lri1cCzCO16SOZhYvD9PcfzsjfSS0SrjELdkuLTFrIC0iW18p?=
 =?iso-8859-1?Q?mJUeMaq9fTdlrk9D0l1DLKcJfF29cODlU5e8yDISQaY9Zv7TLr64zlzAue?=
 =?iso-8859-1?Q?ckI31HD5IuoobFoNnDpiZ6pTH4byvYCSD/3eul33wcPrWtFJTWZ9oRso2T?=
 =?iso-8859-1?Q?/JL8Gmqld8oCPFbdM/A585dYl3P4r4ZbMqVss1T02JiPJpUWAEzubY8tEq?=
 =?iso-8859-1?Q?IDHcMF4xLnzRjAvp0zKOea3uTF9FUpbPVf9hSV7pXc+JDY4MJz62HHUUUF?=
 =?iso-8859-1?Q?8cJoVoiB91+mjnT8B9GLCeh8TTtBNTKTjSUYmm+ZcLMPl7wyC3qTmhwXdV?=
 =?iso-8859-1?Q?mAy8BvJwvZtvUlE5joQQLlaHSHLlQYk77FZFP/F/5nU7mLQICZg01ROzzT?=
 =?iso-8859-1?Q?tELwgYwEQ6YWiYg2IEY+A7Pf6njhkKF0APIHxOBbbsA+X/w2Fk+5yEdSM6?=
 =?iso-8859-1?Q?ZECfTqgC7fOpmeIiOh1YluItBRvA8PptAt/k8EsGmxiDD70lQULFz2Rku9?=
 =?iso-8859-1?Q?H+q4LxdNdKjAr6lky7mz8lK6F6lmNBWUwAxxLBNmxm/Rj/f2wJNWeBOUkX?=
 =?iso-8859-1?Q?bO8uDa9Jft4XxPvvBgyM4sBtEhEMcObBN54Mm8dazyoplx3SuEFbSPFI3k?=
 =?iso-8859-1?Q?ZeaFkGNsH/IVEonpSEJaee14+8XjtSUFhiQ69hTBciYHvzuWRKrDygrWyW?=
 =?iso-8859-1?Q?G8IIVf3oTdePZH3IxQAJXyW6bzm78UYcEGRHDTyW8ZKRqt2bWLAzuEsySs?=
 =?iso-8859-1?Q?25PSKEM5Mbqt1qGmVHJ5p2aG4zzlx/7hE5fRthHUKJHEvnLww8YK66uSqT?=
 =?iso-8859-1?Q?YSw4hVwSyyN2BkmdE/iXdNWvW2YL8caB5IcoKS5Lq5uip4k4IFM9BSYLxB?=
 =?iso-8859-1?Q?9IMZNrM9Vw1Z8Odv1ibilLD/OsUA6pA6RWTJLnzZDlG59vpcG8AqPzkfxG?=
 =?iso-8859-1?Q?FeiIbFCKdpXphwkHp5gP1bgJdtMEvjDyHL1ESLXmbqQwKtX3wmR86APfFH?=
 =?iso-8859-1?Q?haWNAYFYQsNV4mQ/cjrWcWXfRZHseAClWIfVw5lRBm3gSHhFFOsG7q4ehP?=
 =?iso-8859-1?Q?lcHHcu9l9W?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecb19ea-ad27-4522-420d-08d961965fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:22.5323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6qNa2DBlITxONOt+Giu+t/hS11zaoipAn/CbCFPaE0IfNuCCGEMFFg/NpsqIpliT9bbW6Ho5I+ChJCY+rlpcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: yu5QTIn6ZMssxsMga3hib_FXHBBSuMKe
X-Proofpoint-ORIG-GUID: yu5QTIn6ZMssxsMga3hib_FXHBBSuMKe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/binfmt_elf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 439ed81e755a..4a13324aaba1 100644
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
