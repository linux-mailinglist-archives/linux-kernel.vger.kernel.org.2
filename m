Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01517363893
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 01:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhDRXoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 19:44:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhDRXoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 19:44:44 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618789454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wgVscjmRkejG9o0RpwH58wcnPRSJ6kzfnrbcbAA0W4=;
        b=HCIPyJ69SDdjztIiFFBnfSrXtA479pGl+36lBPjlGdWLZACz6026nJauoFbNJhzUNq8iQf
        112lwZqJcJwhyPvHtqq0TbpPrLRbbpBz64XFl7WJKdL97hkt5a7p1OVeWC5GBImbiEQfA2
        ucEG2pFCj+2tqEna1/QUY6OynHa4fNvrUBpPnELXAPuH4F7pRpCxu3qsDlluSoMtC1Pjk5
        AnYiwMpFAKQH7iN3m1ZQ/jJ87KxOp6JmeMJdqf3tVl3tFKwWjtEyiqsUu28G9qOGKncZAI
        VaSgO+CHEqNKMft7iFKrldhcPFAuySnxC0nZuSGcY9E/58fnjrQXe+UP037Amw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618789454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wgVscjmRkejG9o0RpwH58wcnPRSJ6kzfnrbcbAA0W4=;
        b=Lh7nZcpvH8k1Y2ScgqyPfRLBDMWJPvEe89TjuhWrNX3Oz59s+cP2ESFA6mIg6i57hKdqDb
        CuXC/yTN14QlBODw==
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] genirq/irqaction: Move dev_id and percpu_dev_id in a union
In-Reply-To: <20210410120008.3034091-1-maz@kernel.org>
References: <20210410120008.3034091-1-maz@kernel.org>
Date:   Mon, 19 Apr 2021 01:44:14 +0200
Message-ID: <87y2dfqhtd.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10 2021 at 13:00, Marc Zyngier wrote:
> dev_id and percpu_dev_id are mutually exclusive in struct irqaction,
> as they conceptually represent the same thing, only in a per-cpu
> fashion.
>
> Move them into an anonymous union, saving a few bytes on the way.

The reason why they are not in an anomymous union is that any misuse of
interfaces will result in an instantaneous explosion while with your
variant it will cause hard to diagnose side effects.

I rather waste the extra 4/8 bytes unless there is a compelling reason
not to do so.

Thanks,

        tglx
