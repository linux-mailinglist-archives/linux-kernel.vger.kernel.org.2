Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670E8338A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhCLKgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhCLKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:35:50 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD36AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:35:49 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id g24so3358798qts.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9kZZ4ShtUBySG8kNNKPjt7UxcAfmn40nTCWrz8Qxyg=;
        b=Oxd+RJVTsSb0oiRRHZ8zf1GhpuY5tc4w9FZ9OwFxcp/02OWPNqeNkgWozSLXFIhtju
         KMeBauUuHhUuV23KKmHNa7OqcPA7mZq3AOpNlENixqy9OP5tKgfiLHecldmdIDDF/t61
         tkz57N8a53AXpEngmCCThh1X9XB06/K9dXJ6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9kZZ4ShtUBySG8kNNKPjt7UxcAfmn40nTCWrz8Qxyg=;
        b=qv2HpzuW5g6ZQIglE70h8sTXbVq0rnR3ng3LfBapKjTzT4d8mF7Rsse0VV+manFsLW
         VPKS45CzWGjClhTX2n/2oW+MfUWerA+5iflcg5dZlc0QxZKTr7BIwn9/LEUWfedknL7m
         pfaM4Bxoz0YQ09SGPquBlPoeQ0PoVkDk0/eHAAMb+jvSikZUdGExc4nSvD+EPStz9wm4
         klHlaHOsrfdGZo43VcBbwIDJmU/pQlMqReoomGN7Wh3WhrK3AJRvWPtsoXtLL2LZ6Aa9
         cBp83NJNERm1/3+DAdypxPBukVgpM1CJmEM22oPP+YKZcw7omARp9LQG97gTAB/kUKRa
         SuEQ==
X-Gm-Message-State: AOAM531K8JTqjw994adly7X27hLNsDOWmUjaFZl9tRmlWnYgKUw78zeY
        eIcIGTrIOzgWc0Ccz+b+DrXI7xmDjBxejXF4ukO0ig==
X-Google-Smtp-Source: ABdhPJxc+3XPOzTj4jbVAtXgGbqiHsgkinTCAKBVlfD3N/JvECXuF+8EEA/bcbCXHL3hVa6UGcI4Yr5V3Rg46Q47H0c=
X-Received: by 2002:aed:2981:: with SMTP id o1mr10859464qtd.386.1615545348968;
 Fri, 12 Mar 2021 02:35:48 -0800 (PST)
MIME-Version: 1.0
References: <CAFr9PXmHhB=PT1kRoYYowf2dw2fqa1-LGCD5S52hW9jJtq5Q4w@mail.gmail.com>
 <20210311161140.32678-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20210311161140.32678-1-mark-pk.tsai@mediatek.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 12 Mar 2021 19:35:38 +0900
Message-ID: <CAFr9PXmwp5FQP8dOZed0siz76qj4Lo-ytt=nt+1GR5qAFtEr9g@mail.gmail.com>
Subject: Re: [PATCH v2] irqchip/irq-mst: Support polarity configuration
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Daniel Palmer <daniel@thingy.jp>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?WUogQ2hpYW5nICjmsZ/oi7HmnbAp?= <yj.chiang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 at 01:11, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> Why irq could accept either?

As the irq intc has no way to clear it's triggered state (no eoi) it
must just pass the signal through instead of latching it?
Otherwise it would latch once and never again right? That's what I
really didn't understand.
If it just passes the signal through and maybe inverts it then the GIC
can use edge or level I think.

> So maybe we don't need to do extra work to check the type for an fiq or irq controller?

I think without the eoi callback for the fiq it would only ever fire
once. I don't think doing the same eoi callback for the irq intc hurts
anything but it wouldn't do anything either from what I can tell.

> And I will update the patch as following:

I think maybe Marc or someone else that knows better than I do should
comment on what needs to happen.
My input is just that the fiq controller seems to trigger on an edge,
holds it's signal to the GIC high until eoi happens and then only
triggers again on an edge.
I guess it doesn't matter if it's an edge or level if that's how it
works but you'd only get one interrupt out of it per edge even if
configured as a level interrupt.

The main thing I didn't want was filtering out edge interrupts
entirely as that breaks using edge interrupts with gpios i.e. using
gpiomon.
With the changes to set the polarity it can now detect rising or
falling edge gpio events. :)

Thanks,

Daniel
