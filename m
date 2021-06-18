Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745563ACF5B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhFRPo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:44:59 -0400
Received: from mail-mw2nam12on2040.outbound.protection.outlook.com ([40.107.244.40]:15937
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230334AbhFRPo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwInXN4VIkwYfBq6bYZ3ORnP2etf4yPVSFPO+7iOrdb0W0EGFe5gdZTpCSl+6j267ZloyCt9K2mXEFZ6kvToLQhuUYNbSL8AKl3f+hRrj8+8dmwkJevYNKmg7t8713XHGcivGUIPidM8tSSdoFgzyOfRWPbqWArp/r2WnaI7Kf+reOmbo0IwnDJLlu0qiBx7ALf4FWrmvO+2zne4rqI7T3OXcHfbKUCCl3SsWVHkYjo6uRYxFKQQflNfT2vWb/EAF6nDt0YFxC/3mkJuOuheZEhhgtjbCZj3+OtXzJOE3zwelUnSDM8LQDEbjSNi2vvZfFV/Wb/1F+c2SqKzTtu9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfXCp3Bssy8ppPnIoHYo2bN09CEqEFmctpfg0RYrrPU=;
 b=BdUqf1sVrPRK+MbAhOVVro3X8uqdpN7OISTQPRHyKgb2x9eLItFge8qvBbGz6F1+/b3c6tsLjtspjUTwFyVNCsd6BZhOzrkmd4EQjtDTLBer15Vp6CG9aSP3XGY4713jTNW6XCASAVHULf/ESTsCx/hRN/u0TSnG23hZygDgN3m0M1M8BXSi8KAXfv+fhPLPfaHGIjYCyMFpGFDyhDQkwrRt+sKgIIkLFRKsM/ZMzw6LleDmI0V56Fy8KOf4fBGEuRmt4oBTE3TT38D3o7clBADRYi4XqH45lMt2G1RKudMOQcPApC/cfftbKYLRQbpTTgGR+HAedf5aOjAYFSyj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfXCp3Bssy8ppPnIoHYo2bN09CEqEFmctpfg0RYrrPU=;
 b=R59VqC+vPVUc2hyzp+RntwQPBFU1pqLo3lTooHoG4JuMaGSce+EiP0XFqWcMaEa12Dh5B0nbl8pW+DW88B8dxQhwoyMSym2EWzh43IF+jVotU3D+vW7t9stqMpTWLgzaMRcRB8dopnsKC/0A4l5hiBhv5EZyEgjp0hf384FCObMUhTc2JTGXEdyujm8PhIp0L5uhNhjJROsqbXsHzVIm2bQyN8wgF2h/VyQj6E0pNcYUjNTS4HrjfQWjfGcjV+GehYwUlEGT8o6AqN5G4kGGRuWxc/+egeQwXJGNVyJjwMps0mCJME3lXQVTaTidoX+ub5Yzb0RJKVtb6GrqiGejTg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB4721.namprd12.prod.outlook.com (2603:10b6:208:8e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 15:42:47 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 15:42:47 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        osalvador <osalvador@suse.de>
Subject: Re: [PATCH -V8 05/10] mm/migrate: demote pages during reclaim
Date:   Fri, 18 Jun 2021 11:42:41 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <88CFDFA7-70E1-4C26-B9CF-7A0CEFEB035A@nvidia.com>
In-Reply-To: <20210618061537.434999-6-ying.huang@intel.com>
References: <20210618061537.434999-1-ying.huang@intel.com>
 <20210618061537.434999-6-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6AFDC277-2745-4F51-BD00-BF246A3857F8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: BLAP220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::34) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.58.56] (216.228.112.21) by BLAP220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Fri, 18 Jun 2021 15:42:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2436da98-b0de-49c8-55b5-08d9326fb8be
