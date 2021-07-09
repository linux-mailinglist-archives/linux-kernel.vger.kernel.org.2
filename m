Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA013C290E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhGISdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 14:33:47 -0400
Received: from mail-co1nam11hn2240.outbound.protection.outlook.com ([52.100.173.240]:38209
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230082AbhGISdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:33:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/BntZhLhWuQNTrJ4tgnIsqkZdHqLm7eddWgIsY92T5FiP2ouNxfU7xVP7B8x/sfPUCQZJEWQD0Cj36cXNRrENVmjuQlxJyYJA0zReIX8HkK/7D31y/qDCq05sVf17e5y7bsIxPStebkVejqyuL77SjHQqmsqo/yCpRBefA641dn/TbWD1ud0OJUvSpJMJ0QHn+t11ugtIGrA07YqoC3vvYTt4biNYirGfLsqTFLPsoqgaN9VN6q//8gjqa9rmZy0QtGSdgdKlK8+qgvWlOWNleq/C99rLoVE8zHoL7kl/IKmrVQUY5WIQjzARnpc/BusGdxe6yefne82W/GZW/feg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVkQ4XklSo+Q4lmIpxL9BXjUjGCdGMNyXJudPGmosp0=;
 b=duMBd630vRo8/yv3u3vEdvaqScmg0eKbrFzy5PMg2xwUd7gcn2xoy+vSu7zqRJwk2LUTgv49Fje8STEqpSi/oB4osRYSAM57IVh+4+1gg1tsfiuAoWTiv+CQBoKD8gSnG/+9vKUmjOVsHPHs5zZX6oOBh0S00S8abiucbQgLuCGQE4h/sFzeVocLIdky6fr/QvUlxUQN1xLmRMkHfe10SAka80xKwoVH/tyHcXpqZ+klhvwM/ViGSNxe9PkqjooaHFmtVQruQJgU2x8FWmnWehHdcELRh6G+yIsl5UFHLZp3rD+5RikTe/qLd46i+64EvL59Tt15pCg65dBPS0JWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVkQ4XklSo+Q4lmIpxL9BXjUjGCdGMNyXJudPGmosp0=;
 b=We1V4pe+gLVS0cDZoAaVDU5cRN0vn4f5G3oq+/Svj1mlM9QKCJtHzm5y8TJVDC3SmR7Dl+BJltHNxGDgozkYbLTyRCkvLOI5sUO99+mtSb0qM2OXklxRw+9+PP5voVKpxVQ8mVVJtYz1Rbk3KRwgsV96yYx+RdXplwhCgVFFd+Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2831.namprd12.prod.outlook.com (2603:10b6:805:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 9 Jul
 2021 18:31:00 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%6]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 18:31:00 +0000
Subject: Re: [PATCH v2 0/5] Add Alder Lake PCH-S support to PMC core driver
To:     "Kammela, Gayatri" <gayatri.kammela@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "vicamo.yang@canonical.com" <vicamo.yang@canonical.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mashiah, Tamar" <tamar.mashiah@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rajatja@google.com" <rajatja@google.com>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "mlimonci@amd.com" <mlimonci@amd.com>
References: <cover.1625709047.git.gayatri.kammela@intel.com>
 <CAE2upjQK80HF+hADt+q9PQKpX6MntqQFQ+mcXRKkus1FvxvvRQ@mail.gmail.com>
 <MW3PR11MB4523BCD490ABA17CE3B5FD94F2189@MW3PR11MB4523.namprd11.prod.outlook.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <3ea67145-f22d-a8fd-bdd1-35e774c8a1bc@amd.com>
Date:   Fri, 9 Jul 2021 13:30:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <MW3PR11MB4523BCD490ABA17CE3B5FD94F2189@MW3PR11MB4523.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0047.namprd02.prod.outlook.com
 (2603:10b6:803:2e::33) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.51.208] (165.204.77.11) by SN4PR0201CA0047.namprd02.prod.outlook.com (2603:10b6:803:2e::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 18:30:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73b55a1d-e815-4381-924a-08d94307b366
X-MS-TrafficTypeDiagnostic: SN6PR12MB2831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28319EAAC962C439C38DDA3EE2189@SN6PR12MB2831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2w1VEhsVStUOGVGOHJlNnNKc3hyL1BlMytaUi9Na0ZLcVNQampXNEthcklV?=
 =?utf-8?B?NFJkbGxsVHF4QUNVL2o1NjBjL01EbDV2WU5PRTF0UGhHMk5vYlhQWE9weFhB?=
 =?utf-8?B?bnJpay9GZHZVWjNkZlo3aDFOM25aZDZJeWRFMy9pVDVCbjlTTEI1ZnRaOGRP?=
 =?utf-8?B?Yy8wV1RrQUVjQWJnaTZzV2lOb3FDOUt0MVFOZGhSR3MrOXljcWhaVEcvd2N6?=
 =?utf-8?B?ajRsTlk0UTUzYytFZGdFWkpUQjJ1QVNRZHk1bm5aaG1DaVdaRjlBZXB2WFFm?=
 =?utf-8?B?MXdZSkNMZERoYzZtWis5QnpLVnUyYndIWEhMblZPdDUzS3hGWU5yRlhBc3NB?=
 =?utf-8?B?VzJhTGw2UVowZFJoY1VBdStITy9ic1B2M0tZQllleC9DYkJ3OUkrN3JnMEVF?=
 =?utf-8?B?em95UC95WkRjSDZ2RzJ3cVVUZVUzeGpESWtZdzBrZnBZVGRSc2Juc0sxQmk4?=
 =?utf-8?B?d3FDMm1TU0xtOUR1eEJFVWpOS2ZuUEg5QlFjTFZuYzNGeUtwZUNnVVpWWEpt?=
 =?utf-8?B?TzlQRXJnUy8yTnZ1RjRKWlFaeE1ZOGJlbG1ySGFFQnRhVXBWem83bmxKSlk2?=
 =?utf-8?B?WE9kR0JwK2JhRVQwODdmWWJ5UmgwbVhIQlZ6eU5wR1pOci9JMHVTTFVvRFY5?=
 =?utf-8?B?MWpxblErMmlCTC9XajJmVU1PVWw5OWFuMVBuT29VWEozemZRbysxc3RVQkp4?=
 =?utf-8?B?ckgrR3JBYlMrcks5bUNKU3VsdVBMQkNYSmc0QzBOdVZBQklZTFFxQ3VLeS9T?=
 =?utf-8?B?Y2RqSXRJc0plUVJUQnErNVl1Wi9KYlIxWDVKVHFXWkpQWGJMYnMyOW9XNWhY?=
 =?utf-8?B?dzhlZkFXMXdUOXR5dU05cU9iYTliWWhFQnpCU1dFL0c3Y0I3MU5XcU5ncSty?=
 =?utf-8?B?dWszVUtETnZieU1tWmpQZXNLcTAxM1dvOUdCbGpQelBkU0tuU3FjMGpLRXI5?=
 =?utf-8?B?bzc1bFViWkNTZGFRL1g0QmJHdy9ySkJkTERFVHQ2bGFOTm5nY1NrRnEySi9S?=
 =?utf-8?B?RkZHNDZ6cTFRN1NubmtrbFNIL29TNG1MZStMdUpLcEpVa3VhYjVydGJlZktL?=
 =?utf-8?B?Q2cxRE03L0lFeWtJVWN1RmQzTDByb210TUkzSkFWWi9LbVBhNTVKRCtRWWVj?=
 =?utf-8?B?dGtXS0wwczdmdnd5SW5vWnJXYmphMllpd1FHS3dqLy9MVXh0dzFBN2hoNS92?=
 =?utf-8?B?UTQ2M1ZCdjJTamhiWGFwZVMrdXRMbDFGNk9vVkkzbG1ZRlVSZS9UUUtQWDRV?=
 =?utf-8?B?R1BqSjFxRUQ1eGNIc1pVQ080RTJ2QWJzSEZiSHRlQUJkWUl2VVZsNHVxRU1K?=
 =?utf-8?B?eEJDV3pYVVVTVjBQT0Z5ZytTNzFqYitGd3JqQmFhckRVSUJRYjI0SzIxQXV2?=
 =?utf-8?B?dUdkUU9CWFhVeCsyRlBYNUx1TTUwbVZGcS80bm9haVoxdFQyOEFoLzZ6ZUJQ?=
 =?utf-8?B?Z0xBK0h1ckd6YzZDenpROEZJUE91WHp0ZE5XcGhRK3lRQ042QWk4MzRLaGwv?=
 =?utf-8?Q?XE8BNQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(2906002)(8676002)(2616005)(4326008)(5660300002)(8936002)(38100700002)(316002)(16576012)(6486002)(478600001)(54906003)(36756003)(186003)(66946007)(83380400001)(956004)(110136005)(66476007)(66556008)(26005)(53546011)(31686004)(31696002)(7416002)(86362001)(88260200001)(226253002)(43740500002)(45980500001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUlNVkpDWGpiUGxzSUlzeGdja0s5WTg4T2hDVTlBWGFEbUpCOEJabHl0WkRW?=
 =?utf-8?B?RWpWSWZueXhySXpIV05TUkF3U1FzR0ZVVHNCNi9NTHgwT2dYQ0hGYnB1VUly?=
 =?utf-8?B?b0p3SlNEYWUrcUNoeWVUNWVLOHc5MnE4cElOY1duS0VkWXMzMm4vNk1oRVBX?=
 =?utf-8?B?L0Z3QU5lQUJFdnNvWCtsVHhxQTErN3NnRjU0N29JZ2tHcGQ5U2pLeWdNODI5?=
 =?utf-8?B?NnBkV1U3QjFoTXBpM2NTK0hucERpUWJSTFIrSFNDd3E2VnJxaG5zZmFIODc5?=
 =?utf-8?B?SGJ5bGIxbVd4NUhxck9YVVdxY0hQZmI0THFuM0RHSWJlZ29jMUNPZ0ZrdWNP?=
 =?utf-8?B?Tm9jZHZnS0RCenJiVkdXbFdiTTkrd3ptMkpEOEluNHRpaWwwU0RDODNHZWNk?=
 =?utf-8?B?SFpCUG95Z1JtOUw2c2dxMlNQdGhmSFBzc2J3SkxsYVVSRVBqclhZUE8xRlo5?=
 =?utf-8?B?cElDRHlKSlpKaE5RalVjeXNEampBNjlHUkVXdDFLZzc1b3UrS2toMG4wSUo4?=
 =?utf-8?B?WjdOZHNZOHpERGd2ZzcwOWxZa3JPQ3dPUksxYnhJTThpUlpyRTkxQnp5ZnQv?=
 =?utf-8?B?VUJ4Qktzc0lkTXBaRCthcmZmMDBuOHNMQWt4SEx0cWNwV05OOXBkck90b0xS?=
 =?utf-8?B?YitEQ1R6SHloL2ZYRS84N3J1QmxEaTg0QnQyemRGb0x3VFM5aFR5bFVUN0hj?=
 =?utf-8?B?dFNGUzVTNjQxUTl1elFpQXhja0NaekJXZEp3REduZFgwMEJxNkZBc244ZnRD?=
 =?utf-8?B?SmcxNHJNMkNvdy9FZk41b2JUYTk0NUNvQm1CN2g1VzVUamVrL1ZES1Nnd3NM?=
 =?utf-8?B?RVp6TEVFNTY4MEZlWnhHMDVLMlVrMExiOEdMNld2NmFvUFJ1YUZWOFBtSy9V?=
 =?utf-8?B?V0FGLzlXMlI0N29nbmFWV3FMT0RrY1o0TTZHb2IwSy82RjVySms0Q3hUUkVu?=
 =?utf-8?B?Nnh6YS9JOXo4SEtmVUY0U2JxRStuY3JNUU5uVDRaZHprTzJNbEZLYTVabzBi?=
 =?utf-8?B?R3Q2NC9nYnVndlAwNGplWjNleUVQN1QzSUh2NDVHNFVBYzhxS2xsbW5tQ3Az?=
 =?utf-8?B?eHdVVGgxbG81cE5qS1lhSjFhTFJyeDcyYmlBb0dobVVKc1lRMkJlZnFqOWVx?=
 =?utf-8?B?Zm43MXFIVDkvbGtYNHl3RmkxWWExaWM3aXRINlh0aHl2cG44bWcwazdobUtO?=
 =?utf-8?B?dEdQTlEzaTRQQzBmcTFMekFEVVBpbVRnMEZSTW44OHVQSk16ODEyNC9CbjBW?=
 =?utf-8?B?S2locnVqbnlBdi8wZXQ1MUkyNmxpU0prczlWMm1UTTFIenRYZWwwUWorN3Jv?=
 =?utf-8?B?TUhGNWFCOVBNbWx3RXdrREFYd0NrMEgyWFRKQkhhVHBmOEtTMjNQL2pIRnZP?=
 =?utf-8?B?Vlp6Nm1uaUhyUHVQVW84aUpVMm1GbklBNEt4WlduMkZHWFIxYU5LdlE2SC9B?=
 =?utf-8?B?QU5DWTZmMnNVNVo2emtDazZIOXRGd0JrMzJTVWlLMTRWdTN4c0pTc2RYdnlv?=
 =?utf-8?B?SjJwVjB6RWQvcEhBZzNLVzZidUR3V0dzNHQ4M3N4Wk9MeFBuMnhGZm83QVdp?=
 =?utf-8?B?dnMxWDVzVmRzZnpqcG44WHdCdVZDNElsZHJjS2xQa1hBc1pNVVMrbmlJWDNQ?=
 =?utf-8?B?ZGZ3dTVNQmhzUkkwdkE5cjFwLzJ5anMxL0thNVcwMER4RHVoZGxLODdFUWJy?=
 =?utf-8?B?SmtNQXdDLzN0OEY1dDBLWHdMazdZZCtGcU5xL05GbzZnMHZheXRnRHllTVEv?=
 =?utf-8?Q?02/Abl5ezN5p2Fyrp4HiOGU4DVEA13RBA0IoXaM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b55a1d-e815-4381-924a-08d94307b366
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 18:31:00.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcxife4I5HSn4TISDWIj+gm7n2q4HrJk6tgBS5EpecroSeFycwUfIABfkTpiaIv0uiFlmk3VNQkkoydxl3NTBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/2021 12:40, Kammela, Gayatri wrote:
>> -----Original Message-----
>> From: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
>> Sent: Thursday, July 8, 2021 10:33 AM
>> To: Kammela, Gayatri <gayatri.kammela@intel.com>
>> Cc: platform-driver-x86@vger.kernel.org; mgross@linux.intel.com;
>> hdegoede@redhat.com; Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com>; vicamo.yang@canonical.com;
>> Pandruvada, Srinivas <srinivas.pandruvada@intel.com>; Box, David E
>> <david.e.box@intel.com>; linux-kernel@vger.kernel.org; Mashiah, Tamar
>> <tamar.mashiah@intel.com>; gregkh@linuxfoundation.org;
>> rajatja@google.com; Shyam-sundar.S-k@amd.com;
>> Alexander.Deucher@amd.com; mlimonci@amd.com
>> Subject: Re: [PATCH v2 0/5] Add Alder Lake PCH-S support to PMC core driver
>>
>> Series looks good to me.
>>
>> Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
> Thanks Rajneesh!
>>
>> + AMD folks
>>
>> Hi Alex, Mario and Shaym - Perhaps AMD PMC files should also follow the
>> similar convention and it could probably evolve in future where both x86
>> based PMC drivers might use some common library helper functions. What
>> do you think?

Gayatri,

If there is going to be PMC subfolder, then yes of course amd-pmc.c 
should move into it too.

Are you also thinking to move uPEP code from drivers/acpi/x86/s2idle.c 
into the PMC drivers?  Or do you have some suggestions on what code 
could be shared between AMD and Intel PMC drivers?

Thanks,

>>
>>
>> On Wed, Jul 7, 2021 at 10:10 PM Gayatri Kammela
>> <gayatri.kammela@intel.com> wrote:
>>>
>>> Hi,
>>> The patch series move intel_pmc_core* files to pmc subfolder as well
>>> as add Alder Lake PCH-S support to PMC core driver.
>>>
>>> Patch 1: Move intel_pmc_core* files to pmc subfolder Patch 2: Add
>>> Alderlake support to pmc_core driver Patch 3: Add Latency Tolerance
>>> Reporting (LTR) support to Alder Lake Patch 4: Add Alder Lake low
>>> power mode support for pmc_core Patch 5: Add GBE Package C10 fix for
>>> Alder Lake
>>>
>>> Changes since v1:
>>> 1) Add patch 1 to v2 i.e., Move intel_pmc_core* files to pmc subfolder
>>> 2) Modify commit message for patch 2.
>>>
>>> David E. Box (1):
>>>    platform/x86: intel_pmc_core: Add GBE Package C10 fix for Alder Lake
>>>      PCH
>>>
>>> Gayatri Kammela (4):
>>>    platform/x86: intel_pmc_core: Move intel_pmc_core* files to pmc
>>>      subfolder
>>>    platform/x86/intel: intel_pmc_core: Add Alderlake support to pmc_core
>>>      driver
>>>    platform/x86/intel: intel_pmc_core: Add Latency Tolerance Reporting
>>>      (LTR) support to Alder Lake
>>>    platform/x86/intel: intel_pmc_core: Add Alder Lake low power mode
>>>      support for pmc_core
>>>
>>>   drivers/platform/x86/Kconfig                  |  21 --
>>>   drivers/platform/x86/Makefile                 |   1 -
>>>   drivers/platform/x86/intel/Kconfig            |   1 +
>>>   drivers/platform/x86/intel/Makefile           |   1 +
>>>   drivers/platform/x86/intel/pmc/Kconfig        |  22 ++
>>>   drivers/platform/x86/intel/pmc/Makefile       |   5 +
>>>   .../x86/{ => intel/pmc}/intel_pmc_core.c      | 307 +++++++++++++++++-
>>>   .../x86/{ => intel/pmc}/intel_pmc_core.h      |  17 +
>>>   .../{ => intel/pmc}/intel_pmc_core_pltdrv.c   |   0
>>>   9 files changed, 350 insertions(+), 25 deletions(-)  create mode
>>> 100644 drivers/platform/x86/intel/pmc/Kconfig
>>>   create mode 100644 drivers/platform/x86/intel/pmc/Makefile
>>>   rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core.c (85%)
>>> rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core.h (95%)
>>> rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core_pltdrv.c
>>> (100%)
>>>
>>> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
>>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Cc: David Box <david.e.box@intel.com>
>>> Cc: You-Sheng Yang <vicamo.yang@canonical.com>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>
>>> base-commit: a931dd33d370896a683236bba67c0d6f3d01144d
>>> --
>>> 2.25.1
>>>
>>
>>
>> --
>> Thanks,
>> Rajneesh

