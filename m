Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1408B3316FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCHTKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:10:09 -0500
Received: from mail-dm3nam07on2061.outbound.protection.outlook.com ([40.107.95.61]:47104
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229463AbhCHTJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:09:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmWHzwWiJ1iqUavLxSBfndwEDvC1ympfdt0ngPdrYKs7MHCf+447D2nW87tDTtM2kfP6ZgY3OvuBdwvt386MTW0NZZRuai5Cp5R+3GO7b4y0ppSv/syjrRasXb8ezDX7ITdc9KDzRd8owjTf4U4gfRvRkO5P7m3tpdJARwYWfY3mCheda2zvIDb1/DxV109T7H28QRsZFKovV/P4x1oFzmKlufcmBgjmY0pkGC/wtjatfYJTQ1Z7WQMBHqKyhJ2pt4EAN5eAPjvq+9O4L5on6cW95LEP8Hvtonp2kmRXqBGzDHiq2/mW/vDG2tYVC1rDZA7APrpyVXej6Zn58CcWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUIEjrM86PV1YmMt+1Ut/psNbgPAYkjGxBZUNPbLOSo=;
 b=dfQYGVfwYuAKLb4m2O9qT1SGWm8JPAWiDnb2wHEvY7zI61w46AXdon8rfH3EzhEz94pbdXEFsTeNEug9Q/PPNDWNi2UqTdkCXo5DK24wpCU1hSbLkCDkzByzCDNNLkvwbIEmGczDwAJLvZRsBK82DhXsw4ixz8wRvxjegFLxC+8BpGn7lhRc9ZEjGoN7WM6DQjKxAH9u/7RSjOLZOq31pK91AVH3qJ+GZWreqL1Ro3vbO7CF/WBeINSmTf2xtGPGHDBU6VRnvpobpLCPRtZP8o/uSgndWsrbd9F6NA4b6sFN0yIa7LLphToPrrXU5tyJpwfvzaVBacrGwcRB6oJ2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUIEjrM86PV1YmMt+1Ut/psNbgPAYkjGxBZUNPbLOSo=;
 b=unHH8TJjyzcpAvrr6ugDuKuhDTxdFvIhFMkpR/P26fxVUmqvrqTm7R/nMu91/vPfdxjiQls5GkeL16Eygzg24wMmsjMhnRKO1uMfwjyT2BPiMWkJfpUW4BNqkCUdU/k++S0SI6Gw3wJOFTiAopwrtZls6Ddn4CkwN+EHRB5Qmow=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4916.namprd12.prod.outlook.com (2603:10b6:208:1ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 8 Mar
 2021 19:09:55 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%9]) with mapi id 15.20.3784.031; Mon, 8 Mar 2021
 19:09:55 +0000
Subject: Re: [PATCH] drm/amdkfd: fix build error with missing AMD_IOMMU_V2
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Philip Yang <philip.yang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210308153359.2513446-1-arnd@kernel.org>
 <176cae4d-33bc-1d51-a7d7-58eeeea5180e@amd.com>
 <CAK8P3a0nUKSJ2+knM6+REp8HXRFbz5-DmNRAusezkT+XzZQa7Q@mail.gmail.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <92a6c999-c20a-2311-4e31-209a2d9229ed@amd.com>
