Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966513794D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhEJRCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:02:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44996 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhEJRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGsdEc166722;
        Mon, 10 May 2021 16:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yiCus1SNg4fVDb+IExuntbPRcdq5nzNnKDDWG4EX8fA=;
 b=IlkmdQDrxoY0/7V+6+GWt5DqfD4xv2wsru2mpDZohGb79PeBeyBHKnqpXyMlBMfuW5Di
 1chKY0YzsaMvP97PlU4HQBwYMk4E4l0antqGtRdHpTflCXKZyCsh+44DRFxKRspghNR7
 P4mxnMiJkBtpvRt5Z72c9wWt54/2a3UpGqhoFDbpw/MOc0zcbVRxdO9X2XNeE6KXRB7X
 LsDDVgvncZwChZh+bH5ZRrpQF0wfIvAg4WVDmRUiM9SRdUNFLCpvmA/dYHPN5nIHWVpK
 nuPuWvc95JIvHR+isDPMfhAdbt1ZSGK5qf7RSmr3IvPxXOlPKRBlPh06QvuDRQkFxIoz 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38dk9nbx1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtx3Y001777;
        Mon, 10 May 2021 16:59:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by userp3020.oracle.com with ESMTP id 38e4dskqwm-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2zRm8H30NCtsHKLMZUMZh9Ew8x89AVTE7zQr6qyuQUNrRBG/HAinTgtb/E2vA24vkQFeG88gkB/h4OoE8osd76I9HgCnNae9rvKAeK5m58ZHJ/qTYI1rnoKfoD32GrfUKvPdIecxj+zVWjLaJ6Wqit7/GcYLRyEUsVkQPL95+M8/bN2Hi6yIxuWpHvAdMl/n7U7qDyrw1LxLuiZI/3j3A1PPEZLptihYw0rV1MU+v3FHfMUxVtPZu11bgQvN268Oghd9qhyqxNS5UHXZj8aj1IUprZl2M0y8rPRXPRmqxXkdmptPCgRtHds8aySUtdof4gdsYVzQzUNX5JRNM0otA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiCus1SNg4fVDb+IExuntbPRcdq5nzNnKDDWG4EX8fA=;
 b=Qqq/qfXHZA7uwRG4ZLF37M1p/0LV4JaP2pCy3GAJ8o0pTw7G5DSym60NhYXUHVSuxXscVIwykf/jG/vUlErGXWXjy0wmEhtUtnG6qBKQuEbkuh19axYVtq1BonPVvA4CaGe9ALqGWAhVn3Y2a/1StQN7CcMQ0D7EjkZesgVHPeQYsvSym86wu4EixiwZlwZ6o1PdXljGP/22daqHKUhoatqIqMWaTl2D4ey/prGKLaswJ6c+YE2O+aqYpdsNmTwES4OCdjTbRMa/VWgSZt0qEsZ1Hr4QwGacFOBNWzNIuCs04gnPXGfUNHZJ5X30pgoNnHvNgGUPgi+qtFGwAnQ0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiCus1SNg4fVDb+IExuntbPRcdq5nzNnKDDWG4EX8fA=;
 b=rJqBajnDv6CvwTWVuDvGhEiC0zHvRjDTi49AL2OTFchN/qLFioz1JwnsEDwsnthjPv+1sJHxNqYD5sdsZf1h6GMD8iLA3CP/4ELuSv2Jm3xbsRk1jmbu2y7ITWYCO8wpxwT3nBAk63+N3ieEFn572/fpo1xYKljiuXzru/MXyGo=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1437.namprd10.prod.outlook.com (2603:10b6:300:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 16:58:59 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:59 +0000
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
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 22/22] mm/mempolicy: Use vma_lookup() in __access_remote_vm()
Thread-Topic: [PATCH 22/22] mm/mempolicy: Use vma_lookup() in
 __access_remote_vm()
