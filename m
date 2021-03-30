Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DE034E5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhC3K7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:59:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:57324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhC3K70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:59:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617101964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmeQCq04jT8rHPiUv6/LBiRXDPMlB3aXGtuUdtytZnk=;
        b=li3HODFHgB9/S6azBGw7BuW78uUknYi4ocXmKFhZbr6W6SBSJ89moi2Bct3jdiNqgtIUVL
        zb7xAfevGnBAUzJzXMb6giL32J7yimdf50q70jaNrpWD5DHROz+zbKCYb/w+TO/1l1yYL0
        OUnPfN9/gCj4wD3kMO4ZHijf44GkbaI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 783D7B242;
        Tue, 30 Mar 2021 10:59:24 +0000 (UTC)
Date:   Tue, 30 Mar 2021 12:59:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        peter enderborg <peter.enderborg@sony.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, kexec@lists.infradead.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sasha Levin <sashal@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH v2 00/12] Add build ID to stacktraces
Message-ID: <YGMEi6i8ksa9+adD@alley>
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <20210324085543.GA2660708@infradead.org>
 <dbb430e1-2223-9df0-2563-4b017d6b409d@sony.com>
 <161671450646.3012082.10177164412320557022@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <161671450646.3012082.10177164412320557022@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-03-25 16:21:46, Stephen Boyd wrote:
> Quoting peter enderborg (2021-03-25 04:06:17)
> > On 3/24/21 9:55 AM, Christoph Hellwig wrote:
> > > On Tue, Mar 23, 2021 at 07:04:31PM -0700, Stephen Boyd wrote:
> > >>  x5 : 0000000000000000 x4 : 0000000000000001
> > >>  x3 : 0000000000000008 x2 : ffffff93fef25a70
> > >>  x1 : ffffff93fef15788 x0 : ffffffe3622352e0
> > >>  Call trace:
> > >>   lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
> > >>   direct_entry+0x16c/0x1b4 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
> > > Yikes.  No, please do not make the backtraces a complete mess for
> > > something that serves absolutely no need.
> 
> It serves a need. Please look at the patches to understand that I'm
> adding the buildid to automatically find the associated debug
> information on distros.
> 
> > 
> > Would a "verbose" flag be acceptable solution?    Something like write 1 to /sys/kernel/debug/verbose_stack to get the extra info.
> > 
> > I think I see a need for it.
> > 
> 
> Or a kernel config option and a commandline parameter? That would be OK
> for me as I said on v1 of this series. I'll add that in for the next
> patch series given all the distaste for some more hex characters next to
> the module name.

IMHO, a build configure option would fit the best here.

It does not make sense to show the ID when the kernel vendor does
not have a service to download the related binaries. But it makes
sense to show the buildid by default when the provider/distro has
the service and want to use the ID when handling bug reports.

We could always add boot/run time options when people really need it.

Best Regards,
Petr
