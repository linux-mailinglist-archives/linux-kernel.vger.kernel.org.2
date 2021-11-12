Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1516544E3AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhKLJQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 04:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234614AbhKLJQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636708422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/UJZxf1rg8eMFR87IMiW9u+KeIoLex0Bdd2vdqsTBSQ=;
        b=GiXWvHoTB0VsRmdUbXkM5+fIlfdgP4i9FeHdqQnZoIghbFy8C03ZjgdBf6LAXWX2k10R09
        2kwetcHKo/o9Cziz2uF7jRyRs5x31wGY6npu2rCp2VQs5k8PG/0N6ryWnV9rYRu12DKAUs
        sMyfXtLo8nlA298BwunaPjHjBlUE8i8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-DYuqwa9dO8eQgN0yuJwt6A-1; Fri, 12 Nov 2021 04:13:41 -0500
X-MC-Unique: DYuqwa9dO8eQgN0yuJwt6A-1
Received: by mail-lf1-f69.google.com with SMTP id n18-20020a0565120ad200b004036c43a0ddso3544054lfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/UJZxf1rg8eMFR87IMiW9u+KeIoLex0Bdd2vdqsTBSQ=;
        b=4V5I3zGeNE47twIVmXYoEzHy0llkTZYEmClpX8NuxFu44kJd/IL1BK7VBkKoGvDjMi
         4A5mOLbHJp9NOTaDSmu1xIamcILEeCgwm43v3MIS9rmcEgDNkuPzZ2IuPxu8ckcTJngo
         nzCHjKsvijcO7z+/F9Qe4wy6wUdjmxkatqJPbhTG+TjHNe525yJdCGPtq0SktqF92n1D
         caOr8GPPXAsWZN5rx8qDqi4LcatB/XW25eEybezT1ocsr5XnhFMGJBvccsq9R/5jQNiQ
         D7wslt72dg9kAXechQjWyJ9K1o2pgIH/hf1PG9v38frx/GkUZe0e5FFQree4DEuBhD1M
         3GEw==
X-Gm-Message-State: AOAM530jYi0CpPTfO2ZUDPkul1dhQP3AKUPTFO8445zZbPcDJYZojyKP
        70UKAJw0HL60VbOLxsT9792i2T4ZhXM2KskJpkXdNSSUG8EQCMzit1qcj0VWwXBuw+Tc3lfPYZ2
        isgBLxj7iVOnU0h2g50Jb2USNHTt8ewoa4RfznQd/
X-Received: by 2002:a05:651c:28e:: with SMTP id b14mr14022780ljo.440.1636708420205;
        Fri, 12 Nov 2021 01:13:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0F0CWQYl9m9FBj62gxAvBUzPdVSEJofB9lQJLdxTMadeC7FiMMESs00TZNnsYIoG7YrRozlAk3XYE1AiAGcI=
X-Received: by 2002:a05:651c:28e:: with SMTP id b14mr14022756ljo.440.1636708419982;
 Fri, 12 Nov 2021 01:13:39 -0800 (PST)
MIME-Version: 1.0
References: <YY2duTi0wAyAKUTJ@bombadil.infradead.org>
In-Reply-To: <YY2duTi0wAyAKUTJ@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Date:   Fri, 12 Nov 2021 10:13:28 +0100
Message-ID: <CADFyXm5DroJqhQVVxUcN8yqa8DLWRRDi0sQWGz7u-LMYg3JVyw@mail.gmail.com>
Subject: Re: update_balloon_size_func blocked for more than 120 seconds
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 11:49 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> I get the following splats with a kvm guest in idle, after a few seconds
> it starts:
>
> [  242.412806] INFO: task kworker/6:2:271 blockedfor more than 120 seconds.
> [  242.415790]       Tainted: G            E     5.15.0-next-20211111 #68
> [  242.417755] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  242.418332] task:kworker/6:2     state:D stack:    0 pid:  271 ppid: 2 flags:0x00004000
> [  242.418954] Workqueue: events_freezable update_balloon_size_func [virtio_balloon]
> [  242.419518] Call Trace:
> [  242.419709]  <TASK>
> [  242.419873]  __schedule+0x2fd/0x990
> [  242.420142]  schedule+0x4e/0xc0
> [  242.420382]  tell_host+0xaa/0xf0 [virtio_balloon]
> [  242.420757]  ? do_wait_intr_irq+0xa0/0xa0
> [  242.421065]  update_balloon_size_func+0x2c9/0x2e0 [virtio_balloon]
> [  242.421527]  process_one_work+0x1e5/0x3c0
> [  242.421833]  worker_thread+0x50/0x3b0
> [  242.422204]  ? rescuer_thread+0x370/0x370
> [  242.422507]  kthread+0x169/0x190
> [  242.422754]  ? set_kthread_struct+0x40/0x40
> [  242.423073]  ret_from_fork+0x1f/0x30
> [  242.423347]  </TASK>
>
> And this goes on endlessly. The last one says it blocked for more than 1208
> seconds. This was not happening until the last few weeks but I see no
> relevant recent commits for virtio_balloon, so the related change could
> be elsewhere.

We're stuck somewhere in:

wq: update_balloon_size_func()->fill_balloon()->tell_host()

Most probably in wait_event().


I am no waitqueue expert, but my best guess would be that we're
waiting more than 2 minutes
on a host reply with TASK_UNINTERRUPTIBLE. At least that's my interpretation,

In case we're really stuck for more than 2 minutes, the hypervisor
might not be processing our
requests anymore -- or it's not getting processed for some other reason (or the
waitqueue is not getting woken up due do some other BUG).

IIUC, we can sleep longer via wait_event_interruptible(), TASK_UNINTERRUPTIBLE
seems to be the issue that triggers the warning. But by changing that
might just be hiding the fact that
we're waiting more than 2 minutes on a reply.

>
> I could bisect but first I figured I'd check to see if someone already
> had spotted this.

Bisecting would be awesome, then we might at least know if this is a
guest or a hypervisor issue.

Note that the environment matters: the hypervisor seems to be
requesting the guest to inflate
the balloon right when booting up. So you might not be able to
reproduce in a different environment.

