Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAD5369A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243532AbhDWTG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWTG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:06:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5DBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:06:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j14-20020a17090a694eb0290152d92c205dso1729170pjm.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GpqOHn/9B9hSZVCdkn9bD5TQglqedYD5yQE2kwe7+Eo=;
        b=BxPC1ErkiPg0mzt5jzCE6imPVfaIddBKFHJEDMk+3J9PzEMiP3RwLJJ9R3yYcuY7KG
         dA+BehMoNCCD3l3aMJK47uzSNDSacKLDHtsnBo6YlsZUh3yEd4E4KQP621ZpakIUFxHA
         3HjmBYz0cyeAPfbFiMLhss4Kvbt/n6JZzrNRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GpqOHn/9B9hSZVCdkn9bD5TQglqedYD5yQE2kwe7+Eo=;
        b=nk4U81k65R060GzN63ISi/fLAunJnNfsht33XZVqLIi61MPULO07aP3lqmn9dLUvOg
         F6YZFW6p7BQy9tBXTJxW5l+E/TKBgR7314a4C2xf0NToA7B1Ws7pvLIoXLZCLnTExp01
         W0rjVnS9C6msJ7JEErCMzhjThxX4BhJVzhu09MBYjftgV1HWIcHG5/OKgrEzosKhQmyx
         8O5kaVvcTN6XyvH3A7n2ijlWZc1xuj/btxMBwv8syfnXBOrEubmeIDtza2VdgMscd7zP
         BpoKVdUDU+SQiPEVfG/9XmWhti9NNZ9NClUQN7fNzHiqCcSwDJvtg4+pySWaUp5y9L5I
         DQ9Q==
X-Gm-Message-State: AOAM5327898U4QWoXaN4F3oNg/6hyIeazkYEhzRR2jvmw8eogRS4dN/+
        iXA2BZjj+doBlIdGqoM4E0vQdCznkxwJsA==
X-Google-Smtp-Source: ABdhPJzYZkSuoxgidmF/KPrSbE9Ua89opGdRHB4AAnsUO5lp6E3kBAAVvSp1N1fyfEymVkDJjD5fjg==
X-Received: by 2002:a17:902:8bcb:b029:ec:a192:21cf with SMTP id r11-20020a1709028bcbb02900eca19221cfmr5228506plo.71.1619204779623;
        Fri, 23 Apr 2021 12:06:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a129sm5528260pfa.36.2021.04.23.12.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 12:06:18 -0700 (PDT)
Date:   Fri, 23 Apr 2021 12:06:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools build: Fix quiet cmd indentation
Message-ID: <202104231158.30BC61C4F@keescook>
References: <20210421185848.1292167-1-keescook@chromium.org>
 <YIMX164sB0CjPHUW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIMX164sB0CjPHUW@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 03:54:15PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 21, 2021 at 11:58:48AM -0700, Kees Cook escreveu:
> > The tools quiet cmd output has mismatched indentation (and extra space
> > character between cmd name and target name) compared to the rest of
> > kbuild out:
> > 
> >   HOSTCC  scripts/insert-sys-cert
> >   LD       /srv/code/tools/objtool/arch/x86/objtool-in.o
> >   LD       /srv/code/tools/objtool/libsubcmd-in.o
> >   AR       /srv/code/tools/objtool/libsubcmd.a
> >   HOSTLD  scripts/genksyms/genksyms
> >   CC      scripts/mod/empty.o
> >   HOSTCC  scripts/mod/mk_elfconfig
> >   CC      scripts/mod/devicetable-offsets.s
> >   MKELF   scripts/mod/elfconfig.h
> >   HOSTCC  scripts/mod/modpost.o
> >   HOSTCC  scripts/mod/file2alias.o
> >   HOSTCC  scripts/mod/sumversion.o
> >   LD       /srv/code/tools/objtool/objtool-in.o
> >   LINK     /srv/code/tools/objtool/objtool
> >   HOSTLD  scripts/mod/modpost
> >   CC      kernel/bounds.s
> > 
> > Adjust to match the rest of kbuild.
> 
> Is this some recent regression? I never noticed this when build perf,
> with what I have in perf/urgent:
> [...]
> It seems nicely aligned:
> [...]
>   GEN      /tmp/build/perf/common-cmds.h
>   CC       /tmp/build/perf/perf-read-vdso32
>   CC       /tmp/build/perf/exec-cmd.o
>   MKDIR    /tmp/build/perf/fd/

This is a "tools only" build. I wasn't clear enough in my commit log
(sorry, I can fix that if needed): it's mismatched with regard to the
rest of the kernel's kbuild output. (And since objtool is built out of
tools/, I see intermixed indentation on parallelized x86 builds.)

And, in fact, you can see it just in our combined email reply
quotations. The first line is a build target from the main kernel (from
my email), and the second is a build target from tools/ (from your email,
with additional email-quote-prefixing added for comparison):

> >   CC      scripts/mod/empty.o
> >   CC       /tmp/build/perf/exec-cmd.o
--------------^

(I haven't looked into what's needed to strip $(obj) from the tools/
target output, but that isn't as jarring for me as the extra space.)

I also nominate myself for "most trivial patch this week" award.

-Kees

-- 
Kees Cook
