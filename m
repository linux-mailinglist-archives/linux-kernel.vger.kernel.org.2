Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E6138B0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbhETOEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 10:04:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47152 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243811AbhETOCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 10:02:07 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621519244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHRsTtM3vY7sbJIv2y/Np9gHHRhx4H2ZewXo37swilA=;
        b=BfW7a32wJe9st936eYtalBufaq+y5SRB7OkhLTh+0074hZFWM1kmgBa0WCsquRhY73beh0
        FxxngW3Et+INCWZKVkIpihlBjrVHfK1ulTOAZJQdaIbIa9OGiMmq6zG3QnMiz5nO+eq3cV
        VcgCb36fNasXGuAq9w0HSqvROkpFMbHPPfID6nEfBKQnsM6XLYGKagNej3G54fS84x+uSj
        VhdBQAzfpLmvyAyYOovZSqv5irw1CWviYjmaxzYytzZkqPhREu+9Ex3vAKdgKpVNIHQc6W
        zomYDEEAEuIY60s0qtwaO6r9FigleCY/dgwK0G5XQ3EC+oKmpJC6ma9gzMSsxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621519244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHRsTtM3vY7sbJIv2y/Np9gHHRhx4H2ZewXo37swilA=;
        b=xhHIu+Mz+337RguQFZowt0sCkFwU9C6rV0DXGMVeVMscHypwRnCGoO9uTDzWbcMmdhQCYt
        gGuFZlQJzGlik7CA==
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH v3 7/8] x86/irq: WARN_ONCE() if irq_move_cleanup is called on a pending interrupt
In-Reply-To: <20210519212154.511983-8-hpa@zytor.com>
References: <20210519212154.511983-1-hpa@zytor.com> <20210519212154.511983-8-hpa@zytor.com>
Date:   Thu, 20 May 2021 16:00:44 +0200
Message-ID: <87o8d5bj3n.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19 2021 at 14:21, H. Peter Anvin wrote:
> The current IRQ vector allocation code should be "clean" and never
> issue a IRQ_MOVE_CLEANUP_VECTOR IPI for an interrupt that could still
> be pending. This should make it possible to move it to the "normal"
> system IRQ vector range. This should probably be a three-step process:
>
> 1. Introduce this WARN_ONCE() on this event ever occurring.
> 2. Remove the self-IPI hack.
> 3. Move the IRQ_MOVE_CLEANUP_VECTOR to the sysvec range.

Second thoughts on this.

Despite having a halfways sane mechanism now, that warning still can be
triggered for remapped interrupts which can be moved from task context.

Interrupt is bound to CPU1 and moved to CPU2.

CPU0               CPU1                 CPU2            Device

set_affinity()     local_irq_disable()
                                                        Raise interrupt
                      -> pending in IRR                 on CPU1
  remap to CPU2
  (after this point all interrupts will go to CPU2)

                                                        Raise interrupt
                                                        on CPU2
                                        handle_irq()
                                        send_cleanup_ipi()

                   local_irq_enable()
                   handle_irq()
                   handle_cleanup_ipi()

Now if we move the cleanup vector up (higher priority) then CPU1 will
have:

                   local_irq_enable()
                   handle_cleanup_ipi()
                      WARN(irq set in IRR)

Unlikely but bound to happen.

Adding the WARN_ON() to the current code is harmless because it can't
trigger. Let me think some more about that.

Thanks,

        tglx

