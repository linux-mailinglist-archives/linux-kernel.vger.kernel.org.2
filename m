Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068493A728B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 01:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhFNXig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 19:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhFNXif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 19:38:35 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4FBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 16:36:18 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q16so14248046qkm.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 16:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzJYum4jPDYdUZOzxiE2EDYoA//UFqDYCYrMpSJjOzc=;
        b=J4coD/Yq3Y+IWgXlsye2jcl1NSGH//FV5ng79LOcvQO18tNKoWLiXcbslqFwjaJLuZ
         HKVIz8wuW2qkYevTBXTtBvxOGUT4MGiGBfw8WfQFYDyiRStW8P9OnseLP4+gU/NiLKLS
         AaOCj2p3HzGDOnFcKOCNiWhgo4b5HT5uTGUJmfo2w4fstlkYdnJTqIX/RJtWmuabYBEY
         gw8YBCQZqBIFrf1S8STV25xmozk1W6CGzvyP3nWcpv4mvUUWudj0BKjDDVUwQ7dxeRG/
         i0ZVNQkYkIS4EskS2lifvpKtZbZYspufOcVBiLnsxyO/VNAxD+z4WkWoj+ScPHQrdFiC
         tnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzJYum4jPDYdUZOzxiE2EDYoA//UFqDYCYrMpSJjOzc=;
        b=TYKLV9MkEuoCQ/v2ax22tqMiYq1OMid4INLEm4cA2AHJA4DKHgNLXx/rpPMXgITk+7
         Q69DgFZqr+hrfnSvOU8p6ToHvC3IJ+rOGdCXq/iF2xOr5R95k/NMFWCeGH6NZFzWIgvm
         0JOBDfBugjGFLkCyS7Lf31mxKiX95jB164JxfLl3o2m4/4z53yZPyfWRaahzpsFvedg6
         IOF1PuVEXEq9Mu4UPBQsRJnZKYZm3WIpDRenvMlB8id6TPIjNggNHeLixSdV1UBFPU9N
         s2yTf5gP6WypknKq/kW7Yj1S1A5cZhioiqe5pSkolrz2/HkNtKPASfD82zP8SZaMe3U2
         L/8g==
X-Gm-Message-State: AOAM533wNBhXVAwk0/Fg4T/jSBhxhVcahdG3BZ0NPWW5qrETyqoyVS5J
        +sHodxEvy41mBXg3zBBHqlOf488h5hR5XTWViVu7cA==
X-Google-Smtp-Source: ABdhPJzHAtJv0exi/Hya7peRe/J8A+9ovUirjHPA6xZwwO4/jwWy8tb7RSIWJAMy54GQ//vqPC99EkkUlU5U4/Voa18=
X-Received: by 2002:a37:c58:: with SMTP id 85mr18364587qkm.276.1623713777603;
 Mon, 14 Jun 2021 16:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123309.039845339@infradead.org>
In-Reply-To: <20210422123309.039845339@infradead.org>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 14 Jun 2021 16:36:06 -0700
Message-ID: <CABk29NtA4UxM-XqJ0v+5UOZEfgHTozF5VeqVGpLcR3Ci4z806g@mail.gmail.com>
Subject: Re: [PATCH 18/19] sched: prctl() core-scheduling interface
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Xiangling Kong <xiangling@google.com>,
        Benjamin Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 5:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> From: Chris Hyser <chris.hyser@oracle.com>
>
> This patch provides support for setting and copying core scheduling
> 'task cookies' between threads (PID), processes (TGID), and process
> groups (PGID).

[snip]

Internally, we have lots of trusted processes that don't have a
security need for coresched cookies. However, these processes could
still decide to create cookies for themselves, which will degrade
machine capacity and performance for other jobs on the machine.

Any thoughts on whether it would be desirable to have the ability to
restrict use of SCHED_CORE_CREATE? Perhaps a new SCHED_CORE capability
would be appropriate?

- Josh
