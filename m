Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF6A428FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbhJKOCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:02:13 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:25056
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238127AbhJKOAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:00:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKiHZcAfUFklbvdsGAjJBcyVa4NT8XRpi7CQRurlGzpYjkGjEtPo9mz6ZQorZhXCvNQMvWv51vFSGWCdbIDl5q9TogXeEYY52uxJ27dXsseQVpqruKKD5LrXoLHU/pl96JGM9BEQPZK7Bvr+JGtAi8i58vke0I7GSY0ZD9A4mYsGgSa2vfyzR1Pt1YZnZ4plsl8MsNcQ7n0YS/ULK2EInXjng4puW60b0g4193s1QB9jFGGjHIz4iH+U+kX3cY8vG9vE2cphWzei63eAE4PKnSyBXQJK9uYUsyHtkwSKr27WWZp5256ShP7G2uXJGq/g/m0BZa2xMKYa8vILPD/jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ3i8mPkTy1kcwEcueANV5scD8j8U/PeYSI80pPxgDA=;
 b=EEFRedUBuz+y6i1Cw8EWL4WlRjiwdJCbl1q4q5cQc6NHbUTM2fLe1CNVaQPmVRpkf6xJIwqeUZef6oJi/+7daUqYWR27g8yFphQaqvlAChaN7EBjcC94rZioumuUMebvd1/Wxq/583RsVEEhMfUNQYtOgl3RjlVtP4tQTxKXCIPbDlm2uB2d916Dlqx9ZT+vTRAdY8jfwi/uCFgonUTdMQmduS4qFakALIiBV/m/sk6j7NuG8maO9/ybe3l7IoyoytuVqghKDGdwqJpDvRuvL1qbRJJ3YdxELTMGxOAwxfowYEyp7sfUCDpgJZriDLWoml878j8Mk+gNSjw0fnF/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ3i8mPkTy1kcwEcueANV5scD8j8U/PeYSI80pPxgDA=;
 b=fvy9wLqnTFGf9gFFJmJj445e795lPxWG7L6mD8NpcVHmZ35j/01yMsOEkWa3pHp+Gf6t9bPZsPxmK5bj4iNuyTfDZbINlZyZwLQpmmkmPLucllgOnV2cUEga6rYoStP8+DUD10d18P33hvSBg6Gr2G5iKv5/CeSVa7wOoGg1wNA=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5517.namprd12.prod.outlook.com (2603:10b6:5:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Mon, 11 Oct
 2021 13:58:04 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 13:58:04 +0000
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de>
 <YWQ3963xcO3xbFo5@zn.tnic> <87d93314-ba3e-464f-d051-84a8de674b06@amd.com>
 <139ed784-d622-b0d2-3650-736b42e624f0@molgen.mpg.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <be2b3cca-9822-4bb7-12b4-4c5c89318625@amd.com>
Date:   Mon, 11 Oct 2021 08:58:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <139ed784-d622-b0d2-3650-736b42e624f0@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:805:f2::36) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SN6PR04CA0095.namprd04.prod.outlook.com (2603:10b6:805:f2::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 13:58:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17a3ec5e-aeb8-4abe-4bce-08d98cbf255c
X-MS-TrafficTypeDiagnostic: DM6PR12MB5517:
X-Microsoft-Antispam-PRVS: <DM6PR12MB55179F3F54CAF83BA8F49BF1ECB59@DM6PR12MB5517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzld4DfBJSui1gLNnMwBtEBKVIHU49yM0lnjOu7JT407VeowwMNaEbZLsCaAbeNW7C28BIAO8QjeKOYNId3ZLPECK3VNRBt4j+4fAgzek8HGgVU2t21XvpU130F48ZcZocG0K+7tsHbaCFymOcBU704EXV1jnccfc0qrrVpuC4WVMpCSc72YtTH5DgFMF2NZrPn/gybm+GJdD5+cLcuWN0bmQkbCXE30kVh0Ih9MVJG15dyxdJG/Du9tYc8srkYZFmv8htC/35ZD0KNoi5m2bXGlSDTTUUNSJZENe+2+CGkcP/EPqRCnBvCCwfSozkA9YGFAA405pGs2ELVlkClT72QyR+HY7YrxzdSZfpxa7Aa/ODvrQ1w4SBjI9j3yYwgKdbKZZDU/TQAbyMOyOyAGDaXdeCf/6sYfLi3e6G4pJ9wEkHHmG5HKkg3JFfGXundosw/gEIQ+V9Q6kGTQGO0ua2a4Xg3LjYlGhxP6GKmBf0Vnhs8svJlzXuJkpffgoQxA2N5khiwvLXGpzltp2B+U4BXWHrQVzC8n/URXAW648kjEddVh210mCbFnklZo/tzCCcCfoND6brhaVS5xSliNWpHs69XXUmzZ3ormd+xCpVJAab2E7x1jhIPCJOmLFlhcL8NHi+r1PKG79yqgBJw16nPLHIgvUF+nRp8/AsjW0ULpxYDNVm3sWjHh9Brb2jF7QG05SKDJOMJ+q4hqejr6USUHo64mWOmzpaWj38oQZur61QTvTZR+xQdCBvyLHbNBlRmf8KdwAKOXIi3r1ycYjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(31696002)(8676002)(186003)(2616005)(8936002)(83380400001)(38100700002)(26005)(36756003)(956004)(31686004)(86362001)(66476007)(508600001)(66556008)(7416002)(5660300002)(66946007)(6486002)(54906003)(316002)(16576012)(6916009)(4326008)(2906002)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0hNZEVaOUFod1RXYmhXSFVWSzdvdjdaOWJxaHFac2lxc2hma3VlRStCOEhC?=
 =?utf-8?B?M1lhd2FDa3VlNHAyQURQVk9Bc0FpZ09kOUN2ZGZXYW5zcW9mZTY4RjFXaG1w?=
 =?utf-8?B?QzIzcWgvMitsSmd5dEZHS1JpN2k1VGFTbC9qeWNUT3UzelhLM01XYno2ZXR5?=
 =?utf-8?B?YVZ5MHBTanVkRlQ4SEdkcnBkWEcraWpvMEtpT1NuZGU2TFFLM2FmVGtUWkxn?=
 =?utf-8?B?SXZ0c3pnYVNydE40UDhBV1RKNS90cDJiakJZRFFjbzBqd2FiZXFyT0dnOUw3?=
 =?utf-8?B?OGVXUmpxKzRUaFdncFJ0RW1rU0JZc0NMZW9ycWRHNlg4V2RLYjh5RCthUFhB?=
 =?utf-8?B?SENxMVhOaS9uTTIrMWtsMnVMeGF1VFlqV2tFdWZsUVBsR0UvU3N5MjRGS0Ri?=
 =?utf-8?B?SWlFWU9nbWhBTjhseStNeUFPNlYzNzE1ekRvZ3JxTWlkeTdXL0NyeFQrTmNP?=
 =?utf-8?B?YXNuOG1nU2V4TU43a0dFMVZocnp4M296SlQzci9FWTNVaG10MjNndlVoNkc1?=
 =?utf-8?B?bmVFd2czWlBoZXQ5VVNpQW5vR3BXRGRjU3J3cEtMVG4wUC9pOFB0OHdCeFpG?=
 =?utf-8?B?NzBvZ3VGL2J1Y2d5TExVZTRKWEJ2RXhwb2FDYzB2U2xReXRraFpSZEtJVEVj?=
 =?utf-8?B?bDJ5bXZlK3NPcU92QkdDeHErNExwRWRCYTd0K0lya1YrZzc0Z0FJOGQ4NUV0?=
 =?utf-8?B?QjBuM2RWVU9Vb0NGNTBJc3lQWFpUSzhQd3lyK0FvMG4zTmJMeGorc1JYUGgw?=
 =?utf-8?B?Yzg2N3JuMXZrK0xKa3VpbGZ4cGVTbkxJUjc3eHljd25ob25PbTZncit5VWtT?=
 =?utf-8?B?NVE4dzdTVjFnNXpPRUhHMGFvVEZOaHp5TDlaMm5BQW9TbGZjUjRjTXlBdG8z?=
 =?utf-8?B?RDMzbUpodFRYVWtXNXkwSy9XeFRZalVzdEtwZkI5SFcrM0ZiVlMwS2l5QzVC?=
 =?utf-8?B?M0RIRjdQNGI2SXFiUDE0L1czWE5JaDFyaG9Sa3c4N1lFUzdTUlI5NXBIclU5?=
 =?utf-8?B?Q2ZiQkNFZXBTUXYwODlsTmpiNEF6ZWFFaVNnVmt5dCtRTy9pYnZLVGd0amNE?=
 =?utf-8?B?SFNWZndsME9JeDgxZEViK1A2eWtsa2cxaGUzT1BLdHVjL2oveFhWU2RLclky?=
 =?utf-8?B?NGFzWGNZSHlWRjcybTlua0VmSTRxSHJsK21lTjJFZm5vbWdla0JHU1YyS3o3?=
 =?utf-8?B?bThkdFlZajlZcU5kU29oNVdWdFExM1U3TFZtM1JlejZtYkloWkI3TWRWYzJZ?=
 =?utf-8?B?TDJWb2VRd3d4bWVJd2ZleWNXQjA3ZkVHZHA2dUhzRU5tMzJZcWRpTThjdmh0?=
 =?utf-8?B?cC9TcnpiVjErbjVNL2pkZlhWb2EzY2U4ajd4OVc1bmhBeXhPMjUrUWovMzJJ?=
 =?utf-8?B?WnVWNFFwTXd1bElqQXhuVnhZQldBL3pGT0NIbjREVVBXUVVIVHBUS1J1QzNq?=
 =?utf-8?B?eWUxZklUSVNHWTMzZzZZQ0lBKzVJL25xL25rK1cvRGNnazN4YjJXWGo5Qnhm?=
 =?utf-8?B?QW1hUnhENmd6WmYvdkZyUFExcVU4NzZPOUUxeXZCSHNVanJUbWVZaHlFdktM?=
 =?utf-8?B?OUs4N3REaTkyZktuaTZOcEFXYVlQNWhjUFUveHl0ZWNRSjRmQnVTUHBmdC83?=
 =?utf-8?B?enVBTi9adXFMV2pGSDhkeGlXUm0wVlErSGRoZVc0ODMyR1ZEUHV6b0dleWJa?=
 =?utf-8?B?ZThtSmpidGFUNXc4NWlyeS9tWWo4L2IrNGc4WUtJZXB6VDM2MXBaU2RaUWxl?=
 =?utf-8?Q?dwPH0kGCdQDIvPCHeg16BIOcvNfb9HEPFbqNtoz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a3ec5e-aeb8-4abe-4bce-08d98cbf255c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 13:58:04.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCb7WccaLWPWMXKkcynnLGFipKWCTzFHOfhAzTqpZoARkSnG8xvVwHWkz0/jUgTDwgayigX6NNMVKkg1cAwUmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5517
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 8:52 AM, Paul Menzel wrote:
> Dear Tom,
> 
> 
> Am 11.10.21 um 15:27 schrieb Tom Lendacky:
>> On 10/11/21 8:11 AM, Borislav Petkov wrote:
>>> On Mon, Oct 11, 2021 at 03:05:33PM +0200, Paul Menzel wrote:
>>>> I think, the IOMMU is enabled on the MSI B350M MORTAR, but otherwise, yes
>>>> this looks fine. The help text could also be updated to mention problems
>>>> with AMD Raven devices.
>>>
>>> This is not only about Raven GPUs but, as Alex explained, pretty much
>>> about every device which doesn't support a 48 bit DMA mask. I'll expand
>>> that aspect in the changelog.
>>
>> In general, non-GPU devices that don't support a 48-bit DMA mask work 
>> fine (assuming they have set their DMA mask appropriately). It really 
>> depends on whether SWIOTLB will be able to satisfy the memory 
>> requirements of the driver when the IOMMU is not enabled or in 
>> passthrough mode. Since GPU devices need/use a lot of memory, that 
>> becomes a problem.
> 
> How can I check that?

How can you check what? 32-bit DMA devices? GPUs? I need a bit more 
information...

Thanks,
Tom

> 
> 
> Kind regards,
> 
> Paul
