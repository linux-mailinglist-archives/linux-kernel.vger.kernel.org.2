Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C21445974
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhKDSSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhKDSSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:18:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CAEC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 11:16:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r8so9960078wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 11:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=drJ6D9Eu8FeZWkX48l8zvS8JURElK7MsF1YnD12M0PQ=;
        b=Y1k/NacURiNHXdFDKRc4CR+sNx/XDPZRiL3EVrvfvxZy872WUyzGVx97lV04Frkgl7
         ny54lYFUfXyglNbWp01OpWs9vybGyDEG5a89Fo9C+2chwjYrvkUPsm2GTBzaaPCovB5U
         pxpBGEuJlOp66+JRym6XOMd551oc8yQhpKzF7oWg0TCWJwwDIURuSOdhjKH/nwVv5Dbd
         20AajD67TTPPiVRpiouB0JxVLOBhwyQWKZZeMiD+HTLT1ZyBE1DXSkX16s9uUwh66ARz
         bhV6+ZrIalKf1wnIzDZgvU7cb3368FzPNf36mahgGareGbWj9VR+UZdavgqdt9+y5q7G
         PBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=drJ6D9Eu8FeZWkX48l8zvS8JURElK7MsF1YnD12M0PQ=;
        b=w1RJN7vFA81/9fKGfqQPp7HFc2NWTK9SyaZMs05Sfa19RzG8Jh5lQ5weg9NVHBA+ay
         41xEw9n6ML7Y1KenbJK/TULdl46Mm5ZitI4HUw6qQ9MPm/PLWGGwKdhbX3u1ITHw7rkw
         O7PEnCHbtC42F4Pf9f2USAdGMDsgg1X+TiJWomzgAjVXKG+8+jJvfHgoFr0g1Vi8zhki
         zhSELdvRWEHVJYQBsFhkYz5JXiedMZNCiD3v7bf6sRe8wUwBe6U+IYAoUMSIJhyadfLg
         pmjrRFvVC+4/ExX5G7ZSQ9cHlEpE9MPQj70eyIDkAetpqKek/NoujRiB4T1DdfmIs3XK
         Vzig==
X-Gm-Message-State: AOAM53223RgooRExpEAGMT+dQ61HG/LcNyL7N+76lP1/jNq1H2lFHOZQ
        5KB0MAXu3eAfY7IoyqUD83Lto/HLn2FDiA==
X-Google-Smtp-Source: ABdhPJyqL7ZNlq0z1H49SSwly0gaPzKraHGBi63MLkw+widVikO11Um/RXb7K2u9qn0CIxsSKkrhJw==
X-Received: by 2002:adf:9147:: with SMTP id j65mr66481439wrj.163.1636049759040;
        Thu, 04 Nov 2021 11:15:59 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.74.143])
        by smtp.gmail.com with ESMTPSA id q123sm9109298wma.30.2021.11.04.11.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 11:15:58 -0700 (PDT)
Message-ID: <83f48296-fa72-a27f-5acb-654b51cd848f@isovalent.com>
Date:   Thu, 4 Nov 2021 18:15:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: perf build broken looking for bpf/{libbpf,bpf}.h after merge with
 upstream
Content-Language: en-GB
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YYQadWbtdZ9Ff9N4@kernel.org>
 <CAEf4Bzaj4_hXDxk18aJvk2bxJ-rPb++DpPVEeUw0pN-tJuiy0Q@mail.gmail.com>
 <YYQhzbh1tL5MPgaI@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <YYQhzbh1tL5MPgaI@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021-11-04 15:09 UTC-0300 ~ Arnaldo Carvalho de Melo <acme@kernel.org>
> Em Thu, Nov 04, 2021 at 10:47:12AM -0700, Andrii Nakryiko escreveu:
>> On Thu, Nov 4, 2021 at 10:38 AM Arnaldo Carvalho de Melo
>> <arnaldo.melo@gmail.com> wrote:
>>>
>>>
>>> Hi Song,
>>>
>>
>> cc Quentin as well, might be related to recent Makefiles revamp for
>> users of libbpf. But in bpf-next perf builds perfectly fine, so not
>> sure.
> 
> This did the trick:
> 
> ⬢[acme@toolbox perf]$ git show
> commit 504afe6757ec646539ca3b4aa0431820e8c92b45 (HEAD -> perf/core)
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Nov 4 14:58:56 2021 -0300
> 
>     Revert "bpftool: Remove Makefile dep. on $(LIBBPF) for $(LIBBPF_INTERNAL_HDRS)"
> 
>     This reverts commit 8b6c46241c774c83998092a4eafe40f054568881.
> 
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index c0c30e56988f2cbe..c5ad996ee95d4e87 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -39,14 +39,14 @@ ifeq ($(BPFTOOL_VERSION),)
>  BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
>  endif
> 
> -$(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT) $(LIBBPF_HDRS_DIR):
> +$(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT):
>         $(QUIET_MKDIR)mkdir -p $@
> 
>  $(LIBBPF): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_OUTPUT)
>         $(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) \
>                 DESTDIR=$(LIBBPF_DESTDIR) prefix= $(LIBBPF) install_headers
> 
> -$(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_DIR)
> +$(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h $(LIBBPF)
>         $(call QUIET_INSTALL, $@)
>         $(Q)install -m 644 -t $(LIBBPF_HDRS_DIR) $<


Interesting. I needed that patch because otherwise I'd get errors when
compiling bpftool after the switch to libbpf's hashmap implementation.
For the current breakage, it could be a matter of how we pass variables
when descending into bpftool/ from perf's Makefile.perf. I'll try to
look at this in details, and to experiment tonight, if I can. (Thanks
Andrii for the CC!)

Thanks,
Quentin
