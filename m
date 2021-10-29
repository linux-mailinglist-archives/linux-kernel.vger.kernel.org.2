Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8473D44018F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhJ2R6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:58:43 -0400
Received: from mail-sn1anam02on2050.outbound.protection.outlook.com ([40.107.96.50]:1647
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229489AbhJ2R6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:58:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oywyp5pZM1ITVC7qlEKSDy/tfXyqeU5DiXF9y9bRTmLNBviIMTtzMEQs0nfcvO2GTD8PD+gMUyFTYm7qj2TvnLgt+q5nTdvSkyfqWp8K28FNLB7YoryqhHrHhqY/UdOVicoed33+1RkjhhySb4J588NlPtHtTxWcKmDDSnbDbOSl9UiSVLw5J3M09YvgXBVaqOAnGR0GGX4lVhff4vioo40ZAG2dxlU9gQjUQM3zdYvg2gYgVLhRoju+Uh6KJJUj9hFWT3/5Ail6KzkJmPZFow6dQqYmwwliZEdWq/B3gzwkz7MU8arz8Mq/RGPK+OtvDtkn4taajwGsunwBt7F2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOMQO0oQSYDgGBs49ft2axrytxPmdQhFgE2Jp/lXGas=;
 b=MrkaMgJAfZBLhMmcwgn3TjOCNC/DxbSSoBpZBP6LFWF8tzvHIX+ilrNqqB79OmoVEriGHois3XPJkyZLsSXNFkUVJaiwRU2MZrNY/i79HuR2VYWA57ey3J4a8AD10u0BNPH28fkbhGwp4uvi1FTPDTG84wTrV57j6X+lpFIW3CixtAJxuqLrJeI0ELrEr1d62mXa0iIKIy1FAUq/td+QQ5E03gYknCGm1mbiE/oizyngsEBsvkVg8b/SW/vwLWFEshdNgUtq7Fe2bOgpatXXXJwhvy1B5wnuYvvsjiH6gHWgWxxt963DB2rc/6igOGquetYUILXV0acYARPRq0tKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOMQO0oQSYDgGBs49ft2axrytxPmdQhFgE2Jp/lXGas=;
 b=w3Tyv0n29e78iH0XQGz+assrwrh2o/JeVorWmZzWyPv38Z0bu1UxTja9MZTRoOhh/Kk3wjNixUAbBuoAPTQLLOmZVwUE5EBEhlAl5KIIeQwfrxlLnz7DWomJffXGqGChsr6In6FGL91fQidpBPJHgJqoxkEglblbLCltayub2/o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14; Fri, 29 Oct 2021 17:56:09 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 17:56:09 +0000
Subject: Re: [PATCH 4/4] crypto: ccp - Add SEV_INIT_EX support
To:     Peter Gonda <pgonda@google.com>,
        "Relph, Richard" <Richard.Relph@amd.com>
Cc:     David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marc Orr <marcorr@google.com>, Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211028175749.1219188-1-pgonda@google.com>
 <20211028175749.1219188-5-pgonda@google.com>
 <c2076ecf-8b30-c96e-2169-bc1f031d309e@amd.com>
 <CAMkAt6rKZx=S7tRuNo-dnHw_iJ2uiDp1nzL-WiAgD+uQo+aCyA@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <50889d7c-67ee-ba17-faa4-e930b7c18a09@amd.com>
Date:   Fri, 29 Oct 2021 12:56:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAMkAt6rKZx=S7tRuNo-dnHw_iJ2uiDp1nzL-WiAgD+uQo+aCyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0007.namprd07.prod.outlook.com
 (2603:10b6:803:28::17) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN4PR0701CA0007.namprd07.prod.outlook.com (2603:10b6:803:28::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 17:56:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f727c7d-ae9e-408d-da85-08d99b056322
X-MS-TrafficTypeDiagnostic: DM8PR12MB5430:
X-Microsoft-Antispam-PRVS: <DM8PR12MB543094339ED09D7305B1FD9DEC879@DM8PR12MB5430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2L8+5SBH8PlqK8IKqMQE1Cp/oCOioiLmFUhWR3LjkVU77ppGA6iVbYZt3zeS5Pv0Rr6y5l3go8WbgmWW1a4W6GW/DJNqHD7BlOqEolj10rZs+ZgCZgqI2A+YeelpgMQJdSMT/MsbP1Q0tUz0B5f+/7IM1f5M2a96rfIR71kIb4JQWwRdHBD+FpE0Ft0+7PraJptKjMqZTzRgUkSA2epjwc/X5E90GnGhytLaIy9p7wpSKOmRlM+wQBL4OMGPVz46vs2oUiyX6mD+GwRCjDSeukbxczAUf8KwyA+sCiH8vP3i20grS22zrXKcazM+3FISG+cFKw8kIoES6vci4f4pj2S3GA6rgLm2aKXCD/0v2jk0rwSt4Z6vJqBQGwfOIfHdlcprEwLXn3EkCoVcDUzJxXyFHh9you9MinP8KQvswocaqgS0zR23F5AYNrRqzAZwi32rPOvvEcR7016d3dhzhl5WecP5XjjtS/WqyhVyvMVBg74tqpjV0bRanfYBJ6A/qqrkDmJYSrIWDPEl8itdAD2x9dGUcaISgkd064C4pBP3LMU5ZBanTSr9EwHVlP092ocaXZB6iUYSP1SdxIVfxaJmZkGfKOaX2+TU5XwWXW0blQPm1GvtHJtxVUGveGBFwZjggGAsOvU5IJ1xnAxzRhN9N3+jj3DN0szBbn4uvxW954KN6b40XNY5OD09gNYJ/mLiYbO5wPh8pSudLFgmbPwL5af9TUMrT3cd3/idUxoOwtKvYGYXopT5NKZte073eFWmZlQM1kZqiAblZ2z5CrLng5eWeVXY6Jxt3hWnDhPlrv59tjiU26YRIWnik33
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6636002)(6512007)(4326008)(8676002)(110136005)(54906003)(5660300002)(36756003)(31686004)(6486002)(83380400001)(8936002)(38100700002)(86362001)(31696002)(66556008)(2616005)(186003)(30864003)(956004)(66476007)(508600001)(45080400002)(6506007)(53546011)(66946007)(2906002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTRkNkNVSDBxQytFLzJBNGIvOWRtV3kySVRiZTJvTktLOGtlWWdWdVpBTHh2?=
 =?utf-8?B?bHJRK2hpNVh3Rnc3N2xBK05XRmY1b08wT0lDcm53TDJwK3VQUGNPeCtSUTZE?=
 =?utf-8?B?WXJQMXpDQXN4SmNZc2JwNENIK3MzSGRDb2F2WHVmcnIzYXloWnRxdFVSdG04?=
 =?utf-8?B?ckMvdmtHNFpZTjcrV1ZTTjV1TTdIWW5MclN5MWl5L01XU1phK2NVREtKNEdy?=
 =?utf-8?B?WVZQTVQ2bjVGbXUyMzNCdHc5NmhFT2plcWJKbWhwYUN1aDJpUEFQMnZxREc4?=
 =?utf-8?B?UGVuTStnN0tjb3dpMHRCcGo5RVJyZHFCeVIyMzhaWXVvOTFuaE5xcWFFbCsr?=
 =?utf-8?B?dUsrS3lRS2txTlAwdnR4a244UWY5MUNXYnFtMTRxOTBYdHFXVjBwRjdZVTNi?=
 =?utf-8?B?TUE5bHduOWlHUWxTcXFMajRiK3E1R1ZBZDhFck1TYVFETENVS0V5TUdIOWhE?=
 =?utf-8?B?Sm1BYVRNaUF4RkNWQVF2dXFyYWpQVUdkcDNDQ2VMSFAyd2hDL2JOZVoxYi9Y?=
 =?utf-8?B?N1piQml5MFlSb2wwY0VsTTBWNTl2alpoV255SjFaMkEyKzdmV0swY3IzeHh1?=
 =?utf-8?B?Tmx3MlRuOEJaR09YYjBOMUpkT1pvQTF6UjE4MUplS2FqOGRpVmorV29Eb1Zk?=
 =?utf-8?B?RUtQUDBCekFiS1ZiSkhTczhFZ1U0QWhrNm5KUm8rUkluSW1iaXhlaVJBcHZv?=
 =?utf-8?B?WXZqVldjSXQwTjYzZ1R5ZUhqYjE0N1BsOVd1cU9VTTZsSTUxd0dtWXFzUHNo?=
 =?utf-8?B?cjhRbVVTVGF5dzdMQ3Q3eWJ3SUxjYnhUR0xXQzEyUVlETDAxSktUOWhpSy9Y?=
 =?utf-8?B?VGZPKzREOEpMazE3YUs4ZlMwMk5OaEwwRFEvOFJ0NDQrTmlkdmEzbnBQZjRy?=
 =?utf-8?B?RU9JZWtqQ0IvSGMrL3JML1NMRkVXYkZYLzJqVDBUeFh6Vy9ua3U3b2I0cHEr?=
 =?utf-8?B?Y0c3QVhZSnQ2elkvTmVBd245T3BXbUsvQldnV2x3UWZ3cHhlN25SUU8wQ25E?=
 =?utf-8?B?dFlRV0dwNHloUTcvbzl6a2h5cE11V0xPNnNPeUE2c21jcVFEZThLSzhPdm0r?=
 =?utf-8?B?aFc5TldOMFVPWVJ1QjFOOUpDeVZORUpsbDFXQk9WL1hKMUN0c2pUNmZyRjkw?=
 =?utf-8?B?clBjMUk4VEJrRjBXT3dYbS9uL1RCZGowbGdJcUVKSDBSZUoyVmFmYW5vTWRL?=
 =?utf-8?B?K01wUDFsRUJDQnUxbEYwbGE5a3BRMkFOVzkvVlhLUlltd2U3dktHOG5kaFBu?=
 =?utf-8?B?UmdQQlRLV0ZXUkhYdUxEdDVROU5PZWI0ME43QzdmMFBIUWdBa01TVThjaXJE?=
 =?utf-8?B?OHZNbjJpQm9ROUZBam5HYWx3R2tnRUw3ZVFIWk5uK2xXakJzQVhtTmw4ZWk0?=
 =?utf-8?B?VzlPQ3dnQ21SNFB6TVNzN0ZwSXRoOFRtajc3TkphZjIwRWkreFdGL1VPTjV5?=
 =?utf-8?B?bnc3Ly9DTzlnZ2pNOXdhTkNqc2NBTm5DOWF6bHdlWjQ0b2xJUTBxdHhvcFVy?=
 =?utf-8?B?bmZxVktLYWpGMlllRTJkbUJYNEt3dndEOHhNbjBXVVhkaERJNmJZMnYyRjVm?=
 =?utf-8?B?OHcvb0ttVkpQMmVRbktEUWhKN0ZQYzdMQTREZGlqRkZZTlovTjBNZ24zaXhC?=
 =?utf-8?B?T1FUMVZ2NmZaZGp1ZnBUeXhCUWtYWEFLSnF3ZXB2VTZZQkRiZWx5MVNqeXpa?=
 =?utf-8?B?S0IxNzgyRUdwejJPbG1IOEplQXNpZGJ3L2JiRFM5eVcxNTVNUzFkRU1XYjZW?=
 =?utf-8?B?K3VqTDZGNnBVcW82cGIyUURzQVhWZzVZbWFDWWV4TlpuNnRieEdZL0xDMk9l?=
 =?utf-8?B?cVFlR3Vqa1RWeEtUN2NSaGRKZzEvMHZIbG42aE5wRnN5T0sxZC9wb0lVellu?=
 =?utf-8?B?MkRzclBHRE1aRlJ6ZTNSZ1VzNGZqcHIycWphVmtHWGE5N0UxZ1FDR2ZsYjQx?=
 =?utf-8?B?QjZLVm51MUR5SE5TWHdlNjJmM2tlWjhIVjZ1cGpuelhzWG5EVExXZmFSbSt6?=
 =?utf-8?B?dnJ3dEY2bHZ1Wm1HdEh3Mjh2cnF2RDU4ME54OElsVEpWR2NuU1E5d3pZdzhh?=
 =?utf-8?B?blpPTVhCMm9teDRRYjR4b1ltS0lSRjNiNmdrV2N1aHBhOUJQU0EyYU9NcnpJ?=
 =?utf-8?B?eDdkZkp3dmNmQ1M4SkNYekV6eEVtdjhyMEF4QjJTNlJzQS80alZhSFdXSStD?=
 =?utf-8?Q?4x5M5MrlmEUWwGbAHlFjvj4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f727c7d-ae9e-408d-da85-08d99b056322
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 17:56:09.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWSVeliFQjCmPsVg4DQNdFGUrFae6hANHToZmEVwQJQCtFKDZEjMCIcsUWxwmblgse3GYhJEOiJxAtIaAaaQPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/21 12:26 PM, Peter Gonda wrote:
> On Fri, Oct 29, 2021 at 8:45 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 10/28/21 12:57 PM, Peter Gonda wrote:
>>> From: David Rientjes <rientjes@google.com>
>>>
>>> Add new module parameter to allow users to use SEV_INIT_EX instead of
>>> SEV_INIT. This helps users who lock their SPI bus to use the PSP for SEV
>>> functionality. The 'init_ex_path' parameter defaults to NULL which means
>>> the kernel will use SEV_INIT, if a path is specified SEV_INIT_EX will be
>>> used with the data found at the path. On certain PSP commands this
>>> file is written to as the PSP updates the NV memory region. Depending on
>>> file system initialization this file open may fail during module init
>>> but the CCP driver for SEV already has sufficient retries for platform
>>> initialization. During normal operation of PSP system and SEV commands
>>> if the PSP has not been initialized it is at run time.
>>
>> IIUC, it looks as though the file has to exist before the very first use,
>> otherwise the initialization will fail. Did you consider checking for the
>> presence of the file first and, if not there, just using a memory area of
>> all f's (as documented in the SEV API)? Then on successful INIT, the
>> memory would be written and the file created.
> 
> Thats a great idea. I'll add that functionality.

It all depends on how you want to treat the absence of the file. I can see 
use cases for both creating automatically or failing (e.g. there was a 
typo in the path).

> 
>>
>> Either way, probably worth adding to the commit message. And if you stay
>> with having to pre-allocate the file, it's worth adding to the SEV
>> documentation what is required to be done to initialize the file.
>>
>> Although, INIT_EX is probably worth adding to the SEV documentation in
>> general.
> 
> Is this (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2FDocumentation%2Fvirt%2Fkvm%2Famd-memory-encryption.rst&amp;data=04%7C01%7CThomas.Lendacky%40amd.com%7Cd9723c44ea764cc7540e08d99b013bbb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637711251880475091%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=WJtwak6F%2Bn7PC8R1ohsC%2FNKGi7oDWFTi72NJDteyQoM%3D&amp;reserved=0)
> the documentation you were referring too? If so I can add another
> patch before this one to document INIT, then add the INIT_EX
> documentation here. Or were you thinking something else?

Yes, that's the documentation I was referring to. I think you can just add 
something to the KVM_SEV_INIT entry that talks about the new module 
parameter and a bit about the file and how that file will be used. If you 
decide to stay with a pre-created file, some details about how to create 
the file would then be appropriate.

Thanks,
Tom

> 
>>
>>>
>>> Signed-off-by: David Rientjes <rientjes@google.com>
>>> Co-developed-by: Peter Gonda <pgonda@google.com>
>>> Signed-off-by: Peter Gonda <pgonda@google.com>
>>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>>> Cc: Brijesh Singh <brijesh.singh@amd.com>
>>> Cc: Marc Orr <marcorr@google.com>
>>> Cc: Joerg Roedel <jroedel@suse.de>
>>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>>> Cc: David Rientjes <rientjes@google.com>
>>> Cc: John Allen <john.allen@amd.com>
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com> (
>>> Cc: linux-crypto@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>    drivers/crypto/ccp/sev-dev.c | 186 ++++++++++++++++++++++++++++++++---
>>>    include/linux/psp-sev.h      |  21 ++++
>>>    2 files changed, 192 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
>>> index b568ae734857..c8718b4cbc93 100644
>>> --- a/drivers/crypto/ccp/sev-dev.c
>>> +++ b/drivers/crypto/ccp/sev-dev.c
>>> @@ -22,6 +22,7 @@
>>>    #include <linux/firmware.h>
>>>    #include <linux/gfp.h>
>>>    #include <linux/cpufeature.h>
>>> +#include <linux/fs.h>
>>>
>>>    #include <asm/smp.h>
>>>
>>> @@ -43,6 +44,10 @@ static int psp_probe_timeout = 5;
>>>    module_param(psp_probe_timeout, int, 0644);
>>>    MODULE_PARM_DESC(psp_probe_timeout, " default timeout value, in seconds, during PSP device probe");
>>>
>>> +static char *init_ex_path;
>>> +module_param(init_ex_path, charp, 0660);
>>> +MODULE_PARM_DESC(init_ex_path, " Path for INIT_EX data; if set try INIT_EX");
>>> +
>>>    MODULE_FIRMWARE("amd/amd_sev_fam17h_model0xh.sbin"); /* 1st gen EPYC */
>>>    MODULE_FIRMWARE("amd/amd_sev_fam17h_model3xh.sbin"); /* 2nd gen EPYC */
>>>    MODULE_FIRMWARE("amd/amd_sev_fam19h_model0xh.sbin"); /* 3rd gen EPYC */
>>> @@ -58,6 +63,14 @@ static int psp_timeout;
>>>    #define SEV_ES_TMR_SIZE             (1024 * 1024)
>>>    static void *sev_es_tmr;
>>>
>>> +/* INIT_EX NV Storage:
>>> + *   The NV Storage is a 32Kb area and must be 4Kb page aligned.  Use the page
>>> + *   allocator to allocate the memory, which will return aligned memory for the
>>> + *   specified allocation order.
>>> + */
>>> +#define NV_LENGTH (32 << 10)
>>
>> Just me, but I think '32 * 1024' would be a bit clearer.
> 
> SGTM and more consistent with SEV_ES_TMR_SIZE.
> 
>>
>>> +static void *sev_init_ex_nv_address;
>>> +
>>>    static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
>>>    {
>>>        struct sev_device *sev = psp_master->sev_data;
>>> @@ -135,6 +148,7 @@ static int sev_cmd_buffer_len(int cmd)
>>>        case SEV_CMD_GET_ID:                    return sizeof(struct sev_data_get_id);
>>>        case SEV_CMD_ATTESTATION_REPORT:        return sizeof(struct sev_data_attestation_report);
>>>        case SEV_CMD_SEND_CANCEL:                       return sizeof(struct sev_data_send_cancel);
>>> +     case SEV_CMD_INIT_EX:                   return sizeof(struct sev_data_init_ex);
>>
>> Maybe move this to just under the SEV_CMD_INIT: case statement?
>>
>>>        default:                                return 0;
>>>        }
>>>
>>> @@ -156,6 +170,89 @@ static void *sev_fw_alloc(unsigned long len)
>>>        return page_address(page);
>>>    }
>>>
>>> +static int sev_read_nv_memory(void)
>>> +{
>>> +     struct file *fp;
>>> +     ssize_t nread;
>>> +
>>> +     if (!sev_init_ex_nv_address)
>>> +             return -EOPNOTSUPP;
>>> +
>>> +     fp = filp_open(init_ex_path, O_RDONLY, 0);
>>> +     if (IS_ERR(fp)) {
>>> +             dev_err(psp_master->dev, "sev could not open file for read\n");
>>> +             return PTR_ERR(fp);
>>> +     }
>>> +
>>> +     nread = kernel_read(fp, sev_init_ex_nv_address, NV_LENGTH, 0);
>>> +     dev_dbg(psp_master->dev, "sev NV read %d bytes\n", nread);
>>> +     filp_close(fp, NULL);
>>
>> Add a blank line here.
>>
>>> +     return 0;
>>> +}
>>> +
>>> +static int sev_write_nv_memory(void)
>>> +{
>>> +     struct sev_device *sev = psp_master->sev_data;
>>> +     struct file *fp;
>>> +     loff_t offset = 0;
>>> +     int ret;
>>> +
>>> +     if (!sev_init_ex_nv_address)
>>> +             return -EOPNOTSUPP;
>>> +
>>> +     fp = filp_open(init_ex_path, O_CREAT | O_WRONLY, 0600);
>>> +     if (IS_ERR(fp)) {
>>> +             dev_err(sev->dev, "sev NV data could not be created\n");
>>> +             return PTR_ERR(fp);
>>> +     }
>>
>> Add a blank line here.
>>
>>> +     ret = kernel_write(fp, sev_init_ex_nv_address, NV_LENGTH, &offset);
>>> +     vfs_fsync(fp, 0);
>>> +     filp_close(fp, NULL);
>>> +
>>> +     if (ret != NV_LENGTH) {
>>> +             dev_err(sev->dev,
>>> +                     "failed to write %d bytes to non volatile memory area, ret=%lu\n",
>>> +                     NV_LENGTH, ret);
>>> +             if (ret >= 0)
>>> +                     return -EIO;
>>> +             return ret;
>>> +     }
>>> +
>>> +     dev_dbg(sev->dev, "wrote to non volatile memory area\n");
>>
>> Add a blank line here.
> 
> Added all these blank lines.
> 
>>
>>> +     return 0;
>>> +}
>>> +
>>> +static void sev_write_nv_memory_if_required(int cmd_id)
>>> +{
>>> +     struct sev_device *sev = psp_master->sev_data;
>>> +     int ret;
>>> +
>>> +     if (!sev_init_ex_nv_address)
>>> +             return;
>>> +
>>> +     /*
>>> +      * Only a few platform commands modify the SPI/NV area,
>>> +      * but none of the non-platform commands do. Only INIT,
>>
>> maybe say INIT(_EX)?
> 
> Done.
> 
>>
>>> +      * PLATFORM_RESET, PEK_GEN, PEK_CERT_IMPORT, and
>>> +      * PDH_GEN do.
>>
>> Does SHUTDOWN modify the SPI/NV area? Otherwise a separate comment about
>> why it is included below.
> 
> Double checked the FW doc looks like it does not. Richard can you
> confirm? If it doesn't I'll remove this case.
> 
>   >
>>> +      */
>>> +     switch (cmd_id) {
>>> +     case SEV_CMD_FACTORY_RESET:
>>> +     case SEV_CMD_INIT_EX:
>>> +     case SEV_CMD_PDH_GEN:
>>> +     case SEV_CMD_PEK_CERT_IMPORT:
>>> +     case SEV_CMD_PEK_GEN:
>>> +     case SEV_CMD_SHUTDOWN:
>>> +             break;
>>> +     default:
>>> +             return;
>>> +     };
>>> +
>>> +     ret = sev_write_nv_memory();
>>> +     if (ret)
>>> +             dev_err(sev->dev, "sev NV write failed %d\n", ret);
>>
>> You already have error messages in the sev_write_nv_memory() function,
>> this one probably isn't needed.
> 
> Removed.
> 
>>
>>> +}
>>> +
>>>    static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
>>>    {
>>>        struct psp_device *psp = psp_master;
>>> @@ -225,6 +322,8 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
>>>                dev_dbg(sev->dev, "sev command %#x failed (%#010x)\n",
>>>                        cmd, reg & PSP_CMDRESP_ERR_MASK);
>>>                ret = -EIO;
>>> +     } else {
>>> +             sev_write_nv_memory_if_required(cmd);
>>>        }
>>>
>>>        print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
>>> @@ -251,22 +350,42 @@ static int sev_do_cmd(int cmd, void *data, int *psp_ret)
>>>        return rc;
>>>    }
>>>
>>> -static int __sev_platform_init_locked(int *error)
>>> +static int __sev_init_locked(int *error)
>>>    {
>>> -     struct psp_device *psp = psp_master;
>>>        struct sev_data_init data;
>>> -     struct sev_device *sev;
>>> -     int rc = 0;
>>>
>>> -     if (!psp || !psp->sev_data)
>>> -             return -ENODEV;
>>> +     memset(&data, 0, sizeof(data));
>>> +     if (sev_es_tmr) {
>>> +             u64 tmr_pa;
>>>
>>> -     sev = psp->sev_data;
>>> +             /*
>>> +              * Do not include the encryption mask on the physical
>>> +              * address of the TMR (firmware should clear it anyway).
>>> +              */
>>> +             tmr_pa = __pa(sev_es_tmr);
>>>
>>> -     if (sev->state == SEV_STATE_INIT)
>>> -             return 0;
>>> +             data.flags |= SEV_INIT_FLAGS_SEV_ES;
>>> +             data.tmr_address = tmr_pa;
>>> +             data.tmr_len = SEV_ES_TMR_SIZE;
>>> +     }
>>> +
>>> +     return __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
>>> +}
>>> +
>>> +static int __sev_init_ex_locked(int *error)
>>> +{
>>> +     struct sev_data_init_ex data;
>>> +     int ret;
>>>
>>>        memset(&data, 0, sizeof(data));
>>> +     data.length = sizeof(data);
>>> +     data.nv_address = __psp_pa(sev_init_ex_nv_address);
>>> +     data.nv_len = NV_LENGTH;
>>> +
>>> +     ret = sev_read_nv_memory();
>>> +     if (ret)
>>> +             return ret;
>>> +
>>>        if (sev_es_tmr) {
>>>                u64 tmr_pa;
>>>
>>> @@ -276,12 +395,30 @@ static int __sev_platform_init_locked(int *error)
>>>                 */
>>>                tmr_pa = __pa(sev_es_tmr);
>>>
>>> -             data.flags |= SEV_INIT_FLAGS_SEV_ES;
>>
>> Inadvertant deletion?
> 
> Oops only testing with SEV guests. Will test with ES too. Fixed.
> 
>>
>>>                data.tmr_address = tmr_pa;
>>>                data.tmr_len = SEV_ES_TMR_SIZE;
>>>        }
>>
>> Add a blank line here.
>>
>>> +     return __sev_do_cmd_locked(SEV_CMD_INIT_EX, &data, error);
>>> +}
>>> +
>>> +static int __sev_platform_init_locked(int *error)
>>> +{
>>> +     struct psp_device *psp = psp_master;
>>> +     struct sev_device *sev;
>>> +     int rc;
>>> +     int (*init_function)(int *error) = sev_init_ex_nv_address ?
>>> +                     __sev_init_ex_locked :
>>> +                     __sev_init_locked;
>>
>> This seems a bit much in the declaration. How about moving the assignment
>> down to just before the first call?
> 
> Done.
> 
>>
>>> +
>>> +     if (!psp || !psp->sev_data)
>>> +             return -ENODEV;
>>> +
>>> +     sev = psp->sev_data;
>>>
>>> -     rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
>>> +     if (sev->state == SEV_STATE_INIT)
>>> +             return 0;
>>> +
>>> +     rc = init_function(error);
>>>        if (rc && *error == SEV_RET_SECURE_DATA_INVALID) {
>>>                /*
>>>                 * INIT command returned an integrity check failure
>>> @@ -290,8 +427,8 @@ static int __sev_platform_init_locked(int *error)
>>>                 * failed and persistent state has been erased.
>>>                 * Retrying INIT command here should succeed.
>>>                 */
>>> -             dev_dbg(sev->dev, "SEV: retrying INIT command");
>>> -             rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
>>> +             dev_err(sev->dev, "SEV: retrying INIT command");
>>
>> Maybe dev_notice() instead of dev_err()?
> 
> Done.,
> 
>>
>>> +             rc = init_function(error);
>>>        }
>>>
>>>        if (rc)
>>> @@ -307,7 +444,7 @@ static int __sev_platform_init_locked(int *error)
>>>
>>>        dev_dbg(sev->dev, "SEV firmware initialized\n");
>>>
>>> -     return rc;
>>> +     return 0;
>>>    }
>>>
>>>    int sev_platform_init(int *error)
>>> @@ -987,7 +1124,7 @@ static int sev_misc_init(struct sev_device *sev)
>>>
>>>        init_waitqueue_head(&sev->int_queue);
>>>        sev->misc = misc_dev;
>>> -     dev_dbg(dev, "registered SEV device\n");
>>> +     dev_err(dev, "registered SEV device\n");
>>
>> Not sure this is a necessary change... but, if you don't want this as a
>> dev_dbg() then it should be a dev_info(), because it is not an error.
> 
> Oops this was my debugging. Reverted.
> 
>>
>>>
>>>        return 0;
>>>    }
>>> @@ -1061,6 +1198,12 @@ static void sev_firmware_shutdown(struct sev_device *sev)
>>>                           get_order(SEV_ES_TMR_SIZE));
>>>                sev_es_tmr = NULL;
>>>        }
>>> +
>>> +     if (sev_init_ex_nv_address) {
>>> +             free_pages((unsigned long)sev_init_ex_nv_address,
>>> +                        get_order(NV_LENGTH));
>>> +             sev_init_ex_nv_address = NULL;
>>> +     }
>>>    }
>>>
>>>    void sev_dev_destroy(struct psp_device *psp)
>>> @@ -1105,6 +1248,19 @@ void sev_pci_init(void)
>>>            sev_update_firmware(sev->dev) == 0)
>>>                sev_get_api_version();
>>>
>>> +     /* If an init_ex_path is provided rely on INIT_EX for PSP initialization
>>> +      * instead of INIT.
>>> +      */
>>> +     if (init_ex_path) {
>>> +             sev_init_ex_nv_address = sev_fw_alloc(NV_LENGTH);
>>> +             if (!sev_init_ex_nv_address) {
>>> +                     dev_warn(
>>
>> Shouldn't this be a dev_err(), since you are erroring out?
>>
>>> +                             sev->dev,
>>
>> Move this up to the previous line, i.e.: dev_err(sev->dev,
>>
>>> +                             "SEV: INIT_EX NV storage allocation failed, INIT-EX support unavailable\n");
>>
>> Since you're erroring out, probably enough to just have the first part of
>> that message. But if not:
>>
>> s/INIT-EX/INIT_EX/
> 
> Fixed this log line.
> 
>>
>> Thanks,
>> Tom
>>
>>> +                     goto err;
>>> +             }
>>> +     }
>>> +
>>>        /* Obtain the TMR memory area for SEV-ES use */
>>>        sev_es_tmr = sev_fw_alloc(SEV_ES_TMR_SIZE);
>>>        if (!sev_es_tmr)
>>> diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
>>> index d48a7192e881..1595088c428b 100644
>>> --- a/include/linux/psp-sev.h
>>> +++ b/include/linux/psp-sev.h
>>> @@ -52,6 +52,7 @@ enum sev_cmd {
>>>        SEV_CMD_DF_FLUSH                = 0x00A,
>>>        SEV_CMD_DOWNLOAD_FIRMWARE       = 0x00B,
>>>        SEV_CMD_GET_ID                  = 0x00C,
>>> +     SEV_CMD_INIT_EX                 = 0x00D,
>>>
>>>        /* Guest commands */
>>>        SEV_CMD_DECOMMISSION            = 0x020,
>>> @@ -102,6 +103,26 @@ struct sev_data_init {
>>>        u32 tmr_len;                    /* In */
>>>    } __packed;
>>>
>>> +/**
>>> + * struct sev_data_init_ex - INIT_EX command parameters
>>> + *
>>> + * @length: len of the command buffer read by the PSP
>>> + * @flags: processing flags
>>> + * @tmr_address: system physical address used for SEV-ES
>>> + * @tmr_len: len of tmr_address
>>> + * @nv_address: system physical address used for PSP NV storage
>>> + * @nv_len: len of nv_address
>>> + */
>>> +struct sev_data_init_ex {
>>> +     u32 length;                     /* In */
>>> +     u32 flags;                      /* In */
>>> +     u64 tmr_address;                /* In */
>>> +     u32 tmr_len;                    /* In */
>>> +     u32 reserved;                   /* In */
>>> +     u64 nv_address;                 /* In/Out */
>>> +     u32 nv_len;                     /* In */
>>> +} __packed;
>>> +
>>>    #define SEV_INIT_FLAGS_SEV_ES       0x01
>>>
>>>    /**
>>>
