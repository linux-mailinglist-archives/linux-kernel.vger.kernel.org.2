Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E9B34D86D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhC2Tlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:41:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12484 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230462AbhC2TlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:41:20 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TJeKZt019685;
        Mon, 29 Mar 2021 12:40:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=2gtGarr3SqQXewllJzqfjlDtDm/Jsx74OoIf4oQPN3s=;
 b=nO0HgITxsWePv6Ysrab2BRdG9pC01+Z2gwm6iDssfmBqbTCWDK8W79zrT16IdpQPAGXP
 A69XfiNYHMyOhPhWniCB/cf4p1Qj3RfYA307TjUgnLQtDDm1CmFgDMtcP/Bz4v25xwd+
 ELxSg0x/JNjxuPz/3FkFgb0uVZxG4Blf58U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37kcfnb6uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Mar 2021 12:40:58 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 12:40:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzKca+ozplm9fasXJ8FtlpRYX8+2+/VlMXmFZeQaPxC2EyZyQuYGmta2ZN0d+ZnBwcAC7erFaD1MQ4NaelPsItvYNwpJOPnbDnN8uW1g7+2tNHnNoNKbzxElpPVOcDtwmHWabjcST5TkhJmEkQOm+Kd5OtjiEXiZcZGpX37qm7jSiyvOoRC6/3eyBk0cr5j4UP6QLTpNQqFSO8ul9SkUjJBiH08V6KB3rzydzlFS8eztV7giD6gwRKgJHALlduqY2F3TO8tYoJzTdfgFexSuYYr/IKt7eCgWy7uHcofA+A9h8YxBh0R94NgBur8OMo9rn+XxLcFcE36ny7ctF9ErrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gtGarr3SqQXewllJzqfjlDtDm/Jsx74OoIf4oQPN3s=;
 b=W0YY++YDB0n/n9hg2VmZecYn8mAOZzgTChQahil2CIiPcYCbIXIbkYupvcroZLudgBTNOknk4Pt86U3EAHwVn/JnQ4pEdhSgDVEeHUbANzogbNcx/lC41+LAL8sj8LTVIpYUmBRNE116DDXi+trQSfjS/ON+k4f1dzmpplv3D9IZDdEupfC4PPm8q+GQA7IR/nrXXjFuQ1HLOJuHnbrdcu97FI6hch4FJK/s6ySOaON+XmJQjACHE2Yr8JbLW1B6AfDnSgl7cL2E6peRSsu2paeN11sZC0y1HuxZuR7mKQAwX09xdKqtsP2HB5t+Uha8Qi3ffToB5KH8F8bKRvGr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2760.namprd15.prod.outlook.com (2603:10b6:a03:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 19:40:56 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 19:40:56 +0000
Date:   Mon, 29 Mar 2021 12:40:51 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 1/4] percpu: implement partial chunk depopulation
Message-ID: <YGItQ6g6ljLAU0dq@carbon.dhcp.thefacebook.com>
References: <20210324190626.564297-1-guro@fb.com>
 <20210324190626.564297-2-guro@fb.com>
 <YGIMdy2t1oLHDC4b@google.com>
 <YGIcgp/shX4HhXOk@carbon.dhcp.thefacebook.com>
 <YGIqcSUua1cfBijy@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGIqcSUua1cfBijy@google.com>
