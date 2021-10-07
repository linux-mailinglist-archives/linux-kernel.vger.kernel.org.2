Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252914254FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241942AbhJGOGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241947AbhJGOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:06:15 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250DFC061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 07:04:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i84so13583254ybc.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+QZvDwemsFFIczEEWYwfhVIIBD8PeDyHFieg5RXpUw=;
        b=lLc72o7s2z0McMBJd5JqBA1t6N9i4TsKLEJJitVTE6pmNOc6bDRxOvwjp0dJ8B+TxW
         Hd2WEtShpX8Tzx7WEd27WXxhTdZOR6yE2wbV/gFQB7I9BauB+2I+8OVbQP/EWN0K3xJB
         QqIPvW7MJpFGOaZYaGRqpv492JdLth7XhR1FgPwh8nFBB1mDowvR9WN56PwDZaN2Lj9b
         cMMrxQ00KQuTG584aqunF2JgpK8ZTCQpITSOTjdlTPEsy5I+l8JdlfBaVnafRQDnRR/j
         VozoQ3P8GGWiPMFtt1Otjd6TMgUuoht399nU/P7RdSA+nWCUu7Y6x/jLFfdiDNuaYrBQ
         UXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+QZvDwemsFFIczEEWYwfhVIIBD8PeDyHFieg5RXpUw=;
        b=1AvEZZKlW5tOhyfQ+jw9RVvcWIQ/jxTg2HutWZB3LztHI5zorDXPEYOsyOGCQ6LcM0
         sHkzNxTM5dD1iIK0f5YQWLT5U5Ti6CwMpgd/bq/A3Vu353jZPMnXXdGqohyqc8K/9wHg
         NCoUOnQphHPPl7aCule9K0PIB4cEzCzhFTwIt+zqf6NIOfIJwo17OgSUvk8qMc9SBZWS
         XI8RrSLl3+W/bf3vO9Y2Sbg6lNC796dpJOFIbRV4Kcv/zGCRnUi08Y9ZB9mMV3oZK74z
         F+YptnVypfGVkRJLu4lZSzY/EYtw5QWSUwSm2U08TJwTnLeY/9WlTu/ZRGQKeBZNOS6J
         8Whg==
X-Gm-Message-State: AOAM5315SZFZXRBjriC3MXEeOLR4pwEcxF4REuq5S68N9aql+x74j9x5
        YcddzSpaErF8PUrohQwhhdc6Fad5Yhz5I9tr8vR8FP76Z4k=
X-Google-Smtp-Source: ABdhPJxXJG5X/OkNue0yZkUB1yIFkaX9oe+9/9KMn1SAqXSnk+VMvqxx+vmGdIa2vdFK40GKF9Ss0Ioj9xHN4rkzDVc=
X-Received: by 2002:a25:dd46:: with SMTP id u67mr5308520ybg.295.1633615460464;
 Thu, 07 Oct 2021 07:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211007031756.345269-1-eric.dumazet@gmail.com> <20211007072917.GN174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211007072917.GN174703@worktop.programming.kicks-ass.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Oct 2021 07:04:09 -0700
Message-ID: <CANn89iKOa+tqerm80vHvHEurc2UxTq_heQuOUE0KnVuJht8AKA@mail.gmail.com>
Subject: Re: [PATCH] x86/apic: reduce cache line misses in __x2apic_send_IPI_mask()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 12:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 06, 2021 at 08:17:56PM -0700, Eric Dumazet wrote:
> > +/* __x2apic_send_IPI_mask() possibly needs to read
> > + * x86_cpu_to_logical_apicid for all online cpus in a sequential way.
> > + * Using per cpu variable would cost one cache line per cpu.
> > + */
>
> Broken comment style..

I was not sure and ran checkpatch.pl before submission, but sure.

>
> > +static u32 x86_cpu_to_logical_apicid[NR_CPUS] __read_mostly;
>
> NR_CPUS is really sad, could this at all be dynamically allocated? Say
> in x2apic_cluster_probe() ?

Good idea, I will try this.
Hopefully nr_cpu_ids is populated there ?

>
>
> Otherwise this looks very nice!

Thanks !