Date:   Mon, 8 Mar 2021 14:09:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAK8P3a0nUKSJ2+knM6+REp8HXRFbz5-DmNRAusezkT+XzZQa7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::20) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by YT1PR01CA0141.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Mon, 8 Mar 2021 19:09:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c53d0c28-a0fd-44db-17a5-08d8e265c226
X-MS-TrafficTypeDiagnostic: BL0PR12MB4916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49164377D074C0A54BA0D1AA92939@BL0PR12MB4916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/g89Wq6l1Bqh6FU1Hs9n4BFuC/Ode7+1zD3l9KrE7iz4HNJdpSpcB6dNfXZZcpHsRYK6szT7d2WvLhl8CJWWYP/BKmxc0gvAtdsclu+Bmi70lUNUZBAQsvRzN0Kl0uqh8ar+fc0F5HX0BaTzHfbokzvwE437pJw1WlU14EWikY/VgAYyNdo3AzfzmoAQA8gXsWbB4pivtV/DaKKBfg/yafWA/pCP4oJkMJiUAEWj9SNw8tCy/2EbZpvuQGAlHeuADVZjjf78OdlpwGrhnWPi6fU/StJjpzcCztioDMgpplqk3F7WMW6iFW08jfexWjPaq7ZflSr0227rj5K30l2sMrboeMZ0YKugRjhGHtm2f5T3NkbQF7spBED4wIannvXiXWvHfsBRFFZTX2/HKQ+5Uu+G7XNgtNO/D7Y2kIefNmT0bdEHoQVdXFlcY159gsssC96M3RJ6+xLx/cSIeDydfF6dowppEkpLRTZIDYTH5ugIYocQ2yHmtRqbANhR7bQ+YFQiuP12w9sYT+j/3j3GeHGPe0dGOwyp4P9QKU8oqB5toIrb+fDYnmdJmRFhINLH9gxZZnlz+ScBHwh9bSpbYlHmHD9ux/0p2Qlr+wF6XE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(316002)(26005)(66556008)(54906003)(66946007)(66476007)(2616005)(2906002)(8676002)(16576012)(956004)(8936002)(478600001)(6486002)(16526019)(36756003)(6916009)(52116002)(53546011)(83380400001)(31686004)(4326008)(31696002)(44832011)(86362001)(186003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N2ltdy9idDJrYkE0WFVwYjBLMjNDYm9tYWpCbktCb3BSMFgzL3VxU3k3Q2Rr?=
 =?utf-8?B?UjhoSTNjUU1TVjMrVXJPM24xeHlLQjZkczZ2U3Q0SjNsQzBVQkFVdjRNUGcz?=
 =?utf-8?B?WGxkYzgxSS8vM2l4YTg0c0ozc2RFOXFvVEtZTllrUnhLVnlVNE5GRmcwR3Vl?=
 =?utf-8?B?U1lPZUhacHNsQ0haeitybjY2K0pZcGdISFZ6dTl5dEdBT0tnZVVMSkpuekgr?=
 =?utf-8?B?SjhrSmRVTGwyWmFFSnhvN0o0TGNUVG5rbGtRZEZMOVF4RDRGeVVYS1R3VDBn?=
 =?utf-8?B?enZidjhDNWNjNDUwM1Z4VmpoazFIeWkvV1VHNG12ais5QytKWWRYclQ2U0RZ?=
 =?utf-8?B?ZTUxZ3A1YTFDdys4MjVubUtlKzdEcHlBenNZV2h3b0RaOGhnS0gvVkdNOGli?=
 =?utf-8?B?d1NYNENQQ3lOV3VIQllQcytQSXJlSElLNVpVZmZjYnQ2aHFIalhaTWEzMkRt?=
 =?utf-8?B?WjNpaFgwU1IvaEVNOWlNUVNjQU8xY3Uzb1R1amhqWFNlMHMyTThMOVZpTC9H?=
 =?utf-8?B?anR6S3JYSWhQeWtNZFRYclFld1pIMXQzVjRKeEcxOWJ6TjBCZGh4MWszMDFK?=
 =?utf-8?B?RjA3VkZvVWx3azdxMzQ0RmNKQ3VOLzNkMitnSVFoWkpvMnJVdjNNa1VmZnNF?=
 =?utf-8?B?Skpjb2RnbVlEZ2Y4MkpHOE1lL0tQVXFzbmNiR3hnc3JxbWwzL1FIaFdBRTI3?=
 =?utf-8?B?dEtDNUYzMXpyNjFCSzI5Q2xJRzY4M0l1d1Vqc0c3ZlUyNlRDeDFweFQ4aVZz?=
 =?utf-8?B?dmdBMk1uYk9QbElrWWNtMWVnNWE3NDJZVVZzd2poQkw0OVMxM0FpOUozUC82?=
 =?utf-8?B?bXhteWlvWFBieHNOL0lsK3k0ZHhtUldwZFpaK2F2NmlyZCtrOGJMeE41eWVy?=
 =?utf-8?B?RFdzakk2Z3V5QzJkN3RQdWNVTitqS2NpS0ZxZDYwZjdIM0NndStyZi9xa1lt?=
 =?utf-8?B?WHZqUHc4TnFqQS9YbGNnbjVhcmM4b05vcjl6ZmptRVZPM2wyakF0c3BvZUtH?=
 =?utf-8?B?Q2l4WWM4TERIMm9DdHJpNzlEcFdqYWhzRFl6QTBNeWNLQVpvMGxPdzJtcE9L?=
 =?utf-8?B?M0VxY0RwekhKcXVuUWV2WXhtcnNsSGVER3ZadExlcFEvbkRqNEtkUDQ5NkJV?=
 =?utf-8?B?b2dPajNYOVloMVVaUW4zTmYxaGxGR1JMTnBVeDZqVG81S3NVZjR1TnQ4NTFz?=
 =?utf-8?B?MjRlN1FyVkx4K3Y1L2lvNW5FQ3hwcVV2VWZNOFd2OEZ1clptazJCdGgzZTRZ?=
 =?utf-8?B?UlhrMkRwWlpCYXlpZkJ4VS90b1U1R29abVNwZlorZ2tkVUFldWlpTm5hRnZs?=
 =?utf-8?B?WnNLYklFS0JJTXcwWHRvYTA2am9kNzF5aCtidkg5Ym5BakZleHpIWCtYTXlk?=
 =?utf-8?B?NXFqWHdJTW5qeFl3ZUVaSHd5NE01QW9XdGc5MllZREo1bS8yZ1krOE5HTHBn?=
 =?utf-8?B?b3dCQXpMRnBXQWMzYXZPdkw4TDMvanRtSk1HVTNTMmdaM1dFU25UdUtuSmFi?=
 =?utf-8?B?T0tHM0laZWJVZ1dMMUNNWlI5cUJWcFl1SEFORk5RQzJITlhwejFud0o4Rm9F?=
 =?utf-8?B?eXo0aDFiT1JOOWYzeCsvNi9IR1UweTZYY0dKQzJEUERTRjY5V0VidExaTCts?=
 =?utf-8?B?djRlRGJJcXB3dUFlQ3JpNlE1NXYvUHR5N2VVKzRScUd3ZVBZbCtPeVFJU2xx?=
 =?utf-8?B?WUdrRHNpNEgxa1I1aFVLSElFWE1xQ1RtQVdsQXk3Y0JFNVl3SDE4RnJHdzRk?=
 =?utf-8?Q?KqhpoKX/dgR1cRWFubwMXP8nJTJ8OpkIREBkMKZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53d0c28-a0fd-44db-17a5-08d8e265c226
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 19:09:55.1269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNXzr+t3KyFF2bZ4LSq7afiI05mCAF7cl4xQh0+DT7TmihYeQm7Fs1gJKy+F7iZ9SXNid81E9yo29WPQ8FdlXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4916
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-08 um 2:05 p.m. schrieb Arnd Bergmann:
> On Mon, Mar 8, 2021 at 5:24 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>> The driver build should work without IOMMUv2. In amdkfd/Makefile, we
>> have this condition:
>>
>> ifneq ($(CONFIG_AMD_IOMMU_V2),)
>> AMDKFD_FILES += $(AMDKFD_PATH)/kfd_iommu.o
>> endif
>>
>> In amdkfd/kfd_iommu.h we define inline stubs of the functions that are
>> causing your link-failures if IOMMU_V2 is not enabled:
>>
>> #if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>> ... function declarations ...
>> #else
>> ... stubs ...
>> #endif
> Right, that is the problem I tried to explain in my patch description.
>
> Should we just drop the 'imply' then and add a proper dependency like this?
>
>       depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
>       depends on AMD_IOMMU_V2=y || DRM_AMDGPU=m
>
> I can send a v2 after some testing if you prefer this version.

No. My point is, there should not be a hard dependency. The build should
work without CONFIG_AMD_IOMMU_V2. I don't understand why it's not
working for you. It looks like you're building kfd_iommu.o, which should
not be happening when AMD_IOMMU_V2 is not enabled. The condition in
amdkfd/Makefile should make sure that kfd_iommu.o doesn't get built with
your kernel config.

Regards,
  Felix


>
>         Arnd
