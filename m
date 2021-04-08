Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6D358FF3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhDHWp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:45:27 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:38510 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:45:26 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 50BEB92009C; Fri,  9 Apr 2021 00:45:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4323792009B;
        Fri,  9 Apr 2021 00:45:13 +0200 (CEST)
Date:   Fri, 9 Apr 2021 00:45:13 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Masami Hiramatsu <mhiramat@kernel.org>
cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: keep interrupts disabled for BREAKPOINT
 exception
In-Reply-To: <20210409073858.e7b439e99e9e506f4f3847e2@kernel.org>
Message-ID: <alpine.DEB.2.21.2104090041400.65251@angie.orcam.me.uk>
References: <20210330021624.2b776386@xhacker> <20210330183316.942215efe8e6e8455ad14113@kernel.org> <20210331222244.45a5807c@xhacker> <20210401093036.037f2abbce7ed5d1e68466b7@kernel.org> <alpine.DEB.2.21.2104032020100.65251@angie.orcam.me.uk>
 <20210408192348.1d50c588@xhacker.debian> <20210409073858.e7b439e99e9e506f4f3847e2@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021, Masami Hiramatsu wrote:

> > >  Is this approach guaranteed to keep interrupt handling latency low enough
> > > for the system not to be negatively affected, e.g. for the purpose of NTP
> > > timekeeping?
> > 
> > IMHO, interrupt latency can't be ensured if kprobes is triggered.
> 
> Indeed. The latency depends on what the kprobe user handler does. Of course
> it must be as minimal as possible... On x86, it is less than a few microseconds.
> Thus it may be a jitter on hard realtime system, but not a big issue on
> usual system like NTP timekeeping.

 Ack.  Assuming that the breakpoint exception will only disable interrupts 
if kprobes are in use it seems reasonable to me.

 Thanks for double-checking.

  Maciej
