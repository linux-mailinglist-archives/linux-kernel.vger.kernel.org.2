Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941A2402F80
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346575AbhIGUQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:16:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39416 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346508AbhIGUQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:16:52 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187HsZIL027982;
        Tue, 7 Sep 2021 20:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=7fzj3g4bXEgcniFdWzxSlJJk6yes43Fiw5pqobWbhAw=;
 b=ESh2Kcx0v+yAwq885NQO4CwNeo1caC5nNrdbWT8JwUevhdZpm52y7qzwsceqOUJKngxN
 +BRncgO8aCfJ04m/q6v2v4InEkC+Y9J1ZEY697swrTfKMbmEDzqA4bBFA/ve1o+6SSOK
 3HktyZXHGhjBKyf7lDRNJhsKzYXaanqeJiFzWLdElHH0uxPf7Yd8C2/i7gPPZiB6DxGo
 +Q6foDD2bKUJeeYfLMZ3kpwlO3O9KHWGoMl1zABkQWzLrPc64c10XM5bb1iZRXd9DoEJ
 Zgwqck/PyEwnxaxfpDpq7DnovxGas2ULUMBbTmSSam1CnD/1MlVtjMB5czD+piRwbAe/ WA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=7fzj3g4bXEgcniFdWzxSlJJk6yes43Fiw5pqobWbhAw=;
 b=ywVytc4ybgMHQkMlDQRcfrKz1OhfLXkVuL4h8Pg6/ZxzfyNrnGwj1dMyiJVgg4Ju+Dr+
 A0j7BET1hafaRILdHTbqSMziQlOqOuBDTv98ZoIzqjEUyopQHl3v1QZxZHiXIvQiTegW
 XmbgiWd1almsVHVEM5Mnm/at9A5bP83J3WIr6LtaRjUz6o7pdXZWvWv4ofej0QG6BHlU
 9v8g63U2lnj2ZmGTteIUeMrGYGjPDbvV0Z8nHghvMZN0nMxtoagl+8zdVHsP1g9RPHaV
 f8SWFF3vb9bEZgOSCb1tl/uWVZ1i9P+ahwJ8xj8rN6uPDpERiIX7yk3uU/MXmvdAEmFe +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcw68bw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 20:15:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187K6FaW112545;
        Tue, 7 Sep 2021 20:15:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3020.oracle.com with ESMTP id 3axcppev30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 20:15:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdGwXDPcgRvIo4YCdMc8J/K/Z/6ByYwtlVWB7FIMp6awwrOQADJ0Si7pTyrPLvPPYi6lA6DeU8X0ktvn8aah7lL7h6EH+lhWCbnH/nJo8kwxxGHT33K4cFDlXdHdDz4DyupJCExbbuj7ujNJv6fssspuY4KupHHIRTL8O86KwE0V+d8eGeuNEYlkdK0yxusGyIOe6RjshJX9dhLDiKL7T1ArHu7beMMS9gk+tns6W4CfN1uPHmVuRJHQZJKewPX62xOHhLh/ehSZweNhPGNXRSuT/UujtshNLGk6/UsR3O0w/sKatJEfZkNdVaekJcE7mrUzM2kN/uArHG2GxN73Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7fzj3g4bXEgcniFdWzxSlJJk6yes43Fiw5pqobWbhAw=;
 b=b5NMYPh5uU1w17GL6fpu4o3GreZ9jqYda0ETW4QLd0PMwwwMD2JNYxmkgkPn6qaOKq0PorbmbFExIKxsPR0G9TBnQz2zijouSQJuZnU3vF1e2RmIqlKknwVfI09v+F8XLsjSE8ZajEbAa02yN+9ky58W51SNKVuE4fX4HhDcPLqKBDpLUSh8qgbE3Xj1jhf6ZiQX10ZURzq3Jm+2tkP5ZQzJ1uiEekeB+pBAamScABq5XxxaB340M/tGVJ6EtxqzKQcXE+Un9ON3+/LNO7TTRvXFA764huOxT3eMVHG+Q5yS5f2FWHcSxxQjZt/shYQb1HgkTEWYWQviXEoSk/f67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fzj3g4bXEgcniFdWzxSlJJk6yes43Fiw5pqobWbhAw=;
 b=nMLophKAaq6hLBhRRATnAoFlXweKCtCOBCzfDvDjLAxaSBdq0++NN4PRlzLOH8Nn02gOKb3KqOQQnUdjbQK+MADfSJqPek5tnIcCufuTmsfxCj5luIqM9gNIQBQ5IIZ/0lSePCZvysH7O2IefLU8rTmwgjWmZX9FCocWfoqUUB4=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3756.namprd10.prod.outlook.com (2603:10b6:5:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Tue, 7 Sep
 2021 20:15:19 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%4]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 20:15:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3] mmap_lock: Change trace and locking order
