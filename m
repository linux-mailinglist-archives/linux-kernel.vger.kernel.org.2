Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F9B402BB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbhIGPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344974AbhIGPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:25:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D6C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 08:24:19 -0700 (PDT)
Date:   Tue, 7 Sep 2021 17:24:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631028255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ztyMDLw2nLj5OUvh/fHeitzx6bLzqOi9rgLK4HB9cnQ=;
        b=yHdbfkr9fR+1+QuVUkNWQo+UXziwWf0HMkA6AZd7TqGMNtBOBzy3SKZiQlFxrZO3jHH9o+
        RAyn/X9g3kON7/HgmHnKA6qa7b2VMdyUQ6F4e5nPJl2chPZimSr+6LrLqRYZwGVwg2cIPI
        +LzyOGFCzWDRc6lkslFT8qoj4oQvtMRlOHkWcreou5L0VIcnNRfcmFiCxqbVPK1im/XPnk
        hDdnXC5F9y5EytNbvfZrOnWHINqgf4VAB9cJ8WZHsV2Rlx4/4vw5pnChI6TWPVaXXSa53K
        BiRL1TA3gXbf91d67OQwP9Oa0zmIQsm+QzghQduCLDOSMTkH9eyU8AIYP27UiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631028255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ztyMDLw2nLj5OUvh/fHeitzx6bLzqOi9rgLK4HB9cnQ=;
        b=t0jtBwdNGI+JzDymSbdF2uR0gKSWPqgNOIHJ0ya+tJVgmzJfrYH//lMnYID7AtamrWy8Fm
        PIFwIeDVnIodjQAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] trace: Add migrate-disabled counter to tracing output.
Message-ID: <20210907152414.cnkhciethhfuhv6e@linutronix.de>
References: <20210806164907.xtgvrb25eb4isxhd@linutronix.de>
 <20210806135124.1279fc94@oasis.local.home>
 <20210810132625.ylssabmsrkygokuv@linutronix.de>
 <20210903194216.1392b62e@gandalf.local.home>
 <20210906081343.klxtb652s5aphg4z@linutronix.de>
 <20210907112128.7e670ad7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210907112128.7e670ad7@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-07 11:21:28 [-0400], Steven Rostedt wrote:
> Right. It will break filtering, and I don't see a good way to handle that.
> 
> That said, I'll update the code to handle comparing fields with a mask.
> I'll need to do this with the kernel as well.
> 
> I'm fine with breaking the filtering on preempt_count over having it just
> fail to print it at all.

This was my only concern and if it does not matter even better ;)
Thank you.

> -- Steve

Sebastian
