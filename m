Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48AE42E1FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhJNTZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:25:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:21267 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhJNTZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:25:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="228057873"
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="228057873"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 12:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="461312106"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 14 Oct 2021 12:23:49 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 14 Oct 2021 12:23:49 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 14 Oct 2021 12:23:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 14 Oct 2021 12:23:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 14 Oct 2021 12:23:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoRZ5O3k1eve2TkkXhGzJSqXe9eeHqLjyNhw1NmfeW6fpXIs+s5m4dk7E8mrLyd1ItME0NYwJw2LGdpzLEFBPqIKNNQDSWE/PjurmTy7Gcf1vchnSUERZv974/rrvwrBeM17/HsXkbOEE6cdfBn9VFcDwlykHiskxQvyc8OI5FRos+poC8jt78LPolOWuPe58J1WCWlCRVVfUb/hOlOECcnaupaOAB0Mspl/XJZIfUbV1hYuMVh/42jw78YVkTxdGtam9Tbw5cNqPGL9ifI/8XrLPRKrqCHcxfKUoQPDhzzc8CEgZ1fqxEuPCXR3OXYq1C8I1+wke9pqkZBgkilQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL9TTkGWvbQw6eSgTE5aAx8xr4igtqMc/xNyhnDPZpE=;
 b=ZaG2nJXV9p7m8OBhoR37pf7ZWAWjh6WpakbzCsqn3dsbq3wHH2QqKoPX4Yez/dn98NwZONgbvdaHa8a59c8nfSOyDxAK+DaqUfhz3CVMgdxj9idHidPh6BMAxSwYSl2/XY/BE6LTRLH45/OzAtdKTPU3B4zuf64+/zutsxagqmDTYtSTxeiQ8oJ5VxT4OBlqKLiU2tk1fUYAKoaBpwV9gvkBaAekkrWKi08rV0rV+gM0mcVMqNShB0JE3qgFeIO93Odr70s87LX4jrpss5rDT2OIrLeVKnHWzHevzllKovSorOyE+h4evCrscf/WyhZu2qWFz1T//u3FeNf5DiubWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL9TTkGWvbQw6eSgTE5aAx8xr4igtqMc/xNyhnDPZpE=;
 b=mo++YHJR8g5D/uxS8WSp51jXg4yEwjbR9P05bkEevzMS5Y59QJLKBRpmLKkO7drShR2rqJBQz2Ech7qhGrnc5SGUwHNHICc+mLBkaCwjxwxaWp2b18unabiDV4fv1+UQfS6fIIHSObybR1fG23vS1+5C/hb4gFBf8w04MboQs80=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) by
 DM5PR11MB1404.namprd11.prod.outlook.com (2603:10b6:3:c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Thu, 14 Oct 2021 19:23:43 +0000
Received: from DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da]) by DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da%9]) with mapi id 15.20.4587.030; Thu, 14 Oct 2021
 19:23:43 +0000
Subject: Re: [PM] bfcc1e67ff:
 kernel-selftests.breakpoints.step_after_suspend_test.fail
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <lkp@lists.01.org>, <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>
References: <20211014075731.GB18719@xsang-OptiPlex-9020>
 <51c0a15f-1941-f161-dcec-a7a9acc726f2@gmail.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <e526de16-5efd-6474-20e1-3f96a2e3c524@intel.com>
Date:   Thu, 14 Oct 2021 21:23:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <51c0a15f-1941-f161-dcec-a7a9acc726f2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To DM4PR11MB5326.namprd11.prod.outlook.com
 (2603:10b6:5:391::8)
