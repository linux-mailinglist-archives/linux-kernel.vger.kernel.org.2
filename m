Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64C14341F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 01:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhJSXTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 19:19:24 -0400
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:11840
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229554AbhJSXTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 19:19:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBvrYT0dy5BkRlJvjIyz5ayHvXvGbwfhOxZsSZbg0rttFKlqvS4OmOe/wDbr56DAoQj/Tdh1uqMnUKmRM/xdUEss3SQXNHx69YKjAcUcWlO5/qMgCxAWhZ5bHTV3ijQ994YDTL0Aw0qGccmIBV4s+T5QDd6vEcjEfY5nigJPcYyqSi4IkYOVWqVr3C/nNmj3v2JXVLLe4PZWKF6Jk8VH4lzSAXab6rAd50RUX8106PFo8ryhDoLkId7RmoDhR5nDMX1VMH9t/9EWEwCGesgltw7qjloXMn/3QDHV3vyA1HXhuIveLn0y5g8hTs/Sg3kZhR9R3uQ010JuJe90/43YnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOlrnod4yT+aLWOw6YqWrbNmQO5aMc3z3mRpGYLozVk=;
 b=DCfrZYWEFqEw5WSk3MmVGVULEXl+XIZ7eEtwxqYOaPLC1JcdM/gCfcjHmXf26dN8py3BiXlqRdorUrAYKp/RX/vvxHPv/8WqCX0RSOmThN26CR+O5JIqK6mS8c4Jt6eQnG1OmG5909nvkrQG0v3s0qKPDg5ksL4dWTD9O4Uxog1BrUEm/s9ZHatkEjb2Cdh4nAsuCzTWFVHE8tLVLtGj6Kuvj795j6uF4B4O49jaKufw++QQ1nKHWuax5P1d4gFN6XbfYC+tLrucw4GX+FSPuOf9PKyYRgjRfXZbXXfcPdQry3no7f6zDG4R76F+xsJPGJu/lXBhxkPN36tpStJvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOlrnod4yT+aLWOw6YqWrbNmQO5aMc3z3mRpGYLozVk=;
 b=aAU60/PNFqE7GjlxZxHcXXd4dm1kpRXURxQNaCGLdqtSdRLObWJVxq68qGKbGtGZVt1SlACZG2ENay1nvmgJ+Y9iJrzlqpEDQ7dtzQnJGxmyPgKtb4sMVlASHCDg+fqMu3m0dL+W33YdTYQdq0QillziZ3vIo/hlzUmtxtw07jA=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 23:17:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 23:17:05 +0000
