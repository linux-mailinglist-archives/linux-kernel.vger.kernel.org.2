Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882CB454D66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbhKQSvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:51:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:41655 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240221AbhKQSuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:50:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="214061001"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="214061001"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 10:47:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="472838529"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 17 Nov 2021 10:47:51 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 17 Nov 2021 10:47:51 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 17 Nov 2021 10:47:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 17 Nov 2021 10:47:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 17 Nov 2021 10:47:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDUb8to9q1Aop4r/4OZM9uLB61ZD5J/q7xM1c+h0fhEpXrnmiOhLBhiEprDZKt75eYVbhNM1jHDMTnyvyGNH4ZXv9vj9+1vYOciY5Ym9W4EVX939ft+0FvmTQxDS6kMl6VZsVDS20Fq1XuzOdI+lpzMSlEP4wfMtfieDzmdb6bxLbiulmnnOKnQGzHSy4LdP+DRM+MVpubB3E7mXjOjBTrriQnMGy43WNVnVr/1zxvGpgLMolTWF1p3tahxH2kF5tmftiq2B/VOkPm0RtOXa+14ig5xnao+4U43SIOK/pAtbJCNU1ytNWUwFxvzElYpsyQuIDOn0bYypwn2mtIEtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wx3ntUihgoMedUeoMYQB/OGIxneiz24o/qEAwOgtN5g=;
 b=LUWjdxgmoKW8d6ddMLm8minIHBJiFatmx+NEi8kAUzU7DK+Iezo6MEmUKyRdfbuha/uoSZA77XR9oBF5MI1hZXZiuhaLxCM4h73nErHiKgqNqmrmZniNh9qHMtuCZlWl4Hz/zXX/yO6l4q3ehRoAYGq3cvGGQxqrBSfwPbEYo9JQQ3ogytb/cbpeWVcW2idj6+iNIw9DBf7KBw5BSUN5lg/AgPZCtElHkp9aXRKl+HqeQNVbl+mT0NyQbtihc6fR8qRbdWi9WC5Zcm+VNlzBShPBm3G+I21hWw8yOOPK5MGed5mKijefVtZgncZyB2/V1dfixBtBWYuNdvZ+BDssDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx3ntUihgoMedUeoMYQB/OGIxneiz24o/qEAwOgtN5g=;
 b=hsYdw1jcPGBDILXvzXpSobc89FLJWHQqFt/ujjfY2yEsRvohTi5hPbb0yIS+GQEeq5IVY0rgewsjf4Z3cNjEc8IavB4mYRgMQHjtVyKnHUaJ71nX6AF+42nZPxIhQIOkJn1Z9pe7ondBdyTBrj84Mb1h8Ea9/pbrngwAaKmHk+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB4858.namprd11.prod.outlook.com (2603:10b6:806:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 18:47:42 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%9]) with mapi id 15.20.4669.022; Wed, 17 Nov 2021
 18:47:42 +0000
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
 <YZVHaeuYL8QD/7db@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <44f1be15-5e16-38fe-392c-b87a29451318@intel.com>
