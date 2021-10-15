Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C15242FB62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbhJOSr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:47:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:49006 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241132AbhJOSrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:47:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="208081904"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="208081904"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 11:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="525520931"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 15 Oct 2021 11:45:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 11:45:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 11:45:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 11:45:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5LxXvU8kHSA6JRSilNSPttTu994QJla6dtjQZrh6uYrFuDsRgV1GlW7yZm2XzZqnAmIgVmv7T4bX1LLWF5m2V2BNHKUSGjX8VKp5hPUbD0whMzMVt+YtHJlJAGs7SWPh5BCm0ABYV3L5PvTtZJRGZ8wodFBwF03GiaDMLW0cr+gJgueEfGvACK8Y+e/q0paSiqCGO6L7+eYU5uItRp1OdJy4pyg5pzsk8bN5KDdFBz0Fpq5sltk9y5FZn3eCx2zuoL420P0kgYAtjMLMMRoSnoYVqbSiMC+O/lS4Xr1NogLO+uo4H/ZihgE6Iqe0iVt4IDQugQfWkfv9EyADwzOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coz8zqOVe1rFPsM0mjkqJunE8OpQor8c6ETySe/ezCI=;
 b=EAAJHYZY/4zDi0MrO8QW4NMaVdXxO/o/l5ULsKxaiwVWc3Lw+uDcJHi34E6jZS1ZJzQQvCMFROBntyB8GQoV90RPqxJUGPRmC0xCodCyNKIZ9azes3btWCHOYlqZRHXM+zuJDF32mfBJBftK52m0e8MJeBAV2vqz/Nae8MPxcgCzfbwiqgVJvzUUaOMNg5guEHqG2tBM0O8jPrnGI94BXYoMdDUurI3WXv8rk7aYrI9bZXy+vqdWAECDL23uLZ7PzXunMJ5Amtc7lQ41Ex668hM2TQvx8Q3TijrM/NVtEc9t86YDhACRoSG09EVYihVgqss2oPIuAc59YLtNbynx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coz8zqOVe1rFPsM0mjkqJunE8OpQor8c6ETySe/ezCI=;
 b=izUx80Rzbze/W7iIfUyL3M7sBSZ5VnCECHlufVRqtdN7L/u+i+uYzM0avFG+AvGYaD3RQQHtNrgR84svng9ejTZnDyvfKr/RveEnLp2TsFFA9E1mhsVwTbrSPO0eAJxgINIbpf8YNrhO1R9BKRaIiEiWNv60Bew6MbPx0L9Y7gU=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) by
 DM6PR11MB3851.namprd11.prod.outlook.com (2603:10b6:5:146::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.20; Fri, 15 Oct 2021 18:45:43 +0000
Received: from DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da]) by DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da%9]) with mapi id 15.20.4587.030; Fri, 15 Oct 2021
 18:45:43 +0000
Subject: Re: [PM] bfcc1e67ff:
 kernel-selftests.breakpoints.step_after_suspend_test.fail
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <lkp@lists.01.org>, <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>
References: <20211014075731.GB18719@xsang-OptiPlex-9020>
 <51c0a15f-1941-f161-dcec-a7a9acc726f2@gmail.com>
 <e526de16-5efd-6474-20e1-3f96a2e3c524@intel.com>
 <6755cf07-fa5a-cbb7-c076-57c162a08c99@gmail.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <d3cf18f1-2af7-5e4d-abe4-c882f25bd5c3@intel.com>
Date:   Fri, 15 Oct 2021 20:45:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <6755cf07-fa5a-cbb7-c076-57c162a08c99@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR0P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::6) To DM4PR11MB5326.namprd11.prod.outlook.com
 (2603:10b6:5:391::8)
