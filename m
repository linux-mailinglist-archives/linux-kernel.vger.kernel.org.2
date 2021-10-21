Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A374366F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhJUQAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231842AbhJUQAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634831893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfpACOZctT0RhCg7latmNH+ENpS2vqEqG/eWd+re1mY=;
        b=QziaWjvuE+smOOKB7jXw2Uf+a03TfE9bbrBQvHkgMdh/hxM7+smCdubPJ3nufv9yitWars
        Hgofr+lE1NpEtDm1K1oKemzYS/lAgipIQCv/xQRVZWf6dRUJOO393jdpzeQ2vfvj8QyBRX
        RsowAugM/kcLCNgjPcw1QSy5zQ/6QFA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-UkDl71i-POiHhKE9BeleTg-1; Thu, 21 Oct 2021 11:58:12 -0400
X-MC-Unique: UkDl71i-POiHhKE9BeleTg-1
Received: by mail-wr1-f71.google.com with SMTP id r21-20020adfa155000000b001608162e16dso36999wrr.15
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VfpACOZctT0RhCg7latmNH+ENpS2vqEqG/eWd+re1mY=;
        b=s5KIINAIGV972WdIL42RKg6m3a9CTvosARAV9ZzU8ddaNMjDwG07yTCzfSQgn8F/9o
         dG+PgskaeiWimguKFPKqn3ol5R6uHSXqWVEmfo9oDLGr7Eb3kecL5ioCkC1d0Gh1atEg
         b2f3eAazrr2tJ8KJbWBOkF6pSYRCW/qPiSvE//U5EyoyRRNEKdCHRiOHh7SQOHk4t3pF
         hgCNCTohhgFkpSf6oaz+4Lvh4V3zEydBVmR2Bhb5e9rnngFY4fdbFVb25mVB2MLCPCww
         /Xzc+5Q0J84fX550DiLnIg+NW+6reBB2mwUsTmUB0Kq8qH5m55berLEBpsiIfOks35Jm
         FFwQ==
X-Gm-Message-State: AOAM531fQaj1BozQVfg7OtyAF2UXK46urnhUD+lkVk8vSbwxMcJ5oHFV
        64fS6RozB7QKy2j59OCgS8otSJC1Y4prwAsT2A57JJI/QU+8808jRK59p0YQHnG8zBpRCwXyQW0
        dFouYbl1oZihRMDlwc5Y0GUUd
X-Received: by 2002:a1c:7dcc:: with SMTP id y195mr988213wmc.18.1634831891400;
        Thu, 21 Oct 2021 08:58:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO7pXOflrAQi/8QFCQATA/d84nibFh3NwUmFnriNy9h3nvirMWb+xiNwlUPnLYnkiVTf4qZQ==
X-Received: by 2002:a1c:7dcc:: with SMTP id y195mr988188wmc.18.1634831891154;
        Thu, 21 Oct 2021 08:58:11 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f17sm198213wmf.44.2021.10.21.08.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:58:10 -0700 (PDT)
Date:   Thu, 21 Oct 2021 17:58:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mingo@redhat.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjain@linux.ibm.com, james.clark@arm.com
Subject: Re: [PATCH v2 2/2] perf jevents: Enable warnings through HOSTCFLAGS
Message-ID: <YXGOERQLp3M+pGH1@krava>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
 <1634807805-40093-3-git-send-email-john.garry@huawei.com>
 <YXFhr2YoVp9GPsDM@krava>
 <f4330522-f36e-21f4-5967-0ef67de7418f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4330522-f36e-21f4-5967-0ef67de7418f@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 04:50:09PM +0100, John Garry wrote:
> On 21/10/2021 13:48, Jiri Olsa wrote:
> > > +HOSTCFLAGS += -Wall
> > > +HOSTCFLAGS += -Wextra
> > > +
> > >   # Enforce a non-executable stack, as we may regress (again) in the future by
> > >   # adding assembler files missing the .GNU-stack linker note.
> > >   LDFLAGS += -Wl,-z,noexecstack
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 7df13e74450c..118bcdc70bb4 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -226,7 +226,7 @@ else
> > >   endif
> > >   export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
> > > -export HOSTCC HOSTLD HOSTAR
> > > +export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
> > >   include $(srctree)/tools/build/Makefile.include
> > > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > > index a055dee6a46a..d5c287f069a2 100644
> > > --- a/tools/perf/pmu-events/Build
> > > +++ b/tools/perf/pmu-events/Build
> > > @@ -1,7 +1,7 @@
> > >   hostprogs := jevents
> > >   jevents-y	+= json.o jsmn.o jevents.o
> > > -HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
> > > +HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include $(HOSTCFLAGS)
> > so the the host cflags are made of:
> > 
> > host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
> > 
> > can't you use KBUILD_HOSTCFLAGS?
> 
> Maybe. However, it seems to be empty when building perf/pmu-events. Even in
> building tools/objtool - which currently references it - it is empty AFAICS.
> I'm not sure if it's being imported properly.
> 

I meant change like this (on top of yours)

jirka


---
diff --git a/tools/build/Build.include b/tools/build/Build.include
index 2cf3b1bde86e..c2a95ab47379 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -99,7 +99,7 @@ cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXX
 ###
 ## HOSTCC C flags
 
-host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
+host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
 
 # output directory for tests below
 TMPOUT = .tmp_$$$$
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0ae2e3d8b832..374f65b52157 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -17,6 +17,7 @@ detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
 detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
+HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
 include $(srctree)/tools/scripts/Makefile.arch
 
@@ -211,6 +212,7 @@ endif
 ifneq ($(WERROR),0)
   CORE_CFLAGS += -Werror
   CXXFLAGS += -Werror
+  HOSTCFLAGS += -Werror
 endif
 
 ifndef DEBUG
@@ -292,6 +294,9 @@ CXXFLAGS += -ggdb3
 CXXFLAGS += -funwind-tables
 CXXFLAGS += -Wno-strict-aliasing
 
+HOSTCFLAGS += -Wall
+HOSTCFLAGS += -Wextra
+
 # Enforce a non-executable stack, as we may regress (again) in the future by
 # adding assembler files missing the .GNU-stack linker note.
 LDFLAGS += -Wl,-z,noexecstack
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7df13e74450c..118bcdc70bb4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -226,7 +226,7 @@ else
 endif
 
 export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
-export HOSTCC HOSTLD HOSTAR
+export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
 
 include $(srctree)/tools/build/Makefile.include
 