Date:   Wed, 17 Nov 2021 10:47:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <YZVHaeuYL8QD/7db@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW2PR16CA0058.namprd16.prod.outlook.com
 (2603:10b6:907:1::35) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW2PR16CA0058.namprd16.prod.outlook.com (2603:10b6:907:1::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Wed, 17 Nov 2021 18:47:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d973782-d5ec-4861-ae6c-08d9a9fabcf9
X-MS-TrafficTypeDiagnostic: SA2PR11MB4858:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA2PR11MB48587B3FAD9D51FF6CC652DAC59A9@SA2PR11MB4858.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DinRMXlRpk4MScpjbigmvhQzTCM9gPT661FIoz7vT7wyVsX2YOP6fNPmMy2HYLPk67Dkuo4ynKcdhtmcjgos4YMjjLNUjMDm9dZA3WiZ+n02z8O5NBcPC2gHQ2D5Sppgx932FJCAQi/loeuhtPDxpmjVy7j9KYTJDhb8OXYcReq7PpECZczA2dUBDv/V3gLXlStmAiNONveY1nAq+KbT04P1rWgiabFoC+YRnMttG+QwSMElvPJcAOnUPTOE0uYkpsHhZ+kP66tR7tsrTtysl0lPJrCo4rvuVBd1etRfX4Ik1hWf4DquJfk01KUhXsnvFzD/Yd4teKi1LcHAsAaMgXdlap2m3rNOAEIs5QkBM8suHjR/anBAg7EOOFmcOvmophsQPr8WPwtcx0kwWYyuRkHeltke+X78uOv+ajaPCpJahmTLtgNbb5jSh4tUmN7/hvpu9YH3ECKZo2Cc0tDq0akEvNZrPD7vKfz1xkOCD3gGUzcapl6068Byv1iBLt6FvJBdooODi2fZuPl+5JQbqEbBdSxqmNDh9ogDclD0BWO4mH2w8KOw0uCL0XR3cvgFmvhJXGbunkNsr28gDHoPyp9utRPoJjKSOk8MLiyF9N31SzJtZIhsYNSMSjPZX1DJWm+YqcSw4SvwDL8BAFd0OJ75QG7SnVv4rRfHFnba7pDTYvrrOCQqYDqtUV8xzvS1stNcBMVN6KuRXlvF+yK+NYJGFE56znaIWL0l+6E6D7eXAwoivfynpK1qIg2Iz8b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(956004)(107886003)(66946007)(66476007)(66556008)(5660300002)(316002)(2906002)(86362001)(6916009)(16576012)(82960400001)(36756003)(83380400001)(31696002)(31686004)(53546011)(4326008)(38100700002)(186003)(8936002)(6486002)(26005)(6666004)(508600001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YS9ZcGh4RVFxY0dkMHVLcXdkdXJGOERGSlVHY1k1bG5nc3RWTDdlTTQ5UVRE?=
 =?utf-8?B?SGZ2YjNDL0tpQlJaQXlDVXg0dkpCaUtWdklGTVNmbDRsL2lqRlJJNnkwYW4x?=
 =?utf-8?B?bGYraUhoRmRuSzBhRi9JRFMvU0YyZkVkNUhBM0d0cGF5NHZHc1RYSFU0TkF4?=
 =?utf-8?B?d1NQbEwveWtYQ3VnVXVNNUgzUTRpekhzMnkrSnpEeTJxUXc4UWxXR1RqU1g0?=
 =?utf-8?B?c0U1ei9MREpJT2E5QkVoUWp1Mmp0bGN4a2JnS1FOcnBESFl6Qm1NVnRxSXhv?=
 =?utf-8?B?NDVmWlU1bWNGTzdnUCt1K2FHc0RVWHFFUUZ1em5ZS0pZK21XRG81WDVyMzlX?=
 =?utf-8?B?VVRndDlBTEVJVEd1SWxtc1FQSTdlSjFuUUo3bGxkeHFkMWl1MlV4NHBQUjVi?=
 =?utf-8?B?bVdYWXkvTktCTFkzWlJwOFNvL0xoVTZNUWkzakxZOXpMS1VDNlhpWnBpeDhQ?=
 =?utf-8?B?RzhBV3l4b0JZbUV6WEdGKzNOZ3I5VkdaYW9ZUGVYTy9MVWo2a0RKWks5QXg2?=
 =?utf-8?B?aVNxSVVZL1AzTkR4eVc5SXY2Um9JcmNnT0RHNW5rVEJ3aFAxTGpZcW5IVkY3?=
 =?utf-8?B?Qmt4YVFlTkFWOXZMa0FVczBRVlJ5VndDMXlLeXREUmU1di9KTmhkMkZKZkJ0?=
 =?utf-8?B?REVxUUw5ZXNhQ2ttdnllU0pVdjQxVHhicDhTOVhRQjZqd2RhMHdXVzNBTXEz?=
 =?utf-8?B?VjZKRXRKeFVBRG14TEZieGNHcVVMV1JUa1RrVDZJMVg3Ti90YnFlZXpWZGpM?=
 =?utf-8?B?OG90N1luSjRqb044OGcxYnpFWHJSa05yQTZTdXBuK0lHb2FDd3NwUmZZYVdz?=
 =?utf-8?B?Um96ZmUwdFFoRVlSQlBtUW4wSDZxK0s2Ly9QcEREVDM5UmRsZHB3RnpPVkFr?=
 =?utf-8?B?QitTRlhkTnVDNit5M3FKdkk0M0FaVzhyK3pvbTFJT0pQSjZtaWIwOGJsMGgy?=
 =?utf-8?B?N1dSM2p0cDJVRTZPd1NvRE5NcjQ4UHVoMHFpZXhwdUdhbDhrNmszd0ZNMkQ5?=
 =?utf-8?B?T0pxQmlpZkorM3p5VFlGMUFuSTZKUmpDSk5OdWhxbU85RHFPdUJrVUE3c2pH?=
 =?utf-8?B?YTZZbi9BaTcrYUJ0UTZXbGZqKzl4M1BzbUY5NGpDbTduS1I0am5ZOFRyTkp6?=
 =?utf-8?B?dHpYSzl0Z1NWZGF0cU1hVkNCenBDQVUxZzViQkdaRUVHb3JQNjRsVzB6VXJp?=
 =?utf-8?B?NFBGalgydGVaeW5IQU4wazY1OGxhU2J0ZXEzemtKd0dwTlRLT2NGUWVIOUtL?=
 =?utf-8?B?VmNCMFg3YjdwbEo5TmQ3MW5mNEg5eElheXJqTXVheXFERnRLcVg2T3o3bVBO?=
 =?utf-8?B?eXlHeFpLb1BONjZjcUJPMWlmUDdXSkcvQ0Y3Tyt2bHl2bW03Y3Z6UmtBZk0x?=
 =?utf-8?B?eSthUkFzM3QwOHNwQ29rTk9Ec29TalVneHg1NEJEZUpOQi9IbVhVbUZMeGRG?=
 =?utf-8?B?Y3QyVk5TbkFvUFlZSGY3NVJJZCswZkR2NjlCRk9WYmZFM2hzR3lCRjVVSU83?=
 =?utf-8?B?ZGRaQ1ZVczkzS2tieE9aOTdnRkdPc1FBN1A0VkpTKzEwZDF3ZjB5R3FCSlIw?=
 =?utf-8?B?aG85U3lZZUFSK1EybFVTazU2Wm8vNGZzZytxdDB0N1BWc0JmY2dxamp0ckR0?=
 =?utf-8?B?MzRIUzg3bUhFRkVQaTh5aEZVQmxVNUdRRE5jcW5JQi9EMG81bnpUcXpCQlM3?=
 =?utf-8?B?c1g5Q1JHZzdEaU56QlNVVVZFQTVlUDVoaHR3NFJSb3pzai9KVEdFeXpUeEo4?=
 =?utf-8?B?eHJhS0xucHY0bzI1aVZuOU5lSVRnRXhIMzhHOE43OHIzWDg5WENrcWNQU3dO?=
 =?utf-8?B?dVRhNjhFKzZXb0cyd0c1eUtxN1RxU1NUazBndDRSVjNMNjNNVmlFNzNTQ2RX?=
 =?utf-8?B?Mkhzb21xV0FtdnU1UnZpUWV2NDZraUZ3V2VrWUZ1d21tV3dkL2NmNDd5NTkz?=
 =?utf-8?B?VjdMemZpQlRJb2Y0T2FnYVQwRDJLaFVFdTFhS1N6R3BxS2NYdmxqRFJUdy9u?=
 =?utf-8?B?ZDR3VVN6aGFib3FNajVOcFQ0aGg4S0U3K0ErdVdBVnZHcDdjaCtVaC93L3Zl?=
 =?utf-8?B?RUF6RWdkRjM3OFdycGN0Z2VIazNLN3hHWVBNVW9uRmxqOWdJMVhqTFg2a0xh?=
 =?utf-8?B?L1JFUXZVT29KdTBBUnlUNmpSTGwwMlVMWTk0L24zSENUVFhuTm1uOXZOazhk?=
 =?utf-8?B?aElwYUJnSUlkalFnYUwyVHZjVFdqcXhhR0JLNENGeGt4Vk4zbW9yRnFTNGtm?=
 =?utf-8?Q?qFPz0Uf8AprawszGlEXgX/P7Dthq7his+mLvdZu3/0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d973782-d5ec-4861-ae6c-08d9a9fabcf9
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 18:47:42.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pWkcF3c87CUbFMwt9ScRP6xKoa0KlmGv1GeEi0inHGT46lSlaw2ZITuSLhDQGzB2tt2RhH7TGLKnsO1R+dfGrB5YUL/MRfN+7+DGpA77Ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4858
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 10:18 AM, Greg KH wrote:
> On Wed, Nov 17, 2021 at 10:00:54AM -0800, Russ Weight wrote:
>>
>> On 11/17/21 7:15 AM, Greg KH wrote:
>>> On Wed, Nov 10, 2021 at 05:13:41PM -0800, Russ Weight wrote:
>>>> The Firmware Upload class driver provides a common API for uploading
>>>> firmware files to devices.
>>> That is exactly what the existing firmware api in the kernel is supposed
>>> to be accomplishing.
>>>
>>> If it is not doing what you need it to do, then you need to document the
>>> heck out of why it is not, and why you need a different api for this.  I
>>> do not see that here in this changelog at all :(
>> This is part of the documentation included later in this patch. I can add
>> this to the changelog.
>>
>> +Some devices load firmware from on-board FLASH when the card initializes.
>> +These cards do not require the request_firmware framework to load the
>> +firmware when the card boots, but they to require a utility to allow
>> +users to update the FLASH contents.
> There's no requirement that request_firmware only be done at boot time,
> why not use it at any point in time?
Calling request_firmware() is not restricted to boot time. But it requires
a firmware filename under /lib/firmware, and the convention is to specify the
filename in the kernel config. I don't see any support for a user to provide
a filename at run time to be uploaded to a device, and that is the use case
that I want to support.

>
>> When you say "existing firmware api", I'm thinking request_firmware, which
>> requires that driver names be specified in the kernel config and wants to
>> load firmware automatically during device initialization.
> It can be used at any time, why do you think it's restricted to init
> time?
>
> And I do not understand your issue with driver names.
Sorry - I meant so say "firmware file names"

In an earlier iteration of this patchset, you pointed out that allowing a user
to provide a filename for request_firmware() to use was a security issue.

The use case that I am targeting is to allow a user to provide an image file
to a device at run time.
>
>> Other support under driver/firmware is specific to certain vendors, devices.
>>
>> If I add this information to the changelog, is that sufficient?
> Nope!
>

