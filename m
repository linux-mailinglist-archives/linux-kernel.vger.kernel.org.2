Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D522443A49B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhJYU1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbhJYU1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:27:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8776C053A6D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:15:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635192904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/OIggvsO5RpOUZVeKcl5+bBrSQ2QmtpTw90r5Hq2js=;
        b=vKXOc1yzBx41QEz5yN+TgX//S1AbXNLtLvB+esChHKc6gPR5+4qh3VUgNCC5IZDTzqWDgN
        GBPC02eQO7mf04z4P2caSaTWUJvGlF0w3dzJXnAykcfTRvlcNI/x6yf8Tx+RZcpy8NYTgx
        L+RuRA6Dpo9W7qZusYoxMFSJpdF2qOeH7+eLaYJmyEeQ1uUI0+4Wy2jX9EcpnZSRAFvCB1
        AFCBONoJGzz99fEG5xwufrTYi36M+yA8Y86uji2/f7ks6wXlX9yRkU+k1cB0L/KWrhQrP4
        FHy2Yv2a2eL6s9+FZwRG1L/LzkVGaaGzD63uZB6XgEIEYQtvH9LJ2XSCVZG4hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635192904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/OIggvsO5RpOUZVeKcl5+bBrSQ2QmtpTw90r5Hq2js=;
        b=IkbjKOWC6Y5ehEoIIYLJGU9yvPFq0DmkmW2pMke5Akrk5vo4gUyVBwdIjAyBQ0ayGtqkXd
        JVVMv8zy1XYjN1Cw==
To:     Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com, arjan@linux.intel.com,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH 15/23] x86/fpu: Add sanity checks for XFD
In-Reply-To: <YXZmqF3KlHZBrdgn@zn.tnic>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
 <20211021225527.10184-16-chang.seok.bae@intel.com>
 <YXZmqF3KlHZBrdgn@zn.tnic>
Date:   Mon, 25 Oct 2021 22:15:03 +0200
Message-ID: <87lf2gg8u0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25 2021 at 10:11, Borislav Petkov wrote:

> On Thu, Oct 21, 2021 at 03:55:19PM -0700, Chang S. Bae wrote:
>> @@ -217,12 +240,15 @@ static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64
>>   * Restore xstate from kernel space xsave area, return an error code instead of
>>   * an exception.
>>   */
>> -static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
>> +static inline int os_xrstor_safe(struct fpstate *fpstate, u64 mask)
>>  {
>> +	struct xregs_state *xstate = &fpstate->regs.xsave;
>>  	u32 lmask = mask;
>>  	u32 hmask = mask >> 32;
>>  	int err;
>>  
>> +	/* Must enforce XFD update here */
>> +
>
> <--- something's missing here?

That comment is replaced in the next patch which adds the actual XFD
update. I added it as a reminder. Could probably go away.

Thanks,

        tglx
