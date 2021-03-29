Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E050A34D8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 22:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhC2UK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 16:10:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33632 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230294AbhC2UK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 16:10:26 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TK5LLs025983;
        Mon, 29 Mar 2021 13:10:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FFFaUPnA3OOS5+HobmZV9PFCZqvDQRO846vOsgPYdIU=;
 b=ktrtcctx9rNXQad8kzNC48cmCz07Z8a9FqnlgVnFOyMTmsH6aaEexPV3eDBtppLuJ/QK
 hzNsgSx9tQCnfn/iP5pLI4fyPBtDLogh1eZeXhHLYCCDKbgfrzQFbXTBEhmgb9fl8xBl
 GYB5NFbxJBv4l03uEfqViS00bRq9jO/L4qU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37kdyt2y1r-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Mar 2021 13:10:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 13:10:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cytYq/+wPyfZ8CGn82/YnSVr9LDpzzlaPbMUdsMGx1hqjkqD9ltfElIq3yWe7rOHxs8QOZm9U0I3rW8d0f8qQl9R8qOvMHjb2sVjjpyXmVb5SREayjTW5KnG95hMFl4FiwTI/6iv6ptxCDJZMnVv8SDZY62464QU7XuapWyNA78IbMSwXuHywGgZVTh30qRiXIrNAa+db6BM5TlsFSdv121KwAGJIehXxYSpfhoyo9LNTyM17Xb2yGWzkhdoy4DcV5CH9vMHB0it4lPtgpw5hF2ilLGdVZxm70kMBX7j230B2xfihJ4Vo2AqqQCJsnGFmkC2k8Zbr40Lb1XT4yt6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFFaUPnA3OOS5+HobmZV9PFCZqvDQRO846vOsgPYdIU=;
 b=PCLWrEomhdJGaMV9S0t4q1Zlt/4SR3x6NLQ4JRW5+2QWkPXzj7ELsowrP/3u4NpohHK8ZyIqvPaadvH2/g0U/cAPZEw14bV1KoWuw/dkzKKnfs3y0OOOpmAFocuB3CZYjO6Q5v4Lev/+jXk9Z2aYY8qRU0VtpHwTqOh8uMwt6HTFEhg7xIlPQpiw9Dxp411kdUELFxi8HzQ1KtkW19o3h5zAbFnjLa3kQigONG3ezq1iPrQXU+E1bjtlq//3ceNEozBcJog1emncuemHo+joUh+tbmrXwXnEfwd23Hjewux8Ix5lAZ2Jr7p81ZP1FZ+PRJFN9nG3z3OjUCmgaA+Blg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4375.namprd15.prod.outlook.com (2603:10b6:a03:370::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Mon, 29 Mar
 2021 20:10:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 20:10:14 +0000
Date:   Mon, 29 Mar 2021 13:10:10 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 3/4] percpu: on demand chunk depopulation
Message-ID: <YGI0IsSjGpqomJxh@carbon.dhcp.thefacebook.com>
References: <20210324190626.564297-1-guro@fb.com>
 <20210324190626.564297-4-guro@fb.com>
 <YGIotHUFTrPauwrP@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGIotHUFTrPauwrP@google.com>
