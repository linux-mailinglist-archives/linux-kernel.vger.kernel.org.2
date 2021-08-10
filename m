Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EB83E5C66
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhHJN7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:59:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43572 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhHJN7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:59:35 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628603951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SEk59/13X9MwRECexYUk5FVIksWsmStm9Je3MwyUiKE=;
        b=o6jDmzzhOhwQDmXCyega4hubfNuITIhRVr+YPeMtyGih9hshncqdrd583aLVtwspPDxKvJ
        5WcJs7WRm4p+goiSqajdUvKI8MOoTV+gREbPrMtP1PCUzPqwcS5XQF0+F4ZJzV3gm0ynTJ
        RyduiU8RuD1ctdPXAWJXg/ZTtWxiVk1R1bS91F7FjOHGYAEjACjgufvmd+iDlvS5kFXaOY
        AmjYRp2EZYOkrhWQAD/No2cJLsX63eCKfzoqiKcLAV1F6FJyi344V+qUBlCuba3Wl1glIp
        eUX/C5t+MblzNHbungG0YVQpr0a2q+SYPnciPtn7pAvlEWHPGEmaNoxGmVayvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628603951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SEk59/13X9MwRECexYUk5FVIksWsmStm9Je3MwyUiKE=;
        b=zosrRjw9/dIi7ykVbpfjdACg0YhGQTK3r7hUUpEogoxXOOwXSOS0owyKMOM0hanmtGob2h
        71rE9+1u3HcwXOAw==
To:     Kees Cook <keescook@chromium.org>,
        Yejune Deng <yejune.deng@gmail.com>
Cc:     peterz@infradead.org, frederic@kernel.org, mingo@kernel.org,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Yejune Deng <yejunedeng@gmail.com>
Subject: Re: [PATCH] softirq: Remove the unnecessary CONFIG_TRACE_IRQFLAGS
In-Reply-To: <202106021051.0AF942F9@keescook>
References: <1622619282-12077-1-git-send-email-yejunedeng@gmail.com>
 <202106021051.0AF942F9@keescook>
Date:   Tue, 10 Aug 2021 15:59:10 +0200
Message-ID: <877dgts8nl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02 2021 at 10:53, Kees Cook wrote:
> On Wed, Jun 02, 2021 at 03:34:42PM +0800, Yejune Deng wrote:
>> The local_irq_enable() and local_irq_disable() had two definitions that
>> include CONFIG_TRACE_IRQFLAGS or not.
>
> Hm, this has a behavioral change. Current code only does tracing and
> raw_local_irq_disable/enable when CONFIG_TRACE_IRQFLAGS. This change
> causes it to always do raw_local_irq_disable/enable. Which is the right
> behavior?

Disabling interrupts is only required when CONFIG_TRACE_IRQFLAGS=y. So
the code is correct as is.

Thanks,

        tglx