Thread-Index: AQHXRb3FJPvh3dKIDU+MAPMV/nbNXQ==
Date:   Mon, 10 May 2021 16:58:59 +0000
Message-ID: <20210510165839.2692974-23-Liam.Howlett@Oracle.com>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 69ca7c75-13a1-4e70-36d4-08d913d4e811
x-ms-traffictypediagnostic: MWHPR10MB1437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB14372E1121C0F712BFE1B442FD549@MWHPR10MB1437.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bahft+oS4Y6LSA/syQjLhcy06mXcCczCPbe1dbv2SPImqwC8Ei/6HXYwnovCJXFTi6XJEGS0J+/RsiQNM1cbo8a+OPr8joYTaGQP4JC0F/Ga3SzduFAXmFOHfXtF4XLZmFVL65UuTNBcm1ILquJEJvEOUflAo9WSMRvX6lA1XrvLvpYBWFDY+EI91+jQ6XV/2tIFrZXUipu0GNl4CdptDmHNGp5kh0BsIDe6+eMWGxRxE4teirHlQ+wujylGVoOA1Ap/Dkv48Zrjbqpo/cAUaY+O1wyvgv6+teGXqESQPAPiVaA6VUQ4pFkIuKCpKxixog6A+rDUg6nBjtepqHmy5m4Y5pAKp/OFTsYaIS4RiU4HY8UPS5ykUTuNxe/AyUBJ93k5s5Tprxbf1K536XRXh0QGQnD34R5ecfxC2uIjZLKa59DJwURCuYidwZ+0dWwz6md5QxstptGnvpOEhNQvZDXRn+w1aFZ7XaUkN45d5HKDSzTIL9p0xrZ1RJGvHX2Xlmy6udSUZCsoL/AVUeUtuQdaSI1t6hYmNoDbsrRrLD2xv/0zK8UzPomgAl4vfijimDNbgbTThHo7sxWF9eyYASb6KqjjcoROZnl4dVucWCc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(2906002)(64756008)(66446008)(8676002)(44832011)(1076003)(6486002)(122000001)(66556008)(66476007)(8936002)(110136005)(26005)(83380400001)(54906003)(71200400001)(316002)(6506007)(86362001)(5660300002)(38100700002)(4744005)(76116006)(91956017)(478600001)(107886003)(6512007)(66946007)(2616005)(7416002)(36756003)(186003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?G+w4lIEsaMMQ55nOArxc/XFl4ihUZoasCLhW0DX3hNVW/G28RaDQt4Zs2d?=
 =?iso-8859-1?Q?55zW1yLIawLVbvXiNu00tXgN+lrH/w7j9gBt7JDmFYgV3mVffM1fhQ8Ys1?=
 =?iso-8859-1?Q?ciFEF/pyoB18KdH//YimZfb0T+/ThkxNvS413FIh5llm5gYehnesCGT6bu?=
 =?iso-8859-1?Q?wm+BF3FGBlgqwdj2/Vmmoo9oYa1nb9qjUskDB3EVt4xjuKCTMMBijvyyE+?=
 =?iso-8859-1?Q?qbhcdnG4Xvb/pX4fWSz/aV1hXvqonJhdvgOCzzwKH2G1PRS16PFtFn89RL?=
 =?iso-8859-1?Q?4ZrU0QfPxqkjTHvYAV0rasdpyoNVhOWWL/JM+MbeLzGTV2362GxXi4rMPg?=
 =?iso-8859-1?Q?HKQG6NiX83R/BL3yHeIASAn2wVME79CEOwxKovCImRHNKtkISg+OD+jv+Q?=
 =?iso-8859-1?Q?jeeFi/RStiVYo5yFvyDgSreT3ITAF2fBxdn6NVHR2T4Xn1Yg30Z6fRo278?=
 =?iso-8859-1?Q?uWgnKWyfoEv2UJx9QHHC/dbaUqwr16HUrb8GqXsmcxMZtn+YhArzNPK3Hr?=
 =?iso-8859-1?Q?cioWJKrXTYvLf9TQmSrAF3qEjD+2DlXJEBCz8aXzF6kTSF+9iGD/Tirvgv?=
 =?iso-8859-1?Q?+iL8u0GTMvo6Hzi+LxVUa+N1jFX/a6f8/tMnhM5+WB9ICUqjSfwqKxHrS3?=
 =?iso-8859-1?Q?3xZ+dllTux4x/onNtv43AZONPUhSxlcPhdEHBMA8DHawpoVStXUW1s3B0D?=
 =?iso-8859-1?Q?OSizRsT+iOxR5fzZcm5GkN6UN+mf341jGvVuhi4k2G0SvYKbD7oonZchTL?=
 =?iso-8859-1?Q?+MDHOKxn8pEbo4Q4JmBMm0PcKckTSANRIQ4z1VQoxdx6VcNZe8zX/u3dX0?=
 =?iso-8859-1?Q?0thBu5fnVE+a4QqClKm6wSMYVdC5V3YzehYRMfQtEoXwNeammfkjNY+si1?=
 =?iso-8859-1?Q?Dx698A0V7hACbr47nzTlr3ahE4yj1PwlOvPdhDYYAI4QLUDGx5wj3Unvph?=
 =?iso-8859-1?Q?yv7W1nVlxGy5m42EFUzi91oQn02UAhQwg7S8Hj27iE0gC9P4udgWt/a1JM?=
 =?iso-8859-1?Q?SyUb0yn7c0aOcZBifl2sM+0/AcW9g7gJLHjQBiv8v42lT2xKt3c+0pPyXJ?=
 =?iso-8859-1?Q?60je+Du2kVL5iBIUqwbtJ9nkwJ1ADmVttaRRgkkvglRqxwYKVrQmVYgCfO?=
 =?iso-8859-1?Q?ugOxb6EACLjZaBAMZnyaRg+wHS8OYgSiE+g3WuYfpHHAfz0mELbNOrHAtk?=
 =?iso-8859-1?Q?YK102dwQrrVYeZKlFqOddfZZtN+zoZ4ViRoOb48xvzzfyZXNvK/5vpJ3Jv?=
 =?iso-8859-1?Q?mCgy5hmOjtekRVIn728y5vD8sm7cFQaK0i3QceOuD0pfq6iN/tz723qwEp?=
 =?iso-8859-1?Q?8lWcvB/ri+u9gDBPyYrJwEK0F40Y3MvchoskFXojXsyEJDn9BeCmaZRL/i?=
 =?iso-8859-1?Q?CFT7QDnNcU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ca7c75-13a1-4e70-36d4-08d913d4e811
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:59.6053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1faoF7K8CUidbF2cYCy0koZkAosj01xilV7hhLdPL3Olk7KsvyR2vjRkwh2BUXjlkyY2Sm1WQQm0RC5irHs+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1437
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100114
X-Proofpoint-ORIG-GUID: AM4z0DegWzLQ8JgqiqWCG9jkX7IDSkJr
X-Proofpoint-GUID: AM4z0DegWzLQ8JgqiqWCG9jkX7IDSkJr
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() finds the vma of a specific address with a cleaner
interface and is more readable.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d79fa299b70c..325771bef5e2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -975,7 +975,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *n=
mask,
 		 * want to return MPOL_DEFAULT in this case.
 		 */
 		mmap_read_lock(mm);
-		vma =3D find_vma_intersection(mm, addr, addr+1);
+		vma =3D vma_lookup(mm, addr);
 		if (!vma) {
 			mmap_read_unlock(mm);
 			return -EFAULT;
--=20
2.30.2
