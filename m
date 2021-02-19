Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B50731F911
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhBSMJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:09:58 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:25666 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBSMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1613736593;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q+QJjhNLMxS21jlay2vItPyDNF0wh7KFcr3kFihjy3g=;
  b=exg//ASMwRBRi5oNNNorSLhWT3iC6lnPu6b2+ox8RX+sOj/+gB2D3sRr
   ih1mOevV3qRBI0DpOi5hCpptKSR9aPInEASDY48e/idy2e6UIjNkE0DEb
   Jje9y+Ia5CJEYr7uTWkXoqORrqqoFEAQ0pYjuIv+k16MsPUkYlFemMAi/
   k=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: ikky6QEoKrAcd2hJlTMddxqxApNw6jrNQnGu2NEYkhWKdgCYlOBxO1Wpxr/hg5f6fjHBL3ciEX
 tTrNkc93SA//1lktzYainR+BCM+SYltwn+bvoQIHtd7aKDbp6fnVcYAvsYRiJXzUD+D+dtM/bP
 gKgsNC5BiwK3oAqdvTGYNqBItjcdBdTpgkfgAjmPowbeu5HBm6FG0XISrDn42sACxbE/92T40M
 vfwrDVgdL0905ELdFRjCEIMW4mPIaLgdqxny77lF++JgSEFk9EUPWjbIFe0dOsCt1jvMMI/6Li
 qpY=
X-SBRS: 5.2
X-MesageID: 37534729
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.81,189,1610427600"; 
   d="scan'208";a="37534729"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPHOMBzGr2h8+5sQrEujoiRwDW+tuNniz2XeNPPRSaH4weOHQhpy8/mE/myJrjwBB+pRqRCN/Pd+PIJ1+4QsHYkvKqwgBMPj8oH64x6WOm5YD/8WGpUMBgaBq1ByEbHgZS/sUvSL1h05k39EfUBX2ydoV1edNW6Yij0Dyc/XIEx2vPiJ0bH7S68apoNzYtO0yOi+uAoy4dfwfafBrbOHQWC/GIsc8/aFXU2tmfJhqYvnFCWfC9qSIKZT6bK58bfs3o7xnlv9HWHZDGNPqDKTZmumee/06g0cnv8ajpscrWhaXMn7Gm6UppM8ohBwpJdxo1nDKx46pebN1LTx4Hr/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+QJjhNLMxS21jlay2vItPyDNF0wh7KFcr3kFihjy3g=;
 b=bGaUr0hlht/4Zpr9bVxUUO9qjeQV96cNkJzehqfDUmlm4IMZ7g95w+PiDyY32ZMsTFOIRG6zy8nQ87KZi2E65UU7jnAAyv+46AEe5m+vYjIe+DNrqUU6kt7xXUQs4I9GOxnALSL9/EJUu9DQ65wsAZMyMXbsja80FNfp9IVo5qIJoSjn9CI5o0BLt06+6XDIx50FQIAjdY7c00s6vrw5hTbPVI+tkTifC5qhRzhZN4LlAsB78Rrh0clZZKjUR7dJ9w3uA6i3AkpRdDgSfIwtR88lN4PyTj/kKwSCv+rY35zX5A9YitjcC2MnKETGfVKLUujdMiua9rUt/ght2nZoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+QJjhNLMxS21jlay2vItPyDNF0wh7KFcr3kFihjy3g=;
 b=aFwltNCO5+K2TFO9fWKzn4Slow8OBy/KMle9Ny4gEfcVx8YQIlwR2N5FdO2RsrXstTKu93oaB/F0mgUwwja5a/yJ7ijZLN9Qpei7RtlitX8JCtYd2WmTTcQuws1a08yfcZfnXLZqDRNOJnJauPlZG64sbKrRYAz6eQJi5MYvImA=
Subject: Re: [RFC PATCH] x86/retpolines: Prevent speculation after RET
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, <tony.luck@intel.com>, <pjt@google.com>,
        <linux-kernel@vger.kernel.org>, <r.marek@assembler.cz>,
        <jpoimboe@redhat.com>, <jikos@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
References: <20210218165938.213678824@infradead.org>
 <20210218184639.GF4214@zn.tnic>
 <20210218190231.GA59023@worktop.programming.kicks-ass.net>
 <20210218191138.GH4214@zn.tnic>
 <20210219081507.GC59023@worktop.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <b09d81b3-30b0-972f-aa88-132b0e153673@citrix.com>
