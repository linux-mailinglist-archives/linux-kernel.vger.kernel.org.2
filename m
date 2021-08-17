Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31533EEF95
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbhHQPxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:53:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29188 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240226AbhHQPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:31 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkF7D022508;
        Tue, 17 Aug 2021 15:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Jbw5atURRhyIIzaH+ltrvXt3bxGqwb4c9lv39LgYV/k=;
 b=mYr6QDh7Y+hDL1hooaIosgk/LgYs7gokd05R9L3xW2hvHAUXx2yCe/9VVO+ShTmnENFZ
 hbCSOgoulh3O6vQzSmbh5LC3dOd6n3YW7fY3qwiguuiCMEDhk8XDu53xaWx02HuHxw+6
 E8cawssQ4F7X2K8dNfN1zURj4XmR8YJz+gfYzxtYSlOFg4fOiR++UEKGU7SYCQ4+0h1K
 jVcGmhYe6y16eVttuTHndEyiSUGDGv/w9BI01HZoKbGP/I221YvJNbX7wK0XiN+LLaPs
 91Y0T8Om6LMJeuG2Wcph84Y1AdCJw2aWjHFfTdSlTBMz6kO5ZmoJlFtknARgEZtGfYGw 6Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Jbw5atURRhyIIzaH+ltrvXt3bxGqwb4c9lv39LgYV/k=;
 b=YjqejzU49UbT1cOTm4xToN60ZgAn+lzpUr4Dw31ZNl7/F91w6TfsH2fDFy2bN3VdGHtk
 hmfGMSIIK6AJZnVfE6KJ9ERT7B+L0A4j/+jpKtUq57w2s+0xdtPpw3RIkc/WwhynwPGv
 1G3FD0EcnXk+mxrEbSRK0dMAnGUNjfRKbXPwpHusjyuMZ/a1sKDQCWJuzx6k2mGrve04
 Lkq9cBu4G0ujvNfkTKkR/QkqqbPaLOw87bUxm8s7+PR8Ozb2rekb2XTUXh2y6rSVkhbE
 ojs7HbGcFe3mgKgHK6En5MfCJqPFq+dHMZvn85mRUXi0Q/LtUoXjcbkzGvyQaZ1H7c/5 og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgm8y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFksAl094402;
        Tue, 17 Aug 2021 15:47:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3ae3vftdbk-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMnzojHe+nSmE8IZkP+FJmBh6l+eluS+VKubNZ3lzhOdOxj0CmXOw+yAhSModNcn7ddm1nDyDdKPq3fYgsbjEC5boUvaDkEup8Sf1XG1s3b16+60dyeU8fq1RWOOvRHCbh/BTY/aF+PmRfeFDdSfr6Pru0XQBRW7iObRvQyAi2xiJgCFXhJ5UyiOpDAOcDbyGK0sZCCJCSRJXXLUqKHQ4gOe6DBX7hrf4NmiHsTTje7R7npzJ5WQQpEy5I/wqc40yNWVZNIwusH32cIcfeMN+E2LXeyg+m4afLnkf+464pYU998BBMXCODIlbgBipBYpCWFTPyZaTwJwRVfA4lxywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbw5atURRhyIIzaH+ltrvXt3bxGqwb4c9lv39LgYV/k=;
 b=Z0lbW+b0qdTu+jUSypRbzV9YXXHK/WqH1o3IC5Uf6EZPQwkdVaZYpDhoxZC7NX9ac6Sduv4vgFKsfmz3/tEokcBKkDagTF9dO4yl0mtMByPawpxORAU2oO+XzUTq+4HE3H8yaflrx74u+7TMB3a82cMmlZXwKRNyMC71HWOfrU9VZYFL+vkPaioXxG9zUlvBDAfhak7TvQdThirqXQE0XlTA4o3bRzQs920sf2Pq8iqcHdhZjlbstYV38Reop/wT2qoz1NraFmksrkaLGpYAjlnvDMJzhp5RGB3lykgDt/7S/EnRTOPlBblJODxV7wvYjEcy6u/ajzz84nwk5VefzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbw5atURRhyIIzaH+ltrvXt3bxGqwb4c9lv39LgYV/k=;
 b=QUcaqXfDmVJKad619Qnb/zYEPVU63rxypnOVx+2xNEJC4ANfevkQmlHpcQ+f+VfuXd7XiP1LTEfeoUq0eiyNOcLy1i8NVuH2QTZodnYV5qVnE0z/k1nUWRa6Lms3wAGoXWyqkJ7xB05p+aj9q+Z1jRA0Cpew510A6x97aBycbYI=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:19 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:19 +0000
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
Subject: [PATCH v2 25/61] arch/parisc: Remove mmap linked list from
 kernel/cache
