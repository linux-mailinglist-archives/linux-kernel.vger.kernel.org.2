Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D8E3CF0C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379982AbhGSXqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 19:46:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:50082 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376708AbhGSWov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 18:44:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="210868831"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="210868831"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 16:25:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="453865137"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 16:25:29 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 19 Jul 2021 16:25:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 19 Jul 2021 16:25:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 19 Jul 2021 16:25:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyVJumLf1Iu0qYXBAEhIQ+KA3dM2cx9yEqifCViCZUCRzcJQhQpTGsJc823BTiQQ4CIE0B0hkz9tyhNWcaZne+0wl1EgdLoh0+GKjQp91eIBScOz/rBNQGXIItcACkmRWNxOSgac9lFpvlSGNwvc3os+1mGQq0HPwTiyJR9Cf2NJ+MBG/IbG9kmQEAaB0PGvpTy44rQGe8+viZPQTOhGTC0JybWU1A8vQ4MPavMSzvZldtQoU9Z8FnWL48A18SsU7hxPqodiJIG1LNtcKa/KgPRu6/LPfkrqZZwaKU50gQBEyDQM5rhhSN6HKIIgU95dp/ZecYw9c4UqobRgtpHQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrH+p1Fx+tTD3ZOQ8ZJmLuNng1qSSqD9R2NTVQ6rXKs=;
 b=JhNAU0OEbY+rkpVI9GHvMeqsmkndO7asMYSagt2QAzUfIxv2L5jcYI7WBv+/VY1v6zyPzZZB2Rq9MQiPpSMrXGG1OWw/nHhm4IXkHRSlP/gGG7eUL920/9039XlN9AWEBZddjZQduo9lbRMD7xzqoXLFti+gvSKnlXgWI7xxZJusyYLVdhaoLaq6DhgHRlSOQzBnAywwCT5EF9i0nXS2lTHBuybdWPnnQjDrIDJrzyL55CwODUVwEf6BmHemzh+CPfUizcYbpn6r4OJ0F6D6MZPO6Hpf5Vc95JdnBicnfCX406l+1qP3Ew1DmhprBVIYgt4futEdpmYQf9EpKCE6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrH+p1Fx+tTD3ZOQ8ZJmLuNng1qSSqD9R2NTVQ6rXKs=;
 b=T4Holiwm1sfgLYd+uoN+UFI2sfHnOvVY3hbhv/DJrRyh1TtdiaWJ0EeEL6A4oassfnb3/mfCCKGkLFZa+J8ij3c5xZRSp8c2ttSr/+bRCcS+Nqi6Nv3bMh1HH4ojIVL/vIgY7bL4pJ442yZDwGVm37p50roZZ6hGpO6s0Sg3Tv4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1411.namprd11.prod.outlook.com (2603:10b6:404:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Mon, 19 Jul
 2021 23:25:27 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::202f:e602:3983:e631]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::202f:e602:3983:e631%8]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 23:25:27 +0000
Subject: Re: About add an A64FX cache control function into resctrl
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
 <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
 <TYAPR01MB633071CD547B0AAF818520E48B2D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <f53b9bfd-0d55-4cf2-fabb-82b3ec86e52a@intel.com>
 <TYAPR01MB6330758A49FECF90B5290C768B259@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <89416df1-4e91-8ad2-981c-827808a65229@intel.com>
 <TYAPR01MB633085C894CA3B064BB637E28B1A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <26ffe50f-7ff4-2c4e-534c-edf23cb88df1@intel.com>
