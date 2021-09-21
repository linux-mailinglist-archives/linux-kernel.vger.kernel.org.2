Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF01413078
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhIUIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:54:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:20324 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231248AbhIUIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:54:07 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18L8GJk8026060;
        Tue, 21 Sep 2021 01:52:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=auozVwbFSrkcmV2fQD7nO4QUqmKAfvgN3QJLtSCFX2g=;
 b=F0Z7bpe1AXc682UCSUiDXZan57PFzZtnUmspTvnUPh+iO6wSyyL0qhuTGMAD1XT64/TP
 PIyFmJlgfMwNKm3JWAWzeBKR60BEWNI+4le2fU3pKu4Rxlk424L2jjKj5fHCEiWtjeJG
 OKuGNzOIlQ7fwjlbTxKtqOXt9g/4vKPLofPeWOv9OVSwPs4WDcNAvx1b0MfJmLbQ4lwJ
 5lFkvpXL47OP6pocQ+oZQUxTIsP/bK25O5ELUotuRLZD+AribOY8SziSX64RWTfSm2vV
 1aDq9LGeCKSPwoem2Xijr7eCuE74lXBfVU6K1CJUdhiBi5JF8FwIzDsn5brMMr3DZRnX 7g== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by mx0b-002c1b01.pphosted.com with ESMTP id 3b6sctj4q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 01:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCtCyJKc3thlEcWHEMkFlvUUSKf9RneInsBnrbOMcSiiLzcqSaFhNFtgU3SlWhUMpHb4oXww2QJhHVGxbjxGgZRNi1DfEOUd7bvhChxhXA/0MvJ60p0eTG7S2xWFyoTsHdlgIdcLURVyIyph5j8kXinz6iw2CVPEAdZD6pU1/l7yXF53l8VeAald68WCepn3hSzy3e82gd0hUnB/UQk0XBdn+SXc5znRcfdBDwIgqF4XsmJ6b83R9yroUyXpXY1uuRSrRIn4fXmul4bxGv0ICYg6cYP5jpFOmKp3VDrveIDUCqR8/VJLezz+LvRFVFCbw7NRPueFaAMTrs03aLUEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=auozVwbFSrkcmV2fQD7nO4QUqmKAfvgN3QJLtSCFX2g=;
 b=Hot4PONxFN3ar1fo08iveSQkzfy7MIIIijbRcsWsAcNI9UQ6kF6jY1YifOO0FyP3NQHu/v4pV7+NnApGoSjlKSk8rjYRPxc4omNJeaSfIefgROemOYH+ECn1drBsYz60vmFqWvJ3JFPowsitsfKZR+pJY5qyg+lZg4olvFPaPmOMrPhhBGisPKLubyCNjeGegFvmyXokeLxEov7Y6tZWkJUcwn0jQQikVzyHexhmY9j2LuQsGZD/tF9dYAMF+IxSN3/Upx5wILOwTLJUOJF7beZancmGiirKA1IJebqOxo771WhrAe596I3mJdWPVZJraQDmLIjcWM9Ozgi5eRs2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM6PR02MB6283.namprd02.prod.outlook.com (2603:10b6:5:1d3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 08:52:33 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e%7]) with mapi id 15.20.4523.019; Tue, 21 Sep 2021
 08:52:32 +0000
From:   Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "david@redhat.com" <david@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Jonathan Davies <jond@nutanix.com>
Subject: Re: [PATCH v2 1/1] Documentation: update pagemap with shmem
 exceptions
Thread-Topic: [PATCH v2 1/1] Documentation: update pagemap with shmem
 exceptions
Thread-Index: AQHXrj+D4T8obcdGHUe6vvWc8xL+VautSQuAgADmeYA=
Date:   Tue, 21 Sep 2021 08:52:32 +0000
Message-ID: <F6A49621-C7A4-4643-95C2-F47B02F132D2@nutanix.com>
References: <20210920164931.175411-1-tiberiu.georgescu@nutanix.com>
 <20210920164931.175411-2-tiberiu.georgescu@nutanix.com>
 <YUjb91tWhd/YAgQW@t490s>