Thread-Topic: [PATCH v3] mmap_lock: Change trace and locking order
Thread-Index: AQHXpCUUhRJXEngyu0KRBTXxoM/xrQ==
Date:   Tue, 7 Sep 2021 20:15:19 +0000
Message-ID: <20210907201456.4036910-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ec0c9d0-8ef9-4c44-a928-08d9723c36c1
x-ms-traffictypediagnostic: DM6PR10MB3756:
x-microsoft-antispam-prvs: <DM6PR10MB3756A927F4832D98A4821A64FDD39@DM6PR10MB3756.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0GS4EuC0hbakhkHCdixM14NXpqLyACM0mVj0cFjCMdEXC1UUitIZX5s518uObpjZzyd98lRfKbfPZWRi8G46m3H82aM5qbgTNtYQPm7bWFM4AvsNPqBrd1zGBClOVVMc5+mhC+JCLnssf4A+DlTNz1BArUKIe758WWRVDZasMIoojh+0GKCtG5phxXfn0merzSmky3ylTIPrsncusUfDWKeCFVIYsS6iXVk7W9tiEUs1B3BGr0761bE4n4HFUMec9kYvRH6rtZ2f8wrd4pVHTV91o1X4zbdxO2ol1TiRnYNNKqWxPBhM/x+X5tKPz3M0UXW4/OfC2xU3B0AbMk93pL/e4zZjKmtsFvqWSKanwv81w8/tTGCRKtjIAoid1iCsWhUQ6bo6VYcNPsj7ISbzJ26zZ8gx8FySFXLOcUUAW6Q+fofzKNZEUtlGFfRB1T9BP0gB9JpjrWqhugt/cxSqKm8V+7swUt6hyRKC5qgSItt97TVpOSKUG9PWLadnBtHyLtMbqhvp6zHYcRaAE4a+9WUOB7FPsoRGwMT60cdLp3iMeBrLtQGk/eE6cCEtWc1S24lXxRTT4kKWD3yWRvZuJxovIcLlHdzvP7q7JEN1ndU356CdE3UIk3+dOQxo+PB5VtEglQ/jdPK8cElmz+8pblz9McXpVpVlLuKClY9JJBhvqGkta3bnrhzxvNgLwdafrELnw5YMk3/xwtVtGerVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(39860400002)(376002)(366004)(2906002)(54906003)(1076003)(4326008)(110136005)(316002)(36756003)(186003)(38100700002)(26005)(8936002)(122000001)(38070700005)(83380400001)(5660300002)(91956017)(6512007)(6486002)(66556008)(76116006)(6506007)(64756008)(66446008)(71200400001)(2616005)(8676002)(66476007)(66946007)(478600001)(44832011)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Nv6N7xKhn2CgCiUgK6y45pgejSk60y6H8yoAqHO2Kk7h8TlcXWD68addE6?=
 =?iso-8859-1?Q?o2qlN4BfIFm4/eID4wM/xMfDTzDxiEKZN8dzBA8XMPCwMmVxhMm2elK1Jw?=
 =?iso-8859-1?Q?2ud25dLMbL+ruCABj9v0o1U/cf2/XJrgw8aZ2haI79k81eZ9WSjVkND5pK?=
 =?iso-8859-1?Q?0bolX4ah0RH3Mzycaeshsc0UpV9oMJb0oQjstjWK2UJ8AeGAy9xJpKQeVg?=
 =?iso-8859-1?Q?zdlnvM7ArqXY/SPvGPmayyhpoB3Rpg1pj1IyOay1F+iCuU5tFDl0zhGUOU?=
 =?iso-8859-1?Q?drRyYv9NMaH/ogXlY2cgRl51I8kphi1vFJROSdAjAhiOB5dkzqxfmCwHak?=
 =?iso-8859-1?Q?gVSqc1bwjR0CP8bo38NNu5ogSe9LyhH8s/YXS96tAPnaGnxv8i/tXucOdr?=
 =?iso-8859-1?Q?3vRr5020JKas54lIxIDMwpwWyijVkSzkUkijbXt04g5MoOzb2GPkw4Mo7s?=
 =?iso-8859-1?Q?EgN59eRgIj2X2xgKVJ9uL6B5ngKmPALzTtWY55Ktedn7vCq1Mr1c5nIu5I?=
 =?iso-8859-1?Q?Poa+mjoC/6u+QKzu9i/LlX90nAJ0Z6QH79O7ym1kftKRzF5vwmQi6zSnzq?=
 =?iso-8859-1?Q?Ujj+/r//zEU8LgXeZ5zdCl4yydy/7LeETUp6bjDk8zlpPcIJ2VGQtTOq9S?=
 =?iso-8859-1?Q?6dK8PmmgAvuQRa44YeXg1ZnaTr5/LFdyfIi6UNZ9lzbNdgAGJs5Z3fFX9S?=
 =?iso-8859-1?Q?v+a6nBNIygAELeeZZGYwG8YcJDkObTui4w1qHNTNfItYlQwfv8mtBcoi0V?=
 =?iso-8859-1?Q?YAXmzqo+zX3Ks4CXl3ujWahnd7v7vIopLKnfS7L2X7S0De8Ox/jN+YNP2K?=
 =?iso-8859-1?Q?irQSg/8GiLMxj9ygyFINm0+FdcdO7MvCADXSBO+uAa0jEtO8Bk4NH0Q84+?=
 =?iso-8859-1?Q?DKou1htofxwUVo2eVvTr2R2X2NY016boJWTNgqk6+W9BRTZ755oPB+OeS5?=
 =?iso-8859-1?Q?QF4nljnmqbfieDg+Q3oIzG+wYMe3522hcDYLlyPYxQfH7IJkkcNChKHREx?=
 =?iso-8859-1?Q?d/JRjoUcWYdmIczy0tJx/wMCjSLWI9JLRDRkLY7ZDYjHx9CGhBhokO9ujA?=
 =?iso-8859-1?Q?MfdojlOxlcUJSkC6144qH8ZB0ATMV+HLlrFlRZugqYymgNI7E2HY6uPFBi?=
 =?iso-8859-1?Q?RqFs5VDD5Y9HgGC4hYDAAZLlpMKrM/BYH+1XUUmrI6MWo9rANW3Y+t4Mev?=
 =?iso-8859-1?Q?aF1InZg/5Xh524r/bhBPSkuB8gstHCmzb5M9B32VJAxGt8G9+9I4L5zlFQ?=
 =?iso-8859-1?Q?m3gq0j1lphYtkWvihMDloouv6Ho4PcdcuFIeXvF+sT7zF8DsvZm5K3h6t3?=
 =?iso-8859-1?Q?AE/zFgCyKi4yhWUweYkBNOCeKHKraYdeoHXHAyM4In5u3J/36DqCHRA7bf?=
 =?iso-8859-1?Q?CVDOgvJ8sg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec0c9d0-8ef9-4c44-a928-08d9723c36c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 20:15:19.0826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHVsl4uoTBOL7BPbb6PLneZL6xJB+xC0vbg1fMY/BBBwIgBGyOPIntSFAskoyOSwhoU4lWGi/lxPS31FyBrF7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3756
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109070129
X-Proofpoint-GUID: vkY1mF1uSwUI2h5zYgWKcudTXXX_xwQF
X-Proofpoint-ORIG-GUID: vkY1mF1uSwUI2h5zYgWKcudTXXX_xwQF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ordering of the printed messages from the mmap_lock trace can occur
out of order.  This results in confusing trace logs such as:

