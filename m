Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8FF38C92B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhEUO0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:26:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40588 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhEUO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:26:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LEOsYa062649;
        Fri, 21 May 2021 14:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DVrwV+lG6Nijm/Dj2Txd/TSDiwjaOGob5AjORE9LEj0=;
 b=NqVi6cW3u/mSa18ESCczAxrQr/DO2mDYEwkKU26wyDPmMFg61FVjq4ObKHgCCXHX/rcx
 kV4zCcvt7m8xQIHArtZXCRO+E8WuY9jlggDYNRTzYU8ZILgaINZJdNA7vERQRJ1tA/fH
 +zUF3Mssc0+LUAtg3TCjgHBnuik2odmjB/L2aiKZvk2uIN7dYbZ2RRZ3QYg9sSSklg1I
 R4T77P3MVic8ws9PZbHcA1AjeJqo5ZC/lt/iyKK8+T0P5ldHxeY5U49BBbI73o51zZPz
 fIGkPfwP1giFEf9Wx7XPl2DBLHK6tlGezm4vuiHv5GUfuDtrN5vxAso6OO9tarcT8FcS 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 38j68mqsxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 14:24:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LE5X8o014742;
        Fri, 21 May 2021 14:24:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 38meeht6xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 14:24:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3F5cN8EmfS/3Tz4WewgtPqgKPJjNQQv/m1JbXwhIN1VJ+CtIwDlt9Ioa0raMpbIKW9nVYtLy0YzW86s9oluFogwGDuaWMD9rHrJ+nAwguWvFUYpEF0KRafIisDQ9y8KE6M8nVrwxu7SPbGO28K/CGNPbOwh2doaSKanzF4gYESIbZDy3D9sAvpcOFoHMoL8xgNI1adF3a/SbR1Ls3hBV0wN8xNfyAL28b/9XjwXh5NYHZnpopvQ+dnk8ODjoAKCHAxQ6sF6uyfVZCYqw2RVNhpRgFqp5rBH1rmE1bvWBu1d4pYeT1zBS3Pps/LTCO3Wnnz/3qwgH0ccXedhOKy2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVrwV+lG6Nijm/Dj2Txd/TSDiwjaOGob5AjORE9LEj0=;
 b=aOcJHTc8dE5+IH4HgPDao19yWot+36n8K0bZ23rx5RugkuLgoj/hoo0EWqIy2kC99zPnKTyqXcba/gl5h1jj1WFW2a+pkfdZ9grDGwkTRrALdHhABQDw+BX/tK2o9Do4EnOaMlzjvDm8yHVH0+xLJmWF3R4F7iIQ7E9C0vbSTXngDabAynL2a3y+Cz1JGwU1cILO5ehdw+nc2kCumy4XPEqUPr+4vBHZV2Obv1VV6zZb/KxvKAM+bl8kLTYizEWsn3OxT6BA8z7LukCLOvnkcejBsydpQLg4ufvqSWCKKkUQ7P4LeNWXvwzGs96tCSeZddg1vd3h/YYjuNSU1faEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVrwV+lG6Nijm/Dj2Txd/TSDiwjaOGob5AjORE9LEj0=;
 b=SVkaxJC0cgObDzioZOT9iQHfz5akxUF2joYdaS6hUCW3HoJnpcWcobPj0MOF77Iz1v6EdyDEbiJC9uxPci/76HkhkQfxKsEZDmUW9gOxcG+uaSe8jleDEZthAPV9Uj+5MY2GaGh0/wktkZmSikyYbcGkta15qbFKG8OhqpiSXRE=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1584.namprd10.prod.outlook.com (2603:10b6:300:29::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Fri, 21 May
 2021 14:24:47 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 14:24:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: Re: [PATCH 01/22] mm: Add vma_lookup()
Thread-Topic: [PATCH 01/22] mm: Add vma_lookup()
Thread-Index: AQHXRb2/5QqU4ByieE67cOKQO9MokartWGIAgAC2NAA=
Date:   Fri, 21 May 2021 14:24:47 +0000
Message-ID: <20210521142440.n6ejmeaxnxjus2to@revolver>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
 <20210510165839.2692974-2-Liam.Howlett@Oracle.com>
 <20210521033232.dyams2dziycp4hv7@offworld>
In-Reply-To: <20210521033232.dyams2dziycp4hv7@offworld>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b32c866c-4dd1-446f-c26d-08d91c642fde
x-ms-traffictypediagnostic: MWHPR10MB1584:
x-microsoft-antispam-prvs: <MWHPR10MB158412BB64F68EB32ED3B14DFD299@MWHPR10MB1584.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gd6yCzv0PwuWAduleznJJiq6lvtciFE24IeTGanrB8q3h+0HodCgKWroHFV9MuEOe4RR52au8iTzymoqk47vXEyTDGsQJC6OhEoIU6PsG4OUJMcL5noV5dz1P5IJAINWsJq50mJnb6f2GAf9xE/Ju4swpKJlZ7vPuqFFaxGc4axq2ikU5fsjolU7wqGdE07FjZxQ15poD7JEDK3ncVY1n0t2N/REHiJtoSToF4elxeT23njVS/WAkxy3Gwg19air9p2O1ektDprwjfH96bFVTPEOhdjOYvRI/h6A6IpoVqceOoErijJ99zqnp+XMeEAiT7gcJgryjWyMPYkh1pN/C2s1xSbMseGCU0681fN1MKXIyByLT/e2vgetrQi74wtX43H09LF1tMW9R9VBm/R/D3xohM/psGRgFKIfcPlEPwm7FTwAXGm/XaUzT349knGfREtghjzI3HLG7mwXFTmw0bIDXGvQq7Vh7OfBqTZw2XLMpwg0cx0x0vPGefuMjImS7MDJvrAzAR7uE8TLc4kTMGbNjy/FyELZexvB9iBh145TnMfgxRJRaSyFwyjikvmvqqjXVC3cVZrMdLdo0KQ5k9dWhNkN4IF9tXwgTaef1/aFltzTFfv5k7gC2w9ZcE5N0pFD5yUtn0VpI+jHyQr9zQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(136003)(346002)(396003)(376002)(39860400002)(38100700002)(86362001)(5660300002)(83380400001)(6512007)(8936002)(71200400001)(9686003)(2906002)(44832011)(110136005)(6486002)(6506007)(1076003)(478600001)(26005)(122000001)(8676002)(66946007)(33716001)(66446008)(76116006)(66476007)(91956017)(186003)(66556008)(921005)(64756008)(316002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?B6qhqzGejdEVyCWyOacYIijTpG9XOI+sDuSdpGaX55BfvjYlxWTr0um8KqEQ?=
 =?us-ascii?Q?p5BSZRT3uma38RboeFGN6OSkXUNGW5kSgutWlJIIxadiKXqkJXW8rojsBO1V?=
 =?us-ascii?Q?yyMEX8R3CkcemfdotmhW7XpryS5BHYEQcn3g97VrdqHAvuj8HAJIV5Fgzyea?=
 =?us-ascii?Q?+1Saj+bg/+7148NQYc9P2I+BWk2GyzNfklXx/mi8KgxN0B9N6p99WYDqr3hP?=
 =?us-ascii?Q?SJc012VBJnGCELVxR+ZL4HqKm5fMLLNcIdXx4d/rBFCwGPj44h6Vvuv8h88Q?=
 =?us-ascii?Q?aLNqSHiFrLZnnLiP0zoaeOTxQLzEcYlgxB7xVeTK8KBFDKzU/jSEYVMjNh6p?=
 =?us-ascii?Q?/KY3wiQIhlqKm5oOio4o9Av0fHjquIjgWWHEQW7RGVRA19Fz+hle4kiKu0Hs?=
 =?us-ascii?Q?cfPdidTL8s9/dvBMJ/yCRMZgQCjx7cJ2XYg4tcFi0Y8yr1cyeVa0ynhmn/60?=
 =?us-ascii?Q?SfGLCJvGaF4H9rdZdZpbzXdr1K08TOwvVP+aifEkAqxLHyL0DTdNngaelcAA?=
 =?us-ascii?Q?ybBZNlCxIrb5wzeaihVqZrkAj0WTAxx8ig+k/KJwmWWH5Oxw00QBw6ZA4P2F?=
 =?us-ascii?Q?I1nM+Iq5y8pAxP3OzgOC0yijDI9+vldQjh0i0AiDVdYOYkCGaRptfBdrVJah?=
 =?us-ascii?Q?bevdmqiXmVyiNhNdsAJWJqRT3U3vPkT+9v+XUEf12IszOB8OEEfI3TbNfoSB?=
 =?us-ascii?Q?xH3Hmgp2RBFQqG1Proj8IYKcuc9gMeUnx7bmCroqW83j5yj9yev7XMh4ZS5h?=
 =?us-ascii?Q?TWMVgoSw6fyDVIsNt+sHMCoU8RS757RXcbOyaVuO5ZyY7Q+QzefFL07CxglO?=
 =?us-ascii?Q?X/LJDkkWl8jMhW3emuWRitSRvYpDWmgKdl4CGC0boqRfb82K4wSlx7v8+DqL?=
 =?us-ascii?Q?o/77jtLHFMWfzqz6cKRWuE7C96tbBekdoIlLoi8VC2OwLKxos6N5RgWoeoxR?=
 =?us-ascii?Q?FE/yHatYDHoNDyrffFZyI6Ll3HKgr065V1fpigRu41Y0CSZmIaaIqQqXAzGT?=
 =?us-ascii?Q?L2qD3ja+C/Pex+RmXHKqUDXOfP4i+bCU3tFKS4Q+TbQF0iE7xX5iKyARWOVn?=
 =?us-ascii?Q?PYFafJW5ulKrlAaYHUY/9fyXZ8Cg2GIkuAW51LFr+m8sx2njPMKPeFSnbAfe?=
 =?us-ascii?Q?wQIjeh8mw+rkML0a2YRftAHiViufWs8YFs4VIMmlrNLOAZmGwTxTmWzR0DMa?=
 =?us-ascii?Q?ZNDI26TX4r9aXaBCjnPZLw25tyXCGXHR1/2cIXgbBanIMhcd533jftlfS6d8?=
 =?us-ascii?Q?t3v7zUP1Psk55+vpzeXdOQN+zeYFEu9jshN2VotSn+81OMkIlZL6NzdRsvtq?=
 =?us-ascii?Q?fjdOaCaod2EtuyuNqnhyxicP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <442400745FF6B0418A263609BC9CAD30@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32c866c-4dd1-446f-c26d-08d91c642fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 14:24:47.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sD7gJe5+AU33gLe4xJ/jNo8CwPV25brXcFx9VY6zlnCEm7+0wJJY9VCGfHeYYtS6WH0oEcuZLBFtAeyW+HO8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1584
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210080
X-Proofpoint-ORIG-GUID: af-LrpbEyJoCwR5cWJf74P4nCXf6YMgj
X-Proofpoint-GUID: af-LrpbEyJoCwR5cWJf74P4nCXf6YMgj
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Davidlohr Bueso <dave@stgolabs.net> [210520 23:32]:
> On Mon, 10 May 2021, Liam Howlett wrote:
>=20
> > Many places in the kernel use find_vma() to get a vma and then check th=
e
> > start address of the vma to ensure the next vma was not returned.
> >=20
> > Other places use the find_vma_intersection() call with add, addr + 1 as
> > the range; looking for just the vma at a specific address.
> >=20
> > The third use of find_vma() is by developers who do not know that the
> > function starts searching at the provided address upwards for the next
> > vma.  This results in a bug that is often overlooked for a long time.
> >=20
> > Adding the new vma_lookup() function will allow for cleaner code by
> > removing the find_vma() calls which check limits, making
> > find_vma_intersection() calls of a single address to be shorter, and
> > potentially reduce the incorrect uses of find_vma().
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> > include/linux/mm.h | 18 ++++++++++++++++++
> > 1 file changed, 18 insertions(+)
> >=20
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 25b9041f9925..5f2a15e702ff 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2689,6 +2689,24 @@ static inline struct vm_area_struct * find_vma_i=
ntersection(struct mm_struct * m
> > 	return vma;
> > }
>=20
> While at it can we clean up find_vma_intersection? I'm not particularly
> user/fan of checkpatch.pl, but this one is kind of ridiculous.

Agreed.  This addition is worth re-spin.  I will change the comment into
a kernel documentation style comment at the same time.

>=20
> Thanks,
> Davidlohr
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c274f75efcf9..16eddedf783f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2678,9 +2678,14 @@ extern struct vm_area_struct * find_vma(struct mm_=
struct * mm, unsigned long add
>  extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsi=
gned long addr,
> 					     struct vm_area_struct **pprev);
>=20
> -/* Look up the first VMA which intersects the interval start_addr..end_a=
ddr-1,
> -   NULL if none.  Assume start_addr < end_addr. */
> -static inline struct vm_area_struct * find_vma_intersection(struct mm_st=
ruct * mm, unsigned long start_addr, unsigned long end_addr)
> +/*
> + * Look up the first VMA which intersects the interval start_addr..end_a=
ddr-1,
> + * NULL if none.  Assume start_addr < end_addr.
> + */
> +static inline
> +struct vm_area_struct *find_vma_intersection(struct mm_struct * mm,
> +                                            unsigned long start_addr,
> +                                            unsigned long end_addr)
>  {
> 	struct vm_area_struct * vma =3D find_vma(mm,start_addr);=
