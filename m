Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF1631A1AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhBLP3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhBLP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:28:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB828C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=xCWTsoSbOlREB9C8JV0M5wM8KtNFMw7ytG5hkc4u4As=; b=02pPfDfDq2DgQpcKDDFXi7krtc
        noEa1zoBRz51wPIHSZ76k30UlPMtHuXcszIn+eSqXHMnyegDDpbC+wEMhu4/fD3QYK4MKW7NMjU/t
        mCTLehrbsKo3rChovH0+ll3z5JP5tRCtm6Q0SV7lGjhGyVHaJcOcPUiJTn+04ZHqLaGYzlNVV0suQ
        V1OiUz+9T5IxEX+N7DX3nPPlAjXJM74T4L1wL3Ke3pO3TmC0Dz6O3btXmWwGqb4GZgxg8lT4kQCtr
        yYP8MStjDmDMvfyTdLJC8b3Nzhk+Inu/EQAiNmh7g3F+RKa3xFtj4A3La45ZK7YRUZr1UjoCyjwo+
        AW/pmvWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAaMD-00031t-SC; Fri, 12 Feb 2021 15:27:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C1B3300446;
        Fri, 12 Feb 2021 16:27:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 521542C1CD09A; Fri, 12 Feb 2021 16:27:42 +0100 (CET)
Date:   Fri, 12 Feb 2021 16:27:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jason Gerecke <killertofu@gmail.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] RFC: x86/jump_label: Mark arguments as const to satisfy
 asm constraints
Message-ID: <YCaebvpeLjY5oRAs@hirez.programming.kicks-ass.net>
References: <20210211214848.536626-1-jason.gerecke@wacom.com>
 <20210212094059.5f8d05e8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210212094059.5f8d05e8@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 09:40:59AM -0500, Steven Rostedt wrote:
> On Thu, 11 Feb 2021 13:48:48 -0800
> Jason Gerecke <killertofu@gmail.com> wrote:
> 
> > When compiling an external kernel module with `-O0` or `-O1`, the following
> > compile error may be reported:
> > 
> >     ./arch/x86/include/asm/jump_label.h:25:2: error: impossible constraint in ‘asm’
> >        25 |  asm_volatile_goto("1:"
> >           |  ^~~~~~~~~~~~~~~~~
> > 
> > It appears that these lower optimization levels prevent GCC from detecting
> > that the key/branch arguments can be treated as constants and used as
> > immediate operands. To work around this, explicitly add the `const` label.
> 
> Yes this makes sense. The "i" constraint needs to be a constant.

Right, using -O[01] seems a little daft though. But yeah, that patch is
correct and won't cause harm.

I've queued it for after the next merge window.
