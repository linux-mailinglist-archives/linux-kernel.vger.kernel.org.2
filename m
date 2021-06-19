Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADF33AD88D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 09:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhFSH61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 03:58:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33152 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhFSH60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 03:58:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624089375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cNstW53zAdTSKjnd/uFTh8EXy2E4aia9C+TcSMNuBas=;
        b=Y4Zza9RNF6VigLci/ADSaUf4+ygwxRn/7bMN/rCSZje+ZyBSxgRscBgwo+cRPkEhgihh3c
        A5i9MWuuFoP+1KtABklDV2YsLnart5f45j8QCw4QIy8xeM6bgFQzP7tEf3F1UQMAjjiAlK
        MHlZjZwaH6hPK1yyEvCN24tkeXlbrNth/bMC4A+4beG2UTwSpCh8mCUZMoCvmjILbh+wiK
        7OnM/VN2PWIhMUOWU6o2xT0hClIcYxZ1o9rdw5dJ3JefCrft/n9t2OnOrW7D3cOapKsW1N
        641PxYyino6lUNjKLh0Eb37rwpyt8X2mtmFLw6JpVOIViQWeV1cbnkC/pmT0ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624089375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cNstW53zAdTSKjnd/uFTh8EXy2E4aia9C+TcSMNuBas=;
        b=bwBA7DmZJN1MBR4lu/rAt+eSH3j5NMDsmCO1p5SPtn9xYETMQSUEHzURcxDfOLhxZSy2hW
        ugsocUyTTTEFcXCg==
To:     Juri Lelli <juri.lelli@redhat.com>, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH RT v2 1/2] time/hrtimer: Add PINNED_HARD mode for realtime hrtimers
In-Reply-To: <87k0mqeofg.ffs@nanos.tec.linutronix.de>
References: <20210616071705.166658-1-juri.lelli@redhat.com> <20210616071705.166658-2-juri.lelli@redhat.com> <87k0mqeofg.ffs@nanos.tec.linutronix.de>
Date:   Sat, 19 Jun 2021 09:56:14 +0200
Message-ID: <87bl82e19d.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19 2021 at 01:35, Thomas Gleixner wrote:
> The wild west of anything which scratches 'my itch' based on 'my use
> case numbers' in Linux ended many years ago and while RT was always a
> valuable playground for unthinkable ideas we definitely tried hard not
> to accept use case specific hacks wihtout a proper justification that it
> makes sense in general.
>
> So why are you even trying to sell this to me?

I wouldn't have been that grumpy if you'd at least checked whether the
task is pinned. Still I would have told you that you "fix" it at the
wrong place.

Why on earth is that nohz heuristic trainwreck not even checking that?
It's not a RT problem and it's not a problem restricted to RT tasks
either. If a task is pinned then arming the timer on a random other CPU
is blatant nonsense independent of the scheduling class.

Thanks,

        tglx
