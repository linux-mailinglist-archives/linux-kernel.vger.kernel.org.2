Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59DC371884
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhECPzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:55:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55122 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhECPzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:55:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143FdfpZ012541;
        Mon, 3 May 2021 15:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tqkb3KJIWGvjkupbAuEiDyP8zu6JU5EiMIHasB5Intc=;
 b=c2TJST8O3PL9DOlusnT+vpuHI5GW6bu2Tp4f8IttrZDlUAySHYBDUsPUPrvwGx52UGc8
 acBIJVFlr7zeo6JwkQymD4BU4+IYeqNQJOeiVcOXjO8KClOZpaZda0838sb2/O0Eb6v8
 86x1pma9zl7JZoT7BrYIMkQraS2NJV/6yLWgXvSeU4GsIPV1f3j0v1kfO8H+ev77KCjt
 sEAQMo7ZRtT9jNiFhJ2+xCo6mUBDArby655Xz9+RfH8vGgUgOSOtsQEPJGgX+Em08wxL
 6BP12m7S2fmQcoJd2BHusD7VM/GekYpWItkFc942eDSsqpdF3jc+qV6gi8wrwPDrpct+ oQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 388xdrv429-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 15:54:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143FeED3191611;
        Mon, 3 May 2021 15:54:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 388xt2kkvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 15:54:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1fkeuMiuKRWRmCc4isyq7zMQoQzZG5VifS+0rGhoshVetmB0AMTTyDIdH/D3JgkT47pYxLZVT3olLTMF3PYSjR3H1SleIU9S32G2z4zljTa2VfaxyIjtleQTsPG0txPLIM2puJ7gsTf+iWmHe5U/r5qbdmcCthBkAXijznPs0S9G37d9U4zLxo8NBu7ReP10y4spWsHtcqvE0r1mg73yN9k9fVzZOXYkT91MNLl0kJnenIn9B/nZ5k1AB7tKP+o0nN7nMBKpnvL6I0sFuFJzk4gkZisJPQA7wx0wouvZ8p/CMZ6GKuA4OJVq7V040TOpL19H6Esxe/wbE1HkD9D9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqkb3KJIWGvjkupbAuEiDyP8zu6JU5EiMIHasB5Intc=;
 b=i4f+gQ24D57j7aSBCIrw+g81q6of3/nZNck2+CtCvIQLYhTlPnGSXAjn6GtWoyCZmVj213ODxJeb0gLyqb+mzE3FTQujYVEKFdXskBz3SE+XYJPIe9OBpxMhPwhYbQms+TxE0Grvk2tvb22vCTdy4f2cz1tsNmc+ecBRG/LjpjKWHP1u7fbU+cSMBqj7m1MJ2mcvNt5AXj7szT0mVQ4/0GH7hTjVE4iAARzxFhwGYRgi7yzJ8hr7YPX2e0yBN1CToFAMZIqWGna6RUQzPVmGokibC4dmy2C8ZFwhAi1KQ93br+H2axOyvQU1fiYlglrVIOBFVm3KiCYcB2Ut8fZClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqkb3KJIWGvjkupbAuEiDyP8zu6JU5EiMIHasB5Intc=;
 b=uLsYNokWmo/RApPwgqoO1vOwXXGnFjXApzTE2+La2Ji8m4UzwTg4AaaVHxT01rNgtsx0ZTikVR8yjBt/NYlZIhtf/nN5rS99wtkVfUToRF91n6vJEgLDBy+jk26YXvjXJjgHw21mrdMNx+sElz/qaRMHEs+E69iZ/UufBWWELF4=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR1001MB2079.namprd10.prod.outlook.com (2603:10b6:301:2b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Mon, 3 May
 2021 15:53:58 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 15:53:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Michel Lespinasse <michel@lespinasse.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
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
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 38/94] mm/gup: Add mm_populate_vma() for use when the vma
 is known
Thread-Topic: [PATCH 38/94] mm/gup: Add mm_populate_vma() for use when the vma
 is known
Thread-Index: AQHXPEQ1vRs0vBrIxUqHuI8bmYeYEarOGOoAgAPXlAA=
Date:   Mon, 3 May 2021 15:53:58 +0000
Message-ID: <20210503155352.74xqhqgizaagdro5@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-39-Liam.Howlett@Oracle.com>
 <20210501051330.GC5188@lespinasse.org>
