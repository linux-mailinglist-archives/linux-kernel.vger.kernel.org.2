Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3A4362A89
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344529AbhDPVpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbhDPVp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:45:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9E6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:45:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618609498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uX8x0qlHjq8ARaOYNBcOux4kil9K4/exMGWuX+C6sL8=;
        b=VKbRPrheNtuX3dI1bEisaQvqtCV8+3F5wuKOQ08NMeXkh+wReZE6Y0yj1gdXclHqr+gKye
        2ESiUvJoApKijmyjdkaJBAVesE78oDpto8FRBcOE++lDP7DB5dORpg/jQ4n1kqBX2uGRM3
        P/+GEsl99ob3twts4AUHjvKb03qJaA0ljz3+cukzDGbR1I7DhVRLatNcvTMNofLTJQbc+w
        LflEXSDV1iMimTghbpaIL5VTi1X5boDDFei+0nmucuGExEkku6UovxYwxEpeVwDqIKpN4C
        8kUWA+0aZ/nidqlp8jbucyCBDff80lcRs/UElTl0mDDpAZrJ/rX7qyauiHHOww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618609498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uX8x0qlHjq8ARaOYNBcOux4kil9K4/exMGWuX+C6sL8=;
        b=pZF0xV0/myJGF+9U+SPhNp2tqx4zzmCD32pifBAlK7TJRtjXC7W3xxYb0fk5C9DPCVlRpm
        euYsRZ65M96CQzAg==
To:     Mike Galbraith <efault@gmx.de>, Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, DaveYoung <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] x86/crash: fix crash_setup_memmap_entries() out-of-bounds access
In-Reply-To: <7826c19ecd583700f56d2db33360e8032e812ecf.camel@gmx.de>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de> <20210416110701.GA3835@dhcp-128-65.nay.redhat.com> <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de> <20210416114708.GB79779@dhcp-128-65.nay.redhat.com> <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de> <20210416121636.GA22348@zn.tnic> <a853ea8535151fd8b267d8e68a45b33748978d8a.camel@gmx.de> <20210416144459.GB22348@zn.tnic> <7826c19ecd583700f56d2db33360e8032e812ecf.camel@gmx.de>
Date:   Fri, 16 Apr 2021 23:44:58 +0200
Message-ID: <87sg3puco5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16 2021 at 17:13, Mike Galbraith wrote:
> On Fri, 2021-04-16 at 16:44 +0200, Borislav Petkov wrote:
>> On Fri, Apr 16, 2021 at 03:16:07PM +0200, Mike Galbraith wrote:
>> > On Fri, 2021-04-16 at 14:16 +0200, Borislav Petkov wrote:
>> > >
>> > > Please be more verbose and structure your commit message like this:
>> >
>> > Hrmph, I thought it was too verbose for dinky one-liner if anything.
>>
>> Please look at how other commit messages in tip have free text - not
>> only tools output.
>>
>> Also, this looks like a fix for some previous commit. Please dig out
>> which commit introduced the issue and put its commit ID in a Fixes: tag
>> above your S-o-B.
>>
>> If you don't have time or desire to do that, you can say so and I'll do
>> it myself when I get a chance.
>
> Ok, bin it for the nonce.

Can all of you involved stop this sandpit fight and do something useful
to fix that obvious bug already?

OMG


