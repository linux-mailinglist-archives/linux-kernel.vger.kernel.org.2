Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E126041B98E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbhI1Vpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241482AbhI1Vpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632865438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iiF8exoYlueRS0KnTsyCUS9qWOqre2hhhD+QduQ5KmQ=;
        b=h/M2YgpIXSdfeRk3QGzzxo9XKllMTEDaRMgk4tV6guALUud22Y5eqEn1HPsVs4K+rGkmqI
        8PkpAJWiKQmNUjV6sNZmkMOyJ5PZjL7UFPDpGZ+fONM2wxx+RrdiAB/VUt+gV9JJufrk1J
        RDw5PJKb6nxZkTka1etHqUPv33e8ja4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-E8qhOiQHMfWAL8TaAoWzbg-1; Tue, 28 Sep 2021 17:43:57 -0400
X-MC-Unique: E8qhOiQHMfWAL8TaAoWzbg-1
Received: by mail-ed1-f69.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso183840edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iiF8exoYlueRS0KnTsyCUS9qWOqre2hhhD+QduQ5KmQ=;
        b=gCyt6SKVRy4cg2ubjcJL9LgAFfFE8VVJ1mkKse4OgkHVxToV82repDCXxKEK4eYWR8
         p9+878HBwRIBJGuuUiS1YY/IcwWPmlER2b+fMaZWdwZnyKxtuwnK/Mob4NM9cCKByWry
         nxiQBvCycZEtRk+MQPlZ98+KowSM0RRgqLuEr147yYwRdBHoMr0Z8zbYlhJwZAlZsf42
         mR5VmHV2bLmVk37Vfopcm7C+EY8/acNYYAJOJLiqPbMxsk3/UhLWpWW+W9RGRs8F6r/U
         /I7Odp+Ul/EdTGq9oPprahM4FlAxA/cha4MchwQfowXG/H9Tqxne6Yg3rMHWhuPhpSZM
         DITQ==
X-Gm-Message-State: AOAM533Xi4zmot1V4EuxtbSyN3fQgIUYwj8TdEEq+kUy+l4xvNL9RrX7
        syHJubc1otKAX4r2KFSLM+Ezg0039hOj3p6Thjlq7Cezq9T5PzLkFi/1QSBoN2BayfMXIjmwEyo
        9sO03H4C7BU67tn7Qqi55s//6
X-Received: by 2002:a17:906:a150:: with SMTP id bu16mr9687733ejb.108.1632865436027;
        Tue, 28 Sep 2021 14:43:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzffHysBBgASP2F8Ab/DD86WSd96VYno2KuTylK/C/SLn2gn1hgJ37l2kHvRSFMtXbL2vmRZQ==
X-Received: by 2002:a17:906:a150:: with SMTP id bu16mr9687714ejb.108.1632865435859;
        Tue, 28 Sep 2021 14:43:55 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id m7sm171987ejc.83.2021.09.28.14.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:43:55 -0700 (PDT)
Date:   Tue, 28 Sep 2021 23:43:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jinshan Xiong <jinshan.xiong@gmail.com>
Cc:     arnaldo.melo@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/lib/perf: make the static libperf complete
Message-ID: <YVOMmYcX4E6PsHu3@krava>
References: <CABoqRjsUPhJk6A7QOh_9z6zHLyqX=ZZG7gkcEZeui1uO4m7Bbg@mail.gmail.com>
 <20210927223101.3155964-1-jinshan.xiong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927223101.3155964-1-jinshan.xiong@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 03:30:26PM -0700, Jinshan Xiong wrote:
> This patch makes libperf.a complete. Initially it misses the symbols
> fdarray_* that makes it unusable after being installed by:
>    $ make install DESTDIR=<install_dir>
> 
> Check missing symbols:
>    $ nm tools/lib/perf/libperf.a | grep fdarray_
>                     U fdarray__add
>    0000000000002b3e t fdarray__available_entries
>                     U fdarray__exit
>                     U fdarray__filter
>                     U fdarray__grow
>                     U fdarray__init
>                     U fdarray__poll

