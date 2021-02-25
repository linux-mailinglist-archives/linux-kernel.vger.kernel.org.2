Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046C33250AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhBYNn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:43:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54835 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229571AbhBYNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614260511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KQ7sVTCjqXq+gWk8WUPPFzUx0abvdao+zN6h3girOFk=;
        b=LtDFG/7hLkf6GOoS4zLN0URvabbSWaRE+CSFyojZVN493UFNvMV0ywjZUgzUWiaFSuffOU
        HEytbNX7UaFxr/X3tgZ/8OB2Zs7PWZvHE+ARypB5FYQOo/4+cvI/xf9U7x66hJ4ZmeEL9z
        Hy0UC9e0ZaRASsi6Vh1kZuhJDrXFfAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-Kkii4PVRMKWon8nMmzhTdQ-1; Thu, 25 Feb 2021 08:41:47 -0500
X-MC-Unique: Kkii4PVRMKWon8nMmzhTdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF52080196C;
        Thu, 25 Feb 2021 13:41:45 +0000 (UTC)
Received: from krava (unknown [10.40.194.234])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8C89E5D9DC;
        Thu, 25 Feb 2021 13:41:40 +0000 (UTC)
Date:   Thu, 25 Feb 2021 14:41:39 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf tools: Move feature cleanup under tools/build
Message-ID: <YDepE7E/7cdWUDxE@krava>
References: <20210224150831.409639-1-jolsa@kernel.org>
 <CA+icZUWEFqd2eYLf_npXmeP-qF7QEiFwb7h0Gj6U_GCgnvj4+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWEFqd2eYLf_npXmeP-qF7QEiFwb7h0Gj6U_GCgnvj4+g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 11:10:00AM +0100, Sedat Dilek wrote:
> On Wed, Feb 24, 2021 at 4:38 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Arnaldo reported issue for following build command:
> >
> >   $ rm -rf /tmp/krava; mkdir /tmp/krava; make O=/tmp/krava clean
> >     CLEAN    config
> >   /bin/sh: line 0: cd: /tmp/krava/feature/: No such file or directory
> >   ../../scripts/Makefile.include:17: *** output directory "/tmp/krava/feature/" does not exist.  Stop.
> >   make[1]: *** [Makefile.perf:1010: config-clean] Error 2
> >   make: *** [Makefile:90: clean] Error 2
> >
> > The problem is that now that we include scripts/Makefile.include
> > in feature's Makefile (which is fine and needed), we need to ensure
> > the OUTPUT directory exists, before executing (out of tree) clean
> > command.
> >
> > Removing the feature's cleanup from perf Makefile and fixing
> > feature's cleanup under build Makefile, so it now checks that
> > there's existing OUTPUT directory before calling the clean.
> >
> > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> 
> For my new friends from linux-bpf and linux-perf...
> 
> I tested your patch on top of Linux v5.11-10201-gc03c21ba6f4e.
> 
> git checkout c03c21ba6f4e -b for-5.12/perf-tools_feature_cleanup-jolsa
> git branch --show-current
> 
> link="https://lore.kernel.org/r/20210224150831.409639-1-jolsa@kernel.org"
> b4 am $link -o - | git am
> 
> LLVM_TOOLCHAIN_PATH="/opt/llvm-toolchain/bin"
> if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
>    export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"
> fi
> echo $PATH
> 
> MAKE="make V=1"
> MAKE_OPTS="HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld CC=clang
> LD=ld.lld LLVM=1 LLVM_IAS=1"
> MAKE_OPTS="$MAKE_OPTS PAHOLE=/opt/pahole/bin/pahole"
> echo $MAKE $MAKE_OPTS
> 
> LC_ALL=C $MAKE -j1 $MAKE_OPTS -C tools/ clean 2>&1 | tee
> ../make-log_tools-clean_before-perf-build.txt
> 
> LC_ALL=C PYTHON=python3 $MAKE -j4 $MAKE_OPTS -C tools/perf/ 2>&1 | tee
> ../make-log_tools-perf.txt
> 
> grep gcc ../make-log_tools-perf.txt
> [ empty ]
> 
> LC_ALL=C $MAKE -j1 $MAKE_OPTS -C tools/ clean 2>&1 | tee
> ../make-log_tools-clean_after-perf-build.txt
> 
> $ clang --version
> dileks clang version 13.0.0 (https://github.com/llvm/llvm-project.git
> c465429f286f50e52a8d2b3b39f38344f3381cce)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /opt/llvm-toolchain/bin
> 
> Logs etc. see attached tarball.
> 
> Feel free to add:
> 
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v13-git

great, thanks a lot

jirka

