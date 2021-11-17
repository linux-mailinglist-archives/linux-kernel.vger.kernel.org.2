Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B5C454E41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 21:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhKQUGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 15:06:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:30877 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231911AbhKQUGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 15:06:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="232766707"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="232766707"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 12:03:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="593479634"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 17 Nov 2021 12:03:00 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 17 Nov 2021 12:03:00 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 17 Nov 2021 12:02:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 17 Nov 2021 12:02:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 17 Nov 2021 12:02:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATAycwKn+h+tKt5ZGDgPZxZbDy1p7d0IXEM4oI6AXP5FTo0Rx/mDijYwWu5qBeuvMdN6gF5unLVmguekYGvUZuiafXNonk44F5fio6Mqb4UZXXRNbXEVRY7xX3a0DctANse1UhZhqkRuQhtfAoreLnoj8A7F6MvJHxdFGsmL/ALkbrq6IPcbFvI3lsnt0HBFpqphW1DoaIHxgilQW2CQoixhqXM/PlPLBFzxS+FiJTIZEKkkxMhafrHWhNuaX1xlGhS9RtESUJEtfHRKgw2FOB4BoWjQ+vNYaKTggoZMYcNScoBHcG+uRSxMsfFiZzySaYzhi5vWy66u/kzTeVLhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8FGoBNQ01pRX8LYF2Co5UYekbSDhVVRlYaKLW6HM8Q=;
 b=j7tOFHbs7eZmAI8L2g3BvNoMDdk8SAFGoRVmn4GeoENXL8QDwtvk0Cvz1aFwhX1M/0LKFKTDZmw6NLtVKoJqupTuhRiGcJZ6TU5v+rPE94YhDvoYmQUm4Ps8uEIaXLab7zt3BwaG81KlhqFhxHcKMECvFh6nTPMl/DdiY3lANefFYdKRv3ZFdV8FImZAyEhfKlEE0KrUkc4mn78EiktNY4Rfzcz5Ao/lcjvNtUrFD6pkkAjq+bKZ37eK40/UTsUJG92BHacTp4NDPFWZjOLpz76DXot0oN1X1LZmQQ5pSAf4cJIX5PXFoTPLx4SDCJ0t+UNsXsx4dKuyIYoPovrMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8FGoBNQ01pRX8LYF2Co5UYekbSDhVVRlYaKLW6HM8Q=;
 b=tt6GJmrloPrFitGZvBUPdc4rRuOK+Vck3vlebDZqn4AAV6+Fy6tRvwc7528kTISq/j1yXbmh2AkZ9MJ7oPyR0pTp6AGFi6blNLs3i0yfXuOFxfyALLa3Y3JmB980erJzGaPgGEqAXWaWIU84dZuh70xoKlD89hja1leJKLjuyog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3453.namprd11.prod.outlook.com (2603:10b6:805:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 20:02:10 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%9]) with mapi id 15.20.4669.022; Wed, 17 Nov 2021
 20:02:10 +0000
Subject: Re: [RFC PATCH 1/5] firmware: Create firmware upload framework
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ardb@kernel.org>, <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
 <20211111011345.25049-2-russell.h.weight@intel.com>
 <YZUceupQe67KYJyf@kroah.com> <c521bc07-0f10-e89e-a59c-b6e07fc35089@intel.com>
 <YZVHaeuYL8QD/7db@kroah.com> <44f1be15-5e16-38fe-392c-b87a29451318@intel.com>
 <YZVP1jetd/a+dYyf@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <29541f4f-c1d5-9ce1-9160-e5698b215c96@intel.com>
