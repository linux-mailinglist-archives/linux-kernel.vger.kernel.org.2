Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C695E35D61D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbhDMDo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:44:27 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:51556 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238999AbhDMDo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:44:26 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 13D3hkRn022991;
        Tue, 13 Apr 2021 05:43:46 +0200
Date:   Tue, 13 Apr 2021 05:43:46 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <20210413034346.GA22861@1wt.eu>
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com>
 <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 07:46:06PM -0400, Len Brown wrote:
> On Mon, Apr 12, 2021 at 11:21 AM Andy Lutomirski <luto@kernel.org> wrote:
> 
> > AMX: Multiplying a 4x4 matrix probably looks *great* in a
> > microbenchmark.  Do it once and you permanently allocate 8kB (is that
> > even a constant?  can it grow in newer parts?), potentially hurts all
> > future context switches, and does who-knows-what to Turbo licenses and
> > such.
> 
> Intel expects that AMX will be extremely valuable to key workloads.
> It is true that you may never run that kind of workload on the machine
> in front of you,
> and so you have every right to be doubtful about the value of AMX.
> 
> The AMX architectural state size is not expected to change.
> Rather, if a "new AMX" has a different state size, it is expected to
> use a new feature bit, different from AMX.
> 
> The AMX context switch buffer is allocated only if and when a task
> touches AMX registers.
> 
> Yes, there will be data transfer to and from that buffer when three
> things all happen.
> 1. the data is valid
> 2. hardware interrupts the application
> 3. the kernel decides to context switch.

As a userspace developer of a proxy, my code is extremely sensitive to
syscall cost and works in environments where 1 million interrupts/s is
not uncommon. Additionally the data I process are small HTTP headers
and I already had to reimplement my own byte-level memcmp because the
overhead of some libc to decide what variant to use to compare 5 bytes
was higher than the time to iterate over them.

So I'm among those userspace developers who grumble each time new
technology is automatically adopted by the compiler and libs, because
that tends to make me figure what the impact is and how to work around
it. I have no idea what AMX could bring me but reading this above makes
me think that it has a great potential of significantly hurting the
performance if one lib decides to occasionally make use of it. It would
possibly be similar if a lib decided to use AVX-512 to copy data and if
it resulted in the CPU quickly reaching its TDP and starting to throttle
like crazy :-/

Thus I think that the first thing to think about before introducing
possibly cost-sensitive optimizations is : how do I allow easily
user-space to easily disable them for a task, and how do I allow an
admin to easily disable them system-wide. "echo !foobar > cpuinfo"
could be a nice way to mask a flag system-wide for example. prctl()
would be nice for a task (as long as it's not too late already).

Maybe the API should be surrounded by __amx_begin() / __amx_end() and
the calls having undefined behavior outside of these. These flags would
put a flag somewhere asking to extend the stacks, or __amx_begin() could
even point itself to the specific stack to be used. This way it could
possibly allow some userspace libraries to use it for small stuff
without definitely impacting the rest of the process.

> At the risk of stating the obvious...
> Intel's view is that libraries that deliver the most value from the
> hardware are a "good thing",
> and that anything preventing libraries from getting the most value
> from the hardware is a "bad thing":-)

As a developer I have a different view. Anything that requires to build
using different libraries depending on the systems is a real hassle,
and I want to focus on the same code to run everywhere. I'm fine with
some #ifdef in the code if I know that a specific part must run as
fast as possible, and even some runtime detection at various points
but do not want to have to deal with extra dependencies that further
increase the test matrix and combinations in bug reports.

Just my two cents,
Willy
