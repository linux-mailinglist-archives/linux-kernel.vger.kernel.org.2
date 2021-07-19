Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9992C3CEE32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 23:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386668AbhGSUUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 16:20:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:44004 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387290AbhGSUDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 16:03:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="232903263"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="232903263"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 13:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="432247185"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2021 13:43:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 19 Jul 2021 13:43:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 19 Jul 2021 13:43:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 19 Jul 2021 13:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQjShU3MQO+/RHyXRjooN/S1CCXTeVqILbfZRxua99r/D4M56UujORpD07WpcCXfGxwvJJbRALwsr2+s900Za4oSidb3yRSbHXQVMzIXRXPf3bDMbBTaITGT8/KofAjoYLMGvH2icsWVw6SxEestdjPFljVvmrgzNLy34KCp0dtqxm/cqwYzCFqhRkvgcY+KOgDoN208XVK0wInOexYvZRboB9E0HuN36OtXM2NqyNy7T8N+vTCi3IJfpqVcbbx5nWPO8ZfAcnf2ofjOXaSkiXb1AzWCJgnvRtL8y+5ByrfCXPjK3vTN9+zMBRC1V+fRhdRlIJ+e+yVAhdX+rwQKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdG0UIoXcjeGFgIqtzON4DbM2wM0N+FkhOHA0f59aVU=;
 b=n6sLLiXOzZJUGp1lHBu9Cis2+iM9TrtZyvbTvh0fCn9+Y0slGP8GbLBXG7A7CnVDeFV1/bRegVg+rDpj9eZTcNXiU4KvSjUrYdYI38J6uLLvMPnbAiCema18Vm4Wul8XuKi4QqIcgJEnBu6BA0qSodxeXXUe6mhF3JWrK4l5mFKTeofE91TVreat34zn2NCZpnZyqINUPgBrWZJdz62MNeSaFD+TDpkNtzOuguRBxLqPqYA3VBcD8nY6uTsQzndpTU9a/6FAlICPOJ/f9om8wIwFQ6mI3foWqXlsqbu3w0H4vwK7g9k7WWMmRYBd14Y0sscB0hQn8iTvqA+NKZ3yBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdG0UIoXcjeGFgIqtzON4DbM2wM0N+FkhOHA0f59aVU=;
 b=pebDewwcjwUIQQmTnJt07N2CvbPJrqYNMIFjMqVZS2SQ+pxhffGQRVDqRIGxTa1O+WiK41nCt9J0rmS1r/CBqZgExRIJdGj31m1CSZz+hUxGD8C34w1F/HuBKHMDshiyEddYjbHNLYcfVCpRQwK1pQvkvwReR7EsJK/qXlIme/E=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1668.namprd11.prod.outlook.com (2603:10b6:405:10::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Mon, 19 Jul
 2021 20:43:46 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::202f:e602:3983:e631]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::202f:e602:3983:e631%8]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 20:43:46 +0000
Subject: Re: [PATCH] x86/resctrl: Fix default monitoring groups reporting
To:     Babu Moger <babu.moger@amd.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>,
        <pawel.szulik@intel.com>, "Luck, Tony" <tony.luck@intel.com>
