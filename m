Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE9C3FE4E1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbhIAV0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:26:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:37829 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343918AbhIAV0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:26:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="198426050"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="198426050"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 14:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="476355028"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2021 14:25:38 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 14:25:38 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 1 Sep 2021 14:25:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 1 Sep 2021 14:25:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 14:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a36rAp/FwWZ4td5Jjpw6fGt+L4Usz8HolkrBagyVZ0HidUPcDGedjoBB45ZTfw/lO7Vnh9ZEdi5IcKcfh86Tts4QraQS+QKZo5FwadLXF/Zt4qWDWfdpYetPiPJzWexv5SYS280b9uEnLELjE04OnfJdjvO424RuuiYI3jJZy/fp5+eJX61KDnVwRcwlOFPvjqVB5byNQhM1+VzIrnhbAN5RB/pfhbXcS7ofR1LgqPiYEG2QCKVE0enBO/QO3r2Tfv030m0FXDy/4wCFjEdDALOMCmsTn9RHWQmeokcvAA1HK2iUhmrFuyjdqLcrekQ0jy+JRzpikdf9CDgkQ1Vgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1ZPlGIPvK4WfstIUxeuvVwGI11Ro24n0lbZvw4eaE4=;
 b=gHBYiuSi1U6ER4WBh1skH4b4s37Ug9C1Xm2sGpOXeyvIwqQ7pZTgUqYtDqUm/KYioX6qhEsqXsBE3yD52MUXcspRlr9OOISAAKJUl0y95+xU2oqe5lb5xVYoNFTKc7pangzMdXV4YWElmEFeHXW6tlztNMk6zsFJtN+QFi2TWrddmMbujB83cDZcIqxMW6AydfKZ+AxWpWLI2xJ2hmTE8Y477ZMG2STGrAEpKNzHlVbMaXQnWGbpt9WCjPB14seBHGQCySB8b+MtcQLzmsH1VuWzhHOs4kvtEAh8HOozVbVgyoqL6l4t/TOkrHng0zDZyoVew3oqucZgCWyOgVjWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1ZPlGIPvK4WfstIUxeuvVwGI11Ro24n0lbZvw4eaE4=;
 b=M73RBoBuC8VvgKvb6+Z1RVajekEMvrTuGl1vZfesPP2mX1SI21ub8RTtl4oY+F2mCkDWVyfCjrruAp2sWlwiJOdwi+NmTV3PUMSx2HUoycWvFa1PUuBi1YJSMHZTB3rDyMpduN8qngoKAnubBIfLJs35P6RbwVODKNVgOHnTcbY=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2258.namprd11.prod.outlook.com (2603:10b6:405:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Wed, 1 Sep
 2021 21:25:31 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 21:25:31 +0000
Subject: Re: [PATCH v1 06/20] x86/resctrl: Switch over to the resctrl mbps_val
 list
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
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-7-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <5be446b6-d6f6-dacb-4368-7c1e7aedc6cf@intel.com>
Date:   Wed, 1 Sep 2021 14:25:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210729223610.29373-7-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::31) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.217] (71.238.111.198) by MW4P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 21:25:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d8f7b57-cf37-46c2-099d-08d96d8f06dd
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2258:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1101MB2258D5527F0F337ABC98749BF8CD9@BN6PR1101MB2258.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqVF2rtXS6UW+0zJuBNZBCmSA/3foHdtFobm4N+7l1ALQtnghrZyyHHhxwsNjUS0GKSOhu/3YXitv+tcWWnBf89Yv4WRHrbsuxP0DvSurQsUEoawLcRkzWPi8Kq+fERkx87rDBXR9Gifjfg72lQKIBvQF5CPl/w1oaJngqcQIsRqB3ioK2hzqgrsaVPb0p/IYtcNsR90UJzptk5ZRVQhPG6iLzj+e3vhMejdfyjRtsdG2FFehiWcVjJcrcowgM32r50ZuhbO4t7r1x3TiBzQjP3ipp55YZ/WYPbYrHPhb++YhhOMRyVPXQJHnjuow+Z9L4JBr3pG0IWYroS2bToFDRwPBtOQJ+bKvWAQaoAs8O6aHl+GMkWs/iPIzDmer2dOt8u0suGJeQSQ/7cExdoehPNjUYmDrP/cjrj0sRiMVQ5V6J1BhoS3OGMu6Z2tnTraURV7/WjSkMqVa4wDCTdrebKIbRKqyczx+YnNv+SP1kvPQdg+801rGATvKyr6Qb3xgqQ/nnap6Jzbmn2JLCsqi1mTJcyXTnqRi344KG9qNennf5mqy65hYDyv7k/hfNFAb2dYUOOqvgSlFzdn9YTvMmeICmffAg2sTz7XVdCOmXB/H6dIY0fz5z22hB56hePuDQBUtp6VwgoT6V1qtw793AAytt2WnkjP/o9qwf9ir9IT5OXtApaS+9gJDb469IugAooudE4CF3wrf1x79FX+nq2ptVWAgb+CoARaupv7RNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(86362001)(26005)(6486002)(36756003)(2906002)(5660300002)(7416002)(186003)(53546011)(44832011)(316002)(8676002)(4326008)(66476007)(38100700002)(956004)(83380400001)(2616005)(6666004)(31696002)(478600001)(16576012)(66556008)(31686004)(8936002)(66946007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzlMdlRYNno1REloSE8xa0hnbzMxeHVJVnhka0tiUDhORzZhZHEwZzg3Ujg3?=
 =?utf-8?B?TnBRdG9NSWtkZ2UvNmpjVFh1SXMrVnRxdEJhQUhycWk0RXlhK2ZGYklUenFM?=
 =?utf-8?B?VGJlQWRQay91L250U1VXakFlblFaUzZZZUQzanR6MTA1NXdqZVV4RnArdkg3?=
 =?utf-8?B?N1N5ZGNLZkdBcEoreVBGbmI5Vk54TkVKV05OVGQvMlNVbnNSa25XSkdVZmxU?=
 =?utf-8?B?bmVsYjFDSUxHRnRkVUxjenRjYThOb0R5YVRwZWQ3bXE4ZTYzTk4zVlpXMjcv?=
 =?utf-8?B?WlRqa1drcWpOM05XTXlQOU96dUROU0E0R2w4MStkdERKWFk5dlBQVzJHcVEv?=
 =?utf-8?B?ck5yNGVmSk5IRjFPV1UzUDBPNHpYMmw5L3dEMUlycWt0cXVQN29heGVmWE1o?=
 =?utf-8?B?N0NXME9kQkdRSUx3cE1HbjVrbGkzV1l6YkpRc2cvaWtiSGYxMURtd1Z1MHk0?=
 =?utf-8?B?QTczbHdlTTZac0luc1dqNlB3b05FUE0zWWtlL2JaQVlpM0hZNm40M0dGcEFr?=
 =?utf-8?B?Y1ZoSzEyVlh3ZnVuejFPbEhEaUNuczVjR1c2NndoeHZrVHFYbTR0K1VmTXV2?=
 =?utf-8?B?OGl5Ym42VlllSGQ4UDdBdmhLWFdhZllMZkw0QWh2b1pVSnUzNUVkTlR4UXp0?=
 =?utf-8?B?cWNPRC9zSUx0c1VOYTg1Wks5YkttcTF3aUJrZ1Y5ZWJnVkFlNE16djhPc2lW?=
 =?utf-8?B?VzkyWThlVWF0R3RQR2VidlQzdFlxWXVuZERSdHFpSHhTcS9IaGoyUWREN3dv?=
 =?utf-8?B?U3RVVFBRZml0Ym5KSXlnUWNmSzE0QmxJNXNCeEg1S3E0UmplbExvMnFtN1JO?=
 =?utf-8?B?Q21OblB6QWtsMFFzeS9rL0I2dHdOODd3ckpGeklCamxKZFRQODRxM2RrcnlQ?=
 =?utf-8?B?Rlk1OXhUKzV2QzR5UDhkU3AwYkRDa25sYTRxVklzUDZtalNsaW1rbkF5WGcw?=
 =?utf-8?B?UXNPdmV1VmlhNGExc212Rnl5K1lIMmpGcG9zQVhCWmhnQlNrK1dEbXRWcU9k?=
 =?utf-8?B?VUdsK3hLb0k5NmovbDBlczdGVUg3WUUreDJKMThDUDM2eW5qeWhwNk9HU2Uw?=
 =?utf-8?B?czdGTmFwQ1JaOVVqeVJJdzRnUnRtcitJM0tNQ0ROKzVQSGNDU2VUb0tCNlFC?=
 =?utf-8?B?c3gxakw2TmIrRE9wWTNFeCtJaFJKMlI0dDdoN0Q3RFNtWDhXZE4rQ3ZTR2gz?=
 =?utf-8?B?Um9VUHBBMWx4RzRlOFFpYTlIL29ma1JORDJSclpQdlFTWk1XL1d1WElrYW44?=
 =?utf-8?B?dzFSR1pjNkwrNng1TDBvVTJ3WU1ieDNsaVZuTzhmUFJrTHhlNnVTSllIbVEx?=
 =?utf-8?B?dWVYL3lkekc1aUxHdlViczlpZk5BYVZiem0vQld5WTdqbVRVcEQ0TzZCTzNC?=
 =?utf-8?B?eC9pRlc0djAxbmJsbTZwTWpKUjV4V1lTYlZqTGRESmsrUkpTc2tDeTJIVVVl?=
 =?utf-8?B?SmllRVBoM0JCTVZMRkxTQ3A1RkkxWStWZDcyOHlwUVJ0TGw5WnJocVdPUXF4?=
 =?utf-8?B?UHZhRUhvT2psWnozLzhIWGhINnIvRWZMWnBSN2RwTmhyVDh3QXRXejU5em9V?=
 =?utf-8?B?djU3NXFRQXdSbHBSMGFqNWNQZ1ZvVXlWaWdFQ2lhTmxEQkJuRVd0MmVVUCt2?=
 =?utf-8?B?R21DeHUxZ2d3ZkQ2Z1g0eE5QZVhmTHlBekVaNThDUHV4ZXdMc1ltQjFLVlVP?=
 =?utf-8?B?bkFhQ2Z0S3R4MVMvdTJWejVaejcvdll4WlhQSnFUZTZOeGd2Mk9VdTBqQkI4?=
 =?utf-8?Q?37gaPq20dntzk7S10HfnH8KzbXkorDhZHG7n46/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8f7b57-cf37-46c2-099d-08d96d8f06dd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 21:25:31.3541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DV8TTK/ilR/mxZ8JR/e4+X919pPHnBtkXb4GjGiff++NDYma5bmhl4lAw8vFU7iB/D+ucuccXBnzcOpXjYIxVk+4y/Muiw0gRWX02QyHt8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2258
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/29/2021 3:35 PM, James Morse wrote:
> Updates to resctrl's software controller follow the same path as
> other configuration updates, but they don't modify the hardware state.
> rdtgroup_schemata_write() uses parse_line() and the resource's
> ctrlval_parse function to stage the configuration.
> resctrl_arch_update_domains() then updates the mbps_val[] array
> instead, and resctrl_arch_update_domains() skips the rdt_ctrl_update()
> call that would update hardware.
> 
> This complicates the interface between resctrl's filesystem parts
> and architecture specific code. It should be possible for mba_sc
> to be completely implemented by the filesystem parts of resctrl. This
> would allow it to work on a second architecture with no additional code.
> 
> Change parse_bw() to write the configuration value directly to the
> mba_sc[] array in the domain structure. Change rdtgroup_schemata_write()
> to skip the call to resctrl_arch_update_domains(), meaning all the
> mba_sc specific code in resctrl_arch_update_domains() can be removed.
> On the read-side, show_doms() and update_mba_bw() are changed to read
> the mba_sc[] array from the domain structure. With this,
> resctrl_arch_get_config() no longer needs to consider mba_sc resources.
> 
> Change parse_bw() to write these values directly, meaning
> rdtgroup_schemata_write() never needs to call update_domains()
> for mba_sc resources.

The above paragraph seems to contain duplicate information from the 
paragraph that precedes it.

> 
> Get show_doms() to test is_mba_sc() and retrieve the value
> directly, instead of using get_config() for the hardware value.
> 
> This means the arch code's resctrl_arch_get_config() and
> resctrl_arch_update_domains() no longer need to be aware of
> mba_sc, and we can get rid of the update_mba_bw() code that
> reaches into the hw_dom to get the msr value.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

...
> @@ -406,6 +406,14 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>   
>   	list_for_each_entry(s, &resctrl_schema_all, list) {
>   		r = s->res;
> +
> +		/*
> +		 * Writes to mba_sc resources update the software controller,
> +		 * not the control msr.
> +		 */
> +		if (is_mba_sc(r))
> +			continue;
> +

A few resources can be updated in a single write to the schemata file. 
It is thus possible to update the cache allocation resource as well as 
memory bandwidth allocation in a single write. As I understand this 
change in this scenario all configuration updates will be skipped, not 
just the memory bandwidth allocation ones.

>   		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
>   		if (ret)
>   			goto out;

Reinette

