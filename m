Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29B3EEFB0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbhHQPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17794 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240293AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFklTc017365;
        Tue, 17 Aug 2021 15:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IFpJyLTSJ7k1dORsiMVstnCdzUroco596b8lztKtmxg=;
 b=GRBiirEXMFpAxrdZApK1FVL4Wa44SI/OGLANhNy9WDkqC79Rzcp8SDlol2wmfhVUDvRR
 pUUqZUUPkz53ck14M+GyVZle/tzzVB541FjIFNUiJ6Fxtw/voNIpReqEjtNDY7lh5JaK
 2jh57OvAA75qx4ZZ2GIuSeY0ydOV6HjaU5/KOYYEGo5t2JHgBdlJznRfCpxY6eisRuJ6
 FkZkwiyXoLnjpKIzaQEGPzgen4mitPF+nyhb5HJwy4Wq9dty5abt3f/uueE6JAkXBk1A
 FiKlcsGsXJS1FpsMkxmdQCXfzZyZctys17XZmZgBLSm15KrJL9Pd8T84Q7LkWxHNeMp7 MQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IFpJyLTSJ7k1dORsiMVstnCdzUroco596b8lztKtmxg=;
 b=Wy4CiC8GU0ctWdkbkQNCzHZYmc0uzc+064KnA9e5HpuJT6VKttW3Ps+MsOK0KLGZ+Xkr
 X3lazES/7GfXsaNdXgtP4vcanGQhoXB9HM5NabMoT8DTVE+qX0TSwurl/yFUajghLyTW
 BaHdmloAm4+NtGPzqQPsH/y55kblmEWMM6BuVHHaMdz0mLmHckM8raLZXGV3Qruk+rrh
 NqnOEN4Bn04N2HdNVgm9ZtnGJqpPenjRK7/OE/PgJB3/gUf1ZlSduubgNGhkEjVZRN2M
 5z1zb0Ib25bCFp077qA1tK5dnb/W6nHx+DkQFtoNS5OCRkismYJ1ZftHaQAUcr6HO+Ba SA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf0g6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfX158706;
        Tue, 17 Aug 2021 15:47:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAeuVz1pFKC4x5iBNR1LDR557KezVPUk3BH5XAxPDNfg1iXZsrXyBIAI4jr/+UJhmLFsbZuaQS1lvQ8guDLpBttR7XZGeuwCyrsiwBu4EaCIjSy8WDUT9wKzvK0NWRNOrXSr3eZ8h5bEMm+liQim6cLiPm7UmqRX+YC2uH8lBSu6yGQDWDWRS5QW1a2qJdxExuuAUDLK4TQogZA8nUCs8POdzgLLO1omXAwuDcNqL2m21pJYIWqyufIV9a4HaRjJuaFw2WBMUfWC89/YaOeooePO80Pg4wzLnWoSDhv3b7lKkvq4JYEITk7c2Hi6wwGsX1Wn9fTIBRI+bMP31GmGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFpJyLTSJ7k1dORsiMVstnCdzUroco596b8lztKtmxg=;
 b=Qj+l6rVZFNwmhBanOdqxcczCSQkPcc30SXKllxRI25DplpTcG8+jUBSRNlvPRQFD8UdezB0EWBJlH9GZl2ZWQ9zKEd+L0MoBwNwguqEw5PYeiJx1EU8rU418WLPtDm+smoiJOkgibxzwQbviTRQn08/VA0VyAgM0uUNXBwxiCr3nWPNQO2Pj49ZcaUKZGlBvevjKidEOawLKYNpsmCjcEYmqvUz5pDg2mIuJbogKq5VgWYpsFENqafc7DcD5Tl+nqbOT09aidrSOm+NUJGF1alEMOOdLG2Ddo+1k7mYMfu+IANOfgLwLupEz3py1tuXLTITgskzYoO4b/u59bvTHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFpJyLTSJ7k1dORsiMVstnCdzUroco596b8lztKtmxg=;
 b=QgbFSQLFSc8ywigFCT9SCQrPepn2+nPWNrvzb2oz7pMmSoHlbspuEbcTzItSwv5141bVNvRWt4X0aKZ5uySvpECNjBPgQN8sTAJ7LvB71DeZz45KEOE4CqDkmwJT2WZJvmzdKroj/0jjs1IUYidovXHJjbxx21SOmDWlsoI1b7g=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:54 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:54 +0000
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
Subject: [PATCH v2 41/61] kernel/events/core: Use maple tree iterators instead
 of linked list