In-Reply-To: <YUjb91tWhd/YAgQW@t490s>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bfe007b-24a9-4073-efdb-08d97cdd26c4
x-ms-traffictypediagnostic: DM6PR02MB6283:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB62837A545E58237F71294DF7E6A19@DM6PR02MB6283.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QXFUJtxUeQ0a0t1gn4eHdKq96yFD4fvtdn1MkDsb430BvLfeNZtGWR4r90jM/IKv5yznL1DbOkiMSmKidb+80qatsRAkC63kKzCRv6UqXpc+uC/TkLt6eomk3a+/VEfbuRAz+LGJ7xi287XJ9GME8cV0f+swjnDnuo5FFSfCSHrcakr6HwE1sSMqefhaFJEooXI6VWCaeZ/ryncVk8+0EJl+ksr+ZgMNGpaeLBKpl5FS4CBcInfKiFvpuJhRUT71HBtgXwO4YIfUHTKjmwSlay/uvdEBnWMrbDNUzl206BvRIljITKbqrJ+F0GZ0rJROttOONzmtWGacTJRxMZ7/9PVqdYnJLRe39QgsqPhwULMiFPwvzdQ9YVgNb5L8TBpQ+THT7Sjlz8NCg3qDztBaMpufHFqnbsnNOyJ+RGvR89S4/hjpGV6swyaQrsrtTozJjTM+q/YR4Y4v37LLn+0ew2mYono9z/LRdktiwD1eJq2QP3/dKy1fGrCNyGzhdtqLHQcYjUX77kZMUfe2GFYJoj26NT5RAaRE7/WWFv9Hk8HIn0Aq7JcIHV8wSdbMWJ8zaqBDjOS+sp9ka8EBPjdAhmaZqgDKvMHjsgg26ZZUEU7kyVdQrnvJOyvuzK5J8g59eaNx4OUJPrUa6E4jxKfBK0yflyr5PsfepSy7/MyuXtvzQnbsFAapiBC4ibRzssU9oAfV5fjE7qG/rhotuUE/C/uJxPdf8ViI0grVivesu5o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(6916009)(38100700002)(36756003)(2906002)(26005)(8676002)(508600001)(86362001)(107886003)(6486002)(6512007)(186003)(2616005)(4326008)(6506007)(54906003)(71200400001)(5660300002)(66946007)(66446008)(66556008)(53546011)(91956017)(64756008)(66476007)(33656002)(44832011)(76116006)(316002)(122000001)(8936002)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rqr9GT2XlfzBTh8b5jMUm4FBnKtSizUsVwucrxrUP8DXhVPUlaVZM5DZdwQe?=
 =?us-ascii?Q?34whKsfNxzxd2SpNEp1mbv0QU/rLtvElVov+1TyeXLzQXEAyFomm9h/1FRMH?=
 =?us-ascii?Q?7yoQk51Gvm7sngZaiZltbtdthn9kuFmFaT8rVDswj03oYV/dH/fu3QXHD26u?=
 =?us-ascii?Q?hngHtoan1voN2rKlEFqJIJ88nxK2YH3CfG9F0QzYi1/L2i+CmM6dI8kAkTFU?=
 =?us-ascii?Q?56co0eHaeDmZx9K8xUkfKMIka7iLft7o1fFpK/1TeN21Ax1bDZSmbJJ32egd?=
 =?us-ascii?Q?fR85GG+SprjEBajPWRIn9bHdu0Qhx+WfOzRe2b2X2IfU/Y8OwHletTg26S1y?=
 =?us-ascii?Q?GVs7IgkOrsHPA1xceirCiB00jDDoAWcRLd8Z53mQNc0T+p9TnvvdsrZFJaiJ?=
 =?us-ascii?Q?ZO5TDeBGB4tkaEAzWYCS95U4wcakcR7RF1dmlvb0BCLQE6QMsH1JIeDHbMJ4?=
 =?us-ascii?Q?Iic/OEl1ovFyiqMkDyRuQIMdh/7hWLFaXqYe5lTP/bTMR+QklRVeew11AKQJ?=
 =?us-ascii?Q?686A8kX+ilhPxqF+nKn4GrO2map9a+LcHlIf04mfxsy4Qq/rGpRHvMDF1mI2?=
 =?us-ascii?Q?+fRnxKD/MUQQ72Q4K7A9znRNe/I+6xU1tkzSlvMShnLhkDJbJSqBlLvAignP?=
 =?us-ascii?Q?9rGPvZysCR9569CGCKcXR8EPiTeywF78ZFeh0IUqmPuicwf/P1tqeXNYCeal?=
 =?us-ascii?Q?CnRJSJ9gFhxoP9/4IoSZ1cX50qTKxUKbP5kqgJTkoYfQy2AT15rhEMEVSu25?=
 =?us-ascii?Q?Z/nNcV82JKFqXVG+4vZcL3LJ1MSxN/ymglVAKU36gD+KeJZV96m8xF4gx9GI?=
 =?us-ascii?Q?uMZfEMfWXL3au9uDuNew9eOy+5LKIIOiyywxUxSuR/3IgJcplsEjw0QeqFd2?=
 =?us-ascii?Q?6Tx7yyC7QET94mSF7AwIXNSuwGD1zOJMykfixi42TehxWKTEYvsPVmXDaRvL?=
 =?us-ascii?Q?MEv1HmIz7sF26TCC6zqPMq1UnffVAdQ3Rv7WtK6X1AMNaLqPS63v9nrfJNi/?=
 =?us-ascii?Q?oBbAcwHHhOh+4S6FuXTrUXvvBYWYWe6TcrxbVVrlHHpMk1OHLQQXuYJ1zbgT?=
 =?us-ascii?Q?wK1yHYhbcr41e+fSKPXUWSq4DSKx9rCv1aF7gFwz0rM5Haq3LWzM9OnGnfYN?=
 =?us-ascii?Q?6+63Q+x8Xg5gdZkhmzqJZP5QNkRVzsQlH+6Z0xaAwf0c8MhVlq3zxKb8MyOJ?=
 =?us-ascii?Q?My61q0WYhcYE70Tus+dVOFAQlI+DJVZ7piLkuhw/AqSU1469OoV/QF+IIUcu?=
 =?us-ascii?Q?N5uvXW+LTMWVPtH2BWgksP8tgR2E4HkFYF3Xs5E9YJCWAJEgBddLrX9K/LWc?=
 =?us-ascii?Q?zW4csoEWR3IQR26/MmTNbymg?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <55132C605629E8448B529E1145E52A89@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfe007b-24a9-4073-efdb-08d97cdd26c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 08:52:32.8723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6CoEYwSYxrsE+ypyIzmT0dMkm8KmnfZRcKfdCktPAgZS2eYVGVTknyb72jlFxPEbmwHtz1ydlhSXJr8TOvxcI7IP11irf0d1O2/i6SmJ94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6283
