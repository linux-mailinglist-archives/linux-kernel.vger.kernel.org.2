Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD763F318E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhHTQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:38:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:13343 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhHTQik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:38:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="213679518"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="213679518"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 09:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="682461513"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 20 Aug 2021 09:38:00 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 20 Aug 2021 09:38:00 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 20 Aug 2021 09:37:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 20 Aug 2021 09:37:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 20 Aug 2021 09:37:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnIRrf1cI1I1FGmXf4ao46IT4vpawlDcR8lGVSRcTJkE1Ve1ZOkFsXaCfCyQpK6ahiwKzR2wmldddYINXSx3WTSQI+RMyXu68ZeKhMel3st7rOknceFdiP+GreiHeyhVdhBZYRicpyQiZpXM1WHCg3U/hHNu71iKKHEf1f3iZweDf+4SFHr9m1GJGIM3KFVopToL1nfkoJUHOMzKrj6gUkRTiwvQ9LSiwTPDsBz7TMSBdVdiGu9G42a93EmVQfx7W/B7M7NH3upy93KKgckSB3DE2KgfsDm/4Bdqhq6sia9MGfiuqhh7CVxN84/69FtqPANiot1RPul6ObL23wAf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOowUV34xGpscRXG212EkP0ZbLAsyOJzJeyJkgDv51M=;
 b=R6mkPzD9b7A+VtdANhkcQojvppswO8voW9md7p478pApWnun3cHqOXY2FfTojx6Q7sWO9BN7eEOLu9CJrJ9Awd/mrH/4Ti/obc0RzQhV5yqyYMSE9I59Q3nvO7Yn8OawKLXl3Py6QJrziqN0cJaVnPruuV0nw0rAQngmHdZOy69uyR42BfPuXBFCDrEWNl5pHHk1ktx1BBNRttgntqVmCKNIC1xYSZ9i85fsEpnv9p1QMcIx9d3mVquhKUSOjariWOGp63iqCHb75tU2Ymg1GoZU0hLP3XGoVxzyEyFLUNxF8wgTWjJGnagM8XpFywJNKEqLvA9I3DT2xj8o9lw2IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOowUV34xGpscRXG212EkP0ZbLAsyOJzJeyJkgDv51M=;
 b=FOB/8R5nDkcApXOf0x7ez+gaALEZgx3CpRvdJjzlFBPlHWw662pCox8g4V/l623WoUwHWC3pSX2DctOW5nCDO/RYVFwIBTS48PNwzYNhQjv4Pn0IXsbmudPEvIBfa68JONCwAX7Fn6RKvPKeDrxU3TlhJfVA87ZP4BFsC+6FgmU=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1441.namprd11.prod.outlook.com (2603:10b6:405:b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 16:37:58 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::e4fd:45d5:403f:9022]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::e4fd:45d5:403f:9022%4]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 16:37:58 +0000
