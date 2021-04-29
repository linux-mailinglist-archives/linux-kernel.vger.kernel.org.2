Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5661536EB2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbhD2NJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:09:59 -0400
Received: from mail-eopbgr1310047.outbound.protection.outlook.com ([40.107.131.47]:10499
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239555AbhD2NJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:09:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c420ev7UEZ9htod+I+mLeXABfvlKX7nI4rX2Zf3FP1hRQo2wgBA66+/QPE8NBcfRfEI8q1wQb78iz7eg7N1TjaHIhfrWsLyi6GQq/u9rG2H5x9l96fVTuhU5rFNMZvmbda6M+I6DA5iFK7gmyivb2fYXUDNbYDJYYpOvMwVM9Ckn50NlT3aGFRi+y4uBkFkMYQ4YYHSXFFGXaUbHM69Eqizyae/FXtgC9Kp5J3MI8eZEfd+GdqagqYrB2uC+1tZDUyQf+04lVt8ZBoR1B4FMXrBJtfjWLeK8RW/PbqBehwexRDhK7XbReBF3+OxJSBFmnQTXXUVdgVyYEMX6Vood1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf9vPHE27gwOymeLl//mzpl0g1bbPzN2Do509XYYjDc=;
 b=OJ0OQxZL3Hc7assXh35v0PNJvlLoOzUd8TVr8sT9GddBF/Q+O724AB89cxx8hPCsHLPQgmDqvdVejKhg6Ti9lNLLfl358bngTe5Chb2ktORKWaAcFnGvs0seFAS6dpB3JyCuvubOJB3eF9j9rxWAwjmaWEzeI9x11z+lNHOhybZNQm980a6nyh8KriwlTf39wlg1Q5afBWhL+ml2u4TIl+C0XTw9d++ptvhYTh+hLzICQQNMxVWD1uwVU3EcsF7f8DCy6pjAd9Bsr9977+UOeTkc6Tw1Vt25SNCQAi8eS+FW8s2G0EXbY05eXy5GlKLTq8UXTo40SKbZyNRdOYE2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf9vPHE27gwOymeLl//mzpl0g1bbPzN2Do509XYYjDc=;
 b=fus/RpkdRa65uuPi3wiyUAoz4PDIy7Xm0fCnjl7Or8qi6C6VliBJvwS4vJHhru4FwyJOkVq1JYD3aAbLsIzBt+KQUBogZRqgVfj0jQMe2DAovbrtFDXbE5X6NWzqqzflT9hZeuc6mWHu9o4zQ9XtgVWXej0/DtFWb+aH0Ol0zFk=
Authentication-Results: lists.linux.it; dkim=none (message not signed)
 header.d=none;lists.linux.it; dmarc=none action=none header.from=oppo.com;
Received: from HK0PR02MB2690.apcprd02.prod.outlook.com (2603:1096:203:6e::12)
 by HK0PR02MB2418.apcprd02.prod.outlook.com (2603:1096:203:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 13:08:46 +0000
Received: from HK0PR02MB2690.apcprd02.prod.outlook.com
 ([fe80::dcc:ee46:e56f:16f6]) by HK0PR02MB2690.apcprd02.prod.outlook.com
 ([fe80::dcc:ee46:e56f:16f6%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 13:08:46 +0000
Subject: Re: [LTP] [f2fs] 02eb84b96b: ltp.swapon03.fail
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Huang Jianan <huangjianan@oppo.com>
Cc:     Matthew Wilcox <willy@infradead.org>, rpalethorpe@suse.de,
        kernel test robot <oliver.sang@intel.com>, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ltp@lists.linux.it
References: <20210308072510.GA902@xsang-OptiPlex-9020>
 <87h7llhnfe.fsf@suse.de> <c75229cc-e325-1c8b-0afa-fd236db8319c@oppo.com>
 <20210309040144.GH3479805@casper.infradead.org>
 <c84bf5c9-501e-6c25-1728-a7c6281093fd@oppo.com> <YEkw0J9VEg66AgIt@google.com>
 <e2009f2d-253d-264c-53ca-fa644897a952@huawei.com>
From:   Weichao Guo <guoweichao@oppo.com>
Message-ID: <cf28837a-9558-b00c-bca3-601a70b752ea@oppo.com>
Date:   Thu, 29 Apr 2021 21:08:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <e2009f2d-253d-264c-53ca-fa644897a952@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.255.79.106]
X-ClientProxiedBy: HKAPR03CA0029.apcprd03.prod.outlook.com
 (2603:1096:203:c9::16) To HK0PR02MB2690.apcprd02.prod.outlook.com
 (2603:1096:203:6e::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.119.35.139] (58.255.79.106) by HKAPR03CA0029.apcprd03.prod.outlook.com (2603:1096:203:c9::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.10 via Frontend Transport; Thu, 29 Apr 2021 13:08:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4937788a-5d7f-4e39-b7f8-08d90b0feba3
X-MS-TrafficTypeDiagnostic: HK0PR02MB2418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR02MB24189B9435EADD47F01227DFB65F9@HK0PR02MB2418.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNUB08iRy9gM6MXJj+H2U6zB7N7jVH4V0SrX35g9BdrlK679z9eyyWDeMr7xWycfiRYgX1CQ9QXsB3UwbxMUYRwr5rLvSsc6SNV2CHgZiknD9EsbTTadSU1jY54BGjeOJcGovzDkphlpoDPQepXcSNOwkiQtHqZBX1r5luz5c9AMCtXhv+4RXh9CZXmX1TiKmGQO5orFc0rwGxWnPv7s7MgMIYDPAqSIvCsFv1chvqUez3ySju0Su3JhiGJxAd6PvkVrXS6woghCc2Wfw42nz5Ob8txRPXZWQvuiGgjL+sp63pzb6HH+WsnzgqWHoFHogMAn8xrfnMoS6sLrOgFTHcBFtD2vtS8iMpY2AZOfvDFKuokHNAedRinX2jDHBs+FIqus+joUk/Ins1TKCql6zSVAjwGoB0o73Ts2tYGT6+v9IKGa6eZtauaXWS0ar8Oklnvl0r+7kaosfbqYR0iRtf+k+xYUpM7z8Rko06uhPcT473U0nLxMv7U7GlJ/7EwVtkZu5WgUO8IKyxsq291ZXDtU47gWx79NVESr6mdJdylU3pEa9Mquwc4GBVpTNXpOrBZB8p0ze1WdP3x7W2nSTmn8XefJZtYUfkD4qK0o+DuYyRaDZKLo3VT6i53RsXtIoa+rxQZGOisDmLHvoGqlmk7rPl7ef68+Kmt3/eLxYEG/IZVL+Fvk+MFRT7FRQlNKPPH+1SAJnFatV0iwi4wAwb921BgPBa5bJMpfKEz73pQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR02MB2690.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(8676002)(86362001)(66476007)(66556008)(38350700002)(7416002)(2616005)(26005)(31686004)(186003)(52116002)(5660300002)(16526019)(53546011)(2906002)(478600001)(6486002)(83380400001)(8936002)(6636002)(66946007)(16576012)(110136005)(4326008)(54906003)(38100700002)(31696002)(36756003)(316002)(956004)(11606007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?5qXR0B70NkCLjXp4wFQUllj6uYs7YB8VTt5Z3YmEVjbv5Uiw9xDpXP+F?=
 =?Windows-1252?Q?XID0o89216LOjNEFZe5/sD/IHb0BlUh9ekVpn9dVle5087V0B3zPr+sY?=
 =?Windows-1252?Q?NjcNMy3hnbSxABUvsdSaPKTO9Rn0zxpVANx0OgP2wPR3apglyahOrn+p?=
 =?Windows-1252?Q?uoaiqhhM5aOJmCCR0T4TtJ8DyGnrynBEavHX7GPaYbRKvN1pJxNaULlv?=
 =?Windows-1252?Q?GtcPHOT+EuKSnH6Qx8fTohnJN4Yu+6p5HIm8IKui0Qhv3yvQHTy+T9lh?=
 =?Windows-1252?Q?q4KmfM2WteKD8Seh/J1t0B/YWdgMO5BqB0jWvv9WlJzcesJmQPkOsuhY?=
 =?Windows-1252?Q?bTGJ3oTsDIHLcSPOeXOYh/inJa3vzdDIHSfnrhhCwCjvLkNNHTnKpnym?=
 =?Windows-1252?Q?FbTPqSYwN70IeIj90+4tVN+Uy2Jon8ZGqKAe3RTOaOGISbojhvF63F2v?=
 =?Windows-1252?Q?Xbn0Fn/4PwHn6xYhoSUL4jN6KFwVncoojVoFlSZQDCcRkXsbAUafSqV9?=
 =?Windows-1252?Q?iIqs24fHgpcuJg8YMq9J/bqs8nkRAmWaMVXuQV33bptV0DvulyKLkz2r?=
 =?Windows-1252?Q?chE2z4SERvUt3ArSfxpSj7trnRlnTO1JeM23qRav8Z5ir96E899dUHGB?=
 =?Windows-1252?Q?f3VlIepa61JmmftqqtaKZbgr+6CmKFiHoPcO/O8leRY/SheHDzyBl52x?=
 =?Windows-1252?Q?wdVpGPcfYjQC7mOkDubIZ5Qd6/PXpSxRtLwAB8hmVy8FD/PJcDrHaI3+?=
 =?Windows-1252?Q?WkrWywz7RZrMN/sry/4YXEMhamz5Sl9UNhBiTEWx0smedF1xKO8xQi1u?=
 =?Windows-1252?Q?nRcIxPtcSZgrStdOyBaMVe3Wi/xmVFQTgJTX9y/PHMxXd3iNDoaw/5O8?=
 =?Windows-1252?Q?f+6ylOwVYyPXUdKSk+sqEM0eZIiZDbrEoce8DD9Mh4Y65DiD8zHzGBBY?=
 =?Windows-1252?Q?Hkb0ckesrRUKBcNgVJUpNKu1AzpmCqsxjCSWlxUVxtBVZywNGyfJaN38?=
 =?Windows-1252?Q?ae3e9kw3qV2WFr1fykLo2q38HSK38WNG7CuDQ7F8+Hu4XxXdtizGHSzf?=
 =?Windows-1252?Q?YfIEk1ICHEiO/eWldsxbKrsFabCtFWZPwoQjBYpeyImDRoS1+Rmk9bOb?=
 =?Windows-1252?Q?GBqxV663Pk8wa4poELLofKm1E7fkqoQCj3kildm+wdZT6S65unGpBAZq?=
 =?Windows-1252?Q?jlAmO9LULwHObXvKY+oUcPgh0ialx7Gj8/cF9Or1VKfCe8L2z4hIbSHR?=
 =?Windows-1252?Q?1UdohSJjsl6yCLYldzrcxiqgQCIOr2zdqzcdpO9uzcjm12EakRQrOyNg?=
 =?Windows-1252?Q?02MpmQRdON31edOLgBmNPp9Ir9IaPLw2jouEr0KZ4O2Hka3jLCkzK+yT?=
 =?Windows-1252?Q?5dtfxG+HQ1jPrZ+1ariklAcxSIH4aOrcLgtmLGGMEQXa7HClLlOpBPa7?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4937788a-5d7f-4e39-b7f8-08d90b0feba3
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB2690.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 13:08:45.9763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZOP2SHmLExxNpU2KS9P2A3iyWpTvo8PbqM62qx9iYoCx9qZAt5E0ZlYDADrnr8aGDsIQOeazHA6brDVd5SMoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB2418
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/3/23 17:04, Chao Yu wrote:
> On 2021/3/11 4:49, Jaegeuk Kim wrote:
>> On 03/10, Huang Jianan wrote:
>>> Hi Richard,
>>>
>>> On 2021/3/9 12:01, Matthew Wilcox wrote:
>>>> On Tue, Mar 09, 2021 at 10:23:35AM +0800, Weichao Guo wrote:
>>>>> Hi Richard,
>>>>>
>>>>> On 2021/3/8 19:53, Richard Palethorpe wrote:
>>>>>> Hello,
>>>>>>
>>>>>>> kern  :err   : [  187.461914] F2FS-fs (sda1): Swapfile does not 
>>>>>>> align to section
>>>>>>> commit 02eb84b96bc1b382dd138bf60724edbefe77b025
>>>>>>> Author: huangjianan@oppo.com <huangjianan@oppo.com>
>>>>>>> Date:   Mon Mar 1 12:58:44 2021 +0800
>>>>>>>        f2fs: check if swapfile is section-alligned
>>>>>>>        If the swapfile isn't created by pin and fallocate, it 
>>>>>>> can't be
>>>>>>>        guaranteed section-aligned, so it may be selected by f2fs 
>>>>>>> gc. When
>>>>>>>        gc_pin_file_threshold is reached, the address of swapfile 
>>>>>>> may change,
>>>>>>>        but won't be synchronized to swap_extent, so swap will 
>>>>>>> write to wrong
>>>>>>>        address, which will cause data corruption.
>>>>>>>        Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>>>>>>>        Signed-off-by: Guo Weichao <guoweichao@oppo.com>
>>>>>>>        Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>>>>>        Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>> The test uses fallocate to preallocate the swap file and writes 
>>>>>> zeros to
>>>>>> it. I'm not sure what pin refers to?
>>>>> 'pin' refers to pinned file feature in F2FS, the LBA(Logical Block 
>>>>> Address)
>>>>> of a file is fixed after pinned. Without this operation before 
>>>>> fallocate,
>>>>> the LBA may not align with section(F2FS GC unit), some LBA of the 
>>>>> file may
>>>>> be changed by F2FS GC in some extreme cases.
>>>>>
>>>>> For this test case, how about pin the swap file before fallocate 
>>>>> for F2FS as
>>>>> following:
>>>>>
>>>>> ioctl(fd, F2FS_IOC_SET_PIN_FILE, true);
>>>> No special ioctl should be needed.  f2fs_swap_activate() should pin 
>>>> the
>>>> file, just like it converts inline inodes and disables compression.
>>>
>>> Now f2fs_swap_activate() will pin the file. The problem is that when
>>> f2fs_swap_activate()
>>>
>>> is executed, the file has been created and may not be section-aligned.
>>>
>>> So I think it would be better to consider aligning the swapfile during
>>> f2fs_swap_activate()?
>>
>> Does it make sense to reallocate blocks like
>> in f2fs_swap_activate(),
>>     set_inode_flag(inode, FI_PIN_FILE);
>>     truncate_pagecache(inode, 0);
>>     f2fs_truncate_blocks(inode, 0, true);
>
> It will corrupt swap header info while relocating whole swapfile...
How about back up the header page, and recover it after 
expand_inode_data() ?
>
>>     expand_inode_data();
>> .
>>
