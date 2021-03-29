Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568D534D6E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhC2SVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:21:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58608 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231354AbhC2SUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:20:55 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TIK3oF027933;
        Mon, 29 Mar 2021 11:20:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7eiZu0LguVFGL5nhxJF7zFkSY9wW4xv7C3QkMYgICaM=;
 b=ltgpJKAsugO3lBkn40Arcyf73THEAABQ8KAIQQY4PNqCtKMiw3cxbLaQ2XL3KiffLCR3
 AulgkoxprIK+ChYl5FMsclN/QXVYwSwx/opLYHznyoCBEpOcnOEyWd6OKojMKmvUlMQL
 OANmBtyqddghx1IW06FW/OSkw7UGv1vcpJE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37kk6n0ex8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Mar 2021 11:20:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 11:20:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/SuqXiP8usXzO8KPCBkT7AEmWsu2mzADQyr+nbnBpaTAdAypOlcvGyEClkaehBSceGCIRXQjSynEZFjHi7jg3O9X10UiycPfCo1RMpTaWpg2FhkQBala7Z8qJruHzP0rwcIRylw5qBA2lUqJ5NBysbO4IhdFXfYaD2yPw2zFrMs2vm3A8P1VhFHx4SXXXBK7HoKJMCOE9zlJxUJnotdVoXltXuDdnsd1IVMlo09MNjNC4GQ7mqa2VzD/qgzwhEBp5hiwuZ7pATgjEadnh5mKNs1BSJGgPxd2upDeu5fsvD4l63M8aLGK3uRovIk0+NefqxzliyO2MB2O0BSHjbB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eiZu0LguVFGL5nhxJF7zFkSY9wW4xv7C3QkMYgICaM=;
 b=EE3BOIukAVw57PPZEvnD3GT1RHAxEQakHY+Imf6pFGOwF+eOasZXvlPG54CPkJuWONBkN+WPS9orUTkTZzH/WDeqiFgAamlLWH2edyEIJDAhbw73oEfd5vL8F4iyS1urgp57T8w+xYY2BV5BHRz1VrlApApwi7v9RiUqMHFnAZMs3hWVt0d5WnIc+72RtuJllA+g3DeM66pdCl3Rji0VeTghXSkWC4CSyFViH+4CMTjGqREQXyRuDPKY/xuWcuRrRP0TUo3wD/Z6tEuk1HhvFfXF7GhefGw1iCMz27L4IMqqV5+kIWF+0N+6EwHpgEtbLjXNH4j9Saoau07dWMeZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4155.namprd15.prod.outlook.com (2603:10b6:a03:2ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 18:20:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 18:20:38 +0000
Date:   Mon, 29 Mar 2021 11:20:34 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 2/4] percpu: split __pcpu_balance_workfn()
Message-ID: <YGIacjqWI8v+TESq@carbon.dhcp.thefacebook.com>
References: <20210324190626.564297-1-guro@fb.com>
 <20210324190626.564297-3-guro@fb.com>
 <YGION8fYFy0uVVlm@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGION8fYFy0uVVlm@google.com>
