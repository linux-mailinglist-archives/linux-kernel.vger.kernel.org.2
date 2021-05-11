Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215EB37A722
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhEKMxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231362AbhEKMxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:53:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 335E56191A;
        Tue, 11 May 2021 12:52:37 +0000 (UTC)
Date:   Tue, 11 May 2021 08:52:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Stephen Boyd' <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
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
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        Sasha Levin <sashal@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        peter enderborg <peter.enderborg@sony.com>
Subject: Re: [PATCH v6 00/13] Add build ID to stacktraces
Message-ID: <20210511085235.09bc38a7@gandalf.local.home>
In-Reply-To: <b30f6d396edf4db5974a2b90364b6314@AcuMS.aculab.com>
References: <20210511003845.2429846-1-swboyd@chromium.org>
        <b30f6d396edf4db5974a2b90364b6314@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 12:36:06 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> >  x1 : ffffff93fef15788 x0 : ffffffe3622352e0
> >  Call trace:
> >   lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
> >   direct_entry+0x16c/0x1b4 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
> >   full_proxy_write+0x74/0xa4  
> 
> Is there any way to get it to print each module ID only once?

If there's a trivial way to do that, then perhaps it should be done, but for
now, this patch series isn't as obnoxious as the previous versions. It only
affects stack traces, and I'm fine with that.

-- Steve
