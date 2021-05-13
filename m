Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4011937FD3D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhEMS2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 14:28:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20996 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229748AbhEMS21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:28:27 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 14DIDT9S029712;
        Thu, 13 May 2021 11:27:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=XGRpUmW1dnTiJPXLI2zZaCBcpzPpsAu1xq6fwj00Y3Y=;
 b=VKZykgr60o4L1Rxtv1jbmZPlgk/bdGRDn1aDL/7rcIQ4nTMqRd8k15CjLltZtgJRt2gS
 jdtn9JNoyKflcotuoMvGdk4Qwt/8L+z5LkpO+K9799UDlem121IpdHc7VOxukDYFKz/v
 2e5pff3qq10NXhj7kJ15BFge2txSFKRr8SM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 38gpnhnr7a-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 May 2021 11:27:07 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 13 May 2021 11:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wcilk9cK5EZXnUGV7mNRHdtKB7pRhM8SDJH2oWFQWNesmPKeZKtJQJpDNiOfCTThR/0kPe5ZFIWVzm9O3CeXxftT6BSnYYEUUmHDlPi3SBlSagoq6y7+LiUm7LwhNqmwUHoF1hEha1uYwN1BlBEfl5tJHKm66gXjS2rYU7Q/BMTLb7SaT4sXGudtlvnYfprVHezgCcVzG1gu4/hqXhcRAwimk/z0xg+w5K/Q3Zo1beLIx5WkyXOlecwpSnEVhNEQkFok40JhXrSCJKI7WUD2ZrYANLFiAMD1xorCJUiHU3NOKXcK2V6AZfPXKAMY788wpuyTGJ9djbW/GZZijIR/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGRpUmW1dnTiJPXLI2zZaCBcpzPpsAu1xq6fwj00Y3Y=;
 b=Q8BsqODGh+u1pT+H2Lk2TXxp+ukd/UFLJkI5/gIsuutD6vWUfHXmsZfUoKB4im++DU+qS1bpyiIQTXxRXsja22heBiUXOhI7Gc6Dlq/FMIO10799I7HZnApGsFbt6/I1kzD22NMjzG8sq0FH2YNq3Iqdoayvs0zqkz+UAHQDHA0nsFROl5XZzWR/yhtg9K4ZzwnGp6WKKbU0UBK30l2tPMA/KiBAN+M+1M/PAqoZofnKM2BhNVzpRf464xbqismiTClFo8oMx9Zg04u6sto+Vpz13bcU3/bqgH09FJLCbgUBQK242lgoMN0GAbX/fjGwm/93HKZjcJaP7htxVLrL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4135.namprd15.prod.outlook.com (2603:10b6:a03:a0::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 18:27:05 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 18:27:05 +0000
Date:   Thu, 13 May 2021 11:27:00 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] percpu: rework memcg accounting
Message-ID: <YJ1vdAC52gaOqAQ8@carbon.DHCP.thefacebook.com>
References: <20210512003504.4023979-1-guro@fb.com>
 <YJ1Iuviqo6NE4Kma@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YJ1Iuviqo6NE4Kma@google.com>
