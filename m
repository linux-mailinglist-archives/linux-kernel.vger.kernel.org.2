Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF693EA5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbhHLNrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:47:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58652 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbhHLNrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:47:09 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628776002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YBQuqilT/XK1XXP5rChadBY0XWIQYySfdLub6I1T4o=;
        b=LFUyh8NNYOq7byxL6U/N8Cy32HL2bNVjPW+VAncHcwkosPi7Sgw5XLBIWpMV2iWQtnivlC
        pTfSgj/mOXa5TtdyJa1B50dsgRYz110sS1Mwyge4QPH7evRN3/S1Si6NbBFA4fABOjxnfG
        KXK0ceBAIWnWBct8qZ5euLMFUunpDv/D9SiK5Aa5VPhl6V1Ye9pxszUlNrJzekRAeCS+dn
        nR0FhDmUPTNeXWe6bxNOp3lPz26TvRJprsHLEQDdbaYCrmGGmPh4sCj2JYF3JHNxtu4OdZ
        JKmp9ISwnIITWt9cw/eDUcPycm4FTbk6Hcs1d+a6qq2wHOrM2XUJ0KhT2RTzIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628776003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YBQuqilT/XK1XXP5rChadBY0XWIQYySfdLub6I1T4o=;
        b=bkgi/zt2YyrDJHuo8Wu9ol0MvbOIb1kq4QO83xaNDypVhWIOuqQCbjiIiQJsI+/rFGndN4
        VnTopUlfqbOp3CBw==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        kernel-team@fb.com, ak@linux.intel.com, rong.a.chen@intel.com,
        sboyd@kernel.org
Subject: Re: [GIT PULL clocksource] Clocksource watchdog commits for v5.15
In-Reply-To: <20210812000133.GA402890@paulmck-ThinkPad-P17-Gen-1>
References: <20210812000133.GA402890@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 12 Aug 2021 15:46:42 +0200
Message-ID: <87czqiixml.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11 2021 at 17:01, Paul E. McKenney wrote:
> This pull request contains a single change that prevents clocksource
> watchdog testing on systems with HZ < 100, thus preventing the integer
> underflow that can occur on leisurely HZed systems.  This has been
> posted to LKML:
>
> https://lore.kernel.org/lkml/20210721212755.GA2066078@paulmck-ThinkPad-P17-Gen-1/

So with HZ < 100 .mult overflows, but why not simply adjusting the
mult, shift value to be

      .mult	= TICK_NSEC,
      .shift	= 0,

which is effectively the same as

      .mult	= TICK_NSEC << 8,
      .shift	= 8,

Hmm?

Thanks,

        tglx
