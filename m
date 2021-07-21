Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5392D3D0A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhGUHV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234418AbhGUHUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626854476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvuH6VK1mrxNm7ZXgEI2iox9G8vBz5MBjI5rE3+lsWo=;
        b=guV6+dR1aPhbnaQhEspFR54ZMPlnUA9Lahr1Z+F0VTgqk0ru0Z+HXGjEuPTaHudrQnQixc
        fB0ZOpmu3xLWzQTiBYdFvqZDL3sfbn5IU4ZMlkXtcq4SmaC1Wh+W5gs0V0ONgZvJcIsYqB
        G/Qqj1bgxdgZMYAAmIcG5AaHoDTQL3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-XlB02AQLNpOoQh2qJXUYCg-1; Wed, 21 Jul 2021 04:01:15 -0400
X-MC-Unique: XlB02AQLNpOoQh2qJXUYCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FD671005D5C;
        Wed, 21 Jul 2021 08:01:13 +0000 (UTC)
Received: from T590 (ovpn-13-178.pek2.redhat.com [10.72.13.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C532D19C79;
        Wed, 21 Jul 2021 08:01:01 +0000 (UTC)
Date:   Wed, 21 Jul 2021 16:00:56 +0800
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
Message-ID: <YPfUOKrxGs6FjaOZ@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <YPTYGD1zeae1x7Yp@T590>
 <2407736.Le3fEKZpXq@natalenko.name>
 <2356877.Yf5hrMSTGe@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2356877.Yf5hrMSTGe@natalenko.name>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 11:05:29AM +0200, Oleksandr Natalenko wrote:
> Hello, Ming.
> 
> On pondělí 19. července 2021 8:27:29 CEST Oleksandr Natalenko wrote:
> > On pondělí 19. července 2021 3:40:40 CEST Ming Lei wrote:
> > > On Sat, Jul 17, 2021 at 02:35:14PM +0200, Oleksandr Natalenko wrote:
> > > > On sobota 17. července 2021 14:19:59 CEST Oleksandr Natalenko wrote:
> > > > > On sobota 17. července 2021 14:11:05 CEST Oleksandr Natalenko wrote:
> > > > > > On sobota 17. července 2021 11:35:32 CEST Ming Lei wrote:
> > > > > > > Maybe you need to check if the build is OK, I can't reproduce it
> > > > > > > in
> > > > > > > my
> > > > > > > VM, and BFQ is still builtin:
> > > > > > > 
> > > > > > > [root@ktest-01 ~]# uname -a
> > > > > > > Linux ktest-01 5.14.0-rc1+ #52 SMP Fri Jul 16 18:56:36 CST 2021
> > > > > > > x86_64
> > > > > > > x86_64 x86_64 GNU/Linux [root@ktest-01 ~]# cat
> > > > > > > /sys/block/nvme0n1/queue/scheduler
> > > > > > > [none] mq-deadline kyber bfq
> > > > > > 
> > > > > > I don't think this is an issue with the build… BTW, with
> > > > > > `initcall_debug`:
> > > > > > 
> > > > > > ```
> > > > > > [    0.902555] calling  bfq_init+0x0/0x8b @ 1
> > > > > > [    0.903448] initcall bfq_init+0x0/0x8b returned -28 after 507
> > > > > > usecs
> > > > > > ```
> > > > > > 
> > > > > > -ENOSPC? Why? Also re-tested with the latest git tip, same result
> > > > > > :(.
> > > > > 
> > > > > OK, one extra pr_info, and I see this:
> > > > > 
> > > > > ```
> > > > > [    0.871180] blkcg_policy_register: BLKCG_MAX_POLS too small
> > > > > [    0.871612] blkcg_policy_register: -28
> > > > > ```
> > > > > 
> > > > > What does it mean please :)? The value seems to be hard-coded:
> > > > > 
> > > > > ```
> > > > > include/linux/blkdev.h
> > > > > 60:#define BLKCG_MAX_POLS               5
> > > > > ```
> > > > 
> > > > OK, after increasing this to 6 I've got my BFQ back. Please see [1].
> > > > 
> > > > [1]
> > > > https://lore.kernel.org/linux-block/20210717123328.945810-1-oleksandr@na
> > > > t
> > > > alenko.name/
> > > 
> > > OK, after you fixed the issue in blkcg_policy_register(), can you
> > > reproduce the discard issue on v5.14-rc1 with BFQ applied? If yes,
> > > can you test the patch I posted previously?
> > 
> > Yes, the issue is reproducible with both v5.13.2 and v5.14-rc1. I haven't
> > managed to reproduce it with v5.13.2+your patch. Now I will build v5.14-
> > rc2+your patch and test further.
> 
> I'm still hammering v5.14-rc2 + your patch, and I cannot reproduce the issue. 
> Given I do not have a reliable reproducer (I'm just firing up the kernel build, 
> and the issue pops up eventually, sooner or later, but usually within a couple 
> of first tries), for how long I should hammer it for your fix to be considered 
> proven?

You mentioned that the issue is reproducible with v5.14-rc, that means
it can be always reproduced in limited time(suppose it is A). If the issue
can't be reproduced any more after applying the patch in long enough time B(B >> A),
we can think it is fixed by the patch.

For example, if A is one hour, we can set B as 5*A or bigger to simulate
the long enough time.


Thanks,
Ming

