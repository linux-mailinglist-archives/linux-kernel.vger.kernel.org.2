Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A6733D5DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbhCPOhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:37:17 -0400
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:3329
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235591AbhCPOgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:36:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6rsyCKSONT2P0U8Gfn65nHbTs5pDrdt4Stek7jENUbHq7C4S1r8lCvoQZiuDDwB5y5KcVLmIa9pSvheGO4oPq5WxVEeOexdjIWxKUKcZySbMU+HBNNgmVNIYnsUKuyDcHOe5dJwQDIXoOES1OV5w7jU75YDSZEdj2umi1UvKewZ6E6JEmaZtScSa9c4EIbZG60zhXlv92EXH0LCoGfTF8AefdfOTP+IONSYKjh8uhOlARebdF/Vrs43uwnv+vjTIkT25YtAPDqoFk7xUBzXfB59UB9JdweeRinYksxseCt1JFAwLuBa9svYuH1oGiEBi4BHG6sWX2QvdippNnR1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHlr4KsNUB0d+V5qJBjL/ZFPx9et/SH96q4l2hUKqMA=;
 b=mqNhavFAobihp2eHncxLvLXAZB8qF3L6+YCk3aSGpq7gnp51b3v0BtCuS7A/FKOVFPKMH5of5gE4vLVsSIjEFoRsBi2H+zaFMwhQZOLGW1UP6bR90yCXdvfQshswbB7NWg5sGRTFOW+BySx4JvOlg96oNj/YSmeRBQVYo+ylxl8hCBE9i152YMirol1oxfEAWuQDcWJNyulmZVGLXa4EddPaA0UcnVpi7d7pmVs88SCH7PFgY5s2YmDwX+b2Yz4PPEOKDs5QQtE5dmFimnhHYRFfzbisYvUeJQV9CGsDKaawvcL4+LGXdT1O6Id5cl4Kfh5wJr7zOhyfPvNXV9botg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHlr4KsNUB0d+V5qJBjL/ZFPx9et/SH96q4l2hUKqMA=;
 b=hcRk+sDCmf3YgMxG/gv77/8Vseztx2AwGxvP5UbZxTaMTMKfRRtygNy94ingqLfckYQzqa99p0Xeb7s4s8IktX7VXh13eV7lrbEstI3UwyBQ2fUJbj9yT6cCKIWq1qz9jaNOY1ZjgQXpTBhifUcvRk4HOus3+pyGwt/cc7Yip8s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 14:36:35 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 14:36:35 +0000
Subject: Re: [PATCH 1/1] amdgpu: use MMIO to init atombios if device is
 Thunderbolt / USB4 attached
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <PSXP216MB0438E23D0F4C2DFF2D9B8686806D9@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <CADnq5_Mqc3H07BtJbaGpt8XGnpXgaZvxDsS_e0cnZ++kWdQR-g@mail.gmail.com>
 <PSXP216MB043819E5E33ECCDBBAB490BC806B9@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <0c968142-1fd2-be34-4345-c5e796dc5d13@amd.com>