X-Originating-IP: [2620:10d:c090:400::5:85e4]
X-ClientProxiedBy: MW4PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:303:dc::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:85e4) by MW4PR03CA0338.namprd03.prod.outlook.com (2603:10b6:303:dc::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Mon, 29 Mar 2021 19:40:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcd456b1-46e3-46cc-bc06-08d8f2ea9196
X-MS-TrafficTypeDiagnostic: BYAPR15MB2760:
X-Microsoft-Antispam-PRVS: <BYAPR15MB276076C879E46104D367A2D5BE7E9@BYAPR15MB2760.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKfUDNhvWDcisQbhhC5YljiwPGQ6zFgEEFMAy8vYX8V5VXySn/5jb5vrFB+4U95AWupk8BeZclkBzuSus5O+4+aG8D+8yfm47UmxRdJUK2MNK2rs+0e3Ug9aGtcsDQJrXiCxQknMvZBKpJ62P5RDMvomMcw5Nb6y82rlYJctdyCk1bv6b05usl7JjihMgXvOOBVeAXJwl6A2PLcmJm9g6JbYTNNkF6X1O+qZEwh9NQiA9wXZgX7oLHqjccdoVEt8My4YBtJyTBD0l60AXQ8v8+yV2kvoSE1Nf0K8qC9DEAEycFxE+wia9l6GbcFuYXn8XIik/aa5KNKs0P3/5g59v82fhZ0PV3nUUsMUIVUcK08K/L2IM0zgIrVo0WDH3r0qTRZ96mFiwI70zoujaERBaTuMlG/YM0qQOccgT9rQ+JmJLOFwFSfsnIQRMu4uWccm4Nr2lmc9FIWnthbFPH+wZcZK0qT+VRi1/tcXeDrqkv8K0O5xNlB1UcsM+zLefFiYWXGeCEgWiE4CBdlXwAZGmI4PFt14pC1+F0siojg2HPTQKJTY2nPqgG/+OYuh0cb5DBS5g4L6YVOoJHyNwLPnSlgvOAfqTCgTpx6O9bypfQTpUPi+4hZGcL0AE20rhc1EgNO2rmWEtQ0c9ouyv+vGjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(376002)(136003)(316002)(5660300002)(52116002)(6666004)(478600001)(7696005)(2906002)(54906003)(4326008)(86362001)(16526019)(8936002)(66556008)(55016002)(38100700001)(186003)(6916009)(66946007)(6506007)(83380400001)(66476007)(9686003)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0PcO8fJ7R5CfmiM6odrwB3EBYs1hX2uNshJJ0NCkbL1v1/UhjuWmKrHb9v61?=
 =?us-ascii?Q?j8++VT0bf7ZrovfcBsmw2Bg8QeA8v++zztS84okMXtGjQerc5Lug1Lyt9LXC?=
 =?us-ascii?Q?Bw2y8H0I9WYaXbliSyw5nX/AbwUvsJ8ELL95m8d6Vf29kWY4a9YZuISz3CuX?=
 =?us-ascii?Q?rBC5N5q80eTeupPfJrcheobZ3wIGked/A1aa7jHVOJIMfLWjGLEOdh+CtPt4?=
 =?us-ascii?Q?NXblRwORKcrxmNJF1hmtmmVvq9xytc7bo3zQN9g7kMQZF1p8JsByjq4a17/Y?=
 =?us-ascii?Q?iZLZzbD4kXOKLxwZwbrsq3ODa4T6fso9jbAUW8RIEYisfY19TaEKT3dnDE7R?=
 =?us-ascii?Q?zHP4bUr99YYzVXoMMlr1z8jGqgqmP2LQ8lmJSY4zQ/E+jihudm0hD7Z9s9Sk?=
 =?us-ascii?Q?z5r4KbHwn10uNlgfa7BEygH4FA8NlOqXfkCpdyX5h/R8UIEBf9xhiP8JzMkb?=
 =?us-ascii?Q?pHPhC3R4DBVWDOgOsXls9Okk7NBGv1aWOrNBZr+jyVgcjYm/yGSEdvKKe9d6?=
 =?us-ascii?Q?yPbFDZ+OD/reEfAIs1NAGtybbaKNUwYtXMoouyg0c6nIuAXyeZ617fuCRsNs?=
 =?us-ascii?Q?d5NugqX8WKQbAAph0O4plAWUmDaZGYFmUHBrsIlCy2aL/FixFv1BgC6qK4zC?=
 =?us-ascii?Q?34kC+Grzw28Oj/21Sz4kAWSRWikMfOI/EvXNaP7bzgG/ir4JfygfXzQz67m0?=
 =?us-ascii?Q?bGk1Cda7BaPXKY+WKKjx/DGYVXMzUMLnzs9xSMDj6YzmECRw7KGMXAzdfOyv?=
 =?us-ascii?Q?PuG7Bu2YVg0IXaWPo8Dj4qny9KUpRrLJSK1wKxn0imBy3VvJKFo/ujqonhK6?=
 =?us-ascii?Q?AGt54zdTbWV/VC80lWEnFSsnItMxrvcgm418p2hjimUFBG+rSoUtzC6oOk8F?=
 =?us-ascii?Q?XViK6NPATnW4Km/F83LfzchjqvdqhN9qugpHBQK4lzQxGwD8sYv/Nsa7qunh?=
 =?us-ascii?Q?3jn1CcUCEc1c1zUe84PVu7fYp6GlBZj8vMvT/CoAFJ4vNUk/o6rp/CVxspq3?=
 =?us-ascii?Q?cT/j0cNpTNJ2wXN1BLLybDb6BnG4lACgSb3fwZIvjsveauPmZJa1EMV0zjYD?=
 =?us-ascii?Q?3XTlB6vyUtEAD+7ZZ/F2iiDYyQ11Popm/UW/3Pu0NRb1iF2xmUUCbHpfyYXm?=
 =?us-ascii?Q?Gq4rwCPKKVGEYyTKPAj9BtT6XJ+4eSFgETKWIFEWDE/u/HWBkWcWQ6zTZnoS?=
 =?us-ascii?Q?7q7M0bJEY25tLHz6mYor/HypHwq1gkryFb8pQ8fpIDMLh0ZbaIQG9ToeB79G?=
 =?us-ascii?Q?T9N4vCzJZtR7p/vUxg8vEVcw6osRwZCVX4j6V8FFFuQI954iSQtgO18y1t/P?=
 =?us-ascii?Q?0S5SGodWWoiqRUNZu3j8hhm8r7+DIFheAano/vfr5SKuMQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd456b1-46e3-46cc-bc06-08d8f2ea9196
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 19:40:55.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gWgeTsuNutyUuhOrVtQwFxrZ3Acd5ZBZZZX8BApkpGKd9ROSc2liMzQ88tc/Zw9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2760
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 4c1LTpRXbr5Hq-1kFNzoG1mMfz-pw9Kf
X-Proofpoint-ORIG-GUID: 4c1LTpRXbr5Hq-1kFNzoG1mMfz-pw9Kf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_12:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103290144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 07:28:49PM +0000, Dennis Zhou wrote:
> On Mon, Mar 29, 2021 at 11:29:22AM -0700, Roman Gushchin wrote:
> > On Mon, Mar 29, 2021 at 05:20:55PM +0000, Dennis Zhou wrote:
> > > On Wed, Mar 24, 2021 at 12:06:23PM -0700, Roman Gushchin wrote:
> > > > This patch implements partial depopulation of percpu chunks.
> > > > 
> > > > As now, a chunk can be depopulated only as a part of the final
> > > > destruction, when there are no more outstanding allocations. However
> > > > to minimize a memory waste, it might be useful to depopulate a
> > > > partially filed chunk, if a small number of outstanding allocations
> > > > prevents the chunk from being reclaimed.
> > > > 
> > > > This patch implements the following depopulation process: it scans
> > > > over the chunk pages, looks for a range of empty and populated pages
> > > > and performs the depopulation. To avoid races with new allocations,
> > > > the chunk is previously isolated. After the depopulation the chunk is
> > > > returned to the original slot (but is appended to the tail of the list
> > > > to minimize the chances of population).
> > > > 
> > > > Because the pcpu_lock is dropped while calling pcpu_depopulate_chunk(),
> > > > the chunk can be concurrently moved to a different slot. So we need
> > > > to isolate it again on each step. pcpu_alloc_mutex is held, so the
> > > > chunk can't be populated/depopulated asynchronously.
> > > > 
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > ---
> > > >  mm/percpu.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 90 insertions(+)
> > > > 
> > > > diff --git a/mm/percpu.c b/mm/percpu.c
> > > > index 6596a0a4286e..78c55c73fa28 100644
> > > > --- a/mm/percpu.c
> > > > +++ b/mm/percpu.c
> > > > @@ -2055,6 +2055,96 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
> > > >  	mutex_unlock(&pcpu_alloc_mutex);
> > > >  }
> > > >  
> > > > +/**
> > > > + * pcpu_shrink_populated - scan chunks and release unused pages to the system
> > > > + * @type: chunk type
> > > > + *
> > > > + * Scan over all chunks, find those marked with the depopulate flag and
> > > > + * try to release unused pages to the system. On every attempt clear the
> > > > + * chunk's depopulate flag to avoid wasting CPU by scanning the same
> > > > + * chunk again and again.
> > > > + */
> > > > +static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> > > > +{
> > > > +	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> > > > +	struct pcpu_chunk *chunk;
> > > > +	int slot, i, off, start;
> > > > +
> > > > +	spin_lock_irq(&pcpu_lock);
> > > > +	for (slot = pcpu_nr_slots - 1; slot >= 0; slot--) {
> > > > +restart:
> > > > +		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
> > > > +			bool isolated = false;
> > > > +
> > > > +			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH)
> > > > +				break;
> > > > +
> > > 
> > > Deallocation makes me a little worried for the atomic case as now we
> > > could in theory pathologically scan deallocated chunks before finding a
> > > populated one.
> > > 
> > > I wonder if we should do something like once a chunk gets depopulated,
> > > it gets deprioritized and then only once we exhaust looking through
> > > allocated chunks we then find a depopulated chunk and add it back into
> > > the rotation. Possibly just add another set of slots? I guess it adds a
> > > few dimensions to pcpu_slots after the memcg change.
> > 
> > Please, take a look at patch 3 in the series ("percpu: on demand chunk depopulation").
> > Chunks considered to be a good target for the depopulation are in advance
> > marked with a special flag, so we'll actually try to depopulate only
> > few chunks at once. While the total number of chunks is fairly low,
> > I think it should work.
> > 
> > Another option is to link all such chunks into a list and scan over it,
> > instead of iterating over all slots.
> > 
> > Adding new dimensions to pcpu_slots is an option too, but I hope we can avoid
> > this, as it would complicate the code.
> > 
> 
> Yeah, depopulation has been on the todo list for a while. It adds the
> dimension/opportunity of bin packing by sidelining chunks and I'm
> wondering if that is the right thing to do.
> 
> Do you have a rough idea of the distribution of # of chunks you're
> seeing?

The majority of chunks are almost completely empty and reside on a one
of two last slots (before the slot for empty chunks). These are chunks
I'm mostly targeting.

> 
> > > 
> > > > +			for (i = 0, start = -1; i < chunk->nr_pages; i++) {
> > > > +				if (!chunk->nr_empty_pop_pages)
> > > > +					break;
> > > > +
> > > > +				/*
> > > > +				 * If the page is empty and populated, start or
> > > > +				 * extend the [start, i) range.
> > > > +				 */
> > > > +				if (test_bit(i, chunk->populated)) {
> > > > +					off = find_first_bit(
> > > > +						pcpu_index_alloc_map(chunk, i),
> > > > +						PCPU_BITMAP_BLOCK_BITS);
> > > > +					if (off >= PCPU_BITMAP_BLOCK_BITS) {
> > > > +						if (start == -1)
> > > > +							start = i;
> > > > +						continue;
> > > > +					}
> > > 
> > > Here instead of looking at the alloc_map, you can look at the
> > > pcpu_block_md and look for a fully free contig_hint.
> > 
> > Good idea, will try in v2.
> > 
> > > 
> > > > +				}
> > > > +
> > > > +				/*
> > > > +				 * Otherwise check if there is an active range,
> > > > +				 * and if yes, depopulate it.
> > > > +				 */
> > > > +				if (start == -1)
> > > > +					continue;
> > > > +
> > > > +				/*
> > > > +				 * Isolate the chunk, so new allocations
> > > > +				 * wouldn't be served using this chunk.
> > > > +				 * Async releases can still happen.
> > > > +				 */
> > > > +				if (!list_empty(&chunk->list)) {
> > > > +					list_del_init(&chunk->list);
> > > > +					isolated = true;
> > > 
> > > Maybe when freeing a chunk, we should consider just isolating it period
> > > and preventing pcpu_free_area() from being able to add the chunk back
> > > to a pcpu_slot.
> > 
> > You mean to add a check in pcpu_free_area() if the chunks is isolated?
> > Yeah, sounds good to me, will do in v2.
> > 
> 
> Could also be done in pcpu_chunk_relocate() so it's clear an isolated
> chunk shouldn't be moved. But I think pcpu_free_area() should be the
> only way the chunk can be moved on the list.

Yeah, I thought about putting it into pcpu_chunk_relocate(), but it's
used on new chunks, so it would require more changes, so I'm not sure.

> 
> > Thank you!
> > 
> > > 
> > > > +				}
> > > > +
> > > > +				spin_unlock_irq(&pcpu_lock);
> > > > +				pcpu_depopulate_chunk(chunk, start, i);
> > > > +				cond_resched();
> > > > +				spin_lock_irq(&pcpu_lock);
> > > > +
> > > > +				pcpu_chunk_depopulated(chunk, start, i);
> > > > +
> > > > +				/*
> > > > +				 * Reset the range and continue.
> > > > +				 */
> > > > +				start = -1;
> > > > +			}
> > > > +
> > > > +			if (isolated) {
> > > > +				/*
> > > > +				 * The chunk could have been moved while
> > > > +				 * pcpu_lock wasn't held. Make sure we put
> > > > +				 * the chunk back into the slot and restart
> > > > +				 * the scanning.
> > > > +				 */
> > > > +				if (list_empty(&chunk->list))
> > > > +					list_add_tail(&chunk->list,
> > > > +						      &pcpu_slot[slot]);
> > > > +				goto restart;
> > > > +			}
> > > > +		}
> > > > +	}
> > > > +	spin_unlock_irq(&pcpu_lock);
> > > > +}
> > > > +
> > > >  /**
> > > >   * pcpu_balance_workfn - manage the amount of free chunks and populated pages
> > > >   * @work: unused
> > > > -- 
> > > > 2.30.2
> > > > 