In-Reply-To: <20210501051330.GC5188@lespinasse.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lespinasse.org; dkim=none (message not signed)
 header.d=none;lespinasse.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30f89289-c259-41fc-0436-08d90e4baa01
x-ms-traffictypediagnostic: MWHPR1001MB2079:
x-microsoft-antispam-prvs: <MWHPR1001MB207940B96A3DC954F9532FE0FD5B9@MWHPR1001MB2079.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ztHGEAwJHRYcg3CjtUQ8fNYdvR0vurt7MqksUTFRgk6MQSUM/5nDWxadJ+yoIQH7gfavpnwD125AehN7/bHGvKg17oEYk4kgVUawxKHgJauLnCVCCmazI/bq0H49flqxuXie2SmYQiZQKyCZcWsA8hoDFLagGfLqqBiK9RMlPOSjPio2bjXHqhhy8sqgAzGyD888lbW9762VkhcROAIwgkbPdsUCGXzrRBC93ex0UyW9NLZtUYpFH/vmqLGBHheJkMzWf1/un3GWMn6pMxnWPbQrSg67f/h75pKa6+rGgwnyjuav9L6Cb2+6OVP45Jf00polMkmoq9xngKj9gSWZy6VzShNvIPEpwbJGsZ0MGJWzBEGPgqEUAwXmUU17nGCQBPsVX1jB3zwwITq0kFuoM65oX8TTiMu9o6dxNijuII6q5uGOyhoAs9k41T5aUyDZfVS9EbdNRQ9ybdKVZApayfUnCqf+dcqg0Uz8hVHImt2F3p6iUK1whVyeNRkCKIxxhEZHd5EbK4N6IXNWWYK0Vyza9luTtjMBTdM5RqwkZUOSlLg+nOY4GGrA9VCQ4s3fQ+GbhslPhHqeoOeqAOFvLo/k9Y3XrMyWTPCoQLS0vgo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39860400002)(376002)(136003)(396003)(366004)(346002)(66556008)(66946007)(6486002)(71200400001)(66476007)(83380400001)(76116006)(66446008)(91956017)(64756008)(8936002)(186003)(6506007)(54906003)(33716001)(5660300002)(6916009)(8676002)(4326008)(316002)(9686003)(38100700002)(6512007)(26005)(44832011)(122000001)(2906002)(1076003)(478600001)(86362001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YoZ5tgrbeO8t1CSlcyg9HMVqaJ0YUcs4rpUap+pypm6vZp7BMh4w3v12kv5g?=
 =?us-ascii?Q?N6Wd0GgvKYMeFyvBOCq8XrVONXPpQZUoxmzShMFXqieowNszvYlszJadFK7Q?=
 =?us-ascii?Q?eD3jtgoiUf0HzBSqpRY3AXoB3pQJACgtsL8q4YvMrmxWjQs9jK5FBoYHUlo6?=
 =?us-ascii?Q?L2aFwLKUhQ8vDF3ip8bN0VzU3Uo6B4DmiZIGz+HrIS5wYi9bz6408O0RHgZm?=
 =?us-ascii?Q?m3kB62n4i3Z/f8jw/lm7Hy1pFPDaeycLk920uwoENRatArZqlPPO+NGldmfa?=
 =?us-ascii?Q?tGctyxLSjfuuoVrsw1njeBoEc6Pa9pQF7cjFhSdi7C0ebCwInoGbcPeG9xjF?=
 =?us-ascii?Q?hgpr00Nc2BuJ/V79kXDUKJNhAS13ZJqTijHfmlWPhIS31SrG2gow+4mpeZRr?=
 =?us-ascii?Q?0z29F6Iyv1R00xTfOKVaAmPbvJVQEtx2h7kiomEa7UZexIHWb7vcPxvlyadT?=
 =?us-ascii?Q?Z+wcPxoXdngcENsTH7ES/3PS4qqjU0RCrx01Qpbt9nhEMjZS+QhAEJaB7I6a?=
 =?us-ascii?Q?qNim6fsPLkWGJzvyhJ6XdS5HC0Icw62e3VXZjBCIA9k1o01mF8NYWMwaM3Jf?=
 =?us-ascii?Q?IzmEeIFsmfZYYXzSPocXxu1/662LazOk4MNbR7GG719IWPyu3oOVis1nHetO?=
 =?us-ascii?Q?jFzT8djWEK4GQ7DmTItafgypULdhyCO2gvCSTcSHqnPsQajJYWvadJjfCg8l?=
 =?us-ascii?Q?7GvUMpEWIuAtu4HcFln5jq1X3eh+Sz1ycC81BLLEnc24oF9GOmI6YQ/oyYyk?=
 =?us-ascii?Q?DsodkUNgZst5w9/vDvDxtJOVfwFXZWhebkBCK5tVcnS4NPhoUIaMO9cMbYvj?=
 =?us-ascii?Q?6kCnhcLSHr2QCnbtPFoFJhr1kOpNZZHoB5jKV3jWgi3s3Wl+TOrxxMq2/Cnx?=
 =?us-ascii?Q?U5NUX3Akq8JuxBR60antr8fa5CJTxilR9iEhtZv68IDwah/53jhxeZXQAgQn?=
 =?us-ascii?Q?ac0LSlmyetUClzjlGjn8LkkLMngtrkyIwZL6mZIeqye5HwMck1IjQq4gqsUM?=
 =?us-ascii?Q?Obp5OAZULBq4odWQDf5B89vnE55rBSBfqtc6cyvluMnwDWHNPeY0djaDPp4K?=
 =?us-ascii?Q?B0uW6Vre2EDpvAMrVlHD7/ks89+btFk+r2mliEMDVSVa7MqeHNXcgfudvYcT?=
 =?us-ascii?Q?PwxLOjgL1qZdAOtNk1AxFydBYoyRfaVUIWs4IyjDsIPOj//fxGeY7e6GXBfc?=
 =?us-ascii?Q?SJHmonKo3q7QWle/WemsCH4WccqyQIpRAvIli8ixQ4GA0rM6GonxugMMfX9I?=
 =?us-ascii?Q?kQirG0PalsnwzpaEMrFQrmASdiiR9r0eHMsCqoCy1z8cjeFzTdAeGUguXCfj?=
 =?us-ascii?Q?+2NSe38U4gxHxKVmMq+PAC01?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB01F18B90112248A7EDFF4BB69F52FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f89289-c259-41fc-0436-08d90e4baa01
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 15:53:58.5525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDf6SP3PgpMsuOqr6FBWMzTc9E6szy+IYm3ID4rSf9rPpx0QBbgYWialp28nptzut3LVWGoGuE3VTz0/GRnuzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2079
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030106
X-Proofpoint-ORIG-GUID: fkIw3GiM1B2pxAH6tYbYyhdSkYh2MAX7
X-Proofpoint-GUID: fkIw3GiM1B2pxAH6tYbYyhdSkYh2MAX7
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michel Lespinasse <michel@lespinasse.org> [210501 01:13]:
> On Wed, Apr 28, 2021 at 03:36:08PM +0000, Liam Howlett wrote:
> > When a vma is known, avoid calling mm_populate to search for the vma to
> > populate.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/gup.c      | 20 ++++++++++++++++++++
> >  mm/internal.h |  4 ++++
> >  2 files changed, 24 insertions(+)
> >=20
> > diff --git a/mm/gup.c b/mm/gup.c
> > index c3a17b189064..48fe98ab0729 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1468,6 +1468,26 @@ long populate_vma_page_range(struct vm_area_stru=
ct *vma,
> >  				NULL, NULL, locked);
> >  }
> > =20
> > +/*
> > + * mm_populate_vma() - Populate a single range in a single vma.
> > + * @vma: The vma to populate.
> > + * @start: The start address to populate
> > + * @end: The end address to stop populating
> > + *
> > + * Note: Ignores errors.
> > + */
> > +void mm_populate_vma(struct vm_area_struct *vma, unsigned long start,
> > +		unsigned long end)
> > +{
> > +	struct mm_struct *mm =3D current->mm;
> > +	int locked =3D 1;
> > +
> > +	mmap_read_lock(mm);
> > +	populate_vma_page_range(vma, start, end, &locked);
> > +	if (locked)
> > +		mmap_read_unlock(mm);
> > +}
> > +
>=20
> This seems like a nonsensical API at first glance - VMAs that are found
> in the vma tree might be modified, merged, split, or freed at any time
> if the mmap lock is not held, so the API can not be safely used. I think
> this applies to maple tree vmas just as much as it did for rbtree vmas ?

This is correct - it cannot be used without having the mmap_sem lock.
This is a new internal mm code API and is used to avoid callers that use
mm_populate() on a range that is known to be in a single VMA and already
have that VMA.  So instead of re-walking the tree to re-find the VMAs,
this function can be used with the known VMA and range.

It is used as described in patch 39 and 40 of this series.

Thanks,
Liam=
