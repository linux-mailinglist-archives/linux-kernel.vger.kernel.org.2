Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A593CCC05
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 03:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhGSBoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 21:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233713AbhGSBoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 21:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626658861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEqAVMebt8KkaRBeojxifkyre8q09DDKsrxdRcTSaRM=;
        b=PcJ6FVT8i17KyyQG4S8TRJIWMq3LLoW6Xh5/WCtZPozKehrCBcyp3NNl+YSZiYjFFtIPj3
        S0RBDbIumWx3J9Yny9Kn5wf9ffKFaROmItf5IdPRXaFbpb8g0rroh587BI5/gWEu8I2+h7
        JETqHMADRJ25ua5k5ntjTW9zh1aYf2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-zjI_g7yqO8CK3PNlvtZDIw-1; Sun, 18 Jul 2021 21:41:00 -0400
X-MC-Unique: zjI_g7yqO8CK3PNlvtZDIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43EB9802C80;
        Mon, 19 Jul 2021 01:40:58 +0000 (UTC)
Received: from T590 (ovpn-13-11.pek2.redhat.com [10.72.13.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACF5A27068;
        Mon, 19 Jul 2021 01:40:45 +0000 (UTC)
Date:   Mon, 19 Jul 2021 09:40:40 +0800
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
Message-ID: <YPTYGD1zeae1x7Yp@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <5053297.vgnLoh5Ws3@natalenko.name>
 <8988303.mDXGIdCtx8@natalenko.name>
 <3383530.3bVf3B8HMu@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3383530.3bVf3B8HMu@natalenko.name>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 02:35:14PM +0200, Oleksandr Natalenko wrote:
> On sobota 17. července 2021 14:19:59 CEST Oleksandr Natalenko wrote:
> > On sobota 17. července 2021 14:11:05 CEST Oleksandr Natalenko wrote:
> > > On sobota 17. července 2021 11:35:32 CEST Ming Lei wrote:
> > > > Maybe you need to check if the build is OK, I can't reproduce it in my
> > > > VM, and BFQ is still builtin:
> > > > 
> > > > [root@ktest-01 ~]# uname -a
> > > > Linux ktest-01 5.14.0-rc1+ #52 SMP Fri Jul 16 18:56:36 CST 2021 x86_64
> > > > x86_64 x86_64 GNU/Linux [root@ktest-01 ~]# cat
> > > > /sys/block/nvme0n1/queue/scheduler
> > > > [none] mq-deadline kyber bfq
> > > 
> > > I don't think this is an issue with the build… BTW, with `initcall_debug`:
> > > 
> > > ```
> > > [    0.902555] calling  bfq_init+0x0/0x8b @ 1
> > > [    0.903448] initcall bfq_init+0x0/0x8b returned -28 after 507 usecs
> > > ```
> > > 
> > > -ENOSPC? Why? Also re-tested with the latest git tip, same result :(.
> > 
> > OK, one extra pr_info, and I see this:
> > 
> > ```
> > [    0.871180] blkcg_policy_register: BLKCG_MAX_POLS too small
> > [    0.871612] blkcg_policy_register: -28
> > ```
> > 
> > What does it mean please :)? The value seems to be hard-coded:
> > 
> > ```
> > include/linux/blkdev.h
> > 60:#define BLKCG_MAX_POLS               5
> > ```
> 
> OK, after increasing this to 6 I've got my BFQ back. Please see [1].
> 
> [1] https://lore.kernel.org/linux-block/20210717123328.945810-1-oleksandr@natalenko.name/

OK, after you fixed the issue in blkcg_policy_register(), can you
reproduce the discard issue on v5.14-rc1 with BFQ applied? If yes,
can you test the patch I posted previously?


Thanks,
Ming

