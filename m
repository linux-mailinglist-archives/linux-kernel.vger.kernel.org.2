Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA6D35D8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbhDMHaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:30:22 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:14049
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239741AbhDMHaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:30:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIvlRwwNDUUFvGlRozeelP1Y590ytrIyhEdzXb9fEYaLfQxY+KQCAVeWrK8zZmmHZfp7ZdZexizgUUcrLs/XV94HXgX8zC4fMBgMBlOUrfpEXwyvfWM8kLiSMLP0h6eJCv9d58tLc3mgfpAlPze/L9U5DmdOUny0COb0yHrFhYfnbLX3LBgP51SR10GUK+xuzUPPuSlNaPWItfFf+G/92dV81M9HE4BeIMfj3zGbcHpahlAWHSZp1EjR/hgKCyIry1BAr0UclcABKOv1yiqVES71alL8U5Cx8NMqxOvpzfMWoufEESxBBmB/7YhsmrD+n8JA6Nz4oh8+iz1uIfckjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahuBdDo0ey3yUOHx0gTIs8AqYvhQdq5RwgYUUuPOsUg=;
 b=mFP1PFE7Q4dSGC7jQb/mSBAmHQ9NuafPydNfiEKtsaTezBTCN0G5+FKaEMYHpU1q8JEKKpkKBYDFKT5UCjyqqEc/gjgD91x15dsGVtzUEDwBjEa4NhFsnMm1Pgg7aTtXUSts7MpxpskK4EPLr6La4f/EgLM2ONxnx96dwYrB6eriXatX1Ejhv5rNK4JeqSdG7SkJa/Nvce6sdyZKjSuADCsMM4IMDyFpuxC4VJiQ3tc5ifGlE5V6J4RiiBh9/bPzUNAMaFIjmNnwjlXtL7VKbikBhiRfj1KG4tjeu51aIYcmCBKLF1eTZPu0FDGzIaCAHm6mCsZtWwIH9C1XYICzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahuBdDo0ey3yUOHx0gTIs8AqYvhQdq5RwgYUUuPOsUg=;
 b=lNnE4BSJgjy0oSB1xd8HlRM+olfoBiNdgE0MzJIInrYu+6sXFkcKf1cWzJBYlrOxDf/2hTdxKQlkCPw3GAqdE9dSPrGj0qxfqCHfx325J1t1KHn9GZA/RnlNAY24zrLM+M0ng+kVDm0TRMmI0xaJMCGoFVsW0Zi8Uo4MgdXpDLA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3950.namprd12.prod.outlook.com (2603:10b6:208:16d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Tue, 13 Apr
 2021 07:29:52 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 07:29:52 +0000
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
Date:   Tue, 13 Apr 2021 09:29:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:acbc:5f44:93b6:4587]
X-ClientProxiedBy: PR1PR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::42) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:acbc:5f44:93b6:4587] (2a02:908:1252:fb60:acbc:5f44:93b6:4587) by PR1PR01CA0029.eurprd01.prod.exchangelabs.com (2603:10a6:102::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.19 via Frontend Transport; Tue, 13 Apr 2021 07:29:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14c55d88-cd5f-4d21-1240-08d8fe4ded29
X-MS-TrafficTypeDiagnostic: MN2PR12MB3950:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3950E23AD8080C4D459BD450834F9@MN2PR12MB3950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bofaq/ScdTN8SrJ9ltxa1clNfc+ssgpsQYmqbag/DtW7XV8NMdg781jELZLigHNUwFqSrVoZmde84yWWI0sl8uUDAgfHKekqeHtFvskGddG03GZFbKhMwxqIhQsJv/6dzv2mzC1DhEHw2B/WsnxW3ybLMRlg1NeokLsAGWSO5GQLRhU/5rmV6xFcJ48ZNCy/35/u666zTus2Oqu2kEeslDz3MyMX2aUFBO+80GTxkgK0zPPd0rcMaPGVM0wRGFoMW3CkFmtAhSKvVQy81/RyJe4QA1letDtZ74CyZ8HYw6Ej0CBy9FyXL5wK11nuSIaWel3SsyKemN0kQNeWm4wq385f7mO1VlxFDNKN274O0Tykl1wCPHKzZ5+2yJ+DaTXU9TERkJpoSG+E2N/LdccgwEXYN1twjW+ukZ7lZT2oP59u45hpowsGW5cZPpO9lmXbnE+rwRSwz76AI3MPWVC5fBbY1SN3isvkfjI3J8Np1xBjGlBUSm1r9SxCva4yfvpE8MjWE3FrPzx9DMd1y3N/ckLme07ATP4WYE3+XjqUp6jajt4B4Fa/fnxL0VtpHujBShcW14wJkBbGCgsgPYIl+q/YH2nKskyRtXzXHhCqPLUoH9UZqurgWXQd73ceC72BTiTb56E/Exl+ZVmtuQ8fGd1QYFIRhTOISYGPJUdMIOeicRwkvYk+TvdTngRHRkj3e716ruTgaOp7Z6WTvdB8W1LJKHyCKBqWfZyOgw1y7uQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(2616005)(6486002)(30864003)(52116002)(186003)(66556008)(86362001)(316002)(31686004)(5660300002)(110136005)(2906002)(6666004)(38100700002)(45080400002)(66946007)(8676002)(8936002)(478600001)(966005)(83380400001)(66476007)(16526019)(36756003)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dlVFa1VKVHQrMm5GOGwyZ01VQlJPNkx1VHFTSjdkRTl3SjJqZjNVMGk4ZHNU?=
 =?utf-8?B?cEtQU2lxWjBxL29hK2ZhU0RHSjlkMUpuYkMwWmlNd1I0MllTZG12ZzNYMHZX?=
 =?utf-8?B?TUZFcWgwcERUTlQwYk9hL3pCbVd6U3JVbG9abmdLSWpYK3hyY1BPL1ozcm9N?=
 =?utf-8?B?VnE1RGJlYzdFK0lIbW9kMnpKS2lEMVRWVzBGek5tTVZVaE1jU3dpaVV5RFM3?=
 =?utf-8?B?K29ucHB0bkZOZHUwVVhnT0xQajhFNDNOMGNtdXcySncrdmR5VHRHaEtvdm12?=
 =?utf-8?B?QzlMeTJjMjNnQzY1WU1rSmR4ZHRBUEU4R2NJenh0ZmlObmZ5QVE0dlFpUW43?=
 =?utf-8?B?bE9KZTU1ZnN3cTdtZWtIRlg1bFJnOXROVHJFVWFsMEs5Zm9PQTNSZkxZOXEz?=
 =?utf-8?B?SG1xM1JWMzhrcVc1aUlWWkxVL2V6c3JtMTBXK1pmeHNTQlEySlNWZWZ6TjN1?=
 =?utf-8?B?cHUzaUxuZTZvUWtIMzZPK3BkdGhqdlVaVkE2aWxaYzB1SmJpbjN0TkpaNHRm?=
 =?utf-8?B?ckwzWm1veHl2SDNlcjI1M1E2eCtUTmRqRkFIZG9BdzI2VU04eXRmNzlabUtn?=
 =?utf-8?B?Y1kyUzhweXA0VzJlU1RsU2haVFJscmFQcGdkSjlGUTZMNFE0eDlJTHRHYlYy?=
 =?utf-8?B?YjJQRnpqY015cUZGQWFVTVFDR1UzcllFK3FpZSt3MzJNWWtvTS8wMXhBcmhG?=
 =?utf-8?B?NEJVbTNPTjJ5dkI0clJCZm9POXMzZ2F4SnR2bEViWXEvQk9GMHFxOGNFWFlk?=
 =?utf-8?B?b1p1aEhrVTE3ZkNjMStBWVR0SDVRY1FKWkx4WGVpemt0a1BieHRXbm51b2N6?=
 =?utf-8?B?LytLaXBWVm44VU1ObEhzQ25mS0F6VkpDWHk4MFFvVGlwaHg4MnNmSVFxMHBo?=
 =?utf-8?B?SkUrT0xTNEFCZitzQ3ovcFkzQ3pxbGdHc2VBSW1RSFZseHZ2cjI2T0lmWFVY?=
 =?utf-8?B?Umo0RzZlMThneTV6ajlzaWRKNTF2V3p1OFJlK1AxaHFxNVFZaHBGVHRJVldn?=
 =?utf-8?B?cEVyOFM3akdveEM2TzhOUWVYMUorRFU2bmRRVGJMRUQ1ak83STQrSmlWczd6?=
 =?utf-8?B?dWgzQTFVNlNFZ21DTWRqSnpJYWZXOTVwODhZdDZVQTFxc0RxdW9ENkpMaHNQ?=
 =?utf-8?B?dW9pVzVmeHBEcGtUUERBQW1xcDJHdktaWFkvalBSOE9zSUlTZ2ltdDRiNUdB?=
 =?utf-8?B?aEQrVUpsM1hma2c0VlNaN2l1WkJtMlB6S0luQ0hNOWJYV20wMHJVVkVaaHZK?=
 =?utf-8?B?ZWpYdzM5S3czN3AwcVNWdHR4dnRnMnpWd3k2S05mcklwRmlxQlJTNk82N2Vj?=
 =?utf-8?B?bGZhTy9CVlkrd21NVHlicmZkbDZSTFp5TnJieHhoMGZZbVVwYkNoOCtDcERu?=
 =?utf-8?B?Um5qVUw3SHFKQkE4S1RVK3dtZ0N3YW5nd3A4eWs1ZHgvN2t1cTF5MUhNY0ts?=
 =?utf-8?B?bVBZblh2REZqWWZGQnYxWUlPRjk2Mm1wVFhETnR5UHh4QUJuek9vVTZaK0xj?=
 =?utf-8?B?YVBkTTZlTWZxL0pCelVnQjZ5a2wvQnVxWXV0elc2ckg3UjB2TXA3VmpQbCtn?=
 =?utf-8?B?dDZ5QjQyOE1KYnRqMzl0dnNaSzVkMUxKQ3dKbkg3ODFWZmc0dFZXWWR5WmhZ?=
 =?utf-8?B?MFFYb2h2QWdBSTZveVZFNjdMaUZOb09vMkE3LzZYL3p0YjJjR2JVQzhsREtv?=
 =?utf-8?B?RGVQcTE1YkpKZk9UZWpWcS9iN0U1WVlYbXlBWHBSNGdjSW1WY0lGdTN0UW5Z?=
 =?utf-8?B?Q2tKK1ZxWkJ2bTJRVlcxUHRLMWdCVjNxWk8waGxoUzMzcnZ4a3E3b3hTNUk5?=
 =?utf-8?B?aGNpRFFnL2x1ODhCTGRTT0lMc0ozRE0xamFUUzl1SEZ4eGl5UkU3TllZT09C?=
 =?utf-8?Q?9LcM0HPkVtofO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c55d88-cd5f-4d21-1240-08d8fe4ded29
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 07:29:52.0112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8YjuoQOmAsY+wgw3F5rJ56mJNxc1DXu3sIMB3RQ7WAFb7BtMbNG3UjthJc/+F1/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3950
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

the crash is a known issue and should be fixed by:

commit f63da9ae7584280582cbc834b20cc18bfb203b14
Author: Philip Yang <Philip.Yang@amd.com>
Date:   Thu Apr 1 00:22:23 2021 -0400

     drm/amdgpu: reserve fence slot to update page table

But that an userspace application can cause a page fault is perfectly 
possible. See here for example https://en.wikipedia.org/wiki/Halting_problem

What we do with misbehaving applications is to log the incident and 
prevent the queue which does nasty things from doing even more submissions.

Regards,
Christian.

Am 13.04.21 um 00:05 schrieb Mikhail Gavrilov:
> Video demonstration: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fyoutu.be%2F3nkvUeB0GSw&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C15d8dd21061b4466fefd08d8fdff0df6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637538619197386172%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=yunKS%2Fbm%2B4eF5IMS4dYH9mKELbM6ajK19pXXgm8dv6Q%3D&amp;reserved=0
>
> How looks kernel traces.
>
> 1.
> [ 7315.156460] amdgpu 0000:0b:00.0: amdgpu: [mmhub] page fault
> (src_id:0 ring:0 vmid:6 pasid:32779, for process obs pid 23963 thread
> obs:cs0 pid 23977)
> [ 7315.156490] amdgpu 0000:0b:00.0: amdgpu:   in page starting at
> address 0x80011fdf5000 from client 18
> [ 7315.156495] amdgpu 0000:0b:00.0: amdgpu:
> MMVM_L2_PROTECTION_FAULT_STATUS:0x00641A51
> [ 7315.156500] amdgpu 0000:0b:00.0: amdgpu: Faulty UTCL2 client ID: VCN1 (0xd)
> [ 7315.156503] amdgpu 0000:0b:00.0: amdgpu: MORE_FAULTS: 0x1
> [ 7315.156505] amdgpu 0000:0b:00.0: amdgpu: WALKER_ERROR: 0x0
> [ 7315.156509] amdgpu 0000:0b:00.0: amdgpu: PERMISSION_FAULTS: 0x5
> [ 7315.156510] amdgpu 0000:0b:00.0: amdgpu: MAPPING_ERROR: 0x0
> [ 7315.156513] amdgpu 0000:0b:00.0: amdgpu: RW: 0x1
> [ 7315.156545] amdgpu 0000:0b:00.0: amdgpu: [mmhub] page fault
> (src_id:0 ring:0 vmid:6 pasid:32779, for process obs pid 23963 thread
> obs:cs0 pid 23977)
> [ 7315.156549] amdgpu 0000:0b:00.0: amdgpu:   in page starting at
> address 0x80011fdf6000 from client 18
> [ 7315.156551] amdgpu 0000:0b:00.0: amdgpu:
> MMVM_L2_PROTECTION_FAULT_STATUS:0x00641A51
> [ 7315.156554] amdgpu 0000:0b:00.0: amdgpu: Faulty UTCL2 client ID: VCN1 (0xd)
> [ 7315.156556] amdgpu 0000:0b:00.0: amdgpu: MORE_FAULTS: 0x1
> [ 7315.156559] amdgpu 0000:0b:00.0: amdgpu: WALKER_ERROR: 0x0
> [ 7315.156561] amdgpu 0000:0b:00.0: amdgpu: PERMISSION_FAULTS: 0x5
> [ 7315.156564] amdgpu 0000:0b:00.0: amdgpu: MAPPING_ERROR: 0x0
> [ 7315.156566] amdgpu 0000:0b:00.0: amdgpu: RW: 0x1
>
> This is a harmless panic, but nevertheless VAAPI does not work and the
> application that tried to use the encoder crashed.
>
> 2.
> If we tries again and again encode 4K stream through VAAPI we can
> encounter the next trace:
> [12341.860944] ------------[ cut here ]------------
> [12341.860961] kernel BUG at drivers/dma-buf/dma-resv.c:287!
> [12341.860968] invalid opcode: 0000 [#1] SMP NOPTI
> [12341.860972] CPU: 28 PID: 18261 Comm: kworker/28:0 Tainted: G
> W        --------- ---  5.12.0-0.rc5.180.fc35.x86_64+debug #1
> [12341.860977] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
> [12341.860981] Workqueue: events amdgpu_irq_handle_ih_soft [amdgpu]
> [12341.861102] RIP: 0010:dma_resv_add_shared_fence+0x2ab/0x2c0
> [12341.861108] Code: fd ff ff be 01 00 00 00 e8 e2 74 dc ff e9 ac fd
> ff ff 48 83 c4 18 be 03 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c5
> 74 dc ff <0f> 0b 31 ed e9 73 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00
> 90 0f
> [12341.861112] RSP: 0018:ffffb2f084c87bb0 EFLAGS: 00010246
> [12341.861115] RAX: 0000000000000002 RBX: ffff9f9551184998 RCX: 0000000000000000
> [12341.861119] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffff9f9551184a50
> [12341.861122] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
> [12341.861124] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9f91b9a18140
> [12341.861127] R13: ffff9f91c9020740 R14: ffff9f91c9020768 R15: 0000000000000000
> [12341.861130] FS:  0000000000000000(0000) GS:ffff9f984a200000(0000)
> knlGS:0000000000000000
> [12341.861133] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12341.861136] CR2: 0000144e080d8000 CR3: 000000010e98c000 CR4: 0000000000350ee0
> [12341.861139] Call Trace:
> [12341.861143]  amdgpu_vm_sdma_commit+0x182/0x220 [amdgpu]
> [12341.861251]  amdgpu_vm_bo_update_mapping.constprop.0+0x278/0x3c0 [amdgpu]
> [12341.861356]  amdgpu_vm_handle_fault+0x145/0x290 [amdgpu]
> [12341.861461]  gmc_v10_0_process_interrupt+0xb3/0x250 [amdgpu]
> [12341.861571]  ? _raw_spin_unlock_irqrestore+0x37/0x40
> [12341.861577]  ? lock_acquire+0x179/0x3a0
> [12341.861583]  ? lock_acquire+0x179/0x3a0
> [12341.861587]  ? amdgpu_irq_dispatch+0xc6/0x240 [amdgpu]
> [12341.861692]  amdgpu_irq_dispatch+0xc6/0x240 [amdgpu]
> [12341.861796]  amdgpu_ih_process+0x90/0x110 [amdgpu]
> [12341.861900]  process_one_work+0x2b0/0x5e0
> [12341.861906]  worker_thread+0x55/0x3c0
> [12341.861910]  ? process_one_work+0x5e0/0x5e0
> [12341.861915]  kthread+0x13a/0x150
> [12341.861918]  ? __kthread_bind_mask+0x60/0x60
> [12341.861922]  ret_from_fork+0x22/0x30
> [12341.861928] Modules linked in: uinput snd_seq_dummy rfcomm
> snd_hrtimer netconsole nft_objref nf_conntrack_netbios_ns
> nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> nf_tables nfnetlink cmac bnep sunrpc vfat fat hid_logitech_hidpp
> joydev hid_logitech_dj mt76x2u mt76x2_common mt76x02_usb mt76_usb
> mt76x02_lib intel_rapl_msr intel_rapl_common mt76 iwlmvm mac80211
> snd_hda_codec_realtek edac_mce_amd snd_hda_codec_generic ledtrig_audio
> snd_hda_codec_hdmi btusb kvm_amd snd_hda_intel btrtl snd_intel_dspcfg
> btbcm snd_intel_sdw_acpi snd_usb_audio uvcvideo btintel snd_hda_codec
> videobuf2_vmalloc snd_usbmidi_lib videobuf2_memops iwlwifi kvm
> bluetooth snd_rawmidi snd_hda_core snd_seq videobuf2_v4l2 snd_hwdep
> videobuf2_common snd_seq_device eeepc_wmi snd_pcm videodev asus_wmi
> sparse_keymap libarc4 mc irqbypass snd_timer ecdh_generic cfg80211
> video
> [12341.861969]  wmi_bmof rapl ecc snd sp5100_tco k10temp i2c_piix4
> soundcore rfkill acpi_cpufreq ip_tables amdgpu drm_ttm_helper ttm
> iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul cec crc32_pclmul
> crc32c_intel drm ghash_clmulni_intel igb nvme ccp dca nvme_core
> i2c_algo_bit wmi pinctrl_amd fuse
> [12341.862012] ---[ end trace 3503913ed2bda6ad ]---
> [12341.862018] RIP: 0010:dma_resv_add_shared_fence+0x2ab/0x2c0
> [12341.862024] Code: fd ff ff be 01 00 00 00 e8 e2 74 dc ff e9 ac fd
> ff ff 48 83 c4 18 be 03 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c5
> 74 dc ff <0f> 0b 31 ed e9 73 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00
> 90 0f
> [12341.862028] RSP: 0018:ffffb2f084c87bb0 EFLAGS: 00010246
> [12341.862035] RAX: 0000000000000002 RBX: ffff9f9551184998 RCX: 0000000000000000
> [12341.862039] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffff9f9551184a50
> [12341.862045] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
> [12341.862049] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9f91b9a18140
> [12341.862053] R13: ffff9f91c9020740 R14: ffff9f91c9020768 R15: 0000000000000000
> [12341.862057] FS:  0000000000000000(0000) GS:ffff9f984a200000(0000)
> knlGS:0000000000000000
> [12341.862062] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12341.862066] CR2: 0000144e080d8000 CR3: 000000010e98c000 CR4: 0000000000350ee0
> [12341.862072] note: kworker/28:0[18261] exited with preempt_count 1
> [12392.114261] BUG: workqueue lockup - pool cpus=28 node=0 flags=0x0
> nice=0 stuck for 50s!
> [12392.114276] Showing busy workqueues and worker pools:
> [12392.114279] workqueue events: flags=0x0
> [12392.114283]   pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=12/256 refcnt=14
> [12392.114289]     in-flight: 26978:amdgpu_irq_handle_ih_soft [amdgpu]
> [12392.114411]     pending: amdgpu_irq_handle_ih_soft [amdgpu],
> free_work, kfree_rcu_monitor, free_obj_work, psi_avgs_work,
> psi_avgs_work, psi_avgs_work, psi_avgs_work, psi_avgs_work,
> drm_mode_rmfb_work_fn [drm] BAR(2588), event_mall_stutter [amdgpu]
> [12392.114679]   pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=12/256 refcnt=13
> [12392.114684]     pending: psi_avgs_work, psi_avgs_work,
> psi_avgs_work, psi_avgs_work, psi_avgs_work, psi_avgs_work,
> psi_avgs_work, psi_avgs_work, psi_avgs_work, psi_avgs_work,
> psi_avgs_work, psi_avgs_work
> [12392.114704]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> [12392.114708]     pending: kfree_rcu_monitor
> [12392.114727] workqueue mm_percpu_wq: flags=0x8
> [12392.114730]   pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> [12392.114734]     pending: vmstat_update
> [12392.114739]   pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> [12392.114742]     pending: vmstat_update
> [12392.114826] pool 56: cpus=28 node=0 flags=0x0 nice=0 hung=50s
> workers=3 idle: 25238 14400
> [12394.038243] watchdog: BUG: soft lockup - CPU#27 stuck for 22s! [obs:27017]
> [12394.038262] Modules linked in: uinput snd_seq_dummy rfcomm
> snd_hrtimer netconsole nft_objref nf_conntrack_netbios_ns
> nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> nf_tables nfnetlink cmac bnep sunrpc vfat fat hid_logitech_hidpp
> joydev hid_logitech_dj mt76x2u mt76x2_common mt76x02_usb mt76_usb
> mt76x02_lib intel_rapl_msr intel_rapl_common mt76 iwlmvm mac80211
> snd_hda_codec_realtek edac_mce_amd snd_hda_codec_generic ledtrig_audio
> snd_hda_codec_hdmi btusb kvm_amd snd_hda_intel btrtl snd_intel_dspcfg
> btbcm snd_intel_sdw_acpi snd_usb_audio uvcvideo btintel snd_hda_codec
> videobuf2_vmalloc snd_usbmidi_lib videobuf2_memops iwlwifi kvm
> bluetooth snd_rawmidi snd_hda_core snd_seq videobuf2_v4l2 snd_hwdep
> videobuf2_common snd_seq_device eeepc_wmi snd_pcm videodev asus_wmi
> sparse_keymap libarc4 mc irqbypass snd_timer ecdh_generic cfg80211
> video
> [12394.038306]  wmi_bmof rapl ecc snd sp5100_tco k10temp i2c_piix4
> soundcore rfkill acpi_cpufreq ip_tables amdgpu drm_ttm_helper ttm
> iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul cec crc32_pclmul
> crc32c_intel drm ghash_clmulni_intel igb nvme ccp dca nvme_core
> i2c_algo_bit wmi pinctrl_amd fuse
> [12394.038328] irq event stamp: 0
> [12394.038331] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [12394.038337] hardirqs last disabled at (0): [<ffffffffaa0ddafb>]
> copy_process+0x91b/0x1e10
> [12394.038343] softirqs last  enabled at (0): [<ffffffffaa0ddafb>]
> copy_process+0x91b/0x1e10
> [12394.038347] softirqs last disabled at (0): [<0000000000000000>] 0x0
>
> This is much more dangerous and, as a rule, leads to system freezing.
>
> Full traces uploaded here:
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FaAeazCP8&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C15d8dd21061b4466fefd08d8fdff0df6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637538619197386172%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VLxZoY2WX%2BZIiPG4ADi37WJszWaFXR%2Bz5MimvKRlHR0%3D&amp;reserved=0
> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FZLUP8Xvs&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C15d8dd21061b4466fefd08d8fdff0df6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637538619197386172%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=J6PQR%2FDssvup2W5CTFLN7wsr79M2AZJDz1uT%2FfmxH1U%3D&amp;reserved=0
>
> It curious why ffmpeg does not cause such issues.
> For example such command not cause kernel panic:
> $ ffmpeg -f x11grab -framerate 60 -video_size 3840x2160 -i :0.0 -vf
> 'format=nv12,hwupload' -vaapi_device /dev/dri/renderD128 -vcodec
> h264_vaapi output3.mp4
>
> 1. Anyway, the user app shouldn't break the kernel.
> 2. Command above not working as expected because framerate is not 60
> on result video. The ended video is looking as grabbed at 1 frame per
> second or even less.
>
> My hardware:
> $ inxi -bM
> System:    Host: fedora Kernel:
> 5.12.0-0.rc6.20210408git454859c552da.186.fc35.x86_64 x86_64 bits: 64
> Desktop: GNOME 40.0
>             Distro: Fedora release 35 (Rawhide)
> Machine:   Type: Desktop Mobo: ASUSTeK model: ROG STRIX X570-I GAMING
> v: Rev X.0x serial: <superuser required>
>             UEFI: American Megatrends v: 3603 date: 03/20/2021
> Battery:   ID-1: hidpp_battery_0 charge: N/A condition: N/A
> CPU:       Info: 16-Core (2-Die) AMD Ryzen 9 3950X [MT MCP MCM] speed:
> 3433 MHz min/max: 2200/3500 MHz
> Graphics:  Device-1: Advanced Micro Devices [AMD/ATI] Navi 21 [Radeon
> RX 6800/6800 XT / 6900 XT] driver: amdgpu v: kernel
>             Device-2: AVerMedia Live Streamer CAM 513 type: USB driver:
> hid-generic,usbhid,uvcvideo
>             Device-3: AVerMedia Live Gamer Ultra-Video type: USB
> driver: hid-generic,snd-usb-audio,usbhid,uvcvideo
>             Display: wayland server: X.Org 1.21.1 driver: loaded:
> amdgpu,ati unloaded: fbdev,modesetting,radeon,vesa
>             resolution: 3840x2160~60Hz
>             OpenGL: renderer: AMD SIENNA_CICHLID (DRM 3.40.0
> 5.12.0-0.rc6.20210408git454859c552da.186.fc35.x86_64 LLVM 12.0.0)
>             v: 4.6 Mesa 21.1.0-devel
> Network:   Device-1: Intel Wi-Fi 6 AX200 driver: iwlwifi
>             Device-2: Intel I211 Gigabit Network driver: igb
> Drives:    Local Storage: total: 11.36 TiB used: 10.84 TiB (95.4%)
> Info:      Processes: 766 Uptime: 5h 12m Memory: 62.63 GiB used: 36.93
> GiB (59.0%) Shell: Bash inxi: 3.3.03
>
>