X-Proofpoint-ORIG-GUID: yXxZLUCjt3O6ZZrMN8uUjTcrJtJuPSby
X-Proofpoint-GUID: yXxZLUCjt3O6ZZrMN8uUjTcrJtJuPSby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_01,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 20 Sep 2021, at 20:07, Peter Xu <peterx@redhat.com> wrote:
>=20
> Hi, Tiberiu,
>=20
> Thanks for the patch!  Yes it would still be nice to comment on this beha=
vior,
> some trivial nitpicks below.
>=20
> On Mon, Sep 20, 2021 at 04:49:31PM +0000, Tiberiu A Georgescu wrote:
>> +In user space, whether the page is swapped or none can be deduced with =
the
>> +lseek system call. For a single page, the algorithm is:
>> +
>> +0. If the pagemap entry of the page has bit 63 (page present) set, the =
page
>> +   is present.
>> +1. Otherwise, get an fd to the file where the page is backed. For anony=
mous
>> +   shared pages, the file can be found in ``/proc/pid/map_files/``.
>> +2. Call lseek with LSEEK_DATA flag and seek to the virtual address of t=
he page
>=20
> s/LSEEK_DATA/SEEK_DATA/

Oops, mb. Will change that.
>=20
>> +   you wish to inspect. If it overshoots the PAGE_SIZE, the page is NON=
E.
>> +3. Otherwise, the page is in swap.
>=20
> It could also not be in swap, right?
>=20
> Example 1: this process mmap()ed an existing shmem file with data filled =
in,
> but without accessing it yet.  Then the page cache exists, not in swap, b=
ut
> pgtables will be empty.
>=20
> Example 2: this process has mapped this shmem with 2M thp, all data fille=
d in,
> then due to some reason thp splits, then the pgtable can also be none but=
 lseek
> will succeed, I think.
>=20
Ok, those are a lot of exceptions. So it's possible for the pagemap entry t=
o be
empty, yet the page itself to be actually present. When that happens, the p=
age is
mistakenly considered in "swap" by the current algorithm.

Thanks a lot for pointing that out!

> So to further identify whether that's in swap, we need a step 5 with minc=
ore()
> system call, perhaps?

I tested it some more, and it still looks like the mincore() syscall consid=
ers pages
in the swap cache as "in memory". This is how I tested:

1. Create a cgroup with 1M limit_in_bytes, and allow swapping
2. mmap 1024 pages (both shared and private present the same behaviour)
3. write to all pages in order
4. compare mincore output with pagemap output

This is an example of a usual mincore output in this scenario, shortened fo=
r
coherency (4x8 instead of 16x64):
00000000
00000000
00001110   <- this bugs me
01111111

The last 7 bits are definitely marking pages present in memory, but there a=
re
some other bits set a little earlier. When comparing this output with the p=
agemap,
indeed, there are 7 consecutive pages present, and the rest of them are
swapped, including those 3 which are marked as present by mincore.
At this point, I can only assume the bits in between are on the swap cache.

If you have another explanation, please share it with me. In the meanwhile,
I will rework the doc patch, and see if there is any other way to different=
iate
clearly between the three types of pages. If not, I guess we'll stick to
mincore() and a best-effort 5th step.

--
Kind regards,
Tibi