X-Originating-IP: [2620:10d:c090:400::5:d1e2]
X-ClientProxiedBy: MW4PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:303:b8::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:d1e2) by MW4PR03CA0200.namprd03.prod.outlook.com (2603:10b6:303:b8::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 20:10:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35c3820c-8af6-4047-2067-08d8f2eeaa28
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4375:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB43752308AFB297D985B6EDC2BE7E9@SJ0PR15MB4375.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++LdUkGNs5LkgDETzIlUHFWw96v48D7tqSznTFrFPshAkv4I8GoIHZOB9OS3HGwqk1FXeqXiCnLWQeMh8Hz/dtsgSQplHaQS1Xnxf35tc6WV8XDUnEyFWWR6Gsl12gYyWfpPWR+XUN1yiDB5VTSLuPo/cISs/3k+iuM42jh6DGQlUnleP3rQEr3ol0TTwkoZ7Hd1Qt5kaVuH+bBUh4779ypQxlMZ4LBGI/lwP3xewtPlmIA7aka239c4cgIAHQsf0Tl1jwHy8GdKB579L5l66zAt1avAFUEG/cIHFOaQWl7nE9cLRoxUrq6IHbMtnyQdmHgvV1IAJm2z+Cd8N4RbY1DsKnhj8kYzJ5ihChJjtoJNG73kGbSsD9lAjpzCoePf1p+FZdZoxybx8OcF8+KwIUOX6WGjGGjsSitUc2oa5LVazSuwvFbuxWADcz0skZ229WNzd65RVpsYLHkFx7u5WMJrtPiN6cYi52L1cHC6tjefGvfK0uy150VT+t3G4FwdkJG+JkEfuwd/RiZ4KhVIw9R2LW79vkT49z74neUXgPcMM8R1/fCq55lw+8BubC1CMYXdR7UIpiNN25f9vUqufQaqq7NOrSukOBeFn0OwN6qk15Zu+josxOPaIkhtgfm56y2joL6FRGfmOf9JhqzWz0ymR6xruqjFfTqpzaL5/W8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(346002)(39860400002)(5660300002)(2906002)(55016002)(9686003)(478600001)(316002)(52116002)(30864003)(7696005)(6916009)(6506007)(8936002)(4326008)(186003)(86362001)(16526019)(66556008)(66946007)(83380400001)(66476007)(54906003)(8676002)(38100700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IOQ9or56PC2RR5DmtP5GDdwCAQ4/AZ00sWucGb8nxgKJFdtZPydwnfMqIo6g?=
 =?us-ascii?Q?siHWCJpv5K/zqkOZwc277s80cCqx600ZmgEOvM7My3eI5+3ABUzkA0B92uJ0?=
 =?us-ascii?Q?/ajC4beQkDh2FpjpTEfUi+bUGLgshzUHmRgZafvcAGL8bPa6UAzGMJ7qIVVU?=
 =?us-ascii?Q?B1M7Mo0rTxE91pkLf+5gbENrfO9eGautmh56YwvLF3i9YtZW4dLam54vZ3KP?=
 =?us-ascii?Q?J36sShI/NdTzyYslCmm/4Mq56NNAJxazz33gfS4I0OzWBAa8xf+FeMaajfo0?=
 =?us-ascii?Q?DboPtRFivO9MeyUEV8ARXpHrBP4i1T+/EBE1rDl4SNTPsonZrEMdqbrjf1cA?=
 =?us-ascii?Q?AWY4OcHClfTXFRx3uveAmGVinrerWy5nxDaAuX3GpM7XJx6LizCvYrTtlTRh?=
 =?us-ascii?Q?eJLpev/LD5FarSfH0KW9vP22bWw7+1WhmnrbOaJpbbpF7BK6I/nFqFUS8RDA?=
 =?us-ascii?Q?Hgyl80Ui1tYQ9BNc1ivyMD5Kx2WgsEKCtX0SsKEkL8KqLiVAdV108vCKfDpp?=
 =?us-ascii?Q?0mxL/UwcCLV6SL6EbglB4/KSzKxlh16A3bXCDRd84LyXajH/tu1EL5fdpVEx?=
 =?us-ascii?Q?8qU95tQ004jYNpRPWkArkOWwfhPa+EoSSlE5zK79IPej1aY2CAmtPO7R5kn4?=
 =?us-ascii?Q?qu/SJnYQ7t4GxzxZfxuLk7YgZnN1qhBhUxWQ2PqnUFvNaNUZqHP0OIrbIMS2?=
 =?us-ascii?Q?Fdkn1IxK3F+wIHSZcsIJgAp3LKdfHBNDei7+iZB0DtLG7NQw8ds79VRZxDCY?=
 =?us-ascii?Q?/yWGRZhrrhcdX6i3OAaw8abhx7/R8J/Am/J3/RQ1EAglyt4IGwzDJHaRc52V?=
 =?us-ascii?Q?sMbHCHqojO0jHpzwXrOXjflN3Qb2ZQqv8v//frM3L4CGFkMBpO3JCbcDlzhE?=
 =?us-ascii?Q?O4Kzn8bZaTWRXFzxLGJWRaHX9dTttz0cevvLv6g7GruAeeEswAQEYYoJmWDy?=
 =?us-ascii?Q?4hP0Bo1nXstnfN0dt5T6nmQmEQWA8QyHY5bDElU3hDYSnveu1NYP94APplP/?=
 =?us-ascii?Q?vLoKacO/suP30HpEd3FFBvevmCQy14PrFOHjVutRsePp7d4/LHwUFtwJ1i0k?=
 =?us-ascii?Q?QIN0nv4f79Zq7ZGbJ5C53DYPFOd+U/6Vo4KyRhCmG4BbOIs2Vpw+UFhaSJgV?=
 =?us-ascii?Q?KK1YlC1Z4VyL1Hh0+OReR+a/U4sfjg/Dg7Zvcd74KR2dB1WBQr0Uig+ezst5?=
 =?us-ascii?Q?IFnQOOw5QIwErfMx/87yspXQ2RGvGRJnHaM811aJpRHbVySmbgNxcz4gziZh?=
 =?us-ascii?Q?GqURGh1eDPpWpdrRgftuJwoSmav8koff44SV0fuKyFzYnLgqx9lFN4bbaTzm?=
 =?us-ascii?Q?i710qws0D9s/qGhQGD+IH48LKuyEXlTMANugF/tI8lydSQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c3820c-8af6-4047-2067-08d8f2eeaa28
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 20:10:14.5302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfLkP2gvAkIthmbYF6lAnY6SA+a9X4NVnLWEDkzpWQxcKNIP42fE64Vt0AothojH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4375
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: s8r2372IaqUH0oPfd9VyALwdI2ci77Ki
X-Proofpoint-ORIG-GUID: s8r2372IaqUH0oPfd9VyALwdI2ci77Ki
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_12:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103250000 definitions=main-2103290148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 07:21:24PM +0000, Dennis Zhou wrote:
> On Wed, Mar 24, 2021 at 12:06:25PM -0700, Roman Gushchin wrote:
> > To return unused memory to the system schedule an async
> > depopulation of percpu chunks.
> > 
> > To balance between scanning too much and creating an overhead because
> > of the pcpu_lock contention and scanning not enough, let's track an
> > amount of chunks to scan and mark chunks which are potentially a good
> > target for the depopulation with a new boolean flag.  The async
> > depopulation work will clear the flag after trying to depopulate a
> > chunk (successfully or not).
> > 
> > This commit suggest the following logic: if a chunk
> >   1) has more than 1/4 of total pages free and populated
> >   2) isn't a reserved chunk
> >   3) isn't entirely free
> >   4) isn't alone in the corresponding slot
> 
> I'm not sure I like the check for alone that much. The reason being what
> about some odd case where each slot has a single chunk, but every slot
> is populated. It doesn't really make sense to keep them all around.

