Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B913AD3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhFRUnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:43:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58918 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhFRUnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:43:12 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624048861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d9IbksiglimKBYfN8tOs1altlZW32anj2J1cQ5JfUj4=;
        b=GJ3sVXeGuq+NKBiJsqn2WLtruQiQFBF8aJJkFlkAqrkLWa23Up6IMPCly2kVS1hbYLo+U8
        oEcqwW5iGlQNy8epa47Kv5XqlHqzlYFXylMRhljg1vm29yHvnK6jqUA3KagPnAwyh8Jttw
        /DlcH4+V8mAymqvreEdyM+6jbASJbSGgjte7FUOMGRTtiFgjeIwgSDXILvRhLqc/RsRSkC
        a80ahHgjbS+dmSVuguBUysRBx7HCKYohwCMnskh5eZkYUzJWHjIxudQqTpFmS4AINNjdXj
        nlSNOVBn6flycekK7y0ZrYue8tZm8TtIu6LCG6D0rmx0tw5FEir9cgaXtfw4UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624048861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d9IbksiglimKBYfN8tOs1altlZW32anj2J1cQ5JfUj4=;
        b=9/hc8xd0zVG6CdsTpmir2UdymVmqN3/kHoyI1reQ1jNf8x1MhLR3nu5GjlXKL/JvBSAur4
        7B7Lms5+U0uzu5Cw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrew Cooper <amc96@cam.ac.uk>
Subject: Re: [patch V3 02/66] x86/fpu: Make init_fpstate correct with optimized XSAVE
In-Reply-To: <20210618143444.587311343@linutronix.de>
References: <20210618141823.161158090@linutronix.de> <20210618143444.587311343@linutronix.de>
Date:   Fri, 18 Jun 2021 22:41:01 +0200
Message-ID: <87v96aewiq.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew!

On Fri, Jun 18 2021 at 16:18, Thomas Gleixner wrote:
>
> Fixes: 6bad06b76892 ("x86, xsave: Use xsaveopt in context-switch path when supported")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Doh, I wanted to add Borislav's R-B tag and either my brain tricked me
because I was staring at this way too long or my tired finger memory
ended up using the wrong shortcut. So this should obviously be:

  Reviewed-by: Borislav Petkov <bp@suse.de>

Thanks for spotting this.

       tglx

