Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410763801AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 04:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhENCBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 22:01:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46438 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhENCBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 22:01:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14E1x6te166672;
        Fri, 14 May 2021 01:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=YzDi9dB4xZRPO7YlSkBxl59p4+K3FgxAoQlKABC61rw=;
 b=t2YPrqMa9O5P+fQL/phmosOvO9458E5CcAVd1thVPdzk2YVoXSnrIXPE5Qw9Ig9YHF7R
 gDydRKvmcnfvYXJNHf0LrslZ1wOxL/1eXSm7mXO0NuS/vp2COa5gbRVNP4c8IgCrQw2h
 1w+P5rRxtj5tlhDfxYLQJWOcDCy5+E2MdOLvYtOVr5LPSpAs8aWoxnGkZfx/edmGAolW
 qkajuhIiphq0K9HLnR2owM1zduzX422eFiblvbMaCqmZX7XFNNxb9rqk2XWkbAfuAEnH
 WBn2b1fKmh/NHtPMSQKilmGEisX2y4Dl+8yRh1LENwR2ETp5MzMNYkW0gK//WrnpE+l+ mA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38gpndb6gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 01:59:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14E1tmKe066971;
        Fri, 14 May 2021 01:59:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3030.oracle.com with ESMTP id 38gpq2kmch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 01:59:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXDbw5EVRME/fVzt2ohF4bJ5ZFYQO5wW89yuwLFgUL4duYv9rnaNLob1/l8lAry8uKN/PoVnnER76Vw+E4U7H+SJvvSZKoF4xHOMbaFGDhjebC++Q8r8huqAEGTESCJQqjRZTUnCh4VyHAX0l1wOvFW7YzVZ2SsCUYzjbPe7IEFAHmULtROMnHQKT1HqzSNTyOSEKIsbvd/7Bbh+ozjH9WhMOypGE7/lGBzL/XHpv1C8oZUKIzQosB5EDK047s3wHYiLhW+a5WSZRbw19AE8oLII+RRSor1HguOMstjLeshFx9JNhRCaltxjuvCxlOUFEB97oB0mVyYF5ngNCnNIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzDi9dB4xZRPO7YlSkBxl59p4+K3FgxAoQlKABC61rw=;
 b=aFBLx1e+xr24V7FoDHY0YEIYc8huxacWCKP68kz4KQ6IwZjzM8r0cr1oQLerk4YekM8kKZRqGXJUYHXFOx9aTnfE2I9zK/fCkHXbveTILm462MsWNnKGWvMP4C2IP5dWHzSbZiR79yODNsnmDcbO1AuIRTadrJOxY2KwomHosDTiJ6jWsf608MnjNQnWRLKVg3VVBWNqE8pCfxkn/x0QXuzm9cGhfDJY1EpkXSHJjSSsTEemIb7kZzhl66KCSLcCU7sZGj5tgS+pE4Y8LV5ZKuQfr95I93cxBSpNAByVBfGE5ewah4FXn8vbS0Vvi6VgzpphD4oV+XYdvwryGzKa+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzDi9dB4xZRPO7YlSkBxl59p4+K3FgxAoQlKABC61rw=;
 b=sBMXAL5bDCTexE+4hn4jgBji8gspe3nLUh9NjnwJSOQG/LYHPNrfnGhzzdlUC+L1R80SWaj+3MBPZioB9KJGX3rFMupf4Zv4z5bTKPiXIzwBdWHTWssJFsrHR1SKdupKxETH1ZbNXW+yy+QNAUhuCE0j2R4TKjC/8yurSQs5UP0=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB3605.namprd10.prod.outlook.com (2603:10b6:a03:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 01:59:51 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::144d:392c:6407:169]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::144d:392c:6407:169%5]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 01:59:51 +0000
Date:   Thu, 13 May 2021 21:59:46 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>,
        Paul McKenney <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH] mm, swap: Remove unnecessary smp_rmb() in
 swap_type_to_swap_info()
Message-ID: <20210514015946.nivgnoobef4nqwmw@oracle.com>
References: <20210513064837.3949064-1-ying.huang@intel.com>
 <YJ0fkhuAZ7JnNmEw@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ0fkhuAZ7JnNmEw@hirez.programming.kicks-ass.net>
