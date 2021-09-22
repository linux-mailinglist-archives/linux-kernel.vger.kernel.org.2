Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3246F41526F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbhIVVMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236476AbhIVVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632345040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QSaDDb+UPCl85zWqGodzp//Rjjy1AQfZIg0iKTqryTc=;
        b=RVwXfEGRUJK97+d5JxQEz2QUUl48sZfXdoRnhv5bX4s1WdKNXGYHJ9sA8RKw9AfVFShNIf
        cpuNRZONH3ayrmtVvLVq8IHHnHvIeRCEpe+VNQWfv7Z0J0eDvx95ytDprSQB/T0GYPEqPL
        qavfeZFDGkCa9179teio1UGgctgYKmc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-EtgC5s4zM_6ZUZCjq6jBrA-1; Wed, 22 Sep 2021 17:10:38 -0400
X-MC-Unique: EtgC5s4zM_6ZUZCjq6jBrA-1
Received: by mail-wr1-f70.google.com with SMTP id v15-20020adff68f000000b0015df51efa18so3301016wrp.16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QSaDDb+UPCl85zWqGodzp//Rjjy1AQfZIg0iKTqryTc=;
        b=Nhg7eJpqEylnwuZZzeqmA0mRqIQWz6nSDS279Cffs7XJ7lSuV1Sq9dFzjmqW/cKlff
         WHUR+OlZwLqpyCs974rovB727BPGK0mx7TxTQZsDZbFTkcZERFEMrXAWegzc9p9KFV6X
         XhwIsVNFiWs1DFXEkLm3aImT+dtoyWgeeJkY8sUvYRrNU2F2sxPoG5m9Utem8mkTUnwn
         u8Mnv3wK85/DWNcbbWESVNzx2Z26Df7M3GiV2yxMLdN3GkvFVOX8Kv7hUQCtIJcK8/0m
         Lh2ihPGXKyhNSinTZTITFwYID0lGBsCWccMsECJ1Gbn+RyFT6p3wOMI8VHeQPA1bKVw2
         osFg==
X-Gm-Message-State: AOAM530FBE8aoXnMANZGHcQqa4/OK2Y9RSt4SaFcONKplUVy1fSvIhda
        kXgdlb823Y5sRzK1pIdEll55v8jso4/y6Uhp+BdwdOv9odofSLwxF7kG4rmRiT94FYHSAlvfv86
        ZGYPJNO/fni7i6vE6e4gUWjgN
X-Received: by 2002:a5d:4cc6:: with SMTP id c6mr1205694wrt.108.1632345037784;
        Wed, 22 Sep 2021 14:10:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5T0pxBW9oWQ/llmaNM/LDVZnierNxbbZ52SgI25fsINV0QQ/74eaFTFihjih1WuagzrDGBg==
X-Received: by 2002:a5d:4cc6:: with SMTP id c6mr1205678wrt.108.1632345037650;
        Wed, 22 Sep 2021 14:10:37 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id h1sm3006175wmb.7.2021.09.22.14.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:10:37 -0700 (PDT)
Date:   Wed, 22 Sep 2021 23:10:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, eranian@google.com
Subject: Re: [PATCH v2 1/4] perf: Enable libtracefs dynamic linking
Message-ID: <YUuby5uGSzR9+Lfy@krava>
References: <20210921204839.236840-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921204839.236840-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 01:48:36PM -0700, Ian Rogers wrote:
> Currently libtracefs isn't used by perf, but there are potential
> improvements by using it as identified Steven Rostedt's e-mail:
> https://lore.kernel.org/lkml/20210610154759.1ef958f0@oasis.local.home/
> 
> This change is modelled on the dynamic libtraceevent patch by Michael
> Petlan:
> https://lore.kernel.org/linux-perf-users/20210428092023.4009-1-mpetlan@redhat.com/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/build/Makefile.feature | 1 +
>  tools/build/feature/Makefile | 4 ++++
>  tools/perf/Makefile.config   | 9 +++++++++
>  tools/perf/Makefile.perf     | 2 ++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 3dd2f68366f9..45a9a59828c3 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -52,6 +52,7 @@ FEATURE_TESTS_BASIC :=                  \
>          libslang                        \
>          libslang-include-subdir         \
>          libtraceevent                   \
> +        libtracefs                      \
>          libcrypto                       \
>          libunwind                       \
>          pthread-attr-setaffinity-np     \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index eff55d287db1..d024b5204ba0 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -36,6 +36,7 @@ FILES=                                          \
>           test-libslang.bin                      \
>           test-libslang-include-subdir.bin       \
>           test-libtraceevent.bin                 \
> +         test-libtracefs.bin                    \
>           test-libcrypto.bin                     \
>           test-libunwind.bin                     \
>           test-libunwind-debug-frame.bin         \
> @@ -199,6 +200,9 @@ $(OUTPUT)test-libslang-include-subdir.bin:
>  $(OUTPUT)test-libtraceevent.bin:
>  	$(BUILD) -ltraceevent
>  
> +$(OUTPUT)test-libtracefs.bin:
> +	$(BUILD) -ltracefs

hum, looks like you forgot to git add test-libtracefs.c?

jirka

> +
>  $(OUTPUT)test-libcrypto.bin:
>  	$(BUILD) -lcrypto
>  
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 446180401e26..00ec900ddbca 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1098,6 +1098,15 @@ ifdef LIBTRACEEVENT_DYNAMIC
>    endif
>  endif
>  
> +ifdef LIBTRACEFS_DYNAMIC
> +  $(call feature_check,libtracefs)
> +  ifeq ($(feature-libtracefs), 1)
> +    EXTLIBS += -ltracefs
> +  else
> +    dummy := $(error Error: No libtracefs devel library found, please install libtracefs-dev);
> +  endif
> +endif
> +
>  # Among the variables below, these:
>  #   perfexecdir
>  #   perf_include_dir
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index e04313c4d840..7df13e74450c 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -130,6 +130,8 @@ include ../scripts/utilities.mak
>  #
>  # Define LIBTRACEEVENT_DYNAMIC to enable libtraceevent dynamic linking
>  #
> +# Define LIBTRACEFS_DYNAMIC to enable libtracefs dynamic linking
> +#
>  
>  # As per kernel Makefile, avoid funny character set dependencies
>  unexport LC_ALL
> -- 
> 2.33.0.464.g1972c5931b-goog
> 

