Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6393CB0B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 04:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhGPCTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233114AbhGPCTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626401799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7GTfH8fCEHAUZ3BetrG+wDQa3jsM8/zy40SCzAZxl8Y=;
        b=K2s6uQSxVma3z0kWZna3CEcfpObFIEmhha+5R+xmHxzn7GfOr3Q9y9sz78TcI5gzrqcW8m
        a3ZfWYpDdXP7FcSHvZr/joi256DTBtqsGnuxNHg5yRMJoDJfV9cxdDhmOsDQ8d/YCtjFnb
        qAyUcog5B8kIWclmtetdc2VlLb/1ZJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-IjJ6mpBJOyyOqKMMbKbcqA-1; Thu, 15 Jul 2021 22:16:36 -0400
X-MC-Unique: IjJ6mpBJOyyOqKMMbKbcqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AB191084F4B;
        Fri, 16 Jul 2021 02:16:34 +0000 (UTC)
Received: from T590 (ovpn-13-153.pek2.redhat.com [10.72.13.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C198A60BF1;
        Fri, 16 Jul 2021 02:16:24 +0000 (UTC)
Date:   Fri, 16 Jul 2021 10:16:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        David Jeffery <djeffery@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Message-ID: <YPDr8ucoDCE4NBSe@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4729812.CpyZKHjjVO@natalenko.name>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 03:56:38PM +0200, Oleksandr Natalenko wrote:
> Hello.
> 
> After a v5.13.2 massive update I encountered this:
> 
> ```
> [19231.556665] ------------[ cut here ]------------
> [19231.556674] WARNING: CPU: 20 PID: 502 at drivers/nvme/host/core.c:850 
> nvme_setup_discard+0x188/0x1f0
> ...
> [19231.556776] CPU: 20 PID: 502 Comm: kworker/20:1H Not tainted 5.13.2 #1
> [19231.556780] Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS 
> 3601 05/26/2021
> [19231.556784] Workqueue: kblockd blk_mq_run_work_fn
> [19231.556789] RIP: 0010:nvme_setup_discard+0x188/0x1f0
> [19231.556794] Code: 49 8b 44 24 10 4c 8b 90 40 0b 00 00 4c 2b 15 8f 09 d8 00 
> 49 c1 fa 06 49 c1 e2 0c 4c 03 15 90 09 d8 00 4d 89 d0 e9 b9 fe ff ff <0f> 0b b8 
> 00 00 00 80 49 01 c2 72 52 48 c7 c0 00 00 00 80 48 2b 05
> [19231.556798] RSP: 0018:ffffaed2416efc00 EFLAGS: 00010287
> [19231.556802] RAX: ffff8e67fb580000 RBX: ffff8e640bbe5240 RCX: 0000000000000020
> [19231.556805] RDX: ffff8e67fb580000 RSI: 000000000000001f RDI: 0000000000000000
> [19231.556808] RBP: ffff8e640bbe5388 R08: ffff8e677b580000 R09: 0000000008abb800
> [19231.556811] R10: ffff8e677b580000 R11: 0000000000000400 R12: ffff8e6405999c00
> [19231.556814] R13: 000000000000001f R14: ffff8e6405693000 R15: ffff8e640bbaf800
> [19231.556816] FS:  0000000000000000(0000) GS:ffff8e6b0ef00000(0000) knlGS:
> 0000000000000000
> [19231.556819] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19231.556822] CR2: ffff888c76ece000 CR3: 000000047a184000 CR4: 0000000000350ee0
> [19231.556825] Call Trace:
> [19231.556830]  nvme_setup_cmd+0x2d0/0x670
> [19231.556834]  nvme_queue_rq+0x79/0xc90
> [19231.556837]  ? __sbitmap_get_word+0x30/0x80
> [19231.556842]  ? sbitmap_get+0x85/0x180
> [19231.556846]  blk_mq_dispatch_rq_list+0x15c/0x810
> [19231.556851]  ? list_sort+0x21d/0x2f0
> [19231.556856]  __blk_mq_do_dispatch_sched+0x196/0x320
> [19231.556860]  __blk_mq_sched_dispatch_requests+0x14d/0x190
> [19231.556864]  blk_mq_sched_dispatch_requests+0x2f/0x60
> [19231.556867]  blk_mq_run_work_fn+0x43/0xc0
> [19231.556871]  process_one_work+0x24e/0x430
> [19231.556876]  worker_thread+0x54/0x4d0
> [19231.556880]  ? process_one_work+0x430/0x430
> [19231.556883]  kthread+0x1b3/0x1e0
> [19231.556886]  ? __kthread_init_worker+0x50/0x50
> [19231.556889]  ret_from_fork+0x22/0x30
> [19231.556895] ---[ end trace d9abdf019a56b4c7 ]---
> [19231.556906] blk_update_request: I/O error, dev nvme1n1, sector 632935424 op 
> 0x3:(DISCARD) flags 0x0 phys_seg 31 prio class 0
> ```
> 
> or, in code:
> 
> ```
>  850     if (WARN_ON_ONCE(n != segments)) {

What is 'n' and 'segments'?

thanks,
Ming

