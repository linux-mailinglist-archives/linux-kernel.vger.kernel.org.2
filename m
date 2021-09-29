Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586C841CD30
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 22:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346511AbhI2UI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 16:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346499AbhI2UIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:08:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1F7C061769
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 13:07:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n18so3823579pgm.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qh2eW8LeGi3ecsaiI+luhmjw9dtB3ilPhgER4eDq8qA=;
        b=em8dv1OxQ3CY+GjWZuXKn0XD1KUyGIXo6JnSL4zsriDxpYcBDGVUun35YA90hQEmqi
         nwnf+rGGPeAbcI0LGWcU/iRdas6o494V9gL/n1Kj9aPw+qTvvWnajAqipmtpl+24cqYw
         Xugl3+HDyMIjT8JAMNMYddsZljPijTLJsX6bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qh2eW8LeGi3ecsaiI+luhmjw9dtB3ilPhgER4eDq8qA=;
        b=td5sQqq+3etowEoJ7xGhyRsCuwUH6LR/FgCLx7qClHniskAQz6u0+hNO7OqWsYSC+5
         8/O6j9KZqb+sbkLb6FulGhfIqVIx3ugduIKbjrFTS6A7EcHtE5C38QOdU9dUX7G+5Gnl
         AfpQLuuQwuwzNZFe76HtixqyF96P6sXyWbIuVQ9lyUfbhdpAaUTrD3FefklBiwnIrv4c
         m7qJ7fFuJWDFghUJujipRA8uOG+JHEe70PFDPaZpZ+hXdQ6vIggtjOgyNUVMXOEeP0r8
         n9PPUasR09QOMdyqyBCWKYReRsoZ47l6+MQjEq1U8eZVhjcY9H77IGVsjchvmZgETt/p
         Jqfg==
X-Gm-Message-State: AOAM533U9Ev0ym5Tg3q2tHt9yP+oJJH1+9JS15m4RucmuN3x/50B0aFk
        1aMMk/QfNUOqfldVPm8OzirjKA==
X-Google-Smtp-Source: ABdhPJyASVjN67AZaOARzgD7jg3cw0R30U1AYnQObbDGl6D1dtp9jLVD4UO+Mz+5SVl0hn/odNL7Lw==
X-Received: by 2002:aa7:9846:0:b0:444:5517:fa17 with SMTP id n6-20020aa79846000000b004445517fa17mr494981pfq.85.1632946020896;
        Wed, 29 Sep 2021 13:07:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r23sm2773788pjo.3.2021.09.29.13.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 13:07:00 -0700 (PDT)
Date:   Wed, 29 Sep 2021 13:06:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Garnier <thgarnie@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, notify@kernel.org
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
Message-ID: <202109291229.C64A1D9D@keescook>
References: <20210929185823.499268-1-alex.popov@linux.com>
 <323d0784-249d-7fef-6c60-e8426d35b083@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <323d0784-249d-7fef-6c60-e8426d35b083@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:03:36PM -0700, Dave Hansen wrote:
> On 9/29/21 11:58 AM, Alexander Popov wrote:
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -53,6 +53,7 @@ static int pause_on_oops_flag;
> >  static DEFINE_SPINLOCK(pause_on_oops_lock);
> >  bool crash_kexec_post_notifiers;
> >  int panic_on_warn __read_mostly;
> > +int pkill_on_warn __read_mostly;

I like this idea. I can't tell if Linus would tolerate it, though. But I
really have wanted a middle ground like BUG(). Having only WARN() and
panic() is not very friendly. :(

> >  unsigned long panic_on_taint;
> >  bool panic_on_taint_nousertaint = false;
> >  
> > @@ -610,6 +611,9 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
> >  
> >  	print_oops_end_marker();
> >  
> > +	if (pkill_on_warn && system_state >= SYSTEM_RUNNING)
> > +		do_group_exit(SIGKILL);
> > +
> >  	/* Just a warning, don't kill lockdep. */
> >  	add_taint(taint, LOCKDEP_STILL_OK);
> >  }
> 
> Doesn't this tie into the warning *printing* code?  That's better than
> nothing, for sure.  But, if we're doing this for hardening, I think we
> would want to kill anyone provoking a warning, not just the first one
> that triggered *printing* the warning.

Right, this needs to be moved into the callers of __warn() (i.e.
report_bug(), and warn_slowpath_fmt()), likely with some small
refactoring in report_bug().

-- 
Kees Cook
