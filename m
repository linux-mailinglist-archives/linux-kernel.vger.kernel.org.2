Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83E3F2E47
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbhHTOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:43:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:4911 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238509AbhHTOnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:43:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="302371188"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="302371188"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 07:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="682295863"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 20 Aug 2021 07:42:21 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 20 Aug 2021 07:42:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 20 Aug 2021 07:42:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 20 Aug 2021 07:42:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evtMUgmg1DKQaBALItAjzqCcx8Ck2TaJVaschKlsz0SihNlJCdynREvitB1tKx+xtGJy6oviUBG7B1TRFUFhg9dJrooUnbg331lz2oD7AbVxIgGViWuN8kiY7UM5SlJSVjVsxUO7Yzj3j6XbAnKdZ+TMF8wflBt93TBJmdxSXtZoVA4FE9odWDWYVGDptPHoHQMo6W3FdIpGyYdhNWJYPvCv1UmuG5jmBj3P/eZltrzSePcTfS+YQX/PVgepkmR1IkrmbJ1W89i4FIU3ncjxL7NzA5DM+NeitO74qBqbbMlwQVessS1XSKXitgBwcxVddASyA8vD3RmXwbwOkTpTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izX11mIL8cfaCqd4zGONc9/jlLv0rhdbN5iIMCWfJ2Q=;
 b=RCL7LUERUIWKqkaPrEoZsA6HdresTCQl4wu493teYxVRbd1NdoimqrkM7zsv0GoYZTSMsuUOFkB8SosAzVWAJSh25U1qf4hb6LPbZbpg3T65SDt0XupirjMBKsslCTYWC3HtYn0s8THnMAO31EOLNgr/M8lA6rsh5i5kMuFDTn+RFK3Y/LFDLFperuamMudxWSUktJSBSNPfthk4k263H1JnVNCnrTRQ688WMym8wU8h7nbHuuKHCXLYuV21hpkLZbJsi+dKBDLBgD0WIPfgYeyDLcPQ5mqN337diWXjt2bzSRcPMs3pHPjmy1WmA9X7JHQRdJs94Xck2/k19eYskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izX11mIL8cfaCqd4zGONc9/jlLv0rhdbN5iIMCWfJ2Q=;
 b=jZBOXiG5elNHC4RWTI6oSOXtUR11pW2l2xIHv+jtFey7exU9pBGuThcIZZah8opPVxhsnsKoGguMI+ZsP2pGAnMmJUy12PtkswbaTohq4h0S74tLqLOP4Yvm+wZSH+TF6dan0lY2fX/E8CFh79qjSXdejL97wxCMSM8t6/5DOfU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5385.namprd11.prod.outlook.com (2603:10b6:408:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 14:41:58 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::e4fd:45d5:403f:9022]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::e4fd:45d5:403f:9022%4]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 14:41:58 +0000
Subject: Re: [tip:x86/urgent] BUILD SUCCESS WITH WARNING
 064855a69003c24bd6b473b367d364e418c57625
To:     Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@alien8.de>
CC:     "Chen, Rong A" <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <6118d218.4ZZRXYKZCzQSq1Km%lkp@intel.com>
 <YRjTkkpDjaWxEpjb@zn.tnic> <ced3f2ab-54b6-95d7-7f5b-b6bb6a299330@intel.com>
 <YR4dr079URttZRrg@zn.tnic> <bf20583c-80d4-a037-c5dc-ba243ac6cb0f@intel.com>
 <YR7HtVf3OzM7/3qj@zn.tnic> <20d8842e-197f-e413-2588-92652c1dcb47@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <3f7dd949-4773-c8a5-69b4-bcd2115b9735@intel.com>