Thread-Topic: [PATCH v2 25/61] arch/parisc: Remove mmap linked list from
 kernel/cache
Thread-Index: AQHXk38pjg5uMQOJb0GgZgwCLo6NfQ==
Date:   Tue, 17 Aug 2021 15:47:19 +0000
Message-ID: <20210817154651.1570984-26-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: ad83e384-2778-4cc3-e41f-08d961964c04
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4236CC6F2A3A110A63CC5F3FFDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jnq+mj+aXrxs/aTVMgZzz+ggaNh5wBqeelwbuorBPUjyAuGx39CKohfbSan12lZVrRw433u4UPIElq7RpRz87V4LSj8kvL51g5YRhxj6MFRf+2EtnrpAVyBOBjSbpi2+RqiuzjfV7Rcx8vzg+a2eV1xkECSXgodvRxk9YFsdpH+D+7xw4RhyW5fRhhNjhvO6UHhZyFOrwBqvoW1P7faNYB/LO0nGdWPs4FANljwBRfCBUkMdYo2GHWNFG2z2r65wqpQxbd0FkSFJnOdUAIfsJPEA1BJZz1AU+pW2FbsSYFWSVOldugy0J3cjwWsH8cMBIbj0aca+GzkPIU1vogRyEa+Ce+QrXjddRS1iqcp5GY27BRZWeayCIMQLrd67POq59V8aaK5buXTBW64NxwZwONt3VmtOy5jLLESKMfGwT5T2ikypShTL77rcuP9DVelq/ryii4NFcYLXYNWq9og+ShdPv3c8vG7rjTTE8tgtpNSWWUgt4/Ro2X0WbrvP0xvtbZ6R/R5Tzu1xpCwRLuUFkME8pdRK/Z2ZoMQkkf3XEXGACJ/oyz6NS4VZi9iqCObQSWa2JG4iHW8Dlc6xToBo0hTeKpErtVKPtFHyamT9CAvkGcyrBA6fRXd+GsSmF/dFjQ3A6+ehIiBS5VGQoi3T+Kmmid/ehdS9o7dAn3aAyYsN9dFoM0kYNX9t77vgyMAPkaYTBsFkpixG5xoaA8EOWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BbYLVLbAYHBEMSrD659uncd+QsiXGn7t0crzjA291/sBO05UqOibYd+Acy?=
 =?iso-8859-1?Q?jxFG+HwY1EGBuHTtcct4FCvhWwNpTuWx5OvDJvxnYDSq5O8QhldtjdTWjw?=
 =?iso-8859-1?Q?+cjHNuWB2Mtn4lnCmzINw9F7QdGZJFMGZclCl3ALfqhM5eUbyiLCTWAhZa?=
 =?iso-8859-1?Q?aqZUN2x/3WJyng6kqmk7UWgSLkwt/J8i5Kgy2gy2SdltnJD5dnVa2bkF46?=
 =?iso-8859-1?Q?OY2qXfEZJ+GVnBcnbvQCcvR2hNZjXHsu4S8yA98Xqu4HWyHaNLf1YlXL9+?=
 =?iso-8859-1?Q?aDyaW5XT7sy8tSmB5Z6DLPhu3metZhLkXfsEJOxsVJFJb1a9v7DzItrBgy?=
 =?iso-8859-1?Q?5g1oBqOpwSMA2cp0aRbeXQuifwI4fMc9aUGLJOc3dKIM9ca9PqxmmOoO65?=
 =?iso-8859-1?Q?q1g9KtrWPa54J6+swvAFWNqg1BlAY9d11cpEcdC29i97qPOEf5Hqa+mhhz?=
 =?iso-8859-1?Q?mj9CTDr23wvT90LwmqLHcfuCu6f0pU07Xor6QMxGRr2a//8pJTZr1F31s8?=
 =?iso-8859-1?Q?kNs5rsC9N2MyzFgcJiAJs32KrpdpmNaom8QPJtuAsUXGrQ/g5spRBLUGzQ?=
 =?iso-8859-1?Q?Xil6avYygFGI5sXEqHu6LaVflrV402htTxFLEqCt/87fgts7FtVRx0QEK0?=
 =?iso-8859-1?Q?3b3zPkp/bx4IwlmvzGIccrALTWdRvQrDQ1qlMEP+nfdt080Hgx7sDsK9F2?=
 =?iso-8859-1?Q?KQ136hbbN4EYjI0bxuzxR4mfsZCDNuPOZPhpcHG/g5+pkgfhM7KgJdQNtC?=
 =?iso-8859-1?Q?Vh4s5ITO+f0HmY9YGh+9EDTGsqpfvUzcI+6sAQlXEZrdFB2AbPlTAlAOoi?=
 =?iso-8859-1?Q?zh3rGMF8T0BLOMi8JCs/P6zAojre6sGih9PiFsbKt81/WoB0K9j0k8yxhG?=
 =?iso-8859-1?Q?DUYnOMb/N7bsEdZU8EW5GHS71ODOPmv7yx9CG0KNifBlnQAZvRZ6eYDHL3?=
 =?iso-8859-1?Q?SLiA267I7zd2BW8fpga1PBGqwk8pY+kwsexe+zKrDvpbg206ZSH5SnUkEz?=
 =?iso-8859-1?Q?LQ1evxgN9hTPUM4XOD8uQZCczHWlA+mB2DNcUP8DrmRcjQuaz4IMcqq+hX?=
 =?iso-8859-1?Q?DvHQYd+2s/38T3yBKE2hklnLlXBuXym8pNEpXoLLp74mLo3kpRGGsB2SLu?=
 =?iso-8859-1?Q?SpG2JfEG2twDMx+0Ee0Xn9IMnUuRM996WOEqd2P28ErIqWHcX8B4rO5e4p?=
 =?iso-8859-1?Q?5La8iUuUn/Lb6BpPkzeIf2hVainjcS843XK9m1D6xDu8Trrq+JHmYO0pdC?=
 =?iso-8859-1?Q?43mKzDYEsuPwLWkUGeEw6fejleDy/twnpNp0e6XGMPwOOJpSFPmMclK/gW?=
 =?iso-8859-1?Q?s1Ppo9j8fGRaUIOln/xLCn4oOKLNCusJpeTUaE5ksoRbapiZu0nvLQKOXG?=
 =?iso-8859-1?Q?1G/sI21LTz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad83e384-2778-4cc3-e41f-08d961964c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:19.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2QZHs2gia3eXdGry6TxAIwKf8RucaOv1RUyTBanDhMUZEig50l8kYBpHQbl9/ZcI63rU4FFcnl2CbUnpUjzyfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: ji63WeSqkGYwBSpTLqIaKrbos-MhqxKH