Date:   Fri, 19 Feb 2021 12:08:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210219081507.GC59023@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: LO4P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::17) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c83f6033-ee6f-49b2-6f40-08d8d4cf1a12
X-MS-TrafficTypeDiagnostic: BYAPR03MB4487:
X-Microsoft-Antispam-PRVS: <BYAPR03MB44870BD300BCF58EE0EBB23ABA849@BYAPR03MB4487.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BI839z8b4MEn/mlgmQFbLC2wspLmrbAuQJEOd9Fq1ONex+71rJwi54Ix+yCFH9jnoDNQMyI09horwdhcNA0Kao2c63WZ4zwjCKlDBmHf6qlk8Vix5kymgzX1eMyI1KFNQIcSWbg4ezN3ZBmJ5klLve3uI2D/7luMXHg06tPB8743f2RWhmbSh5FohcbKyduHN5KM3AxR9jr5Vzk78B7mrg/oHI48yea6WeGxyx5Wt1ihJQN0FegaJZtMXGevb+Jn8OaGjqzR3Q/TpJVYldKqZ7zu0Wc3oy5nqCZ2tcgJfysj+B6g/fBshuNADt+ytnOfWUxfp6dBe7jA3jbtofTjG5eXyOJRxSOl8kohkUnYM/SGup/f/m7gzDEkChSzY+4f6NGuJkUGOwCNsfhbjD3GpYcpyXuNAcyjGUSSuPK3ZtORjV4C1Oo6eygNbdI1URtW7Sufa1g5ZApdAOcoYx2Zh3qXRlsKB0gkAV5bBXslrSrPJ5dXuQLeE1J8be6DanGcBffYPob/6RS/SjpRgNve1M61H5h0UfEfNuC/gEewDttvp5Mi4jeO70Y1zsmPGqx1xizz+rFrS3oekNjvALC+5RGtwt5SNSANcbK7oBeRXoMQNnKe7g3JvlxNCVLG+x972IH6NlIicar5TTHiIqw4lwiCCta0hxkdpLPeubj7/FVv9YEN9L3GBqmLFPhIhBI9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(66476007)(110136005)(66946007)(66556008)(4326008)(8936002)(83380400001)(8676002)(5660300002)(16576012)(316002)(956004)(6666004)(2616005)(966005)(478600001)(186003)(7416002)(16526019)(53546011)(26005)(31686004)(86362001)(31696002)(6486002)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SU4wQ1VFVko4SERoTW11bnBKd0lVYUZPZndKNENOUy84YU1xUnFFblg0Mis5?=
 =?utf-8?B?SEtFd29TVXJsY0dGcG1lcnlLME9ER0dDQVdtZTFyNDVqMTFqWlQ3ZDUvRmVF?=
 =?utf-8?B?eWtiM0FpbndPNndJZDNpby9ET3F4SmNjRWl1c0J4UnlEcVgxTjQ4b2ZXRnQv?=
 =?utf-8?B?UTBZNjBXQ0htTlNDcGdqR0Z2OUVHdEhBTFdKYUliUmswb2xySlJBY0hRS2Jy?=
 =?utf-8?B?R0hneFEzV20wcFdkVU5SbkxxeXJUN01PVnU2eEJGTzFhb0JZVzZRNkFYYTU1?=
 =?utf-8?B?a2h0dkMyWjIyNWNOcjRMUkJXcjFrZnAxVnpHT2dZSGRmTHdwNkZZQVY2WlFW?=
 =?utf-8?B?Zko0UmpOclNYZXRBVEt3bHgwdzVDQjZMR1NEZ2lLc3NFVkJGbVNCbnpDamxI?=
 =?utf-8?B?bSthNWZ3VVliYzlEY3RMb0FGV2RFM3FpZjIxOEtaaUk3T1hFSjd6Nk45UzZE?=
 =?utf-8?B?VWZYd3VsejFSSkZPQklrOXhhajdYMFhERTFEVHUrTVViajhPbXAyNjFKRUM5?=
 =?utf-8?B?T01MMFJUU3Y2TmZ1WVlESk00Y2RidkJYRDdJSko5M3kwWEs4cnpiQUtJK1pj?=
 =?utf-8?B?amtJQzlFOG14ZVJYekszWDQwMEExL1JSb0w5VHZZYXJOb0c0Y0lSZkxRK0d0?=
 =?utf-8?B?dkFCVC9IZC9MTFIxc1I5a1FuY3piY3huQkNBMWZHMkhQVDkvNDlVWTlQb245?=
 =?utf-8?B?VzFyMVVUV2RLa1loYjJJUzNwaGJ5L0huVkt2aVlocGNVa2Z0cEYvVDV4bFFK?=
 =?utf-8?B?MWlZaEUzLzh2NDVzY2tSUXloUGdWcjl4SWVMaVpvc0ZaVU92eTdqaHd1SnNh?=
 =?utf-8?B?TFdnb3FsVk5TbkYvWGl2ZmgrZVVOeFVvTTJLL29rSzN5R1dSYXB0TVRBMGlm?=
 =?utf-8?B?OHlpclI2aXB6WWRGNUVQMWpQV0h1WllDbExzZE5DQ1UyK3lhdlhjSGFEWXJt?=
 =?utf-8?B?a1BLODVyK29hYmVkVGtiT1Y4T1ZQdWorTHIxdDE5WEw5NW1aMlBLS2dOV0Q0?=
 =?utf-8?B?WVZwZUlmQlRoUzUrV1V5cmZUYnVjR2ZHWUxuTFJQN1VvK1lMNkFwZW5GbVQ1?=
 =?utf-8?B?ZHVvOFZPU0JZcjNUOWdhRUVXUm5sQS9TbjdBeVV4elF5Tm9yVTllWU0wdmZL?=
 =?utf-8?B?VGVWVUNrRGN2ZE0zK0FERjFUVllEaXNhbHJ6YXUzTzJoWHYrbkpSVWNhSkdF?=
 =?utf-8?B?ZTZBWTYxUjBDNmcraHl0TG84U2pzWENoMEVoY08wSktYTk1zd081WCtqbmh5?=
 =?utf-8?B?YndSWUtSRFg1akRRTFRqVEExMm9MR1R2MjE4d1BnSGZZdmJnU2l1U0loQVNa?=
 =?utf-8?B?YTlISEgyWWVCQTE2ZlB2TldBaktQQ2lpNThxZHRJNzI3SHkwT1hrZGQyM0Yz?=
 =?utf-8?B?NHB4TTRERTZKWk1uZXl4ZE9OUWFhd29KeXhGZHl1N2lFVTEzQ2hhN0kvWElv?=
 =?utf-8?B?L1htR1pmRytSdkU2SjhaMWJKaHNHVDA4ckJPTElwTVJybjd1c28wWTRZWkNE?=
 =?utf-8?B?SnZTNXc1bjBhb1RFM25Jdk5nTVVqSHd0MS8vSGZmc0xqN1NxOEtFckl6WjRp?=
 =?utf-8?B?bDdxMy9SZm1WRHhOaXNTVUt1QWJOUk5wTmJZUGplbXA3eTFjbTRaQmFnOWIv?=
 =?utf-8?B?STJ0T2E0YzdGVjI4Y1pzSTMvaGJzbW1JYnB1Nk0xQVFMdnhpeVl4S0FEUjF4?=
 =?utf-8?B?YlNvTGErYmlTOEJId29raEFXZ1RmZ1J6c3UyNGVxZGorRzYzSWR6aFNxWXNQ?=
 =?utf-8?Q?N2hHENMfCX4NNOouCIOpAwXO3khVpI2/TRLfMin?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c83f6033-ee6f-49b2-6f40-08d8d4cf1a12
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 12:08:43.5528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URGZJDpjBuogSzg817x8w7FD3zJpmiWQ1StTIt5IwtGfhQMIRhBtBltYpvNMMImN1mAJdtMFPmx08eAXzLDCUX2OdK6aVwLfOjLrEADuoU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4487
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2021 08:15, Peter Zijlstra wrote:
> On Thu, Feb 18, 2021 at 08:11:38PM +0100, Borislav Petkov wrote:
>> On Thu, Feb 18, 2021 at 08:02:31PM +0100, Peter Zijlstra wrote:
>>> On Thu, Feb 18, 2021 at 07:46:39PM +0100, Borislav Petkov wrote:
>>>> Both vendors speculate after a near RET in some way:
>>>>
>>>> Intel:
>>>>
>>>> "Unlike near indirect CALL and near indirect JMP, the processor will not
>>>> speculatively execute the next sequential instruction after a near RET
>>>> unless that instruction is also the target of a jump or is a target in a
>>>> branch predictor."
>>> Right, the way I read that means it's not a problem for us here.
>> Look at that other thread: the instruction *after* the RET can be
>> speculatively executed if that instruction is the target of a jump or it
>> is in a branch predictor.
> Right, but that has nothing to do with the RET instruction itself. You
> can speculatively execute any random instruction by training the BTB,
> which is I suppose the entire point of things :-)
>
> So the way I read it is that: RET does not 'leak' speculation, but if
> you target the instruction after RET with any other speculation crud,
> ofcourse you can get it to 'run'.
>
> And until further clarified, I'll stick with that :-)

