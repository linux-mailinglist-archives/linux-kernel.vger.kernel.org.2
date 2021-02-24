Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D1D32471B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 23:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhBXWrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 17:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhBXWrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 17:47:17 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB339C061574;
        Wed, 24 Feb 2021 14:46:37 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id z22so924414oop.0;
        Wed, 24 Feb 2021 14:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gFZNWeIhl7Y/jbqyRNEhThvOfIfoUo6CLS+kVSL6lq4=;
        b=g8QU3tpcgTpAdkAv9GFd7982wm4xmyrAmrHbmg2BtaxQ1bTz5eqwfdGeJeEoOV7KWg
         1Ct3YTa5xEmLiHu2VZ6rYGyWkfHTJCQNsv7vTbNY5es9I3h6lCUMLBMARVF7LXDQGRVe
         iP83zpxX0dC8z2iZr9M0ZBCJtUtUWQiSNgAuhxH3EfBQfEVTqvYrZBcPx0cBMHJyH9I0
         RmYW+nA6EcDw4Rx+vIB789fiaHhIjnN7OcscuDXIrD72f8Mm/i3CRT4Kw3qfObtBWVjT
         rEipdaltcmm0BJ39M1ByYUIde36SQRVpKXpziBNLqO5R7pBKRPJtNpspusw+ENifk7Dm
         q8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gFZNWeIhl7Y/jbqyRNEhThvOfIfoUo6CLS+kVSL6lq4=;
        b=WHQ7QmbIqqSXB+SPk/0AO892vYmiArPg1HsTRbnjxYNuLT2EYPvz18IT8b1VjtgWEd
         fxxrpY+EqdWN09s19BD669FC5NP0hEwqVUG1Xm976fiXD+EBFzPL0D94HAr8jUMBRD7J
         PiYApbkBJXWc2HcSbk6NbTgCLJzAX5OLS+kyBOl+1wMxM8q77feQYMuEE+Qtxi3LqHFs
         o+ruUNmpZdk4knCDFT61mzeHZ09Mo2VUfbLphW6EnzD0F9pcCfNk7n/b1/S/5CJ6T6Ds
         2Pk9RWwSHa/ShtcHOBG2vNlNv9ySU3LQyNLuJ9YhkpYJC1Hd5p2cfzFo8W63ialp0ala
         wwzQ==
X-Gm-Message-State: AOAM530eI/X4Jy0esSgFRuoXFXJRgUKc+l7RShDeBv6p//uYUy1vWto1
        uPiDXe0db9rT3fVws1DciYw=
X-Google-Smtp-Source: ABdhPJz1dw7Vb+fq9ngSXMME0Hbyhc459UGMP6540Dyu6XNZ0MLsOeuHeWuTboR4k9NfdvxuHtWN6w==
X-Received: by 2002:a4a:2f4b:: with SMTP id p72mr3768242oop.27.1614206797089;
        Wed, 24 Feb 2021 14:46:37 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 64sm667611otl.5.2021.02.24.14.46.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Feb 2021 14:46:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 24 Feb 2021 14:46:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Message-ID: <20210224224634.GC74404@roeck-us.net>
References: <20210224205938.4104543-1-samitolvanen@google.com>
 <202102241301.226812E88@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102241301.226812E88@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 01:02:27PM -0800, Kees Cook wrote:
> On Wed, Feb 24, 2021 at 12:59:38PM -0800, Sami Tolvanen wrote:
> > parisc uses -fpatchable-function-entry with dynamic ftrace, which means we
> > don't need recordmcount. Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> > to tell that to the build system.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Fixes: 3b15cdc15956 ("tracing: move function tracer options to Kconfig")
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> I've got parisc building now, and can confirm:
> 
> Tested-by: Kees Cook <keescook@chromium.org>
> 
> Guenter, does this fix it for you too?
> 

I get this:

WARNING: unmet direct dependencies detected for FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
  Depends on [n]: TRACING_SUPPORT [=y] && FTRACE [=y] && FTRACE_MCOUNT_RECORD [=n]
  Selected by [y]:
  - PARISC [=y] && HAVE_DYNAMIC_FTRACE [=y]

when trying to build parisc:defconfig.

I think it should be

	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE

(no HAVE_)

Guenter

> -Kees
> 
> > ---
> >  arch/parisc/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> > index ecef9aff9d72..9ee806f68123 100644
> > --- a/arch/parisc/Kconfig
> > +++ b/arch/parisc/Kconfig
> > @@ -60,6 +60,7 @@ config PARISC
> >  	select HAVE_KPROBES
> >  	select HAVE_KRETPROBES
> >  	select HAVE_DYNAMIC_FTRACE if $(cc-option,-fpatchable-function-entry=1,1)
> > +	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if HAVE_DYNAMIC_FTRACE
> >  	select HAVE_FTRACE_MCOUNT_RECORD if HAVE_DYNAMIC_FTRACE
> >  	select HAVE_KPROBES_ON_FTRACE
> >  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
> > 
> > base-commit: 719bbd4a509f403f537adcaefd8ce17532be2e84
> > -- 
> > 2.30.0.617.g56c4b15f3c-goog
> > 
> 
> -- 
> Kees Cook