X-Originating-IP: [2620:10d:c090:400::5:4008]
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:4008) by MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 18:27:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3118133b-16f9-4223-c0d8-08d9163cb5a0
X-MS-TrafficTypeDiagnostic: BYAPR15MB4135:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4135AB6A92B6109C766F476FBE519@BYAPR15MB4135.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3dBoE+l3xwuAyyFqVTuLtKyjdqyQ2sExzvXOgE2W8mCsholafCPaHbR3o5msLnr2zX9PsbrbBhjKxM9YcTB+hfRbEbn+qhtUH+JVxYsovi+z/RptuqBQwTgiFGn0jlMTinF97JOErps9AOGPJ1Pq9NQLF/JoczZ+mxSzD2Mmj0SODwIPQd6U29/08/sFdGuZsDJIaC6obkHKw/uqavjBTY8/eRX+Mn/lOnMlsymBND5HzbkMIP+OK84mxVCHvC9lxoRGaJGEhhGdYUTB56r9yUaBMZHNfyyAdaXzjB5GCIAkY1j1Z4VLJoWxI0diWyXeVF1HkZ3STMx9Pr2ywFzjFAc2M2v8HCCFw0FDv8zB3oewmxKk9GX/8tIQ5fKpuzSe4zLDlzHPBEwR/p6Q6Q7isI3UyVI823hsvSaFtD2wxiqe3X7pZ1hmIJ0XLPNCJkqimExpvZpOUPlZP/Og7c+b09ojtCoO1Z8kJRW12iNjqZLhvK6KHcd3ApescdtUwIu+U90Jl3y7z965tO0EvcwpN1sU6nqzZA2iBj1w2uS9tAILA/NhRmmFX5RHMY20DIvb1Vrw42l+YhRdKOqHwDpJdMmrMUYxzGVRomSwpNm+aFudJxjB1LZyzlGyxn5mHAIhUxnCDoxs5xZYxiGuzxuwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(83380400001)(30864003)(6666004)(38100700002)(66946007)(8936002)(54906003)(316002)(4326008)(186003)(16526019)(5660300002)(2906002)(15650500001)(6506007)(9686003)(52116002)(7696005)(55016002)(6916009)(478600001)(86362001)(66476007)(8676002)(66556008)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kxoOFDAa1tCCRGbvG9t2LBiBScXsSfx9yb14M0unyJjAP5kYccIes/U+qqs6?=
 =?us-ascii?Q?mFWd22iQQjszn1ivac3vI1Uf1yop+MtsetlK+4/3j2pA58Eu8h92jp4P2etD?=
 =?us-ascii?Q?7+ZMhKDU6qEHpSw5kieA3mBLdaUa2ygxwwJB2jc6Rm6TM1vt5HViD0mc6KH6?=
 =?us-ascii?Q?TiweCZ7EdXIlR/yGzvDUvBz7XnOe++tU2yvYT2Q9vRvteteeWhAR6mX86bET?=
 =?us-ascii?Q?tKibGg/GodqKKY22LRLHSv5ki1GD6adt7w8IxHoBtncDsoVQzNYrY7Yef1FY?=
 =?us-ascii?Q?a5+C7MswghmqX1VmejL4MhMvaVke68ql8x7AIp4oIcwEVRKZId4UWduSRGnB?=
 =?us-ascii?Q?Ad5k2cuH7E+F0bQMO1RxWNNEqMVBO5smiNNaDYEfLyQE2WRNlIh1Z+U+40ig?=
 =?us-ascii?Q?yntnxOD87IZxFN23Y8/kgVRV/mqUUzClGJAx5LWRtORI/GKgu0vYn4AQQR/o?=
 =?us-ascii?Q?fcmop9z32sMuctS7M5UAI/z7/z2JmmsuWM5/96BCd1M33vNaedSc3oqiY07x?=
 =?us-ascii?Q?8SoNyc83vV2K5x6NDtkwJKkurchA6N0/ajX8ocuiGyI5BDlD5eyIX6+q6OmL?=
 =?us-ascii?Q?uAjG9t/n7TYj/jPclXol1OG3xyriQOC/HKwj6pdq2wU3sCnnzTyJs/kvOGde?=
 =?us-ascii?Q?285f3HPYoGnYAOkmdwMk2wVUgbyE8xlHyVNt0uimOl8ze4jQn6fbCRQcIIOD?=
 =?us-ascii?Q?zTBK3Bvxoo37nZ2/C3ThFNecfwHd4rWwOUnevWaEv2CH1upZvI5zvE6Anr92?=
 =?us-ascii?Q?G6WE40L6iISfiTxbsQrSFnAXKLaykK9yBO2fpb3be+nSdo52dAnGNI+PSyDo?=
 =?us-ascii?Q?X7cvnSK+1WGG0yj5KDoNBWJD3EJUiH/KL6negkUjx3zP4mEqeXsiX3IRG2fk?=
 =?us-ascii?Q?0RThjlY7tb9taS6Fnp7tCRVAL6hs8n1TNAaOhox1Mj3mnNOIVRKqt8lxYZjr?=
 =?us-ascii?Q?wEg7dVjUQPb1zah/tXr4AuN3HLKQzGQglEny9hCMhVZV6eBAOq1Wk3nx6ISu?=
 =?us-ascii?Q?HlxRjkMgFiSvpL4BFUa0sBfLHA24s3tMtfqNyg4NkH2eQ9ROZAEUK/58pPC5?=
 =?us-ascii?Q?X3mOAiiPB3tJZcjjRrmmCL67bUTEkNEomNhNoMQV4bp3Stl9sd0x6pyzBgmd?=
 =?us-ascii?Q?ZUA/0N+n3FEEEkMOedzMYAiBr4iUc5GfCnR/LzP8uXVzEjFDbXEeF/wP/rTy?=
 =?us-ascii?Q?+jsGj3SKIx4LG+0R39cjvQNZNuephoGs/XkuJpBrLgMZQG7Bnh3Td1vEUZ5D?=
 =?us-ascii?Q?5isIZiBN0VoKSrh+q2Xj80YywTKs6uSyDbb6TfGoirZ+I0kRRSukBxyxzrGu?=
 =?us-ascii?Q?orcwdfhQ1+DTXKRsolZ9K8wowxIvTgx2Vk2kimO6ctoNDA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3118133b-16f9-4223-c0d8-08d9163cb5a0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 18:27:05.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUW3912Vya/drLIbLZykuV2C0RB6vB+9tJeGybLxYlNvRYRUCUgILTxf+HYPU/AF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4135
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 1raYiIc27bZVwRKbPJdIFTG2AOimMDmk
X-Proofpoint-ORIG-GUID: 1raYiIc27bZVwRKbPJdIFTG2AOimMDmk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_10:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 03:41:46PM +0000, Dennis Zhou wrote:
> Hello,
> 
> On Tue, May 11, 2021 at 05:35:04PM -0700, Roman Gushchin wrote:
> > The current implementation of the memcg accounting of the percpu
> > memory is based on the idea of having a separate set of chunks for
> > accounted and non-accounted memory. This approach has an advantage
> > of not wasting any extra memory for memcg data for non-accounted
> > chunks, however it complicates the code and leads to a less effective
> > chunk usage due to a lower utilization.
> > 
> > Instead of having two chunk types it's possible to have only one and
> > allocate the space for memcg data (objcg array) dynamically. It makes
> > the code simpler in many places (no need to iterate over multiple
> > chunk types) and saves memory. The only downside is that in a unlikely
> > event when a percpu allocation succeeds and the allocation of the
> > objcg array fails, the percpu allocation is passed unaccounted. It's
> > not a big deal (a single unaccounted allocation will unlikely cause
> > any systematic problems) and it's how the slab accounting works too.
> > 
> > On my test vm the percpu size just after boot decreased from 7680 kB
> > to 7488 kB and the number of chunk decreased by 1. It's not a big win,
> > however on production machines with many chunks the win will be likely
> > bigger.
> 
> Overall I'm fine with this approach. I would like to see some production
> numbers to better understand the # of memcg aware chunks vs not as well
> as overtime how does that evolve? I suspect that over time non-memcg
> aware chunks will be converted and most chunks will be memcg aware after
> some period of time.

