Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B32434DD4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhC3BFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:05:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8936 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230229AbhC3BE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:04:56 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12U0xBsv012128;
        Mon, 29 Mar 2021 18:04:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=V9A3sEhM6e6R5L9tDyUQzphc8VsdhpgYTD89zvkZHzI=;
 b=FT76BW1q6Y/IZA6J/x1sk6NVnxRlnshTZ4B4ylcVaMcJm5yX/jgihgwUjPeQHvHFXdgK
 WMGDirzyrmCZgNfvqQpaMGPNNJWq8JV1b1jVkSNal/HrOSS93duqPgnzHO4afCJ0jHPH
 FdYA6peAPOtUbCJyzWH2Yed/DjBS1YtHEBA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37kdyt4f4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Mar 2021 18:04:52 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 18:04:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVjo/1ARNGDKEphr69LMhLjCWrDqccbFFYgNetVf5igtPiyyeycbfwtdWBwdvxSE7doIu/NMPbWgl8WRgVJeV2tKRMVNNnzDUAdMwmXhDQE+PiK+xCRVipS7MImLAh+19FmXt+4KANri9k5YS75WfRdr8HNCPjljABL17tEMS4GHz+ujVOz5suuCt1DmmoWFxpfcIAJkXncV2ZNQBOwBG37UBWibu5N33mARTJ6Dw/VTEu4S1UdcoG4WXQyMa8VQ29MLzbPE/4nOMFpTf63M71kSa8AecKv6EK00AlK89gChjkU+bNqyeTfXltW2JFrj7wfwjUtJFuwd9G0kPV4Eyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9A3sEhM6e6R5L9tDyUQzphc8VsdhpgYTD89zvkZHzI=;
 b=bPgcEIqYGu78v7ge4sAbm6GfXPi9z3f8Qq/U7b3w5i3gniBANpsYzKQkUCTYzY1TUeQAp3Za2+xdOwtKGih+KtQOTQyoPhZRG0ykf3YXG2axN1Vj2UQ+YI77SAEzgkqWjKrmbF/AVetY7IuI4cWsfdqwdXRe90CfvFjdLKDY5XCLll3iwRIqPzd35X3dlroz0titVnY/nvlYyp9HAUuOwjJxRHFqdBCUu6mAlwSWU9Sk4nHJLZ8d4MpRdPqVxPCeSZElQB7azOxB4tun7083lCEN4S8Qdp897A76IWmtecnl7HmNyA5HYrcsfy4bwy3x4a1PP3VD0XOdHbIYlkDr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB4308.namprd15.prod.outlook.com (2603:10b6:a03:1b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 01:04:49 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 01:04:49 +0000
Date:   Mon, 29 Mar 2021 18:04:44 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 3/4] percpu: on demand chunk depopulation
Message-ID: <YGJ5LGvQf4ztpzUI@carbon.dhcp.thefacebook.com>
References: <20210324190626.564297-1-guro@fb.com>
 <20210324190626.564297-4-guro@fb.com>
 <YGIotHUFTrPauwrP@google.com>
 <YGI0IsSjGpqomJxh@carbon.dhcp.thefacebook.com>
 <YGJe4hTfWCoQRFFc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGJe4hTfWCoQRFFc@google.com>
