Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4684633D701
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhCPPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbhCPPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:12:37 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42335C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:12:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bf3so21920136edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGbviYwXGLHE4MYF0ChNHBXUiMd3TQQ4yzCas5xcr8I=;
        b=Iv0h1EsZcVF13nLGcu/i5u8myttZ8nW0jW4FaV2UmOu8m1CkiLbzbrPRjAi7y8KlhJ
         dsG0A/itcyfxDqeHFbGp7wMs/lHzpR4nW80zZ3b9nP5mXtUgzbqaD21Mj61+J0lZIdWC
         5StyDiv9neA+dEm2IuXvKnf4pD0Kv6tM89AYJLX4u7vcskjbiNYiug0QIc3cLn0SaAiI
         jnCB2DNU2qwhPXOmepOcPRkyxDOsNzETWB4fR5NHMLQidEwdrjylXG0MegLF77jpD7vA
         nUmFGga1XiUi/pW+XxHzUdlzU5/H1QXwH4Riu8xJO14uXymeegXuQ/KgQmAGQUkI3FYU
         Senw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGbviYwXGLHE4MYF0ChNHBXUiMd3TQQ4yzCas5xcr8I=;
        b=gskteQdtb/rBFpBCM87DSE7EVx3UgeJjjWIdeQj67bRGwe7uiwS/Wha0UxXYuK4nB7
         bZ9R+u4NhxraPywKA+Ny34L7Q4BNRkwW//sKjszcYf55mOt2K0X4SsmCsR/v3my3GjIF
         Q36tmh9JOOWM25lcrus0oURPE2LNpoPDNg9poMvpunqwX4wl7covyN3TZfTGme3nn40b
         CsR1lshroKDRh/azm13lm96Zul6U6WdzFbXIyL3PhuK5A+hi64BpOfbDSNv1NdXo4i2n
         k3MgCyzvRMMry2yauDJmSQrv28HlRpdRDxUdF+0lRhw3Mjv/HSuUpauaJ8yhJLlPEk/e
         sN5w==
X-Gm-Message-State: AOAM532S8AQXmau/81zyZXhWEN/YPTX7jmgG5ESSrGmnX99UdH13gMUy
        aDfeJK0geBk4+fBh5EuiZMevPFwWVlTg046sXTG0
X-Google-Smtp-Source: ABdhPJx+KAzGCNLdXciVgRe6xQgh0JSC4sLM2JEnI2GeBapxGlqLOAN52hdUeZGhdxr4qTkaMyUj7JLDzU+qgwpaoTE=
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr36006172edb.135.1615907554745;
 Tue, 16 Mar 2021 08:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210224215628.192519-1-omosnace@redhat.com> <CAHC9VhQHrmKHxYuTBOy-JHTXHjGTU9UX-AWk3jbiaNfSkZ+N1A@mail.gmail.com>
 <YFDBFuABYwhKliU9@hirez.programming.kicks-ass.net>
In-Reply-To: <YFDBFuABYwhKliU9@hirez.programming.kicks-ass.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Mar 2021 11:12:23 -0400
Message-ID: <CAHC9VhQraYuPu-fu9YFvHOaCiz=6xi1nSbP_YJ+EcSRO0A760Q@mail.gmail.com>
Subject: Re: [PATCH] perf/core: fix unconditional security_locked_down() call
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 10:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Mar 16, 2021 at 09:53:21AM -0400, Paul Moore wrote:
> > On Wed, Feb 24, 2021 at 4:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Currently, the lockdown state is queried unconditionally, even though
> > > its result is used only if the PERF_SAMPLE_REGS_INTR bit is set in
> > > attr.sample_type. While that doesn't matter in case of the Lockdown LSM,
> > > it causes trouble with the SELinux's lockdown hook implementation.
> > >
> > > SELinux implements the locked_down hook with a check whether the current
> > > task's type has the corresponding "lockdown" class permission
> > > ("integrity" or "confidentiality") allowed in the policy. This means
> > > that calling the hook when the access control decision would be ignored
> > > generates a bogus permission check and audit record.
> > >
> > > Fix this by checking sample_type first and only calling the hook when
> > > its result would be honored.
> > >
> > > Fixes: b0c8fdc7fdb7 ("lockdown: Lock down perf when in confidentiality mode")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  kernel/events/core.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > Perf/core folks, do you want to pull this in via your tree?  If I
> > don't hear anything in the next day I'll pull this in via the
> > selinux/next tree.
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> Ah, fell in the cracks... I've no idea what Changelog is trying to tell
> me. It is pure gibberish to me. But the patch seems harmless enough to me.
>
> Let me queue it then.

Great, thanks.

-- 
paul moore
www.paul-moore.com