X-Originating-IP: [2620:10d:c090:400::5:1478]
X-ClientProxiedBy: MW4PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:303:b9::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:1478) by MW4PR03CA0224.namprd03.prod.outlook.com (2603:10b6:303:b9::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 18:20:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebc0ba9e-38d0-4aad-f17a-08d8f2df5a4f
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4155:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB41550F9EA1FA1B9559E7E723BE7E9@SJ0PR15MB4155.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydDGD9MtahXlJJqE+gvx9IR/oP9gmXu+TmLsz0JErCpUU5dAJFcGenTzCjF6fEaf5g2gxGPg/Y08i/ShasR2FCjOOlZD1dqeLJgZHV5Cwe3tC+qah9riro0uPP13SifdJPgZj6SU1rksJ8sDEW6fjXkXmxfeERbZOYPgssS/1+WaAqf9R8041T9EzucL8IOw9jqVnCrn0/r9tI2QlXmYJRW8e85GoROcJcRZzlbUD2FzBWWGDhS4FiYSG6vkfmUZ4mpRcQYGnlCxjVP4YDQY1s6gdRrZcSeKqel5pCdsiBgJEq1QEblaTstGaq0QXjKtKfa/dBUpEag9VkDHMz29o3DE5YMys49dBHERHhIGa0k7Wsb5jgjJp0ja6cue8zqFN+STZF7PxHJXtk14/Skbg5qb/gE4B2rb0d9C7Tf/0ftC492kImqwJnG0FGDxkij+zQ3ngxPKHeJrKqqyp5SXTaQPtsABFfGVh++YVJ+n0iaNiShidFObg/vpa9PNrDy0f7AIWpWh+Pkfmewt8i6Nc3fEg5+dn1lCyozEu0Qv/Bd6bcu/mRvMzLfIPZ6MqxLpW9o8HdbDkq7ETsj/CjbCmDtp76M9f3eQTxQSEx6htInNYq9LMC6mBAnDkWpLKQahwJY3XlSSzbP0T3bnnxvLEykdKfbLr01PV+9if7dIijeGKnEKJYe+ew6uk7JEUhAP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(316002)(8676002)(16526019)(6666004)(55016002)(66476007)(66556008)(2906002)(66946007)(186003)(9686003)(38100700001)(83380400001)(86362001)(52116002)(5660300002)(6506007)(8936002)(478600001)(7696005)(6916009)(4326008)(54906003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YFmqlqAfD6dhUtscbclPyyQcdBC1L0djNlDmKhUF09tW4Qm0lZmLkTkWIG0J?=
 =?us-ascii?Q?wLvdzYgntbCdUEgHu34/jOkNiMOR4R5tw2FvMp7slpMmaXJs5yNtJHQTpPFw?=
 =?us-ascii?Q?GXYJz9tK/sG7s01ihiSJYYYmswA0hxqSOb3qGvyQvGN71ibMWfVUgY7ymxDb?=
 =?us-ascii?Q?MXa670zJZBmtPCVDprmeIh1rpxgEF8cCqofMFzjCJrC8o2ES8ij1uhSOfKmW?=
 =?us-ascii?Q?cS/KVSFBTJZy3iv8cQJL+kw9LrhAZgidLJ69rgqgEZXDQhpEBHd07XizKZN2?=
 =?us-ascii?Q?UTD5RmlfAil8FhlUSxozwQPVVNxHIqAZ9KdT3uaW3NJP/DFm9qVztjW15260?=
 =?us-ascii?Q?Mp+/ju07mqIttVXYBvCooXkSAnsCl0y4vOEc5LvM6VC/DBi5zm1WTm4Lmcbl?=
 =?us-ascii?Q?hcnbZPRTWmiFc89W3iBbL/l1eVggiE4XgB0I/yNWHYRkIvtuMWXQVibMAyin?=
 =?us-ascii?Q?Xa0mnf8vWgPiAVOHm9rUpL8uZlkpVbKi3STYzKBfYsbV3mwYdcI0h1++b2R8?=
 =?us-ascii?Q?+khxa2mdjMO1b1Dl/zzc4VONDg+9gEQxSfw5b9E60ZKC9dqUCUzIG4SKaMBZ?=
 =?us-ascii?Q?suc6uzYUuxrS1cSE79aYr7rIHhtXnX+o9P2Okyi2Lta1cfVwLNJfaOeSY97d?=
 =?us-ascii?Q?jO4lfMAa76e7WhqTQFhNkVJBKidktdL4+NHnCq/cPhpONucvaeE7AyLegoRL?=
 =?us-ascii?Q?3/RR2FaPtJseV//vnPTflTyCxtLCGQrYq601gA+DrpMIMv0GHYqcoVZtaEl7?=
 =?us-ascii?Q?aK0TcczaB+FzCmWHv5aMt+Y7FajS2FN+nh48R+RZLo8btNtncAeWu6wy0wxB?=
 =?us-ascii?Q?orAC3n3GsKcCo2u2+kiDXmk/VAMjvv9TqW6gV3Usy9x4ab88wJo5BVUGrM4D?=
 =?us-ascii?Q?saqwb6DDSfWMcBpX3Qx8A9JDK7Qc/tAmVnU/chP6vNAxgSOByhdExKCyZUr9?=
 =?us-ascii?Q?U40u4kTNOZT5vXQEZXEbZqSD6mZ9pSatyLyS/cTgN9DUmSRzEUiWu+a7KImZ?=
 =?us-ascii?Q?wlWfybesCdjBhhkzdTE99DxMob6EmLd0pMbu537xBJOWH/BaBOH5Bfb5QBZo?=
 =?us-ascii?Q?lWgWuZuiwtybtfh1lxcgKQ3SYGARfEXK8qxs9je1emGDL3WN5oaIv+ZgLnLs?=
 =?us-ascii?Q?3Oan88IoVX/kUXL4LMZ9cF54DmOEqBPVNSwZa/3iVqdv7Lj494Ptl4IjIT4r?=
 =?us-ascii?Q?HB5kkp7+bb/UdQt2VPcFE0F6SvGlhbL6X3RONfwnuYsq0yfzMXWLR28u4Nv5?=
 =?us-ascii?Q?DTnrU9ZH0EXgDIvJ8eoMLwJJnwtSqtS3tFa3BNYqGadsF4YJ0Wl3gqq1qku+?=
 =?us-ascii?Q?6sB7mCcDxBoanIH6LDIcB0nEFLfbYLIrHWfTgNp0qz65Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc0ba9e-38d0-4aad-f17a-08d8f2df5a4f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 18:20:38.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74YnwM/v4HABHkyO1riryVjyWpZm4vmzLo8aJ1a+XViWq+rYZsOuGzaEHeClMvTC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4155
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: yPKF3v8pcUOhHVHaSnpJa50zKU8up2CU
X-Proofpoint-ORIG-GUID: yPKF3v8pcUOhHVHaSnpJa50zKU8up2CU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_11:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103290136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 05:28:23PM +0000, Dennis Zhou wrote:
> On Wed, Mar 24, 2021 at 12:06:24PM -0700, Roman Gushchin wrote:
> > __pcpu_balance_workfn() became fairly big and hard to follow, but in
> > fact it consists of two fully independent parts, responsible for
> > the destruction of excessive free chunks and population of necessarily
> > amount of free pages.
> > 
> > In order to simplify the code and prepare for adding of a new
> > functionality, split it in two functions:
> > 
> >   1) pcpu_balance_free,
> >   2) pcpu_balance_populated.
> > 
> > Move the taking/releasing of the pcpu_alloc_mutex to an upper level
> > to keep the current synchronization in place.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  mm/percpu.c | 46 +++++++++++++++++++++++++++++-----------------
> >  1 file changed, 29 insertions(+), 17 deletions(-)
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 78c55c73fa28..015d076893f5 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1930,31 +1930,22 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
> >  }
> >  
> >  /**
> > - * __pcpu_balance_workfn - manage the amount of free chunks and populated pages
> > + * pcpu_balance_free - manage the amount of free chunks
> >   * @type: chunk type
> >   *
> > - * Reclaim all fully free chunks except for the first one.  This is also
> > - * responsible for maintaining the pool of empty populated pages.  However,
> > - * it is possible that this is called when physical memory is scarce causing
> > - * OOM killer to be triggered.  We should avoid doing so until an actual
> > - * allocation causes the failure as it is possible that requests can be
> > - * serviced from already backed regions.
> > + * Reclaim all fully free chunks except for the first one.
> >   */
> > -static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
> > +static void pcpu_balance_free(enum pcpu_chunk_type type)
> >  {
> > -	/* gfp flags passed to underlying allocators */
> > -	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> >  	LIST_HEAD(to_free);
> >  	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> >  	struct list_head *free_head = &pcpu_slot[pcpu_nr_slots - 1];
> >  	struct pcpu_chunk *chunk, *next;
> > -	int slot, nr_to_pop, ret;
> >  
> >  	/*
> >  	 * There's no reason to keep around multiple unused chunks and VM
> >  	 * areas can be scarce.  Destroy all free chunks except for one.
> >  	 */
> > -	mutex_lock(&pcpu_alloc_mutex);
> >  	spin_lock_irq(&pcpu_lock);
> >  
> >  	list_for_each_entry_safe(chunk, next, free_head, list) {
> > @@ -1982,6 +1973,25 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
> >  		pcpu_destroy_chunk(chunk);
> >  		cond_resched();
> >  	}
> > +}
> > +
> > +/**
> > + * pcpu_balance_populated - manage the amount of populated pages
> > + * @type: chunk type
> > + *
> > + * Maintain a certain amount of populated pages to satisfy atomic allocations.
> > + * It is possible that this is called when physical memory is scarce causing
> > + * OOM killer to be triggered.  We should avoid doing so until an actual
> > + * allocation causes the failure as it is possible that requests can be
> > + * serviced from already backed regions.
> > + */
> > +static void pcpu_balance_populated(enum pcpu_chunk_type type)
> > +{
> > +	/* gfp flags passed to underlying allocators */
> > +	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> > +	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> > +	struct pcpu_chunk *chunk;
> > +	int slot, nr_to_pop, ret;
> >  
> >  	/*
> >  	 * Ensure there are certain number of free populated pages for
> > @@ -2051,8 +2061,6 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
> >  			goto retry_pop;
> >  		}
> >  	}
> > -
> > -	mutex_unlock(&pcpu_alloc_mutex);
> >  }
> >  
> >  /**
> > @@ -2149,14 +2157,18 @@ static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> >   * pcpu_balance_workfn - manage the amount of free chunks and populated pages
> >   * @work: unused
> >   *
> > - * Call __pcpu_balance_workfn() for each chunk type.
> > + * Call pcpu_balance_free() and pcpu_balance_populated() for each chunk type.
> >   */
> >  static void pcpu_balance_workfn(struct work_struct *work)
> >  {
> >  	enum pcpu_chunk_type type;
> >  
> > -	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
> > -		__pcpu_balance_workfn(type);
> > +	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++) {
> > +		mutex_lock(&pcpu_alloc_mutex);
> > +		pcpu_balance_free(type);
> > +		pcpu_balance_populated(type);
> > +		mutex_unlock(&pcpu_alloc_mutex);
> > +	}
> >  }
> >  
> >  /**
> > -- 
> > 2.30.2
> > 
> 
> Reviewed-by: Dennis Zhou <dennis@kernel.org>
> 
> This makes sense. If you want me to pick this and the last patch up
> first I can. Otherwise, do you mind moving this to the front of the
> stack because it is a clean up?

It's up to you :)
Sure, I can move it to the front, will do in the next version.

Thank you for taking a look!
