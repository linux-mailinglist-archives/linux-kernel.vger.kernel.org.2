Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1413BC727
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 09:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhGFHcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 03:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230203AbhGFHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 03:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625556565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nw0P33cYxqMaEBdimkgujl5GLUpaC+SctslNj38QzXU=;
        b=fLF8gNYMcFRT67r4SF1S3XCeEnwp9ryoUzwfTJBqdcKvYFLtZKpaxjzw1ifTUtPnXwPY2w
        Bz2BKuTkgv/V8kvo22sKHeizI0RC8X/8+9ak1p+dLOiPbj7i/iiL/fxmzh0FtKs8MwrNse
        a/x/6fC/RuKqI0jZJIWfq/Y3Ve5J42Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-qsHgqo21NZyc2_bgpJSftQ-1; Tue, 06 Jul 2021 03:29:24 -0400
X-MC-Unique: qsHgqo21NZyc2_bgpJSftQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59F6A1932480;
        Tue,  6 Jul 2021 07:29:22 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 671C55D6A1;
        Tue,  6 Jul 2021 07:29:16 +0000 (UTC)
Date:   Tue, 6 Jul 2021 15:29:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <YOQGRwLfLaFGqlVA@T590>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
 <YNp50pmlzN6M0kNX@T590>
 <20210705162519.qqlklisxcsiopflw@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705162519.qqlklisxcsiopflw@beryllium.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 06:34:00PM +0200, Daniel Wagner wrote:
> On Tue, Jun 29, 2021 at 09:39:30AM +0800, Ming Lei wrote:
> > Can you investigate a bit on why there is the hang? FC shouldn't use
> > managed IRQ, so the interrupt won't be shutdown.
> 
> So far, I was not able to figure out why this hangs. In my test setup I
> don't have to do any I/O, I just toggle the remote port.
> 
>   grep busy /sys/kernel/debug/block/*/hctx*/tags | grep -v busy=0
> 
> and this seems to confirm, no I/O in flight.

What is the output of the following command after the hang is triggered?

(cd /sys/kernel/debug/block/nvme0n1 && find . -type f -exec grep -aH . {} \;)

Suppose the hang disk is nvme0n1.

> 
> So I started to look at the q_usage_counter. The obvious observational
> is that counter is not 0. The least bit is set, thus we are in atomic
> mode. 
> 
> (gdb) p/x *((struct request_queue*)0xffff8ac992fbef20)->q_usage_counter->data
> $10 = {
>   count = {
>     counter = 0x8000000000000001
>   }, 
>   release = 0xffffffffa02e78b0, 
>   confirm_switch = 0x0, 
>   force_atomic = 0x0, 
>   allow_reinit = 0x1, 
>   rcu = {
>     next = 0x0, 
>     func = 0x0
>   }, 
>   ref = 0xffff8ac992fbef30
> }
> 
> I am a bit confused about the percpu-refcount API. My naive
> interpretation is that when we are in atomic mode percpu_ref_is_zero()
> can't be used. But this seems rather strange. I must miss something.

No, percpu_ref_is_zero() is fine to be called in atomic mode.


Thanks,
Ming