https://developer.amd.com/wp-content/resources/Managing-Speculation-on-AMD-Processors.pdf
Final page, Mitigation G-5

Some parts (before Milan I believe that CPUID rule translates into) may
speculatively execute the instructions sequentially following a call/jmp
indirect or ret instruction.

For Intel, its just call/jmp instructions.  From SDM Vol2 for CALL (and
similar for JMP)

"Certain situations may lead to the next sequential instruction after a
near indirect CALL being speculatively executed. If software needs to
prevent this (e.g., in order to prevent a speculative execution side
channel), then an LFENCE instruction opcode can be placed after the near
indirect CALL in order to block speculative execution."


In both cases, the reason LFENCE is given is for the CALL case, where
there is sequential architectural execution.  JMP and RET do not have
architectural execution following them, so can use a shorter speculation
blocker.

When compiling with retpoline, all CALL/JMP indirects are removed, other
than within the __x86_indirect_thunk_%reg blocks, and those can be fixed
by hand.  That just leaves RET speculation, which has no following
architectural execution, at which point `ret; int3` is the shortest way
of halting speculation, at half the size of `ret; lfence`.

With a gcc toolchain, it does actually work if you macro 'ret' (and
retl/q) to be .byte 0xc3, 0xcc, but this doesn't work for Clang IAS
which refuses to macro real instructions.

What would be massively helpful if is the toolchains could have their
existing ARM straight-line-speculation support hooked up appropriately
so we get some new code gen options on x86, and don't have to resort to
the macro bodges above.

~Andrew