X-Originating-IP: [2620:10d:c090:400::5:8010]
X-ClientProxiedBy: MW4PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:303:85::10) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8010) by MW4PR04CA0155.namprd04.prod.outlook.com (2603:10b6:303:85::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 01:04:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7139d0ec-c6d9-4dc0-e775-08d8f317d124
X-MS-TrafficTypeDiagnostic: BY5PR15MB4308:
X-Microsoft-Antispam-PRVS: <BY5PR15MB4308B1890383E3D2051BD8F2BE7D9@BY5PR15MB4308.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXNJde9dHmSQgOGJ97NuORCeW3isX6pmyvLBN68X+q+gTLeHx/RnduxMLSlaQg/dcJb1V5IZJAeo9i3UMR7RXtAn2U8v9XOmgy3L3xDxgF7Drz8kjzyNSR5FxyzgpvXyzTmtBvQpKw7A0+ZCkTCZJkcqYStH6jjI3qnadZEUe8ok2SEb85rh1mYpIXO4nYJoqVJMLNKdPJqfk69SXaOlmkke8/X58lhAUFxO2A4EFHPCW+/KtdqJviBbzk1X/QNlpwHVk7aqLbRdZIngKhBTn9onIsYY+EewM/Kh1zsMr+wqz6++9EXUVb4JiNgBBZlCyL26RaGNFraGjIXe9uafcs60/nPQpv0ucVdCaE5fnWbssY3wWYT4SvRC0yszsG2DVdUC8J+Ib549pFO0XCRQhHI+7IRbjJT7kbFK0qX9bycNwZR67znaPGNGt11kb4sSj2aoC1oleNgUX8ICUc5r7YiJ2LU/L4owm9LJ3msdefBZyeKQLbN8p+yn2+fyXPogbzR9zrtGWhLli/APoD2v9iIkTAO3aZFz+D3ewEV3zZUtKRlBjQyY/6LDXkKM/f7tpeHbgG5EW7kBbspWqfuZP3lHcjkI7cgf+5EfTvXICnZAdANAG42U9ItEusiNe8d0mQk8pbel8iGLUQ9mFyET7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(346002)(396003)(366004)(2906002)(66946007)(16526019)(186003)(4326008)(66556008)(9686003)(66476007)(30864003)(54906003)(52116002)(6506007)(316002)(7696005)(38100700001)(83380400001)(478600001)(6666004)(8676002)(5660300002)(55016002)(8936002)(86362001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7qijWNLOXwXpbHx0Bq5cxVxnZ8LfBtTkYrlr+VtxgZdQ/WoMBXAJtZGWX3Xf?=
 =?us-ascii?Q?jN3vPTrxfHf1T12yX10FCOXsLZo2zYnoZUh8SmwQl6EXgbCliNr3Q3wykk6V?=
 =?us-ascii?Q?MmKsY7T3E8GjIfYwTuN7sWefsPXDttKoCR+trAqd6BADdONubTRfakc7w7H2?=
 =?us-ascii?Q?WV0pszR+ExNcv6RMc8JS1x1qtnUPm4NvrFg0mWpfmBCuNuUEXVbzugbeLT1l?=
 =?us-ascii?Q?+oEWXW9XgPa8he2nO5NRV/L4zWkNptowpdhXD9c4++Quh/2MRU4BjODm5ZcJ?=
 =?us-ascii?Q?pVZdzuZK9hXQ08YEtu/DpYuzld4j4vmn8xfBSoVi34u6ZLf7R/MBAz7Nm6Vf?=
 =?us-ascii?Q?hSoYAumFw6BDRyF8No91xJ2ah9SsBhokwrtm2W9NbJHbkzIDOZlYo2ZKKLIE?=
 =?us-ascii?Q?WFFLOjmblnA9n9OIYonHKuWvVCXh7P/9N+hVxci7gSk0jmEQH52PrO4Rwyao?=
 =?us-ascii?Q?CIBZuhBXBBkwtpKc3eSP0eBKt2klmGfDATPdJukmwO1eXl+5iOT0kQS+XZmI?=
 =?us-ascii?Q?tLVJiTliaQCRIVUz7+L375+1LTUKogxgZR1ommFmKgHRxLGr2H9j1S7IUh6h?=
 =?us-ascii?Q?SJBLCvX09Nws07tYUKpDbNcsi62Nwhedkw9zDv24G5asFSo68kTmGTRZ2nsx?=
 =?us-ascii?Q?df1RWsqTC9/mtp+wuFQyY3MIQQQ2tQjUTTTbFVkx9eF7IS5ApXctHH5liQy/?=
 =?us-ascii?Q?zBkEMyez50eTaqWvjil/+oc7Z6B402CyPwOXIxch8bwNyC4N14KQzNEqQ76j?=
 =?us-ascii?Q?wprkFpo4hFoCRWd3a+4NMPPsfG7oOJgQhg4iHI+Et1iMJjxT/YoAFqntiYva?=
 =?us-ascii?Q?IJH9JLdK7PvfBA4OLAbqNZjV829UN+ocgbrxgZpbR3eofiGwqfTuxFHf8HCm?=
 =?us-ascii?Q?AdJEH9ZYt5NhYUCJDC9FFYkUdnAJnx1oKdUVmErlV2Ptodzjx1pB8J0mzOx8?=
 =?us-ascii?Q?nOPBX71wFFvvgXXqz+MyfJ0RvBGqMIDeodNmKealpOmZYLWRZ9NYWWX5Yq3R?=
 =?us-ascii?Q?AddcdgXwy9flSzpH05RsbjKpy7usj5/DBnS2Fm41dFLALXVz28LY2FPiIB41?=
 =?us-ascii?Q?AhzdCETm1suyryUuqEWjurrJ74BU+Xu4QnN4VSa1iPAIWvJvTHvSKyswvNx7?=
 =?us-ascii?Q?fpsnh4c1Ra8vBbEt3zW/+oaLapNx/QAK6tjHhxgEvTG2l0amN8p9PfLR8r6Z?=
 =?us-ascii?Q?37Clq9SlLarL7/V7FVSOc7aom7y8KhtlgkojFUQbFgfLWoeXYJuJtvIRbwSa?=
 =?us-ascii?Q?dQLSK4GPvRFVcaTBlX52tUVjGopxqS6+PH7/oYYI3pgy7QSzuo06kLTUGPMF?=
 =?us-ascii?Q?TuPFMBQKLPAnKoUEDVeTCbU5zt4vxbDY6F0MnHryw1xKVA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7139d0ec-c6d9-4dc0-e775-08d8f317d124
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 01:04:49.4418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJe4Wna8t7luM4P7rRxwuf2Z17HhzM26t6tEc55529vbmx7CYyWSRLtapViahm4r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4308
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: xbM55IodZFYxyMiJHBuOKDdl2lKSK46X
X-Proofpoint-ORIG-GUID: xbM55IodZFYxyMiJHBuOKDdl2lKSK46X
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_16:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103250000 definitions=main-2103300004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:12:34PM +0000, Dennis Zhou wrote:
> On Mon, Mar 29, 2021 at 01:10:10PM -0700, Roman Gushchin wrote:
> > On Mon, Mar 29, 2021 at 07:21:24PM +0000, Dennis Zhou wrote:
> > > On Wed, Mar 24, 2021 at 12:06:25PM -0700, Roman Gushchin wrote:
> > > > To return unused memory to the system schedule an async
> > > > depopulation of percpu chunks.
> > > > 
> > > > To balance between scanning too much and creating an overhead because
> > > > of the pcpu_lock contention and scanning not enough, let's track an
> > > > amount of chunks to scan and mark chunks which are potentially a good
> > > > target for the depopulation with a new boolean flag.  The async
> > > > depopulation work will clear the flag after trying to depopulate a
> > > > chunk (successfully or not).
> > > > 
> > > > This commit suggest the following logic: if a chunk
> > > >   1) has more than 1/4 of total pages free and populated
> > > >   2) isn't a reserved chunk
> > > >   3) isn't entirely free
> > > >   4) isn't alone in the corresponding slot
> > > 
> > > I'm not sure I like the check for alone that much. The reason being what
> > > about some odd case where each slot has a single chunk, but every slot
> > > is populated. It doesn't really make sense to keep them all around.
> > 
> > Yeah, I agree, I'm not sure either. Maybe we can just look at the total
> > number of populated empty pages and make sure it's not too low and not
> > too high. Btw, we should probably double PCPU_EMPTY_POP_PAGES_LOW/HIGH
> > if memcg accounting is on.
> > 
> 
> Hmmm. pcpu_nr_populated and pcpu_nr_empty_pop_pages should probably be
> per chunk type now that you mention it.
> 
> > > 
> > > I think there is some decision making we can do here to handle packing
> > > post depopulation allocations into a handful of chunks. Depopulated
> > > chunks could be sidelined with say a flag ->depopulated to prevent the
> > > first attempt of allocations from using them. And then we could bring
> > > back a chunk 1 by 1 somehow to attempt to suffice the allocation.
> > > I'm not too sure if this is a good idea, just a thought.
> > 
> > I thought about it in this way: depopulated chunks are not different to
> > new chunks, which are not yet fully populated. And they are naturally
> > de-prioritized by being located in higher slots (and at the tail of the list).
> > So I'm not sure we should handle them any special.
> > 
> 
> I'm thinking of the following. Imagine 3 chunks, A and B in slot X, and
> C in slot X+1. If B gets depopulated followed by A getting exhausted,
> which chunk B or C should be used? If C is fully populated, we might
> want to use that one.
> 
> I see that the priority is chunks at the very end, but I don't want to
> take something that doesn't reasonable generalize to any slot PAGE_SIZE
> and up. Or it should explicitly try to tackle only say the last N slots
> (but preferably the former).
> 
> > > 
> > > > it's a good target for depopulation.
> > > > 
> > > > If there are 2 or more of such chunks, an async depopulation
> > > > is scheduled.
> > > > 
> > > > Because chunk population and depopulation are opposite processes
> > > > which make a little sense together, split out the shrinking part of
> > > > pcpu_balance_populated() into pcpu_grow_populated() and make
> > > > pcpu_balance_populated() calling into pcpu_grow_populated() or
> > > > pcpu_shrink_populated() conditionally.
> > > > 
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > ---
> > > >  mm/percpu-internal.h |   1 +
> > > >  mm/percpu.c          | 111 ++++++++++++++++++++++++++++++++-----------
> > > >  2 files changed, 85 insertions(+), 27 deletions(-)
> > > > 
> > > > diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> > > > index 18b768ac7dca..1c5b92af02eb 100644
> > > > --- a/mm/percpu-internal.h
> > > > +++ b/mm/percpu-internal.h
> > > > @@ -67,6 +67,7 @@ struct pcpu_chunk {
> > > >  
> > > >  	void			*data;		/* chunk data */
> > > >  	bool			immutable;	/* no [de]population allowed */
> > > > +	bool			depopulate;	/* depopulation hint */
> > > >  	int			start_offset;	/* the overlap with the previous
> > > >  						   region to have a page aligned
> > > >  						   base_addr */
> > > > diff --git a/mm/percpu.c b/mm/percpu.c
> > > > index 015d076893f5..148137f0fc0b 100644
> > > > --- a/mm/percpu.c
> > > > +++ b/mm/percpu.c
> > > > @@ -178,6 +178,12 @@ static LIST_HEAD(pcpu_map_extend_chunks);
> > > >   */
> > > >  int pcpu_nr_empty_pop_pages;
> > > >  
> > > > +/*
> > > > + * Track the number of chunks with a lot of free memory.
> > > > + * It's used to release unused pages to the system.
> > > > + */
> > > > +static int pcpu_nr_chunks_to_depopulate;
> > > > +
> > > >  /*
> > > >   * The number of populated pages in use by the allocator, protected by
> > > >   * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a page gets
> > > > @@ -1955,6 +1961,11 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
> > > >  		if (chunk == list_first_entry(free_head, struct pcpu_chunk, list))
> > > >  			continue;
> > > >  
> > > > +		if (chunk->depopulate) {
> > > > +			chunk->depopulate = false;
> > > > +			pcpu_nr_chunks_to_depopulate--;
> > > > +		}
> > > > +
> > > >  		list_move(&chunk->list, &to_free);
> > > >  	}
> > > >  
> > > > @@ -1976,7 +1987,7 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
> > > >  }
> > > >  
> > > >  /**
> > > > - * pcpu_balance_populated - manage the amount of populated pages
> > > > + * pcpu_grow_populated - populate chunk(s) to satisfy atomic allocations
> > > >   * @type: chunk type
> > > >   *
> > > >   * Maintain a certain amount of populated pages to satisfy atomic allocations.
> > > > @@ -1985,35 +1996,15 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
> > > >   * allocation causes the failure as it is possible that requests can be
> > > >   * serviced from already backed regions.
> > > >   */
> > > > -static void pcpu_balance_populated(enum pcpu_chunk_type type)
> > > > +static void pcpu_grow_populated(enum pcpu_chunk_type type, int nr_to_pop)
> > > >  {
> > > >  	/* gfp flags passed to underlying allocators */
> > > >  	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> > > >  	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> > > >  	struct pcpu_chunk *chunk;
> > > > -	int slot, nr_to_pop, ret;
> > > > +	int slot, ret;
> > > >  
> > > > -	/*
> > > > -	 * Ensure there are certain number of free populated pages for
> > > > -	 * atomic allocs.  Fill up from the most packed so that atomic
> > > > -	 * allocs don't increase fragmentation.  If atomic allocation
> > > > -	 * failed previously, always populate the maximum amount.  This
> > > > -	 * should prevent atomic allocs larger than PAGE_SIZE from keeping
> > > > -	 * failing indefinitely; however, large atomic allocs are not
> > > > -	 * something we support properly and can be highly unreliable and
> > > > -	 * inefficient.
> > > > -	 */
> > > >  retry_pop:
> > > > -	if (pcpu_atomic_alloc_failed) {
> > > > -		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH;
> > > > -		/* best effort anyway, don't worry about synchronization */
> > > > -		pcpu_atomic_alloc_failed = false;
> > > > -	} else {
> > > > -		nr_to_pop = clamp(PCPU_EMPTY_POP_PAGES_HIGH -
> > > > -				  pcpu_nr_empty_pop_pages,
> > > > -				  0, PCPU_EMPTY_POP_PAGES_HIGH);
> > > > -	}
> > > > -
> > > >  	for (slot = pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot++) {
> > > >  		unsigned int nr_unpop = 0, rs, re;
> > > >  
> > > > @@ -2084,9 +2075,18 @@ static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> > > 
> > > I missed this in the review of patch 1, but pcpu_shrink only needs to
> > > iterate over:
> > > for (slot = pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot++) {
> > 
> > You mean skip first few slots?
> > Yeah, it's probably safe. I was afraid that a marked chunk can be moved to
> > one of such slots, so we'll never find it and will repeat scanning, but it seems
> > like it's not a possible scenario. Will adjust, thanks.
> > 
> > > 
> > > >  		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
> > > >  			bool isolated = false;
> > > >  
> > > > -			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH)
> > > > +			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH ||
> > > > +			    pcpu_nr_chunks_to_depopulate < 1)
> > > >  				break;
> > > >  
> > > > +			/*
> > > > +			 * Don't try to depopulate a chunk again and again.
> > > > +			 */
> > > > +			if (!chunk->depopulate)
> > > > +				continue;
> > > > +			chunk->depopulate = false;
> > > > +			pcpu_nr_chunks_to_depopulate--;
> > > > +
> > > >  			for (i = 0, start = -1; i < chunk->nr_pages; i++) {
> > > >  				if (!chunk->nr_empty_pop_pages)
> > > >  					break;
> > > > @@ -2153,6 +2153,41 @@ static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> > > >  	spin_unlock_irq(&pcpu_lock);
> > > >  }
> > > >  
> > > > +/**
> > > > + * pcpu_balance_populated - manage the amount of populated pages
> > > > + * @type: chunk type
> > > > + *
> > > > + * Populate or depopulate chunks to maintain a certain amount
> > > > + * of free pages to satisfy atomic allocations, but not waste
> > > > + * large amounts of memory.
> > > > + */
> > > > +static void pcpu_balance_populated(enum pcpu_chunk_type type)
> > > > +{
> > > > +	int nr_to_pop;
> > > > +
> > > > +	/*
> > > > +	 * Ensure there are certain number of free populated pages for
> > > > +	 * atomic allocs.  Fill up from the most packed so that atomic
> > > > +	 * allocs don't increase fragmentation.  If atomic allocation
> > > > +	 * failed previously, always populate the maximum amount.  This
> > > > +	 * should prevent atomic allocs larger than PAGE_SIZE from keeping
> > > > +	 * failing indefinitely; however, large atomic allocs are not
> > > > +	 * something we support properly and can be highly unreliable and
> > > > +	 * inefficient.
> > > > +	 */
> > > > +	if (pcpu_atomic_alloc_failed) {
> > > > +		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH;
> > > > +		/* best effort anyway, don't worry about synchronization */
> > > > +		pcpu_atomic_alloc_failed = false;
> > > > +		pcpu_grow_populated(type, nr_to_pop);
> > > > +	} else if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
> > > > +		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH - pcpu_nr_empty_pop_pages;
> > > > +		pcpu_grow_populated(type, nr_to_pop);
> > > > +	} else if (pcpu_nr_chunks_to_depopulate > 0) {
> > > > +		pcpu_shrink_populated(type);
> > > > +	}
> > > > +}
> > > > +
> > > >  /**
> > > >   * pcpu_balance_workfn - manage the amount of free chunks and populated pages
> > > >   * @work: unused
> > > > @@ -2188,6 +2223,7 @@ void free_percpu(void __percpu *ptr)
> > > >  	int size, off;
> > > >  	bool need_balance = false;
> > > >  	struct list_head *pcpu_slot;
> > > > +	struct pcpu_chunk *pos;
> > > >  
> > > >  	if (!ptr)
> > > >  		return;
> > > > @@ -2207,15 +2243,36 @@ void free_percpu(void __percpu *ptr)
> > > >  
> > > >  	pcpu_memcg_free_hook(chunk, off, size);
> > > >  
> > > > -	/* if there are more than one fully free chunks, wake up grim reaper */
> > > >  	if (chunk->free_bytes == pcpu_unit_size) {
> > > > -		struct pcpu_chunk *pos;
> > > > -
> > > > +		/*
> > > > +		 * If there are more than one fully free chunks,
> > > > +		 * wake up grim reaper.
> > > > +		 */
> > > >  		list_for_each_entry(pos, &pcpu_slot[pcpu_nr_slots - 1], list)
> > > >  			if (pos != chunk) {
> > > >  				need_balance = true;
> > > >  				break;
> > > >  			}
> > > > +
> > > > +	} else if (chunk->nr_empty_pop_pages > chunk->nr_pages / 4) {
> > > 
> > > We should have this ignore the first and reserved chunks. While it
> > > shouldn't be possible in theory, it would be nice to just make it
> > > explicit here.
> > 
> > Ok, will do, makes sense to me!
> > 
> > > 
> > > > +		/*
> > > > +		 * If there is more than one chunk in the slot and
> > > > +		 * at least 1/4 of its pages are empty, mark the chunk
> > > > +		 * as a target for the depopulation. If there is more
> > > > +		 * than one chunk like this, schedule an async balancing.
> > > > +		 */
> > > > +		int nslot = pcpu_chunk_slot(chunk);
> > > > +
> > > > +		list_for_each_entry(pos, &pcpu_slot[nslot], list)
> > > > +			if (pos != chunk && !chunk->depopulate &&
> > > > +			    !chunk->immutable) {
> > > > +				chunk->depopulate = true;
> > > > +				pcpu_nr_chunks_to_depopulate++;
> > > > +				break;
> > > > +			}
> > > > +
> > > > +		if (pcpu_nr_chunks_to_depopulate > 1)
> > > > +			need_balance = true;
> > > >  	}
> > > >  
> > > >  	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
> > > > -- 
> > > > 2.30.2
> > > > 
> > > 
> > > Some questions I have:
> > > 1. How do we prevent unnecessary scanning for atomic allocations?
> > 
> > Depopulated chunks tend to be at tail of the chunks lists in high(er) slots,
> > so they seem to be the last target for an atomic allocation, if there is
> > enough space in other chunks.
> > 
> 
> I'm just not seeing a reason slot(PAGE_SIZE) can't have 2 chunks in it
> and get the second chunk gets depopulated.
> 
> > > 2. Even in the normal case, should we try to pack future allocations
> > > into a smaller # of chunks in after depopulation?
> > 
> > Well, there is one specific problem I'm trying to solve: if the percpu memory
> > is heavily inflated by something (e.g. by creating a ton of cgroups or bpf maps),
> > sometimes it's impossible to get the memory back at all, even if the absolute
> > majority of percpu objects was released. In this case there are many chunks
> > which are almost entirely empty, and the actual size of the needed percpu memory
> > is way less that the number of populated pages.
> > 
> > We can look at the percpu memory fragmentation as a more fundamental problem,
> > and probably the right thing to do long-term is to introduce some sort of a
> > slab allocator. At least, we can put small allocations (aka percpu reference
> > counters) into separate chunks. But this is obviously a way bigger change,
> > which unlikely can do into any stable branches, so I'd treat it separately.
> > Also, I'm not convinced that we really need it so much at the moment.
> > If the percpu usage is more or less stable, I don't see any pathological
> > fragmentation problem.
> > 
> 
> That makes sense. If we narrow the scope to reclaiming inflated usage,
> we could get rid of the 2 chunk in slot heuristic and scan up from
> slot(PAGE_SIZE), leaving a reasonable # of free pages,
> PCPU_EMPTY_POP_PAGES_LOW/HIGH, possibly just leaving those chunks
> untouched and then free anything else before the final slot which will
> be freed by the freeing path.
> 
> Thinking a little more about what you said earlier, they're basically
> new chunks, anything PAGE_SIZE and up shouldn't expect to find a home
> quickly.

Sounds good to me. I'll stick with this approach in v2.

Idk how much we wanna optimize the "normal" (non-inflated) scenario.
My brief look into the fb production data showed that on average the prize is
not that big, maybe around 10% of the percpu memory or a double-digit number
in MBs. However in some extreme cases there are tens of GBs of wasted memory.
I'd focus on this problem first. Ideally we need a fix, which will be easy
to backport to stable branches.

> 
> > > 3. What is the right frequency to do depopulation scanning? I think of
> > > the pcpu work item as a way to defer the 2 the freeing of chunks and in
> > > a way more immediately replenish free pages. Depopulation isn't
> > > necessarily as high a priority.
> > 
> > I think that the number of chunks which are potentially good for the
> > depopulation is a good metric. I've chosen 2 as a threshold, but I'm
> > fine with other ideas as well.
> > 
> 
> We might need to untangle a few stats from global to per chunk_type.
> Thoughts? Having 1 chunk in each type isn't necessarily a bad thing, but
> having several 2+ is the problem?

Long-term I'm not sure we need 2 chunk types. If a reasonable percentage
of percpu allocations is accountable, it would probably be cheaper to
declare all chunks memcg-aware. But as now dividing chunks into two types
is likely having a positive effect on the percpu fragmentation: likely
largest allocations (both bpf and memcg) are put into one chunk set while
all percpu refcounters into an other.

Thanks!
