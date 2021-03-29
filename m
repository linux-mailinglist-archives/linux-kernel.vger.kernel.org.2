Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500B634D97F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhC2VSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhC2VRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:17:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D039C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 14:17:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617052666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TQOBHBNHWs/ZyfokQYDMYWSiKIBj/rHEXaeDdO4aX8=;
        b=D8JL9f3Hwn+k8AMnHiEaYBAmMZ92q3rb6T40EmUKgFawPtTS4yqvdpeWUxagiNhdI4NzFb
        tgXwgbEUR8bdSJ5h3LjWj4PE6AEu7U19cdSD7Ne+YEqvaWw2Wu0T4dDmTHeQKSi7cXhqZ7
        lXkQJORLbFez//DMly0P8TCOuF4vxx0SQmjqES8ljqypXUXqx99lw/8goTccD6OD7Cm2xU
        /HcsRA8YJCzAiD3Grw1NhCCwm8qG38kFYVIehThhw25+3c1NRvC+/qak9WhwGuqd/VlGeS
        CES0AiTQtzN77V2HtzBcXkM3cKZ7jJLmRJ3drLdMtj8oYRXjhqiKMSGNAroqCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617052666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TQOBHBNHWs/ZyfokQYDMYWSiKIBj/rHEXaeDdO4aX8=;
        b=rDs4H3tCT/xbUAVbCSYCDuykq/Ao0xU7+CmI6n4/pR9C+2RXGZuFmICctid06O99flBuU4
        /bOHEpR+Aw01c1CQ==
To:     Jindong Yue <jindong.yue@nxp.com>
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@kernel.org
Subject: Re: [PATCH] tick/broadcast: Allow later probed device enter oneshot mode
In-Reply-To: <20210329052555.24487-1-jindong.yue@nxp.com>
References: <20210329052555.24487-1-jindong.yue@nxp.com>
Date:   Mon, 29 Mar 2021 23:17:46 +0200
Message-ID: <878s657j7p.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29 2021 at 13:25, Jindong Yue wrote:
 
>  /*
>   * Debugging: see timer_list.c
> @@ -115,8 +116,20 @@ void tick_install_broadcast_device(struct clock_event_device *dev)
>  	 * notification the systems stays stuck in periodic mode
>  	 * forever.
>  	 */
> -	if (dev->features & CLOCK_EVT_FEAT_ONESHOT)
> +	if (dev->features & CLOCK_EVT_FEAT_ONESHOT) {
>  		tick_clock_notify();

If the kernel runs in oneshot mode already, then calling
tick_clock_notify() does not make sense.

> +		/*
> +		 * If new broadcast device is installed after high resolution
> +		 * timers enabled, it can not switch to oneshot mode anymore.

This is not restricted to high resolution timers. The point is that
the mode is ONESHOT which might be either HIGHRES or NOHZ or both.

> +		 */
> +		if (tick_broadcast_oneshot_active() &&
> +		    dev->event_handler != tick_handle_oneshot_broadcast) {

How would that condition ever be false for a newly installed device?

> +			tick_broadcast_switch_to_oneshot();
> +		}

So what you really want is:

        if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
        	return;

        if (tick_broadcast_oneshot_active()) {
		tick_broadcast_switch_to_oneshot();
                return;
        }

        tick_clock_notify();

Thanks,

        tglx
