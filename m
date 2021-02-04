Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0FE3100D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 00:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhBDXkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 18:40:17 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:56742 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBDXiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1612481896;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wNNon/Iuek8LldMjCwjZTDBjXdub2Lk95eW3SUufzC0=;
  b=BiaIA6by2tBLW9eBwswLUAhP1Yv/9n96LHeK/LcKkjlaxsIpBFz0TPAy
   4mjsinWEEbMQ8diYiJE2vNDek+P94Ub4fUKOxrELN8Qmx2RI67wGFdM1i
   sWBmrexfyMJedHsYUxCakmiJFmOadsl1i7xvuEIMJe9Qmp91tRuYv4vub
   8=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: hQ4+SyOt8TZSUt+xKyRv/tI1Z6qB8+2lct/2FAH5EYYWFO6gzZzBDCZloF91/8QXlu5I/fjjsz
 CSUn5/8hH1jFTVEO3ySvVG1Ld0SI9zehPvxSTQ3mgwClZeTLAzZLOZMVk8wspa/+ZtEaFsWXR+
 KF/jRxZHU85xG7pChRI5ZopzAwKcI/8MzAIihZtGP5OTeuFcBDnHt8j+aHYROd65mYrvCQo92w
 4vsTx2qJnSL1Jm1sMkwi59KShT4GEJXf94EP+8fW14gt4vHZ2mY746YcuHblZU6bB8Jge7EAmE
 Ack=
X-SBRS: 5.2
X-MesageID: 36601602
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.81,153,1610427600"; 
   d="scan'208";a="36601602"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFELKPpQjyMImU3IC+xmOjYTpT6oXVrJTdLu5qaQbZ2odIdsuq6rKbbshxcWsQMbMjikgi1wLU9BtaUrpdi95+RuhHcNE/5sWCsAk42O/U0y9/U7AvSzwCoqMGRm/l//hIOY4SkpnPIu+FNmCDuf59A2eMijXTNlfDjtouBj2MGPXVTjQ8w009rrkgAL5cZaicxMNc4iyJQqyMNofZquMkxthhNTlY/SvOEHqLzc4vZEryAvqkyt1sFXvhcQZB0aMZ43s9hn52ZlTmRS9aJRkGqwbFKFPzsWqYJFSC93pY9q8HI8Vh7YLvTg5QFjY/SfUqvgntDa4QO63K+y9ZZeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0ihhClci7rqmdk6efE7rt4cHJ4em3uXEGmQ0JakXpQ=;
 b=RENSD64SS0sDpDBavoSyraGsdDdoM9FT9Sy6I1icgEqduJX9BiT4pISyTnL93sNZHw33FfQW0TL5rjfvuKOBmrmWKPWqKiU5qIPjdDROiHxT/t0J1tA1Cb0e4e44VgNTrd9VDY7C35ixTg4RBBrtEKrYtkU20QqWqmBf3YzzulKVgv8R1sJAcwODXpafSS2vTcBz/WolDZql6pSrinyt4y1a0QK/kl3BDHRVbW0FeTZcshKcycSQdeQLt+bUjbsmdpORJs9aqfMj5a39pxpTJLIKFTkhH7FSy2emOQSW9lnBxw/NqaHXyBqn7dKngB6Ujdamb+LKXKAkjE5WwYNlmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0ihhClci7rqmdk6efE7rt4cHJ4em3uXEGmQ0JakXpQ=;
 b=u8JznNsQ79iIcKNa9mj8Fg2wiYRNk58U3Nb9nqwKgDih42CXtErMfN13ft18kJmFX62ecJAqcdyyAcmisTA9QHN8n+ztxj6FeQzRX1Tqr6kM2Bzuvyt3ki8RxbCJYnH8/o5jqAq+I7OaPMxqvf5IoxndF3T3loOEl+9d2Khize8=
Subject: Re: [RFC][PATCH 2/2] x86: add extra serialization for non-serializing
 MSRs
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <jan.kiszka@siemens.com>, <x86@kernel.org>, <peterz@infradead.org>
References: <20200305174706.0D6B8EE4@viggo.jf.intel.com>
 <20200305174708.F77040DD@viggo.jf.intel.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <f37ecf01-3167-f12e-d9d0-b55c44b80c29@citrix.com>
