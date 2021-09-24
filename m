Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BC0417B56
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 20:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345327AbhIXSzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 14:55:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:38283 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345024AbhIXSzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 14:55:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="224171142"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="224171142"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 11:53:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="559725180"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2021 11:53:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 24 Sep 2021 11:53:38 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 24 Sep 2021 11:53:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 24 Sep 2021 11:53:38 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 24 Sep 2021 11:53:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFgnCbTtfsMgS0gmVgWEy3UJfNpkg5tMnrKB46cuVChrGOSoGSfCC4pTwxxbEpL+yZxqiNkYNQ8WxwpBzPQnfC+pCi3ziWr+gQeUT8rEKMRFWp2n912GszGbCCJB2KGjX1OPPFHsGz378JsQgAjx1xpAwQleJGis3Iw9c/okme9ki6N2ynbmFneq9b5M3smWyvvVFY9C4k8aiArMvIYrRlZ3VizlV2O7bybYYL7hEzPfgKugw/pwiB9mj6s+g9XD1ZY379OI/HQKT2zK6U3NbmOzbx+0FDkamRTNKHih8PlFu75hbeuzblEKbLoSfeZDczVgL6HrXhNvNtXYn3uneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=h7RtAntem3OXBwIfAn9Kmgo31Pkbh56WB/Eb9VXUe0U=;
 b=Mtx5b8vr+0noAH8tU2hC4dP6HhPotzzO+BhIU+kttUoG6PPfg6vXNIFh1b7Hix7peN12chSvJd7vb0PUDb+QqGKMSFh4RznpvkBi+MNrHJOcPoPdQL+2PlJ2GU0My+uNRJjeUQ3r0K6UlIerKtqPOEWPCfXVgrzAnydOk6LliLvaiBytXUawhURrN6bNw2N6AcQElY5bxwUPcPMYhsZSRKT7+0V5eHNbtcqnkjU0bSLyaegt3J2Hdopt2VSyuA59w+/o8AgpMHjYA4jPlpdn7yOQa8DjfNc0p50bD1yarqbX5jEaTpECClZWAcEJJPqs0IQhbCqMi09cvys7TA9twA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7RtAntem3OXBwIfAn9Kmgo31Pkbh56WB/Eb9VXUe0U=;
 b=fan5ZkX3gUGduCVv996BwFCpDI7jjTAiB04ij/FKQ8kLaYFeZaJyuyiGw0yTW/SMgtO3YbjqyJGnqCNjqM/cSqMZ3hSdHL0px+oVnTsmoZlaFAGfbehWX4we+vbbDRxwFWSNlpGoIkTPGOOnyuPcpOlp7r052TpXv4/0ccz2I8M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2737.namprd11.prod.outlook.com (2603:10b6:406:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 18:53:33 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 18:53:33 +0000
Subject: Re: [PATCH] x86/resctrl: Fix return code in mkdir_rdt_prepare()
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <20210924081713.502039-1-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <600c2857-8a5f-df1e-0edc-65fea2aae078@intel.com>
Date:   Fri, 24 Sep 2021 11:53:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20210924081713.502039-1-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR12CA0058.namprd12.prod.outlook.com
 (2603:10b6:300:103::20) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR12CA0058.namprd12.prod.outlook.com (2603:10b6:300:103::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Fri, 24 Sep 2021 18:53:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 898a5d2d-b743-46eb-89ee-08d97f8c9b75
X-MS-TrafficTypeDiagnostic: BN7PR11MB2737:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR11MB2737D5F9C67F7F0850FD7B6CF8A49@BN7PR11MB2737.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xrRofvy4MFJ4eblpa++BNTCjw5DaKEB2+mi8DOk8NBXDQ6X6H4bNVrpwGhpU+T0hYRZdDhzI4jP6BKw7mP5o1Jl3MTFrwF2IgHu1DZ0AQeeg4tyWQCtOsemzEJOuvnbiL/FKdljiJ0ZK5FXIv4Hhdr9AsYpnfEoeWsV9ZqG0YQOrm7vtkWZcYabjIsWypE+yr0SSVdNZ92oA7jUm/3GEfk+iUryvGkzGfXO5jd1+PgvItplIgf11wn/9ldh8knbXc/CB5409iPHcLCT+JGdVTxbglg8BDqsqAUEXT8gp3cIhdVDo8RSTOMS3JICw1dxVb96VO7V/y9vnegcCqrsXfnLfkuUChKpgSXQ1CnlTT7CE4oD4KXPCmnRQYKM5zdOKfdZ+RsaZCmTmP1U/DF9S2HQmMp8E/8SjuVGGAK9CYJXqH5j5LK99uQ+Fk7xA+Mx0TqmMSRQS4K+GVNcFNHnKGmRoGsX9+/nyCuJYDMF9tXmRSS0eSuhLSwyMm5MzJxT59it1xxSTHrJKT56Y3uTLFAwShiuXlUxWgdenzoA7GRuElAqLmbRNQqG6AdR925+bdtRZA67/tJIiXruANqYFSr6e+nAzYsz+WnN4DuasbGA/COt15Jikkj7HtLC8BEuO1MlJFPNkNgo6D5nh+mixrP16xTr79ft0n4mo5eun8FV+x2sYIVMLaVCy+VMGsgVVQyZ3rLmCs+c5Lp6ZEqjvFDpizA3QdvNdGg/UcebPtCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(4326008)(186003)(66556008)(44832011)(66476007)(2906002)(316002)(8676002)(6486002)(86362001)(8936002)(31686004)(83380400001)(2616005)(956004)(6666004)(53546011)(36756003)(66946007)(26005)(508600001)(38100700002)(110136005)(54906003)(16576012)(6636002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUdGMk5qTnpvTG1RZysrcEJLaVhLWGZ5aVpqV0hSNVRWdG1Bb2doZXJ5Zms4?=
 =?utf-8?B?SzdoSEQxSHlwZ1hVMGZrY0VTU1cyaTdRSXVmZzVoWGMrcUM3R2Z5elBSUndO?=
 =?utf-8?B?OTNjeVl2Y05Nd2hYVnMyNEdiaXhJQTRPQ1lBZjhmazBHMldNRGxreEVIR1hS?=
 =?utf-8?B?Y05RblNFMm5mRkpmMy9DQlhuQWZoeStlZXNxbHJJMkhFSDhBeTgyMVl6QklO?=
 =?utf-8?B?ZG5WSzFrNFJMTHl1bXZVSGlvUzdaSldTRW5tZ3h3WnBRcmVoRVdTZ2twYzkw?=
 =?utf-8?B?R1o2OVlvRTlmTzFNVTVZQzVLMWE0YzF4cFJwL0xjK200bEplZTg1RDlsdmUz?=
 =?utf-8?B?bXFtZEhFL0dnbUJ2OUJoaWRVMlJvYkh6YnQrNTR2cU13dW5MdGlZY2F1Y2tu?=
 =?utf-8?B?STdBbGVIS2dEQkpWbVRtQ0ZHOU5yM2dMdTlMNlIwcXNQRlRYalU5ZldZK2pL?=
 =?utf-8?B?TElTcjdVZnZQUzdlWTBrREhVR1kwQjV0eFpjMDJEUWYrQXNCNGNnYjh4ZVhT?=
 =?utf-8?B?RW4yMTN2NElPWEdES1ZVa2RTclVVRVoxZDR6ZjV2L0pRVGl1cUl6ZU5kM3Fl?=
 =?utf-8?B?ajFIc2YzaVN3cmFJaStwM0NMblBGZHhQOVkzK1dwanNwWEFrN0MzMjJsNU1w?=
 =?utf-8?B?SWR6c3BGYjVUb0puZnZoZkZ6eDN1Q2hyUCtCZGhqOFlZN2hRTVZYUUhaYWdj?=
 =?utf-8?B?L2xIT1ROQjZuWU01MDhiZFlaT3FLT21mcDVYU3diT092YUJFUmVpQkxreTZu?=
 =?utf-8?B?dldaaEQrNDM3TTY3YzM0R2QwRWRaT0FobVVqT09ZREZCT0x1aFJWZG43YTdo?=
 =?utf-8?B?eW5HOURBNTBnaWI5MkhzMHovcXdFY1YyYWJEdGNvbFFmZ2lQMW5FUjNyODdu?=
 =?utf-8?B?L3d3UlZrQ1EzRW92c0Y4QlhoQU9ZWGdFNWNWS3J0ZWlHWVZmanhaUnRVVW5q?=
 =?utf-8?B?Nm1jajhNOVNXdnJjcjNJVnBQWmU2NWVGdFJTcUVEb1FOWjYxdmFQbU1PdnFi?=
 =?utf-8?B?Ymp5Qm1JeFNMc016YWh1TGlhUkU1c3NjbGVlU2FNWjJqcWxWZVBOUnkxb2Zj?=
 =?utf-8?B?Vkh5aVVVUXM4dkR0OWxGbkltdFA4MjNQRDhZV1pVUHZkRWE4ektramhKaWRl?=
 =?utf-8?B?UERsM25hd1dZdHZqaW8zOTFYSm03azc1TWtEQ1pCN0ZBS3lreTEwN0V6TzN1?=
 =?utf-8?B?c2Y2QUpZRVAzbS90VU9ldnJ3bE03MEwxVGs4SUxQZVVuTCtpTXJvZVlNVTNB?=
 =?utf-8?B?VHZFR05sTjROQURpbXlJWFNvaFlGelFGc3ArOFN4SG9sZW5SckZTc01pQkJv?=
 =?utf-8?B?WXREellkR3FzVnlvdTM1c2ZyVXB5NmtNSVJBMEJrbWpMdEpJL3BPOW1yRmVG?=
 =?utf-8?B?eXREbHBWekFLaUszazI5L0h5cUVWWHJ6dWUyTnhaVmo2ZlJyOS9iZ0tNaldR?=
 =?utf-8?B?T1JuYW8xMFZMMWloWk1KdjZBYXRQUzIvR1VkQ0VncXdxMWpoTmJLc1VjdFo4?=
 =?utf-8?B?K0xjZW9iZjFQWG12WXBPci84UWpVcUJKcEVWMWZlazVUL3dUb1dQWWczSmdM?=
 =?utf-8?B?cmhYZUhqajVPajFvQ1Q1N1MrYzlsbHpWaGZJTFdGbHhTZUQwTEpQMnN0a1I3?=
 =?utf-8?B?TVRLLzk1MGpFRHhUallwdnAyajF1aU1rbVNKbE4rNXJWQjR2VG9sUzZjTmpH?=
 =?utf-8?B?RzVjNUVTN0VkaUNJenkvUHB4a0tUbWI3RXZWcHdYK3RXanRuNk16U3lGa24z?=
 =?utf-8?Q?AbVK/v8Y8IditaKaaVEUeE2lbR6HEBGpb2kQ7tu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 898a5d2d-b743-46eb-89ee-08d97f8c9b75
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 18:53:33.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9swevt+37PGwSpUT3JXBsdkByi7eNzj8JvemGEngXWP8nyvjeYIjfb4L7agzwZ57KeCujVU+zWz1vo4X5KzMa9iBG5CbEVc1Io1otCVK6/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2737
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaopeng Tan,

On 9/24/2021 1:17 AM, Shaopeng Tan wrote:
> When kzalloc fails, we should return ENOMEM instead of ENOSPC.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Hello,
> 
> I just noticed this when I read the code.
> 
> Thanks,
> 
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index b57b3db9a6a7..a92d047476f6 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2854,7 +2854,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>   	/* allocate the rdtgroup. */
>   	rdtgrp = kzalloc(sizeof(*rdtgrp), GFP_KERNEL);
>   	if (!rdtgrp) {
> -		ret = -ENOSPC;
> +		ret = -ENOMEM;
>   		rdt_last_cmd_puts("Kernel out of memory\n");
>   		goto out_unlock;
>   	}
> 

I do not know the original motivation for using ENOSPC but from what I 
can tell this error is propagated all the way to user space. This change 
thus has the consequence that any interface built on top of resctrl 
could be impacted.

Is there a specific issue that you are aiming to fix here?

Reinette
