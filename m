Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6738C324734
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 23:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhBXWzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 17:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbhBXWz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 17:55:28 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5F9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:54:48 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id t11so2489460pgu.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jOmXw1WPM0nUfzIqaX5dqMCRyZcFv2a1hU4uE5ZKqPw=;
        b=NS/fQU0uqKdc2JBLjH56mhJmhNJghIs8dpe9fmE4G40oOjMmiAZLJO+4rdom/XGmbS
         utEZXPChTuJ4Dsz2YvBynZuUzk5skjDadVQVRuYNVv2oyoPHc52Svj1Nzp4/9DVA5Jil
         4dkKn+6l0FjUDc1Q75WsQHJoT4bBDFUUmvmMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jOmXw1WPM0nUfzIqaX5dqMCRyZcFv2a1hU4uE5ZKqPw=;
        b=IYakhnYB7nnnHSywblzr6ZqCR8quiKRZinqidCEDvn619L3p2XBREX6Y60TMDVFNVw
         Itu7A7l5bX4DblLrGfWSkEiuLDk5cquNjnKFBx10A3tJhP8qWZZNDQkfUiGg09W8NDSu
         uuqSYlyJXdMm8Ieu24350eBJgN1Ruqg7Ff3DI7qwZ4k6RVbrv897Pn5AxqsYwuHGM+ad
         cNJWzQ0T23nGPz4ahZ2m7v7tjIqaM2kC8OsehjpeI7DRE0m9rQ9dzl/y0n7MsHvQ8cs+
         Gi5BXuIFW8I8rCJHBBi4FcaeNDysAgZtk/HrMYFOjDv8Myo2akcv3llQBMq5LDqMcprW
         RRzQ==
X-Gm-Message-State: AOAM533vJkP6dOpxdk9K1fUOfJFvUKDInO+oAGgDGl5H7TtaPO9EGeb+
        gHgk4CC8IJbbvgObnUtE3+9AvQE+m8W6zw==
X-Google-Smtp-Source: ABdhPJyqJPEp9cvfycFpNkGYgk0xt48wyQcSjwI2oQfVsCi4XXY0cCCA0gcEnL510CtCUZyIx+HaiQ==
X-Received: by 2002:a62:e502:0:b029:1e4:d7c3:5c59 with SMTP id n2-20020a62e5020000b02901e4d7c35c59mr234129pff.51.1614207288381;
        Wed, 24 Feb 2021 14:54:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o5sm3759183pjq.57.2021.02.24.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 14:54:47 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:54:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Message-ID: <202102241454.37C5591C7@keescook>
References: <20210224205938.4104543-1-samitolvanen@google.com>
 <202102241301.226812E88@keescook>
 <20210224224634.GC74404@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224224634.GC74404@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 02:46:34PM -0800, Guenter Roeck wrote:
> On Wed, Feb 24, 2021 at 01:02:27PM -0800, Kees Cook wrote:
> > On Wed, Feb 24, 2021 at 12:59:38PM -0800, Sami Tolvanen wrote:
> > > parisc uses -fpatchable-function-entry with dynamic ftrace, which means we
> > > don't need recordmcount. Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> > > to tell that to the build system.
> > > 
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Fixes: 3b15cdc15956 ("tracing: move function tracer options to Kconfig")
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > 
> > I've got parisc building now, and can confirm:
> > 
> > Tested-by: Kees Cook <keescook@chromium.org>
> > 
> > Guenter, does this fix it for you too?
> > 
> 
> I get this:
> 
> WARNING: unmet direct dependencies detected for FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>   Depends on [n]: TRACING_SUPPORT [=y] && FTRACE [=y] && FTRACE_MCOUNT_RECORD [=n]
>   Selected by [y]:
>   - PARISC [=y] && HAVE_DYNAMIC_FTRACE [=y]
> 
> when trying to build parisc:defconfig.
> 
> I think it should be
> 
> 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
> 
> (no HAVE_)

Yeah, that works for me with both defconfig and allmodconfig. (And that
more closely matches what's done for arm64.)

-Kees

> 
> Guenter
> 
> > -Kees
> > 
> > > ---
> > >  arch/parisc/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> > > index ecef9aff9d72..9ee806f68123 100644
> > > --- a/arch/parisc/Kconfig
> > > +++ b/arch/parisc/Kconfig
> > > @@ -60,6 +60,7 @@ config PARISC
> > >  	select HAVE_KPROBES
> > >  	select HAVE_KRETPROBES
> > >  	select HAVE_DYNAMIC_FTRACE if $(cc-option,-fpatchable-function-entry=1,1)
> > > +	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if HAVE_DYNAMIC_FTRACE
> > >  	select HAVE_FTRACE_MCOUNT_RECORD if HAVE_DYNAMIC_FTRACE
> > >  	select HAVE_KPROBES_ON_FTRACE
> > >  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
> > > 
> > > base-commit: 719bbd4a509f403f537adcaefd8ce17532be2e84
> > > -- 
> > > 2.30.0.617.g56c4b15f3c-goog
> > > 
> > 
> > -- 
> > Kees Cook

-- 
Kees Cook
