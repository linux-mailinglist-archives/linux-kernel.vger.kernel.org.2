Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2545B126
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 02:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhKXBfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 20:35:50 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:60703 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhKXBft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 20:35:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HzNmQ6WlVz4xd8;
        Wed, 24 Nov 2021 12:32:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1637717559;
        bh=StwGzFhMGIPHAukmYeKeJosKoihe3KiFUMFiWnca8oc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=p7cnKYEJoC3ARYa1AnP2faJU3R82OGf1x8ED7XCHToBDc7gzUo2zUzLGZ902dwuQW
         OG8LtV1cnTCWqnyovaqhIArrUQrQVDKkdF2JW3pyLxmKMUDhNoGQjCEIjUOftltdkf
         o9K3ftruCkM+doHf9pPzc3EMqoFzwA/izPwdn9zjh9aAnTm7GdbqrTgD/3MrV/L4Hi
         Tgs4nQSErg6vG/mcWxqYT5kcR1RJlFR5VrIiWcA7nRFJWSfbn/6D0as7CZtYgAdmSa
         eWcDZ0J2U5x10gcplKS4TP1yMXCRUYsI0wnpD+V/A/1jDLavhqfhm1dR6PrH70WvVe
         91xTcuHeIMU7Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Hildenbrand <david@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: update_balloon_size_func blocked for more than 120 seconds
In-Reply-To: <CADFyXm5DroJqhQVVxUcN8yqa8DLWRRDi0sQWGz7u-LMYg3JVyw@mail.gmail.com>
References: <YY2duTi0wAyAKUTJ@bombadil.infradead.org>
 <CADFyXm5DroJqhQVVxUcN8yqa8DLWRRDi0sQWGz7u-LMYg3JVyw@mail.gmail.com>
Date:   Wed, 24 Nov 2021 12:32:38 +1100
Message-ID: <87wnkypccp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:
> On Thu, Nov 11, 2021 at 11:49 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> I get the following splats with a kvm guest in idle, after a few seconds
>> it starts:
>>
>> [  242.412806] INFO: task kworker/6:2:271 blockedfor more than 120 seconds.
>> [  242.415790]       Tainted: G            E     5.15.0-next-20211111 #68
>> [  242.417755] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  242.418332] task:kworker/6:2     state:D stack:    0 pid:  271 ppid: 2 flags:0x00004000
>> [  242.418954] Workqueue: events_freezable update_balloon_size_func [virtio_balloon]
>> [  242.419518] Call Trace:
>> [  242.419709]  <TASK>
>> [  242.419873]  __schedule+0x2fd/0x990
>> [  242.420142]  schedule+0x4e/0xc0
>> [  242.420382]  tell_host+0xaa/0xf0 [virtio_balloon]
>> [  242.420757]  ? do_wait_intr_irq+0xa0/0xa0
>> [  242.421065]  update_balloon_size_func+0x2c9/0x2e0 [virtio_balloon]
>> [  242.421527]  process_one_work+0x1e5/0x3c0
>> [  242.421833]  worker_thread+0x50/0x3b0
>> [  242.422204]  ? rescuer_thread+0x370/0x370
>> [  242.422507]  kthread+0x169/0x190
>> [  242.422754]  ? set_kthread_struct+0x40/0x40
>> [  242.423073]  ret_from_fork+0x1f/0x30
>> [  242.423347]  </TASK>
>>
>> And this goes on endlessly. The last one says it blocked for more than 1208
>> seconds. This was not happening until the last few weeks but I see no
>> relevant recent commits for virtio_balloon, so the related change could
>> be elsewhere.
>
> We're stuck somewhere in:
>
> wq: update_balloon_size_func()->fill_balloon()->tell_host()
>
> Most probably in wait_event().
>
>
> I am no waitqueue expert, but my best guess would be that we're
> waiting more than 2 minutes
> on a host reply with TASK_UNINTERRUPTIBLE. At least that's my interpretation,
>
> In case we're really stuck for more than 2 minutes, the hypervisor
> might not be processing our
> requests anymore -- or it's not getting processed for some other reason (or the
> waitqueue is not getting woken up due do some other BUG).
>
> IIUC, we can sleep longer via wait_event_interruptible(), TASK_UNINTERRUPTIBLE
> seems to be the issue that triggers the warning. But by changing that
> might just be hiding the fact that
> we're waiting more than 2 minutes on a reply.
>
>>
>> I could bisect but first I figured I'd check to see if someone already
>> had spotted this.
>
> Bisecting would be awesome, then we might at least know if this is a
> guest or a hypervisor issue.

I see this on ppc64le also.

I bisected it to:

  # first bad commit: [939779f5152d161b34f612af29e7dc1ac4472fcf] virtio_ring: validate used buffer length

I also reported it in the thread hanging off that patch:

  https://lore.kernel.org/lkml/87zgpupcga.fsf@mpe.ellerman.id.au/


cheers