Yeah, I agree, I'm not sure either. Maybe we can just look at the total
number of populated empty pages and make sure it's not too low and not
too high. Btw, we should probably double PCPU_EMPTY_POP_PAGES_LOW/HIGH
if memcg accounting is on.

> 
> I think there is some decision making we can do here to handle packing
> post depopulation allocations into a handful of chunks. Depopulated
> chunks could be sidelined with say a flag ->depopulated to prevent the
> first attempt of allocations from using them. And then we could bring
> back a chunk 1 by 1 somehow to attempt to suffice the allocation.
> I'm not too sure if this is a good idea, just a thought.

I thought about it in this way: depopulated chunks are not different to
new chunks, which are not yet fully populated. And they are naturally
de-prioritized by being located in higher slots (and at the tail of the list).
So I'm not sure we should handle them any special.

> 
> > it's a good target for depopulation.
> > 
> > If there are 2 or more of such chunks, an async depopulation
> > is scheduled.
> > 
> > Because chunk population and depopulation are opposite processes
> > which make a little sense together, split out the shrinking part of
> > pcpu_balance_populated() into pcpu_grow_populated() and make
> > pcpu_balance_populated() calling into pcpu_grow_populated() or
> > pcpu_shrink_populated() conditionally.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  mm/percpu-internal.h |   1 +
> >  mm/percpu.c          | 111 ++++++++++++++++++++++++++++++++-----------
> >  2 files changed, 85 insertions(+), 27 deletions(-)
> > 
> > diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> > index 18b768ac7dca..1c5b92af02eb 100644
> > --- a/mm/percpu-internal.h
> > +++ b/mm/percpu-internal.h
> > @@ -67,6 +67,7 @@ struct pcpu_chunk {
> >  
> >  	void			*data;		/* chunk data */
> >  	bool			immutable;	/* no [de]population allowed */
> > +	bool			depopulate;	/* depopulation hint */
> >  	int			start_offset;	/* the overlap with the previous
> >  						   region to have a page aligned
> >  						   base_addr */
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 015d076893f5..148137f0fc0b 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -178,6 +178,12 @@ static LIST_HEAD(pcpu_map_extend_chunks);
> >   */
> >  int pcpu_nr_empty_pop_pages;
> >  
> > +/*
> > + * Track the number of chunks with a lot of free memory.
> > + * It's used to release unused pages to the system.
> > + */
> > +static int pcpu_nr_chunks_to_depopulate;
> > +
> >  /*
> >   * The number of populated pages in use by the allocator, protected by
> >   * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a page gets
> > @@ -1955,6 +1961,11 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
> >  		if (chunk == list_first_entry(free_head, struct pcpu_chunk, list))
> >  			continue;
> >  
> > +		if (chunk->depopulate) {
> > +			chunk->depopulate = false;
> > +			pcpu_nr_chunks_to_depopulate--;
> > +		}
> > +
> >  		list_move(&chunk->list, &to_free);
> >  	}
> >  
> > @@ -1976,7 +1987,7 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
> >  }
> >  
> >  /**
> > - * pcpu_balance_populated - manage the amount of populated pages
> > + * pcpu_grow_populated - populate chunk(s) to satisfy atomic allocations
> >   * @type: chunk type
> >   *
> >   * Maintain a certain amount of populated pages to satisfy atomic allocations.
> > @@ -1985,35 +1996,15 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
> >   * allocation causes the failure as it is possible that requests can be
> >   * serviced from already backed regions.
> >   */
> > -static void pcpu_balance_populated(enum pcpu_chunk_type type)
> > +static void pcpu_grow_populated(enum pcpu_chunk_type type, int nr_to_pop)
> >  {
> >  	/* gfp flags passed to underlying allocators */
> >  	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> >  	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> >  	struct pcpu_chunk *chunk;
> > -	int slot, nr_to_pop, ret;
> > +	int slot, ret;
> >  
> > -	/*
> > -	 * Ensure there are certain number of free populated pages for
> > -	 * atomic allocs.  Fill up from the most packed so that atomic
> > -	 * allocs don't increase fragmentation.  If atomic allocation
> > -	 * failed previously, always populate the maximum amount.  This
> > -	 * should prevent atomic allocs larger than PAGE_SIZE from keeping
> > -	 * failing indefinitely; however, large atomic allocs are not
> > -	 * something we support properly and can be highly unreliable and
> > -	 * inefficient.
> > -	 */
> >  retry_pop:
> > -	if (pcpu_atomic_alloc_failed) {
> > -		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH;
> > -		/* best effort anyway, don't worry about synchronization */
> > -		pcpu_atomic_alloc_failed = false;
> > -	} else {
> > -		nr_to_pop = clamp(PCPU_EMPTY_POP_PAGES_HIGH -
> > -				  pcpu_nr_empty_pop_pages,
> > -				  0, PCPU_EMPTY_POP_PAGES_HIGH);
> > -	}
> > -
> >  	for (slot = pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot++) {
> >  		unsigned int nr_unpop = 0, rs, re;
> >  
> > @@ -2084,9 +2075,18 @@ static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> 
> I missed this in the review of patch 1, but pcpu_shrink only needs to
> iterate over:
> for (slot = pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot++) {

You mean skip first few slots?
Yeah, it's probably safe. I was afraid that a marked chunk can be moved to
one of such slots, so we'll never find it and will repeat scanning, but it seems
like it's not a possible scenario. Will adjust, thanks.

> 
> >  		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
> >  			bool isolated = false;
> >  
> > -			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH)
> > +			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH ||
> > +			    pcpu_nr_chunks_to_depopulate < 1)
> >  				break;
> >  
> > +			/*
> > +			 * Don't try to depopulate a chunk again and again.
> > +			 */
> > +			if (!chunk->depopulate)
> > +				continue;
> > +			chunk->depopulate = false;
> > +			pcpu_nr_chunks_to_depopulate--;
> > +
> >  			for (i = 0, start = -1; i < chunk->nr_pages; i++) {
> >  				if (!chunk->nr_empty_pop_pages)
> >  					break;
> > @@ -2153,6 +2153,41 @@ static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> >  	spin_unlock_irq(&pcpu_lock);
> >  }
> >  
> > +/**
> > + * pcpu_balance_populated - manage the amount of populated pages
> > + * @type: chunk type
> > + *
> > + * Populate or depopulate chunks to maintain a certain amount
> > + * of free pages to satisfy atomic allocations, but not waste
> > + * large amounts of memory.
> > + */
> > +static void pcpu_balance_populated(enum pcpu_chunk_type type)
> > +{
> > +	int nr_to_pop;
> > +
> > +	/*
> > +	 * Ensure there are certain number of free populated pages for
> > +	 * atomic allocs.  Fill up from the most packed so that atomic
> > +	 * allocs don't increase fragmentation.  If atomic allocation
> > +	 * failed previously, always populate the maximum amount.  This
> > +	 * should prevent atomic allocs larger than PAGE_SIZE from keeping
> > +	 * failing indefinitely; however, large atomic allocs are not
> > +	 * something we support properly and can be highly unreliable and
> > +	 * inefficient.
> > +	 */
> > +	if (pcpu_atomic_alloc_failed) {
> > +		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH;
> > +		/* best effort anyway, don't worry about synchronization */
> > +		pcpu_atomic_alloc_failed = false;
> > +		pcpu_grow_populated(type, nr_to_pop);
> > +	} else if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
> > +		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH - pcpu_nr_empty_pop_pages;
> > +		pcpu_grow_populated(type, nr_to_pop);
> > +	} else if (pcpu_nr_chunks_to_depopulate > 0) {
> > +		pcpu_shrink_populated(type);
> > +	}
> > +}
> > +
> >  /**
> >   * pcpu_balance_workfn - manage the amount of free chunks and populated pages
> >   * @work: unused
> > @@ -2188,6 +2223,7 @@ void free_percpu(void __percpu *ptr)
> >  	int size, off;
> >  	bool need_balance = false;
> >  	struct list_head *pcpu_slot;
> > +	struct pcpu_chunk *pos;
> >  
> >  	if (!ptr)
> >  		return;
> > @@ -2207,15 +2243,36 @@ void free_percpu(void __percpu *ptr)
> >  
> >  	pcpu_memcg_free_hook(chunk, off, size);
> >  
> > -	/* if there are more than one fully free chunks, wake up grim reaper */
> >  	if (chunk->free_bytes == pcpu_unit_size) {
> > -		struct pcpu_chunk *pos;
> > -
> > +		/*
> > +		 * If there are more than one fully free chunks,
> > +		 * wake up grim reaper.
> > +		 */
> >  		list_for_each_entry(pos, &pcpu_slot[pcpu_nr_slots - 1], list)
> >  			if (pos != chunk) {
> >  				need_balance = true;
> >  				break;
> >  			}
> > +
> > +	} else if (chunk->nr_empty_pop_pages > chunk->nr_pages / 4) {
> 
> We should have this ignore the first and reserved chunks. While it
> shouldn't be possible in theory, it would be nice to just make it
> explicit here.

Ok, will do, makes sense to me!

> 
> > +		/*
> > +		 * If there is more than one chunk in the slot and
> > +		 * at least 1/4 of its pages are empty, mark the chunk
> > +		 * as a target for the depopulation. If there is more
> > +		 * than one chunk like this, schedule an async balancing.
> > +		 */
> > +		int nslot = pcpu_chunk_slot(chunk);
> > +
> > +		list_for_each_entry(pos, &pcpu_slot[nslot], list)
> > +			if (pos != chunk && !chunk->depopulate &&
> > +			    !chunk->immutable) {
> > +				chunk->depopulate = true;
> > +				pcpu_nr_chunks_to_depopulate++;
> > +				break;
> > +			}
> > +
> > +		if (pcpu_nr_chunks_to_depopulate > 1)
> > +			need_balance = true;
> >  	}
> >  
> >  	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
> > -- 
> > 2.30.2
> > 
> 
> Some questions I have:
> 1. How do we prevent unnecessary scanning for atomic allocations?

Depopulated chunks tend to be at tail of the chunks lists in high(er) slots,
so they seem to be the last target for an atomic allocation, if there is
enough space in other chunks.

> 2. Even in the normal case, should we try to pack future allocations
> into a smaller # of chunks in after depopulation?

Well, there is one specific problem I'm trying to solve: if the percpu memory
is heavily inflated by something (e.g. by creating a ton of cgroups or bpf maps),
sometimes it's impossible to get the memory back at all, even if the absolute
majority of percpu objects was released. In this case there are many chunks
which are almost entirely empty, and the actual size of the needed percpu memory
is way less that the number of populated pages.

We can look at the percpu memory fragmentation as a more fundamental problem,
and probably the right thing to do long-term is to introduce some sort of a
slab allocator. At least, we can put small allocations (aka percpu reference
counters) into separate chunks. But this is obviously a way bigger change,
which unlikely can do into any stable branches, so I'd treat it separately.
Also, I'm not convinced that we really need it so much at the moment.
If the percpu usage is more or less stable, I don't see any pathological
fragmentation problem.

> 3. What is the right frequency to do depopulation scanning? I think of
> the pcpu work item as a way to defer the 2 the freeing of chunks and in
> a way more immediately replenish free pages. Depopulation isn't
> necessarily as high a priority.

I think that the number of chunks which are potentially good for the
depopulation is a good metric. I've chosen 2 as a threshold, but I'm
fine with other ideas as well.

Thank you!
