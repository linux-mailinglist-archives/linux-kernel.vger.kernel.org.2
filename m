Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C4433B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhJSQBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJSQBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:01:14 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE49C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:59:01 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id u32so4665592ybd.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RlGsUhZv7y1Y43YyXgR+WSHhAI3+aP3m+Q58wtMVpx4=;
        b=WnFq6cutaUIfG5uekqdmLBjybpuQxsfOFzPE50VX9aflVapzESKbSxF/rcN8RnhRLz
         eHrgXRMB1PjuUW6U4v40FFCYGSyi7mcH6FlxkE+eQR0OOvpjAEVnAU6B6gE5PNiMXRBF
         /dwr+mL3vbPOXICuvzFlFe90usff6gA3XBYJwtz+5whizBpqpNTbBuENeRdnr4W4DyEJ
         YvuGjJwZ+etR4qBxOlAlvIHE8dtvJ/utBXgSF8Hj6nuq72yxCnkiQmG/LwsEQYaHJIaU
         dXvZAnUrfsHRh475Rli5/AjqJcp01oyuLieMQ9y9209Irdb+KIeFngLUYIgMUaAf+uv9
         EzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RlGsUhZv7y1Y43YyXgR+WSHhAI3+aP3m+Q58wtMVpx4=;
        b=hFLeaBVHX79NDXrOG+UA584qfXjz0AXYMnOVJR3N7ZuVeHiWgy7IaEkxFlwz7J7qSO
         S4KoHRWNQY77bW7D+wYcjtWegOKStpvnlwm4FjswRfIqjgt6guz9DkIyqMrmzcmZZHd0
         Hck9WflXtp7/4QyEo+txfUOTekl3o+WGRKtCyf+l9Ow9hO+MnOFI1K9axDzTXNWvbj4I
         gUBjwbFr1iozTZp6c8ysm7XuFWlWvw7sRSYBXZEPKbKwwKBOJS0NkmxuNHlSmJvcY3Xc
         dHy9Przn0wPL1wrObuUefeEqcRdpultW939PsQi7ZLA1RqT93Vq4CStaA7dYHqxixJQg
         P8ww==
X-Gm-Message-State: AOAM530fc3EWD9Y101wXJ/h5tu1OJFJh5YeWcpg9wgn1ukB+SH7jd6ZS
        2CB3N+WTQFjPCdR+nd+DSnXP+3GSPjusyPo9MoWBng==
X-Google-Smtp-Source: ABdhPJxv0xZ2ZbCv0Z5wxw3zRP/jtunmb6Y8Hmy1MkV8mEkPkKVr6DkPItiGN0uzi9rh5Gqaw+Hu7G6aZSk2KvdUsV8=
X-Received: by 2002:a25:918e:: with SMTP id w14mr20591461ybl.225.1634659140106;
 Tue, 19 Oct 2021 08:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211018123710.1540996-1-chenwandun@huawei.com>
 <20211018123710.1540996-2-chenwandun@huawei.com> <YW1rEt0u2CSCYgnJ@casper.infradead.org>
 <CALvZod4BEu3sYuo3kZ9OS0SXHm_q7C8w7sYObJo9X_xeMUd8sQ@mail.gmail.com>
In-Reply-To: <CALvZod4BEu3sYuo3kZ9OS0SXHm_q7C8w7sYObJo9X_xeMUd8sQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 19 Oct 2021 08:58:48 -0700
Message-ID: <CANn89iKN_N=tSiv-xFHYAGAagty9pP_FCH2FtfjUU=NGpRf3dg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/vmalloc: fix numa spreading for large hash tables
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Chen Wandun <chenwandun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, guohanjun@huawei.com,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 8:54 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Oct 18, 2021 at 5:41 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Oct 18, 2021 at 08:37:09PM +0800, Chen Wandun wrote:
> > > Eric Dumazet reported a strange numa spreading info in [1], and found
> > > commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduced
> > > this issue [2].
> >
> > I think the root problem here is that we have two meanings for
> > NUMA_NO_NODE.  I tend to read it as "The memory can be allocated from
> > any node", but here it's used to mean "The memory should be spread over
> > every node".  Should we split those out as -1 and -2?
>
> I agree with Willy's suggestion to make it more explicit but as a
> followup work. This patch needs a backport, so keep this simple.

NUMA_NO_NODE in process context also meant :
Please follow current thread NUMA policies.

One could hope for instance, that whenever large BPF maps are allocated,
current thread could set non default NUMA policies.
