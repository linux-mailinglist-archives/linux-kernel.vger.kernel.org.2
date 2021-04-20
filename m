Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF153653D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhDTIPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhDTIPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:15:46 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78ECC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:15:15 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q25so6276260iog.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTgcNVJK9mVrzDm2sPN3v+OzrqXCxv+kyGLvCj9swpQ=;
        b=c75FpBCdwj6gGxvbgYgFw71N8QyQmzVuJ2SN8jpBbtQiYGTQI1NrwVmFo/fH9JdhDn
         1iHu4pvbGKFkv7TwrP87gp56qxhCOC72YsDUeZQ0VURYRXU8iR980wAM4LLroj1SrYFm
         t5GDfkrhsBlqbIiZYCWE3+DpFPIIf81MilhfNyWQYjqxjXh6RXZt4fxn/i5eASJRVG9J
         bx8iibjlZkdwEZXfF5NIzZJWYIsobME9f3C75cNDQK1v/TdqFadj5pURWvMsxCAHjpPd
         Xn6ZoRi2HBZ3Jq7lj4jb1frwrHuttakf1rIUSO018sjamqcUO2/8k3Ifse8Y0qfRblUP
         pQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTgcNVJK9mVrzDm2sPN3v+OzrqXCxv+kyGLvCj9swpQ=;
        b=AW1Skqv8t9M6FhNAFe8w+1A939NHv4WV/o1VY8yywcgLeX1GxNFZ+cr3HN5lPhTJbp
         Tqf3IMi3FzbuB6qK7gwpdczgPPrpb6Z3yQgyb8scY/ESdQRJpEvqtwqs8aKQTHf2VJji
         av5Iixi0tuodlRgQ1HrcVNeabWFeEBJakhmbuJA9yeLrAFdiTF6OI2OqAi0xrkiAShoH
         R1uBJyNABBg3FlukrKQWR+L4t14zT0aA+2O+ehOlpUg7csie0oilnkxWKh4K1JgyceVA
         Ic/WjdTYXotuQGjl1basG2BRbezqyd7FCquOVpWi38A9VFOl3u+NNXSb/sV8i9mlDYEA
         LOJQ==
X-Gm-Message-State: AOAM530MqJF77QfJp+sysZshiqu1WiJr+w2ttfrqomWjNNpnpBa559zD
        HdOuUWgL5tYbFKFtkAzGBe29avRbNk5Ruqoa5SctBQ==
X-Google-Smtp-Source: ABdhPJwdjpK51l39+3IWqOTjkiaGqegS/NWcJ0R8BL9YXKaHzn2huscwk+d6n+954Tn8pAzBmZFEBfxdPBovdUjOz4k=
X-Received: by 2002:a5e:930d:: with SMTP id k13mr17875787iom.61.1618906515033;
 Tue, 20 Apr 2021 01:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com>
 <YHXRWoVIYLL4rYG9@kroah.com> <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com>
 <87r1jbv6jc.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87r1jbv6jc.ffs@nanos.tec.linutronix.de>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Tue, 20 Apr 2021 17:15:03 +0900
Message-ID: <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 1:47 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> Enable tracing and enable the following tracepoints:
> [...]

Sorry for the delay. I had to learn a bit about how to use the tracing
infrastructure. I don't know if I can post here, but to my untrained
eye, one big difference between the old (fast) code and the new (slow)
code is that the new code calls tick_program_event() much more. It
looks like that makes most of the difference.

With the old code, hrtimer_start_range_ns almost never calls
tick_program_event at all, but the new code seems to call it twice on
every timer update.
