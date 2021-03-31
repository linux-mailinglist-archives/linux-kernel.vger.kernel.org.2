Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6192334FB30
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhCaIHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhCaIG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:06:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 01:06:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617178018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WLglFDK/erfIgGVGC1sqtTmnJNmaibFNYmNaVl8FDYQ=;
        b=gjAO6Q+N/6DSmnRVGirnEHHbt07VuJojBLVQ/iIADbpgnvCZ93VZ1AvWcR3UAsfknq7vOd
        iZCMPamkX467Oo4o0FTktv8dZpBsrBBF38BzU2Eo3VnKevjI/44ZgIRqaMYUoyDbPXihFj
        AhUJFmWXK/lBZeXzzh6DZgT0Bbn9NoeCOTe3NdxtOecM73nBhvJvv5qUfBJQv65VyBX4bA
        LLti3nVBf+n8dz0u5KT5+VZ+zdObsic1nDuCyb0UdxqJbyZWOD0lFJrMp7xDbagMfXiIMM
        7biSmmQ/sxiu1+eUOhGVvlSqnHByCwHs5FT0dUdyVjAtNv8U1CTssmNOyFCS5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617178018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WLglFDK/erfIgGVGC1sqtTmnJNmaibFNYmNaVl8FDYQ=;
        b=YLKk5XAITZPUGFM6aX5t8A1a0Kb3FH0JATaf8rv9UXdG9zyfKq2aMlG2iDhz/Q/NWIlkGE
        HAb0iniCRbuyPeDw==
To:     Jindong Yue <jindong.yue@nxp.com>, fweisbec@gmail.com,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, jindong.yue@nxp.com
Subject: Re: [PATCH v2] tick/broadcast: Allow later registered device enter oneshot mode
In-Reply-To: <20210331011045.25381-1-jindong.yue@nxp.com>
References: <20210331011045.25381-1-jindong.yue@nxp.com>
Date:   Wed, 31 Mar 2021 10:06:57 +0200
Message-ID: <87ft0b6926.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31 2021 at 09:10, Jindong Yue wrote:
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -47,6 +47,7 @@ static inline void tick_resume_broadcast_oneshot(struct clock_event_device *bc)
>  static inline void tick_broadcast_oneshot_offline(unsigned int cpu) { }
>  # endif
>  #endif
> +static void tick_handle_oneshot_broadcast(struct clock_event_device *dev);

Leftover ...
  
>  /*
>   * Debugging: see timer_list.c
> @@ -107,6 +108,19 @@ void tick_install_broadcast_device(struct clock_event_device *dev)
>  	tick_broadcast_device.evtdev = dev;
>  	if (!cpumask_empty(tick_broadcast_mask))
>  		tick_broadcast_start_periodic(dev);
> +
> +	if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
> +		return;
> +
> +	/*
> +	 * If system already runs in oneshot mode, switch new registered

the system .... the newly registered

> +	 * broadcast device to oneshot mode explicitly if possiable.

s/possible/possiable/

But the 'if possible' makes no sense here. The above check for
CLOCK_EVT_FEAT_ONESHOT established that it _is_ possible. So just remove
the 'if ...'.

> +	 */
> +	if (tick_broadcast_oneshot_active()) {
> +		tick_broadcast_switch_to_oneshot();
> +		return;
> +	}

Thanks,

        tglx
