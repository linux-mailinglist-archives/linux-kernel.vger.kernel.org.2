Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BE434E271
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhC3Hl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:41:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhC3Hlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:41:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97031B1AE;
        Tue, 30 Mar 2021 07:41:33 +0000 (UTC)
Subject: Re: [PATCH] perf annotate: add --demangle and --demangle-kernel
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
 <YDVcZJscuKIgShsm@kernel.org> <a2349b3e-b3e2-f979-6bc5-a2cffbdd2d6a@suse.cz>
 <cad07055-620e-f0ce-9af2-a8a794bc47aa@suse.cz>
Message-ID: <71d26f15-f0e8-adca-1e7c-46effcba913a@suse.cz>
Date:   Tue, 30 Mar 2021 09:41:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cad07055-620e-f0ce-9af2-a8a794bc47aa@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING^2

On 3/7/21 8:23 PM, Martin Liška wrote:
> Hello.
> 
> May I please remind this patch. Apparently, you applied the perf-config
> counterpart of the patch as 804fd30c6bd9aec7859a0503581312834fb197f1
> (in tmp.perf/core branch), but we miss setting the same via options.
> 
> Thank you,
> Martin
> 
> On 2/26/21 11:01 AM, Martin Liška wrote:
>> On 2/23/21 8:49 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Feb 22, 2021 at 09:29:22AM +0100, Martin Liška escreveu:
>>>> Perf annotate supports --symbol but it's impossible to filter
>>>> a C++ symbol. With --no-demangle one can filter easily by
>>>> mangled function name.
>>>>
>>>> Signed-off-by: Martin Liška <mliska@suse.cz>
>>>> ---
>>>>   tools/perf/Documentation/perf-annotate.txt | 7 +++++++
>>>>   tools/perf/builtin-annotate.c              | 4 ++++
>>>>   2 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
>>>> index 1b5042f134a8..80c1be5d566c 100644
>>>> --- a/tools/perf/Documentation/perf-annotate.txt
>>>> +++ b/tools/perf/Documentation/perf-annotate.txt
>>>> @@ -124,6 +124,13 @@ OPTIONS
>>>>   --group::
>>>>       Show event group information together
>>>> +--demangle::
>>>> +    Demangle symbol names to human readable form. It's enabled by default,
>>>> +    disable with --no-demangle.
>>>> +
>>>> +--demangle-kernel::
>>>> +    Demangle kernel symbol names to human readable form (for C++ kernels).
>>>> +
>>>>   --percent-type::
>>>>       Set annotation percent type from following choices:
>>>>         global-period, local-period, global-hits, local-hits
>>>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>>>> index a23ba6bb99b6..ef70a17b9b5b 100644
>>>> --- a/tools/perf/builtin-annotate.c
>>>> +++ b/tools/perf/builtin-annotate.c
>>>> @@ -538,6 +538,10 @@ int cmd_annotate(int argc, const char **argv)
>>>>               "Strip first N entries of source file path name in programs (with --prefix)"),
>>>>       OPT_STRING(0, "objdump", &annotate.opts.objdump_path, "path",
>>>>              "objdump binary to use for disassembly and annotations"),
>>>> +    OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
>>>> +            "Disable symbol demangling"),
>>>
>>> Nope, this _enables_ demangling, i.e.:
>>>
>>>     perf annotate --demangle
>>
>> Oh, yeah, you are right.
>>
>>>
>>> Asks for symbol demangling, while:
>>>
>>>     perf annotate --no-demangle
>>>
>>> As you correctly wrote in your commit message and on the
>>> --demangle-kernel case, enables demangling.
>>
>> Fixed that in V2.
>>
>> Martin
>>
>>>
>>> Please consider making this configurable (if not already) via
>>> ~/.perfconfig, 'perf config', sure in a followup patch.
>>>
>>> Thanks,
>>>
>>> - Arnaldo
>>>
>>>> +    OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
>>>> +            "Enable kernel symbol demangling"),
>>>>       OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
>>>>               "Show event group information together"),
>>>>       OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
>>>> -- 
>>>> 2.30.1
>>>>
>>>
>>
> 

