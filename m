Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E894432CA03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhCDBVF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Mar 2021 20:21:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235168AbhCDBUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 20:20:18 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44B8064EEF;
        Thu,  4 Mar 2021 01:19:34 +0000 (UTC)
Date:   Wed, 3 Mar 2021 20:19:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
Message-ID: <20210303201932.7ac93f12@oasis.local.home>
In-Reply-To: <161481830876.1478170.4374239517736205573@swboyd.mtv.corp.google.com>
References: <20210301174749.1269154-1-swboyd@chromium.org>
        <20210301174749.1269154-6-swboyd@chromium.org>
        <YD9kNphaSRPk83KJ@alley>
        <20210303100012.0e6e4de3@gandalf.local.home>
        <YD+2fRo4J/ffQF8z@smile.fi.intel.com>
        <161481830876.1478170.4374239517736205573@swboyd.mtv.corp.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2021 16:38:28 -0800
Stephen Boyd <swboyd@chromium.org> wrote:

> I'm starting to feel like nobody read the commit text, or I messed up
> somehow and the commit text was confusing? :(
> 

I read it, I'm just unfamiliar with it. I don't use pstore, and I'm not
sure what "crashdump" is. Do you mean the kexec/kdump? in which case
you can retrieve data within the kernel quite easily.

I haven't used debuginfod (never heard of it before actually).

> │ This is especially helpful for crash debugging with pstore or crashdump                                                                                                                                         
> │ kernels. If we have the build ID for the module in the stacktrace we can                                                                                                                                        
> │ request the debug symbols for the module from a remote debuginfod server                                                                                                                                        
> │ or parse stacktraces at a later time with decode_stacktrace.sh by                                                                                                                                               
> │ downloading the correct symbols based on the build ID. This cuts down on                                                                                                                                        
> │ the amount of time and effort needed to find the correct kernel modules                                                                                                                                         
> │ for a stacktrace by encoding that information into it.  

Are you saying it's common to have modules from different builds?

> 
> In some distro (read: non-kernel dev) workflows the vmlinux isn't
> shipped on the device and crash handling is done offline or much later.
> Using the build ID[1] is a common way to identify the binary that's
> running on the device. In conjunction with a debuginfod[2] server you
> can download the symbols for a crash automatically if you have the build
> ID information.
> 
> I can add a patch that updates decode_stacktrace.sh to show how it can
> download the correct vmlinux/modules if it isn't provided on the
> commandline.

Are you just trying to match modules with the builds that they were
created with?

> 
> If the debug symbols are on some public server then in theory we could
> have some robot sitting on the mailing list that looks for stacktraces
> and automatically replies with information about the line number/file
> and even provides the code snippet for the code that's crashing from
> that binary, because it's all stored in the full debuginfo builds.

Again, I have no idea how buildids are created or what they are used
for. This is the first time I've even heard about them. I'm all for
helping other people out to make their workflow easier, if it doesn't
make a mess for everyone else.

-- Steve

