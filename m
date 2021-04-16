Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43078362317
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245189AbhDPOp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244889AbhDPOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:45:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9849C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:45:02 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cc5009814827a174df863.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c500:9814:827a:174d:f863])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07EF21EC0473;
        Fri, 16 Apr 2021 16:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618584301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LKBqGYoGPrRlQiKOuV0mFVnytcjL+i8Q5LZH5nwqGb4=;
        b=oNSQPL+rNbCFdlYngGelvJM1IvXo59ic+/xVwT03bAxaxek5K/EhSN0G/3NWDj5gFBQ07a
        STHSH8ZvJRH3aokV3+d8g4EMF80oSsg5zC/IvHpBddPGKX3pfCG8Eojpyrh09FKYm0KSw3
        PboXThsfp4b4VlRUQXdWFZecqdBY6m8=
Date:   Fri, 16 Apr 2021 16:44:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, DaveYoung <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] x86/crash: fix crash_setup_memmap_entries()
 out-of-bounds access
Message-ID: <20210416144459.GB22348@zn.tnic>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
 <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
 <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
 <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
 <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
 <20210416121636.GA22348@zn.tnic>
 <a853ea8535151fd8b267d8e68a45b33748978d8a.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a853ea8535151fd8b267d8e68a45b33748978d8a.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:16:07PM +0200, Mike Galbraith wrote:
> On Fri, 2021-04-16 at 14:16 +0200, Borislav Petkov wrote:
> >
> > Please be more verbose and structure your commit message like this:
> 
> Hrmph, I thought it was too verbose for dinky one-liner if anything. 

Please look at how other commit messages in tip have free text - not
only tools output.

Also, this looks like a fix for some previous commit. Please dig out
which commit introduced the issue and put its commit ID in a Fixes: tag
above your S-o-B.

If you don't have time or desire to do that, you can say so and I'll do
it myself when I get a chance.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
