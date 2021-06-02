Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD43398160
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFBGtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229966AbhFBGtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622616454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HVcJbN/KT1+fyetrnk2iAeiqGIXFm+abamxXaSbzX64=;
        b=aCbniVSoxED9tvY13FSMQ9T8Z9BrqtnWGZYYW4BtXTlv/zStbXb58SK60i3XrnFknFhVLG
        Et91Gbd4kKUElewNhOKP2LxG2EsKuyeCvUU7QP0MOAGjo0RgOv032Y9ff1icCV10LwNYU9
        IQjvEYZHmIDQnyS6KkC3lbZjIm2lgNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-09wOAkscMgeBsiscxpu5_A-1; Wed, 02 Jun 2021 02:47:31 -0400
X-MC-Unique: 09wOAkscMgeBsiscxpu5_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5B6E107ACE8;
        Wed,  2 Jun 2021 06:47:29 +0000 (UTC)
Received: from T590 (ovpn-13-164.pek2.redhat.com [10.72.13.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 459DFE460;
        Wed,  2 Jun 2021 06:47:22 +0000 (UTC)
Date:   Wed, 2 Jun 2021 14:47:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] block/genhd: use atomic_t for disk_event->block
Message-ID: <YLcpdKnt28vS6waI@T590>
References: <20210602062015.33605-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602062015.33605-1-hare@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 08:20:15AM +0200, Hannes Reinecke wrote:
> __disk_unblock_events() will call queue_delayed_work() with a '0' argument
> under a spin lock. This might cause the queue_work item to be executed
> immediately, and run into a deadlock in disk_check_events() waiting for
> the lock to be released.

The above commit log isn't correct, and the current usage shouldn't cause such
deadlock, so can you root cause the task hang report[1] on 5.3.18?

[1] https://lore.kernel.org/linux-block/73783f6f-a3ec-907f-ea19-966e9d1457dc@suse.de/T/#mcde381522bdb95740e04ced555ec017a25c993cc

Thanks,
Ming

