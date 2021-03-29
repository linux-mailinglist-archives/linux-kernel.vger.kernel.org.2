Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798CB34D728
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhC2SaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:30:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16660 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231710AbhC2S3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:29:48 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TILeAp031496;
        Mon, 29 Mar 2021 11:29:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=YqOaOs8aECVSK5jBVIv/J9x9Xr38QpJJSDhHg1N37ak=;
 b=LUjeCxxJooAyFoqN2pmlAsIwCQWz0z4PGdkK4TxF/vEPqD/5zNjlPrDOfgBPTjh5TWVR
 5MyQrNanFHibRmLbxRINFtOk2/NMNANYkGFlVDcefU+IB54pSRuj7A3M8kaeYr/WbkRp
 QmbqkK8lyTJYxhummIccm/XkyzTmyeJl0kI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37khfy197w-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Mar 2021 11:29:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 11:29:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ft36Onkf7vYirpHgA7AFQLoViV/IrdkmIROyv2nZcvYxrU4D/yiwjAr14rKYEYmD07RpwO+4RvpY0KQQaym8hs1aCeY3jedp+Rbtoz42xFK2nUSLf8bs7mrMgVMs93hhs+62Qx3Ca6V9OEp+ZaSGVyA1TD210Qv0/k44A0Z0b1hN7K6QK1Wh11No8hcQn8FIQj/81RpYEDFFvLisOT5ZRecGfYDU2g6ydAMZ7RkV3c/EHnNI87cErvAagAXuOrKocCG237W3xdKa8li7ztAVTyco3vBrnZ+PzjohKry5N3nXAC9VWmhj/tCIsdQU4X+ZkLyf9hT+0DACPgLp/pUqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqOaOs8aECVSK5jBVIv/J9x9Xr38QpJJSDhHg1N37ak=;
 b=cUC8EAu2bnzJht1TmFsrnzcxS2kULXoze5pEB94Rk5QWHl8KGbbQ0Od2pM3DN2Th3J1M2Tj1JuWSZl+I+fhkepO+1hnPF/INSNc8VxRt63Hdd62zdGqkBlZtd8ifLvTeFYg3LzdlJsW3fC2e8a2RypDc6xkaSfBOqdRHhcNWQQfkREUMq865Lgj5U+7+WwroI83FmPPS7Fn/KH6sdt8kiOecQL5UDwZiCVt0UloO3NspBfN0+uHCix8EQOWut44Ay5MsskqBSKqb5MYhfh4rwK2sHcOF9YT5nigVZTu0KYizMD3fZHXPN7AXssqNI+x1J91VA5Y3DO5pWr8k2D03bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2933.namprd15.prod.outlook.com (2603:10b6:a03:f6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 18:29:26 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 18:29:26 +0000
Date:   Mon, 29 Mar 2021 11:29:22 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 1/4] percpu: implement partial chunk depopulation
Message-ID: <YGIcgp/shX4HhXOk@carbon.dhcp.thefacebook.com>
References: <20210324190626.564297-1-guro@fb.com>
 <20210324190626.564297-2-guro@fb.com>
 <YGIMdy2t1oLHDC4b@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGIMdy2t1oLHDC4b@google.com>