Just looked at a random host in our production: there are 20 chunks (including
the reserved), 6 are !memcg aware, 14 are memcg aware.

This is how free bytes are distributed:
  free_bytes          :         8092      memcg_aware         :            0
  free_bytes          :        12708	  memcg_aware         :            0
  free_bytes          :            0	  memcg_aware         :            0
  free_bytes          :         2320	  memcg_aware         :            0
  free_bytes          :        13272	  memcg_aware         :            0
  free_bytes          :       131944	  memcg_aware         :            0
  free_bytes          :        20880	  memcg_aware         :            1
  free_bytes          :        12536	  memcg_aware         :            1
  free_bytes          :        10088	  memcg_aware         :            1
  free_bytes          :        10080	  memcg_aware         :            1
  free_bytes          :         2904	  memcg_aware         :            1
  free_bytes          :        16176	  memcg_aware         :            1
  free_bytes          :        15440	  memcg_aware         :            1
  free_bytes          :         5280	  memcg_aware         :            1
  free_bytes          :       145864	  memcg_aware         :            1
  free_bytes          :       248800	  memcg_aware         :            1
  free_bytes          :       256240	  memcg_aware         :            1
  free_bytes          :       259664	  memcg_aware         :            1
  free_bytes          :       256240	  memcg_aware         :            1
  free_bytes          :       262144	  memcg_aware         :            1