Date:   Thu, 4 Feb 2021 23:37:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20200305174708.F77040DD@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: LO4P123CA0332.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::13) To BYAPR03MB4728.namprd03.prod.outlook.com
 (2603:10b6:a03:13a::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3281ffb-083f-4ca1-6280-08d8c965c8b8
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5725:
X-Microsoft-Antispam-PRVS: <SJ0PR03MB5725D91AA7FED320B79CC9C9BAB39@SJ0PR03MB5725.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jf3keDDe+M1iHQGnT9BEzfcVcybD9iFWvP8Lx2aLzEWhFwtDDvcRJ03bLKx3J+mVFblyNn73yXOORYzX8hEIhhUn5+MIHSIlhswhe3M2J8h8tUEdr4uoXGQEvcAbIs61X4UxV5X1F6jfVXEa1fewJxCwipK41B2FRjj29YUAz2OdkZqejFr4uZzh0lUig9ZLwDhNkjK9BkTA8/dlEU9KqMo3vaMeVr/egzVY443evQVsyytBq7f49iRajS381AzRPDaO7dBQl1qKPURoyc+ve6DxpEqWc37qRoFpsvknKR8uJAxCKrrAG+VhtOxxVDnpK1jIBzi4VR0jijQWc6G7Ui5InfYiVXuiz+mEEwfvUmn33jZ+tx8STYw6WobJZnEvWzDtuZJdG4dYcUeNj8tUMbAwKQvgKEwIo+SXFLGAkAmA6dWJqubvXmWoF1V1//haYNpFrG0f3uRl19Mwo8KK1SeAT87sTuztYodfpK6p7k5zfSrIwbwnnukgsoWV0FQNLatr68He991fyaZhP9HhFoPA2O6uHMo9xGpZwebfqsfn/wi2r7GhjEJrGeyoXVlRFhS57AxLF8FsVJNpKx3IYMSb6hAXGjm37OYsAsNpHZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4728.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(53546011)(83380400001)(66556008)(16526019)(956004)(31686004)(6486002)(26005)(2616005)(66476007)(186003)(8936002)(6666004)(66946007)(478600001)(36756003)(4326008)(8676002)(31696002)(316002)(2906002)(86362001)(5660300002)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?enVQaW9lZ3ZvN1VTRDhKcGNJcGlTQ2o0UHExamFYY2JGN3lvZEZ5eTVEZTJo?=
 =?utf-8?B?eWlyUldzUlBMRy8xMllia29XaTdTTUhoSHNsOTk2SVJRdjhibkxsMlpjMXZ4?=
 =?utf-8?B?cUJJZXNZUVFUMW8vNWVMVzVGd0JTMlVRc2FReHFMMXRTTGQ0aVFHdzZycTJ0?=
 =?utf-8?B?TjIwVlJIY3VramZuL1ZtWHhaWnc4K0s2SFhIMmhWakRQeXpyLythNWovQ2t6?=
 =?utf-8?B?bHJBeEtIaU1xSlN2bTVHeHI3d3VhRFZ1L3dhSENrMDdEb2JFelJVSWsxNUJx?=
 =?utf-8?B?MmJERDhkdGlsNTl1Vk9DMlZvTG9JWHh2N0VUeGM0ZnVLSUJKWHpNMEovclNX?=
 =?utf-8?B?SjlXZ0VoUjBVNXpocFMwd2NNL29XZU1ld2M0b1padDA1eEJPQmdGMmRrdkJB?=
 =?utf-8?B?bkxEbi8zNExYMWx0cEFUMkdUc2VjaE8rVThNRk42WERJRTZ5cFBBQ0g4YXpo?=
 =?utf-8?B?VXlBZUFMRityNGVuajdsOUV4blYrU3U2cGYyckRhM05jZ3g2c2dUOHdkQWpu?=
 =?utf-8?B?V3p4MVJCS3hDM2M4d1FhdmthRFU2VUNVY3dmNVlpYjNNUGUxclU1cEs0WXYx?=
 =?utf-8?B?MnNHZlEvZDNweTRjdFVGMmwxT2xFV3BueUU0cTlyT2VCVFFOWGlnTWQ2VEho?=
 =?utf-8?B?SlVaL1RkNWVCZE9rS0Z6Y2tQbXpocHZEVTAySHI4NjFDemtyaVVDL0FmMGV6?=
 =?utf-8?B?a3BQMjBpcGYySnVUTFFWYWNwMU13dDF3TzBBR2VQdFhuQzdHRE1EdmNoRVFU?=
 =?utf-8?B?Q2swbm9STG5nV3pGNlFWNGg3dGtNMko4UnVlN3loVE5PUG1rbW5JZDJpVEwv?=
 =?utf-8?B?UkZOUXQrenAvanBVc243Rm9UL2JrUnhUZjI3dm1pUXp3TklILzhIelhTcWt0?=
 =?utf-8?B?anQ1OVZtckxBbXJPNTZGZzQzN1d2bndPQStlejU2RjlmZitwMFk1NVZXRDdV?=
 =?utf-8?B?TXFMd0M0MU1iTWdDb1FyVTV5MGJ0a1kzNzYrUkJRZy8zWGNyVytoWmpIaTFS?=
 =?utf-8?B?STVxdXFEeXZtWENKdUZUcHY3M25lKzM0Z2R4KysxUFNKTUtHSEhqZHR2S0tB?=
 =?utf-8?B?cFp4TGxMbXoxS0hhVTQ0WjBZc2UxbVBiNlh3Y0MvekF2Q2VFZ2N4djBzanNB?=
 =?utf-8?B?QmFpVkU5Y2puTndHdlBwYkJ4eDF0T0RjWmtGNjFBLzlDdXArZmdFT0JBZlVR?=
 =?utf-8?B?ZnVxMDJRb1dpSzlNOGhYRk9jUnIzS2JLRXNGQ0FTYzRGTjdnb2xieEdoUW9O?=
 =?utf-8?B?WVBsWmlhRDFXV1hRTFJYaldYUlpKUER0cWo1M3lnamhtTFBwVTljNG5DS1NR?=
 =?utf-8?B?akdKVnNHWHNjMzJxSUN0aTNrbDVXN1NEZWtaYmpYcXFnMG5RM1VoU0lLSXN1?=
 =?utf-8?B?UEtlcnAydzYxVGw4UGpwMkV4dndGaGo0d001RWJxaExtOVdMU1hrQXNZMDJG?=
 =?utf-8?Q?QoId+nKz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3281ffb-083f-4ca1-6280-08d8c965c8b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4728.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 23:37:07.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHIl4Hj4TUFtvJhDxfXZM2a5FISjr1ROXxGTfyCUTLu7y6qhrp75Vvicujb489VUXZTDDfLQ+iNZDq6rq7A1jQcVbnqIPpaMOqmNd5GpNOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5725
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2020 17:47, Dave Hansen wrote:
> Jan Kiszka reported that the x2apic_wrmsr_fence() function uses a
> plain "mfence" while the Intel SDM (10.12.3 MSR Access in x2APIC
> Mode) calls for "mfence;lfence".
>
> Short summary: we have special MSRs that have weaker ordering
> than all the rest.  Add fencing consistent with current SDM
> recommendatrions.
>
> This is not known to cause any issues in practice, only in
> theory.

So, I accept that Intel have their own reasons for what is written in
the SDM, but "not ordered with stores" is at best misleading.

The x2APIC (and other) MSRs, aren't serialising.  That's fine, as is the
fact that the WRMSR to trigger them doesn't have memory operands, and is
therefore not explicitly ordered with other loads and stores.

Consider:
    xor %edi, %edi
    movb (%rdi), %dl
    wrmsr

It is fine for a non-serialising wrmsr here to execute speculative in
terms of internal calculations, but nothing it does can escape the local
core until the movb has fully retired, and is therefore globally visible.

Otherwise, I can send IPIs from non-architectural paths (in this case,
behind a page fault), and causality is broken.

IPIs are (at minimum) a write-like-thing leaving the core, even if they
don't interact with the regular memory path, and their effects cannot
become visible until the effects of older instructions are visible.

What the SDM is trying to say is that this potentially matters for
writes queued in the WC buffers.

If some code is using WC memory, and wants to send an IPI, and wants to
have the remote IPI handler read said data, then yes - there is a
problem - but the problem is the lack of SFENCE required to make the WC
buffer visible in the first place.

WC code is already responsible for its own memory ordering, and the
x2APIC IPIs can't execute early even in the absence of architectural
ordering guarantees.

~Andrew