From:   Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 00/23] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20211001160302.31189-1-james.morse@arm.com>
Message-ID: <888f7f5e-a9bd-7349-9dbd-852a76106df1@amd.com>
Date:   Tue, 19 Oct 2021 18:17:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211001160302.31189-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:207:3d::42) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from [10.236.30.47] (165.204.77.1) by BL0PR02CA0065.namprd02.prod.outlook.com (2603:10b6:207:3d::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Tue, 19 Oct 2021 23:17:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c468950-0a31-4918-0f28-08d993569096
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0062:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0062B175FE30925CE0B3105E95BD9@MWHPR1201MB0062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bEFSLwDXIzVnCda9b7yBlX5zDIxPnYIJEx3zAPHP6hn7wrVrBVVgSxPqeb7nRg0/UlVKHHtTQeOrndGuXrYvNj401ZMQK3mo0P+Lrn7LwmOA8RwtuU5dVWckajaJFkAj96WsGLfFbZKdPE8tCQ8ycwhF7aMxlUt0td2su7jEGpgVzXJX3XdU1yahwTJv814O/C4V9qGXBFZmg/kwOjpPWeb8DWslc4l7/meUC5242o7i/geqS4tnavtrLOiSIV3LOQP02cVh3v2VXQhwGn8at9x518RZTxLxycNAIUZ6M2MqcqfOUWUTpMN98/V30yetJWJSlDXidev8IQMk6adFTzVWvvgh46yJLD4UKZQOnJnJFcYXyYcDe1EiT2o7EdtC+3ysaLqIjBTOIbZcgMxYrA0EeFDUT7yTf44HPUAyrjoj3/6mOxhrHQkdao6Flm3wbU7qyAzTsheLn2O//ZVrUztXc9B4xQCI2Jjwk9X3tN6JYL6yEq/Vbby7LDmAUCuVnfIk/vdxaa7f/PF9dIHM3K1kXmpZN9jRH42mn59FRFuGZ7CoC0be8oazuPeR7ffvfx/9aZDHJ6jptvOrYukea+4AwKmozjjuPLkahI+ta7fWOwx0yn4oLeehUPZ2kJfju18wcYlvCkalWMB1haMj3NIAvn23GKmfjfEOmuZ1V0XGPSIfU0LkuRHefWRvtCO8UG1eBLSAuPaLZsby/oBV882+akjdFKTk0kbZME39nKKWB+YLx5Z+IBh6KkbX1mKrHGg9YoViyE56FYeteMZAcZ+emsVLcvnyJ4tlYfU8w8fHgcC1B7/X2SPPnTKWO/NvEHghy2eIsiVevBAej4QQkpe+E3sSBCMUaHTOePj6oGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(966005)(66556008)(2616005)(44832011)(66476007)(83380400001)(186003)(5660300002)(31686004)(66946007)(36756003)(38100700002)(16576012)(316002)(4326008)(8936002)(8676002)(53546011)(54906003)(86362001)(7416002)(31696002)(26005)(6486002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d00xc1l6ZkZZaHJBWTk4UnB4OE9NbzNNd1lBd3FWYVg3cWtMdlFNYnQvT0tZ?=
 =?utf-8?B?ZzRVTnJsbzd5YTJFVlF2QldyL2syK2JjMWhSZi9wZ1JuT3dIajduUENwWFp2?=
 =?utf-8?B?dHJiMXRnUUxMMGpIWHgvTHBJNlp2eDJGekd5eWxUVUY2TFErcU4zZWU0eDZN?=
 =?utf-8?B?a3JkNWVlODlxSHcyMUxSK3J3VkZRa2trWkZpRUFaQzBydnBDaFdkRm4xZ25x?=
 =?utf-8?B?NHhHYkpDRDRXQTJKRXJQaUVVM293TFNFK3h5SG03akYrMkRKS0t2bHRiQW1F?=
 =?utf-8?B?T3kwWm52akxpWUMyRFVadVhKclliVmh5L3hNY2tJclp4T1ViWDk5NE1KQ05W?=
 =?utf-8?B?cFU5ZUZoOS85enhnK1hGdE1NejNXbkFJbW15SjNOM3REcjU0TU9XcUdMRVh1?=
 =?utf-8?B?M0MwYmhPcEx3UmlYRjFpYWx0MDJRNzVQV2w3N24rS2VMWmlsd1RzV2c5SjVy?=
 =?utf-8?B?TDhKMWxTTVp6bi9qbXZaR3VoS3dYYVpQUHpCcFphRTIya3g5QnlJZXFyOFZu?=
 =?utf-8?B?d3JHeDBTcEhrVXZ1dGw5WitIQ0NQWCthcGJLdnVRWmttOTF6YWdmejRhcWZG?=
 =?utf-8?B?UGZ3bFR1OHVxaEVqOExVMS9hQVFsS2p1ZW8yQzZtUXl1b0Y0UU5UZUlOUlNz?=
 =?utf-8?B?bGFjNmdOelUzejVhZXdNMXY3d284VHJnMVlQQll3ZEFGWVJZbkd1K3JWNFcw?=
 =?utf-8?B?VmtocURZYkd3bWRxdXlCQU5SRnNJSUFpM1lUL0NTUEtBOVU2TWZjb2gxWUZI?=
 =?utf-8?B?UW1aanNiMFJ2NlA5d3BXTEdRdkZaZlRDYU1xcUJqS2ZKaDdlRTdHbUtZZTFa?=
 =?utf-8?B?TGh1dnBoM0I0ZkphM0M3MzVJU1M0WWRvU1JyN0VZZlVQZFdxS0dWdEVWYjY1?=
 =?utf-8?B?UFh6UXY4czN6RmNidnVRM1d1QXQ1WllKTFBRSDhQUUtLUHlJdlBhMFcrUUQr?=
 =?utf-8?B?Q01jTGt3T0M5ZHJ5V3RYQXQyUkk2b0dwV0lyeE9ITEFJajRycndiOXFVdnlw?=
 =?utf-8?B?aTM1UHlxeW02TlB5NzdLM2xwYzlmT2Y2cTE1c3BTc2VEWVBXZFFlajJHZnRi?=
 =?utf-8?B?aUl6RWd6MjJNYnpDV09kdGZQbXdyQXNWN1RwU3R0ODd6ZGl5eXg5ZXNvSmF2?=
 =?utf-8?B?K0FQeXFuWXVxMENtdUNuY0l6d2thS0duT0V3WnRlNUszSmkzdjNxY09FaDNl?=
 =?utf-8?B?SEplemViTkFXTE04bURNYkhUUXNjYi9Zbkg0Q0txS0ZrUHpVYVBNZzNWMlFt?=
 =?utf-8?B?cUFQdG9TYWRsZzhCMGp1aVR0dVVKUkNSR0JRVG8yOEMyZHVGeUUwd2ExWXh0?=
 =?utf-8?B?SVdlNzdpOG4yRWRSOTRLSnVHZk1TTVovMkJpbHViYWRtakFGYTFucWhCN3Rx?=
 =?utf-8?B?cFRWQVZGZmN5MThjV05xcWEwRXV1SG4wUU4xT0c1c3dLbmtBVm1DMXNvcWd3?=
 =?utf-8?B?Q2pnRnpibmJJQU5CSUNMUnhmUnZKbXNlS2xHNzArdnFFNU9KMjA0VThEOHUx?=
 =?utf-8?B?cytxQVZTWmtCVjBET0hWTVg5UktqdXZ6QUlIclRjRFk3N3hsVXhOMWRTdUJK?=
 =?utf-8?B?M2lHc3pvbTBESm1WNnBibUxLUVRhMWpMbWUzOUg4SjE3SmtyOUQ4MXd2SmFH?=
 =?utf-8?B?aHJOUjg3Qk8vSWFGT1hsd1hQdzJ3NXk0RUpYTWM2NXo4VzEycmRSQkJISTRm?=
 =?utf-8?B?YmtYS0JQT2cwRFhscy84OU9xU0Q2Q3V5UUw4Tm9rWTlEWnVuS2JKNjdVSmts?=
 =?utf-8?Q?RvTfwjcELu8AkPk07PHHAatznTcmotDhAIZgPZh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c468950-0a31-4918-0f28-08d993569096
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:17:05.5872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmoger@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
Thanks for the patches. Sanity tested on AMD box. Found one problem and
added few comments.
thanks
Babu

On 10/1/21 11:02 AM, James Morse wrote:
> Hello!
> 
> Patches 1&2 have been posted independently in case they are wanted as fixes.
> 
> The major change in this version is when the mba_mbps[] array is allocated.
> 
> ---
> The aim of this series is to insert a split between the parts of the monitor
> code that the architecture must implement, and those that are part of the
> resctrl filesystem. The eventual aim is to move all filesystem parts out
> to live in /fs/resctrl, so that resctrl can be wired up for MPAM.
> 
> What's MPAM? See the cover letter of a previous series. [1]
> 
> The series adds domain online/offline callbacks to allow the filesystem to
> manage some of its structures itself, then moves all the 'mba_sc' behaviour
> to be part of the filesystem.
> This means another architecture doesn't need to provide an mbps_val array.
> As its all software, the resctrl filesystem should be able to do this without
> any help from the architecture code.
> 
> Finally __rmid_read() is refactored to be the API call that the architecture
> provides to read a counter value. All the hardware specific overflow detection,
> scaling and value correction should occur behind this helper.
> 
> 
> This series is based on v5.15-rc3, and can be retrieved from:
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_monitors_in_bytes/v2
> 
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_merge_cdp/v7
> [1] https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com/
> 
> [v1] https://lore.kernel.org/lkml/20210729223610.29373-1-james.morse@arm.com/
> 
> 
> Thanks,
> 
> James Morse (23):
>   x86/resctrl: Free the ctrlval arrays when domain_setup_mon_state()
>     fails
>   x86/resctrl: Fix kfree() of the wrong type in domain_add_cpu()
>   x86/resctrl: Kill off alloc_enabled
>   x86/resctrl: Merge mon_capable and mon_enabled
>   x86/resctrl: Add domain online callback for resctrl work
>   x86/resctrl: Group struct rdt_hw_domain cleanup
>   x86/resctrl: Add domain offline callback for resctrl work
>   x86/resctrl: Create mba_sc configuration in the rdt_domain
>   x86/resctrl: Switch over to the resctrl mbps_val list
>   x86/resctrl: Remove architecture copy of mbps_val
>   x86/resctrl: Remove set_mba_sc()s control array re-initialisation
>   x86/resctrl: Abstract and use supports_mba_mbps()
>   x86/resctrl: Allow update_mba_bw() to update controls directly
>   x86/resctrl: Calculate bandwidth from the previous __mon_event_count()
>     chunks
>   x86/recstrl: Add per-rmid arch private storage for overflow and chunks
>   x86/recstrl: Allow per-rmid arch private storage to be reset
>   x86/resctrl: Abstract __rmid_read()
>   x86/resctrl: Pass the required parameters into
>     resctrl_arch_rmid_read()
>   x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()
>   x86/resctrl: Move get_corrected_mbm_count() into
>     resctrl_arch_rmid_read()
>   x86/resctrl: Rename and change the units of resctrl_cqm_threshold
>   x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's
>     boot_cpu_data
>   x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes
> 
>  arch/x86/kernel/cpu/resctrl/core.c        | 116 ++++--------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  75 +++++---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  62 +++----
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 200 ++++++++++++--------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 217 ++++++++++++++++++----
>  include/linux/resctrl.h                   |  60 +++++-
>  7 files changed, 480 insertions(+), 252 deletions(-)
> 

-- 
Thanks
Babu Moger
