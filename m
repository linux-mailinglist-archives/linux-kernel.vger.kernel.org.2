Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA69423214
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhJEUeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:34:22 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:6881
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232250AbhJEUeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:34:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDdOqm2bX2LFNIGIYuWO/hGnlFhf4fpbiYZTxORhIZwblmIZRwRo41CXw/XFRS+y9F/R+XVXrplXL4IWK/iuIYEM2N7OwyvuXoyrzf5zibHXajJeKUCJVKdCyNw0c8YRYJoQ6x6vSnxhVE/F6jlgDfuricKWy1LuM0gvVMHGG3u9LScizjXj2rGkBMmNzZk2Qz529whIHxc+uW//GCJUuCUj0oaGWO5jM+8yh+0RXAq6Tad7BD2rg0XYYxR2olqQfflEcvipcz3U16G10P2ymYtZMsYnx5YR99ANRTTo9eTcjyz90yCFl4/yqXYob7w605YylcO+NAgxiL/xZcXWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2QbQfN1sDzg8ujE8jcDeU8elVWXnFVuiBtWV++C/wM=;
 b=Vkj0xxIqzuduXyIy4Xow/7RaXUEuNflrhehs10sQ9B2g1agjyxZAvp4Kavlez5gVlXlY2pTHo/S4vVaL4sjE2cGdc7zRUJ/tYB3PpeToQKNwNDZxCIZHe4iFHvtqHf/H6UPezSdySY8eJ9tSxDS9eQ3ALQMtzPVuGosq+HZNTnkOUxHGkZKHuyGgHoE82RTazUbkilzTMIn6DVtDscc9IY/3AhxmJE5sQg/XArZd27MBIeO/B829KRvoCz0lXFwcD2e8pTIon6ZIqJsUpSANaEFjtSJ+dpfLbqJ855ubrnjeuPuKVhgt6EscpUvAXC/ltQpk/uUsF7lZorA42i7L1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2QbQfN1sDzg8ujE8jcDeU8elVWXnFVuiBtWV++C/wM=;
 b=kRNpG7LLJaK8cCbfBJgJqRu4u4HGqsKqgegF6A0vQjuQ8Mtha3xVhkySvF/2rcDLEV4ADBjivCmNTi8mKttBrKckBctQBGJHl5aGZoFhs4xTU5rUNzoQmCxW9LwdUY2QqIF2P0mIUCmgWMML6sumND6JH5BE5wZDt76QDNqpDPw=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 20:32:25 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 20:32:25 +0000
Cc:     brijesh.singh@amd.com, Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -v2] x86/sev: Make the #VC exception stacks part of the
 default stacks storage
To:     Borislav Petkov <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>
References: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
 <YVbNlXwiASQEsG+x@zn.tnic> <YVb2AGXAwYx/OI6J@suse.de>
 <YVcF9ENTfLAGaLec@zn.tnic> <YVcGdpVuSsieFL8W@suse.de>
 <YVcSuVqmTPiw4YLk@zn.tnic> <YVdx/SRNkeRFnIuX@zn.tnic>
 <YVsY95SXNN4uTCCl@zn.tnic> <YVt1IMjIs7pIZTRR@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ee362ce2-b2cc-026e-3137-c4860becd269@amd.com>
