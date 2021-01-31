Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354AA309C36
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 14:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhAaM6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 07:58:10 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:24726 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhAaMMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 07:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1612095129;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/FN0KA57n2CA+Rx69OyfUEzAakkPtFW6zY7bw0yM+bA=;
  b=EEVVMbmB4nWpwsPhE5RI9D8SMmZiiJ0aud0lL7RxHfqS3QV5LzQpEnNt
   Tn311q2xrm+quX6nT/Kzr+Fz/tFwxYZ2gLyNSvJGQzekCFf/Op4x8OncP
   yZB48XP9AwnDIre5Q5BF7pezwBDAsDcyDfVNB5zmw/+/moAvMh4DFVTEl
   g=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: jCkZB5LUcyIRoxh+1dEXsdNZ1T8wCEd9xuLMpHFDiHeSHyS3ZyjGjGKq6wkjYcJUvn5E5r1Jbr
 pSRmoajKEyAKSHIlTry86egHhVltGf5XJdaFShNC87/BtvGgwJicNzmHPR1Y4FhOB5MKSllO0u
 5ofbgqdZXiQ7+0o6GrWU1CVoRko99DIARxR6Yg/yRwZVzgWb3FNCBleSIg9WRzbjJ9v2Tb/B08
 KsJoelf05TwSQW44TqsgYTtqAIMhW91pte5i1zW7N+1aT+mAPGbdycSUM6ujeZTFssOStTgI1J
 +bU=
X-SBRS: 5.2
X-MesageID: 36428903
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.79,390,1602561600"; 
   d="scan'208";a="36428903"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnsH2D67Q2kwYvgszMDz9dPldC392a8HLk469juZtlBbyA33+GiqmVWw9iKh/7OzmGpjdszWavWPivMB21YTxYgfPfFQ2xgOQkFaxuWlhwslkD24WvT1HSaU3J59unvQLPL3CLkzctSqBNglggIdjllV8gawmsEjTBiz49pEAmppLfHsN6C4wPZZD3V8buZoYIWBRFrKeQhZgLR2Xl5xkkTA8pUVDIah7aTGhKXE34XE4bE6Qp47OZH2MbSE6eH9Cty2w+h3Z9XrBeR1Ks+kR2YuzYwCKjdPcZQt5FdpRqnUFFSfw0Jc8WvW9DG9TCiv+52ep2Q1Zh9iJoGAYg+BMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0tvu6aX4dCKEk6QqDhvBJoQrV0FUVeDJsdBw/3PAkw=;
 b=f2BdjxslA5sFtANdzCxZT32PD9LxYPPjQucRharSuBjhmI5ID9ANFWM9YJjJ6r71z5iVnZSSVAyKukwKIDfk5Bg5VVdroz7QTHaNRnvWt9iMJwv/xD3mqpSiz16trzq92wsM21CwQH5C4jN418Gjipjgu4MPNl/ov3dXPJrcIslcCKhw+R+b6hXr3iGPl+ezC4nlaF0aW88gkoTvXkXp5R+ULisXsPicXm2MJWG68EXlpA1rzUjwtjMDSwqLX7pWKhvqEetnf4YA/gKW7185hI89ZShf6YDIQChTjHJggqxiQ33bOPGzZizfFwso5LyHQNWX5avxjftIQ3mq3L6Vfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0tvu6aX4dCKEk6QqDhvBJoQrV0FUVeDJsdBw/3PAkw=;
 b=Duu3vFgEKyECECRcBm6c2kmB+qydmQHr0e1fSobqlv6K00kSckRBspz6qhnw6qVb/0RLwULx24kOqTbAtu8qEkj/RH6GsmXnimK+1jaKMSRsBfVBk24lQ5md8mHwrqV5dQuRmAwc59013SamOti0xw4yqok4I8KwBa2+tmXRjkg=
Subject: Re: [RFC 03/20] mm/mprotect: do not flush on permission promotion
To:     Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>
CC:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-4-namit@vmware.com>
 <CALCETrWxyMsD5zEoaFS-aVfkV=QiVWa7pCU_JE3AYDEEU8Hqvg@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <7a6de15a-a570-31f2-14d6-a8010296e694@citrix.com>