Date:   Mon, 19 Jul 2021 16:25:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <TYAPR01MB633085C894CA3B064BB637E28B1A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO1PR15CA0096.namprd15.prod.outlook.com
 (2603:10b6:101:21::16) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.219] (71.238.111.198) by CO1PR15CA0096.namprd15.prod.outlook.com (2603:10b6:101:21::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 23:25:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd83e6c6-2b2a-4f2c-cf09-08d94b0c7dbc
X-MS-TrafficTypeDiagnostic: BN6PR11MB1411:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB14117650CC9C472653E96DCFF8E19@BN6PR11MB1411.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rXoAa1L1SuDmD+0gBGKUGltgRzbqSpWfNrkCbD/3wcwrBIDSMZs0K8iLIm3z9uBIF73ji5ZePaWlqX19nKdB/5iMkH8ZFNYBZCczAmOA8Pg2g+NQdb//jfDx/FCZaRkCzefJ/TP9saI4BDYdfc7UgdKB7IbSgdCqodkP7T3MUGUDCXBbMEdcT2aKD07387IfyHfoYMazF7vVb68cECGoaszk0KzJsGw0meYNEjSI5Y2UVXCzzR3RzW3iVL20g6XHZkenrKBrmqpUhXnvuAncILUuu3TdGLuqa2LLa+ic/dnqbf29lM7eN/qTGbJ4u/EEsjZ2Hq89eg0nX0932lWbDgHcGIoEyIq9y1UmbxrkB4uzjkLAiWVdIn694dGm9YuFHUzAZOdxxBfKfgFxueO7HnD4/p9lyBDQm470N+Yd1Lfh24xB1jqErdO+TYzmzCjGqThp7yLeYoo/sRC6xCu0UqzT/JkIxQA9vtDCh9dj0ESQAGGpMoQla3pmgFKnChaQtayQTjBlzPMyEIWIrXQ07SatPr5rgAtBkQLXNvsiZXc+cPniO92wwZa2pLsz7OTcNdan+kTCRBKD/5l8+j0nIVk2pXNH8K8kU4ixfYga+cAaaFG9kesF1Syht4GmyysfrVg/3nDabM+cy1ZoWBrK19KKTSTaSuBEBKU86dQuEMAq3FiSU/NVvnLSNEcW0QGq6BASa8LLRiITZLZ14+xsUMztt2kCR0vFTes30SQbadG2E4U0gj3UND5tEEQsqrU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(6486002)(2616005)(956004)(26005)(6636002)(6666004)(53546011)(86362001)(36756003)(38100700002)(4326008)(31696002)(83380400001)(478600001)(66946007)(8676002)(110136005)(2906002)(8936002)(66556008)(66476007)(44832011)(31686004)(107886003)(186003)(316002)(54906003)(16576012)(5660300002)(45980500001)(491001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVpxbkZwT2ZabFYxSmZpTDVud3dLenp3Rk42QXc2M0R1ZnBLR0twVFV1UzFy?=
 =?utf-8?B?Z3h0eXBXNkRoclV5dG1jRmp5U21iS241YmdjNnJKaDRmdkZRTUExVHpjdnNh?=
 =?utf-8?B?N2c3TXVrWThhWmNPQ0Z2WHZUSW00QTl3QXQvdkxiUkMveFFHV1NYNlBVYWxG?=
 =?utf-8?B?c0RTOGVEQVVKQXRkd2hQY0p5b2JQbGZTRlZUMXFFelVUU2EyaldjRjBFUENU?=
 =?utf-8?B?ZzBjSGJPVTlmem5wOGVFREZ4OGVnd3luRkxNS0pSR21PaElpOUM0ZVJZRHhK?=
 =?utf-8?B?elpqcnFXZE5uVHNacUVaTGZsbi9OWW42bXhOT014RFY2c2pJKzBnSjBjMk42?=
 =?utf-8?B?cEkwbDZCMlBUdk1oQm9xdHJGdW0wRFhmYjBVUkxwZUxydjlsVTV5VC9TU3Z1?=
 =?utf-8?B?MVc4UlUxbWJWN3IwTElCTkcxeUN6M2tMUmtzbXNXbWdzMmV5bmNQaExVSnlO?=
 =?utf-8?B?aGY1V3VGVlVaS0tmNHdvdGVqdjVJUUs0a1krNEMxUlRZT2RCaWFqV1dibnRL?=
 =?utf-8?B?V1g2SXVaMGw2Z0Y2TkY2c1FFVlBNdjdPcmowYXZCbTh3VmNVeEFVRjQ4U3hN?=
 =?utf-8?B?Vzl1bkMyZzZXY3FRb1dpODJhWGVMTmNrSWRMNzRXQnZWc0lXSG91WEpLM0Fl?=
 =?utf-8?B?ZGF5bVRIN0ExZjNMTVEvT0twU25pcWlFYVRHOEdXMkUxTlRvVEloZkFjVTU1?=
 =?utf-8?B?cU5NdFhPTnl6dXo2ZjBkTU9tZ3hYa2lwSjNBazhFR3JWWlRWVU5kNHhJMk5Y?=
 =?utf-8?B?LzhZalJuSFdVTytDVDJYN1F1Ti81YXptbjdYSXZMMk8vTEg2Ty8ydEJKOXM0?=
 =?utf-8?B?OTVCNVBYSmRvRXNGVk02OEV6S1NHaDZqT2dhWmI1cjF2T1ZZSEMxS2M2YTMw?=
 =?utf-8?B?Z3lHL1NGK0tML0dybXpjS1MyNHRCTjMzTys1R0RUNHhOb1ppT1VNVXg3bmN2?=
 =?utf-8?B?cktDMjFLdFpacEQwS1JRN0JURkdUZ0tUa3F0eEJ0bGpXZm5meW9sRU9YRGNv?=
 =?utf-8?B?TUhHa2JzYml2dUJWNFlGT3RLRWFwUjg5WmdSUzlvalpFUXNxeXhlR1BnTHhh?=
 =?utf-8?B?VXBUanQrNGd5YTI3SGtnODU0d1NJSEZieEJvcTNCOSt3Y016aGZ2TEkxNmpQ?=
 =?utf-8?B?OVExU0w1eHNhWlh0c245VHhiTk9JNjRiYklOeTc1Q3h5SE5vd291cS9SUDFN?=
 =?utf-8?B?RjQvbnFrOFRWdVZOWTROdTgrcmovbUNqMkN2aUlLQy94NTZJcXg2YkpHdloz?=
 =?utf-8?B?SFNhU1B0MHp0cHd5di95ZnVNbGY3bHdrZ3pETmlXV3pBRWEwRkxsRGxoVWVY?=
 =?utf-8?B?WWVPY3FyVXZNSHJTS1lJb1pDa0ZFTHVKNzJtOWhUbVd3REV5K2FVNXIwWW9V?=
 =?utf-8?B?ekw4ZHVsWjdCZld6WWxYWXExUXo3blhYNGFGZ0M0WXdGYXg2aFJhSlhwRHpm?=
 =?utf-8?B?WGdlTjNLYlFUVUNSVmt2dUpqd0FFZDRNei8zZk0za21iSEthZUdXQVhSOXNr?=
 =?utf-8?B?cUdFRVBMdGw5VEw1QXVnU0JFRStiS0xtK1NNUk45S0R2blF1R0NsS1lTS1NE?=
 =?utf-8?B?WnNTcEE3VGtmUTJFd2ZYZDczVkk4SDNqcjd4QWhzL0phSE40bkpBVUppSCtH?=
 =?utf-8?B?aGpFa2dCUDdWTjRwSTJPZDVkVWxpQlVZWUhkN1lDT2VzdGpHTVZjYWEwczUy?=
 =?utf-8?B?d1Q3ZDZEYUZ1TW5pd0xrTG84SnFXbTBlaWhqYmZmVGYyTHlVYWpsSHFDcC8w?=
 =?utf-8?Q?KrfQaGSU9/l3rAFCCoPFT5uhvKy9F6IKD9l367u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd83e6c6-2b2a-4f2c-cf09-08d94b0c7dbc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 23:25:27.3411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otq/Eqhg4egZqfufoBeH4h86zK9R7Cn3A3nZMqmQxKg7ml4cBSnoUn157H6elLRSI3ilyMaHhUfF3z4pmDBprfIMDkUrVjvp7tX4uJhWGMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1411
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tan Shaopeng,

On 7/7/2021 4:26 AM, tan.shaopeng@fujitsu.com wrote:
>>> Sorry, I have not explained A64FX's sector cache function well yet.
>>> I think I need explain this function from different perspective.
>>
>> You have explained the A64FX's sector cache function well. I have also read
>> both specs to understand it better. It appears to me that you are not considering
>> the resctrl architecture as part of your solution but instead just forcing your
>> architecture onto the resctrl filesystem. For example, in resctrl the resource
>> groups are not just a directory structure but has significance in what is being
>> represented within the directory (a class of service). The files within a resource
>> group's directory build on that. From your side I have not seen any effort in
>> aligning the sector cache function with the resctrl architecture but instead you
>> are just changing resctrl interface to match the A64FX architecture.
>>
>> Could you please take a moment to understand what resctrl is and how it could
>> be mapped to A64FX in a coherent way?
> 
> Previously, my idea is based on how to make instructions use different
> sectors in one task. After I studied resctrl, to utilize resctrl
> architecture on A64FX, I think it’s better to assign one sector to
> one task. Thanks for your idea that "sectors" could be considered the
> same as the resctrl "classes of service".
> 
> Based on your idea, I am considering the implementation details.
> In this email, I will explain the outline of new proposal, and then
> please allow me to confirm a few technologies about resctrl.
> 
> The outline of my proposal is as follows.
> - Add a sector function equivalent to Intel's CAT function into resctrl.
>    (divide shared L2 cache into multiple partitions for multiple cores use)
> - Allocate one sector to one resource group (one CLOSID). Since one
>    core can only be assigned to one resource group, on A64FX each core
>    only uses one sector at a time.

ok, so a sector is a portion of cache and matches with what can be 
represented with a resource group.

The second part of your comment is not clear to me. In the first part 
you mention: "one core can only be assigned to one resource group" - 
this seems to indicate some static assignment between cores and sectors 
and if this is the case this needs more thinking since the current 
implementation assumes that any core that can access the cache can 
access all resource groups associated with that cache. On the other 
hand, you mention "on A64FX each core only uses one sector at a time" - 
this now sounds dynamic and is how resctrl works since the CPU is 
assigned a single class of service to indicate all resources accessible 
to it.

> - Disable A64FX's HPC tag address override function. We only set each
>    core's default sector value according to closid(default sector ID=CLOSID).
> - No L1 cache control since L1 cache is not shared for cores. It is not
>    necessary to add L1 cache interface for schemata file.
> - No need to update schemata interface. Resctrl's L2 cache interface
>    (L2: <cache_id0> = <cbm>; <cache_id1> = <cbm>; ...)
>    will be used as it is. However, on A64FX, <cbm> does not indicate
>    the position of cache partition, only indicate the number of
>    cache ways (size).

 From what I understand the upcoming MPAM support would make this easier 
to do.

> 
> This is the smallest start of incorporating sector cache function into
> resctrl. I will consider if we could add more sector cache features
> into resctrl (e.g. selecting different sectors from one task) after
> finishing this.
> 
> (some questions are below)
> 
>>>
>>>> On 5/17/2021 1:31 AM, tan.shaopeng@fujitsu.com wrote:
>>
>>> --------
>>> A64FX NUMA-PE-Cache Architecture:
>>> NUMA0:
>>>     PE0:
>>>       L1sector0,L1sector1,L1sector2,L1sector3
>>>     PE1:
>>>       L1sector0,L1sector1,L1sector2,L1sector3
>>>     ...
>>>     PE11:
>>>       L1sector0,L1sector1,L1sector2,L1sector3
>>>
>>>     L2sector0,1/L2sector2,3
>>> NUMA1:
>>>     PE0:
>>>       L1sector0,L1sector1,L1sector2,L1sector3
>>>     ...
>>>     PE11:
>>>       L1sector0,L1sector1,L1sector2,L1sector3
>>>
>>>     L2sector0,1/L2sector2,3
>>> NUMA2:
>>>     ...
>>> NUMA3:
>>>     ...
>>> --------
>>> In A64FX processor, one L1 sector cache capacity setting register is
>>> only for one PE and not shared among PEs. L2 sector cache maximum
>>> capacity setting registers are shared among PEs in same NUMA, and it
>>> is to be noted that changing these registers in one PE influences other PE.
>>
>> Understood. cache affinity is familiar to resctrl. When a CPU becomes online it
>> is discovered which caches/resources it has affinity to.
>> Resources then have CPU mask associated with them to indicate on which
>> CPU a register could be changed to configure the resource/cache. See
>> domain_add_cpu() and struct rdt_domain.
> 
> Is the following understanding correct?
> Struct rdt_domain is a group of online CPUs that share a same cache
> instance. When a CPU is online(resctrl initialization),
> the domain_add_cpu() function add the online cpu to corresponding
> rdt_domain (in rdt_resource:domains list). For example, if there are
> 4 L2 cache instances, then there will be 4 rdt_domain in the list and
> each CPU is assigned to corresponding rdt_domain.

Correct.

> 
> The set values of cache/memory are stored in the *ctrl_val array
> (indexed by CLOSID) of struct rdt_domain. For example, in CAT function,
> the CBM value of CLOSID=x is stored in ctrl_val [x].
> When we create a resource group and write set values of cache into
> the schemata file, the update_domains() function updates the CBM value
> to ctrl_val [CLOSID = resource group ID] in rdt_domain and updates the
> CBM value to CBM register(MSR_IA32_Lx_CBM_BASE).

For the most part, yes. The only part that I would like to clarify is 
that each CLOSID is represented by a different register, which register 
is updated depends on which CLOSID is changed. Could be written as 
MSR_IA32_L2_CBM_CLOSID/MSR_IA32_L3_CBM_CLOSID. The "BASE" register is 
CLOSID 0, the default, and the other registers are determined as offset 
from it.

Also, the registers have the scope of the resource/cache. So, for 
example, if CPU 0 and CPU 1 share a L2 cache then it is only necessary 
to update the register on one of these CPUs.

> 
>>> The number of ways for L2 Sector ID (0,1 or 2,3) can be set through
>>> any PEs in same NUMA. The sector ID 0,1 and 2,3 are not available at
>>> the same time in same NUMA.
>>>
>>>
>>> I think, in your idea, a resource group will be created for each sector ID.
>>> (> "sectors" could be considered the same as the resctrl "classes of
>>> service") Then, an example of resource group is created as follows.
>>> ・ L1: NUMAX-PEY-L1sector0 (X = 0,1,2,3.Y = 0,1,2 ... 11),
>>> ・ L2: NUMAX-L2sector0 (X = 0,1,2,3)
>>>
>>> In this example, sector with same ID(0) of all PEs is allocated to
>>> resource group. The L1D caches are numbered from
>>> NUMA0_PE0-L1sector0(0) to NUMA4_PE11-L1sector0(47) and the L2
>> caches
>>> numbered from
>>> NUMA0-L2sector0(0) to NUM4-L2sector0(3).
>>> (NUMA number X is from 0-4, PE number Y is from 0-11)
>>> (1) The number of ways of NUMAX-PEY-L1sector0 can be set independently
>>>       for each PEs (0-47). When run a task on this resource group,
>>>       we cannot control on which PE the task is running on and how many
>>>       cache ways the task is using.
>>
>> resctrl does not control the affinity on which PE/CPU a task is run.
>> resctrl is an interface with which to configure how resources are allocated on
>> the system. resctrl could thus provide interface with which each sector of each
>> cache instance is assigned a number of cache ways.
>> resctrl also provides an interface to assign a task with a class of service (sector
>> id?). Through this the task obtains access to all resources that is allocated to
>> the particular class of service (sector id?). Depending on which CPU the task is
>> running it may indeed experience different performance if the sector id it is
>> running with does not have the same allocations on all cache instances. The
>> affinity of the task needs to be managed separately using for example taskset.
>> Please see Documentation/x86/resctrl.rst "Examples for RDT allocation usage"
> 
> In resctrl_sched_in(), there are comments as follow:
>    /*
>   * If this task has a closid/rmid assigned, use it.
>    * Else use the closid/rmid assigned to this cpu.
>    */
> I thought when we write PID to tasks file, this task (PID) will only
> run on the CPUs which are specified in cpus file in the same resource
> group. So, the task_struct's closid and cpu's closid is the same.
> When task's closid is different from cpu's closid?

resctrl does not manage the affinity of tasks.

Tony recently summarized the cpus file very well to me: The actual 
semantics of the CPUs file is to associate a CLOSid for a task that is 
in the default resctrl group – while it is running on one of the listed 
CPUs.

To answer your question the task's closid could be different from the 
CPU's closid if the task's closid is 0 while it is running on a CPU that 
is in the cpus file of a non-default resource group.

You can see a summary of the decision flow in section "Resource 
allocation rules" in Documentation/x86/resctrl.rst

The "cpus" file was created in support of the real-time use cases. In 
these use cases a group of CPUs can be designated as supporting the 
real-time work and with their own resource group and assigned the needed 
resources to do the real-time work. A real-time task can then be started 
with affinity to those CPUs and dynamically any kernel threads (that 
will be started on the same CPU) doing work on behalf of this task would 
be able to use the resources set aside for the real-time work.

Reinette
