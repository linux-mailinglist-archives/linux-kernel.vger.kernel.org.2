Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2F372365
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhECXHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:07:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47486 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhECXHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:07:02 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143MtQp2056941;
        Mon, 3 May 2021 23:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0FOYDE6BFLn2A7K/NmzBBz9/INirN+nsC9IfFPMRRIw=;
 b=T3qnJ1ZOHAwgKvmy6sy4+xo8F+RYJ6cO9f6OiEed48NFjPz8YYxdaGQNTLZRpXhYeyp5
 AMEUpxraG9beSIdb0axGm2sXG3ITAcdfWG+FB35Ja2+N8Zg6czAikGhjYRyWfhzfu6bu
 DFTK+IkYoN1sGVb5MsywCK1Wk7DFhUja3ACOG+AOmhVlRSq90APdk9gKsFFh5wi9e1/g
 NJAln84GAvVeaB2p0sDYRkznk32XbfugVVx+NH3nuajcTwpui1SJHfXDvjOiSJgte90a
 oJDczANnlQBWE54fo5NYLwyWzQ60qsFpJ80aJeZIr6wxEd3UMuY/wlxAGAUKV7PdOMp4 HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 388vgbnaq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 23:01:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143Mt9kZ099504;
        Mon, 3 May 2021 23:01:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by userp3030.oracle.com with ESMTP id 388v3vjabn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 23:01:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrScXiWEz6uWEIO1/CtkSAAQnJM6zg9bn+d7Hbb0tmNGKYCYcEHyNa4h9ysjEJUUH5CNKUTih27AuwWSW6n5ANTP2tBO0T8iPvq2OyFjyDMkq8+LiYr/hacPtGXBxIAZLUE9llLV9MV5gMdvkvOljE1fHI9epAIEmZsyqbB4cfg3aSsDLNFd9eZKbSddPJRWXqJbl2klKZU9nZDV+4p1CUgknS+eS7spo8Q3tvKGfqGdhpuAQzdYMEWFiQ2+MKDeZBG6T7p0sv6HJd1qQQflOSQNkzb9+AehBqwZiRRiswJ4RM8AqQk1Ng6D4otC+y6krQ4dPSNSu2cfMHwkwCXE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FOYDE6BFLn2A7K/NmzBBz9/INirN+nsC9IfFPMRRIw=;
 b=ZcFtq9y32dwznyxMBdKFioTreB3fi4uGXgLwzGjKxOxChmaek7LbWPP2YgxNH3z1vThQEmlw4iPx4GQpI+VRiKB5Wr30Y7TAxEL0rf3nWKS/UT5gA7jhz3VNwZ2lchvMenhvMvMqsordiIZrMQ9epbGIXEGnpBHbu/5HjlUKhvjR/r1FBb/FpUL8MSAICaFyKkw87iztk7gfX2yd1qFaVhWSxxCfJKBF+vgXztsqZIstdmg7/ri/pLMzgomsyU5q09JawOlcJgqVr2Mqe7iLKY3jkdS4LCXcl6K/GF00sADvWPEc5Tx85FW2jvav4UaLtCVk2k+vcUoMxpE4/OYrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FOYDE6BFLn2A7K/NmzBBz9/INirN+nsC9IfFPMRRIw=;
 b=PW3+0jbcxNKyfdsW85IEV9T8cgEJjXimmb8HMmFF0L+IAKbTP8faaYLuRSqXOlwhmBemfVtK6SUAcGHIqu8gxHTLL7mlcQIIEBv97O61gUaIxXYMw2vcVDpR2RtBKe3V/V2a/8iRcarrJ63Xa3ahMduDbU6dK7eUBCy11+VGDPI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR1001MB2190.namprd10.prod.outlook.com (2603:10b6:301:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Mon, 3 May
 2021 23:01:38 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 23:01:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Michel Lespinasse <michel@lespinasse.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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
Thread-Index: AQHXPEQ1vRs0vBrIxUqHuI8bmYeYEarOGOoAgAPXlACAAAHPAIAAdawA
Date:   Mon, 3 May 2021 23:01:38 +0000
Message-ID: <20210503230130.vmrwp3xnckdnintj@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-39-Liam.Howlett@Oracle.com>
 <20210501051330.GC5188@lespinasse.org>
 <20210503155352.74xqhqgizaagdro5@revolver>
 <20210503160020.GC1847222@casper.infradead.org>
In-Reply-To: <20210503160020.GC1847222@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c2fbb34-ea50-4c54-34d9-08d90e87686e
x-ms-traffictypediagnostic: MWHPR1001MB2190:
x-microsoft-antispam-prvs: <MWHPR1001MB2190B2AEDE10EB25AFD9382DFD5B9@MWHPR1001MB2190.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xi9ZMyz/tfwXh4FId7qEfC7CY7sQyiQpSYEPHQfGtF/rEds3nClZzAG5lp3dYo7k+Ys1OTLWIassTxXcFsm4V8b8UA2z2WpkILp5E7Bq5LqyIhNzXmsDANLUF+ple40kS1pYTLNFEqZUbd6970jJa6TAGRiOzETORUB744qEzMw0h1mDbbI4lMhs9Kgi2z6S4lv2rlReIE4jn7+pC00Ot4VK4ojwAqv7W0Jsn/iF0hFPg8lh9g1fdg8zx7ANQPkrAj/cSnRf8Z5Pqx7JUMs09K+47ODsQWGAsFM/WbdwJWaoOcMOgvHRrejjdVNiVgwV95xd3BnmFlgEoLNXW7l9latEb28FuNJYZoAUQ0aiTzcQKk/Vh7KY5yDs7IBOyTsaDov8gS5Fww0QpnRDBq9OR7kxg3tP18PDG4MXPwbR39NHh0B9s1PdKhkLFoo6rNiAtGxOjH0E09MU+oT9jeZW1WhMdvHQm6TxUisx46SkER47V8ZuQrLh5ytYltNjrQtBXFvPzOsLfR/+2usFjRyO/859PLLyomEjwtmL6FvKYb+Pn4p9aMZGt9n94zq3wos/qFA7jITCOKdiEHOTFU9EKb1t7EKjIxknN4tzO6IMQo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(396003)(346002)(39860400002)(376002)(366004)(91956017)(6916009)(26005)(86362001)(66946007)(54906003)(7416002)(71200400001)(5660300002)(44832011)(83380400001)(4326008)(76116006)(122000001)(186003)(9686003)(8936002)(38100700002)(6486002)(6512007)(8676002)(316002)(6506007)(1076003)(2906002)(66556008)(66446008)(66476007)(64756008)(33716001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CHFinFCau498cEGOLPRbVn1YfedywqpzWcM0IuT7dleKlX1bbA/5Kjovynzi?=
 =?us-ascii?Q?k7yJTR7euCrxJ8LIFj1vdCEQQYzzA7JmV4HFh/sOSPJxKqAzeB9yyGq1qmTU?=
 =?us-ascii?Q?qKSRPvgM3jYtzH+Agb5mlNyTz8XVv4yG+VXUMtWJJg2O7F3vKcE6JZcpVLFj?=
 =?us-ascii?Q?AJVnihVvOC/BMmio5h7PXmBFbD6ALrXOFKuAiCZ2n45gHKB6ZNNWxQmgDhXL?=
 =?us-ascii?Q?ZP99Jzy2FmhnPqVCPmI5BwMjcB9GPxgr8isw4U4dEHUhMm0PYrjnitZHeJ7s?=
 =?us-ascii?Q?u5BhhEVU6ywsIHjWyTYHpJU1J+7oBHLJ3TLDtQ17IvI1wT0PRG0pWOHQQLtU?=
 =?us-ascii?Q?oVOnFRhHIgr++d0mxj15qr/h/b01w8QxQ4ABTGgrMYX+hzzMzY67/zbgzFuS?=
 =?us-ascii?Q?Xurks5d3Wgx3LpvO5zT2E9pBUFbnj5Ac6gwogN43TA6fvwWk1TDL1XQJqnfU?=
 =?us-ascii?Q?uxyZ8FYCw7nIMmcdh052RFD3bPu98d1ZbhznGpoUC/I5BE7u/DzHMV3/fJO7?=
 =?us-ascii?Q?a6Ja6jg5kMbgj5jtZ2gqDuST34QbKFi1oVvjeDO5PjXShTDxi8xy40Kh/N0f?=
 =?us-ascii?Q?Q26c0qngfmxfF9TwRxp41chaozYD0dXYTr+y89DBTyK8JVXXS1UKMQIduhRR?=
 =?us-ascii?Q?DfAsKCF+P9XDIIb1vaFyJkjS78g/8yAXzTYwAZ+iGIOT0cVnvn9OAn0M7Heb?=
 =?us-ascii?Q?ssWLYvZicZws4yzBjSXDi0L7SMiEvKfvHPEwrc6j2tkj+qqt1utL4kiWOAmq?=
 =?us-ascii?Q?qIpYH1AGX6iQe+AD00ir9t6U1ZY0zZmvFgflIqXs+Si4x5tIUevk5eqTHyEG?=
 =?us-ascii?Q?jFDjcW3rReXxv9E7D7V42awLDMFsW9i0gEHzbx3P2u+MWwuvw0CCzz5cSfYd?=
 =?us-ascii?Q?sg7aVKK+vRGC05DUllw9ASrBj+JZ7CpDSjYSEVLuvpWQOWqPTv39OueFgLsJ?=
 =?us-ascii?Q?T/BUpKrdZ6QKVyK0Xcv1JSPanhKJuGFqmBhbEHrEjy+JcFHl5zODdDR7ZjUQ?=
 =?us-ascii?Q?KxxX0SmVVzBp0RtVl6iz/K7MkXLrnpiqVpG/Goe6ceMhwuPOqvgHMqiJxHwv?=
 =?us-ascii?Q?OAUA5dIbrUucBOVgtsoHloiQx4XEJEmcaHOQlNPhjPKaDIy0fQDv14Yl5ZR8?=
 =?us-ascii?Q?4tz0cm/O0RpK5ucr80Mgb+c5vsCw+9arkyAoDTTc+v+rMA50Jkss+VmQ8knK?=
 =?us-ascii?Q?WLjYVkPyI/t6ztmAfYC0wadUktHaAX8aWnxdiiXbcjhexiCuuvYrZja2PjIE?=
 =?us-ascii?Q?XU8uOZyhivdNeLHLs+V4qgUOvAsn3JhSKIlWr4l1E56w21msDpYHxat4Ib8D?=
 =?us-ascii?Q?foTqrobf538lYhcHZ6A7M774?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D82F3CBE5CDFC74D97D4546AA9F32507@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2fbb34-ea50-4c54-34d9-08d90e87686e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 23:01:38.3583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8EB9xEY+YDZQe9WXlyY5Uq8ePWd28+Gxvb2A0VMxf7VElZ6G7rmTSGXohuclb+3224nnl/W8jifmnbEqz6rR9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2190
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105030154
X-Proofpoint-GUID: s9JLqWTT8XB3LHtQCRvvfDVweMTRPjVY
X-Proofpoint-ORIG-GUID: s9JLqWTT8XB3LHtQCRvvfDVweMTRPjVY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030154
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [210503 12:02]:
> On Mon, May 03, 2021 at 03:53:58PM +0000, Liam Howlett wrote:
> > * Michel Lespinasse <michel@lespinasse.org> [210501 01:13]:
> > > On Wed, Apr 28, 2021 at 03:36:08PM +0000, Liam Howlett wrote:
> > > > When a vma is known, avoid calling mm_populate to search for the vm=
a to
> > > > populate.
> > > >=20
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > > ---
> > > >  mm/gup.c      | 20 ++++++++++++++++++++
> > > >  mm/internal.h |  4 ++++
> > > >  2 files changed, 24 insertions(+)
> > > >=20
> > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > index c3a17b189064..48fe98ab0729 100644
> > > > --- a/mm/gup.c
> > > > +++ b/mm/gup.c
> > > > @@ -1468,6 +1468,26 @@ long populate_vma_page_range(struct vm_area_=
struct *vma,
> > > >  				NULL, NULL, locked);
> > > >  }
> > > > =20
> > > > +/*
> > > > + * mm_populate_vma() - Populate a single range in a single vma.
> > > > + * @vma: The vma to populate.
> > > > + * @start: The start address to populate
> > > > + * @end: The end address to stop populating
> > > > + *
> > > > + * Note: Ignores errors.
> > > > + */
> > > > +void mm_populate_vma(struct vm_area_struct *vma, unsigned long sta=
rt,
> > > > +		unsigned long end)
> > > > +{
> > > > +	struct mm_struct *mm =3D current->mm;
> > > > +	int locked =3D 1;
> > > > +
> > > > +	mmap_read_lock(mm);
> > > > +	populate_vma_page_range(vma, start, end, &locked);
> > > > +	if (locked)
> > > > +		mmap_read_unlock(mm);
> > > > +}
> > > > +
> > >=20
> > > This seems like a nonsensical API at first glance - VMAs that are fou=
nd
> > > in the vma tree might be modified, merged, split, or freed at any tim=
e
> > > if the mmap lock is not held, so the API can not be safely used. I th=
ink
> > > this applies to maple tree vmas just as much as it did for rbtree vma=
s ?
> >=20
> > This is correct - it cannot be used without having the mmap_sem lock.
> > This is a new internal mm code API and is used to avoid callers that us=
e
> > mm_populate() on a range that is known to be in a single VMA and alread=
y
> > have that VMA.  So instead of re-walking the tree to re-find the VMAs,
> > this function can be used with the known VMA and range.
> >=20
> > It is used as described in patch 39 and 40 of this series.
>=20
> In patch 39, what you do is:
>=20
> 1 Take the mmap_sem for write
> 2 do stuff
> 3 Drop the mmap_sem
> 4 Call mm_populate_vm() with the vma, which takes the mmap_sem
>    for read
>=20
> The problem is that between 3 & 4, a racing thread might cause us to free
> the vma and so we've now passed a bogus pointer into mm_populate_vm().
>=20
> What we need instead is to downgrade the mmap_sem from write to read at
> step 3, so the vma is guaranteed to still be good.

Thank you.  I will remove these patches from the series and work on this
idea.

Regards,
Liam