Date:   Tue, 5 Oct 2021 15:32:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YVt1IMjIs7pIZTRR@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0058.namprd05.prod.outlook.com
 (2603:10b6:803:41::35) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by SN4PR0501CA0058.namprd05.prod.outlook.com (2603:10b6:803:41::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.15 via Frontend Transport; Tue, 5 Oct 2021 20:32:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b51d85e7-db10-4507-e48b-08d9883f3e21
X-MS-TrafficTypeDiagnostic: SN6PR12MB2718:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27181A31186D69D81498BE71E5AF9@SN6PR12MB2718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IfmqPhcHjdmNPlvwyRrLFHEpWmH5dXi85PVbKTugcfmCqFBNWh0Afj0Wh/KfPrKNP9qq4DW0JQMvvK5ToH6VXL4tfmpsghv5rEEYYcX0HuQN/JVbqRVeYWQxkWycqbxgK5AteZWa+zE7jh/Z5/j9/LaTo7XRbE0UKHtoM/whSB0+4/qBXymkmqm4dX/0QY9waT30OW29O71OLu1IVZbe0ePAslq/oGD1Lwp7CJ9Y3jBD5TW1M24Y6pWFapRIe5UN2R+rkMMQ78E/aQq+6jswvgjC0HzvXhSRbUFGaPefdANY7FoYTXqO/myuwI7bIPybQo3kmZu0J1LW5132a9GG+nh861+ETFcN70D96HhgBCL/LmWseVvH2FRUum8TWxE8pZHWJzx9y8NxIBQFxorAsv+ZybNvqlE1/UWm4HVdzrycKcSLDqQlg8BuM6UnghsrUU1fEm6MT7RL/sgIXFoUjn3hA2JYNZJ5Pd/M/cyckTfUGf4I776l9yQ2nLsZJwl4AYl5db0Z3cKAUIE9cu0oya92Sd0mZZpKSTBHmCFOnrBWufCMZPzcanLXNH6Rlay+xFXeN9zO2qk3cEEx4Auib5bPcV2u3pum534SxlQpTmhGGD7kpXbm11Ov8gCar8WCBpzhvxZT9rdyG9wLXmAPTn6FMTTbcCdxFOCDvYy8b9BXu9PjjSFcK3mXM/azyQd74GV7RGs7HEHNlpZVZSMNEBNpNCbqRPAzVsN7YArgW/OOG/rkzpkhuC+N8F6+TyX7yR4gC8wlBcvkO5764piX/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8936002)(8676002)(6486002)(31696002)(4744005)(36756003)(66946007)(16576012)(316002)(956004)(38100700002)(4326008)(38350700002)(2616005)(5660300002)(26005)(186003)(54906003)(110136005)(2906002)(508600001)(66476007)(53546011)(66556008)(44832011)(31686004)(86362001)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2RWbDUzb1Z3REhYdnNWTjRvTHp0RUVBeHlSelBlT2pLWXlzalFRV1VSV1Bs?=
 =?utf-8?B?ZmZ6OWFpS050MHVWVWtHb2ZNQW9aaDhoK3kyZHhDT0dSRUdxNXdNKzVkTmNx?=
 =?utf-8?B?eXFUa1IyM2U2RVRNTHp6RXdMRERTZk8wdDMvRithRTMxaGowUG9wdm1Udno1?=
 =?utf-8?B?Q2tSY0g2TDlWZTQvaTRKWWFYckUvY0tLYWlwMEVNcGE3Y2ErNWZwS1VkYkdR?=
 =?utf-8?B?djExeGI1S0NrRzc0eHYzWmhVNWpNemdEd2liQVY3L1ZGNk1Db3MvR1NYaGpq?=
 =?utf-8?B?M0NCYVh3Rkp3WWlrdWtBUW96MFJza25FaytwaFZhYlRQa250MHVWNHBzWStH?=
 =?utf-8?B?ZUhQR01WcWZSNTc5VFVmcWtqVnl5MXlwcXd1anVDZUhYekxUVDE0ZUNVY2dJ?=
 =?utf-8?B?NS9zR2VSakpxZ1RVUkR3MmFrREIwSjJNWUtJa3YwaEFPcGtpVUhrQzdvbFJa?=
 =?utf-8?B?cjMzNXFDTlFDdWUvQmpMZDZRWUlRbFk4aVlwVUhVVzY0RGdPOENTeE1VUDJQ?=
 =?utf-8?B?ZXkzN1ZReC83ZnBzZWdIcHE5Y2pQQVM0LzgrM21LVm13TmIwWm13SW9FY2JT?=
 =?utf-8?B?amJjdXc3QXNqbzRZVHVYOWxwUFZNQXRRTnhWN1lPd2JvYUU2c3BoM1UwcXlP?=
 =?utf-8?B?cnVaUDJsSzY5Z09LUS9MK3FkNnFCbUw3NFNraWovaGw5Q3h4TEd1L0RDRnpn?=
 =?utf-8?B?Z05yMW1vRlByZVl2WUhSTU5vK2w1bEZvblNMWk1PZ2FxTXI1YlNqcGxuTWJ2?=
 =?utf-8?B?UklGU1IrcUpkN0JDeHpDVHJGdmt1c2hOcWtwdVhFczlUa05mY25VaFBXb2V4?=
 =?utf-8?B?bm5NTVQrTmZld0FCai8rMzR1L2tqdnJaKzJFTnYyNVZlSkdTVTJsSmRVYytq?=
 =?utf-8?B?R3ZaL3pjL25iWkJpdm1wZnVDTU5nM0RDcHF1TXVUNitTOHRhTmFaT08yWTB1?=
 =?utf-8?B?QTc1eEc4YmVlWmxvQUVtOVo5anQ4c04ybGFCTEtReWVab3JHSUt1Yy9lMW9z?=
 =?utf-8?B?NDgzV0xjWjBhK2RYU0RnK0JoRVJiSmp4R1VUczNTN3BqNFJMUklkTUd5TmZt?=
 =?utf-8?B?d0tVY0pCb1JUY21ZeVJScWJuM3kyT0NYTWpnY0syV0ZzQlhjU2ZLSHFOK21n?=
 =?utf-8?B?V0c5QzkwQXVoWVdUdXB4LzZ0cm82UVdpc1BWUXlMWGtSaXJTMnljT3ZSRnE4?=
 =?utf-8?B?NHJEZkJmTEZTVjdka3pCWkRZcjBSK3JXNG5FYzlnQ3pKVWVKQ3hwMG9qalov?=
 =?utf-8?B?Zm9NVWYxd1NFMDlXMjNscURDTTF1MDBaSEIxRk56b25pWWQ0YXEzbzVaRTZU?=
 =?utf-8?B?eXRUTG0rMmpVUlZiOGExOXhheWppbEY3cHRuNVB4RVdqTy9kUmtjb29RSUNp?=
 =?utf-8?B?dTBvUGFheG5ONElMUjJldk5GSW9zMHA0a013dUxUUlFSRytnM2UxWHFzRktE?=
 =?utf-8?B?a014aGVBTldYTndoeHVhcjQwczBwVk1DRm1CdzR6MStBYjdUZlJya09ZR3V1?=
 =?utf-8?B?OGJ2RHg3aXE3UjhzN3ovcG5QQzBkQ3FLbXp1RkRwaGU5TnZXY2NmaXFaNXZz?=
 =?utf-8?B?aGlBNVdTeFh4UnR4ZFBVT3lRQ1lvVzFSVTNlWWF0V3JjampMNytvaGZYenpR?=
 =?utf-8?B?NVphM3hTbCtSVlBBSVFyRlNwQ1NHMkc0TDZiNisyZ09KUjEzK3VlV2lHT2VO?=
 =?utf-8?B?QkRaU203T0NRcUJHZEpMV254a3pPSkMzTVZaUEFpcXRnYlg5eG5YUk9WNUZq?=
 =?utf-8?Q?GJjwdutAneIz8fV2+sk+6E6h4mQ/wF0xmogGu4a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51d85e7-db10-4507-e48b-08d9883f3e21
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 20:32:25.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFbN7U0PRXCPi6AQfgcrEbjsBdn1Ih3k4M+8ZRtG8Fye8lZFc6h8KrghZoPNE/XbXq7oYOngUmYSudv4XpqFkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2718
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/21 4:41 PM, Borislav Petkov wrote:
> Yap,
> 
> here's v2, now tested. It seems we do need that optional_stack_size
> second arg to ESTACKS_MEMBERS(), thx Tom.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> 
> The size of the exception stacks was increased by the commit in Fixes,
> resulting in stack sizes greater than a page in size. The #VC exception
> handling was only mapping the first (bottom) page, resulting in an
> SEV-ES guest failing to boot.
> 
> Make the #VC exception stacks part of the default exception stacks
> storage and allocate them with a CONFIG_AMD_MEM_ENCRYPT=y .config. Map
> them only when a SEV-ES guest has been detected.
> 
> Rip out the custom VC stacks mapping and storage code.
> 
>   [ bp: Steal and adapt Tom's commit message. ]
> 
> Fixes: 7fae4c24a2b8 ("x86: Increase exception stack sizes")
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---

Tested-by: Brijesh Singh <brijesh.singh@amd.com>

thanks