Date:   Sun, 31 Jan 2021 12:10:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <CALCETrWxyMsD5zEoaFS-aVfkV=QiVWa7pCU_JE3AYDEEU8Hqvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: LO2P265CA0340.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::16) To BYAPR03MB4728.namprd03.prod.outlook.com
 (2603:10b6:a03:13a::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf1d6a3f-59c5-4d87-0490-08d8c5e1438f
X-MS-TrafficTypeDiagnostic: BYAPR03MB3607:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3607C632C0472A40E41CA48FBAB79@BYAPR03MB3607.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+oYuP2vjxutM3q0skxbUXRSK9L9A8xNESch9+JbVhYEs9fXnvRPPQaVU3LEOeEpZGJlil+SUItQ3kAtECpLegTupuwVj8c9gkXJ7iPJOH+Phy0+R6afZIqnXOU4zKDkdvXHyqPFLJfIZgVaCMSNN9voshhoO/KcDAiQDDZY8nf2ibUhlbtxTKlS6uiB4NBW/91hSEdK0rpSSOS1P8NSRIuVhwojNqi5mw6/WixBXyRN0S426YFcARYkcbFOCCkni6aDC81nvbIYoQ2MCgZMbsbpf1DoHVVTgXSb27OTMxPhameTXxnfkjoTlhLQrrBiV/joNiKbDBQzw/5H8Pom7n+VwBao3lItVFctf1N/+MnFA5MFpUkc2HriPoHMxBlCkFHhvUmF8os7h5PeEyItgXcu2o7pmDeLp+giWIhB3tMhnT39Xy3JP1WstznHdcn0KnQ8d3jZ3bU9f2DJ2L6ZhN1iaqSwa1ZbvEPxfCaBLgqgy2QSzeSRljQrcZ3IQySde2aQ4ArWdrhNhoUO3JaqdXmQ3ugI3ybMF2gnP5IED9atsr2duh2Zw9gxfADIUqbkSJ/FmwFaN2FMgF/fjK+7xXNwIUuQy+zM/fDj/a+SnA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4728.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39840400004)(31696002)(478600001)(186003)(53546011)(86362001)(2906002)(4326008)(16526019)(26005)(2616005)(8676002)(66556008)(66946007)(5660300002)(6666004)(956004)(36756003)(316002)(7416002)(54906003)(110136005)(16576012)(6486002)(83380400001)(66476007)(31686004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cTZvVXdkU21kV2h0NERVMEZ6VWJOL0RrdUV4bkdvYkxnVUxMaGk5ZVFoK2kx?=
 =?utf-8?B?cThkamdHUVd1SHZoMXliMUhyUnhEeWFxWE1HdXpSdmM5VHNudG1wajVmcjZM?=
 =?utf-8?B?V2MzV2c1dXNGenhGS29oZkxXYmdTRjR3Wko0YklNREVJRXVHd2JQeklnaTA2?=
 =?utf-8?B?NzNCL0M4ZGFNNU5oUzcxYnhLUWdxTnB6UW1RbnZTcFR4eUlwOHBPV0NEV3pl?=
 =?utf-8?B?cmYzWnliZzRrSUI3N3k3U2dqVlp2SmI1VkQ2TmhUamNnZkxIZzB5NnlJVEZD?=
 =?utf-8?B?blZUbTVod3dybUdHZDhlSUxycTlNSzEwOExxQjFaMlRIZEpIenZ6ZTRHK3lS?=
 =?utf-8?B?cmdTanR3MFppNll3NTY0eldXNWUvK3poYnF3V3M5ZmFQZm5salF4clBtOFMw?=
 =?utf-8?B?U2N3RW5rdlMwa1hUOGl6VUlicGI1UVMwSGd1QTk4ckg5aHU4ckU0N0F4T0Ny?=
 =?utf-8?B?MTJZYyttamU1aWdyM2xoVEVoVmdBK1pERzJIeHlsUVdxdFlUV2hLQ25XbVRF?=
 =?utf-8?B?NEFBOFA0SDdLYjVvbUxLRjkzT0grMkRsa1MzZGlGMVMvRDkyRDBpb2JSdWVC?=
 =?utf-8?B?bnliS2UyaEp2M2ZGRk1HZW1TRkFqVVhtY3I3ZWtOT1hubW9FTklib2s2VGNU?=
 =?utf-8?B?ZnJQRENLMjdGVzJyTWNNNjBIdXl5T3BkckVGRWZ1dmEyRHpKUnpCTFFNSHFw?=
 =?utf-8?B?YVJ0UWFWWFFVdjMwNTYvTUx1WFkyUXlqRW1sd1U5eTIwNUtQVTU0QnByVmFm?=
 =?utf-8?B?ZlZlYUl4NXgyYkJhTlRxa2xyVFAzN1hhM1p1S1FSS0dDUGRwdTZTK29pTEhK?=
 =?utf-8?B?KzZuK3k1MkRlQ202NjZWQVNCUDBSOE85NGhvcE9WVFJ6R3hQYU1ZSHhacFFS?=
 =?utf-8?B?bENtaXYxTVR6UEpxRnlNeUhQS2hhN201SDc1b0pWOU9Sazk5ZHgzNFo5NHhy?=
 =?utf-8?B?RTNtc1VBT3REOFNCRnBwTUsxQTNSM0VuZUQyNk5vMDhJS1UrRGphZGNkZ3FY?=
 =?utf-8?B?SElhY1ZmOGVxS3dIT1l3SkpnUGlhRzVyUVpnaGlBWjI4Y2FMcm9ibGlFS2wv?=
 =?utf-8?B?c3hNdk9sQ0YzZEY0V1lnMVpPZWJVanI0R0x5L3JxUC9tUlZBb3ZCT1RGdjdZ?=
 =?utf-8?B?TGdkYTg3eFhQUW9RWUdYOXhCRUJPZHJ4VDFpU09LUGk5dHFxeWhER29UWWQ5?=
 =?utf-8?B?TjY0ZWhtV1Y1d1ZLNXZQa1RUM1pvUWFUd0NBVnpxd1VsanJFSU1FTGVHSkV4?=
 =?utf-8?B?U1FrWUVBeHdSbk5xempsdWxxWFFuN01KOGdCUnNLdUlRTFBhTHdqRC9pZmYz?=
 =?utf-8?B?USswSFhhNzJIQVYrK0lvQmFCRHdiOEMrZTh5dUZUZm1INlRVMzM4N2N6SzVQ?=
 =?utf-8?B?cW5zUFVKdGhTenlaSXc5R0xMYTlUcGtRVUNlZDJkOWtpVGxqRVhwYitRVm10?=
 =?utf-8?Q?ra1WkPb4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1d6a3f-59c5-4d87-0490-08d8c5e1438f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4728.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2021 12:10:56.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZND4u43yC/4Qgy7a3lj4KXAFJGO5A94NTkG+eugwBAgtVt1xxDCAjsiq0CunOWzvmeD70RHo6Maav2QJcXpry6ayY3YO4IMrHBxQH3NcTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3607
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2021 01:07, Andy Lutomirski wrote:
> Adding Andrew Cooper, who has a distressingly extensive understanding
> of the x86 PTE magic.

Pretty sure it is all learning things the hard way...

> On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index 632d5a677d3f..b7473d2c9a1f 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -139,7 +139,8 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>>                                 ptent = pte_mkwrite(ptent);
>>                         }
>>                         ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
>> -                       tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
>> +                       if (pte_may_need_flush(oldpte, ptent))
>> +                               tlb_flush_pte_range(tlb, addr, PAGE_SIZE);

You're choosing to avoid the flush, based on A/D bits read ahead of the
actual modification of the PTE.

In this example, another thread can write into the range (sets A and D),
and get a suitable TLB entry which goes unflushed while the rest of the
kernel thinks the memory is write-protected and clean.

The only safe way to do this is to use XCHG/etc to modify the PTE, and
base flush calculations on the results.  Atomic operations are ordered
with A/D updates from pagewalks on other CPUs, even on AMD where A
updates are explicitly not ordered with regular memory reads, for
performance reasons.

~Andrew
