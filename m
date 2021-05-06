Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411E0375659
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhEFPQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235052AbhEFPQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620314117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bd4CSdfya8FJ8/MT+WFvFGTihSjlN97aOlnRHDjdyGw=;
        b=SW4On6OxR+Nd1QjnAvzlu0LE4bhBYlRGjmZnlGbKF6bcxH5ONqIHLaTF2aYIr43k9XdCVE
        d9507klRnNsBfUl6Ux9FGlA8grAxshcbf3DMBm1tV7BcwaWLswcfu/xXmIlrrl1rZEaGOy
        spqyCe7vtwdKIJXzP4SxKVg/5HerTjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-Swbhyv1tP1apVojE5z4EqA-1; Thu, 06 May 2021 11:15:14 -0400
X-MC-Unique: Swbhyv1tP1apVojE5z4EqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDB6A80ED96;
        Thu,  6 May 2021 15:15:12 +0000 (UTC)
Received: from krava (unknown [10.40.193.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id 21A196091A;
        Thu,  6 May 2021 15:15:10 +0000 (UTC)
Date:   Thu, 6 May 2021 17:15:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v4 3/3] perf parse-events: add bison --file-prefix-map
 option
Message-ID: <YJQH/mlPbtdc2aih@krava>
References: <20210430133350.20504-1-dzagorui@cisco.com>
 <20210430133350.20504-3-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430133350.20504-3-dzagorui@cisco.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 06:33:50AM -0700, Denys Zagorui wrote:
> bison stores full paths in generated files and those paths are stored in
> resulting perf binary. Starting from v3.7.1. those paths can be remapped
> by using --file-prefix-map option. So use this option if it possible to
> make perf binary more reproducible.
> 
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/perf/Makefile.config | 9 +++++++++
>  tools/perf/util/Build      | 6 +++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index d8e59d31399a..2035bae6d5c5 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -195,6 +195,12 @@ ifeq ($(call get-executable,$(BISON)),)
>    dummy := $(error Error: $(BISON) is missing on this system, please install it)
>  endif
>  
> +ifneq ($(OUTPUT),)
> +  ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
> +    BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
> +  endif
> +endif

I'm on system with:

[root@kvm-02-guest15 perf]# bison --version
bison (GNU Bison) 3.7.6

but I don't see BISON_FILE_PREFIX_MAP set

[root@kvm-02-guest15 perf]# cat .config-detected | grep BISON_FILE_PREFIX_MAP
[root@kvm-02-guest15 perf]# 

jirka

> +
>  # Treat warnings as errors unless directed not to
>  ifneq ($(WERROR),0)
>    CORE_CFLAGS += -Werror
> @@ -1208,3 +1214,6 @@ $(call detected_var,LIBDIR)
>  $(call detected_var,GTK_CFLAGS)
>  $(call detected_var,PERL_EMBED_CCOPTS)
>  $(call detected_var,PYTHON_EMBED_CCOPTS)
> +ifneq ($(BISON_FILE_PREFIX_MAP),)
> +$(call detected_var,BISON_FILE_PREFIX_MAP)
> +endif
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index e3e12f9d4733..33476b1d28d5 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -204,7 +204,7 @@ $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-
>  
>  $(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/parse-events.y
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
> +	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
>  		-o $(OUTPUT)util/parse-events-bison.c -p parse_events_
>  
>  $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/expr-bison.c
> @@ -214,7 +214,7 @@ $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/e
>  
>  $(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
> +	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
>  		-o $(OUTPUT)util/expr-bison.c -p expr_
>  
>  $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-bison.c
> @@ -224,7 +224,7 @@ $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-
>  
>  $(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
> +	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
>  		-o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
>  
>  FLEX_GE_26 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 26)
> -- 
> 2.26.2.Cisco
> 

