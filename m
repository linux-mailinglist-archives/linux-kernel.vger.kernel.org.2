Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC875436213
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhJUMvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230260AbhJUMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634820532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yunc8pub8poBlXrF3I9GBufLMd8UU4ZQnUti6wOGfnc=;
        b=LfLymt8l51FYsVGQqd1uatgp7ICM7vU89+nxqOtR7wx7y8yudpMqnxL5pNOWOXfNfi5obE
        KrcrKGrteBxyyKZi8c903cUiRQHvu96ztG2vIbBFqQepJmyR3HYemucMJtXb7+B+tpL/6T
        1EaYtBwcV24jXgYdgqlCXhT6mrit0xQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-Ga4pDR1wM0eLjidiVrkQLQ-1; Thu, 21 Oct 2021 08:48:51 -0400
X-MC-Unique: Ga4pDR1wM0eLjidiVrkQLQ-1
Received: by mail-ed1-f72.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso216213edf.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yunc8pub8poBlXrF3I9GBufLMd8UU4ZQnUti6wOGfnc=;
        b=5E/39PBIsyMnuOyrlj6MXf34wEJJZ+ArLc6W5QgTM+cNUhvkyD8Kfp2EmztvW3zpXx
         POFcdDNGr1Gpe0+hOhCPzUO8jO7BSBuE2Rpq3ZEfYieHB/8U2F4FSGpqLwDewTcClZcc
         3eqfcYeST+HtOrb/9/jUkBD1fNVNt9BV23c/A7RwvYdu66NKKEP+3wPg5wZpbzSbszcT
         f5jE8mz6qlDFNx+jQqiz+1wIjM1PMyfJCSJOGYbvX/iQJfo8dzEamjLbo8J14pkbdv4V
         HFQgNzOfIOtZjq0UJEE0qMXWihMbTyMazz6M+Sjci9JE55cK6W8niJTby/E6zg51H8j9
         mFfg==
X-Gm-Message-State: AOAM531KaCEV7c+Zk4KmNu6xwaTv+oJ2Sy3ldpgsGhI2fvzW86ysZNVI
        yEeRxZdhXvsWlC5J8eaxH+Qd5A0m+FMV61DruaNcL+CK7pR05mD3TPc6gnQvWpXeCAX03tBaZ7D
        3eYeT3IiA72LQU347MLWuX2A8
X-Received: by 2002:a05:6402:50cd:: with SMTP id h13mr7704805edb.245.1634820529920;
        Thu, 21 Oct 2021 05:48:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLLIdsDZEMYktToTUmJjypunLcitHdoBbMikeliBpBpJFZr+BQdvQNp3OQ0UwVZyVEpQQzPw==
X-Received: by 2002:a05:6402:50cd:: with SMTP id h13mr7704778edb.245.1634820529691;
        Thu, 21 Oct 2021 05:48:49 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id g17sm2843902edv.72.2021.10.21.05.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:48:49 -0700 (PDT)
Date:   Thu, 21 Oct 2021 14:48:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mingo@redhat.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjain@linux.ibm.com, james.clark@arm.com
Subject: Re: [PATCH v2 2/2] perf jevents: Enable warnings through HOSTCFLAGS
Message-ID: <YXFhr2YoVp9GPsDM@krava>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
 <1634807805-40093-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634807805-40093-3-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 05:16:45PM +0800, John Garry wrote:
> Currently no compiler warnings at all are enabled for building jevents,
> so help catch bugs at compile time by enabling through HOSTCFLAGS.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/Makefile.config  | 5 +++++
>  tools/perf/Makefile.perf    | 2 +-
>  tools/perf/pmu-events/Build | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 0ae2e3d8b832..374f65b52157 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -17,6 +17,7 @@ detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
>  detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
>  
>  CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
> +HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>  
>  include $(srctree)/tools/scripts/Makefile.arch
>  
> @@ -211,6 +212,7 @@ endif
>  ifneq ($(WERROR),0)
>    CORE_CFLAGS += -Werror
>    CXXFLAGS += -Werror
> +  HOSTCFLAGS += -Werror
>  endif
>  
>  ifndef DEBUG
> @@ -292,6 +294,9 @@ CXXFLAGS += -ggdb3
>  CXXFLAGS += -funwind-tables
>  CXXFLAGS += -Wno-strict-aliasing
>  
> +HOSTCFLAGS += -Wall
> +HOSTCFLAGS += -Wextra
> +
>  # Enforce a non-executable stack, as we may regress (again) in the future by
>  # adding assembler files missing the .GNU-stack linker note.
>  LDFLAGS += -Wl,-z,noexecstack
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 7df13e74450c..118bcdc70bb4 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -226,7 +226,7 @@ else
>  endif
>  
>  export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
> -export HOSTCC HOSTLD HOSTAR
> +export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
>  
>  include $(srctree)/tools/build/Makefile.include
>  
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index a055dee6a46a..d5c287f069a2 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -1,7 +1,7 @@
>  hostprogs := jevents
>  
>  jevents-y	+= json.o jsmn.o jevents.o
> -HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
> +HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include $(HOSTCFLAGS)

so the the host cflags are made of:

host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))

can't you use KBUILD_HOSTCFLAGS?

also perhaps we could rename KBUILD_HOSTCFLAGS to HOSTCFLAGS?
the name seems like leftover from kbuild move

jirka

>  pmu-events-y	+= pmu-events.o
>  JDIR		=  pmu-events/arch/$(SRCARCH)
>  JSON		=  $(shell [ -d $(JDIR) ] &&				\
> -- 
> 2.17.1
> 