Thread-Topic: [PATCH v2 41/61] kernel/events/core: Use maple tree iterators
 instead of linked list
Thread-Index: AQHXk38uJedmYHyvN0OcF6XZYHFYhA==
Date:   Tue, 17 Aug 2021 15:47:28 +0000
Message-ID: <20210817154651.1570984-42-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 936453ee-a87e-4270-0227-08d9619660e9
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB35800901934ADDE9CDD00BB2FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Ayd0GoHQ19Ru7QWccxbpyUrnDK/A3NOqqKLNauhJ3qDe3v+V9L9/Qkj6Xi0N++UIuOjfsWdha8r8WsxvMJFDXqAzwVArRzcnV+5ZqQaINwmncH8tde9W0SbAZs0VhgZ1PYD2a3E9J408P/0twCV7BLuEFgmfve57Y6OI6lM9WclXUxkl2jupBu3PphRzFUbJWXhc4KQhfh0wbBdY7qf/CHJZyBUlaxswgUiz6UINizgTrm06czKxXX2D+TyiW3AqkNkSO7gfVXDOHU4o6UqIRAqAwnQTwWLerf4RAhc+1DiH42qXs+PDiJQlSaIzcfU1xGPH2Fu7Il9sqrZK6fyZaD6o8349VxsXTOclcTMY5hIH6mFgfAj2l39WOL/SrNvzD2OQFTf5Hl0Xf3+NroykLEL+uErKDlpWxm4SgEgFzsIJUD0t6SyEAKCdwAsa2PaTWgh/050haX07Ve5h227WJd90hyhOmsbaiwAGO6mag2Yt5SketW+rMoFcj3OZB1o01EYYpju0fRWwzx5MRlzvLr9mFiV9R/CZQRDNDZ82MupCXu6LmguurP7iS2oNUGuEO41iyK/Lm846VUWGUVfi4YNg/a7nuzul1HuA8iFd7sRouig/ZfbPEzKxJzoCrKdE+rn6lBiV91WRETs4RxSw96PxcicDknoIx//HP+JM0/3s1ggFh2zNvJvR9sYgcAP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(4744005)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TglHEjwC31T4GBrt/dq9H3c0q84+4vs8juziQMzKZUgIPR4DuunrnSUqAL?=
 =?iso-8859-1?Q?fImR3Ysi1/yCCf8FS/QT7M2VUWINcZ0B/2A5YicG0XQpRRzUdzpaOpjvT7?=
 =?iso-8859-1?Q?R1/CpSTr77GWnU4P8jE9CjcshBpXGfRHcxVhYT/PGf79TeEZp1x4VjWfwO?=
 =?iso-8859-1?Q?i/S1O+VwXV8IMk4RW+2guW+f9nny4cgt0O06cJQ5atgIC8tawbLiByPqoH?=
 =?iso-8859-1?Q?H4CXULMQP4ncU8N1t6OL43YAh4wKQdXUQM4ThAmvEdW7BxuEH4bTaick9V?=
 =?iso-8859-1?Q?q3UQlY/SucOaYIQDhXqCXep1uZMkeWdELbkfG5rvkQkIWPsfdIBTddh64M?=
 =?iso-8859-1?Q?sgJkFvwIoYoZfUDbBloDZA1lzjlPiAWffR0cUGFA8oh7H2AVg2Y7IWxOJN?=
 =?iso-8859-1?Q?pLg1EoiT201DLariUlhNHAurRv8hDyulTSpPTeLwrN/vbN9UJsB3M3cUyi?=
 =?iso-8859-1?Q?2RqB4h4BRcdm00dmNo4Gd2EWzApYJVL3KxsVBMBx8NbIWWXg2eOzNobNsQ?=
 =?iso-8859-1?Q?QeLygiwTEWTHM5w4oXk6cAodoK6SaGRYZZju0dzG/vwm0xRKBglcYR14zm?=
 =?iso-8859-1?Q?3jE5EXoLr+C4esDUucSKsyLwXbPTGT/VJhcAxz/1O3y1I5EzqLe5CKqenr?=
 =?iso-8859-1?Q?9oXh8Gsz5bclW+GWQezucu3WzVQubfXdtxzzVhcZF9Rb0mwfMuUZlrvunA?=
 =?iso-8859-1?Q?VFviKGAHPsf/ULJ3bZhhARmlTuqvnJWrx/Ov6mCD7nCKjS+27PslqMpSaV?=
 =?iso-8859-1?Q?bsNhofQQJFmBywBtQGpX6s9k9B5fR8H4A4wnI2LTNC3bTJdxNB5dexaPWD?=
 =?iso-8859-1?Q?FE6teCT5E3Naorl639EnGjjnsuNRjvuXZuoq3y/cg1u/fvvSD0US+TFdGC?=
 =?iso-8859-1?Q?Dngbp2YqZlhSiPLXt3RIBfJ6mgi0ayr0C+FpUd47e2wBUPNxyAvyIG5M+Q?=
 =?iso-8859-1?Q?ZePCkSx+ydpR4n+1ySSSY42ZHW8JOEoVLKz9FHUE9X6srLg5l96EaQO8iP?=
 =?iso-8859-1?Q?yjvDMgRQemyPyEBmgIfeTsgDxzGixJCJ5yXV9E3Ciq58u5DiQ7ujYQcr5o?=
 =?iso-8859-1?Q?uQZzBHtk5IPI+7URE3n8gUM78TBAjL9voPGSIB3vSxBzK2H71jLTrNB8lD?=
 =?iso-8859-1?Q?uaM0GZk5bkeAQpeVzUR5pmTJx9q/U6KOd0Fi0bui2skpCXUhg5fdXjlVgy?=
 =?iso-8859-1?Q?dzISTClQrhBxLjesCE/pni3tHHWrMfCNaj0BBA9axDQSS7RHKoek/ZvFbJ?=
 =?iso-8859-1?Q?VwuY5m2nZfCAwSiTvTvtLdd8ZMYHoQqByRMnZemNNpRGG9zwtVJcRmwV2w?=
 =?iso-8859-1?Q?l1irTEhhf1S4nH6pGnXiW42dTbFJFlihleRWxdl7hu8VxVr6A4/qoP3dg/?=
 =?iso-8859-1?Q?CiZDUG3Dhl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936453ee-a87e-4270-0227-08d9619660e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:28.7322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POgKnZhmgbJ4SBAMpi7PVjDaU0HVauv2p8VK0EyTm0NptWdrs7ED87p6HW4WABYPx9v7m300mMdPm5QBbgjb5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: Bz986dqmv4XFAGK6UbsuoQVdB6QDtGiC
X-Proofpoint-ORIG-GUID: Bz986dqmv4XFAGK6UbsuoQVdB6QDtGiC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/events/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1cb1f9b8392e..3ac0918d8e32 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10161,14 +10161,17 @@ static void perf_addr_filter_apply(struct perf_ad=
dr_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
=20
 		if (perf_addr_filter_vma_adjust(filter, vma, fr))
-			return;
+			break;
 	}
+	rcu_read_unlock();
 }
=20
 /*
--=20
2.30.2
