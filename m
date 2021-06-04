Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF5039B17E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 06:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhFDE2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 00:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhFDE2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 00:28:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9FFC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 21:26:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z8so7863173wrp.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 21:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UWd9c23gbJeqKN+x05xqP4SMfjB2/ClR1agz1P2O+o=;
        b=TiAICjH6rsZIbGZ0XdCOAiZXNFUhWsTiGyyMuob+l8IGv9uNIN+jjSUy2wya5b37kH
         8Lhl3dCFLzyC7SUYg1zjfdUrvJAI/mNDqguToa/NpRNQJMI4RNs1CQ/rWwXGeuXyDVuM
         bnV8VaIKZX0l6jxDyxlSiis1p/SqkDDAhXdFsadWl/iiw/AvvSWBMv0+MjTkO69rL8hS
         +cuN2Q3ULZWR3j02VXRXEh9N36nKVI69dkNYKY4qT0Vo91S6QDwXe9ZoRLI0LQHQZUQl
         rTFbUgivH8wU6CECRAVmwg8JdygB/aBXkIrTukFKkqYcM3uiqolcaQ6wQhVVWDh9z7At
         dM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UWd9c23gbJeqKN+x05xqP4SMfjB2/ClR1agz1P2O+o=;
        b=V1MD+ufx727BnEbgUUBHP7kGp0QQVsBlCiNDftWwzrgG05DQ4seTle1rjMetg7lQq0
         s6Cg+m7830fNIN9yAX1DUq5uFRZlk82B5j+Xn0ebGdBznFTlJ78ZcNhxmc4W8FqmaZDu
         XxqaObN4dIRfblIKGPxikeBkjPH/plxrkxgz6WXFUxY1sMS2NsHWwa0y67/2VZmzTd+I
         5xJKiMbRRqrPFZwxoNw9EHWUO0X9HjSrl4F2dzipnMGTLP/D5tBnyDPt1I79bhFgawBD
         1odWG1S6GIX+Y5LKLqGUGE6JrYnSraKWFW17rrioL0DHGbsk+OGFNV2uLy2B1YetKNPf
         9o+Q==
X-Gm-Message-State: AOAM531LHAYoC92zbuwz40o1t2ctiAV9Fv7h7bOxBceN8YbQWvmGXgWb
        +QgIIQk9TxyCh1mmMNTMOlK/QWsp7YyGvZsb777LVw==
X-Google-Smtp-Source: ABdhPJxpoHQxaUxpi3FcOjDlpn8+51W8yCO8DE/Kx7g9qyHOmNa1n7quM25+dXoWEvHIBzJ3zdEYP/LPDc0Ffk5e1A8=
X-Received: by 2002:a5d:4903:: with SMTP id x3mr1531894wrq.376.1622780812951;
 Thu, 03 Jun 2021 21:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210602231052.317048-1-rickyman7@gmail.com>
In-Reply-To: <20210602231052.317048-1-rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Jun 2021 21:26:40 -0700
Message-ID: <CAP-5=fVxHUnwGoRypMjCsPSh_yo5PB8Hzbkx5ArA5b0=7S-67g@mail.gmail.com>
Subject: Re: [PATCH] perf ksymbol: fix memory leak: decrease refcount of map
 and dso
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 4:15 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> ASan reported a memory leak of BPF-related ksymbols map and dso.
> The leak is caused by refcount never reaching 0, due to missing
> __put calls in the function machine__process_ksymbol_register.
> Once the dso is inserted in map, dso__put should be called,
> since map__new2 has increased its refcount to 2.
> The same thing applies for the map when it's inserted into the
> rb-tree in maps (maps__insert increases the refcount to 2).
>
> $ sudo ./perf record -- sleep 5
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.025 MB perf.data (8 samples) ]
>
> =================================================================
> ==297735==ERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 6992 byte(s) in 19 object(s) allocated from:
>     #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
>     #1 0x8e4e53 in map__new2 /home/user/linux/tools/perf/util/map.c:216:20
>     #2 0x8cf68c in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:778:10
>     [...]
>
> Indirect leak of 8702 byte(s) in 19 object(s) allocated from:
>     #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
>     #1 0x8728d7 in dso__new_id /home/user/linux/tools/perf/util/dso.c:1256:20
>     #2 0x872015 in dso__new /home/user/linux/tools/perf/util/dso.c:1295:9
>     #3 0x8cf623 in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:774:21
>     [...]
>
> Indirect leak of 1520 byte(s) in 19 object(s) allocated from:
>     #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
>     #1 0x87b3da in symbol__new /home/user/linux/tools/perf/util/symbol.c:269:23
>     #2 0x888954 in map__process_kallsym_symbol /home/user/linux/tools/perf/util/symbol.c:710:8
>     [...]
>
> Indirect leak of 1406 byte(s) in 19 object(s) allocated from:
>     #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
>     #1 0x87b3da in symbol__new /home/user/linux/tools/perf/util/symbol.c:269:23
>     #2 0x8cfbd8 in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:803:8
>     [...]
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/machine.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 3ff4936a15a42..d5937778875e1 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -776,6 +776,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
>                 if (dso) {
>                         dso->kernel = DSO_SPACE__KERNEL;
>                         map = map__new2(0, dso);
> +                       dso__put(dso);

Will this cause 2 puts if the map allocation fails? Perhaps this
should be "if (map) dso__put(dso);".

Thanks,
Ian

>                 }
>
>                 if (!dso || !map) {
> @@ -792,6 +793,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
>                 map->start = event->ksymbol.addr;
>                 map->end = map->start + event->ksymbol.len;
>                 maps__insert(&machine->kmaps, map);
> +               map__put(map);
>                 dso__set_loaded(dso);
>
>                 if (is_bpf_image(event->ksymbol.name)) {
> --
> 2.31.1
>