References: <162499005859.4842.12410192091197461691.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <27e33283-a18f-bc4a-eedd-1d30907c9efa@intel.com>
Date:   Mon, 19 Jul 2021 13:43:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <162499005859.4842.12410192091197461691.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::15) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.219] (71.238.111.198) by BYAPR07CA0002.namprd07.prod.outlook.com (2603:10b6:a02:bc::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 20:43:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a2cc9f5-1470-4001-1c9f-08d94af5e759
X-MS-TrafficTypeDiagnostic: BN6PR11MB1668:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB1668B6EA04EAC79D79BB5CC1F8E19@BN6PR11MB1668.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TksVq+9D7tb30XH39Slh5D9s+KJaeXRcIicRoFqH3ZwGhDzk1ji/lIJwb13mah6anlffIlKmj3doVaJM4AeX9XE93Rx054MIUQfeADGKyHGhfzEuwUwzF1qL4EmbAdOMBpYd/mwGSWdXy/rs3PsYHd2IusFJX9shrE/EwvlzRb2MamdbOyYvKOY2bLsriy8johOsoKtgOOKIlniEvBmFTVDwgt3Z+j/5fkhHrHvUCdENFetdoIkFMzOILJSt+b5cIFaeP8h6PYRv7zvvAKy4yA5yTXcgEFEItKaJSfDp3teaHMOdfXuOgP9naZe/GljO34BHoBleHDsX/nOQIa7h8jXQPz7DlAWu3mXQKnIrjk6U6W39UvIIvWOgo69BxyIFo5kDq84n21BMrv5yYmOjEEVfAkJs0/hdRHQu5v44oLGBTkToRd6pDMidHIFFc+Ay/3u9E++iR3Q0j3K8Y3N2tfynmg3QHNNM5g93I1fi7OCrxqi8+YT1tfyA1uKE/92+B74MG6id/vWGqxutDsAwIxajFTbRFuklSBj6juiDfdyE08z/qCfsRovb3g9GiuEKtSRm4NWoG8GJC6DphcmIS2HocV5XJFe9+BtYRgcXPE8Wouo10LmRDYipvNV3E1w0PZ4AtoZVwHlgk0EIFvKYY+JKhE7HLIyBOKlJ0zkIq5mvS5f3yAeZGP44RNh6MRoDQS93wAX2jLoBa8TXh9ep8TAnNIJuE3e58G2GZd05eEHopz/Z0tsuB8+oMLNlnpUu27tVPJrQHjK+5StfIvvtEw1EP4CZQ/on7XZC4B8Qrf98HAbmrvNTogY2r6Ix/ntG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(38100700002)(16576012)(316002)(186003)(86362001)(53546011)(26005)(36756003)(31696002)(8676002)(6486002)(44832011)(107886003)(66946007)(31686004)(966005)(5660300002)(4326008)(8936002)(66556008)(66476007)(2906002)(83380400001)(478600001)(2616005)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFRFb3NWT0daeGVmeEZMSG1zUnJwNlRtZWsxdkxzZGlvVnBqTG4rSURBODhX?=
 =?utf-8?B?K3U3U05GdloxV0JDWEdSQ0h6dHl0MCt3ZVhZNUQ1MFVleno0OW9DdUU3cUl3?=
 =?utf-8?B?eUJNTlgvai9yVDEzanQxMGs1M1o5NHNLUHRvYWh0SThNRWROQWd1ZHVrL3VT?=
 =?utf-8?B?a2U4ZlBDRVgvb3dBdGorVXI5YmZ1NW5xVnZ4S25UVHN0WlRiakNRamQ3azMw?=
 =?utf-8?B?UGEvcmNIZFB4ZWJtdXEvT2dmMmRXeDR6eGprZVNpT21hWHlxazVYK2hvTzJm?=
 =?utf-8?B?cHRha3lEdnZaVWU2TlpGVi90TzZianBRdXc4cTlBdG16THdLbWFpZ1BkcTJ1?=
 =?utf-8?B?dTRleGxlYVIydGNCOGVPU3RHOVRObDVMbGFnb25Xcld0QnlQTERTc3ppN0hJ?=
 =?utf-8?B?WUd4QU5jNW1rWUY3OUlHNTI5SnEyUXoraVB6V0t4cWZrbTEzZi82KzNiamN4?=
 =?utf-8?B?N2syTzhuMlE0bUVZVU50VTJpRkxDV2FNRnVUaUsrUUNLNmxGVVpwdThoM0tr?=
 =?utf-8?B?UllaYnVyc1ZidnpPRmZqdVQ5ZGpDZEhWdEZjaEM3b1JjS0tzM0Exd1ZUaitG?=
 =?utf-8?B?blY3YmtLdFIzYkR3VVpXdXozeWtkWVAvYVJZdlRNVSs2dEc0Ykd4SW41L0Vi?=
 =?utf-8?B?WHBUVU5mSzdBZXpmYVM0dWlYU0xtN1F3YmVxMVZtQ3A0NzdNUWh4bW1hWWJ5?=
 =?utf-8?B?TXM1MENIVEh5YTE3ZjEwaStpNGNyeVZNSkRYcWRFNTRWWFlKb0VrOElSanZM?=
 =?utf-8?B?R3lIb1c4SnNrbk9xZFg5ZFJZS2tab0NlRThpdGRlZGd0Nms5N0RtL2swNm05?=
 =?utf-8?B?dit3d1VHM1hrc2hYSUFDdnlEMmFrRkFPZDlPam9UTkNJZGZkU2syVCtZU0Z3?=
 =?utf-8?B?RmpXaUt3eDI1SnBpQnhsdmJ4cjRvNkJDdXBKMGRjWDZFRlBlSXlJR0g2aUtu?=
 =?utf-8?B?M3RQOXM0cVYyTm9rZnh0VU1aeDJBbUFwQ3lhajBvQnlxUXpVaTk0bStjOTFX?=
 =?utf-8?B?WXpoRzFWdHRhRW82VDVjWHVPcDVkM1IrcXRmK1BIb2p0cjNBMm9IOFVMSzc2?=
 =?utf-8?B?NGtwK3dTZjQ4TXNYNjVqVWJYcnJDSG4vaEhKR0N0R1pseERJYUZsMllvZXB1?=
 =?utf-8?B?ZllMcmJ4ZVFpeTRBUjZFOElPR0dxQkplRXlFVXVsc2JaY0dDTUx2UGptcGl5?=
 =?utf-8?B?Q1B2bWx4Q0NoUmNKZ3huT2NwY2U3ZFhsbm1NWEhQTUlJYkJCR1ZKdDJNblpW?=
 =?utf-8?B?YkVadHNQcmtZUTg1UWE0NUZXYnlpU25TZ0xtYkVNYmEwWnFMcEJSZHYrdGZS?=
 =?utf-8?B?MDRubW51TzBTTGkzMHFzblJxdC9Qa2lDdVlDczM5N1E0VmhiMmZEcUxuWWdC?=
 =?utf-8?B?eG93R1hzUU55bFdrRDltZTdGQ0xpZ1ZyOU05Q0tvaFJtWnFNM2E5YVpMMnVN?=
 =?utf-8?B?eklsQ2ljNXFTSVJaanVudDZ6MUU4b2RSZXp1RUt5NnRibHBzVi9BUGplcHhD?=
 =?utf-8?B?MWF1MUVJZWYyRjRqNnJkSmR1djRQUFNHMDdJNjM1ZkV4UG12eHEzRUYzRzJR?=
 =?utf-8?B?dW9yK2pCOEhId0t0enZjNjVWZFlWSkNtTXFWMFordkZOUFlINTI1OXl6S1VB?=
 =?utf-8?B?dEo0enc0ZXBESHd3c2FkV1NSa2lGR2dyMUFnZitQR2hoL1djMWVzMEdESk9y?=
 =?utf-8?B?cExPOHJlbXcyY3pZeU9uc0ZQeVE5UkZrOVVTendESWczUzVnN3RBY2ZNQ0JK?=
 =?utf-8?Q?rPaRhRPpIGGn3B8f5wrXdBzwcQZY1CVC7NbTzus?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2cc9f5-1470-4001-1c9f-08d94af5e759
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 20:43:46.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BegyHIcygtgS3U8anlyBLxNkd/j/D7+iUh3ovRPeZL+lKvW2rJwgE5TpMNe345diq2oj3PZUU/pIVMC6O4QyHzT6/fbeUkHxRHXdnpATfNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1668
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 6/29/2021 11:07 AM, Babu Moger wrote:
> From: Babu Moger <Babu.Moger@amd.com>
> 
> Creating a new sub monitoring group in the root /sys/fs/resctrl leads to
> getting the "Unavailable" value for mbm_total_bytes and mbm_local_bytes on
> the entire filesystem.
> 
> Steps to reproduce.
> 1. #mount -t resctrl resctrl /sys/fs/resctrl/
> 
> 2. #cd /sys/fs/resctrl/
> 
> 3. #cat mon_data/mon_L3_00/mbm_total_bytes 23189832
> 
> 4. #mkdir mon_groups/test1 (create sub monitor group)
> 
> 5. #cat mon_data/mon_L3_00/mbm_total_bytes Unavailable
> 
> When a new monitoring group is created, a new RMID is assigned to the new
> group. But the RMID is not active yet. When the events are read on the new
> RMID, it is expected to report the status as "Unavailable".
> 
> When the user reads the events on the default monitoring group with
> multiple subgroups, the events on all sub groups are consolidated together.
> Currently, if any of the RMID reads report as "Unavailable", then
> everything will be reported as "Unavailable".
> 
> Fix the issue by discarding the "Unavailable" reads and reporting all the
> successful RMID reads. This is not a problem on Intel systesm as Intel

systesm -> systems

> reports 0 on Inactive RMIDs.
> 
> Reported-by: Paweł Szulik <pawel.szulik@intel.com>
> Signed-off-by: Babu Moger <Babu.Moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=213311

Is a "Fixes" available? If this is specific to AMD then could this be 
the change that enabled AMD systems?

> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c |   27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index dbeaa8409313..9573a30c0587 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -285,15 +285,14 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>   	return chunks >>= shift;
>   }
>   
> -static int __mon_event_count(u32 rmid, struct rmid_read *rr)
> +static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>   {
>   	struct mbm_state *m;
>   	u64 chunks, tval;
>   
>   	tval = __rmid_read(rmid, rr->evtid);
>   	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
> -		rr->val = tval;
> -		return -EINVAL;
> +		return tval;
>   	}
>   	switch (rr->evtid) {
>   	case QOS_L3_OCCUP_EVENT_ID:
> @@ -305,12 +304,6 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>   	case QOS_L3_MBM_LOCAL_EVENT_ID:
>   		m = &rr->d->mbm_local[rmid];
>   		break;
> -	default:
> -		/*
> -		 * Code would never reach here because
> -		 * an invalid event id would fail the __rmid_read.
> -		 */
> -		return -EINVAL;
>   	}
>   
>   	if (rr->first) {
> @@ -361,23 +354,29 @@ void mon_event_count(void *info)
>   	struct rdtgroup *rdtgrp, *entry;
>   	struct rmid_read *rr = info;
>   	struct list_head *head;
> +	u64 ret_val;
>   
>   	rdtgrp = rr->rgrp;
>   
> -	if (__mon_event_count(rdtgrp->mon.rmid, rr))
> -		return;
> +	ret_val = __mon_event_count(rdtgrp->mon.rmid, rr);
>   
>   	/*
> -	 * For Ctrl groups read data from child monitor groups.
> +	 * For Ctrl groups read data from child monitor groups and
> +	 * add them together. Count events which are read successfully.
> +	 * Discard the rmid_read's reporting errors.
>   	 */
>   	head = &rdtgrp->mon.crdtgrp_list;
>   
>   	if (rdtgrp->type == RDTCTRL_GROUP) {
>   		list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -			if (__mon_event_count(entry->mon.rmid, rr))
> -				return;
> +			if (__mon_event_count(entry->mon.rmid, rr) == 0)
> +				ret_val = 0;
>   		}
>   	}
> +
> +	/* Report error if none of rmid_reads are successful */
> +	if (ret_val)
> +		rr->val = ret_val;
>   }
>   
>   /*
> 

With the commit message comments addressed:
Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you very much

Reinette