task          cpu     atomic counter: message
---------------------------------------------
task-749     [006] ....     14437980: mmap_lock_acquire_returned: mm=3D0000=
0000c94d28b8 memcg_path=3D write=3Dtrue success=3Dtrue
task-750     [007] ....     14437981: mmap_lock_acquire_returned: mm=3D0000=
0000c94d28b8 memcg_path=3D write=3Dtrue success=3Dtrue
task-749     [006] ....     14437983: mmap_lock_released: mm=3D00000000c94d=
28b8 memcg_path=3D write=3Dtrue

When the actual series of evens are as follows:

task-749     [006]  mmap_lock_acquire_returned: mm=3D00000000c94d28b8 memcg=
_path=3D write=3Dtrue success=3Dtrue
task-749     [006]  mmap_lock_released: mm=3D00000000c94d28b8 memcg_path=3D=
 write=3Dtrue

task-750     [007]  mmap_lock_acquire_returned: mm=3D00000000c94d28b8 memcg=
_path=3D write=3Dtrue success=3Dtrue

The incorrect ordering of the trace log happens because the release log
is outside of the lock itself.  The ordering can be guaranteed by
protecting the acquire success and release trace logs by the lock.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/mmap_lock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 0540f0156f58..b179f1e3541a 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -101,14 +101,14 @@ static inline bool mmap_write_trylock(struct mm_struc=
t *mm)
=20
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
-	up_write(&mm->mmap_lock);
 	__mmap_lock_trace_released(mm, true);
+	up_write(&mm->mmap_lock);
 }
=20
 static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
-	downgrade_write(&mm->mmap_lock);
 	__mmap_lock_trace_acquire_returned(mm, false, true);
+	downgrade_write(&mm->mmap_lock);
 }
=20
 static inline void mmap_read_lock(struct mm_struct *mm)
@@ -140,8 +140,8 @@ static inline bool mmap_read_trylock(struct mm_struct *=
mm)
=20
 static inline void mmap_read_unlock(struct mm_struct *mm)
 {
-	up_read(&mm->mmap_lock);
 	__mmap_lock_trace_released(mm, false);
+	up_read(&mm->mmap_lock);
 }
=20
 static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
@@ -155,8 +155,8 @@ static inline bool mmap_read_trylock_non_owner(struct m=
m_struct *mm)
=20
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
-	up_read_non_owner(&mm->mmap_lock);
 	__mmap_lock_trace_released(mm, false);
+	up_read_non_owner(&mm->mmap_lock);
 }
=20
 static inline void mmap_assert_locked(struct mm_struct *mm)
--=20
2.30.2
