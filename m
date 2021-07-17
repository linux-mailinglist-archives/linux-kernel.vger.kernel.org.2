Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007303CC239
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 11:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhGQJiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 05:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231862AbhGQJit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 05:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626514552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vMfm6Ul5FP8FBIaSxrSqUf9N4MLQ8vm57kxlps+k2qU=;
        b=U1De0HZg3C0tzFp3neO9BzMfNyvJKIQAbC5+PDXA4+yo4yA8isDXD0wkT42095+CA63zDT
        5IrulCNpvoaAyE+TqwPTKDcgJy0VsimokREuWHPeDbT0LC1FsT1AUrDE2XeTTEIQghBHe4
        LoOXnblXpbKVaU6xjecLulxJe2zftRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-br8uF12bMaujpXW8N-2Tmg-1; Sat, 17 Jul 2021 05:35:48 -0400
X-MC-Unique: br8uF12bMaujpXW8N-2Tmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5762A1084F53;
        Sat, 17 Jul 2021 09:35:46 +0000 (UTC)
Received: from T590 (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C433260862;
        Sat, 17 Jul 2021 09:35:36 +0000 (UTC)
Date:   Sat, 17 Jul 2021 17:35:32 +0800
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
Message-ID: <YPKkZJWsD84mmKuk@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <2455133.St5lIfLNcX@natalenko.name>
 <YPFicCW90Jse4oms@T590>
 <1687461.6WkTYu5mUM@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1687461.6WkTYu5mUM@natalenko.name>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 02:56:22PM +0200, Oleksandr Natalenko wrote:
> On pátek 16. července 2021 12:41:52 CEST Ming Lei wrote:
> > > Do I understand correctly that this will be something like:
> > > 
> > > Fixes: 2705dfb209 ("block: fix discard request merge")
> > > 
> > > ?
> > > 
> > > Because as the bisection progresses, I've bumped into this commit only.
> > > Without it the issue is not reproducible, at least so far.
> > 
> > It could be.
> > 
> > So can you just test v5.14-rc1?
> 
> Doing it right now, but I've got another issue. Why BFQ is not listed here:
> 
> ```
> /sys/class/block/nvme0n1/queue/scheduler:[mq-deadline] kyber none
> /sys/class/block/nvme1n1/queue/scheduler:[mq-deadline] kyber none
> ```

Maybe you need to check if the build is OK, I can't reproduce it in my
VM, and BFQ is still builtin:

[root@ktest-01 ~]# uname -a
Linux ktest-01 5.14.0-rc1+ #52 SMP Fri Jul 16 18:56:36 CST 2021 x86_64 x86_64 x86_64 GNU/Linux
[root@ktest-01 ~]# cat /sys/block/nvme0n1/queue/scheduler
[none] mq-deadline kyber bfq

> 
> ?
> 
> It is a built-in, FWIW:
> 
> ```
> $ modinfo bfq
> name:           bfq
> filename:       (builtin)
> description:    MQ Budget Fair Queueing I/O Scheduler
> license:        GPL
> file:           block/bfq
> author:         Paolo Valente
> alias:          bfq-iosched
> ```
> 
> So far the issue is not reproducible with your patch + 5.13.2 as well as 5.14-
> rc1 (but I don't have BFQ either with v5.14-rc1).

You have to verify it with BFQ applied, :-)


Thanks, 
Ming