X-Originating-IP: [98.229.125.203]
X-ClientProxiedBy: BLAPR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:208:329::13) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by BLAPR03CA0068.namprd03.prod.outlook.com (2603:10b6:208:329::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 01:59:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0851b4f-0e8f-4261-ef07-08d9167bf5ac
X-MS-TrafficTypeDiagnostic: BYAPR10MB3605:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3605C153734C974B04DF45CED9509@BYAPR10MB3605.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ZAMw5JER14TtQD6IflW1owQex0XXeXJBXqxvOCLjoX9UnRaJIrZsZ2qnpWgXGgthCc4kY9UTvenUXnqgrcHbgCfMIrK3LPe6rXMY7luY8xlZWykPkXfCsClZhPHEzWjdL2qS2LTTXYTAie2097Jr9M7BjmDf3PfQ+hg3QweEFKXjppx0lKMZhT+mc2+n8wWc+c4HFbxzMuDsWDGdM1gXl3nFUq7LPuDGOwNfyScA7WZNlZBJKJKctTdtm5zR/DU8psuX5h8q4RGj3RXhuizecBWiXOgPHGuCe3uVC3rED8P+IeLZ2fhH6I9SW/G+VaDrUHUe5l+WSvyN8+xgRsB7gEKDzJFp22VkFX5kg78Xc2va5kfLf95XTo6QUXqRtrfhdOrsSc6QP7sivPhGRr03merazbB3Fhwr8n9gnJMmz3r5x2TityXMFAegMoP4lKrWZHRQILie6qYQL8CgZEmWG1dK7P5IFCgDRHK586Osw+7qqrKUQM2irxP6DTm7KJGDnzxA21kNymFkmdKjvS0scFRJJ0BxlajI97Mko2K+3can8vyFFd5jDsJ/9tylv+QkdEh5LITyvWopqxBY4VMrwji2nysi9FW5zMg/wrcYT6c5z4YtlJ6glUVybmnZlLrirhHI/iOaj+7BWhJ+I3qBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(396003)(346002)(136003)(38350700002)(36756003)(38100700002)(4326008)(16526019)(55016002)(186003)(86362001)(83380400001)(7416002)(316002)(54906003)(8936002)(956004)(8676002)(1076003)(5660300002)(8886007)(2616005)(110136005)(6666004)(2906002)(7696005)(52116002)(66556008)(66476007)(66946007)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xeHSQU+p6yBXtt6e1k6ak8FdP+aKKAVkvVxmW81T59Iq6V1Z6kaAywy+Od7T?=
 =?us-ascii?Q?idWjyLda3xMNwJ9FCvFZqDVPXPwQhBhJ7MfsbEMwW8GxllwQPgjDYndIHM0I?=
 =?us-ascii?Q?fNUxFxvbIVztyqt3N3X4AKSotWRGUCfdEtztKoN8zWPO+dcuQBS1yyruZLqM?=
 =?us-ascii?Q?j/wlM5UpmoWGQbfEqMdmh0wPwbDUOGNwfeAPb24IWLHSo9l/TLjW6g4vjCdx?=
 =?us-ascii?Q?ukjzBGC2Tzj12x5OtwAKfvnc4AZc/0EmsNRB9A9TCAxSvdpMtOts2Kr1ar6R?=
 =?us-ascii?Q?Xr1Rp5BumWz6HJZvqSYhTyClJtd0nlLo5KaXf3VyGmbVG/yyW8oUNGA0PM1Y?=
 =?us-ascii?Q?SNPeAsOtK3YkPeyCZ7HwzA2mS/4gNwOo8X0zLJ3rrUEcZpUjex2kqc/zzrUo?=
 =?us-ascii?Q?FKuX8lbiObUCTOjD4jto1J5ax8MolEt+X59wCRUxBOSXm3sp5LhdO9furvSa?=
 =?us-ascii?Q?QIq4wceLlr1X+aCcHaklTyjthZzpl4eWXHWuNhi/uYn+0e4Fv0j/iFPJ9HJZ?=
 =?us-ascii?Q?gZ9pe02gcjcY1adp5aTjHHz7VBM/89jRA/eUVpxYDDVfjMrja1+VKwUQTkhD?=
 =?us-ascii?Q?1VtOPbfWvHnHAQQAWNTMAZgD2DqWsm6ATqKos5ahYKb3LOdJB2HYXJAgaaQr?=
 =?us-ascii?Q?y/Z0ZimU+JuUhjJQJE3suilnjpJjNiRCn5g08n+gK3W4SJ3NXL5/8KlrOvTV?=
 =?us-ascii?Q?5Iby/KEcdRDRxy9j24F0YKaVK6fyvSgGnW65Ge+1VmidPUTpgRu8QVwh1nsQ?=
 =?us-ascii?Q?yUj3DlFFLO4f04mAvWkU3IB4RV8T0NZmrFp2ldhx5YqYYW/sKx/uN6v+snSV?=
 =?us-ascii?Q?AzesYSqE8LP2iAnvgjY+ZthWOzgCkCA6yzqXc2mrUCk4fqC+tjNhU1lF4f5D?=
 =?us-ascii?Q?PjLXirKPy3yW7gPA1vDm7qP0IaWuhifS1S7r/o341/ySmPTTO/6sDERFSEX4?=
 =?us-ascii?Q?vH/F2VDZ5w54CD7m6TZa+WflwihcbhY6hbaXsdaZju5a5F0AaZzKQ4TK5BLS?=
 =?us-ascii?Q?7xPQmm6gNFRY+1XyOpuj52C6LsPo1vW0O9OkbLHuBUnZ5gGJ/FpeMuHr+WoY?=
 =?us-ascii?Q?7A2ZEfXMB2kquzT0WN+sxaWTIUhn1A32tlwJwjrI/En8D9Jxlg4nxZzetfiE?=
 =?us-ascii?Q?XKi1a5rjs2Lpw69ybnz/RtuwLBsyjTcehBgmPgxnUtFziRyTDHy1prIUp9oh?=
 =?us-ascii?Q?MJn/rK5kpcnL1EkscvUPFnnlZlHH+sio21eOScvD9RLqUGypQPd5SIfckaK6?=
 =?us-ascii?Q?Dw4z6BLGzKaHEutqfIn1ILSJ2yrz7YwQDgsoYAUoYBnn7SiyoHz0hKQkj8CS?=
 =?us-ascii?Q?WOq7GKHp2JcjYSW28g7ZsPan?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0851b4f-0e8f-4261-ef07-08d9167bf5ac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 01:59:51.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30yxSkpD6Lqo6dEpCO3N2a2ebSK3RAxX+yNO+DwOGdzxbCU0F3sEjl2zFoz5PCdScURbTnIrfjRMt3r47J4Sfib9uxs2TNLOWOmw2l7tdSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3605
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140011
X-Proofpoint-ORIG-GUID: NOsE_sSOrsZRvLWsmJ2llwNGEr2_RIOv
X-Proofpoint-GUID: NOsE_sSOrsZRvLWsmJ2llwNGEr2_RIOv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140010
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 02:46:10PM +0200, Peter Zijlstra wrote:
> Ah, I think I see what you meant to say, it would perhaps help if you
> write it like so:
> 
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 149e77454e3c..94735248dcd2 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -99,11 +99,10 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
>  
>  static struct swap_info_struct *swap_type_to_swap_info(int type)
>  {
> -	if (type >= READ_ONCE(nr_swapfiles))
> +	if (type >= MAX_SWAPFILES)
>  		return NULL;
>  
> -	smp_rmb();	/* Pairs with smp_wmb in alloc_swap_info. */
> -	return READ_ONCE(swap_info[type]);
> +	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
>  }
>  
>  static inline unsigned char swap_count(unsigned char ent)
> @@ -2869,14 +2868,11 @@ static struct swap_info_struct *alloc_swap_info(void)
>  	}
>  	if (type >= nr_swapfiles) {
>  		p->type = type;
> -		WRITE_ONCE(swap_info[type], p);
>  		/*
> -		 * Write swap_info[type] before nr_swapfiles, in case a
> -		 * racing procfs swap_start() or swap_next() is reading them.
> -		 * (We never shrink nr_swapfiles, we never free this entry.)
> +		 * Publish the swap_info_struct.
>  		 */
> -		smp_wmb();
> -		WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
> +		smp_store_release(&swap_info[type], p); /* rcu_assign_pointer() */
> +		nr_swapfiles++;

Yes, this does help, I didn't understand why smp_wmb stayed around in
the original post.

I think the only access smp_store_release() orders is p->type.  Wouldn't
it be kinda inconsistent to only initialize that one field before
publishing when many others would be done at the end of
alloc_swap_info() after the fact?  p->type doesn't seem special.  For
instance, get_swap_page_of_type() touches si->lock soon after it calls
swap_type_to_swap_info(), so there could be a small window where there's
a non-NULL si with an uninitialized lock.

It's not as if this is likely to be a problem in practice, it would just
make it harder to understand why smp_store_release is there.  Maybe all
we need is a WRITE_ONCE, or if it's really necessary for certain fields
to be set before publication then move them up and explain?
