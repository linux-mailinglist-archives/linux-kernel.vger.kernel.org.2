Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B6432098F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 10:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhBUJzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 04:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhBUJzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 04:55:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C6FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 01:54:25 -0800 (PST)
Received: from zn.tnic (p200300ec2f205c000e54e9bea7f0af0c.dip0.t-ipconnect.de [IPv6:2003:ec:2f20:5c00:e54:e9be:a7f0:af0c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8D951EC04BF;
        Sun, 21 Feb 2021 10:54:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613901264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uxF4+IXKSyYsqHBlEAL+H1yOj5yvBTV6KLN9xQ3Mh2E=;
        b=Tzg/QBiDN016zSYBFLyhgwTEtJbx3woK6DxJ6RaC7SKmzkPngXk11ztBmPFj8ltja7MJEJ
        qr4OwMwyNuUPid8zVOJI+WYl+Bhi2R3JwEw9mAC8dmwDy0w7PXDwnMsDdxtUcjsh7l9Hcc
        y+/RWnzvxtnqpEG0pPZzJKpfaZA8sgs=
Date:   Sun, 21 Feb 2021 10:54:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        pjt@google.com, mbenes@suze.cz, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210221095427.GB1897@zn.tnic>
References: <20210219204300.749932493@infradead.org>
 <20210219210535.492733466@infradead.org>
 <20210219215530.ivzzv3oavhuip6un@treble>
 <20210219220158.GD59023@worktop.programming.kicks-ass.net>
 <20210220003920.GG26778@zn.tnic>
 <YDE9bmaO4tOZ/HWn@hirez.programming.kicks-ass.net>
 <20210220174101.GA29905@zn.tnic>
 <20210220222802.GA4746@worktop.programming.kicks-ass.net>
 <20210220225100.GA5208@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210220225100.GA5208@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 11:51:00PM +0100, Peter Zijlstra wrote:
> > 11 patches and one beer later, it even boots :-)

Yah, beer and coding sometimes works. But only sometimes, ask rostedt
and tglx.

:-P

> > Saves more than 6k on a defconfig build.

Uuh, niice. And that will be a lot more on a all{yes,mod}config.

> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=locking/jump_label

Looks interesting. I'll definitely have an indepth look when you send
them proper.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