Subject: Re: [PATCH] x86/resctrl: Fix 'uninitialized symbol' build warning
To:     Babu Moger <babu.moger@amd.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <Terry.Bowman@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>
References: <162947718839.12313.2592762168334394449.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <1d6448a3-9afb-f4af-8552-8a1105c22509@intel.com>
Date:   Fri, 20 Aug 2021 09:37:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <162947718839.12313.2592762168334394449.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::7) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.214] (71.238.111.198) by MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Fri, 20 Aug 2021 16:37:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20c9d252-8c01-483c-01d9-08d963f8de24
X-MS-TrafficTypeDiagnostic: BN6PR11MB1441:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB1441C129E214F6AFCABE3797F8C19@BN6PR11MB1441.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39yFZCOsiVe8gncRdyb0RY/u7vV1HNd902IXLojwBo60B6MP/NWZw/vVMLvgregfpx7APaP6ZZ8Ch2fLXxitKlDjUrphcFxxE5Uu1i+uVNskVBQZusOsX8SXBsSDi+bbBy6ETz/Osmxw7U8FLIB9Jat4kQac3N+5gqC/pHdeZy6nDe0q5K73uZlrVrZ3bUzhJmleg5f71vUd9esrwhFdfwxqQV95kwY56XlXT3PqT32c3zmdzuyxZ68gsrzdyl4Ee5FJVowKblD82Z82B8xyzZDsTCiT7CKwBQwsSP0vRarHfqzXEk1wyCcqVJcrr623lWXvleTV7IVTKI5qLkE+F6RA8HlpCfjpRVvEV2VVHaAsPlbKATXHS2/g8QN9t/GSkU3gG0/i+nmqC1b6b7XVpzGf8TAtMVSMTCecg5qMsat3YhuBWX67xFVFBxXkFxibWABtruzBGoHGIQlJS6ErQQ7rk51STXbiw1mdptKrEERW3LgEnc5KtMd8gKMIlHNToZEv0VTI015yigzV+ffWfplrA4ylMohSKZ4UZI1/r4HxDz89/Ttn0lBR0kNGEFHfpv8QsmefNeKTzTQQZJPQJVBSbRKIPFa5VFdVcdt0eQO50kPcYUwywnNw+/ov3toDP4rlQbKp31vTiJiZY+2T5GWDVcEbfhXwfWcRUZJFnrQm449/jbGSNh54UDM2JMJp+xgqAL5gaL269qRa9jJSEsm20Zvmiybb+l/UQUmgbSSTgouE5E8hZ+6UDIcsi38snmbTqt2VuSgtghOfG7oU9YyONQFQkAqgsuSwGZaZ8MVq3b5OVHJf0Eceuzkw4WYd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(2906002)(6666004)(26005)(186003)(44832011)(8936002)(53546011)(5660300002)(478600001)(16576012)(66946007)(956004)(316002)(2616005)(4326008)(66476007)(83380400001)(966005)(8676002)(31686004)(86362001)(31696002)(38100700002)(36756003)(6486002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGg5bDdDWk9JYXJ6MFlKYVdqNmhQOEEvRkh0cUhyaG9qUTZVM01NblFZYXUv?=
 =?utf-8?B?eDA3Zzk4TFQxMThjMlJTWDNUU3AyWk1HdWJkaEVSSGxJdW1NS1hxbSt1VFpV?=
 =?utf-8?B?ekdwaHE4a1p4UUF3c2l2eG10SExOZmRKb2ZKaDRzK3U3UlBKODVsaVlMMGRZ?=
 =?utf-8?B?TVJhUDl6M1JOY0dpYmJrWXZYM0V5YTZlWTJ6eVBCRUdOOWcwbFNvdE5MTnFS?=
 =?utf-8?B?K2h5dkN0MDlua3Ixb0NOWm9RUmlsalpDdjBGclQwbFB4eDdrUlpEKzJOOUUy?=
 =?utf-8?B?MVFiVHBBdStvZ2FkTWhLSkZsN3hSd1pVOWtDNDYxVWRVNmhLNHQ5RVhLa0sv?=
 =?utf-8?B?S01kenA4ejJBWHdlRUZYOG1qTHBYVk82Vm5nUnJSd2g3eHlnVzd6RU5Ma2No?=
 =?utf-8?B?SVZWNFd0K1AzS05KVXFUZkNVNXFZRnVDMHltRGRYUG9QYUQ4TjVWUG9qQUZC?=
 =?utf-8?B?bkkyQ3YxUjdrMCtDNCttcTFuL3dKRmZpRUU0cncvMTZVaGNmVXdQYVJ4TGVV?=
 =?utf-8?B?a3NRMTVxQ1ByeS8wZFNLM3JxQ1ZwR2dCajQxSmg1SEROQno3THQ1elBIQWJL?=
 =?utf-8?B?K3hnYi8rd1VYL21UWll1cUNQbFZUQzFmZzBNTFJ3bzJabjVxaFJKWGM3c1FC?=
 =?utf-8?B?SEg5K21xVy80RUhVUnpSWnM3UGVRWFpnUkVPZ1lvSWVIR25IWTE4VHlBQkVr?=
 =?utf-8?B?QWN2L3BMb2wxTG5pNXpkVzFiL0llSzVuZWVyejdjZ2RsS2RUeGxDYUlheWh6?=
 =?utf-8?B?RjBnTGl6UFBxVFdFL0RmZzJvT0h4ZXFFWTlkNVY0dDZaL0QwbTR1dFpVODBF?=
 =?utf-8?B?Y01ETXlJdmdJZlFFeGZOaklYcC9Pb3U4SkJWcHkrT2R5T2FzY1htUHE3RWZP?=
 =?utf-8?B?bUgwcFZocitZTTFPZmVCd3p2MGxlN0J6cnM0TkdQeEVQMWZ4OHVxWFpPcTF0?=
 =?utf-8?B?VE5HWmNvNjJreFlHT1JVc09YSWpxaThrMFFNdHlxVjN0NEFKUG9XVUsvOW91?=
 =?utf-8?B?dGREZjRlQU40WjNGZkVIdnBzZitUMTNoTVJENllEU0VFRk50Mkszdm5LZTZ3?=
 =?utf-8?B?THd0aFZuUm9Nc2FHajNuYVJaaWs0MnAyQzJWU2FjZ1AvLzNTdkV1SUdWZTZU?=
 =?utf-8?B?RlQ0UytVdFExcTBOVjZQWW0yb0VOdlJ5c21yQ3g5aC90RGJwMXJJL3pJZm4r?=
 =?utf-8?B?UVUzTmFsb3hKR1JsdDFkWEF4dzNqR1gvQXU2RVVzNnB5NUpkUFBNT3RZQXhr?=
 =?utf-8?B?YVJ3NUJlbmIwRWtQZ2RUNHlMRHppN3dvRnMyb0lXM1pUTkJLdllKa0FMQmFy?=
 =?utf-8?B?U3ZpSE91enc0WDA1ZnRudjNoT0hpbUhxenVwTjNFTlFwdmlSeVYvLzJudHMz?=
 =?utf-8?B?UFRDL2Q1VU84VURILzBpS1RqZmFaTEJVT3AxRnFtb2NRTlZqak5oS1ZOSCtC?=
 =?utf-8?B?TmFDbEpuQy8zdzRaa3VuNlo3UE12UC9kWDFNVGpNRUd5dGVINXpyb1NsVFNk?=
 =?utf-8?B?b21WZEVRZ3lkS3Z6MU8zRUlnc3NhMlZQNjdsbkRQbUdQZzVvTWVjRDlRUXNw?=
 =?utf-8?B?c2xJOFczd2Vya285NGVPeXZrZ2c4VFNCQ29Rb0gvOUV1Rk82Q0FESHlGcHQw?=
 =?utf-8?B?T0ZBaHhHeVpUc2NYSTdoWVY5V2xYNlRmQjRnWkhvZFZYWkNEUHB1cy8xbUY5?=
 =?utf-8?B?bGpCK0lHRFliZVU4enZ1TFVjSnRSeEhVV0d2TnY0QnJJZHE1QTF3Wk5qUFZ3?=
 =?utf-8?Q?/QlkdV7QBhmteFcFxH1tbZTJ2BNqP5q4Y2/0Xbq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c9d252-8c01-483c-01d9-08d963f8de24
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 16:37:58.0701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPL563W+E29D9ktIORNKXdTKBfAtMZrOGEqGTfinOWop0PDaI0TDQ2vR1PkxEY/PiMYStoZqPnNDM5+wlb8tptuEwhThw61YVFX6LBm7ovo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1441
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/20/2021 9:33 AM, Babu Moger wrote:
> The recent commit 064855a69003 ("x86/resctrl: Fix default monitoring
> groups reporting"), caused a RHEL8.5 build failure with an uninitialized
> variable warning treated as an error. The commit removed the default case
> snippet. The RHEL8.5 Makefile uses '-Werror=maybe-uninitialized' to force
> uninitialized variable warnings to be treated as errors. This is also
> reported by kernel test robot. The error from the RHEL8.5 build is below:
> 
> arch/x86/kernel/cpu/resctrl/monitor.c: In function ‘__mon_event_count’:
> arch/x86/kernel/cpu/resctrl/monitor.c:261:12: error: ‘m’ may be used
> uninitialized in this function [-Werror=maybe-uninitialized]
>    m->chunks += chunks;
>              ^~
> 
> The upstream Makefile does not build using '-Werror=maybe-uninitialized'.
> So, the problem is not seen there. Fix the problem by putting back the
> default case snippet.
> 
> Fixes: 064855a69003 ("x86/resctrl: Fix default monitoring groups reporting")
> Cc: stable@vger.kernel.org
> Reported-by: Terry Bowman <Terry.Bowman@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/6118d218.4ZZRXYKZCzQSq1Km%25lkp@intel.com/
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c |    6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 57e4bb695ff9..8caf871b796f 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -304,6 +304,12 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>   	case QOS_L3_MBM_LOCAL_EVENT_ID:
>   		m = &rr->d->mbm_local[rmid];
>   		break;
> +	default:
> +		/*
> +		 * Code would never reach here because an invalid
> +		 * event id would fail the __rmid_read.
> +		 */
> +		return RMID_VAL_ERROR;
>   	}
>   
>   	if (rr->first) {
> 

Thank you very much Babu.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
