Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91E7397417
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhFAN1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233938AbhFAN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622553966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7TuMZN1E0lbaQ4+hZI+BzEhy4hL1Tvu8HZ6jA5gQoCo=;
        b=Or14BzzecxZJmyl55kwvWtqag5norMUHjZImFtjiUJBOVZpg36JzmYjSzHuXqqiYvdsu9o
        0+4tzS7QDiTj6k85TJq5BK+eP68maEiOB28m5poA81aMlqs+Rtc3FDGphrYehpFykAZN0i
        LMXtvpudp7n+CiLiT2wniYceCwoxYnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-K2HIVmKNP-izGpM3ukrxfQ-1; Tue, 01 Jun 2021 09:26:03 -0400
X-MC-Unique: K2HIVmKNP-izGpM3ukrxfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26CB6107ACC7;
        Tue,  1 Jun 2021 13:26:01 +0000 (UTC)
Received: from T590 (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ED749936;
        Tue,  1 Jun 2021 13:25:55 +0000 (UTC)
Date:   Tue, 1 Jun 2021 21:25:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block/genhd: use atomic_t for disk_event->block
Message-ID: <YLY1V/dTMeo3RGZd@T590>
References: <20210601110145.113365-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601110145.113365-1-hare@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 01:01:45PM +0200, Hannes Reinecke wrote:
> __disk_unblock_events() will call queue_delayed_work() with a '0' argument
> under a spin lock. This might cause the queue_work item to be executed
> immediately, and run into a deadlock in disk_check_events() waiting for
> the lock to be released.

Do you have lockdep warning on this 'deadlock'?

Executed immediately doesn't mean the work fn is run in the current
task context, and it is actually run in one wq worker(task) context, so
__queue_work() usually wakes up one wq worker for running the work fn,
then there shouldn't be the 'deadlock' you mentioned.

Thanks, 
Ming

