Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A1C37998B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhEJWCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:02:50 -0400
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com ([40.107.244.54]:26272
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232855AbhEJWCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:02:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBILQFj8M54M/JAVc5sxpM69iFg9ZisFQTelIqwFLYLho6Fry+zOJCb/whVgB+ozWrIBqEmkka52Yv1D8L/iy8cj7sC2L1PAx3Wk1Xi30wBQQCZiyvLfYL/GssK5IvBNnVG0gXdXEkyDXgy3SJrf3MJMHhVMLzQAjok3XiPaJoroUs6DNP0zjifNQB1F2dkJvGdzrjSpjBN6hPXhoqAZyPtXzeaINtMNhJNY4n3BDbKGKFVl/2Fe0B4vECxmsYHzZFNXBlpbXbM8D/uzMwcHPSk+ZKVQmuh7qxPtIS4rXTGmc8pcb0YwT44DcKk4QtbShUJXwO3/M1oD2K+STgPfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vltir54eBd8yiUTd6spsWFfltTceagXuOVdXl5hB1Ow=;
 b=YV/zubWH7EY7EyleLEj9OLfEiZyZPeWQddbJx6/NLG3hGJFWnSOxGmx8ravsQ7LLVafmdX89uGAUdWvG9yf89jjuoLp3Popd6PnJxOqWUIIrC/10pnYOwxYr1Wy4NJSmol7fvKHAUjaCnNE4fWafRZixtaplzYDbF74i8hnbnWaHhyyECHCs+0GYdw8Wtws+gvt7YDr3A6oTTSNdyerFBSKW+3P82VtOpsI4bXQFQXeLvwf5hUYJSwcpK2S+SycRJ3buDO0qXA90PiplzYm9hgUGlVsyITHDJLlhgd87yJpYwsBt2fE8DjXbosJBeA8ivA57xoUKtOJgE654aQ0/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vltir54eBd8yiUTd6spsWFfltTceagXuOVdXl5hB1Ow=;
 b=JJNQQ3tVSJXIJD07sE7p4oekJ/6j62FbY5c/4aKp8WoN+s5qT+oMscjhOdrdggygTB0IdAIVWqzaMzlcBou/pTy5DBll4Wus/b7NeDfc5Rp1C6TzH2aPkksR58B5KtOPMe1PldvS91gjlZjNtL0x+YvgaDA3ZwikXS5OHyEVzTk=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB2700.namprd12.prod.outlook.com (2603:10b6:5:4d::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30; Mon, 10 May 2021 22:01:39 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 22:01:39 +0000
Subject: Re: [PATCH v5 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        bsd@redhat.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
References: <20210505190923.276051-1-rsaripal@amd.com>
 <20210505190923.276051-2-rsaripal@amd.com>
 <87wnsamvaa.ffs@nanos.tec.linutronix.de>
 <d134cbb1-a8a5-161a-1927-2a04df6b4b4a@amd.com>
 <87h7jagt7g.ffs@nanos.tec.linutronix.de>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <6e3c29ee-839f-ae58-0076-e2733404c4af@amd.com>
Date:   Mon, 10 May 2021 17:01:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <87h7jagt7g.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN6PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:805:de::31) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.241] (165.204.78.25) by SN6PR05CA0018.namprd05.prod.outlook.com (2603:10b6:805:de::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.9 via Frontend Transport; Mon, 10 May 2021 22:01:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00c30976-5038-4c72-a251-08d913ff3000
X-MS-TrafficTypeDiagnostic: DM6PR12MB2700:
X-Microsoft-Antispam-PRVS: <DM6PR12MB270014E5D9F07F72254849EC9B549@DM6PR12MB2700.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjWbOvi6d1hFW/qAfp6S4+jb7M9GeQ2MUXQoDDAhybYvVurYVr7qBNVa+AIJsWcVqP2kd3aBZTHPiSqHzWFqyCLeylXQIN+8+bzoryx1IMk02qdmQNWWwepAiYmyU4h3HfZFR08OF5iS2fBjkPDxhoGL9H8XjSSRjOLLh9uu3GdSiGzNcx7Q1ifsYVsrAzdii2nc/zTwQLoQwdMy4KwbFaB/R4zjyZ0MEOFSR0baZzjRlu8RDrE3fJQFByyBPbmM0H98pK3Nfo6Dheb6iRPC0joDPcaOH3fdwGGvg7u76/OblSPBunh29CvQ3YB+8JmlT3wnPQSHZtdFgGT1ePKXhm6mGtQWR/Iyd4MOeDClfwxQvm/TiKn5aah+vcdQ7nwQPyTIlzBYyb+pA21DnGOPJJOZQexxHfPjOFG8tIW0vGuWcUCyzyQl743xV6iIzMkwwJFFobj8MRcfmSuDElwPJmvfnUmbULaGU/lVIP+0CLQmgGTwHeoE7klUBaQS7kSyDheBUnG9BCvmQe3qiIh5ikowPP+UE4V1J3gYS3YA5N1tCl59Cg0ZpYtLdCwjfMEDT/JkasihhgF6f6SxZ35kFkNKEe8qxZCf66vF3GOq7aUjsWMcScpdSyvzJy03yOWCFEpD4LgImflhsvSHtTh2xX40c4U/8ExorKbJzXi5ZCC5Kf0yejixFZ1RzaGNFOY4jlYP5lwzx90ogxrQiRDkiioCHe2jDW/7WgaItmGZpdlcySeKI5DTMwOC6qTT1Y+V33XeIlpE8aCpJ82idOTRAQ8QbmOHXH21MEcQCBDwSycjk6B4cvKLgCYHzSYAyD82
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(2616005)(53546011)(38100700002)(83380400001)(8936002)(316002)(8676002)(31696002)(6486002)(2906002)(186003)(7416002)(66946007)(26005)(66556008)(66476007)(16576012)(16526019)(4326008)(54906003)(5660300002)(478600001)(36756003)(31686004)(6916009)(966005)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VHJGS0JOTkpGd1VyYlRodWU3eTJXRVJQTVdGeEdXbXl6Rk1jUE4wZ09ESnRQ?=
 =?utf-8?B?VmdraFdzWFROQ3hCb1VwOVVEYm5PWWZNcG1ZamdaZThCcGQrSFBPV2IvUS9O?=
 =?utf-8?B?bE1rMjBTV25XY2dUcWlCbElnWWNkQnoyVHVKdDMvcHBFa1VYSWF4eFhlZ3ZG?=
 =?utf-8?B?dDcrdjhEemFtWGswQ3VNRnkwMGVxNjFPcjdnZHVPajdzSnJhV0JNeUJpT2Ro?=
 =?utf-8?B?WDA3Z3dvVXJDdEhXamR1cTl1TkcyOGxHMHVodlNqQ2VZVW5CaGxUVUNLN3ow?=
 =?utf-8?B?ZlVBMHB6S1BYaWsyWFBoL3ZsL24rTUI5V05vblcrRnVQQUNHQzk2RFNlMEpG?=
 =?utf-8?B?QzF5L3VpRFcrc1AxUEFPeEJqWWpNYTMrbVFxdmxoSmdPOWZNa2xJVjU2TTE5?=
 =?utf-8?B?bmloTEp3ZEZHNmdiTmxvMlVnYTZ5Nk9PYnhyMDB5Y0JTdUxGcTA5RDYvVHdG?=
 =?utf-8?B?R0N2UW9ib3I0YmpOZmYxdnJQN2xaR3EvNjlXWU44TVg2aXdHZWJzeW5ZNHdF?=
 =?utf-8?B?V2U4NGJ3enZRT0VhWnZndlNHd2UyTnpyZ0xMRHg0dWV2Qm4wZFpUQzdIWm1V?=
 =?utf-8?B?UXpJTit1eTUzY3VQN0pUUjhoKzBqN29zdHpFZTFLZ2ZKbHlRMVZNalc1aHFx?=
 =?utf-8?B?TmdHKzY2WHM3OXhhSjl1NzhLWFJTQkZDS0tjWXg5Rm1tVDB6TTJiUWdtQW92?=
 =?utf-8?B?WFFwd3ZDeThpWnhYMWNkUDdIRHoyVU5lREFaS3I5WXNPMllieUhrNjU1TkRD?=
 =?utf-8?B?ZHBxZmJBN3Q4TW5UVlFRZVNnaGY3K3F6MDFnUG9zMkU4QjlYRHJGNXlmanFy?=
 =?utf-8?B?N0FKb1VTUEtJK0tpcUxadjBXMXlJaTRXbU55RWdEclVrR083TGFRVytQSnlp?=
 =?utf-8?B?RWo3RGNyV1RWYTF6am9RSnFvSHNKYy9Cd3gza0RhTUhtNFA0MnhVWERtR3FF?=
 =?utf-8?B?TDBXV3VwUU9PNHI5ZVo1UWJNMWFSZWJMSzRtWFZKTFpFVEFkeW1CR1BaOE5I?=
 =?utf-8?B?ZVM1QnlEYVRPbkZZcXcrTE9IeEttQnY0Z3pydnJKTzE1cy9xK1BVN2xqWlYy?=
 =?utf-8?B?c2l6TlY0SHEzODlIQnhUSHRtYzA4eERTVDMzdnVOZUlaZXVIRmpiVXFpeER4?=
 =?utf-8?B?STNEV204ZWVjV2ljQWcxUS9LSXRpa3JCNDNwdGVFUEQ3OThaK1NrUytUVVpR?=
 =?utf-8?B?alhDQTBMRW81eTM2ais2ZklIcUxFZ3FMcFlIMzZycGJBbjZYaEJRSVBXTWlv?=
 =?utf-8?B?K2k2d1BXMFFqcFBaVG9wUk82UGZ6NDgwc2xIbGhWNWdTK25Ob29ZVTZOcXk0?=
 =?utf-8?B?cmNKd2FLWjgzRUdGOFhvY1F4cFI1WHRhYUxZMXBYaXlsak9IN3h6TmNoSlcy?=
 =?utf-8?B?VjJYc25yYS95dURiM2RrRENsQTU5TmxyRkNJNHpYcHNEcDdRVjliaW1ya0dM?=
 =?utf-8?B?MGFoZVdIY3ZhMnI1TEl5a2xHdnVKMUYzMDZ5aFBxZnBFUjdzaFpwL2hLTTEv?=
 =?utf-8?B?YkQ2aERFOVBoWWhDMmF4R3hpNXg0b2x5UDdwNEFIV0NjUHVHWVZwRjVhbU1X?=
 =?utf-8?B?eWg3bUFrYnFKaitvekpZNEF1TElCaXE3V0doOFVtRS80TDRzaGhDQWU3Sk1i?=
 =?utf-8?B?a1lrc2p6dGluS0NPT1J5dHdrT3FhZG4vdkVlMWlEaVNvQVZPb0tFVG1tTG16?=
 =?utf-8?B?MWFjc3VBczNqTmEyOTQzYVdiZWh3K1JTVGsyVDY5U1dSNnNJK3F2SU9Zc2Z6?=
 =?utf-8?Q?dvo6qqPz9gVClp39OsNPReY3oajbcy8cvopA/8V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c30976-5038-4c72-a251-08d913ff3000
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 22:01:39.4640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOECx95kAY6bnroCy5JVy+HRYVe+MxUiFZ9Zq1tznmReM6hB1phkRiQPahplH6LD0rQv+nbyANdawm/XYPO/Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2700
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2021 4:44 PM, Thomas Gleixner wrote:
> On Mon, May 10 2021 at 06:10, RK Saripalli wrote:
>> On 5/7/2021 10:13 AM, Thomas Gleixner wrote:
>>> What's wrong with just treating this in the same way in which we treat
>>> all other speculative vulnerabilities and provide a consistent picture
>>> to the user?
>>>
>>> Something like the below. You get the idea.
>>
>> Thomas, thank you very much for the comments.
>>
>> I provided the links to the original patches which treat PSF similar to other
>> speculative vulnerabilities.
>>
>> Could you review them please?. The first patch is the cover letter.
>>
>> https://lore.kernel.org/lkml/20210406155004.230790-1-rsaripal@amd.com/
>> https://lore.kernel.org/lkml/20210406155004.230790-2-rsaripal@amd.com/
>> https://lore.kernel.org/lkml/20210406155004.230790-3-rsaripal@amd.com/
>> https://lore.kernel.org/lkml/20210406155004.230790-4-rsaripal@amd.com/
>> https://lore.kernel.org/lkml/20210406155004.230790-5-rsaripal@amd.com/
>> https://lore.kernel.org/lkml/20210406155004.230790-6-rsaripal@amd.com/
> 
> They are going into the right direction, i.e. detection and reporting.
> 
> Vs. mitigation control the question is whether we need the full
> machinery of prctl/seccomp and so forth especially under the aspect that
> the SSBD mitigation already covers the PSF issue.
> 
> So for the start a simple on/off might be good enough.

Thomas, I am fine with that. To a large extent, the new set of patches do that (on and off)
but they are not in the same files as other mitigations.

If I understand you correctly, you would prefer the on/off in bugs.c so that the changes
stay with other mitigation controls.

Thanks for reviewing and I will wait for feedback from Kees.
RK

> 
> Kees, any opinions?
> 
> Thanks,
> 
>         tglx
> 