right, libperf.a should be complete.. but how about we use libperf.a
as source for libapi.a and include it directly in there.. and remove
libapi.a from perf 

we will have complete libperf.a without new -ext.a file and perf
compiles properly.. should be also ok for future perf dynamic linking
with libperf.so

I did just quick build test.. I might have missed something

jirka


---
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 08fe6e3c4089..e1150408e095 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -109,7 +109,7 @@ else
 endif
 
 LIBAPI = $(API_PATH)libapi.a
-export LIBAPI
+LIBAPI_IN = $(API_PATH)libapi-in.o
 
 $(LIBAPI): FORCE
 	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
@@ -121,8 +121,8 @@ $(LIBAPI)-clean:
 $(LIBPERF_IN): FORCE
 	$(Q)$(MAKE) $(build)=libperf
 
-$(LIBPERF_A): $(LIBPERF_IN)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
+$(LIBPERF_A): $(LIBPERF_IN) $(LIBAPI)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN) $(LIBAPI_IN)
 
 $(LIBPERF_SO): $(LIBPERF_IN) $(LIBAPI)
 	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e04313c4d840..a500fd6fe5ea 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -321,9 +321,6 @@ LIBTRACEEVENT_DYNAMIC_LIST = $(PLUGINS_PATH)libtraceevent-dynamic-list
 DYNAMIC_LIST_LDFLAGS               = -Xlinker --dynamic-list=$(LIBTRACEEVENT_DYNAMIC_LIST)
 LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS = $(if $(findstring -static,$(LDFLAGS)),,$(DYNAMIC_LIST_LDFLAGS))
 
-LIBAPI = $(API_PATH)libapi.a
-export LIBAPI
-
 LIBBPF = $(BPF_PATH)libbpf.a
 
 LIBSUBCMD = $(SUBCMD_PATH)libsubcmd.a
@@ -340,7 +337,7 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
 python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
 
 PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
-PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBTRACEEVENT) $(LIBAPI)
+PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBTRACEEVENT)
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
 
@@ -379,7 +376,7 @@ endif
 
 export PERL_PATH
 
-PERFLIBS = $(LIBAPI) $(LIBSUBCMD) $(LIBPERF)
+PERFLIBS = $(LIBSUBCMD) $(LIBPERF)
 ifndef NO_LIBBPF
   ifndef LIBBPF_DYNAMIC
     PERFLIBS += $(LIBBPF)
@@ -820,13 +817,6 @@ $(LIBTRACEEVENT)-clean:
 install-traceevent-plugins: libtraceevent_plugins
 	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) install_plugins
 
-$(LIBAPI): FORCE
-	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
-
-$(LIBAPI)-clean:
-	$(call QUIET_CLEAN, libapi)
-	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
-
 $(LIBBPF): FORCE
 	$(Q)$(MAKE) -C $(BPF_DIR) O=$(OUTPUT) $(OUTPUT)libbpf.a FEATURES_DUMP=$(FEATURE_DUMP_EXPORT)
 
@@ -1078,7 +1068,7 @@ endif # BUILD_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
+clean:: $(LIBTRACEEVENT)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 483f05004e68..c470a67d2b77 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -51,7 +51,6 @@ src_perf  = getenv('srctree') + '/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')
 libtraceevent = getenv('LIBTRACEEVENT')
-libapikfs = getenv('LIBAPI')
 libperf = getenv('LIBPERF')
 
 ext_sources = [f.strip() for f in open('util/python-ext-sources')
@@ -71,7 +70,7 @@ perf = Extension('perf',
 		  include_dirs = ['util/include'],
 		  libraries = extra_libraries,
 		  extra_compile_args = cflags,
-		  extra_objects = [libtraceevent, libapikfs, libperf],
+		  extra_objects = [libtraceevent, libperf],
                  )
 
 setup(name='perf',

