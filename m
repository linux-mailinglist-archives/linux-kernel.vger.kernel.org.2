Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96270406F25
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhIJQLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:11:38 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:4960
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233438AbhIJQJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:09:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVqBC05ElEdojTbySxKo3nuQ70bHzxPHGHT+ZPlsf2KY5pLucTx/WkkdsyodCtf1qH7Pvr2KRDbJfpL0QBVfFFqaOvRKsaYl4w1SYFw5p9+NLy74NPqpESi0A7P+mVdjQij3zpG2/rRodk/1VMZxWFdzgkATt6NqROp4ZdT02TuCs5FV2cryiBo2/542RfSS167Wis11JydfZQ4NYw8+DsXUgJeTy8LkjC1UaZJl3WJPGoptHo1FJRjn/dEpYmB6dQdC6N5XofJjYg2pKAZGoh5u385A0sz222rfvnWbFPddoDNEyraQjfN/R0Dk0vnVGZDObA2uUWXL5FPdrhFUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hPT1SSL5X5RS5D55OFCqOuD2wcxJK9TxsIQzZDl+XLI=;
 b=jKWZRj7+vEA+2qgs1gbg4YQTKghWid3kwyCJvCEQ+KXzFzBFjC9VBkhLKRIcMn5j8y5JYvDSJ2qt8q6l/tpQZAoAkplw0AaUZviJ94CeqTrJFRxJgDfwKajzqRKaFnLB2VngNthkLNeTYGC5KtqvZRVyGG0lIHVz54vSBPrm5ZZypXX2Ges1b+9X5W/7BbAQCfG7JjMzStsikJBqTc96FCN1GBPfUHr/lFytjODmgeAspxT3a5d6AxRGlpErNXkN6p8OyUDycsQQ3epkAReK+DnslzGgygWx04StsvsrHxoMeHxGvKub0HWGFR5vcS8+8EXxOfHEVcFsn7YhzGOadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPT1SSL5X5RS5D55OFCqOuD2wcxJK9TxsIQzZDl+XLI=;
 b=KCsKe2jZ7Cmo7JDHbMEM2uGVNIBAF8NUK46is58HTfDmq+Let6C6aEOV+gjZ6+dHkvAt4X+Mlfabbx4u3+JvAZE0oImYRqDecBZ2KmvpUEJvl1adADnF07phuR8OOVdMz8qeLlX9oOm9E1uH4lbruuBw6ebRlLno/VWOVxneO84=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR1201MB2524.namprd12.prod.outlook.com (2603:10b6:300:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Fri, 10 Sep
 2021 16:08:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 16:08:04 +0000
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "Moger, Babu" <bmoger@amd.com>, bp@alien8.de, bsd@redhat.com,
        corbet@lwn.net, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
References: <20210812234440.tcssf2iqs435bgdo@treble>
 <20210902181637.244879-1-babu.moger@amd.com>
 <20210903000706.fb43tzhjanyg64cx@treble>
 <dca004cf-bacc-1a1f-56d6-c06e8bec167a@amd.com>
 <20210904172334.lfjyqi4qfzvbxef7@treble>
 <35a32225-25d3-88eb-f427-14c93c38c97b@amd.com>
 <20210908182047.lcor52bjzrt35gsq@treble>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <10336b28-3347-e988-23d9-f4d51d38e68d@amd.com>
Date:   Fri, 10 Sep 2021 11:08:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210908182047.lcor52bjzrt35gsq@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:806:6f::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from [10.236.31.0] (165.204.77.1) by SA0PR12CA0019.namprd12.prod.outlook.com (2603:10b6:806:6f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 16:08:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c9d9f9-8758-47eb-82d3-08d974752bc5
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25249EDD326D3E24A4130D3B95D69@MWHPR1201MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmfFd1IpgSBxfP55aMRu82DdgOv6XMMRIqvn7bADyItxNre1TmGx8HafQ+R2TiJJUBeGAtP2d6kYJnZBcgFAwKj2uOPWDpZCCxyZAEfaEl3XkwRPBk/IBHkKzW6po1Yb156xDyZYhHlX3oBd0b9PIP1mSUURpJn1qM3O92hnAMQ3C4QIds5d9vjr6+arpK9Gm4gu35My2MBtecExZ6ZdCBynY6lSKgnPAshZXiNP4wb1P//BxSm1+qdu4HBdQt0dut0XMuITWmIx12YGPcx+TYr7/gU8iV9KBN4t4VicJ5e8kBXoYH50XlDMpuRI+e44v0wFWos2xD5VJhaiaYlxWSXCV96ihZ6lIQO+sJZbExsNI+5FTkflRPPKtDA4IeFat6LAwirZ77tqETR19l++Smu0Ht40ZQ1DoAUssQbynyrKcIJi0Bfhemmrtm6YEeJ4YPA45G6/LYK6+HdBJimmRPWg34zuC2+ZS4jzfN0UcV4azp82ClgFSw8XcCXXPt5Pa5nRblS4Z4Ju8zxhowSmEQq8n3tsgddXkXjk1tsSRYbaFuDUEpRDmYTDODLBEtH12Fn0fMnXEDIRset/kYDOb/KTRtYkWbEzRS1Um92w19l4cB8ONV0HbBvpfgLgX0HlBdnA8UPfc7KSSSwdSzkj1T90RvYHrmxtGMud9BiGPTMovTbqerrIxq1bD92Nd5ISrlq33nHJz5kNVJk0ajfcDh876wG/a2f8GWPvkzqPWgeAcQiHxsojvlUeiH0VpEnUVFiyLo5AKe2rXr/3FaG0JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(66476007)(478600001)(36756003)(83380400001)(31696002)(26005)(8936002)(4326008)(8676002)(66556008)(2906002)(956004)(2616005)(38350700002)(31686004)(66946007)(44832011)(52116002)(53546011)(6916009)(38100700002)(86362001)(5660300002)(316002)(16576012)(186003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFY5bTNsclFvVVFJd2p6cDluampMZytkNHV5dDdQZTQ5VitpLzh4QXh6cUho?=
 =?utf-8?B?VnJpdjFMYllwLzlGRTlEZGxhcFVFNWQzeTZuRnQ4eGRoNmFsMnhzRjA0b2pR?=
 =?utf-8?B?dHZNRGJ5cmV3YkxVd3BQUEJ1QWdHdFFEYTJ5L1pSTFU3WWpRaVMxN3Y1amVm?=
 =?utf-8?B?RGhCMC9EZVJzSXVjRnFrWXlibFpUbTUvdVQ0WXBzcXdsYnlFR2lpaXVHVUNr?=
 =?utf-8?B?Ykp2TzBPVEI5R2k0NDlaUDFnRnUwdmZ2MWpoOTkxSU00YStCWkx3elkzT3E0?=
 =?utf-8?B?R3lvVzhaRWpSSXhjdWRVakpoZ3gxamNUWmY2bVNhaTBFTUxPK0NsSExueVdx?=
 =?utf-8?B?eTdzVTRsWTFkVTBjYnB0c1ZlNVZKMDVyZ1dpaWxwWGovWUVONTN6bG5BSy9x?=
 =?utf-8?B?SS9Qc2VGYWU2OVZDa2g5eU9KOXBCVWx6MGdEeXk3R0VFcWU2YVVtcGxDQXpC?=
 =?utf-8?B?SGFRdW1XRW9ucE9oWGRKNHowaTg4cDBJTmc1NTQrTys0eU1PY29Dby9lbXpy?=
 =?utf-8?B?Z010ekZHT0IxeXI0c2RNcFhZR1ZVYStUVjk2MDR3MFpGNTYvcWpQaVZ1bWN5?=
 =?utf-8?B?aWo3OEhMUDY0UXVCWHBZSng1Q2JJcTNwYnJTSGhVelE1UUpKTEJzam5POHRu?=
 =?utf-8?B?aGpMTk9jYytGYmQrblMwMkU3OTZCWGZ0dGpWQ1prVmMwMi9od1BrUGY2aEp0?=
 =?utf-8?B?Q2tRVFQ5d1NXQzNJaDd6NjB2Wk5FNlZKbnZUdUUzelZ2S3hLajk5Vk5LaUYz?=
 =?utf-8?B?RENVVkx1R1Z6anVhZGZ4cFYzR2dTWEZKNmE1T1RYK0wyYi96VGtvUWJ3VHlx?=
 =?utf-8?B?ejRDckI1OTZ2SWFvTEVBU01STkZKWXA4Tlo5QUVnbWt3OXE3dDZWTWdhRnVu?=
 =?utf-8?B?dTFOaWtQaFFRRzFkOEd5VTNWTWgwUndUZUp4ekhtMnJJM3JSa29OMlpQeGdO?=
 =?utf-8?B?Z1NuSURvVE1sem9PTW5ZYUovdkd0Vnk2K2FxeE5GQU5FNDEvOVpCVEVYRGxH?=
 =?utf-8?B?SkUxd1RROVlKcUNwdTdJT0d5UXFXaVhQN2tzTktoT05EdFQrczIxdnNTWGVW?=
 =?utf-8?B?WTBrUDNBQ3JwOFJ2YkNSZFpCUHdaZXBBYkdDb0xuWWd0VE1TZjc2dUdKZDVE?=
 =?utf-8?B?bXR3U2pOQWZ3WCtRZWF2blRneDNtYW4ySTg1UjhKZUVLcEpwNGVURzR2L1VJ?=
 =?utf-8?B?YVFBZjdsOXZMRVBNa1d0bUdQWUFxRmpKU0JwbUI0by9hdUYyb1UwbUhqSjh3?=
 =?utf-8?B?UWhjSFVPTi85RkIxeFRjYzFuM3pCNzJ2a0Z1Z0hBV2dHNFRvbmU2ZHc5SG9G?=
 =?utf-8?B?WTM3ZmxTOHVpUno1QTU0alhCeEs5dHBiRXdCNmJJbWFmbFY3cUhySFZMN0dv?=
 =?utf-8?B?dm9ZN2JUaXFsdVBiMWZNc29sUVlXMStuZ29yaEdlY3RqbHh5MW41Y0lSMkhN?=
 =?utf-8?B?Q3pxem95Y3lsclU3aEZER3FPYzRzOFpmWXZVdlZtMFZrMnR6NjliUVlXVGFU?=
 =?utf-8?B?b3kycTkvQ0I4UUF5a25pR2VLTUVHYk9Va01QVTFxbXdZTUUwY1E5TlVDUWNP?=
 =?utf-8?B?NVNveEsxdFIrY2V4VDRnalY2L3lObWRFZDN5Y1QwTnlCYXFpN0ZXbWNjT1lz?=
 =?utf-8?B?Z2krYW90YmE4QlVrVDRlQUFzaUZobjI3K0xlNEh3bm11MThWaTVSNjhMTUp3?=
 =?utf-8?B?a0lVb2txRVJKS0JBa1NFY0xCdkEyVG56N1Z0WEh5aXdkUHZPekdpajUrcDFV?=
 =?utf-8?Q?qIgfcINKIFR3KIhHMW9UrxHuCeOZiuN/e5RxTcT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c9d9f9-8758-47eb-82d3-08d974752bc5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 16:08:04.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhcph4LEzupqKN6APg9/KgGwCD5MZ0YO6zP7ZnnpoFBvHxnoX5Xa5wKicxuPQESg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2524
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/21 1:20 PM, Josh Poimboeuf wrote:
> On Tue, Sep 07, 2021 at 06:15:53PM -0500, Babu Moger wrote:
>>>>> Because trying to give them separate interfaces, when PSF disable is
>>>>> intertwined with SSB disable in hardware, is awkward and confusing.  And
>>>>> the idea of adding another double-negative interface (disable=off!),
>>>>> just because a vulnerability is considered to be a CPU "feature", isn't
>>>>> very appetizing.
>>>>>
>>>>> So instead of adding a new double-negative interface, which only *half*
>>>>> works due to the ssb_disable dependency, and which is guaranteed to
>>>>> further confuse users, and which not even be used in the real world
>>>>> except possibly by confused users...
>>>>>
>>>>> I'm wondering if we can just start out with the simplest possible
>>>>> approach: don't change any code and instead just document the fact that
>>>>> "spec_store_bypass_disable=" also affects PSF.
>>>>>
>>>>> Then, later on, if a real-world need is demonstrated, actual code could
>>>>> be added to support disabling PSF independently (but of course it would
>>>>> never be fully independent since PSF disable is forced by SSB disable).
>>>>
>>>> Do you mean for now keep only 'on' and  'auto' and remove "off"?
>>>
>>> No, since PSF can already be mitigated with SSBD today, I'm suggesting
>>> that all code be removed from the patch and instead just update the
>>> documentation.
>>>
>>
>> Hmm Interesting..
>> Just updating the documentation and without giving interface to enable or
>> disable will not be a much of a value add.
> 
> It's also not a value add to create controls and added complexity for a
> feature which nobody needs.  There's no harm in starting out with the
> simplest possible solution, which is no code at all.
> 
> Code can always be added later if really needed...
> 
Alright. Lets revisit this later when it seems reasonable to add this in
the kernel.

For now, I will focus on exposing this feature in KVM where guests can
make use of it. It appears straight forward. Will send those patches soon.
thanks
Babu