X-Originating-IP: [2620:10d:c090:400::5:983e]
X-ClientProxiedBy: MWHPR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:301:2::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:983e) by MWHPR12CA0025.namprd12.prod.outlook.com (2603:10b6:301:2::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29 via Frontend Transport; Mon, 29 Mar 2021 18:29:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54a8ef43-601d-4819-0cfb-08d8f2e09513
X-MS-TrafficTypeDiagnostic: BYAPR15MB2933:
X-Microsoft-Antispam-PRVS: <BYAPR15MB29338FA5024FE464FE609C33BE7E9@BYAPR15MB2933.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7LLqdrNqaBlmst8tmI/mq3Z/I2yk6gc7rHjkhBtloa42IgDZZW8rHUbc/aaPtWypwkWUNRpg/2Xhqx3mdpE5Zx2/bRXJNpdrfdz//ZL+BVrzEGbmpCDqhvBXS94LEN+YHM7vYn7JNjbxfcCu4O0uLmdPSfIIjEPEOG8FnISbqeSkVG0se7tqHQKgfWD1JDzOuoJ9NBIiHGuOiuVAiDlhgHp0QFZKJmUDHD8OV2+0XIwA1sbuvwBqB8bEC862pxTzNjlzXM5hOBJ+RLJRT0IkrkBT6xZvbZZe6FnrKCBP+dCnIUoLOKxoBZ/VFKNCOtNoHzOSm9OAvR3jgxqgJnuhF7pG6kf3c/6MIIOIFxP5mLsKZkIQ4nBRz+40oQhlnSOZ0OW8u0WX0rOMEWceQ/D6keT8HbjuHChVt5vTvy9avVL3K1xDRNPvZX5Ro1DSMiBn8T07nnYrRgroDKY2zBBBpBypvM/Nn2HP9TAj7G4gvydAE+Rx7qPs7fjvNuKp0abgHbPG+/3VNqqhKgIdI80lPv0MaWkV7v4E8fZ6k5mkLYB4+KypFirDsfHi7VawlatGAj3yxnbAc804GmPtzDxFlEUvUl4my6OILfZ/aq/yj29CHwIWW8x347c83f5LPUSMOVNHBS6PtrlGONh7G04sag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(376002)(346002)(6666004)(9686003)(2906002)(83380400001)(8676002)(6916009)(66476007)(6506007)(55016002)(186003)(16526019)(86362001)(7696005)(4326008)(316002)(8936002)(478600001)(66946007)(52116002)(54906003)(66556008)(38100700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kgHEPkOIpB2+39Lkeuk0m5uyQy7yI82eqpdGkX1GjGTXHnyK1RoxVSjIhk9x?=
 =?us-ascii?Q?I2MngkR2k01BF8B5PzwrAf+y6CENZ2F/AwLmYNG1hYO72jwWsxdK6a43Jtjb?=
 =?us-ascii?Q?O61fUxr8VDTLv0OCZ8cs99rj44Uas1RTshkg5rTlU6o0vqdrlW4EqJdioQQz?=
 =?us-ascii?Q?G4Yi3qsCNuytCrmcQqdzNWNtA65MgHQHNCDIT6Yo58iMtcGkb1c0c0mdBKFe?=
 =?us-ascii?Q?+ySf57Cj+kqb5d9sfxfO6rQ0zbAF023mOMWk5InDp9MMZembZht8rN8bcUSr?=
 =?us-ascii?Q?EYqcK0Xww+8trd63WVwFOXlbcRJYh+ugdpJytof40wenaeAT1N5rK3jUpvOw?=
 =?us-ascii?Q?6jQ3HuZcw+O15hHmP6JhzaCN0wsk0wzTWlx7vIZZhrpjIsLZ69Rr7X1Gp1ve?=
 =?us-ascii?Q?AIn/7bXzkgdQSr9OWIKAXKDQ0V2CTW3Nhmr5a5V5rXcd8K9dsFWvjJjSfgDQ?=
 =?us-ascii?Q?LQGyplx5/CXAB3RT7HRyBLdexuCUfhtRoHsmBF8W3dEnS8c5TPd6tglkBB0i?=
 =?us-ascii?Q?TspMWxszb0TGb2S4jmPWMYULH9Vn48S6FeEUUsm9WGeDEsu585aqmmFfXYDg?=
 =?us-ascii?Q?t+xjTbd+ZdT2J1Vn8oqJxEKqOg5ZXWpBmJNDBUHDzVr+yNbSho3fM+R0mL1b?=
 =?us-ascii?Q?LN2OV1vdRBCXThSU4o1ccU4pf80+p1O7SAZRCxMsuZZ5ZP4ChNG7BVdKSs2f?=
 =?us-ascii?Q?Uqx/qQZIOVzGmytI2XtwmfK+PrgAZIQyU61qf0BT3tkKhHNL2apPdYLu8Znl?=
 =?us-ascii?Q?heC33KewhuSkquPeg+qHHtn46+d1I43UhHTLNsetyr+JbVyYp3q63Fgp8AUb?=
 =?us-ascii?Q?Cq9ktjURje8JzGAAr0gkc3LZuVk+Mwzx89E/Xyet+oCD61/0V8zYCcVsmdJI?=
 =?us-ascii?Q?r1Kk9y+4FVMUhJRAV4AM29b4HBpJbYOPo4k5wSk5InsAX/c0qLiRHhHU1lc2?=
 =?us-ascii?Q?kBc1BjRh4ze+jtTGVoEwGgX1FvgxXmrKecjHOYJBdbaq3i06Tyuhi/wQ+6hw?=
 =?us-ascii?Q?zuYfMCL26Fgj73DRxWuS+Yt0Skiba7wV8dJPBul9q3MEryGbI3LI5fPF26st?=
 =?us-ascii?Q?tc/WNlsqFNkU0D44OM6//0V44KROg7uRZ8W9Kx9RoiT2Fzhz35YH/fMKQYzA?=
 =?us-ascii?Q?tP0Fw9aqAc4Dtlo5LxLxgxqVWU3haUtNhRY54GNNYkuaEiB3ECl8elK8ue4r?=
 =?us-ascii?Q?zvXrUNym3/ss7zkTssxfDwv9oHQFdjX/I2MRMec4LesojLWzxy9SkTDqYYlt?=
 =?us-ascii?Q?Ia9Wk7FDGtdIL56vAsoO0RQ6VLiXsqKn/SiUWW6Y04TNFgA52GzMC+VE4gx4?=
 =?us-ascii?Q?HlzEY6nmaTytxz4a/OXtJA7FNiH4PNZkiM25t0UbbUnDcA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a8ef43-601d-4819-0cfb-08d8f2e09513
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 18:29:26.2606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scQpcUOAwYl1sLD2swPxvYvJQx7oeKIiVZwX1FugXjolbHhly2yvfWZYsRxtIGUH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2933
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: cm0zBPhqe_inTNxCknwSGd5u0RCeFxVX
X-Proofpoint-ORIG-GUID: cm0zBPhqe_inTNxCknwSGd5u0RCeFxVX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_11:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 mlxlogscore=971 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103290136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 05:20:55PM +0000, Dennis Zhou wrote:
> On Wed, Mar 24, 2021 at 12:06:23PM -0700, Roman Gushchin wrote:
> > This patch implements partial depopulation of percpu chunks.
> > 
> > As now, a chunk can be depopulated only as a part of the final
> > destruction, when there are no more outstanding allocations. However
> > to minimize a memory waste, it might be useful to depopulate a
> > partially filed chunk, if a small number of outstanding allocations
> > prevents the chunk from being reclaimed.
> > 
> > This patch implements the following depopulation process: it scans
> > over the chunk pages, looks for a range of empty and populated pages
> > and performs the depopulation. To avoid races with new allocations,
> > the chunk is previously isolated. After the depopulation the chunk is
> > returned to the original slot (but is appended to the tail of the list
> > to minimize the chances of population).
> > 
> > Because the pcpu_lock is dropped while calling pcpu_depopulate_chunk(),
> > the chunk can be concurrently moved to a different slot. So we need
> > to isolate it again on each step. pcpu_alloc_mutex is held, so the
> > chunk can't be populated/depopulated asynchronously.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  mm/percpu.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 6596a0a4286e..78c55c73fa28 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -2055,6 +2055,96 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
> >  	mutex_unlock(&pcpu_alloc_mutex);
> >  }
> >  
> > +/**
> > + * pcpu_shrink_populated - scan chunks and release unused pages to the system
> > + * @type: chunk type
> > + *
> > + * Scan over all chunks, find those marked with the depopulate flag and
> > + * try to release unused pages to the system. On every attempt clear the
> > + * chunk's depopulate flag to avoid wasting CPU by scanning the same
> > + * chunk again and again.
> > + */
> > +static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> > +{
> > +	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> > +	struct pcpu_chunk *chunk;
> > +	int slot, i, off, start;
> > +
> > +	spin_lock_irq(&pcpu_lock);
> > +	for (slot = pcpu_nr_slots - 1; slot >= 0; slot--) {
> > +restart:
> > +		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
> > +			bool isolated = false;
> > +
> > +			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH)
> > +				break;
> > +
> 
> Deallocation makes me a little worried for the atomic case as now we
> could in theory pathologically scan deallocated chunks before finding a
> populated one.
> 
> I wonder if we should do something like once a chunk gets depopulated,
> it gets deprioritized and then only once we exhaust looking through
> allocated chunks we then find a depopulated chunk and add it back into
> the rotation. Possibly just add another set of slots? I guess it adds a
> few dimensions to pcpu_slots after the memcg change.

Please, take a look at patch 3 in the series ("percpu: on demand chunk depopulation").
Chunks considered to be a good target for the depopulation are in advance
marked with a special flag, so we'll actually try to depopulate only
few chunks at once. While the total number of chunks is fairly low,
I think it should work.

Another option is to link all such chunks into a list and scan over it,
instead of iterating over all slots.

Adding new dimensions to pcpu_slots is an option too, but I hope we can avoid
this, as it would complicate the code.

> 
> > +			for (i = 0, start = -1; i < chunk->nr_pages; i++) {
> > +				if (!chunk->nr_empty_pop_pages)
> > +					break;
> > +
> > +				/*
> > +				 * If the page is empty and populated, start or
> > +				 * extend the [start, i) range.
> > +				 */
> > +				if (test_bit(i, chunk->populated)) {
> > +					off = find_first_bit(
> > +						pcpu_index_alloc_map(chunk, i),
> > +						PCPU_BITMAP_BLOCK_BITS);
> > +					if (off >= PCPU_BITMAP_BLOCK_BITS) {
> > +						if (start == -1)
> > +							start = i;
> > +						continue;
> > +					}
> 
> Here instead of looking at the alloc_map, you can look at the
> pcpu_block_md and look for a fully free contig_hint.

Good idea, will try in v2.

> 
> > +				}
> > +
> > +				/*
> > +				 * Otherwise check if there is an active range,
> > +				 * and if yes, depopulate it.
> > +				 */
> > +				if (start == -1)
> > +					continue;
> > +
> > +				/*
> > +				 * Isolate the chunk, so new allocations
> > +				 * wouldn't be served using this chunk.
> > +				 * Async releases can still happen.
> > +				 */
> > +				if (!list_empty(&chunk->list)) {
> > +					list_del_init(&chunk->list);
> > +					isolated = true;
> 
> Maybe when freeing a chunk, we should consider just isolating it period
> and preventing pcpu_free_area() from being able to add the chunk back
> to a pcpu_slot.

You mean to add a check in pcpu_free_area() if the chunks is isolated?
Yeah, sounds good to me, will do in v2.

Thank you!

> 
> > +				}
> > +
> > +				spin_unlock_irq(&pcpu_lock);
> > +				pcpu_depopulate_chunk(chunk, start, i);
> > +				cond_resched();
> > +				spin_lock_irq(&pcpu_lock);
> > +
> > +				pcpu_chunk_depopulated(chunk, start, i);
> > +
> > +				/*
> > +				 * Reset the range and continue.
> > +				 */
> > +				start = -1;
> > +			}
> > +
> > +			if (isolated) {
> > +				/*
> > +				 * The chunk could have been moved while
> > +				 * pcpu_lock wasn't held. Make sure we put
> > +				 * the chunk back into the slot and restart
> > +				 * the scanning.
> > +				 */
> > +				if (list_empty(&chunk->list))
> > +					list_add_tail(&chunk->list,
> > +						      &pcpu_slot[slot]);
> > +				goto restart;
> > +			}
> > +		}
> > +	}
> > +	spin_unlock_irq(&pcpu_lock);
> > +}
> > +
> >  /**
> >   * pcpu_balance_workfn - manage the amount of free chunks and populated pages
> >   * @work: unused
> > -- 
> > 2.30.2
> > 
