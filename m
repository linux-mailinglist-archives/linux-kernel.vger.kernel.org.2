Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BB73A7E88
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFONCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:02:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45700 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhFONCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:02:06 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3FA91FD56;
        Tue, 15 Jun 2021 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623762001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2F28xEK3LuIA+IKQg5+F6rhmLDrEZhEdkQGf+P5sG8o=;
        b=S+k8Qy3DX7wo7Vo7JGFmrcjsuAi9K54Qv7xpMrPOgrwj+MpoAcWsGAhxhiL+rjEYC04fet
        cgv42Ohp5Fh+74kATFmxnea2bKrKey9jCvG70LEDx4cyUu++jVd7uLbalWQaPgG4ngCxIl
        ZMXJKv9mxdIXfUwmM+wQtsK0Ew4vbmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623762001;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2F28xEK3LuIA+IKQg5+F6rhmLDrEZhEdkQGf+P5sG8o=;
        b=ABBcFCD69IgrCxpLwWzxPPem7kxmonxc8NXmNo5eDdcaROyfIi57eqG97vzB9Jmeb1SxCa
        dc+lvvL7w+kcmNCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 90CB6118DD;
        Tue, 15 Jun 2021 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623762001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2F28xEK3LuIA+IKQg5+F6rhmLDrEZhEdkQGf+P5sG8o=;
        b=S+k8Qy3DX7wo7Vo7JGFmrcjsuAi9K54Qv7xpMrPOgrwj+MpoAcWsGAhxhiL+rjEYC04fet
        cgv42Ohp5Fh+74kATFmxnea2bKrKey9jCvG70LEDx4cyUu++jVd7uLbalWQaPgG4ngCxIl
        ZMXJKv9mxdIXfUwmM+wQtsK0Ew4vbmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623762001;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2F28xEK3LuIA+IKQg5+F6rhmLDrEZhEdkQGf+P5sG8o=;
        b=ABBcFCD69IgrCxpLwWzxPPem7kxmonxc8NXmNo5eDdcaROyfIi57eqG97vzB9Jmeb1SxCa
        dc+lvvL7w+kcmNCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id GKAyIlGkyGBWAQAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 15 Jun 2021 13:00:01 +0000
Date:   Tue, 15 Jun 2021 14:59:49 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V2 02/52] x86/fpu: Fix copy_xstate_to_kernel() gap
 handling
Message-ID: <YMikRd/nTEXqGwSd@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155353.825709513@linutronix.de>
 <YMiKC09GUaG5vZta@zn.tnic>
 <87tulzgur1.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tulzgur1.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 02:47:14PM +0200, Thomas Gleixner wrote:
> I'll never learn that. /me goes to write some elisp.

You could also say, this is a way to keep your reviewers awake. :-P

> Nah. The wonder of membug_write() is that it does not write behind the

membug - Freudian slip, yeah, I know which is the word you've been
writing the most, lately. :-P

> end of the buffer which is designed to allow partial reads w/o checking
> a gazillion times for return values etc.

Yeah, right. I'm just being overly paranoid here, as most of the time.

> The point is that this gives us the proper init.mxcsr value when SSE and
> YMM are not set.

Oh sure - what I mean is, this could be a simple assignment into those
mxcsr and mxcsr_mask things but if you add the whole conditional code
around it, it'll become hard to read too and it will be the only copy
which doesn't call copy_feature() and that would throw off people
looking for the same pattern of calling copy_feature() in that whole
function.

And the destination @to would need casting...

Fget about it. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
