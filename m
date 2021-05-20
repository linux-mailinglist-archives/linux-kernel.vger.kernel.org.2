Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7C638B90D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhETVkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhETVkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:40:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48215C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:38:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c15so21580839ljr.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goseYwTkzgMm+FX+KCZopTYXh0tzEbkX4x36YfbUrsw=;
        b=EC5etK9i7fAPFZR2RrpV8bzGlnP0ytGmzkd7hkYjxPqb1E/JJAtuQXFeMofPFRcDHW
         TPq5jkxO+jZnj7CC1E/kNocAD+1S0fRowDF0LOnTYbhWVPj7S/wIHTf5MfZSrbMqb+8p
         4qoW9Fdgfss9Ruo6qfzHavqNe3aOeNjWyvu97aGzHVeVaIETa/yJYwkx7Qfahm1KLOes
         NAUoGN1pybuE2UD7uuvQg6kQSxAUZ15V/0yAF8iqs/0ntH2olPZfBXvvzNhuPw8d4LD5
         NWHpRb5OLMzCj8bb0YO1Wg8JXFcYByxSxl/kQDPA12IilD+EdlLjl9qL1m5nwLQEDAgJ
         8gPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goseYwTkzgMm+FX+KCZopTYXh0tzEbkX4x36YfbUrsw=;
        b=qNW0ZFaBBLAJ1U4qyGOVl0UvwxS9NTenMb2WdyZ6Qo2Y6Hr9dJ+FNayVxD3k7nP9x1
         8YwGdPUq43S6Wl7IgqGsRricAvTZfnnG3xsJz+7GfkH0xpDIOEhfHUlJldRWmd6er6vF
         YDNlQYT82bPjurntIe2++aMkJSz6udRzpfXF0BNRarTUqSZn4cW0gc1+H6wECVokAcrs
         xnu9SWatPjOEgQo24B/G4E0A3Zke7n+SV9m+15LgNcBOlhJpQctejdA6NnuzAcfWuqml
         XG9YqMRPwt3Vpdr2viqbiB3Bc1iTJH/i0LwT8oKsfmYI3axdTUeQWbC6PLGYLp8f4bTR
         Yv8g==
X-Gm-Message-State: AOAM5335Zi8hUoBZVy+amST6+rQH+IJA/ZYYp60r0SPUwy2oP5I+1Jnh
        0PS1flSXK47EPziO+JfSDBx6uUu7CsEN47FwZIv5Bw==
X-Google-Smtp-Source: ABdhPJzwMrDBwob6pN+S2ilFdQh5N8EphMYiUtNUox7/axVceZ5jIphVm7b3994vHgkqA+TwbzuLpeYT6O39l9e/IaM=
X-Received: by 2002:a2e:a54d:: with SMTP id e13mr2982312ljn.266.1621546725312;
 Thu, 20 May 2021 14:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com> <87mtspm7fe.fsf@meer.lwn.net>
In-Reply-To: <87mtspm7fe.fsf@meer.lwn.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Thu, 20 May 2021 14:38:33 -0700
Message-ID: <CAPNVh5eV+CtY74_JMv6_Bm5aCVBh_F9hkWLT6v3BT=H0UwodUg@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 2:17 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Peter Oskolkov <posk@google.com> writes:
>
> > As indicated earlier in the FUTEX_SWAP patchset:
> >
> > https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/
> >
> > "Google Fibers" is a userspace scheduling framework
> > used widely and successfully at Google to improve in-process workload
> > isolation and response latencies. We are working on open-sourcing
> > this framework, and UMCG (User-Managed Concurrency Groups) kernel
> > patches are intended as the foundation of this.
>
> So I have to ask...is there *any* documentation out there on what this
> is and how people are supposed to use it?  Shockingly, typing "Google
> fibers" into Google leads to a less than fully joyful outcome...  This
> won't be easy for anybody to review if they have to start by
> reverse-engineering what it's supposed to do.

Hi Jonathan,

There is this Linux Plumbers video: https://www.youtube.com/watch?v=KXuZi9aeGTw
And the pdf: http://pdxplumbers.osuosl.org/2013/ocw//system/presentations/1653/original/LPC%20-%20User%20Threading.pdf

I did not reference them in the patchset because links to sites other
than kernel.org are strongly discouraged... I will definitely add a
documentation patch.

Feel free to reach out to me directly or through this LKML thread if
you have any questions.

Do you think a documentation patch would be useful at this point, as
opposed to a free-form email discussion?

Thanks,
Peter

>
> Thanks,
>
> jon
