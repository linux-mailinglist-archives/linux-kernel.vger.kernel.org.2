Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C564C35A070
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhDIN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbhDIN5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:57:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D61C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 06:57:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617976648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2zIDm7nK+W4A1wDlcD9qfBdKn49IbGZJiECKP2XiQo=;
        b=RbN2dImCEvz2NcS+8IWtoahnQEvWMKCo0zXlHoAgOADQWl2ZOTbFu6NDwsXPllySQYXRgU
        Tazwr+b5AyJ29cBb+og4BAsXziSn55IgBQw4n9EMMjTUbzIjIps9eMrU7GLmTBsa3PbPxz
        G7s9MgI575kcHrlE6OLC0U9yhHb4rXWZgpZHoIK9idGmGM3+JiJ+SGdvQX+kLuE45mUy/k
        tiuC4rxUEbA6ZcFgginG3SUwU3TInJkEudR2ljctRIKFDXqO9ags6bwn6/m9w8H4BGhs2M
        xfhDH/aOI4kk29hSFHoOlMsFqOZg5lCpkBVY+wsTP0r4O9xki7Wtnox2zlTDkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617976648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2zIDm7nK+W4A1wDlcD9qfBdKn49IbGZJiECKP2XiQo=;
        b=2TXilVl0j5E/8WAtPlk3JYZv0rr6u0nPlkvWKMU6bYG3hSBUMVXkTEVsg9CmwHOJvxonFz
        q/n65K09pU1mRFAg==
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH 06/10] genirq: Don't mask IRQ within flow handler if IRQ is flow-masked
In-Reply-To: <20210408154326.3988781-7-valentin.schneider@arm.com>
References: <20210408154326.3988781-1-valentin.schneider@arm.com> <20210408154326.3988781-7-valentin.schneider@arm.com>
Date:   Fri, 09 Apr 2021 15:57:28 +0200
Message-ID: <87sg3z4l2v.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08 2021 at 16:43, Valentin Schneider wrote:
> +	/*
> +	 * Masking is required if IRQ is ONESHOT and we can't rely on the
> +	 * flow-masking persisting down to irq_finalize_oneshot()
> +	 * (in the IRQ thread).
> +	 */
> +	if ((desc->istate & IRQS_ONESHOT) &&
> +	    (!(chip->flags & IRQCHIP_AUTOMASKS_FLOW) ||
> +	     !(chip->flags & IRQCHIP_EOI_THREADED)))

#define XXXX (IRQCHIP_AUTOMASKS_FLOW | IRQCHIP_EOI_THREADED)

        ((chip->flags & XXXX) != XXXX)

Hmm?

Thanks,

        tglx
