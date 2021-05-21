Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177A638C75C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhEUNCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhEUNCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621602049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SP1j3lBexDWEssgurMXzVe6QbtETBwWqUZ3KB+CEW78=;
        b=LcPeGajnNGbSlDfLkngojnOh8Y3KQcRrV4OfSwh4eKwpUFcCTyWEOUZRJcoCLR7DgtQIV2
        wBHk4plCdpBABVxb6ZU+rnAQXtZafdV+rGYL6Aq66KjPN69LYch4p1/2FepIuejcStnNYJ
        +BsEymbaOk00m+CGdExcz5EUejkJgOc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-G1_aX_7nMbyO7vvxHB8Wgw-1; Fri, 21 May 2021 09:00:46 -0400
X-MC-Unique: G1_aX_7nMbyO7vvxHB8Wgw-1
Received: by mail-lf1-f70.google.com with SMTP id o4-20020a0565120524b02901fc3210717eso5139870lfc.19
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SP1j3lBexDWEssgurMXzVe6QbtETBwWqUZ3KB+CEW78=;
        b=g/7yoCoFG+UhIkY57+YGuOg0Cw9jCiBlOBt3qEKXC3O4Wjhrg9z32p5P0RQiNwtJXb
         SRIptTXTzNlzYQQGfrS4UIXW7KgdwGw3OfQGN0KbMVlSIvaQNOoncDReoFxio0h7uPYF
         pHR83Y8ZuYPu+Vbc445TwD4MySMG+xVGnurwCEWeIOUmhzNjDiGEOh86pcznCoPIesN6
         K8GdBNMJgztR1T5CgVr57mw7ZjNDoEkhG/1x7lUHECabUnWw1KhG+s286H1vg0AuTJke
         Dr+ctJ8JQlU9xn9Wo67tiRMDcj0xD1QtFRuO8sLXNOaROPwnHpUyS3aG3I8VlD6j+T0d
         /8Lw==
X-Gm-Message-State: AOAM530toWX4oTmOHO2OKu6U22/qdegcVVtktAN7Ka0mfPDONE+GIOSP
        x4m2AZv2yCYuEkw3qBfUhPXelrfbl/+P2OVhe18/yKJo0LRUd9mYLs/nUmcGGRncLX9AsLBzi6K
        svgJEBSrbbSwirV23XSMiwYqG
X-Received: by 2002:a2e:5842:: with SMTP id x2mr6722155ljd.228.1621602044866;
        Fri, 21 May 2021 06:00:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUAgJJeugJDvgzv58Unyyv+sMfrnrZRt7zMDFjI81QGSvDbxDDn0PxzWyb4Ax/MVpyYscj6A==
X-Received: by 2002:a2e:5842:: with SMTP id x2mr6722105ljd.228.1621602044422;
        Fri, 21 May 2021 06:00:44 -0700 (PDT)
Received: from x1.bristot.me (host-87-19-51-73.retail.telecomitalia.it. [87.19.51.73])
        by smtp.gmail.com with ESMTPSA id g4sm4024868edw.8.2021.05.21.06.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 06:00:44 -0700 (PDT)
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
To:     Will Deacon <will@kernel.org>, Juri Lelli <juri.lelli@redhat.com>
Cc:     Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
References: <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com> <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck> <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <20210520180138.GA10523@willie-the-truck>
 <YKdEX9uaQXy8g/S/@localhost.localdomain> <YKdsOBCjASzFSzLm@google.com>
 <YKdxxDfu81W28n1A@localhost.localdomain>
 <20210521103724.GA11680@willie-the-truck>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <b7182444-1385-214f-4526-6e83be3d7f02@redhat.com>
Date:   Fri, 21 May 2021 15:00:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210521103724.GA11680@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 12:37 PM, Will Deacon wrote:
> Interesting, thanks. Thinking about this some more, it strikes me that with
> these silly asymmetric systems there could be an interesting additional
> problem with hotplug and deadline tasks. Imagine the following sequence of
> events:
> 
>   1. All online CPUs are 32-bit-capable
>   2. sched_setattr() admits a 32-bit deadline task
>   3. A 64-bit-only CPU is onlined

At the point 3, the global scheduler assumption is broken. For instance, in a
system with four CPUs and five ready 32-bit-capable tasks, when the fifth CPU as
added, the working conserving rule is violated because the five highest priority
thread are not running (only four are) :-(.

So, at this point, for us to keep to the current behavior, the addition should
be.. blocked? :-((

>   4. Some of the 32-bit-capable CPUs are offlined

Assuming that point 3 does not exist (i.e., all CPUs are 32-bit-capable). At
this point, we will have an increase in the pressure on the 32-bit-capable CPUs.

This can also create bad effects for 64-bit tasks, as the "contended" 32-bit
tasks will still be "queued" in a future time where they were supposed to be
done (leaving time for the 64-bit tasks).

> I wonder if we can get into a situation where we think we have enough
> bandwidth available, but in reality the 32-bit task is in trouble because
> it can't make use of the 64-bit-only CPU.

I would have to think more, but there might be a case where this contended
32-bit tasks could cause deadline misses for the 64-bit too.

> If so, then it seems to me that admission control is really just
> "best-effort" for 32-bit deadline tasks on these systems because it's based
> on a snapshot in time of the available resources.

The admission test as is now is "best-effort" in the sense that it allows a
workload higher than it could handle (it is necessary, but not sufficient AC).
But it should not be considered "best-effort" because of violations in the
working conserving property as a result of arbitrary affinities among tasks.
Overall, we have been trying to close any "exception left" to this later case.

I know, it is a complex situation, I am just trying to illustrate our concerns,
because, in the near future we might have a scheduler that handles arbitrary
affinity correctly. But that might require us to stick to an AC. The AC is
something precious for us.

(yeah, SP would not face this problem... now that I made progress on RV I can
get back to it).

-- Daniel

