Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75904340E44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhCRTaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhCRT3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:29:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB570C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:29:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616095784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVJ9Dld13f6FI3wh1jGulwrBS6xukpnCOUr/a/7iTaQ=;
        b=Vmc3MjjkQiQW0mpNSYQbVLSkz8WTmuGzfDzqOc8DSG53llRzaI5LC+qlnwXD6HTvApWuM2
        Au9GAjSUDeAAbLgAaulM9vS/tPSmXqrjDQe3mL6NfIQnsfoQHxBDsjg2wBLcMt/Z1Vk3zA
        bxo7ZvyQ2bxJyjmreEfvBeRKwFy7fcknj03wvnqEDJkRbE3KlTlwLMBlR3Qzj/LYv9yMZF
        8KPRJljmW7cdRvGrvnWhHcbGu5AMasFu0yvNHlgnL4SP/P0UwC0MsIdRmFB8QFREV/GlKl
        l9p7qEKmsFsKqHIQWOgqA1lHluP5CZ71w72/9LYw79J8+qPKg6fSunXlP7qM1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616095784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVJ9Dld13f6FI3wh1jGulwrBS6xukpnCOUr/a/7iTaQ=;
        b=H8202jXGDVmu4j4eeE12duQ55LMPynCRgGcI3ur259XLqr8n/WnSgWZFRB33W6mPF3NaeF
        c4gn/Cv7LxHrFUCA==
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] genirq/matrix: WARN_ON_ONCE() when cm->allocated/m->total_allocated go negative
In-Reply-To: <87eegc7v0g.fsf@vitty.brq.redhat.com>
References: <20210219113101.967508-1-vkuznets@redhat.com> <20210219113101.967508-3-vkuznets@redhat.com> <87eegdy0qh.fsf@nanos.tec.linutronix.de> <87eegc7v0g.fsf@vitty.brq.redhat.com>
Date:   Thu, 18 Mar 2021 20:29:44 +0100
Message-ID: <87mtv06z13.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2021 at 08:58, Vitaly Kuznetsov wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> There is a way more useful way to handle this. In such a case the bit is
>> NOT set in the alloc map. So:
>>
>>     if (!WARN_ON_ONCE(test_and_clear_bit(bit, cm->alloc_map)))
>>     	   return;
>>
>> would have caught the problem at hand nicely and let the machine survive
>> while just throwing warns and continuing is broken to begin with.
>
> Thanks, I like the idea. I didn't do that probably because the problem
> which triggered me to write these patches wasn't fatal, it was just
> causing CPU0 offlining to fail.

Can you whip up a patch for that?

Thanks,

        tglx