Date:   Tue, 16 Mar 2021 10:36:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <PSXP216MB043819E5E33ECCDBBAB490BC806B9@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:5590:b510:518f:11dc]
X-ClientProxiedBy: YT1PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::25) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:5590:b510:518f:11dc] (2607:fea8:3edf:49b0:5590:b510:518f:11dc) by YT1PR01CA0086.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 14:36:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2f224c7-287a-4af1-5675-08d8e888e689
X-MS-TrafficTypeDiagnostic: SA0PR12MB4448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44489873F92049A29F59E7FEEA6B9@SA0PR12MB4448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +irnjjZqrDeIANXmA8B4t77Mv5ihMTyA6dJhza5jzjneYrzp6GJUEsRXhD/33xNXYSTbMHsryazSKLhGr763kQPOX9inygm5/1R7TllxbfOcl0O3cihJtjJ3I4/SqCc7/+tqWBeDent9S/LUj2QcrAIjPxGmMrZvLgqQkHqL8Ah1skgqkyht3g1Sc1l5aFaIyibF/jdZk8R7BjC8us8p3uWkkk2yH0nKjABi7fjwrdeWg/uaF8QVtHPxHbO4qn8u0GkgOnzQEaXbsgPVwdHs3fMXYkc+hX+BqWhDe7Cg2ACU5yJZNgz1LIMZdhUttKmgbChSmA/BvOLUmMFJhGppjTByCmcM2Hw0T64JGLjNVVMvAwcpXwVfAV5esb/jbLXmMDWTE3QBtT7Rlb06OABjxCzc+QbXYLKdI2AXyubDLwlJzgtHjts2Ec4uXSuIJbe4oIQ0t71dV9mte8xCQKNw3uXKniNF1YlGAz0i68sfwZWo9K+/dUq1Uy5Kb6w++lC5uRCD7E+W+1wMr87QSsNkBNm9iJ6XVenIrNkAQa98CyEd07raKfOF0EMOJcTiTdZDpSsHbkvSbI5TAzugqRuTeKNH5uC1OQ8f8F1hjajr0IZwQIeqIPagsYXUXfNCvHCgi8QQuf3HGy0ct6984A2BfZPCYttwqPlgj3izHd7/3xLbZe5SM6RapM2dlXjbCFAGmSeLMqOA+Wt4Vn64lJC3bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(66476007)(53546011)(66946007)(110136005)(186003)(16526019)(5660300002)(66556008)(31686004)(2616005)(34580700001)(316002)(83380400001)(478600001)(6486002)(4326008)(52116002)(45080400002)(8676002)(966005)(36756003)(31696002)(44832011)(8936002)(2906002)(54906003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S0w5clBvMW5IRnNNQVd4clhLWFY1NHRJSmdrOTVZSWV6YzNiSklPa2d1dUd4?=
 =?utf-8?B?bzhkZURoMUtKNVc4N2xiT2ZYMmdhVGV2RnlWWWplbW4yYll1dUpNK0dTZGJl?=
 =?utf-8?B?T0R1SFFjQWhVZkViSkJIaU8vSHU1TDh0NHplcDdlbFoydHMrTFFWQUxOeGN1?=
 =?utf-8?B?S09VS1pUTDUvQ0VpeGczZDJGTVJDcEFtL1RyQjBmTmpkem1VMHlSSHdaMTk0?=
 =?utf-8?B?MmR3SGU1S05zbmhjZGFlcTZTRnozSExmd1BTRFVaalNlZzBSNytKYlE0RHd0?=
 =?utf-8?B?NXRBRUtZTDZQNUZuS2JGMHFKaXJVcjc4UUI0amVnZUdDU2xzRDFVSk41UzlH?=
 =?utf-8?B?akpjWXN0alVFcTQrb1BCemtWbjEreDI4YTNwaERMeTRWNCs3U0hxTnBMRlJV?=
 =?utf-8?B?YjJOTU9aeDJOdC94YmdGVGh5ekNIemJnTnoySHg3Y2tRMmtwYzFOQVlLM2Jj?=
 =?utf-8?B?VzJCeWlWeWtKakN2QkhYaVN1dzlBemxHOEV3eHU3ZDB1c3I3REFIUkJSbnlw?=
 =?utf-8?B?TVNldThER0cwUlRnZDJ2Y0c0ZWJENFhOV2Vpd1lPYi9pS1VxOEdkc2lnSzBh?=
 =?utf-8?B?dFg2U3pSWVZXVnplTGJiaGlhdWhLWHdST2hZV0FMWTd3TDVWeE5HUDdaOHBB?=
 =?utf-8?B?d3lUYkY1c0wzcGdMK21ESzZZWitXbWZLVERvZ0l5RXBTTGRrV3RicktYdjlS?=
 =?utf-8?B?ajNMZ0VHV3dZVlFQS3ROb3NheGlmYXFjeUtzN3F0S0pEdHRPSGY2cHF3ZkFu?=
 =?utf-8?B?SUhIUjZ2cEtxRndoV3VUeHc3Rk02NGJ6RDNtbzBVL0w0Vi9MNE5UNUlCakh0?=
 =?utf-8?B?Wjh4b01NSUFEamxXSGxIRDQ3UkIxOGFSNVdCbFNsc2pVSzV2VThSQkVvSkxT?=
 =?utf-8?B?L2Q5T0JVTXl4dDZDWmNkaXBYeDFQRW9renF1MFVtSTEzL2NSMzFpN21RNWd6?=
 =?utf-8?B?bDN5NkNIZUxkNnhrUTllNXNGNURJNlM4dzNuY3N0THV1QXFwb0pUK1RmWEgw?=
 =?utf-8?B?ZExBQ0NSandoN0ttN3psK0diM2NlS21SNmhGcks0eU84RlRCc3UyS1BuaHkv?=
 =?utf-8?B?U1pLdnV6M0VrSzlaVWsxMjdQUTg2OEFWM0c3Q1FJYUpsK0ttUG5uSGIydjNR?=
 =?utf-8?B?K1R3STZJZ1JJTi9WdFVwVFRsVEsveWtndWptMjRBVnJjeGx3Ynp6aTlmTjFI?=
 =?utf-8?B?VkRIZnRhRlpPWk9RMmxqdWJyNzRnUC9XbVh5bkZSR0xjd3ZXS3R1OG5kOW54?=
 =?utf-8?B?dXJXRlBlUHFNNEs5WUsrMlJYMlV1ZmFqVFFsajVTQlozVHJnRXZRSHBIaHNu?=
 =?utf-8?B?RFF2MUZhNndJakY5UyswNWdLbU9YTDViaGg2cWsrNWtrNi9OeHBoWDIyelFR?=
 =?utf-8?B?ZUl4U2JralUwczQ3VTVmVDBGVXdFY2dNL3Y5b1FBeXB5NlFiQUw5aEQvYXdM?=
 =?utf-8?B?TjlYa1FZaTNsQ293d3RqalNYV01FMVp4dXFaTXZyS3lZOHBjOWhtQy84T01N?=
 =?utf-8?B?TDF4SHgxcTBrYUxack91UVBhYUYvQ1VFbkduTG0rK00rOGlrMXRkUTd5bXM3?=
 =?utf-8?B?MExLaVFOa0JFRXl3QjdCczZOS1l1VW9lUjlCdG9sL1FQWVJaMDhtM1ZhdEpq?=
 =?utf-8?B?Q04waEw4N2thQnREQzBrQlBWNU5yWlVrbjVVTTQ3Tm5oNXE5a05IdE5uOWw3?=
 =?utf-8?B?OFpYRFFMU2lzMEppK1VvRzk1Vk4rc25aL3QrRGJhdkxtTUxuOW9ZT3Y4bU9p?=
 =?utf-8?B?bXRFSVU4NTM3dTFuZVZQbVduL0VnQlBISjFwdSs0cGJQSk0xK3dlK3lTS1lE?=
 =?utf-8?B?bjVmdEwrSTJQUUdKTFIrMmlmeE1YV0thK2tPWGl6a0daY2VxaEZwNFBMak5W?=
 =?utf-8?Q?XPk58pdjBq+EA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f224c7-287a-4af1-5675-08d8e888e689
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 14:36:35.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEFqnKzHQVEZZNj0jnfXh8uyghsMgF7i5suxUyo1CSn9aKTaGYfuF3kkFTQL5i8jqfKxAupfLQ6ZJ3j3GonHlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We actually do, while currently it's on hold since I switched to working 
on surprise insertion
for some time it still would be helpful if you could give it a try.

https://cgit.freedesktop.org/~agrodzov/linux/log/?h=drm-misc-next

Andrey

On 2021-03-15 11:01 p.m., Nicholas Johnson wrote:
> On Mon, Mar 15, 2021 at 11:05:21AM -0400, Alex Deucher wrote:
>> On Mon, Mar 15, 2021 at 4:04 AM Nicholas Johnson
>> <nicholas.johnson-opensource@outlook.com.au> wrote:
>>> When using some Thunderbolt hosts using BIOS-assisted PCI enumeration
>>> with IO BAR assigned, we get an atombios timeout, such as:
>>>
>>> [drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than 20secs aborting
>>> [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing B456 (len 304, WS 4, PS 0) @ 0xB51B
>>> [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing B104 (len 183, WS 0, PS 8) @ 0xB17E
>>> amdgpu 0000:08:00.0: amdgpu: gpu post error!
>>> amdgpu 0000:08:00.0: amdgpu: Fatal error during GPU init
>>> amdgpu: probe of 0000:08:00.0 failed with error -22
>>>
>>> A workaround is to use MMIO to access ATOMBIOS when device is
>>> Thunderbolt / USB4 attached.
>> Missing your signed-off-by.  Also, we can just remove the legacy IO
>> callbacks altogether.  They are leftover from radeon and not required
>> at all on amdgpu.
> Sorry, it's been a while; I forgot "-s". And I like your patch much
> better. I look forward to the day when all new PCIe devices only have
> 64-bit MMIO_PREF BARs.
>
> Thanks for looking at this! If you are still doing work on surprise
> removal / driver unloading for Thunderbolt, then I am happy to do
> testing for you. Removal of DRM devices in Linux is the main sore point
> for me, and I would love to see it through.
>
> Regards,
> Nicholas Johnson
>> Alex
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>>> index 86add0f4e..5d16ec10d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>>> @@ -1999,11 +1999,15 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
>>>          atom_card_info->reg_read = cail_reg_read;
>>>          atom_card_info->reg_write = cail_reg_write;
>>>          /* needed for iio ops */
>>> -       if (adev->rio_mem) {
>>> +       if (adev->rio_mem && !pci_is_thunderbolt_attached(adev->pdev)) {
>>>                  atom_card_info->ioreg_read = cail_ioreg_read;
>>>                  atom_card_info->ioreg_write = cail_ioreg_write;
>>>          } else {
>>> -               DRM_DEBUG("PCI I/O BAR is not found. Using MMIO to access ATOM BIOS\n");
>>> +               if (pci_is_thunderbolt_attached(adev->pdev))
>>> +                       DRM_DEBUG("Device is attached via Thunderbolt / USB4. Using MMIO to access ATOM BIOS\n");
>>> +               else
>>> +                       DRM_DEBUG("PCI I/O BAR is not found. Using MMIO to access ATOM BIOS\n");
>>> +
>>>                  atom_card_info->ioreg_read = cail_reg_read;
>>>                  atom_card_info->ioreg_write = cail_reg_write;
>>>          }
>>> --
>>> 2.30.2
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cbbb3dd71d833433cc92b08d8e8537709%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637514792478220135%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=LBx9fok9E7hD8AKWm9kqFVjhsxsvnLKifDX18MR3eC4%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cbbb3dd71d833433cc92b08d8e8537709%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637514792478230124%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3uh0ATLmWUeuYF6b0GZ64b5sKvzyWk2p0v8LjXJf9Ww%3D&amp;reserved=0
