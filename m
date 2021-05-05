Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B1737337A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 03:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhEEBOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 21:14:14 -0400
Received: from mail-dm3nam07on2071.outbound.protection.outlook.com ([40.107.95.71]:35937
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231785AbhEEBOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 21:14:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkKTPW/W/5ZVaI/MHs1xqVN0mInOQcofrygVCRNHJiw/7GCxlL6wYQ9Gc83K5+Oh7xk2pT7QeWp4x2oIYE/Vas1wsUM2mbXW2dW5cHwbrHPW0PL5fgp6hUdzbHpQ63J0NUqHHDRqvRjgOd3/CS1CJD/l/SF+UpLY0GwcaKgpxgBrPBeHp4TkDgEwrIG+ys9UaT9wHADv2udkMdFm+OV5APSrO+m5JeH0TCPgYPP60GKBVPNl9sOgYOjVz4/INebpahe+UpngYo2thy+5PHwaZ34zoaU7IyD2KvmXHzQDRsba2zvYcdDcKckSo0H/oVMTmxUPjd2Snf8xMUO8gyqd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4dBaGMlJ4mxk1via6FQgXkly/B38/SD/+ZLaw0/AGs=;
 b=ZlQOwtmGh6edrxpTgX58UK5WncuupsMXEaIRbBqBRUn6UCKfOsjPTUyWHRTxbD0kL4TxPxlnZEmq7q9WdVQb3Af9WzqlmrVNIvRV9Is/I25MkJZ1GBh0FaVdK0uI6e7wD6d6s8rFIuZWvdVDrlyvuq5G6Nt/1lDZdr+dV+Tyhz1Np1I1SqlPAvEsKYaW9TbBQuZuiRlc+wjzV0O/1unCugcUnPb6qWreaStPa6fz9FZeWHAb7uMoU8LLwcCVufHC/g+pOeBO8IYWhxFhn8sNpFZw4yIyuyZXYnOUdaoip+VPjFbV23MbdFfkhzL5LzSSfAf/2SHb/60UOC6k4wOtXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4dBaGMlJ4mxk1via6FQgXkly/B38/SD/+ZLaw0/AGs=;
 b=pirb7mo1KgDdwd7GuyK0dYWBWX/UeSM1uzBrPqg8m777oqoTMtMOPp5PkzdiATlElqbH5xfSwxqu63QDyLIeCLwOYXWwaqYBwvEag+6nryIyYn3noJecOeOb9AFGOPx5Ev7XMa8YPSIjsjYqPI7dvlVGJWo6Zw3JRazuGn1XkQM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM5PR12MB2454.namprd12.prod.outlook.com (2603:10b6:4:ba::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.38; Wed, 5 May 2021 01:13:15 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 01:13:15 +0000
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     Reiji Watanabe <reijiw@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, Borislav Petkov <bp@alien8.de>, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
References: <20210430131733.192414-1-rsaripal@amd.com>
 <20210430131733.192414-2-rsaripal@amd.com>
 <CAAeT=Fw-nt5h3DhRCQr8Ma71NiP7dHB+WD2hie_55SpCHR=mDQ@mail.gmail.com>
 <e53887f8-c09d-28db-5041-bf8822370c46@amd.com>
 <CAAeT=FyAmSxKy5cpGLBH_kqDohXeQOdi4r02KjQO_vycq=4y=Q@mail.gmail.com>
 <d64b9e19-7124-640f-0ca1-7abc7816d642@amd.com>
 <CAAeT=FwYNJfHUzQjSpJD8oexNfR9CLa2oPx4Umh6=97xpkA7fA@mail.gmail.com>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <3f389ebe-ae98-5bce-8708-27e07898e286@amd.com>
Date:   Tue, 4 May 2021 20:13:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <CAAeT=FwYNJfHUzQjSpJD8oexNfR9CLa2oPx4Umh6=97xpkA7fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [69.215.231.172]
X-ClientProxiedBy: SN7PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:806:120::9) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.13] (69.215.231.172) by SN7PR04CA0034.namprd04.prod.outlook.com (2603:10b6:806:120::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 01:13:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4d62aaa-858c-42d8-d558-08d90f62f588
X-MS-TrafficTypeDiagnostic: DM5PR12MB2454:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24540DD332E4FDA3FB74C1839B599@DM5PR12MB2454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQ108O0aEcouUOVHZQIGbqZVjt4x6Rzs1NC8qNC1mVBNGOebgpKNNSHwbGq2s1Er/CfX5nrO9NtK2gYdTfiq4JqPtfzfrcCp0EXPJq73vOIh65js+ciFTas7s4yrDTP8WUopndXi4aetEWSTWbm3aQxlbWoQku5ZdRDmptRJcpStAd2d/35k+CjXeILeG01vx//Bp3ztKGBo/P3R6ZZcQCBw0h0p+YuihWSs/sBZHcicYFYYogvWhfhBpUa0Rxle7mOq+U6x4ZiG+GjOU0dCB3D7wVUOXZ7juEqosSL1hfwKpkjzTvKrUyOTLEZG82sMUxREYZngDiw2/qWfI3D4ZVA4XCCBLn1dRjkisXOXXrBk2Bc/ZAZ2V8S8zPg+2LVPCiVm0U+7S4KfP3JqrW9yP7lZuj2rYZvQCqBQP6x2enzTR25SDd8Y69gjXe64JjtuDVQh2dC/Z7EaHH6kPEsRfNKRKkM+yNLyNuSxeDAnTtB+lcBLFAj5xU+QZn7Hi66mGpmUshf9n8cj2NpEu4c0LIgxF80TIj2oazXe8ucSTO1jsCsml4+rQX1kTkFl4hjwWUSr/+/SSL6F8Q2yV0+ChxXcnZ/eQ27uOJk3YB2R6rSA+LuHOTQHlbuQsVdX0OqU1AILr5SDHOytcpZJ0/ZvzAvAcFyKQpSepv0CK7LdAMr4uxM0dSVEPnPGYpPUs4i/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(316002)(8676002)(2906002)(54906003)(66476007)(66946007)(186003)(26005)(16576012)(16526019)(83380400001)(36756003)(66556008)(31686004)(478600001)(31696002)(38100700002)(4744005)(8936002)(4326008)(53546011)(2616005)(956004)(6486002)(6916009)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bEpMRE4vQjRoYWlBbllLdGt6eXVNNlJNRlo3dVhEc2c2RzZLdE1qRGtkR1Qv?=
 =?utf-8?B?c1JVT29xSzhNcElsa0huaUJHdXhYdHZ2OHJZUExlUkNEczA0N3VkSEtaVklv?=
 =?utf-8?B?VVd4cFZEakNHOWJPM2FNTUZweDhqVWFhU21FMmhlbE54VmJ2M01LbEVGeEhP?=
 =?utf-8?B?a3l6K2ozS1RqUzIyMjN2MmxYNlNkb3o1cC9tbVVCcVk0c0R5WlVUNzRCR0Zp?=
 =?utf-8?B?dW1ZbEZPV0hDU0VDRkRzVDEyWFluT1RqSkE4YldCc0VTSk90bEV3VnJQdVRr?=
 =?utf-8?B?N01GYVdxT2lwVkd1c3pvdHhPaHBLbktVTHZPOXpMN0xLQTBNcG1TbVJHcEtX?=
 =?utf-8?B?clpCTVg0UURLemdBempUWjBOSHhlVG1QQldGd3lRSUQ2VVo0b1oxYlJ1aDB4?=
 =?utf-8?B?Wm9pc2IxYisrMUlMTG4vM0R6b0dwcHRVOUJTdmNva3BIYWhndDRJdndYR1VV?=
 =?utf-8?B?WjQ5WGh2azRadDZLZ2llYm5ZdUMxSHZSR2dMdlFILy9OK3lUR3RMdnFWM1Y0?=
 =?utf-8?B?UURMbFh1NEt1anpmKzJmRjlxR0VWcXA1STdTWXJnV2tmdmc4dTlpZWNRVlRx?=
 =?utf-8?B?cVZsNGtVei9oeCtyWndVMGlBbHhhMHNVcFo3ejRSSVZocDJVVktrbDFrRWxO?=
 =?utf-8?B?akJkeTZldjZwWll6d0RyREdFZzVDU2FTNlRWQXQ0NnZSU3RjVWJrSGw0N2tF?=
 =?utf-8?B?a0pZTFNVNWdYbDZWWXJwS1BDaWcyOVVKM09UQklYV2krd3FVZEdNRTRNU0VI?=
 =?utf-8?B?SmRha2N3bDBrd0hRaEcrVTVIV0VpaDBoa1JhSDRUS2FNK2ZUVmxPZ1IzYkZl?=
 =?utf-8?B?cHU2UFBMU3B2ZlVsMXdEYzVZQlBhWGRXbk9LSWc1RE9IUUczWkQyZEpEZVdU?=
 =?utf-8?B?QWRnODdVc09JM3NwVjVJQ0hWS2o0Q05oZzRPWVJoZXNFeVpSWWd2SXpMRlM2?=
 =?utf-8?B?KzdwellkQTNMbzRLTkpsOWdzaUtFdUg4WVZ1STZKYlF6Y1JDMWtHNWpLZ0hO?=
 =?utf-8?B?TEhQK2NhanlBZlkwNFpDVWw0WUNDckdUNDc3ZS8ybkRkb1BySmFMVGRkWTc1?=
 =?utf-8?B?Rnh3RmVHdm8vNXdFbXJOVkNqd0ZJQ1ZzeW54UTk2KzZQc29zanZtdE5oTjQ2?=
 =?utf-8?B?WmR0WmNsMDlvWXpHTkJTVmpqTllNakk4Qk42bmtZTlpnclVsVTlyUDVLT3Rz?=
 =?utf-8?B?U2FyK3R5YSt5bWpMeVBOZXozcnBpbDdJZFJEZG5RdEFoM1RSQ21BbkJjSVly?=
 =?utf-8?B?SWQ3UExKNTZYdFBIbndsYlZ6a2E0WVd2SFFzMStnTk5Yd0NqYmF1WEpvQjRu?=
 =?utf-8?B?c0pFT0hUTjFOdFZNbGpLRG13cHdVditBMkRabFEwNm5DakdqU3RlSi8zRlcw?=
 =?utf-8?B?QWlPOVRDRlBuY2F2VWpiUXk4RDNZaTNSdlh6Z3hmZkc4aGZNVDRXZFVzTGla?=
 =?utf-8?B?bEFLbndzNDNNby8vVCtLZnllUjRDWU1pcUNIVzVjanZwNnVOdXNwOFY1b0dM?=
 =?utf-8?B?alcvWjcyM25yOEFBNDhudEhlNDFHZ2JHczRWKzAwYkFMMHRyZEE1TlNCd1d3?=
 =?utf-8?B?bjdvZVV1NjQ2NmovQkpaOU8zb0pxODVRSXY0ZlRFVVhHc2t4cVhnOHBIOVV6?=
 =?utf-8?B?VUYxYUhhVFdsZTFsYURZaFFmaUJLNCt3ZmpncDlCSW15ZmxqVERXUWo3NE9y?=
 =?utf-8?B?NmZ2ZHBxZE5VUDBHVkJ3L3lqWDhET2JWdFRnd2RucXpuaWQzOUhpUXhlOHRF?=
 =?utf-8?Q?Gk3NvCSSOsB1V+Y/9Qtv+J3W0X3+uhd7Gp/6a89?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d62aaa-858c-42d8-d558-08d90f62f588
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 01:13:15.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yMRzuyz7cDJE5DwJeCmqsSeAMn/8+7LP/La9FOiTsotbi/dRBGKRLnGhm6Le64qCZ+/lLpNs2r2F9N2WN2kew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2454
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2021 5:11 PM, Reiji Watanabe wrote:
>> Boris / Reiji, I am wondering if I have answered all the questions on these latest patches.
>> Just checking to see if there are any more changes needed.
> 
> All the questions from me were answered and I don't have any
> other comment/question for the latest patch (assuming that
> the patch will be updated based on the comment from Tom).

Yes, I have a new patch that takes into account Tom's suggestion. It is a minor change.
I was holding off to incorporate feedback from others (Pawan).
I will send the new patch with Tom's suggestions incorporated.

> 
> FYI.
> I was going to ask you a question about x86_spec_ctrl_mask.
> But, since it is used only for KVM (although x86_spec_ctrl_mask
> is defined/used only in arch/x86/kernel/cpu/bugs.c),
> I plan to ask you about it once your KVM patch gets updated
> rather than this patch.
> 
> Thanks,
> Reiji
> 

