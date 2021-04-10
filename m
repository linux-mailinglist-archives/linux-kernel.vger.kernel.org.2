Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7180535AC88
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhDJJsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhDJJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:48:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9EBC061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:47:57 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1aea004ff424aef8172112.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:ea00:4ff4:24ae:f817:2112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 39E911EC0409;
        Sat, 10 Apr 2021 11:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618048074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Tvf19OXUBXZlFKKnhTg3hQs3cfovqzCzgW+ka1x1V7A=;
        b=RtQILUdppQ3HWLrs1+lEOkyhYze2Gu6mUYmik1O3u8SXLUOecirHFe2r4o8IFrxeVMJ7HX
        ZCZgc0imZOjkRL8glZ2uTGJuiuq6XXnJ9PUO6LyzG5fouE9k0fjf72ONo6SyXTY4buPcrb
        IXXLv0qXb79VKueBdnsZgrG9ePl0wTQ=
Date:   Sat, 10 Apr 2021 11:47:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, len.brown@intel.com
Subject: Re: [RFC 1/2] x86/tsc: add a timer to make sure tsc_adjust is always
 checked
Message-ID: <20210410094752.GB21691@zn.tnic>
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
 <87y2dq32xc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2dq32xc.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 11:27:11AM +0200, Thomas Gleixner wrote:
> On Tue, Mar 30 2021 at 16:25, Feng Tang wrote:
> > Normally the tsc_sync will be checked every time system enters idle state,
> > but there is still caveat that a system won't enter idle, either because
> > it's too busy or configured purposely to not enter idle. Setup a periodic
> > timer to make sure the check is always on.
> 
> Bah. I really hate the fact that we don't have a knob to disable writes
> to the TSC/TSC_ADJUST msrs. That would spare this business alltogether.

We have the MSR filtering and I'd *love* to add those MSRs to a
permanent ban list of MSRs which will never ever be written to from
luserspace.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