X-MS-TrafficTypeDiagnostic: BL0PR12MB4721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4721DDCBC6055AB6C574EA4AC20D9@BL0PR12MB4721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXLpBHb9v9SCgdXY8bH3wsskDRPC4ZKY1dnc+LaXIJQgV612fjmDvQEn3tHWO/YiPhYHrqddYfiTyOZUtqn24yIrEqSHWLAp7NFvaOiCSNFQGcJJ5LbVvqz2PsdNt5UviHf91lt8rHvjGKcW7avhAhrtIgpk+1UOwzbSCRbYHlbVEFN9L6bwQ7qaSqvq+XCHGvRN3M2TB7YdPoLeS0Qobel9V8a1ordX+Vmr2UX7dV+7f0aYDmT2GSlD+vGRlgdj+W2Qwt9updEOfmO8cwcT3UIgx57gSWbZPgjwb33iDgZJ5U2PJ+EejvECFIQQ3xLtvrY3ZBFP4d8iqcsg5iFmOYyc82yl2/MBLqAZlyKVqE+4Ywae1QjNINq7qFeRidndjtPK9571bYP8j2jwG38Qjl0PIMpGa4Fh34rWeUQLvyUCP3oD4eDQyjxfoYadsa/RLlcKwZPOBhNAPicsQx5aw1EnwvJlRyOyc8k6pJH17U1EtVjcbUB74lMPGp0YHGtLqLYpNufgTVlGDyBW75aLfJQ8eJQ1XWJX5m57yryJ3RbDqxpsgS89vO+qqRkrfUw+6ekFwWnc8GrVX+wma4DiRcBd6XN2Ow8aMCOePEKGyo0r7GpSHutL0sSZtJqXAc6Bj1hV9xFmw7+MBSGaSGMzlVWErk7ytlOhO6eVhNqbGhS6JtqzuajGHRgRbL1PU6zx5nFcWBhh7RkJpI4GwAhtF+vYZD8FXd2z0umjVPBUloGf6ViZTx7Ht5rnUwexqRXBUKxYDDba96IrJxUGfupsAyXjdIJ/H+GsiGNgbOJlF7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(7416002)(235185007)(21480400003)(478600001)(16576012)(316002)(8936002)(33656002)(5660300002)(54906003)(956004)(4326008)(6486002)(2616005)(36756003)(6666004)(8676002)(966005)(38100700002)(2906002)(83380400001)(186003)(66946007)(26005)(16526019)(33964004)(66476007)(66556008)(53546011)(6916009)(86362001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW91RTZBODArOHdvWVVVOWxJZkhhQ2MyMkRQMUE3NkNsNUR4dm1HU0xheEsy?=
 =?utf-8?B?V1ZVTUVRVUhiTERNMWdnT05tc0JJMVYvZlBsN29ZS2hEUldoZldVeWp2STky?=
 =?utf-8?B?aEcyTGs1M0xFaTRtWTl1SnpuT0IrSllVZDJHdENmcXcvNFZIalRaRmg2aUNa?=
 =?utf-8?B?WTJIdUthaHcvWTFPNUtDM1c2RHp3NVptVHRHK1BHR0V4KzBrOXVJdVp4QzQ2?=
 =?utf-8?B?VFlZYklUcmxGWHh6UnpmSXNWalVuTTRoWStXbGlSRlI0OHdtVTZUK1NUaHRM?=
 =?utf-8?B?Mk1VZW9KSG0zUVdObUlMbXRIUkN2UXBhbExoWlFvcVlIRmt5Q25aLzYwRFZr?=
 =?utf-8?B?YlFKSFFHY3lFVCtCakNISTNxNzQyOVhuYmJmWlkzbmhlZWw1R1VIT1RJS2hV?=
 =?utf-8?B?N0lqWVFGS2lZUXlrdCt2SnpNQWhqVCtMOUVlM0hKc28rMGJGOVZSM0lQYUh6?=
 =?utf-8?B?VlNtdml5NkhNT3BRZWZLK2s2MFNpL2Q2cGVJWUJvRURhOUlWYzdGSWxSckxZ?=
 =?utf-8?B?R1FkaCtJWDZ6KzAvbC9obk5ad2RDVkRITmRpL1ZrR0Jkdzh3UmJ2RUxIY3Z4?=
 =?utf-8?B?WnRlVnlNdG93VkFzYVRMQ25NbjFlN1FkSk9YRUM3SEZPMElySU5weExWbmZa?=
 =?utf-8?B?OTgxbElVOTlVNzJDakRvK2RyMkFTS0tTZ24yV2xBR1YwZDVNaFZpemhyNmxt?=
 =?utf-8?B?YjdYS0p4aTYwajVuTGd1dFVGQ2JTRk1EOWhLaHlPWE8vNjNLdnh3UW1heE93?=
 =?utf-8?B?cER1NDB4bDc0eGNGZm1NTXNURFRvVjF2dHcrTWwzY2JoSkFzd2tjSmZFaVNI?=
 =?utf-8?B?c3VYZGM0Z054WDdsUEhOMFQxY2RTOHltcnFYdmtWdGduYndUYk5UaUVRQ2pw?=
 =?utf-8?B?ZzRDTnAvOGFVYjFqcWxoWHhjOHAyMC9ZWldybGJRN2JrMFhJN0hxdGwxVmpM?=
 =?utf-8?B?U2RmK0VSQzdIeWdhZGRXODhpNE1tTXRSSGZ2ZnRBcjRLNk1LTFhkTTEvMHZK?=
 =?utf-8?B?Uk1kaGhoMSswR1VPOGhoWmJpZ0k1STZqQUVzODdFOE0zNHpWWkZrdnYzbFBa?=
 =?utf-8?B?QWxWWDJ6WHAwaVJLcGt3ait3YXQ2K3JBNnNuODJnbitlYk0wL3NseW41NmRZ?=
 =?utf-8?B?OThMZzc2OUZ6RHdadllGV1FscVJTeGZCaGhEY2pPZU9QUDA1VnVxTGZyUDFG?=
 =?utf-8?B?R1B5TXpiQ0ZVTEpsTXBZZGlFU3lIZC9jYzZiQnVZUExQUFNtU0tEQUVWZlVh?=
 =?utf-8?B?dE1XUVlUak83UVNOaStvbDEzMlhmM3RQVXJPV3hhMHZkaDFZbG9oM0Y0UFlI?=
 =?utf-8?B?Slp6Qmc4azJoNU9Rd283V20xd2J1ZGhjVWtFeFNrUFJzQVhMbGdqbWpwa2J6?=
 =?utf-8?B?QkNZN1BzaXFuajVIL2kzc0VPZnIxKzVmVVhDTWlrdWlBT2Q3ZFJXaUNHUHVw?=
 =?utf-8?B?OU1PdWE0aHJQZUg3c1lVU1RJK0RJOXhsb2VTWGpKbXBRai83VktidURFbytj?=
 =?utf-8?B?WG45QzVjSDMzbk8xczVvZWJVUS9JQlZGbVlzSnl5SDlBQ256NVhJTlpLODU5?=
 =?utf-8?B?WVRsTmk4OXg0RjNIV3ByZWlVOG1tZURraGJXRFhmVWk2VzRqZXhXMVFiS2xU?=
 =?utf-8?B?K0NQNjE1WHgvSXRibWMxOGkrYXBudWN6OXlDaHk5dGJWWloyL0JxMWxXemRV?=
 =?utf-8?B?UFVYNkpNWkt1WWVRY0djYjlJWHIxdFpWci9pYTJFamdVZHJnNTZnaGJXaXZO?=
 =?utf-8?Q?eCF3AIcBxcVcdPCpVzj8DScvowc+MKiQOOOadCc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2436da98-b0de-49c8-55b5-08d9326fb8be
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 15:42:47.3914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRwcT6553hyH2Ak6gUTu7h3VY+c7pc++imKL7x+jW5WpI0MhmjtVD54jh8Z8U1PZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4721
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6AFDC277-2745-4F51-BD00-BF246A3857F8_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 18 Jun 2021, at 2:15, Huang Ying wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> This is mostly derived from a patch from Yang Shi:
>
> 	https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-y=
ang.shi@linux.alibaba.com/
>
> Add code to the reclaim path (shrink_page_list()) to "demote" data
> to another NUMA node instead of discarding the data.  This always
> avoids the cost of I/O needed to read the page back in and sometimes
> avoids the writeout cost when the pagee is dirty.
>
> A second pass through shrink_page_list() will be made if any demotions
> fail.  This essentally falls back to normal reclaim behavior in the
> case that demotions fail.  Previous versions of this patch may have
> simply failed to reclaim pages which were eligible for demotion but
> were unable to be demoted in practice.
>
> Note: This just adds the start of infratructure for migration. It is
> actually disabled next to the FIXME in migrate_demote_page_ok().
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: osalvador <osalvador@suse.de>
>
> --
> changes from 20210122:
>  * move from GFP_HIGHUSER -> GFP_HIGHUSER_MOVABLE (Ying)
>
> changes from 202010:
>  * add MR_NUMA_MISPLACED to trace MIGRATE_REASON define
>  * make migrate_demote_page_ok() static, remove 'sc' arg until
>    later patch
>  * remove unnecessary alloc_demote_page() hugetlb warning
>  * Simplify alloc_demote_page() gfp mask.  Depend on
>    __GFP_NORETRY to make it lightweight instead of fancier
>    stuff like leaving out __GFP_IO/FS.
>  * Allocate migration page with alloc_migration_target()
>    instead of allocating directly.
> changes from 20200730:
>  * Add another pass through shrink_page_list() when demotion
>    fails.
> changes from 20210302:
>  * Use __GFP_THISNODE and revise the comment explaining the
>    GFP mask constructionn
> ---
>  include/linux/migrate.h        |  9 ++++
>  include/trace/events/migrate.h |  3 +-
>  mm/vmscan.c                    | 83 ++++++++++++++++++++++++++++++++++=

>  3 files changed, 94 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 4a49bb358787..42952cbe452b 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -28,6 +28,7 @@ enum migrate_reason {
>  	MR_NUMA_MISPLACED,
>  	MR_CONTIG_RANGE,
>  	MR_LONGTERM_PIN,
> +	MR_DEMOTION,
>  	MR_TYPES
>  };
>
> @@ -191,6 +192,14 @@ struct migrate_vma {
>  int migrate_vma_setup(struct migrate_vma *args);
>  void migrate_vma_pages(struct migrate_vma *migrate);
>  void migrate_vma_finalize(struct migrate_vma *migrate);
> +int next_demotion_node(int node);
> +
> +#else /* CONFIG_MIGRATION disabled: */
> +
> +static inline int next_demotion_node(int node)
> +{
> +	return NUMA_NO_NODE;
> +}
>
>  #endif /* CONFIG_MIGRATION */
>
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migr=
ate.h
> index 9fb2a3bbcdfb..779f3fad9ecd 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -21,7 +21,8 @@
>  	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
>  	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
>  	EM( MR_CONTIG_RANGE,	"contig_range")			\
> -	EMe(MR_LONGTERM_PIN,	"longterm_pin")
> +	EM( MR_LONGTERM_PIN,	"longterm_pin")			\
> +	EMe(MR_DEMOTION,	"demotion")
>
>  /*
>   * First define the enums in the above macros to be exported to usersp=
ace
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5199b9696bab..ddda32031f0c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -41,6 +41,7 @@
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
>  #include <linux/memcontrol.h>
> +#include <linux/migrate.h>
>  #include <linux/delayacct.h>
>  #include <linux/sysctl.h>
>  #include <linux/oom.h>
> @@ -1231,6 +1232,23 @@ static enum page_references page_check_reference=
s(struct page *page,
>  	return PAGEREF_RECLAIM;
>  }
>
> +static bool migrate_demote_page_ok(struct page *page)
> +{
> +	int next_nid =3D next_demotion_node(page_to_nid(page));
> +
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	VM_BUG_ON_PAGE(PageHuge(page), page);
> +	VM_BUG_ON_PAGE(PageLRU(page), page);
> +
> +	if (next_nid =3D=3D NUMA_NO_NODE)
> +		return false;
> +	if (PageTransHuge(page) && !thp_migration_supported())
> +		return false;
> +
> +	// FIXME: actually enable this later in the series
> +	return false;
> +}
> +
>  /* Check if a page is dirty or under writeback */
>  static void page_check_dirty_writeback(struct page *page,
>  				       bool *dirty, bool *writeback)
> @@ -1261,6 +1279,47 @@ static void page_check_dirty_writeback(struct pa=
ge *page,
>  		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
>  }
>
> +static struct page *alloc_demote_page(struct page *page, unsigned long=
 node)
> +{
> +	struct migration_target_control mtc =3D {
> +		/*
> +		 * Allocate from 'node', or fail the quickly and quietly.
> +		 * When this happens, 'page; will likely just be discarded
> +		 * instead of migrated.
> +		 */
> +		.gfp_mask =3D (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> +			    __GFP_THISNODE  | __GFP_NOWARN |
> +			    __GFP_NOMEMALLOC | GFP_NOWAIT,
> +		.nid =3D node
> +	};
> +
> +	return alloc_migration_target(page, (unsigned long)&mtc);
> +}
> +
> +/*
> + * Take pages on @demote_list and attempt to demote them to
> + * another node.  Pages which are not demoted are left on
> + * @demote_pages.
> + */
> +static unsigned int demote_page_list(struct list_head *demote_pages,
> +				     struct pglist_data *pgdat,
> +				     struct scan_control *sc)
> +{
> +	int target_nid =3D next_demotion_node(pgdat->node_id);
> +	unsigned int nr_succeeded =3D 0;
> +	int err;
> +
> +	if (list_empty(demote_pages))
> +		return 0;
> +
> +	/* Demotion ignores all cpuset and mempolicy settings */
> +	err =3D migrate_pages(demote_pages, alloc_demote_page, NULL,
> +			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
> +			    &nr_succeeded);
> +
> +	return nr_succeeded;
> +}
> +
>  /*
>   * shrink_page_list() returns the number of reclaimed pages
>   */
> @@ -1272,12 +1331,15 @@ static unsigned int shrink_page_list(struct lis=
t_head *page_list,
>  {
>  	LIST_HEAD(ret_pages);
>  	LIST_HEAD(free_pages);
> +	LIST_HEAD(demote_pages);
>  	unsigned int nr_reclaimed =3D 0;
>  	unsigned int pgactivate =3D 0;
> +	bool do_demote_pass =3D true;
>
>  	memset(stat, 0, sizeof(*stat));
>  	cond_resched();
>
> +retry:
>  	while (!list_empty(page_list)) {
>  		struct address_space *mapping;
>  		struct page *page;
> @@ -1426,6 +1488,16 @@ static unsigned int shrink_page_list(struct list=
_head *page_list,
>  			; /* try to reclaim the page below */
>  		}
>
> +		/*
> +		 * Before reclaiming the page, try to relocate
> +		 * its contents to another node.
> +		 */
> +		if (do_demote_pass && migrate_demote_page_ok(page)) {
> +			list_add(&page->lru, &demote_pages);
> +			unlock_page(page);
> +			continue;
> +		}
> +
>  		/*
>  		 * Anonymous process memory has backing store?
>  		 * Try to allocate it some swap space here.
> @@ -1676,6 +1748,17 @@ static unsigned int shrink_page_list(struct list=
_head *page_list,
>  		list_add(&page->lru, &ret_pages);
>  		VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
>  	}
> +	/* 'page_list' is always empty here */
> +
> +	/* Migrate pages selected for demotion */
> +	nr_reclaimed +=3D demote_page_list(&demote_pages, pgdat, sc);
> +	/* Pages that could not be demoted are still in @demote_pages */
> +	if (!list_empty(&demote_pages)) {
> +		/* Pages which failed to demoted go back on @page_list for retry: */=

> +		list_splice_init(&demote_pages, page_list);
> +		do_demote_pass =3D false;
> +		goto retry;
> +	}
>
>  	pgactivate =3D stat->nr_activate[0] + stat->nr_activate[1];
>
> -- =

> 2.30.2

shrink_page_list() is also used by reclaim_pages(), which is called by
madvise(MADV_PAGEOUT). This patch changes the semantics of madvise(MADV_P=
AGEOUT)
from =E2=80=9Creclaim a given range of pages=E2=80=9D to migrate the give=
n pages to lower
tier memory or reclaim them if the migration fails. You might want to che=
ck
the caller of shrink_page_list() to avoid changing madvise(MADV_PAGEOUT)
semantics.

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_6AFDC277-2745-4F51-BD00-BF246A3857F8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmDMvvEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKb5AP/R0qKv9TLfE49y4DgXUivaNALrez8Laxh4KF
lDzwfM+hib61Dsn2pt+dr7H5CqyPJ0Kbg+T7meHUm6mSm0ipbFR8FtOkZsfsc+Ew
8Ppxt8/nhhOxFnH+iPqyvHoDzoOEyJ21vt2j0urEbuMJucc9hZ3hlbykoE01DbkE
ipraOPMiFeMO6Osbdbnotaey0AshpGGwzVm8InpY8MI0E62Z62t3bBEmaT/g9fGv
tvP5jJv12/45E/odFTN2BYJpbO1KSzKOw8UG3GscArTfIf4JBBcRzUY58K1zItf9
rixkHMRfE+mBoENACoYxvhTxd28g6qTKdxoa6xsFWedK+fXbQ5EhzQ0NyMNnFBYr
UWHyzMd9BTpgEFPhhCCIJcxfhF5NXjASgQWK5iF36muCIBf1srIcr+cLTXOPa2AO
hVwDk2DjEzNODc4QLusZl8QRB6kgOb6jD6X7v/Rj5DxlzTuVlE6z1HQhgPgCitHO
o/hDO6GIJexwMvUKunyJfbDCJWgicVinbqTqvmAkazkaRnJ3rz6rGjNs+ObEVpdS
q6nnT4TpzoyiacQphzUyBl8dOL3bZmQD3WheFnwLvcnuB5y6juoShWUHjDiSW4+j
Yo+/SlYfU8uJaCt0z/Dn6oUHIxgpDIf1b0ctX+15z122RpBb4RQnFbieP3wNsZtT
n/CZafMZ
=CUP0
-----END PGP SIGNATURE-----

--=_MailMate_6AFDC277-2745-4F51-BD00-BF246A3857F8_=--
