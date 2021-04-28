Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FB036DC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbhD1Pmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28844 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240414AbhD1Pil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:41 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKkAb030196;
        Wed, 28 Apr 2021 15:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yF3WhfTupJK+c0meHpl8qnrTPa94LeCJJFz38V5aUhk=;
 b=s3t2Oj1mMfsiN3q2s2qOZWcWKCy2M1E5hdtolTJ27U2pXGk/cjU/o0KRCgBmf02IcjHC
 FPnoZOq6Gd+pBE8VjGoT9RPhu4Gpw/5q6P0C1+BWsBNLheb14cy25IOod95gdNnU2/YS
 YIb629CfDWSRrXBVyEAyWeClhcH0ObROWajjvs0EViH+S7VgdN8INrispPFl6uVyo7ZI
 /QPlx0syrdmgd7jSvO3E0PFyPvuDAZs+IW/ZAw90ViJ+zScZe+FKJk+JB4VZOIzbbP9a
 64DwFMxfVBwUbVa5Ct6BvYvhP/uL74PbyWXRlpVyUFckMISSz55hp54Z5b/419BwfVSa rQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh639-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:31 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZjx3021758;
        Wed, 28 Apr 2021 15:37:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 384b58qq07-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ijth0djaEwiovgliNTrwXD8Ytvu7gSz/SavZKWk4Q4OI4gyQ4WjSInnCnWbXV0SaI4Z2FtaC3BFuSB/MId9vVc+lTwREE4OXUYS9XlYTQwFyxNw8wlusDE6zkdVGEShI6nb1IuLmWdYcqEaklJcCbc/tm1Uzn9VNzzyJ5mWG2/dgOlkv3nkb6dLWsgul3LgLehJCXoNmYgy74TLcQJxvQMN9Ot5mz3yy05LFZH1VzHAe0TW/00Irr90911PLB6mlGORu5/phLvatwBjqln8mbHIrj0Vp4xuND0RQepE225bL8XoC1hVdppb2tuysuNNhVjJI48EgIY6haXCipKrstg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF3WhfTupJK+c0meHpl8qnrTPa94LeCJJFz38V5aUhk=;
 b=E9n3J+efbkEwU4l4EooB3c0O3jcqykcL+QiQBVsLrqskmYd10nmllu65lFa9LrcfjZ/z8tAjm0gotRQnNYrS7IJv2iO9NhdHXfcwjykWWYkwg10gjgE+0C2aInml3g4t1A7tpMX7BNHbmmfZENWufdHYWa1f81B8MEwV5SiOXLQbF1AMmfR/98a/7IvulMGE8bfozd9BsTPDmn+aJ+kPO2VDqtGc9lJQavOG7i/LHqP77urzT6KLh+CFlNbDLiKaD09bRi6IMoujDP8UZF14KeME6jr39z7TZHtMkToRpglIUMp1j0ME8Xor3Rap9y12kVOZWL7KzbyGWe9h3EX8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF3WhfTupJK+c0meHpl8qnrTPa94LeCJJFz38V5aUhk=;
 b=cbXnALhFO8cbYZQtRICoeSm+B+3H2deeySD7Hb+ZrOdBmh9716K3yC+oFLNVNrojVdLKrSICy8wFJmqmA6xyiQmqSOq/BR4Nx77wfJEQ7HCO9gYSL2DkCn8ZMLbFRqtcrePR8eXtvj4SKa2wxdAxBLvEJshhw8DGi9gdakLagz8=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 15:37:27 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:27 +0000
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
Subject: [PATCH 84/94] mm/msync: Use vma_next() instead of vma linked list
Thread-Topic: [PATCH 84/94] mm/msync: Use vma_next() instead of vma linked
 list