Date:   Fri, 20 Aug 2021 07:41:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20d8842e-197f-e413-2588-92652c1dcb47@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::32) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.214] (71.238.111.198) by SJ0PR03CA0297.namprd03.prod.outlook.com (2603:10b6:a03:39e::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 14:41:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e09ea179-e67f-498e-a2f2-08d963e8a99a
X-MS-TrafficTypeDiagnostic: BN9PR11MB5385:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR11MB538561026B2C0714B5CAE133F8C19@BN9PR11MB5385.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blN8FkSDj7vOzuYtFB/vrr9DbMkNN4RoC2RKVF1gKM9pqqHCbjZmpvwfScDgRz7RrN+4XI3rYmW8kvO3lQuiH+ULxIG6z+9JaMFtpdMxk1kG5Ud5TWtdMqunMrQiSvQdvtVtyw1WmFZC8hfbY0naNRNYPIDuM22+lB5Zuz5zNM3oasMoAp6yk4kQ1gkZ+3+az4l6Y8THWOfbVlgROvczYj2ybTuXFxOkqyFgugYmh0ztvpt6EAx6cyHNtjHIXTIWyyKIEeRFjRTLp99ig9Fh6LN1zqkg6ogkOKvrHZWvBHv/28kbnfHimeeoV7Itl/R6u5YtsaZ0yYYubBM1OPxuLMwHqhyzAtSvW3QTC2jVDzlYLnv/wQpaK84BMvS40i87BDlfKMgRufZA+8X+rY47f7pxNALss2ZFDlCkj2dRxHUsW+RvQ+O8qv5ioeqw3LZl7SyPn7gu/L8bNkX3sIFwQ8sedKQllPketJ+XxOjkjR0ZynCHeRf+PblvMgvSnYLHtkdGzxl7JSbjx0J8MpkV/zWY/T6DDYkNUNmiA13dqAa0b8h0c6LfrhA02FI4URw2Kk5P3IJngbWDhvk4yefeokkRelNmTiYjS1vlGdVYF6nifhgROp3Vaa3YuNizpxSgoP4JPdP5TVRu5VVizcLyNWdMUndR7B1s1oBMzhRKzTWCghGGhIsi9qjnyjnCLJshu6jYWdeYzEuPncz49IWlBSWmThD8lE7dO8ti4ppG6nGJr/MzPe4e0+QYsPiH/ZtX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(8676002)(8936002)(26005)(16576012)(2906002)(2616005)(956004)(44832011)(38100700002)(31696002)(86362001)(316002)(53546011)(110136005)(31686004)(4326008)(5660300002)(36756003)(83380400001)(6666004)(6486002)(66946007)(478600001)(186003)(66476007)(66556008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEt2SzczRnJPUjhnY2NheGVIdEc1YnJvQ1JYaXpFM3VpZDNKRnFGZHlCR0Zw?=
 =?utf-8?B?dHFYc09IQVN1bk5GcGVXMC9ibzFOWTRMRnNKOGVYV1h0V0lxNU9MbGxYODFx?=
 =?utf-8?B?MFJUcTAzbFBXaVpEZTFJL2xTU2dBNU1Fd1JFS1JYaG9SNlFhWDlzSVZpQ2Fs?=
 =?utf-8?B?SG9HVlRqcUQ0UmIydGVKTEZhTE91ckhlL0NKcTh4dnBJUURiejhoL295ekp5?=
 =?utf-8?B?UTlKenNJUUpvTFFzdlZ6UTloeVJ1OFkzVHRLY1ZDWVJYYk1QYmtTMEdGRHVI?=
 =?utf-8?B?dWJMTzFCSXdWeWJIQ2I1bHZRLzJTV0JPOWZrcWdGY3VnUUUxc3pjU0Y2QWF0?=
 =?utf-8?B?QkpvTVpzR2F5NE1LNGxiZUJKVlhuS09JdnNjaTFBMS82U2YzdmxLOWRPdTFQ?=
 =?utf-8?B?SGRyRWZBMzhmdXBqNHFlaE1RWWYxL295NmMzcldhdGxoSXhQYjlNYTMzZzJ0?=
 =?utf-8?B?YmN1SzZKVkU5SVZENkptRU9BMTNmTkcrYWlqVk13SGsxM0JSMTExWnlyZTY3?=
 =?utf-8?B?QXE0bXRsNnhtNU56K01zMEVBdHprNXVLdzJ6RFVXWStKQ25saEh0LzlVN0ZE?=
 =?utf-8?B?QXkrQTNOTEJKY2plc21NZkR6Tk10V1gzbnJ6NnlFU3JTaE5nZXFLdVRESkdX?=
 =?utf-8?B?ajhrZTR3bkx6bUdic3BSNzZoS3QrdzQ2ZElZQ0U2blFUNCtPZnBlUEljTzkw?=
 =?utf-8?B?QnA3KzQ5RDJkSUsyWmNLblB5MFpvTEVmNGFvR2ZGd2prU2VXRmZaeWRmWHdq?=
 =?utf-8?B?Y2Ribm84c3BlY1pUUXpCNk4zd2ZGNTN3UEdHY21TWThIYUhTM0dFMTE5Tk9B?=
 =?utf-8?B?WllBQWpiREdOYVc3eFpQakI4aFkvT0s4Q0Q2QUkrVC9zTTZVWHpaVU12eUZ0?=
 =?utf-8?B?d1FtdHNOY0ozMVVaL2FDZStFRGN3eGg4R25FS2Z4ODY1aEwwZmpQc2ZjbWJR?=
 =?utf-8?B?ckxXbkEwUFdVWVlVdlZXMTFxT1ZpbFRwa3p1NVI5bjRNYjlDTm5YaVRjN053?=
 =?utf-8?B?eHhWSXNmL0R1bUxEZzEwS2hsMEJiN0FEMVFocStlaVVhS2V0SHpaYXhacFl5?=
 =?utf-8?B?bUtxYm5ackU0bWJqVHl4d08rWjBxd0ppaG0xUURSQXNUakpaSjFUS2FuTXUr?=
 =?utf-8?B?YlhmWGc1NW94YXZmc25Sd0NpcHRmWUJXVjM4Rk5rRm5jNG1iWlNEUUl3VkVz?=
 =?utf-8?B?TFFTTHJ6YjRacVdtV05TL3FDMlZTTFNWOFZpSGk1YnVPV0hOY2p2MW84TlFw?=
 =?utf-8?B?YnFRdkR5ZkM4cEZaRGJzTmpsemxWWDFOTjNDMk5sdEFrTWF3dFRtRGNheW5o?=
 =?utf-8?B?ZFdpc2s1dlpHVjRTYVBWaXlORUljV2ZEMFBSVVRUWmZMTitBbmxPWUNXRHN5?=
 =?utf-8?B?em1CV3ZGZ0hSeGx6V1JyeUlJOGd1c29HdGZKczM2ZFY0OUwzNlp4bFNLa1dM?=
 =?utf-8?B?dnRBQVBHa29lcDJ3VVpLQm5NM01LSXh3N2NBUFJCZVZGRWlmRnkvK3hXT0xK?=
 =?utf-8?B?ZXF0REJ4NDBsRDdKYlhTNktoRm9nR0hacXYvaVgyTG5GMHNQOHRBa3VROFh0?=
 =?utf-8?B?aFZYNzZRdkVmbDVJbkp6QXgxaFgvUEF5eHZIMk5OWW9Qem0wY05ycVhSR2Yr?=
 =?utf-8?B?UTRqOS8xMjl5Um4wdnF2TDF0amJOOENCVmFnOUFpTnlsVDB2SzNPMFJDR2hi?=
 =?utf-8?B?MWU2ZFJmWjhOVnpaN2pEZU5YMVp0SjcxYkpqRkJjY1NaWTVOWTFFMjNPbDFU?=
 =?utf-8?Q?0jZgGi7Z1gVy6KY6Y0FFmrI/IhCu5BYu6npEXo2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e09ea179-e67f-498e-a2f2-08d963e8a99a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 14:41:57.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmg6Diq0EfXFy/EWVCs5LvZkpWc9I9EPTdP+b7VZKc0k3mT40t5yxsGRTjkXWhunOBTuU6ECHrpMMAPTSqrdNttmVf70j+SiWUnmeyuHNuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5385
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/20/2021 7:16 AM, Babu Moger wrote:
> 
> 
> On 8/19/21 4:05 PM, Borislav Petkov wrote:
>> On Thu, Aug 19, 2021 at 01:39:46PM -0700, Reinette Chatre wrote:
>>> I can confirm that the removed comment explains why m would be initialized
>>> when used in the code that follows.
>>>
>>> How would you prefer to address this? We could add just the comment back in
>>> support of future reports or perhaps by adding the default case back with
>>> the same error that would be returned earlier when there is an invalid
>>> EVENT_ID. Something like:
>>>
>>> ---8<---
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index 57e4bb695ff9..05b99e4d621c 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -304,6 +304,12 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read
>>> *rr)
>>>   	case QOS_L3_MBM_LOCAL_EVENT_ID:
>>>   		m = &rr->d->mbm_local[rmid];
>>>   		break;
>>> +	default:
>>> +		/*
>>> +		 * Code would never reach here because
>>> +		 * an invalid event id would fail the __rmid_read.
>>> +		 */
>>> +		return RMID_VAL_ERROR;
>>>   	}
>>>
>>>   	if (rr->first) {
>>
>> Right, I would normally not take a patch just to fix a tool because it
>> cannot see it correctly.
>>
>> But Babu has another use case which breaks the build so I guess that's
>> serious enough to make an exception.
>>
>> Babu, can you please explain?
> 
> Details:
> 
> The patch applies cleanly to RHEL8.5 tree but the build fails with an
> uninitialized variable warning treated as an error. The RHEL8.5 Makefile
> uses '-Werror=maybe-uninitialized' to force uninitialized variable
> warnings to be treated as errors. The build error was found while using
> the redhat/configs/kernel-x86_64.config kernel config. BTW, the 5.14-rc6
> build passes and it does not build using '-Werror=maybe-uninitialized'.
> The error from the build is below:
> 
> arch/x86/kernel/cpu/resctrl/monitor.c: In function ‘__mon_event_count’:
> arch/x86/kernel/cpu/resctrl/monitor.c:261:12: error: ‘m’ may be used
> uninitialized in this function [-Werror=maybe-uninitialized]
>    m->chunks += chunks;
>              ^~
> 
> The following patch fixes the problem.
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 57e4bb695ff9..553cc6410442 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -304,6 +304,8 @@ static u64 __mon_event_count(u32 rmid, struct
> rmid_read *rr)
>          case QOS_L3_MBM_LOCAL_EVENT_ID:
>                  m = &rr->d->mbm_local[rmid];
>                  break;
> +       default:
> +               return RMID_VAL_ERROR;
>          }
> 
>          if (rr->first) {
> 
> 
> Reinette,
> Are you going to send the official patch or let me know I will send. You
> can add signoff from me after adding above details. We probably need Fixes
> and Cc: stable@vger.kernel.org.
> 

Could you please go ahead and send a patch with these details you 
collected?

Thank you very much

Reinette
