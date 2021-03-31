Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55C434DDF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhC3CEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:04:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229763AbhC3CEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617069860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gngwkyZ/3M/2XkpH6d2ukHiMd39dV8LGK6CsTjibunk=;
        b=T3flcwSEsPel8JXA+ZxO5MlQY+SVfJk3WFzvBF6EmBWOyD5X8JR16BVkev/PngJSg8gig7
        9HxqayQk0EAv9ewI7oeIjDuk1gFpSzI+XtekGI7uApyBfI8A65Z7Twbd4P8MP6DQxaM8KO
        4iEWIBNCl86y6on3RX8JpUduIZa9RCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-kPTxH9BXMj-4hnSWZf7KCQ-1; Mon, 29 Mar 2021 22:04:17 -0400
X-MC-Unique: kPTxH9BXMj-4hnSWZf7KCQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 429C883DB64;
        Tue, 30 Mar 2021 02:04:16 +0000 (UTC)
Received: from T590 (ovpn-12-129.pek2.redhat.com [10.72.12.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 69DA16E707;
        Tue, 30 Mar 2021 02:04:09 +0000 (UTC)
Date:   Tue, 30 Mar 2021 10:04:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] blktrace: fix trace buffer leak and limit trace
 buffer size
Message-ID: <YGKHFbQ6vfdVroZ7@T590>
References: <20210323081440.81343-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323081440.81343-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 04:14:38PM +0800, Ming Lei wrote:
> blktrace may pass big trace buffer size via '-b', meantime the system
> may have lots of CPU cores, so too much memory can be allocated for
> blktrace.
> 
> The 1st patch shutdown bltrace in blkdev_close() in case of task
> exiting, for avoiding trace buffer leak.
> 
> The 2nd patch limits max trace buffer size for avoiding potential
> OOM.
> 
> 
> Ming Lei (2):
>   block: shutdown blktrace in case of fatal signal pending
>   blktrace: limit allowed total trace buffer size
> 
>  fs/block_dev.c          |  6 ++++++
>  kernel/trace/blktrace.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)

Hello Guys,

Ping...

BTW, this is another OOM risk in blktrace userspace which is caused by
mlock(16 * buffer_size) * nr_cpus, so I think we need to avoid memory
leak caused by OOM.


Thanks,
Ming

