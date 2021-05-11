Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9BC37A906
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhEKOXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:23:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:36234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231154AbhEKOXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:23:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620742919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=45i14jgdilkL4c57omliQFKc/dMVSrDzuFT1ipWFf8M=;
        b=nePkdhpO47MaoTKB9P1sGYbCGxxIKDlBZDpre7MdnhCkKh+rpbX9XqDNiV9WACT/ogMQcK
        B1qI9Qhbokav6j3HT+Gb1NYLnw63gOnl7y52YpzKp3A/LvbBONIa9Zval7qh4L6KmjmgGo
        ijgmbxV7l3Ar/kDGcReiLeT/3zh7Exw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 889F8B11D;
        Tue, 11 May 2021 14:21:59 +0000 (UTC)
Date:   Tue, 11 May 2021 16:21:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Steven Rostedt' <rostedt@goodmis.org>,
        'Stephen Boyd' <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sasha Levin <sashal@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        peter enderborg <peter.enderborg@sony.com>
Subject: Re: [PATCH v6 00/13] Add build ID to stacktraces
Message-ID: <YJqTB5pJiRqS1yGY@alley>
References: <20210511003845.2429846-1-swboyd@chromium.org>
 <b30f6d396edf4db5974a2b90364b6314@AcuMS.aculab.com>
 <20210511085235.09bc38a7@gandalf.local.home>
 <37ca7834a8514a5695ed002e073a83b6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ca7834a8514a5695ed002e073a83b6@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-05-11 12:58:47, David Laight wrote:
> From: Steven Rostedt
> > Sent: 11 May 2021 13:53
> > 
> > On Tue, 11 May 2021 12:36:06 +0000
> > David Laight <David.Laight@ACULAB.COM> wrote:
> > 
> > > >  x1 : ffffff93fef15788 x0 : ffffffe3622352e0
> > > >  Call trace:
> > > >   lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
> > > >   direct_entry+0x16c/0x1b4 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
> > > >   full_proxy_write+0x74/0xa4
> > >
> > > Is there any way to get it to print each module ID only once?
> > 
> > If there's a trivial way to do that, then perhaps it should be done, but for
> > now, this patch series isn't as obnoxious as the previous versions. It only
> > affects stack traces, and I'm fine with that.
> 
> True. Printing the id in the module list was horrid.
> 
> The real downside is all the extra text that will overflow the
> in-kernel buffer.
> At least it shouldn't be extra lines causing screen wrap.
> Unless the variable names are long - hi rust :-)

Note that the ID is printed only when CONFIG_STACKTRACE_BUILD_ID
is enabled. It will be used only by some distros/vendors that
use it to download the debuginfo packages.

Best Regards,
Petr
