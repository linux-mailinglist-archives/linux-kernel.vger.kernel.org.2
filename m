Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D089136DC01
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbhD1Pko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:40:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4892 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240489AbhD1Ph4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMAmD031068;
        Wed, 28 Apr 2021 15:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=n2PWu02AH/kw8vXJUI56qPWB9SPwItvjAS9gDUgb7Ho=;
 b=ZBn97saTrWnhXiQyT9TqzinhHzdYdfV5dpethg6tJTlvUmojlgg/V8NmoDaCdczIJBe2
 ViqMLhAAd+pyb3Dnu6zvQBoh8spZIInoLhV0vZFQFPRBrzQlc82UOlFqfNViSGWE89hi
 sR8Bfq49sO7iKvInaX1BLpKUIOLSbXsQvM6qq+Yda5YzMS1tHrlfrOc9Jg2utJY6NtVr
 cwr7l9lgEvIFNu/2RGJA1tF12zeLE1uf7HJuSSp/jhYMThbnzLBz1xH5HliC4DTnX9cV
 Jnag9dA9rWQGOqej7sbD5csV/7ly2BZ56LrcTtJjfj6TT179UPNMgS4tme+FYcOvsy2T Ow== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0eq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:54 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAxC018431;
        Wed, 28 Apr 2021 15:36:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3874d2759n-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyqQYfi/Gw7nadfSBtD36+40s1FIeclJ2srUXF38ZaJdUFX7Tx4+xxw72wY2Rmnedj7INeejcRDNQ6Pi1UYxDbmRkDd8O0OCE66X4g++HTpKEilgDx4VTp0kOmsIvwY5K+CavxUR6JJIXOluT01aYRVMaTr7gebbe6cnxA+gjXohxn8FDo91OcHoiohPeKXUamoz4HXJGDOYdPbialhm2M5EiHdzlNzPfD/nWgFuPcgAah7TyvuW+wdzWw+4Rl+nLryKCk8sh92fhp7KCa8rcuiYu6DFPUo62GbMyH2R+6oTplgZKNjeBP7qnkxFvhLIoVoUPWripgl9PrNXEHsYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2PWu02AH/kw8vXJUI56qPWB9SPwItvjAS9gDUgb7Ho=;
 b=m1qruhFsmpL1iIj6JLrZFtKTt0gKfkh0bwLqvFgPJsGAye5DMPL3x+gRrFE+TJBWK0/vNYuuqQYtzFuetfH8rdgQzvGHPDbz6Qw5SH0c7TuCxdyldfZ1mW4lcwn513DAQsLTqhFb5iTeW7w+4Ae1UCXyep9/wWv45ZOKfMG3/GaTAV/UR6pa5WhWfaDj8lP9ZLF511+9tnOzLwUHPggGLCFuQzu9rvymX2efZnekxhKmLM110BIN5VgudVbIweOXVMzxEr7B51Ls42rvGorgwt1e4xFmzi/NY11R1TYZ5D8owWEJzxoZ5k2OBxLLtIci9AyjhqRKinCaXRkiTFQnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2PWu02AH/kw8vXJUI56qPWB9SPwItvjAS9gDUgb7Ho=;
 b=V3jdXU0TuJchuJsO/K2mKVZBJ/Ql/SLKYdhWXWdgjVIdRIYoE2IQneI+bcNCXMxIDAZGShub8jkvfcmPJiZ4ALHYIKVx+3YkzMbTALkhoEht5cI9L7MbSZgdmjDgEAwhczLKxfBeA6dDAEpv6j53jPliKHd7m8m6g7KU3OnXEM0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1743.namprd10.prod.outlook.com (2603:10b6:301:7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:36:48 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:48 +0000
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
Subject: [PATCH 59/94] arch/xtensa: Use maple tree iterators for unmapped area
Thread-Topic: [PATCH 59/94] arch/xtensa: Use maple tree iterators for unmapped
 area
Thread-Index: AQHXPEQ6j0S6k1UavUqJQjvUslCcVQ==
Date:   Wed, 28 Apr 2021 15:36:17 +0000
Message-ID: <20210428153542.2814175-60-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 2f3f4fdb-aff6-4ffb-9d6f-08d90a5b7000
x-ms-traffictypediagnostic: MWHPR10MB1743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB174304221BF86836C81ADCD7FD409@MWHPR10MB1743.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D2ns/3y2l735s5PB/qYqj10ZTGpm8M//EnLE+YbUJOI/jMQoyEtc7pwi5/KSIk8UnDlYOdjjdlcYSU5tJWjAGrFI0a3/dLqLobi6KI03SGYcLIXRdX/o9UX4jTDdUpiLcjg5JGELHtxYxpIBGANiF92VpekPvBtPZyPuDdVMrvVWNbtRqGshAX4mNIU9MtmOtCCMSrpHohyGqE+5dBE6lOxDtB9wuOgdJZVFP+wn/rpM6V/9LH6LdG+aFE1GhQSOHowCMNQ9oWnuq2/4nB6sPJn/YIlIIZ2qiUGdbmguRZLx3woiMdPFaeNuEpadPQGG1L9/m3Bk1r2nGTcM9FD4AZuBy3Lbk8sGRT6kfJTD5Ws2Mm8RcbqJBgUjGhdPlIirxWIPKnpM4/FHrXTioGjmx9bxTWgcMPnsniPQGMdtTvf6yaykb1VkekzL10nGT7JBdO4HK8HuLH1G/6Db3/geyti8dJV5+OSx2lUy4Uacju6ImI6y90VXfpOu13qh7nIHTcXc32n5TgkL/x3YqY0lMTbgrp/mpwqEfrVJUlSTPceMTgted1BpgQ70O5rbORsLmPvLuBp5s+TdmVN1ZzGUdTocO6ipoyBxhzD0dT8Xu8g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(110136005)(91956017)(316002)(1076003)(64756008)(66946007)(76116006)(44832011)(5660300002)(66476007)(66446008)(8936002)(6486002)(8676002)(83380400001)(54906003)(2616005)(66556008)(2906002)(122000001)(38100700002)(6666004)(478600001)(36756003)(7416002)(86362001)(6506007)(26005)(4326008)(4744005)(186003)(6512007)(71200400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?dEmP6Wpz0yJwOI9nSdVetBzgVYSUueh4mHbwt5vftCfhHPdf+feTOQ//W7?=
 =?iso-8859-1?Q?axfhGmDJJinMRsMcPvZ532zzTCKz/KMenOzf9ZAeSRp0oJ7fXRTVf8NLa3?=
 =?iso-8859-1?Q?Fb5QjnqzMEsxkn55U0Vo7tlqnHB9J3QI2djoWzUzWrjVZfLrQW2RpAH0M4?=
 =?iso-8859-1?Q?YKN+fQQ20IP/rYH4n3Zqlq+tCokcAtaXW8M/9e7Jzm7PoniJl8qHqZXJCm?=
 =?iso-8859-1?Q?FbrfGCuRug3FAbqDnYCBHsqCuejw3THQI0aRkzIl7NEqzZ9cIFFQOHi2/t?=
 =?iso-8859-1?Q?zo3EJBNfW0tPh3GPxEi/i34EE8g9G3eLIsX8y4Yf7LZmsPlENrjA4paExt?=
 =?iso-8859-1?Q?kKpU6CECxv7X/tv8pCrfy7P8l6s0nF16S9l7nQ1NzICvc0S73imTq7ceLx?=
 =?iso-8859-1?Q?vWs13QFlAsmqCx0yVdQ3S37vaEzGF8vL+G3t/KTMAKaHmDjR6IHNc3UUsT?=
 =?iso-8859-1?Q?bnJhxW1SUpnnI2F1OoRnMi0MFMQUfBHHr5M/BWstph45aub+00uxpZWyDt?=
 =?iso-8859-1?Q?4KfaLiTWAOSsMlvu7y21D/dQ/rqSvdC6fN9PajB/m7kiOQOI6clBkKeWO5?=
 =?iso-8859-1?Q?OPa3iYdSjZ5Zy2vQbSAU2PD1cMXel0bwBLbvOTjQkqzRXmFn+72nu1uXc/?=
 =?iso-8859-1?Q?rAV8Deh69bvABnK/VbTPjHkTWmOywK0mgAXF2N5mBWuSl4yU3jrA1Safi0?=
 =?iso-8859-1?Q?lR5LVMtQYtEVuXSPSey9AxQs94bPFSjb647fIuj2NO+fIDpvm6pUVX0AVp?=
 =?iso-8859-1?Q?NZq+7gmdTEkl07Jr4zHwWZ2RAw0dWpG5/H20HPzEgWzJNekmAbBbsu6Woz?=
 =?iso-8859-1?Q?HpcBMBuA2tAoStm5yVhF7IxXf+GNwGCBcvneN4DV86vPOVv72bxXqcvRk1?=
 =?iso-8859-1?Q?2zp699Oo8wQ2hzj9v89JtdMIVfTPtkqsd9reF7KFIyU1gJlncyfQpJOJQ5?=
 =?iso-8859-1?Q?eQyvrVYQlBGNKeiDYGhX2v1aLQOSQ9LXpb2wu0bY8unOqq/fz1G6wbaaZi?=
 =?iso-8859-1?Q?rhSEbWIrBehfQwSkAMD1E0qI/8j12wrH9K8Lht12IYNTp2uSIaPNA6gpqN?=
 =?iso-8859-1?Q?9KHgKGwEyYsIpmEaWph7Af1HT+45iXySBywE0VumH3A/WbdZOPwjhQu1nM?=
 =?iso-8859-1?Q?lXXNKsC0P+dlRoYpXAtYJF0w8ylSdyNTnuD8vkWIrCwkPzbo40DEadVJLc?=
 =?iso-8859-1?Q?IAJtW4wGuYFFyZO3exlGY71ZaAiI60Waxe9fTeEajObFrN6z2BadaxlXBQ?=
 =?iso-8859-1?Q?OTVszOVmWuth0qRO82BGd0hVsJhv2Gcuxsuod569jhUguLramM8I1s+JE8?=
 =?iso-8859-1?Q?3u4akKZMLOIMsqDL6xo2/9rEzUEB1fXMoEds222qkI6kNHLhbmr2QKieDP?=
 =?iso-8859-1?Q?hJWRu/FguK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3f4fdb-aff6-4ffb-9d6f-08d90a5b7000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:17.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JipHDft+Z0cX5Y+YZutgovLiCabmf56GwEIIWj/psjncXLBNRaBQhCMP8k4/pjJqyM9BnNpV2hfHOtyuxrKvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: UGjay3RKzfMPcrp2QTg301dgKW2cemE7
X-Proofpoint-ORIG-GUID: UGjay3RKzfMPcrp2QTg301dgKW2cemE7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