> 
> If the numbers aren't compelling, let's just allocate all chunks to be
> memcg aware.

This is an option too, however this will require some tricks to handle correctly
the first chunk, the case where memcg accounting is disabled via a boot option,
etc. On-demand allocation is just simpler IMO.

> 
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  mm/percpu-internal.h |  52 +------------
> >  mm/percpu-km.c       |   5 +-
> >  mm/percpu-stats.c    |  45 ++++-------
> >  mm/percpu-vm.c       |  11 ++-
> >  mm/percpu.c          | 180 ++++++++++++++++++-------------------------
> >  5 files changed, 98 insertions(+), 195 deletions(-)
> > 
> > diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> > index 10604dce806f..b6dc22904088 100644
> > --- a/mm/percpu-internal.h
> > +++ b/mm/percpu-internal.h
> > @@ -5,25 +5,6 @@
> >  #include <linux/types.h>
> >  #include <linux/percpu.h>
> >  
> > -/*
> > - * There are two chunk types: root and memcg-aware.
> > - * Chunks of each type have separate slots list.
> > - *
> > - * Memcg-aware chunks have an attached vector of obj_cgroup pointers, which is
> > - * used to store memcg membership data of a percpu object.  Obj_cgroups are
> > - * ref-counted pointers to a memory cgroup with an ability to switch dynamically
> > - * to the parent memory cgroup.  This allows to reclaim a deleted memory cgroup
> > - * without reclaiming of all outstanding objects, which hold a reference at it.
> > - */
> > -enum pcpu_chunk_type {
> > -	PCPU_CHUNK_ROOT,
> > -#ifdef CONFIG_MEMCG_KMEM
> > -	PCPU_CHUNK_MEMCG,
> > -#endif
> > -	PCPU_NR_CHUNK_TYPES,
> > -	PCPU_FAIL_ALLOC = PCPU_NR_CHUNK_TYPES
> > -};
> > -
> >  /*
> >   * pcpu_block_md is the metadata block struct.
> >   * Each chunk's bitmap is split into a number of full blocks.
> > @@ -91,7 +72,7 @@ extern struct list_head *pcpu_chunk_lists;
> >  extern int pcpu_nr_slots;
> >  extern int pcpu_sidelined_slot;
> >  extern int pcpu_to_depopulate_slot;
> > -extern int pcpu_nr_empty_pop_pages[];
> > +extern int pcpu_nr_empty_pop_pages;
> >  
> >  extern struct pcpu_chunk *pcpu_first_chunk;
> >  extern struct pcpu_chunk *pcpu_reserved_chunk;
> > @@ -132,37 +113,6 @@ static inline int pcpu_chunk_map_bits(struct pcpu_chunk *chunk)
> >  	return pcpu_nr_pages_to_map_bits(chunk->nr_pages);
> >  }
> >  
> > -#ifdef CONFIG_MEMCG_KMEM
> > -static inline enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
> > -{
> > -	if (chunk->obj_cgroups)
> > -		return PCPU_CHUNK_MEMCG;
> > -	return PCPU_CHUNK_ROOT;
> > -}
> > -
> > -static inline bool pcpu_is_memcg_chunk(enum pcpu_chunk_type chunk_type)
> > -{
> > -	return chunk_type == PCPU_CHUNK_MEMCG;
> > -}
> > -
> > -#else
> > -static inline enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
> > -{
> > -	return PCPU_CHUNK_ROOT;
> > -}
> > -
> > -static inline bool pcpu_is_memcg_chunk(enum pcpu_chunk_type chunk_type)
> > -{
> > -	return false;
> > -}
> > -#endif
> > -
> > -static inline struct list_head *pcpu_chunk_list(enum pcpu_chunk_type chunk_type)
> > -{
> > -	return &pcpu_chunk_lists[pcpu_nr_slots *
> > -				 pcpu_is_memcg_chunk(chunk_type)];
> > -}
> > -
> >  #ifdef CONFIG_PERCPU_STATS
> >  
> >  #include <linux/spinlock.h>
> > diff --git a/mm/percpu-km.c b/mm/percpu-km.c
> > index c84a9f781a6c..c9d529dc7651 100644
> > --- a/mm/percpu-km.c
> > +++ b/mm/percpu-km.c
> > @@ -44,8 +44,7 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
> >  	/* nada */
> >  }
> >  
> > -static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
> > -					    gfp_t gfp)
> > +static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
> >  {
> >  	const int nr_pages = pcpu_group_sizes[0] >> PAGE_SHIFT;
> >  	struct pcpu_chunk *chunk;
> > @@ -53,7 +52,7 @@ static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
> >  	unsigned long flags;
> >  	int i;
> >  
> > -	chunk = pcpu_alloc_chunk(type, gfp);
> > +	chunk = pcpu_alloc_chunk(gfp);
> >  	if (!chunk)
> >  		return NULL;
> >  
> > diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
> > index 2125981acfb9..7103515525e9 100644
> > --- a/mm/percpu-stats.c
> > +++ b/mm/percpu-stats.c
> > @@ -34,15 +34,11 @@ static int find_max_nr_alloc(void)
> >  {
> >  	struct pcpu_chunk *chunk;
> >  	int slot, max_nr_alloc;
> > -	enum pcpu_chunk_type type;
> >  
> >  	max_nr_alloc = 0;
> > -	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
> > -		for (slot = 0; slot < pcpu_nr_slots; slot++)
> > -			list_for_each_entry(chunk, &pcpu_chunk_list(type)[slot],
> > -					    list)
> > -				max_nr_alloc = max(max_nr_alloc,
> > -						   chunk->nr_alloc);
> > +	for (slot = 0; slot < pcpu_nr_slots; slot++)
> > +		list_for_each_entry(chunk, &pcpu_chunk_lists[slot], list)
> > +			max_nr_alloc = max(max_nr_alloc, chunk->nr_alloc);
> >  
> >  	return max_nr_alloc;
> >  }
> > @@ -134,7 +130,7 @@ static void chunk_map_stats(struct seq_file *m, struct pcpu_chunk *chunk,
> >  	P("cur_med_alloc", cur_med_alloc);
> >  	P("cur_max_alloc", cur_max_alloc);
> >  #ifdef CONFIG_MEMCG_KMEM
> > -	P("memcg_aware", pcpu_is_memcg_chunk(pcpu_chunk_type(chunk)));
> > +	P("memcg_aware", !!chunk->obj_cgroups);
> >  #endif
> >  	seq_putc(m, '\n');
> >  }
> > @@ -144,8 +140,6 @@ static int percpu_stats_show(struct seq_file *m, void *v)
> >  	struct pcpu_chunk *chunk;
> >  	int slot, max_nr_alloc;
> >  	int *buffer;
> > -	enum pcpu_chunk_type type;
> > -	int nr_empty_pop_pages;
> >  
> >  alloc_buffer:
> >  	spin_lock_irq(&pcpu_lock);
> > @@ -166,10 +160,6 @@ static int percpu_stats_show(struct seq_file *m, void *v)
> >  		goto alloc_buffer;
> >  	}
> >  
> > -	nr_empty_pop_pages = 0;
> > -	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
> > -		nr_empty_pop_pages += pcpu_nr_empty_pop_pages[type];
> > -
> >  #define PL(X)								\
> >  	seq_printf(m, "  %-20s: %12lld\n", #X, (long long int)pcpu_stats_ai.X)
> >  
> > @@ -201,7 +191,7 @@ static int percpu_stats_show(struct seq_file *m, void *v)
> >  	PU(nr_max_chunks);
> >  	PU(min_alloc_size);
> >  	PU(max_alloc_size);
> > -	P("empty_pop_pages", nr_empty_pop_pages);
> > +	P("empty_pop_pages", pcpu_nr_empty_pop_pages);
> >  	seq_putc(m, '\n');
> >  
> >  #undef PU
> > @@ -215,20 +205,17 @@ static int percpu_stats_show(struct seq_file *m, void *v)
> >  		chunk_map_stats(m, pcpu_reserved_chunk, buffer);
> >  	}
> >  
> > -	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++) {
> > -		for (slot = 0; slot < pcpu_nr_slots; slot++) {
> > -			list_for_each_entry(chunk, &pcpu_chunk_list(type)[slot],
> > -					    list) {
> > -				if (chunk == pcpu_first_chunk)
> > -					seq_puts(m, "Chunk: <- First Chunk\n");
> > -				else if (slot == pcpu_to_depopulate_slot)
> > -					seq_puts(m, "Chunk (to_depopulate)\n");
> > -				else if (slot == pcpu_sidelined_slot)
> > -					seq_puts(m, "Chunk (sidelined):\n");
> > -				else
> > -					seq_puts(m, "Chunk:\n");
> > -				chunk_map_stats(m, chunk, buffer);
> > -			}
> > +	for (slot = 0; slot < pcpu_nr_slots; slot++) {
> > +		list_for_each_entry(chunk, &pcpu_chunk_lists[slot], list) {
> > +			if (chunk == pcpu_first_chunk)
> > +				seq_puts(m, "Chunk: <- First Chunk\n");
> > +			else if (slot == pcpu_to_depopulate_slot)
> > +				seq_puts(m, "Chunk (to_depopulate)\n");
> > +			else if (slot == pcpu_sidelined_slot)
> > +				seq_puts(m, "Chunk (sidelined):\n");
> > +			else
> > +				seq_puts(m, "Chunk:\n");
> > +			chunk_map_stats(m, chunk, buffer);
> >  		}
> >  	}
> >  
> > diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> > index c75f6f24f2d5..e59566b949d1 100644
> > --- a/mm/percpu-vm.c
> > +++ b/mm/percpu-vm.c
> > @@ -328,13 +328,12 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
> >  	pcpu_free_pages(chunk, pages, page_start, page_end);
> >  }
> >  
> > -static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
> > -					    gfp_t gfp)
> > +static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
> >  {
> >  	struct pcpu_chunk *chunk;
> >  	struct vm_struct **vms;
> >  
> > -	chunk = pcpu_alloc_chunk(type, gfp);
> > +	chunk = pcpu_alloc_chunk(gfp);
> >  	if (!chunk)
> >  		return NULL;
> >  
> > @@ -403,7 +402,7 @@ static bool pcpu_should_reclaim_chunk(struct pcpu_chunk *chunk)
> >  	 * chunk, move it to the to_depopulate list.
> >  	 */
> >  	return ((chunk->isolated && chunk->nr_empty_pop_pages) ||
> > -		(pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >
> > -		 PCPU_EMPTY_POP_PAGES_HIGH + chunk->nr_empty_pop_pages &&
> > -		chunk->nr_empty_pop_pages >= chunk->nr_pages / 4));
> > +		(pcpu_nr_empty_pop_pages > PCPU_EMPTY_POP_PAGES_HIGH +
> > +		 chunk->nr_empty_pop_pages &&
> > +		 chunk->nr_empty_pop_pages >= chunk->nr_pages / 4));
> >  }
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 79eebc80860d..09624d920dc5 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -179,10 +179,10 @@ struct list_head *pcpu_chunk_lists __ro_after_init; /* chunk list slots */
> >  static LIST_HEAD(pcpu_map_extend_chunks);
> >  
> >  /*
> > - * The number of empty populated pages by chunk type, protected by pcpu_lock.
> > + * The number of empty populated pages, protected by pcpu_lock.
> >   * The reserved chunk doesn't contribute to the count.
> >   */
> > -int pcpu_nr_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
> > +int pcpu_nr_empty_pop_pages;
> >  
> >  /*
> >   * The number of populated pages in use by the allocator, protected by
> > @@ -532,13 +532,10 @@ static void __pcpu_chunk_move(struct pcpu_chunk *chunk, int slot,
> >  			      bool move_front)
> >  {
> >  	if (chunk != pcpu_reserved_chunk) {
> > -		struct list_head *pcpu_slot;
> > -
> > -		pcpu_slot = pcpu_chunk_list(pcpu_chunk_type(chunk));
> >  		if (move_front)
> > -			list_move(&chunk->list, &pcpu_slot[slot]);
> > +			list_move(&chunk->list, &pcpu_chunk_lists[slot]);
> >  		else
> > -			list_move_tail(&chunk->list, &pcpu_slot[slot]);
> > +			list_move_tail(&chunk->list, &pcpu_chunk_lists[slot]);
> >  	}
> >  }
> >  
> > @@ -574,27 +571,22 @@ static void pcpu_chunk_relocate(struct pcpu_chunk *chunk, int oslot)
> >  
> >  static void pcpu_isolate_chunk(struct pcpu_chunk *chunk)
> >  {
> > -	enum pcpu_chunk_type type = pcpu_chunk_type(chunk);
> > -	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> > -
> >  	lockdep_assert_held(&pcpu_lock);
> >  
> >  	if (!chunk->isolated) {
> >  		chunk->isolated = true;
> > -		pcpu_nr_empty_pop_pages[type] -= chunk->nr_empty_pop_pages;
> > +		pcpu_nr_empty_pop_pages -= chunk->nr_empty_pop_pages;
> >  	}
> > -	list_move(&chunk->list, &pcpu_slot[pcpu_to_depopulate_slot]);
> > +	list_move(&chunk->list, &pcpu_chunk_lists[pcpu_to_depopulate_slot]);
> >  }
> >  
> >  static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
> >  {
> > -	enum pcpu_chunk_type type = pcpu_chunk_type(chunk);
> > -
> >  	lockdep_assert_held(&pcpu_lock);
> >  
> >  	if (chunk->isolated) {
> >  		chunk->isolated = false;
> > -		pcpu_nr_empty_pop_pages[type] += chunk->nr_empty_pop_pages;
> > +		pcpu_nr_empty_pop_pages += chunk->nr_empty_pop_pages;
> >  		pcpu_chunk_relocate(chunk, -1);
> >  	}
> >  }
> > @@ -612,7 +604,7 @@ static inline void pcpu_update_empty_pages(struct pcpu_chunk *chunk, int nr)
> >  {
> >  	chunk->nr_empty_pop_pages += nr;
> >  	if (chunk != pcpu_reserved_chunk && !chunk->isolated)
> > -		pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] += nr;
> > +		pcpu_nr_empty_pop_pages += nr;
> >  }
> >  
> >  /*
> > @@ -1447,7 +1439,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
> >  	return chunk;
> >  }
> >  
> > -static struct pcpu_chunk *pcpu_alloc_chunk(enum pcpu_chunk_type type, gfp_t gfp)
> > +static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
> >  {
> >  	struct pcpu_chunk *chunk;
> >  	int region_bits;
> > @@ -1475,16 +1467,6 @@ static struct pcpu_chunk *pcpu_alloc_chunk(enum pcpu_chunk_type type, gfp_t gfp)
> >  	if (!chunk->md_blocks)
> >  		goto md_blocks_fail;
> >  
> > -#ifdef CONFIG_MEMCG_KMEM
> > -	if (pcpu_is_memcg_chunk(type)) {
> > -		chunk->obj_cgroups =
> > -			pcpu_mem_zalloc(pcpu_chunk_map_bits(chunk) *
> > -					sizeof(struct obj_cgroup *), gfp);
> > -		if (!chunk->obj_cgroups)
> > -			goto objcg_fail;
> > -	}
> > -#endif
> > -
> >  	pcpu_init_md_blocks(chunk);
> >  
> >  	/* init metadata */
> > @@ -1492,10 +1474,6 @@ static struct pcpu_chunk *pcpu_alloc_chunk(enum pcpu_chunk_type type, gfp_t gfp)
> >  
> >  	return chunk;
> >  
> > -#ifdef CONFIG_MEMCG_KMEM
> > -objcg_fail:
> > -	pcpu_mem_free(chunk->md_blocks);
> > -#endif
> >  md_blocks_fail:
> >  	pcpu_mem_free(chunk->bound_map);
> >  bound_map_fail:
> > @@ -1589,8 +1567,7 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
> >  			       int page_start, int page_end, gfp_t gfp);
> >  static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
> >  				  int page_start, int page_end);
> > -static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
> > -					    gfp_t gfp);
> > +static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp);
> >  static void pcpu_destroy_chunk(struct pcpu_chunk *chunk);
> >  static struct page *pcpu_addr_to_page(void *addr);
> >  static int __init pcpu_verify_alloc_info(const struct pcpu_alloc_info *ai);
> > @@ -1633,55 +1610,68 @@ static struct pcpu_chunk *pcpu_chunk_addr_search(void *addr)
> >  }
> >  
> >  #ifdef CONFIG_MEMCG_KMEM
> > -static enum pcpu_chunk_type pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
> > -						     struct obj_cgroup **objcgp)
> > +static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
> > +				      struct obj_cgroup **objcgp)
> >  {
> >  	struct obj_cgroup *objcg;
> >  
> >  	if (!memcg_kmem_enabled() || !(gfp & __GFP_ACCOUNT))
> > -		return PCPU_CHUNK_ROOT;
> > +		return true;
> >  
> >  	objcg = get_obj_cgroup_from_current();
> >  	if (!objcg)
> > -		return PCPU_CHUNK_ROOT;
> > +		return true;
> >  
> >  	if (obj_cgroup_charge(objcg, gfp, size * num_possible_cpus())) {
> >  		obj_cgroup_put(objcg);
> > -		return PCPU_FAIL_ALLOC;
> > +		return false;
> >  	}
> >  
> >  	*objcgp = objcg;
> > -	return PCPU_CHUNK_MEMCG;
> > +	return true;
> >  }
> >  
> >  static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
> >  				       struct pcpu_chunk *chunk, int off,
> > -				       size_t size)
> > +				       size_t size, gfp_t gfp)
> >  {
> >  	if (!objcg)
> >  		return;
> >  
> > -	if (chunk) {
> > -		chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = objcg;
> > +	if (!chunk)
> > +		goto cancel_charge;
> >  
> > -		rcu_read_lock();
> > -		mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
> > -				size * num_possible_cpus());
> > -		rcu_read_unlock();
> > -	} else {
> > -		obj_cgroup_uncharge(objcg, size * num_possible_cpus());
> > -		obj_cgroup_put(objcg);
> > +	if (!chunk->obj_cgroups) {
> > +		chunk->obj_cgroups = pcpu_mem_zalloc(pcpu_chunk_map_bits(chunk) *
> > +						     sizeof(struct obj_cgroup *), gfp);
> 
> Percpu does some weird things with gfp flags. This might need to be
> fixed if we don't always pre-allocate this for our definition of atomic.
> I haven't thought too much about this just yet as seem my thoughts
> above.

Yeah, I thought about it, but it seems that passing gfp here is ok.
Or at least I don't see any specific problem. If you do, please, let me know.

Thanks!