MIME-Version: 1.0
Received: from [192.168.100.217] (213.134.175.255) by FR0P281CA0056.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.6 via Frontend Transport; Fri, 15 Oct 2021 18:45:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1660fd3-ab73-4b54-7b3c-08d9900bfe16
X-MS-TrafficTypeDiagnostic: DM6PR11MB3851:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB385181663CF27E2449BC63D1CBB99@DM6PR11MB3851.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wX/doAin8M3iSJxAv7XeDhM0KHIosSe4uxOqBOmVEvtEOkalWrcpMtyaIfVsUDRvQqHCRkFUpP6F1Qu/4x+JXvfC3nS88i6QaB31nH1oLXDSCOBxl04WQYGUdbCQym3b9XUE79pPz5AiBjmOlY7wB4Asm6tWhPkL2XkVD7+Y3hgg+Ph5vJCWTxdT6ulxeaRVnyW5EkrmqHOAXWM5SkYpOVw88h0EWG1/KG728B+6JcdshJV8zv58Qqz3AtKK/BxRqGjh12BRfQsPNrfOIlvWQa1uREs3EHDLqJmt2OgF0tejlHRMJG/MvFBSsCkeB+f9vJ4oq6rmhEdcGDucP3l1/c7yMpXCaCZHAeyzK1LoFazsQMLGa10c73TqgoN9dn2rZoGxqwjbeWPx8bLzV2cehPssIpOaGueVwG6Co87pVExhFAw4nEKLiLSVKu3sAKAtntsZOnUZS45aujxGAGhB0MAZyBvYgdFZnPnRwGTB7VV6wGwDazdDbKmJy1N1ZyAlzn31tsVVHRxgIoMjK6m2OJBx2gYL/lNfFy08cSClSH8JySmQoGpxWG2QImQ9voNcEUuSGpIgZr7dprifNNoPCAs4ufnTKuZ5a2HEINOWPbypcrATi9ZNlCOsKCSx/MgdQhlu7W9Bqz9uyL66loARZjeuFzQDOAhFHYlsQsjLokp615n8BtaOzmPuG6T6RIQmJw+tEfWPTgkoLR6YuXuAkRP0UD+TpT5cVelb7UVNqS5rpk6YYkDjOqDoP/BtESeX+0SIAyairfo2VLrfQf+EpI9i+ZXpXuFEeqTrUih2VI09wcPtYFSaMEC/9nKRdCfQt3WU029kFkK+ku0DL+91RufxTntcQrcNG/hqgq0zEDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5326.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(6666004)(4326008)(86362001)(83380400001)(38100700002)(8936002)(2616005)(6486002)(966005)(82960400001)(8676002)(36916002)(31696002)(54906003)(186003)(66946007)(5660300002)(26005)(107886003)(66476007)(66556008)(2906002)(53546011)(16576012)(508600001)(316002)(31686004)(36756003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVQ2T1JBY25menJzakI4Q2swVC9XK3A2ZVFVRzFMamlRQVcvczVCdWliaXE3?=
 =?utf-8?B?MjRkTkR6RUxqamR3NEV5anBTL1luVHdrc0pFZm5GcWFTaTlBclRmdmlRSW9Q?=
 =?utf-8?B?bU5hK2tRMVBTZWdJN2JSUEI5T0NjajVudCtBclB0NXJZWml3aFd3NEVxQkZY?=
 =?utf-8?B?SWFBKythaUFadlk4NElkYlQ0ajd2ZEw2aGVQbE5XZldHUFQyaXZKMDFETGVs?=
 =?utf-8?B?UWdGTkpuc1FlZkZHU0s4RERBcnp5ZE1OY00vZEd4NWp4S1F0cWxZMTBWaUJq?=
 =?utf-8?B?Vit1WlFQS3laWE0zV0luMW5vUVZNYmRGdHIxVW1Bc3FXNDR3T3hqL2x1V0hQ?=
 =?utf-8?B?OVlvOFV5Y0tadCtTSDdVSXNQZ3R0d1laeHJTakR0R1JGZkRQdVYzUFdEMUNQ?=
 =?utf-8?B?anoya0kyL3N4UGxKUnhWMys5VHE2VWhva3NnMVF1UXhad21nZEpaRVlmU0NM?=
 =?utf-8?B?L1VpN3BtRzhzaVJzeUdYSVk0UGFqUVM5MkdNYytvTW5tWWxqR2svclpNTHVv?=
 =?utf-8?B?Z2p3WUh0bm5xVjJVeDYvOGtPb3JUK1AxN3l3Z1NQbkR1ckFyT2VYUlI1bklk?=
 =?utf-8?B?Nk1hR0l0djdsQ0xDbFN5ZHJPODQ0WDBBWEtCN1orODhDSXA1QmlHaG5NODhw?=
 =?utf-8?B?M2Y1RTFWUmVicUNCeHppa0Y5M3NzOTJ3V05IbTZaZThoMzl5L0VHOUFkRE0x?=
 =?utf-8?B?dWNlSSt3eHk2TS9KYVJrcTgzdmxvODlOcHlWZTMreWNBc1ZOcmtTMGJlS0tz?=
 =?utf-8?B?SUQvbjk5RXkreDhtcFFuRmVkZ1kxTVV1bGdTdXhLMUNsalY4NXJocVV5NEdW?=
 =?utf-8?B?Q2VpUjZFOXpYVGpWVWY2QkdOZ01yenVjRDJPTEtkMkZyZGdENzZIeE1BTnRp?=
 =?utf-8?B?UHAydnptOUNkcWxST203QXl6MDNjaW4vZ0pCanp0bDhWeWRHQU55d01GY3Fo?=
 =?utf-8?B?ZnRyeHV3Rzg3Um0vaktrNFlOTXh5VHYvcW1kWU5UZHQ3dTgvaFEyTUhVRWl2?=
 =?utf-8?B?Wm10VXlvT3RGN21ESlJiMzJ5cjVMUER4Yk5wbnJGOTl5OFpSTnk5WHJNbmFP?=
 =?utf-8?B?N3RzTkNmZkZndTg2ajN4QVdVRWl6NThGd2tLbWJIdXhZVHQrTEdIWlVINkZX?=
 =?utf-8?B?S2tHOG95eUdzYmlrVmVEZ013Ukp5QnI3a0ZFSzdEMHMyS1pqS0ErUWVDSmJw?=
 =?utf-8?B?S2lRdzFJS3BFcUN6V0R2NE04RnBTZllOZloraE5ZejQ0ZnJaeDNra1FzcGRT?=
 =?utf-8?B?NzgvVVpiMnNDUTRNUlRXd0xnVXlPbkJwblpUcDJpNERjWHJHeHBmVVZkRHZn?=
 =?utf-8?B?elJwbWhUMWpLRzd5OXFHaTFqRXh4UmhsUkdoTG5FUk1qNmNTaWhIRUg1RU11?=
 =?utf-8?B?Y25EL3RUQk4zQ0VqRTVjNHNpMEs1SXo0Vm42ckFVRUxQc0pmZG5hTlgwa085?=
 =?utf-8?B?VjZwQUNyeGE1ZGdZSTZQaHB5NjNWQXYrQVc1ZGtVYS9wOVZJVUFuakxtN0R0?=
 =?utf-8?B?aCtSbHpWeUgzM2RGT3dsSktJQ1hZbWhMTCtSV0Nmc1F1NGpHVkhhMWR5RllT?=
 =?utf-8?B?UXZLU0xDaVlJK1F3SVl2R3NnVncrSnNpU0szNjNtdFJtSkVUd0w0Y091bWFi?=
 =?utf-8?B?OGlibUxjQ2FRaEpXckd1dkR4RlJHQWt3WTc5TlVIZm5rbUlCZ0pPRisydUh1?=
 =?utf-8?B?ZmVjcisrNDQxSEdUUjBKaE01eXNyUFM3ZjFIZFZqVGJmdWNlWk8xYnkzbVdS?=
 =?utf-8?Q?NFGLDGOvReOo8oYXDnhkZVxvKpXDiZqAzk+FpMV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1660fd3-ab73-4b54-7b3c-08d9900bfe16
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5326.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:45:43.2567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNfO1ZjjuYqeBvNlp4NFRI9HOb7hgxJ/AMu2d+J63glzjRsh6EhEQ3ajv+tG+BWamZCDjhDvzjVTtnFF9CetBGivRex+3FyCnCHCgzdEOHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3851
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/2021 11:55 PM, Florian Fainelli wrote:
> On 10/14/21 12:23 PM, Rafael J. Wysocki wrote:
>> On 10/14/2021 6:26 PM, Florian Fainelli wrote:
>>> On 10/14/21 12:57 AM, kernel test robot wrote:
>>>> Greeting,
>>>>
>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>
>>>> commit: bfcc1e67ff1e4aa8bfe2ca57f99390fc284c799d ("PM: sleep: Do not
>>>> assume that "mem" is always present")
>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>>
>>>>
>>>> in testcase: kernel-selftests
>>>> version: kernel-selftests-x86_64-c8c9111a-1_20210929
>>>> with following parameters:
>>>>
>>>>      group: group-00
>>>>      ucode: 0x11
>>>>
>>>> test-description: The kernel contains a set of "self tests" under the
>>>> tools/testing/selftests/ directory. These are intended to be small
>>>> unit tests to exercise individual code paths in the kernel.
>>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>>>>
>>>>
>>>> on test machine: 288 threads 2 sockets Intel(R) Xeon Phi(TM) CPU 7295
>>>> @ 1.50GHz with 80G memory
>>>>
>>>> caused below changes (please refer to attached dmesg/kmsg for entire
>>>> log/backtrace):
>>>>
>>>>
>>>>
>>>>
>>>> If you fix the issue, kindly add following tag
>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>> Thanks for your report. Assuming that the code responsible for
>>> registering the suspend operations is drivers/acpi/sleep.c for your
>>> platform, and that acpi_sleep_suspend_setup() iterated over all possible
>>> sleep states, your platform must somehow be returning that ACPI_STATE_S3
>>> is not a supported state somehow?
>>>
>>> Rafael have you ever encountered something like that?
>> Yes, there are systems with ACPI that don't support S3.
> OK and do you know what happens when we enter suspend with "mem" in
> those cases? Do we immediately return because ultimately the firmware
> does not support ACPI S3?

"mem" should not be present in the list of available strings then, so it 
should be rejected right away.


> I will rework
> tools/testing/selftests/breakpoints/step_after_suspend_test.c not to
> assume that "mem" is always available, since it may not be.