Thread-Index: AQHXPERB3iqPPBGgHU6lIj9LAjOCKw==
Date:   Wed, 28 Apr 2021 15:36:28 +0000
Message-ID: <20210428153542.2814175-85-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: d74b4dd5-69b3-4ab9-5db4-08d90a5b8758
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB18718B2BE8FFF598E852CDD4FD409@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x9KV3gX49qJgfDc+FngSaCrKewxfHIRg6E1+v690EyOOqYf+L/JwLGb+MSVq2GHFTHHi9g2Yirhk1IA/UbppooUltZeWfvEFGGMaVk1unN1H7sCyvv/mtMYnZ8eBG2DCGnXpxVJsb5/ubAuzITWHNrAs2gmwk6Df+z6nacgC3R5+w3V3GF/F3KiZWsJagciRho/zISX9QCTgzgWVswJelQm+zAfQPcA9foxCM+4nyL4xMdkkPBg2vhuY0uUb5azznNFAxWAxB+UKsgPMk3wVVk8Jcv2GpN3tOdZvvW0zENrW7a2X4thpwcbccLDuwJ2LLSiQgnEjRQqNllQzVO8O1iKzN2WZoTh68aDFvUshsdFtWp3kckp1jrY+0wEG7bVIoEGV+1wMJspzwLbzOHKf4ZyT788WHIC+iiSD5nL6vK94XK0oclj9eW24csRibRZ601L5QgoGeOdfZ/wOuvQIebaPJsysX0JqWUU1pr0jwoI0Kr+o7uP7NQ0gEAkt/VoABftlkHNfKYsOz+/CAWUR5JBo6KpSHS2DwsXLRAPDhpa7IClVHuh1M1jObc+kQH8RVRjw/OaBLyOB+bd4a0LkeBcaE5zGSYD8G7bxdM1DZs0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(186003)(6512007)(66446008)(6486002)(4744005)(66476007)(316002)(107886003)(5660300002)(66556008)(71200400001)(110136005)(54906003)(478600001)(44832011)(76116006)(6506007)(36756003)(7416002)(26005)(2616005)(8936002)(1076003)(122000001)(38100700002)(83380400001)(8676002)(66946007)(91956017)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?NUsW+kKXTKO9O+mjtABrF86XLqj9LZUD02srTxMdimdUpI1V56JBzkcFUQ?=
 =?iso-8859-1?Q?4850JH7P/RrqAKfz7BcIqZR7pCwheCSYlNPwFT3Z1i1jNr+d0av7mmGLWV?=
 =?iso-8859-1?Q?ocDkpiVu6IApzjAvbXhwBeP/BzPKo7GA60qTa9YMaCRQlteTPuBUdtdAPI?=
 =?iso-8859-1?Q?3pIvE3ntMvn+oKKemNZWz6XeehbtzdgKBlTDgr8eC9PPkElLEGfvQjye9K?=
 =?iso-8859-1?Q?6v/4IYYsiSzuTwau8579zFijI5hy73yd9ee8PMVIgj3dW5NiLBUAaLzfp4?=
 =?iso-8859-1?Q?9qI2RMkD4lOPetnRj5sEByeRcX7aGCD2ugAfuLgCb05a/fJ67Ncab/gZlF?=
 =?iso-8859-1?Q?8VxKZoEbiWCVplVMwAf0yz0aQL2wRo5MrJuIhT/2VoAMJ7GVPaTdbd02MQ?=
 =?iso-8859-1?Q?aATOAftS44WN16ozn0UU8RDeZQwvEaZlqmd9jptbfSjEXr/NL2eGuChjyS?=
 =?iso-8859-1?Q?k+jg0YQV01rEIq1e76EAomN1rbFSUyomefiYn6L9L9Zf7NydBW25HPB0AQ?=
 =?iso-8859-1?Q?MN31wdaq8VWq/KrMNycKWudw/RwAXSJhOWB/v/Mv0dMnCKSRxVkGsixPtN?=
 =?iso-8859-1?Q?ZH5r25ffoU0oYKykSdnL0QM4e2k7vQbP/+WLhIOOfqBagzWlLKYu9x7jBP?=
 =?iso-8859-1?Q?h/6JS3Py/pfpFped9LbZuxfCRaHKphXIgUG8lV/U4TJ3ik7p2j+i69xOBH?=
 =?iso-8859-1?Q?u8cVgmvyFtHfOVvz9ahfk8j1esHQFF6SGqwMdlxJN+XzQNyv8EnJdOKnO5?=
 =?iso-8859-1?Q?/ob+6Hw74D+X6E20rll9N1Srz4b11y2FS9qe0cUz3NwLbhhbY8oETjAETI?=
 =?iso-8859-1?Q?0Oq1yrMVFAgUd7jeHIhBH2rcFxjgzDInf+JRt5LzeJo0yhNmHrrA9ERqU2?=
 =?iso-8859-1?Q?KByknVLyEwki/ybDtwnS1mY9/hB6F8yRJ/yh5R6uRtsKZieqo7LqlJLtO2?=
 =?iso-8859-1?Q?RDPhpuGNybDvtlW3PYPvBADj13LQls3EV4KlGAMLmXrzwqzPfFjzANSz2/?=
 =?iso-8859-1?Q?S5KyYhyvY2AvvmLQFsUG93EiIImVM5MGD6yPom/cBU+5ZQiSo5iKmGkFcE?=
 =?iso-8859-1?Q?MtoUezqL1HT6RWhaiR2+4EUjCkPaK+DsUnqls569vBa+gbiGoLmESBN/RG?=
 =?iso-8859-1?Q?e14NPLbDH3SMauAxMxONnUOVixK6JP7wv1tglXM7EAkmJ46OUiEU84Iqrz?=
 =?iso-8859-1?Q?unqNajLCqNq7ZabSmHhrgMwbhgbgzRRS2LDOb+gzq5BwHMhyNvRWSnfVLm?=
 =?iso-8859-1?Q?+fgJsnbrKYqFdWbGoITqGom4J+uJMiVrwgqoAeghHRM+vPBTS3Kzkmjksi?=
 =?iso-8859-1?Q?b2De4bPl9ZNg6egtxAIKZqO6t2RBRKujr6CJvd6R/xkL4EiWJ2tUoPP64z?=
 =?iso-8859-1?Q?mvPEVA79xF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74b4dd5-69b3-4ab9-5db4-08d90a5b8758
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:28.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4E/Tclz9VgdAfiYd0gNx7yjm0nSd3mJ5b9np2kqRmfpBqg5AbUQfbH1Hnq3CkFAnhYtHSwKxMv+NrY0qzvfUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: 7kdwCNQyMImVectgprJ5Fn9Gq5a2YhAt
X-Proofpoint-ORIG-GUID: 7kdwCNQyMImVectgprJ5Fn9Gq5a2YhAt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..d5fcecc95829 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D vma_next(mm, vma);
 		}
 	}
 out_unlock:
--=20
2.30.2
