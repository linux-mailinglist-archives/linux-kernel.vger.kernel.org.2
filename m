Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763BA3CED0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382836AbhGSRmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358906AbhGSQx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:53:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD6BC0F26EB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 10:11:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l11so12179951ljq.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vqFcAPpr2Wrm3IQBRWJ29wt2kc6RE+Zc3iAnlFe6GY=;
        b=DREFa+Crra3/Gwt/ozWS6XyyFKY4Mg7dPcld3cizJiTFXWiznp9HUE67QvDO9oZbMl
         3B000kz0sS3krAYD5a9gSu4NLZy1dE4yjQ9TVgBrKCK528Roj8zK08CGtsxThRGSyXDy
         ffWrnC9O7291POYBsVEi4zTCMxsxY7N/ykOM/tzi3rOF108KqHG+a3+2JefEhIN/oX0f
         VyMRoQNFp8urHC5L9xqQac7l8DS+rfqzzY7gd9u2EOqO//9C9pgpq/ZMCAFw4jQUsB6A
         v19hBqOGOdThZ0zo/07dXAHgVKO8uuU8kzOaDdOVo8Li2Tzapur/tu/weHW3xGPsT6zs
         GwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vqFcAPpr2Wrm3IQBRWJ29wt2kc6RE+Zc3iAnlFe6GY=;
        b=eTQGG5OyrwgcSAbLPc3bz/+bWfVISiKHA7k8Bi+RBYuUgfmFxKwuZgEimB/wfM4gC5
         HbJlWcem/FMAIUuVQfqd8d6MOt4uHOIRB676iVJsIc1cO3VZ16YJDUOXkTviY1JZD4L/
         nYQLqghCKUEgsZpePkolZS55kV7Kqk/vLXfOHyEEsRy0KPidthqkvv5fj5Kjj3xPZILl
         d2yMYNn4BryQDkIwfgz7mrZg4PqbNoOT28SFXToKjbuqt0Ts5XEltq708Rg70wCWzKI1
         vTtKYeHCGT3by4bov+WIWdEiSaXsdpah/WzHkKFOaKZBp9+RtKZ1UFQsyFk4B+NqKU7s
         Be6w==
X-Gm-Message-State: AOAM533W0CVnuRM2AT8xZDsD3V55kWy13RJU+8//9QmjhHwxVj6geDAR
        tu007frbu/PY6THjEIdEyBoUrtVJ2G7NZfV6WdZcWQ==
X-Google-Smtp-Source: ABdhPJyo55MqgRQDKulqoMn04KoWQCUp51qWy4Z5KYNeT0BBLUr4vsWWfK5wvi9jXem9ykTLN5UMvoyZTpEdSMcXwUM=
X-Received: by 2002:a2e:934f:: with SMTP id m15mr22566736ljh.208.1626715811254;
 Mon, 19 Jul 2021 10:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210716184719.269033-5-posk@google.com> <2c971806-b8f6-50b9-491f-e1ede4a33579@uwaterloo.ca>
In-Reply-To: <2c971806-b8f6-50b9-491f-e1ede4a33579@uwaterloo.ca>
From:   Peter Oskolkov <posk@google.com>
Date:   Mon, 19 Jul 2021 10:29:59 -0700
Message-ID: <CAPNVh5cmhFEWr4bmODkDDFhV=mHLcO0DZJ432GEL=OitzPP80g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4 v0.3] sched/umcg: RFC: implement UMCG syscalls
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     posk@posk.io, avagin@google.com, bsegall@google.com,
        jannh@google.com, jnewsome@torproject.org, joel@joelfernandes.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, pjt@google.com,
        tglx@linutronix.de, Peter Buhr <pabuhr@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 9:07 AM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
>  > /**
>  >  * @idle_servers_ptr: a single-linked list pointing to the list
>  >  *                    of idle servers. Can be NULL.
>  >  *
>  >  * Readable/writable by both the kernel and the userspace: the
>  >  * userspace adds items to the list, the kernel removes them.
>  >  *
>  >  * This is a single-linked list (stack): head->next->next->next->NULL.
>  >  * "next" nodes are idle_servers_ptr fields in struct umcg_task.
>  >  *
>  >  * Example:
>  >  *
>  >  *  a running worker             idle server 1        idle server 2
>  >  *
>  >  * struct umct_task:             struct umcg_task:    struct umcg_task:
>  >  *    state                         state state
>  >  *    api_version                   api_version api_version
>  >  *    ...                           ...                  ...
>  >  *    idle_servers_ptr --> head --> idle_servers_ptr -->
> idle_servers_ptr --> NULL
>  >  *    ...                           ...                  ...
>  >  *
>  >  *
>  >  * Due to the way struct umcg_task is aligned, idle_servers_ptr
>  >  * is aligned at 8 byte boundary, and so has its first byte as zero
>  >  * when it holds a valid pointer.
>  >  *
>  >  * When pulling idle servers from the list, the kernel marks nodes as
>  >  * "deleted" by ORing the node value (the pointer) with 1UL atomically.
>  >  * If a node is "deleted" (i.e. its value AND 1UL is not zero),
>  >  * the kernel proceeds to the next node.
>  >  *
>  >  * The kernel checks at most [nr_cpu_ids * 2] first nodes in the list.
>  >  *
>  >  * It is NOT considered an error if the kernel cannot find an idle
>  >  * server.
>  >  *
>  >  * The userspace is responsible for cleanup/gc (i.e. for actually
>  >  * removing nodes marked as "deleted" from the list).
>  >  */
>  > uint64_t    idle_servers_ptr;    /* r/w */
>
> I don't understand the reason for using this ad-hoc scheme, over using a
> simple
> eventfd to do the job. As I understand it, the goal here is to let
> servers that
> cannot find workers to run, block instead of spinning. Isn't that
> exactly what
> the eventfd interface is for?

Latency/efficiency: on worker wakeup an idle server can be picked from
the list and context-switched into synchronously, on the same CPU.
Using FDs and select/poll/epoll will add extra layers of abstractions;
synchronous context-switches (not yet fully implemented in UMCG) will
most likely be impossible. This patchset seems much more efficient and
lightweight than whatever can be built on top of FDs.

>
> Have you considered an idle_fd field, the kernel writes 1 to the fd when a
> worker is appended to the idle_workers_ptr? Servers that don't find work can
> read the fd or alternatively use select/poll/epoll. Multiple workers are
> expected to share fds, either a single global fd, one fd per server, or any
> other combination the scheduler may fancy.
>