X-Proofpoint-ORIG-GUID: ji63WeSqkGYwBSpTLqIaKrbos-MhqxKH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Start using the maple tree

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/parisc/kernel/cache.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 39e02227e231..f6316aafba10 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -519,9 +519,13 @@ static inline unsigned long mm_total_size(struct mm_st=
ruct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX)
 		usize +=3D vma->vm_end - vma->vm_start;
+	rcu_read_unlock();
+
 	return usize;
 }
=20
@@ -547,6 +551,7 @@ void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	pgd_t *pgd;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* Flushing the whole cache on each cpu takes forever on
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
@@ -559,17 +564,20 @@ void flush_cache_mm(struct mm_struct *mm)
 	}
=20
 	if (mm->context =3D=3D mfsp(3)) {
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		rcu_read_lock();
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			flush_user_dcache_range_asm(vma->vm_start, vma->vm_end);
 			if (vma->vm_flags & VM_EXEC)
 				flush_user_icache_range_asm(vma->vm_start, vma->vm_end);
 			flush_tlb_range(vma, vma->vm_start, vma->vm_end);
 		}
+		rcu_read_unlock();
 		return;
 	}
=20
 	pgd =3D mm->pgd;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long addr;
=20
 		for (addr =3D vma->vm_start; addr < vma->vm_end;
@@ -589,6 +597,7 @@ void flush_cache_mm(struct mm_struct *mm)
 			}
 		}
 	}
+	rcu_read_unlock();
 }
=20
 void flush_cache_range(struct vm_area_struct *vma,
--=20
2.30.2
