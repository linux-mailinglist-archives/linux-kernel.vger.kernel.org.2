Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B049D42FE09
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243299AbhJOWWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:22:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:59839 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238760AbhJOWWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:22:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="227888436"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="227888436"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 15:20:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="481858217"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 15 Oct 2021 15:20:00 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:19:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 15:19:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 15:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq/RdJUCDywr1JuevSItHyEpDL388r0rFOsp4Pha4DJ3fFYUqNG0gAknE1j+V9KcbZYhCwL1BnaLQpjLzuD/6L68j6MeT69jTTbzCxtk/JWjlU+abPyP4thpLkpuHodtIcTo2mC/g0shep7FfpJfuoQ3HyPDeNtxNX7EbCz0qSwddsn5uf72PcJRtesP/blWpnpU6Vc4bx1abkxLDHoxz9wqxX5TcahhVlZFvKmck3x+QgA2Qp3w+i39f1WhBGzime2ojSNYsS8qU/DDfV+KicdqwKmk5eTaJhivm+83smdoBy0cxv0Ob0vY4KRDPKes4TnSYVhkR5FDtRMwYe9WMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOCmZ//p+uAd1KbUDc56QPmWlNYbWC99MfQILfvzQ/8=;
 b=SnZS0+iF3udwKz72XXCsf+Oca/5TV/vjXXIe9762/bN19pj+u62ws5YKJ4IZnkdXtWKhxRh05SKezxQQw+LayPn4oltJK+JsV+ZwwNQei3NnwmRN808pq6A0VICZYVp47Sr/v44lDlSWuCwcAwGLXwisWya6lEVo+19sO+ozrxQwy1S0ifWSvbqU7XB0nvowEfF4vkmuooIvO1vfQlXm9/pfuQA9jbd2lFEMvIcCsmJy9BYzgECjdH8CDt+JdJyTfb3o/jhfIqKsl11ut6CamsjRqQJ2hYp8Z41J+3Xd3pVMKC1qOWRBeMzef26SF/DQwxaJUN6otqxRCv/Y3YG+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOCmZ//p+uAd1KbUDc56QPmWlNYbWC99MfQILfvzQ/8=;
 b=InTDdXxoQziNQcmRpoCZYcYtX296+naodtdyGODYDuYNYKqTLq8V00RkV7cx2tpR52drCizaKQv571+1ECXoCkhb5U2pGTZ+ZGKg0T0F0jB/oTac57xFZ9DZyxbXPzn2w/7seS4z9QWjninNzEGuOhQk9s/suxSmjePD/6NPkko=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1587.namprd11.prod.outlook.com (2603:10b6:405:10::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 22:19:56 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 22:19:56 +0000
Subject: Re: [PATCH v2 05/23] x86/resctrl: Add domain online callback for
 resctrl work
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-6-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <8b414a4d-899b-b784-5b0a-21f1b41349eb@intel.com>
Date:   Fri, 15 Oct 2021 15:19:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211001160302.31189-6-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0012.namprd21.prod.outlook.com
 (2603:10b6:302:1::25) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.3 via Frontend Transport; Fri, 15 Oct 2021 22:19:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b69ddc78-2f38-466f-0b78-08d99029eb02
X-MS-TrafficTypeDiagnostic: BN6PR11MB1587:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB1587DA64E1D8C8694C8A3191F8B99@BN6PR11MB1587.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaz8+ntEl9wi0Hju7/I9giIjswiEJomARCFVVbG4HuI0N/IpP8iHbDejIPGEoEAq+M4Ss6teD5bKlyeBbcuHHPTl5oFuSBYaJkoR4JuAqG6BUTMKgGBPgVYLA9MPYdYI9G+GZ3ez3kZA6dBqhgcCBP+Nysb7JhYMRkN1PZJCsOQ7XsUjIVjHoORlTfb/EnQ1mlXQeJI0sdLWatonLjpi60gM6MeV44GprxOzOQy01CuZ/yX0iBIF5CVqkMbvp84xHaPmqS8+yhHL7ERmttknS5+jXgHHWwDDNaU/Enah5qQgIBpRgsF7DAKj5EDCXQ5+qsUUwZ4tKTiHutzRJuijLgXOOOjbzDw0W/iO48VWFf7krT15Ldmaw2k70ugyhf2j48vntkwqcW11iFeRxS/Gqiazi28cFoy95J1oC2k7XjPvIvylZIsxfXK0oQI/hgdk02kjt6giuEAum12BA3TjO/hug0Idm64YA76m94AweYTUf7W+Ck1mHR6wSAgbpn8/UMdKKGW9j03cKUhq/9pwKjdsBoOjE5B7vZm72v/sLSzHUGCYLLoUiaCp1arp8pRUWwCTQbfF3YF85JHJnmpT1jFBGUiaRkXGc0XhMrq3QMhshR9T/ULrwm3zfYRz1TwZS2S0u6L1KwJnYw/pQSOdPby//X1myetrZbyU26LPdU/TBMGpxJmlV9lFsQdIQGdSH8Sxv8hth6t3u7Vd0hloQm1cIsYZdLi3PLxLbWnXWlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(44832011)(4326008)(8676002)(8936002)(26005)(956004)(2616005)(186003)(31696002)(7416002)(508600001)(86362001)(31686004)(6666004)(38100700002)(316002)(66946007)(2906002)(82960400001)(54906003)(66476007)(4744005)(83380400001)(6486002)(16576012)(5660300002)(66556008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUF4anVFaHFaL1M1S0RmN0RKT3ArZmNkWVh3UXZnaFdyUWZjVmU2dWJXSkg5?=
 =?utf-8?B?OHhmUytNVFV1UERwNCtZVGVPUnk3ejgzc3E2QVY3cGxNdWhQcm1uWGN5RE5S?=
 =?utf-8?B?SzRoNW55bFl5MFRURUY3MStXVnJOOEM0K3BkNnlmUjFvNjZ3NGFTRTNtK1dH?=
 =?utf-8?B?SnNjemhOdlp0ZDEzV0IwZ3dGdTBmeFMzSEg3ZTZoQlgzbXc5a1lwRE4vVXNQ?=
 =?utf-8?B?MXkrYUdadlQ5QzZTREZWRjVMT1U4dmlXcWxsK0lRRHh4M3lyWjZNL1NIMFI4?=
 =?utf-8?B?bDM3ckdXTmJxcTY0VFkyTjVHODJaU1ppMWhzUG9TMTFXa3ZCQkp4S3liSlBh?=
 =?utf-8?B?M3JURXcxckYwakpxazBiM2dzZUx1Z1FLN1hPSDVUZDMrMi9VMlFXaUtmY2gx?=
 =?utf-8?B?QXV5SHlFZWtrak5nMnlHNjJxb29lMkNGMGttYkRLUEhDWm5rbnR4VjBkTFJy?=
 =?utf-8?B?RitoWnVnTG1TakJIaDFXanFYS0t4dlAwUDdYRDlWU2JDNzZYbDM2ZFZFUU5u?=
 =?utf-8?B?L2YyNzJ4S2VTK2h1cFhpQ2Iya2l4Qks3MFR0V3dza2w3UGRVMUp3aGJwb1Fk?=
 =?utf-8?B?SmVlM3BtSUMwTU41QVh6Z2l1byt1WVhsYW1DMnRCWXBwbFRmRlQ3Skd5R2ZP?=
 =?utf-8?B?cFByYm14UW50Y2hsM0UvK0VPajF2cnUzN1YyOFA1dllQMXJiVDVmVnRGRkRR?=
 =?utf-8?B?Y0dYc1dTZFk2Zi84VmlqRnlGMmFhWEhZY0J1OFZQa08xSmZEVUduN1VuWERk?=
 =?utf-8?B?M25rVFYwdWsvTG5Dd2ZGUGdybzNUazExOVBKblVnNlB5RTJwZWdDclc5a3Vo?=
 =?utf-8?B?akVNKzh6QktaL3RUbW80aWRWcVFQeHZNb2hqY1l2eFFxSXpkZlljN3JLa3A5?=
 =?utf-8?B?SjdmUFVuRjRQbTE1ZHk4YXE0Njh6S1VBNDIxSHpwNWlFekV5aGl6akI4a0Q3?=
 =?utf-8?B?cDlmRXZFWTV2Y2NiQ1paMzZVaWdkdDNsTTdna2xRZFJpRzBxK09ETXBhSDBx?=
 =?utf-8?B?bGljN1c5dzhZZjQyVVA5ZmdWL0JnelFNd1RNcnZpbTZBYllCQnBtVzhVU3c0?=
 =?utf-8?B?akJyMStndFhMa2N2RDl4L01Gam5GOFVQcWpRbWVWMDVWTGoxaFlPWlBvOUlZ?=
 =?utf-8?B?b29EcUVXSFFGM1NpUFpLRklsOVZ1YTQrS1FYNHEzTXdQbnk5dmI5blJXV3B0?=
 =?utf-8?B?OWNhemlhRmhuQ0NFd2RWMDhoL3ZyWDRNdjlMZnlnNndmU2lGd3p6MGlQY1VC?=
 =?utf-8?B?ckhCR0FjeUVaSzBxeEZjeUVCK2JwWk1qS3RTcXJVajNVMVdWTG85QVN2b09q?=
 =?utf-8?B?dlpXTS95VU9ldVMwd0dOajFGSm9aQmhiS050V1BqWG5GbzdQaUZ6TGkwRGhq?=
 =?utf-8?B?UWFGQjlHNWxtQUNrZW9lWnd3MzZTbjl3YW9XSEZzMlp0VUJtNk1jYVVWcTA1?=
 =?utf-8?B?RkxESlFGWWtxRlFSNThLNHFjVHN6NzJYNXlxbXl1K1ZMYkd4TmtOVWpvSXVn?=
 =?utf-8?B?dCtoZ0NNWUx0V29OYTdobnNRbGx2Z3UzWCt4SmV4cnVSam9JZ0U1RE9RQTBl?=
 =?utf-8?B?YTdhc1NVd1Rma1RPZ3JzVVlYeVByQ0FneDN0b2tMZkdzcGMyaGprWVAzOGxZ?=
 =?utf-8?B?WEJ1bG02eWlrTkJneFRYOGNYcFNSeUt5Zk15ZVhUelhnT3hVeXQ1eWd4aWZB?=
 =?utf-8?B?a00rcWozUHJTNks0NVgyRXlHSWJBQncxT1RwMXBpVmRYd0FoK2ltZmhHVkFG?=
 =?utf-8?Q?OUWVpqfWgQDecrKFLOU0jsOSFE1zy6l/M7aXYG/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b69ddc78-2f38-466f-0b78-08d99029eb02
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 22:19:56.2893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHwfIlFB5PQxnhKok9ukZsyujKOmMyfR0ZkvhZ14ZjST23RC7HwOiIlrhRKK0nQhGGKwuFQ3y5o/488qt4ool816HRXA8t4B8ts/SVQXVUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1587
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/2021 9:02 AM, James Morse wrote:

...

> @@ -527,21 +492,15 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   		return;
>   	}
>   
> -	if (r->mon_capable && domain_setup_mon_state(r, d)) {
> -		kfree(hw_dom->ctrl_val);
> -		kfree(hw_dom->mbps_val);
> -		kfree(hw_dom);
> -		return;
> -	}
> -
>   	list_add_tail(&d->list, add_pos);
>   
> -	/*
> -	 * If resctrl is mounted, add
> -	 * per domain monitor data directories.
> -	 */
> -	if (static_branch_unlikely(&rdt_mon_enable_key))
> -		mkdir_mondata_subdir_allrdtgrp(r, d);
> +	err = resctrl_online_domain(r, d);
> +	if (err) {
> +		list_del(&d->list);
> +		kfree(hw_dom->ctrl_val);
> +		kfree(hw_dom->mbps_val);
> +		kfree(d);

Even though this goes away in next patch I think this should rather be 
kfree(hw_dom).

Reinette
