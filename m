Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2986B3ADC02
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 00:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhFSWxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 18:53:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36262 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhFSWxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 18:53:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624143094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=djP8GCwU7E3FeJYesIhhi3VDXpZX+OZV3RZ8wvDxhCY=;
        b=B1WktvRZvmtYYmMVkUZjinpquKlqQpRdqeGfQo/QV2QFvGvEJOyC/TaPhi0O9RFmKhcKee
        BraDiDVOb+5qm5cvTUVaLxMWFhIk0Z1cbBKjzdMHLzNVE833btnlOAFBB1JQ5XClJS/7p+
        liUbCt5dXwnsueNcYqv7WEegdrDHSk9vLN6Dp5S76X1+08OLzddAhY/llHp++I2Snk5nhu
        BuEiGuMH2O58XcfQ6dteHKRfZDb0k2iX8CcNS3MjmMOq9RCCuncj8X9YaLlpzCiYAlcnJ4
        Ny5QO/ifqcx8DBSozUhZKrzZJMy8vJFAhHrmWNPwCdcNqC8JYnWJdUHhG1/x4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624143094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=djP8GCwU7E3FeJYesIhhi3VDXpZX+OZV3RZ8wvDxhCY=;
        b=ZU/tG3N9pzZkCQgemEF/gIvkrCcA1okHqsj1ASkM0i0WrkVwwEsZYEV2I1giezbLcj/t+d
        wwHTb07M2pB5NrBA==
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [RFC PATCH 1/4] x86/entry/nmi: Switch to the entry stack before switching to the thread stack
In-Reply-To: <20210601065217.23540-2-jiangshanlai@gmail.com>
References: <20210601065217.23540-1-jiangshanlai@gmail.com> <20210601065217.23540-2-jiangshanlai@gmail.com>
Date:   Sun, 20 Jun 2021 00:51:34 +0200
Message-ID: <87bl81h3ih.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01 2021 at 14:52, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> Current kernel has no code to enforce data breakpoint not on the thread
> stack.  If there is any data breakpoint on the top area of the thread
> stack, there might be problem.

And because the kernel does not prevent data breakpoints on the thread
stack we need to do more complicated things in the already horrible
entry code instead of just doing the obvious and preventing data
breakpoints on the thread stack?

Confused.

Thanks,

        tglx