Date:   Wed, 17 Nov 2021 12:02:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <YZVP1jetd/a+dYyf@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:303:85::29) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW4PR04CA0174.namprd04.prod.outlook.com (2603:10b6:303:85::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend Transport; Wed, 17 Nov 2021 20:02:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e4fc336-2c58-4400-0d9d-08d9aa0523c7
X-MS-TrafficTypeDiagnostic: SN6PR11MB3453:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB3453FCA6C2E4DE3BEB074F0CC59A9@SN6PR11MB3453.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOqvJu8JCsA/e59ebpGMCOWc1NgW1c//Gp02lelZwONHdgzXdjUzBuSPoJQsQ0S+5lHtDNsunfvNaD8cdAG+OD+M6rFEb72yKxEM1qFWo/A/tE66D4FSJYrSzagz+lkLPj3mcVtQ6cWh7aL33TwL/g6kOlAnIcLH4vwWzxLoWQ2Q4NIg6AdPdxmm4f25rANYGwtukMOk8mDpyISxeMfshNLBZCjSFty91TVYkWO3xLU5Wks/MdrYMQ95pAE3jHKFtll+njxwj8Tk/knW7M4m9H8oKPEoSTZdFjpt3Xb2dmWiPavADC+D8fXcvavCq3aSk7/vg5jHSUQgglg9+0n2K/y7N5Ql1WqdA9y4dAmni7FkUsRoHuesi5l449VY+4ySa+yMHMj5Z2fb5rT/skZCzhZq+UnD4Wytgwhm71BYml4uL6TnFw1ADOQJNa1f9vWwgFv+vvqLGIxOl9ehJbTCKjyhNGLSaYbnWtPokabpIeaAP3UhUeWDpBTTMxTQezbiK/qcofH65OugkNlsdoICDWyHcE1k20j/Kyu2BQvAuDnUtEW5hlEMWSZKdUFhauK1PV9Daukj0iz52dhviGM8xoDoBizjvOn8a3Ra7jTACL1kyILmfDw9bWFmANodDMlq8eZddz5YO+rmVS4YzrSgNYCcFd0bb2XlU3OF4Cib8BiZK6fD9QoLKoKl6cIrvtzYLls0AALRM/Q4YbpD4nPqrtvVXZoV4Sksdnrk+A3+67jgW8yFP3Ke+JLfIy2Mszg5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(4326008)(16576012)(5660300002)(31696002)(8936002)(6666004)(8676002)(31686004)(508600001)(316002)(38100700002)(66476007)(26005)(86362001)(2616005)(83380400001)(6916009)(66556008)(36756003)(66946007)(2906002)(82960400001)(107886003)(6486002)(956004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFl1N0hBUksyNy9obkR4T0h2cTg1VkZnS0FlN3A1bGhKMHozYUNvcmtYMGtZ?=
 =?utf-8?B?S2tqRzEzNVJEYUhHVFVyOThsTmU1TFE4NkZlZWFXS2lIYzZpUXNLa00vWENk?=
 =?utf-8?B?b2pITzJid21ydTE3MHhRU1J5NUFvUW0vWnVlS3NZZVV2cVdrVm93TVdjRzR3?=
 =?utf-8?B?TUMzbXBWRUtuZzYwd0lObzY4dTNVL3NhdU51U1pwNEhIeFh6Sk9GQ2NmdmNt?=
 =?utf-8?B?YW03OTlkV2NqSnFla25wRWxiWFE3ODkrUnhoWVlZNEZQNlAxOC9QVHJ5Z0tM?=
 =?utf-8?B?ZHhSSkpPd1JTTTRFd0FhOFk2bmFUMDFZS1lhWGhObkU3dHlLV1FTVjl6OTB5?=
 =?utf-8?B?R2RtSnJFRDVncC9Id2FZQXZNNCtTZlpVblhNcUF0bWhSRWd6NTd0S3hnekpV?=
 =?utf-8?B?dFJSM2h0RkVDZFV1UFh3Und6eWgvNmNzTmpVbTQ3YkUzT3NCNWZwcU1lWnRs?=
 =?utf-8?B?SzhOVE9YNFVRNDhXaXFWT0JPZ0ExQUhBVWszOUFlc1NLQjlBV3haMlVtZitU?=
 =?utf-8?B?YUVSYW43T04zNFBTZGRSMTlETFZxNS9vdFJycFM2K052L1pXMVRmd0lyZ0lw?=
 =?utf-8?B?REJIL0xwb0FIWlYzOEhIT2k2YmtScUpzdUMzc2Y5ak1uanc5WW5uakxtL3Q0?=
 =?utf-8?B?OUZSUzVhYk1STkh5blZaWE96RWNiZ2ZiU1hjSlhzOHFXUCtQSTlBMGJPNUk2?=
 =?utf-8?B?WHRFdDBsZENzT203UWM0VEhhekIzdXpOZ2l3V28xZjkzUVc2SWZSdGt4ZFFS?=
 =?utf-8?B?TEc0NndleWNnUVFyVWxZMllUU3lFYk10MmM1S251Tm54Y0JQazZCb1dTYVkw?=
 =?utf-8?B?QTd3S1Z1bU1zSHEwbEx2WFRyczQ5L3JFTTR2UC9jYmgvRVpPeGN0NmZ0eXkr?=
 =?utf-8?B?QnRlY1QxU1RTcmRhbUcyYmQ4dStva1FZaVNXQzBEUjVlb2xJSUJCTloxazhT?=
 =?utf-8?B?VHc4NjZ5ZUJ3NWJMQ0RZRUpzaTV1UlRTQjBpcXRWZXVXYUNieG16QXJmclc0?=
 =?utf-8?B?NlR3NGo1VzVEL0tlVWdQSVg0UXN5Z3dmNXpLSVYvSzhoWHl4SnNKV3RxVFFF?=
 =?utf-8?B?RXVyVWRkV3BEcVNpeEgrRUxpWElWL0lCajEzdVp2Rk1JRlJIYVVWNStRYkZs?=
 =?utf-8?B?d1RpUmZ2SSthaUZ2TWxFWEFjVmtsRThIcHRFTjgvT2JvK2RnTlRrK05UcHZP?=
 =?utf-8?B?NWNPckhJdXYxdkVNSHJBQ0lvUXRpcno1cURvamN2MnFJRzl6TW1YejVzMEFB?=
 =?utf-8?B?alZGNjlFTzZBa3dRTGI3UGx4eHFRV0l1c0YzNHkxamJsekNDRkY4WDN4QU95?=
 =?utf-8?B?OGdiS0ZHV3ZLUU9CcjNNTTBrTkRGUFNHelJ5R2lKd1ZoclpGQlltdlNTMWg1?=
 =?utf-8?B?UUY0OGI2cnE2TGl0TU1tMWhtZXIxazVmUEV6Q0piWUN0Nkl0eU8rRSsvTjBD?=
 =?utf-8?B?WWRlVzJvM0dpK1BqNXkzcWprMFYwU2s0UG9Gd0t1eCtEV2FvYUNGRmpNNHZh?=
 =?utf-8?B?OGVydFBzc3IzTG1idis3SGsxc2JQNEw2dXUwOURCNnROcTgyeUF3MFU3VU9D?=
 =?utf-8?B?a1RQcmF2SlJtLzBiWHJIdWkxZ25HOUpwaktoUlZsdlRtRlJ2NUVicWZMNkxW?=
 =?utf-8?B?bXNrK21QWmFLeW1Ielo0dXdyOHF0Vk83SVIyVXN1a3YwbHVHaXBWN3U4Qndo?=
 =?utf-8?B?VFhaYndYVlFRYU0yMW5mSkQ0Z213ZGtKMWtmYUIyTUFYUHY5cWFFeERXSmVw?=
 =?utf-8?B?aVF2RzVnV1VpZjZvZkFiNzAvZ0licWx5VU9YcnlEbzB4ZG5sL0NsMUhDb05r?=
 =?utf-8?B?aERpNTM2YVlhZDBXS3JZUEVGRWV0UlJZZFRISFFkV3NPdlY4TUlWQithbDdq?=
 =?utf-8?B?Z2ZKRTB6N3pSV0UxbCtDWkpIVmdvMTg2dkRIK09ZODc3ZGxocEtLRCt3THkw?=
 =?utf-8?B?RnhiaC91MmphSXFYdllzK29iT0RZMmVBLzdxNWVDcTFpSzVxdkkrWHBua0p2?=
 =?utf-8?B?M1ptVU80TS9abHg5dm1CdGVEbExXYlJZRHIrakEwK2RBNDNtRWJKYXBvb0Zi?=
 =?utf-8?B?QlNIK20vblNEWlBKNlQ3U1VuS0ROY0RLRDRxdGt6dWF0bzlQdVNhZytIQ1d0?=
 =?utf-8?B?WjgwK3ozV2FiYlJjS0ZDS21wRDBtWnV5RC8vMnMxV0NWWU5uM09kRkZyMkVP?=
 =?utf-8?B?ZStyMzRWVEtVT2UzQitNZGlTSHlzN2FiSUlJQk1OYkVheUNzOUs1UGRpblFh?=
 =?utf-8?Q?DVE+PJ18nB4GDlwTfeUwL+uudgA8eUNnJq9k4jd3xU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4fc336-2c58-4400-0d9d-08d9aa0523c7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 20:02:10.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBqDnilm+b0kdizFJ25QsU9w3cXJodYXM/S2GtkxoR6/2HAhRTQ1sgQyiOqDdLUtOOuNsn6AKh9M9YDOlz7oIIUSZgkz1C8DMdYaaGpR8Ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3453
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 10:54 AM, Greg KH wrote:
> On Wed, Nov 17, 2021 at 10:47:38AM -0800, Russ Weight wrote:
>>
>> On 11/17/21 10:18 AM, Greg KH wrote:
>>> On Wed, Nov 17, 2021 at 10:00:54AM -0800, Russ Weight wrote:
>>>> On 11/17/21 7:15 AM, Greg KH wrote:
>>>>> On Wed, Nov 10, 2021 at 05:13:41PM -0800, Russ Weight wrote:
>>>>>> The Firmware Upload class driver provides a common API for uploading
>>>>>> firmware files to devices.
>>>>> That is exactly what the existing firmware api in the kernel is supposed
>>>>> to be accomplishing.
>>>>>
>>>>> If it is not doing what you need it to do, then you need to document the
>>>>> heck out of why it is not, and why you need a different api for this.  I
>>>>> do not see that here in this changelog at all :(
>>>> This is part of the documentation included later in this patch. I can add
>>>> this to the changelog.
>>>>
>>>> +Some devices load firmware from on-board FLASH when the card initializes.
>>>> +These cards do not require the request_firmware framework to load the
>>>> +firmware when the card boots, but they to require a utility to allow
>>>> +users to update the FLASH contents.
>>> There's no requirement that request_firmware only be done at boot time,
>>> why not use it at any point in time?
>> Calling request_firmware() is not restricted to boot time. But it requires
>> a firmware filename under /lib/firmware
> Not really, there are many locations it can be in.  See the different
> configuration options we have.
>
> But why would you want firmware in another location?
My current use case is for a user to upload a new, signed FPGA image to an FPGA
card. The card BMC authenticates and stores the data in FLASH. From the
perspective of the card, the image in FLASH is analogous to a firmware file
for another device being stored in /lib/firmware. For the FPGA images, there
is no real value to also storing the files in /lib/firmware (or anywhere else on
the system).

>
>> , and the convention is to specify the
>> filename in the kernel config.
> That is not a requirement at all.
>
>> I don't see any support for a user to provide a filename at run time
>> to be uploaded to a device, and that is the use case that I want to
>> support.
> If that's the only difference here, please work with the existing
> framework to add that tiny thing (i.e. pass in a name) to the current
> framework.  Do not create a whole new one please.
I think another fundamental difference is that the request_firmware() API is
a driver API for the device driver to do a data "pull". The firmware-upload API
is a user API for doing a data "push" (prepare(), write(), poll_complete()) to
the lower-level driver.

I did look at the backup option of the request_firmware() framework for writing
image data via sysfs. That's a possibility, but I thought that we would be abusing
the intent. I can look more at that option...

>
>>>> When you say "existing firmware api", I'm thinking request_firmware, which
>>>> requires that driver names be specified in the kernel config and wants to
>>>> load firmware automatically during device initialization.
>>> It can be used at any time, why do you think it's restricted to init
>>> time?
>>>
>>> And I do not understand your issue with driver names.
>> Sorry - I meant so say "firmware file names"
>>
>> In an earlier iteration of this patchset, you pointed out that allowing a user
>> to provide a filename for request_firmware() to use was a security issue.
> It is crazy, don't you think?
>
>> The use case that I am targeting is to allow a user to provide an image file
>> to a device at run time.
> That's not a limitation of the existing firmware layer.
>
> thanks,
>
> greg k-h