MIME-Version: 1.0
Received: from [192.168.100.217] (213.134.175.183) by FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:48::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Thu, 14 Oct 2021 19:23:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9a169fe-7b7f-443b-ecee-08d98f4822d2
X-MS-TrafficTypeDiagnostic: DM5PR11MB1404:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB140493573A1FCD4FB158DFD1CBB89@DM5PR11MB1404.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVj4RCv57KnfItdEoStUF4+Ly4S4GBnkSPB9JYm2dpJFDFasr2nCbEUgfJnwGp9BwXcK49a66FbY4m1LTs8cI/u6QfZ5Sx8S+L0cdOPrfHgMy0VwQfE+jvNVoUur56OiG7fuGvIPjj5Y5pD+Kv+XYMIEnON+5zFm2q+jbnAqIj9WLELLxWiOCa1UI1jckmvF0iiCrvc760fxoppBJSMMZH5IvvLjWlOwiniLXCCcM+DD8nGfetRcsuqsXvX0tUfvW3qPnVRb+QwyH8BpoIV7wgy4Qnd0TmYvmcvNefSnrEQdiyHKLFUxDu2O0c8EY90r4gPNzcEPmRXVZIMoGKoTyjktAHOm89EE2bdxfCIgsiCPlmxULKe4OphIOMmP3ijNLALfuFFArW1RPhVVXvBq2/WQ7kwcrtCHzed+aBKRZXWlxgwOmlP1JXVRlS030NZyS4Qj8+ks69x75gHn4SRM8fqmjN+larlKUhLJXg/WwNWC0qBmnJvVmOFsiUqHoZSS0J/dE0hDWaxntnkTLgYwdU6VHyykUmVs4mBBX+ldl8WptzguW2YssDg6BeI5Oio4PS2nGnGSGx6vX0Se7phPQDke0lDtJdhHMEX2oh/PtBvK7e3tfvgiUVU5qYl1uKtWuzE9VOXS2YwnQ4w6KzLTZl24p2LMnZoP25k/vO/J2D2s3C8z1NZJCx6kH9WmOZL96EzPPLvTMVnneCDGsucizupP6k1wPCHIeHdjIvlXuXOs/g72I+bD0y+9XfXqndabLwxGxJEfgu33HEYaxffqc97xE07OWw0dBNjvjaOxxbvcpce/d2aQSxw8l6/1kBHrJleuZ1dquGjRggYFPNAEPo2Gx1wEsgVx+Z+oKSEbp48=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5326.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(31696002)(5660300002)(186003)(966005)(107886003)(86362001)(83380400001)(82960400001)(8676002)(66476007)(508600001)(53546011)(66556008)(36756003)(4326008)(66946007)(8936002)(6916009)(316002)(2906002)(31686004)(54906003)(6666004)(38100700002)(2616005)(6486002)(16576012)(36916002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1BVYlFYU2R5K3pROTMrUzcxTlBMUmNlam1IVjN1VDdWVlNXc3BjMVhjR0dL?=
 =?utf-8?B?Ky9sRFVKemhlTXJERDU3K1NrUTU4Q1pnQUxac0lmaVB0TW9vNzhRUi8zZGVD?=
 =?utf-8?B?Q0lOS2g1WS96R0xuc0FHZjcrNTdJVHdjWDN3bG5HY3BRTG5YcHBpM1huOFBU?=
 =?utf-8?B?VjlNalRlcVdxYjl1Y0h3Y1VDWkN1dDEzSDFGSVJ5aXRYRkN0UEdzSEQ5bTdr?=
 =?utf-8?B?NTVRYkwvdFc4NWZJZXAvYW8wNGxrVjlQWWwyWVNuVEhPSlo4THB1R2QzV1Q2?=
 =?utf-8?B?cFJUc3orK2hMRkxpNjMvQzA3NHdmTXV5WWl4UitTaXppcmlNbkdsMCtrMmd1?=
 =?utf-8?B?cGR0QzNXbEwyREU2VkN0UjY0NjduZCt6MHFzamdUUVlMNk5QWTVTRC9xZ1hO?=
 =?utf-8?B?Z2tudE1KVHNRMVc2WUVmSEo3VDdKemc1eTlybWdkVkd6cjZFVnQrWllpNGVp?=
 =?utf-8?B?VjVINmZFOGF2ZnpDZjdRQlNNblVrdUFsU1BadG56ZUNReG9NTzlFOEVHbzAz?=
 =?utf-8?B?ZGpGOEpXT1JydVZMWUE2OU9WL2VUNzZEaFRFNDRTRzE0ZTA5WllYN3V3V2pS?=
 =?utf-8?B?akxlaGV2ZDhNK0psaUhabVVVNXFxRGI1ZG9ET0c3SFVHZlFhYWxkcFJVdWxZ?=
 =?utf-8?B?ckIzYnd3RjlqTkpSb1U2c0FTN3ovSlR1REZ2MXgzTThFdjU5VTNzR3ZYQitX?=
 =?utf-8?B?NFg4WFRKdEtJcVl0MzFvQnhWZWN6ZDBiYU55RVZ5SWpwYVc3NTZqN3JjSDJ3?=
 =?utf-8?B?UE54M3FKUStYa2NzbmZManJuRUVPRFBGajFmN2R2cjA5WmFXWE1vZS8veGw3?=
 =?utf-8?B?Z0FlaU9KSkp0NWswaFFmMzRmcjhGbmFuQy91MHY4czh1WnVoUUtyckFybnR6?=
 =?utf-8?B?c1pBYTJOSyt3cHBMMGxiOVo0NFFMdHorWkVxWUJhM2VWQ1p5d2oyVVVFSXUy?=
 =?utf-8?B?MkczMHhVMTgzSDRLYzhXQ2MyT3N4TzdOSzZUWEFSRGJHK0JwL1dtM1lLcHhY?=
 =?utf-8?B?a3ZxT2JHbWM0R1VYY0dhVTcrVnZockI3NVBTUW95a2l4K1dETE5YU2ZwYzFx?=
 =?utf-8?B?clBaU2xLQURvcHBzY0VLZFUyNUlUWktLdkZIcHI5VWxJanFyaTMxL251bmd1?=
 =?utf-8?B?MEJMb2ZBOUZ2Vi9qOFJsRWVyTUp6VWkvanR5VTVEZTREa2tCYjAvRzhJQjcz?=
 =?utf-8?B?MVpNb3FTeitjR1d6RXV2Ny9qZkQvTDdZenFydDVGM2ZmZ2pTUWgyaVJMSFRE?=
 =?utf-8?B?RXJOV2x4SUdrQkZrRG5HMDZKQ1hmQVZMaktRaW1KNFhoU3YxeFhwSzd3NS92?=
 =?utf-8?B?MVRuOXlzTFdMa1RCbmZsWkRFM2REL2NLWjJQRFp6Z0JvRlJDYmJWTjJQQVZK?=
 =?utf-8?B?NlR1cmdvR2hLeEgwcVYzTG1kbGRDVkRGOWkwMGxhbHBRY1M2RUJyV1ZhcGVz?=
 =?utf-8?B?OFI2OXFqcDJqMXdXa1dUVnd6SXRjdFdybFB6R0FodENEQnFJMENFaGJkQjNn?=
 =?utf-8?B?RXdBay85WlN3QnJ6d1NGMS9oOFVhMVdSdDkvSkpsUGRpTTVqTHM1eEE4Ujlu?=
 =?utf-8?B?WGk2RWJ5NWxOSEJNL29qeCtucTVLeWNDREFZNUc3V055Q0NES1JtcXVyV1Ra?=
 =?utf-8?B?VHJpdEI0eVE2NmQrVXd3am1mbm54dVFIcFAvaXlVaG1iQXliYlZuWnk3RUFL?=
 =?utf-8?B?bWtVcDJZTVJXenBoVkRwODVxM0dBc0xzcGtWS1JueExiZllDalVBYWlzT1Vz?=
 =?utf-8?Q?EaIGv4e2tP/MTjlJ8LljGhbAchr13OnO+O+7Z1q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a169fe-7b7f-443b-ecee-08d98f4822d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5326.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 19:23:43.5386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/EwRlDBhCTsg74eemTljcmf4vLZ5y0aphW5RCjD+sLs/qiCJQnMpNoWKEbTas+iouDzIjp5U5Gw2sQ9gyV6jXyMskQ2CNZvf3GGDb+07U4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1404
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/2021 6:26 PM, Florian Fainelli wrote:
> On 10/14/21 12:57 AM, kernel test robot wrote:
>>
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: bfcc1e67ff1e4aa8bfe2ca57f99390fc284c799d ("PM: sleep: Do not assume that "mem" is always present")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>>
>> in testcase: kernel-selftests
>> version: kernel-selftests-x86_64-c8c9111a-1_20210929
>> with following parameters:
>>
>> 	group: group-00
>> 	ucode: 0x11
>>
>> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>>
>>
>> on test machine: 288 threads 2 sockets Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <oliver.sang@intel.com>
> Thanks for your report. Assuming that the code responsible for
> registering the suspend operations is drivers/acpi/sleep.c for your
> platform, and that acpi_sleep_suspend_setup() iterated over all possible
> sleep states, your platform must somehow be returning that ACPI_STATE_S3
> is not a supported state somehow?
>
> Rafael have you ever encountered something like that?

Yes, there are systems with ACPI that don't support S3.


>>
>> TAP version 13
>> 1..2
>> # selftests: breakpoints: step_after_suspend_test
>> # TAP version 13
>> # Bail out! Failed to enter Suspend state
>> # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>> not ok 1 selftests: breakpoints: step_after_suspend_test # exit=1
>>
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          sudo bin/lkp install job.yaml           # job file is attached in this email
>>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>          sudo bin/lkp run generated-yaml-file
>>
>>          # if come across any failure that blocks the test,
>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>>
>>
>>
>> ---
>> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
>> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>>
>> Thanks,
>> Oliver Sang
>>
>

