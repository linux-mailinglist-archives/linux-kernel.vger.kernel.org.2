Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE6733FA85
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCQVjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhCQVjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:39:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1175E64F17
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 21:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616017153;
        bh=VIMNcF6dOmgW2zs3po0Jqy5OCE8TvozkFRpvez7f7cg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LE0sFBzm2pFGpEeYIHfkNKt6447R41ZcaGkrtkTm6zspzHk0CZhNcI0F7rzhndFhZ
         cnjYbh9tU8nXfC3h41LJjVZGoISEX232YYOHaZMIAFJZ0+DRnHugDDhURqE2NRxWMT
         Y/EI0Kg6G3/iscelMhsEAMLJSLJhfh5n4yrBRKYh+BYHFlwkT3g8GBGxtYoyJp4EMb
         npZ5Fn7OhB0XFHL4HeLMdeVeThkq9HY8RtJUiRQW5MK89X4X65hCJXtv+IGSj84JP6
         GZ8zVeE8IT9PnACzGub7HUk09ozheJW0SGceLChIHBRywh4Wjq9o8a8aCmVE5oG9T3
         6+z6cdOn4ol/w==
Received: by mail-ot1-f47.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so3245772otn.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:39:13 -0700 (PDT)
X-Gm-Message-State: AOAM533IRI73Y8yKM2EGBEe8enowcOZyPqUNSKhdWeN1t09h7SaOrNPf
        uRQVnlFDOgFEVFPUeFs0mTC42uOrqbz0EutAfKk=
X-Google-Smtp-Source: ABdhPJytKoAhVAf7r4/6bYFXWR4ZQlWy/GBZaNRrasWFCYNNRqqIb9qcJQS3QriuHrJZ5a3Bk/HXs/edlbT+5OhxXZA=
X-Received: by 2002:a05:6830:14c1:: with SMTP id t1mr5015779otq.305.1616017152243;
 Wed, 17 Mar 2021 14:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <1615949121-70877-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <20210317083947.GD3881262@gmail.com> <20210317084132.GA378908@gmail.com>
 <CAK8P3a2qqWV3RGvb4ooiz4LS5GAKL0OHEiVtdgnHAgtmiRDSNA@mail.gmail.com> <20210317200529.GB3830960@gmail.com>
In-Reply-To: <20210317200529.GB3830960@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 17 Mar 2021 22:38:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2MQiqEkrfd+_gE_dbYHgGBb9JjuAW7RX=ySWUc084KGg@mail.gmail.com>
Message-ID: <CAK8P3a2MQiqEkrfd+_gE_dbYHgGBb9JjuAW7RX=ySWUc084KGg@mail.gmail.com>
Subject: Re: [PATCH] sched: replace if (cond) BUG() with BUG_ON()
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 9:05 PM Ingo Molnar <mingo@kernel.org> wrote:
> * Arnd Bergmann <arnd@kernel.org> wrote:
> > On Wed, Mar 17, 2021 at 9:45 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > > More importantly, we use this pattern when we don't want !CONFIG_BUG
> > > to remove the 'condition'.
> > >
> > > I.e. the "side effect" here is important scheduler logic. It must
> > > never be optimized out.
> >
> > This behavior for !CONFIG_BUG has changed a while ago, it is now safe
> > to rely on the side-effect of the BUG_ON() condition regardless of
> > CONFIG_BUG. When that option is disabled, running into the condition
> > just ends up in a "do {} while (1)" loop.
>
> Dunno, I still think it's not a particularly clean pattern to 'hide'
> significant side effects within a BUG_ON().

Fair enough. Readability really is the key here, and I agree the current
version is easier to understand. The only architectures that even define
an optimized BUG_ON() are mips and powerpc, and saving a few cycles
is barely worth it in a fast path, which this is clearly not.

       Arnd
