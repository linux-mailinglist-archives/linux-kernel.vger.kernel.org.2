Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA240A238
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 02:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhINAzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 20:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhINAzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631580872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJecgffscZyS8jybTRNi6LBusFI022jT9cPdy4rCZas=;
        b=Lcu71MrS9D7cMd0+WzLXcwh8YJGnC6epSS26BtZmp7FO38zPDGQEApd1o/qfMSlf+lwaDL
        AA1Qn5ZwJmAJtt4o9nwsRe6EITkjqaHT4LnXmbsrmJo5BE6TJz7D2l6+vhJ7jkeTAAjZte
        aecm/qoiTeqtOAQj2qV0KrtCWfUvrAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-I0hSVFWSPi-u5Rp1IxLG4w-1; Mon, 13 Sep 2021 20:54:29 -0400
X-MC-Unique: I0hSVFWSPi-u5Rp1IxLG4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AB20835DE1;
        Tue, 14 Sep 2021 00:54:28 +0000 (UTC)
Received: from T590 (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F01FA7A5CE;
        Tue, 14 Sep 2021 00:54:18 +0000 (UTC)
Date:   Tue, 14 Sep 2021 08:54:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
Subject: Re: [PATCH v5 1/6] nbd: don't handle response without a
 corresponding request message
Message-ID: <YT/yw3QomdPgHx6m@T590>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909141256.2606682-2-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 10:12:51PM +0800, Yu Kuai wrote:
> While handling a response message from server, nbd_read_stat() will
> try to get request by tag, and then complete the request. However,
> this is problematic if nbd haven't sent a corresponding request
> message:
> 
> t1                      t2
>                         submit_bio
>                          nbd_queue_rq
>                           blk_mq_start_request
> recv_work
>  nbd_read_stat
>   blk_mq_tag_to_rq
>  blk_mq_complete_request
>                           nbd_send_cmd
> 
> Thus add a new cmd flag 'NBD_CMD_INFLIGHT', it will be set in
> nbd_send_cmd() and checked in nbd_read_stat().
> 
> Noted that this patch can't fix that blk_mq_tag_to_rq() might
> return a freed request, and this will be fixed in following
> patches.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

