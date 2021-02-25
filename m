Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1145324E09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 11:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhBYKXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 05:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhBYKAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 05:00:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736C0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dBYHNHpjiMscbLFgcCRhnWMmA09aZCR09/PS/cqEOA0=; b=J6k0rjgmvniMx0Hs5rZuQyv8qP
        jfopzIqHaLBLoOD6MNP/xyhFf8bVcvBJjw1PuTc0SYrqCdNVGEYqqj03+XUnPkwGGzQyBGYfkeUvE
        LTdp6vwIpX2GzSiRNAzO4Qg6BU2mtJpWV5/Hl9pqKumIQCo41u9dr4/6C0ohs2trq1w4bxfGhnhle
        iIHbtUYf5msvt+eDNL/otVmNr115sP+6GadhD/dQxIWhpW7MYP94rh5+PI/neRC9PBezTMBPX4pyA
        wkAW14kEQtPZrH+al2Yacg0TOrq5OqeGxbnfsTxwqDGdBfFKOxWiqIj+7vt4bb48YEbEHLuxzYFPc
        ferYFfog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFDR9-000129-Nh; Thu, 25 Feb 2021 09:59:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 237883006D0;
        Thu, 25 Feb 2021 10:59:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02B5120BC9284; Thu, 25 Feb 2021 10:59:57 +0100 (CET)
Date:   Thu, 25 Feb 2021 10:59:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Why do kprobes and uprobes singlestep?
Message-ID: <YDd1HTDv/Yg3ZX6p@hirez.programming.kicks-ass.net>
References: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
 <20210224101756.bbdf95b9b6dfc982bff21324@kernel.org>
 <CALCETrWoKh0aemrvTGZ13bUzN27s3WGW3CyvTptvayWLQEk91Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWoKh0aemrvTGZ13bUzN27s3WGW3CyvTptvayWLQEk91Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 11:45:10AM -0800, Andy Lutomirski wrote:
> I guess I see the point for CALL, JMP and RET, but it seems like we
> could emulate those cases instead fairly easily.

Today, yes. CALL emulation was 'recently' made possible by having #BP
have a stack gap. We have emulation for all 3 those instructions
implemented in asm/text-patching.h, see int3_emulate_$insn().
