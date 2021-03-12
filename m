Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F453394AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhCLR0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:26:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbhCLR0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:26:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B69D64E76;
        Fri, 12 Mar 2021 17:26:24 +0000 (UTC)
Date:   Fri, 12 Mar 2021 12:26:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <20210312122622.603bd82c@gandalf.local.home>
In-Reply-To: <20210312144726.GA22098@zn.tnic>
References: <20210312113253.305040674@infradead.org>
        <CA+icZUVa7c4aZ=Tq-Axfqu9hT2QR-iNbAMGHE6u1ps-6Vw35=A@mail.gmail.com>
        <20210312144726.GA22098@zn.tnic>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 15:47:26 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Mar 12, 2021 at 03:29:48PM +0100, Sedat Dilek wrote:
> > What does this change exactly mean to/for me?  
> 
> Probably nothing.
> 
> I would be very surprised if it would be at all noticeable for you -
> it's not like the kernel is executing long streams of NOPs in fast
> paths.
> 

With ftrace enabled, every function starts with a NOP. But that said, the
simple answer is for Sedat to apply the patches on his box and do some
performance testing. It doesn't matter if you are white, black, male,
female, or anything in between. As my daughter's swim coach said; it's the
numbers that matter here. Run a bunch of benchmarks on your box on the
latest kernel, apply Peter's patches, and then run the benchmarks again on
the latest kernel with Peter's patches and then report the difference. If
it's negligible then there's nothing to worry about.

-- Steve
