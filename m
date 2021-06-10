Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4908D3A2E82
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFJOrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230280AbhFJOrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623336344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DaR8EEvOWwwKbyA2/NyEHgRAALNGyhbJ1RDxYMv5YZk=;
        b=brFq/QaXAc5kXPHcK92SY61T7K0AMIAiimZXK3O/g7s0ve4aBZijk28aaVUoYXv6lN0vXZ
        HGWfoqeuWXJ93yQ2qrnddJFbkIBU50Tx6VECj5IPQPYYniUkSpsGfN8dFNF9yz86We7M0S
        qE4Y30II6ATIYbJ+NKZSuW7on0um3vM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-xsx70SySNLuKK79ZOrNWiQ-1; Thu, 10 Jun 2021 10:45:43 -0400
X-MC-Unique: xsx70SySNLuKK79ZOrNWiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 782A58049CD;
        Thu, 10 Jun 2021 14:45:41 +0000 (UTC)
Received: from T590 (ovpn-13-145.pek2.redhat.com [10.72.13.145])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1067B100760F;
        Thu, 10 Jun 2021 14:45:34 +0000 (UTC)
Date:   Thu, 10 Jun 2021 22:45:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ingo Franzki <ifranzki@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juergen Christ <jchrist@linux.ibm.com>
Subject: Re: loop_set_block_size: loop0 () has still dirty pages (nrpages=2)
Message-ID: <YMIliuPi2tTLUJxv@T590>
References: <8bed44f2-273c-856e-0018-69f127ea4258@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bed44f2-273c-856e-0018-69f127ea4258@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 02:01:29PM +0200, Ingo Franzki wrote:
> Hi all,
> 
> we occasionally encounter a problem when setting up a loop device in one of our automated testcases.
> 
> We set up a loop device as follows:
> 
>     # dd if=/dev/zero of=/var/tmp/loopbackfile1.img bs=1M count=2500 status=none
>     # losetup --sector-size 4096 -fP --show /var/tmp/loopbackfile1.img
> 
> This works fine most of the times, but in the seldom case of the error, we get 'losetup: /var/tmp/loopbackfile1.img: failed to set up loop device: Resource temporarily unavailable'.
> 
> I am sure that no other loop device is currently defined, so we don't run out of loop devices.
> 
> We also see the following message in the syslog when the error occurs:
> 
>      loop_set_block_size: loop0 () has still dirty pages (nrpages=2)
> 
> The nrpages number varies from time to time. 
> 
> "Resource temporarily unavailable" is EAGAIN, and function loop_set_block_size() in drivers/block/loop.c returns this after printing the syslog message via pr_warn:
> 
> static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
> {
> 	int err = 0;
> 
> 	if (lo->lo_state != Lo_bound)
> 		return -ENXIO;
> 
> 	err = loop_validate_block_size(arg);
> 	if (err)
> 		return err;
> 
> 	if (lo->lo_queue->limits.logical_block_size == arg)
> 		return 0;
> 
> 	sync_blockdev(lo->lo_device);
> 	invalidate_bdev(lo->lo_device);
> 
> 	blk_mq_freeze_queue(lo->lo_queue);
> 
> 	/* invalidate_bdev should have truncated all the pages */
> 	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
> 		err = -EAGAIN;
> 		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
> 			__func__, lo->lo_number, lo->lo_file_name,
> 			lo->lo_device->bd_inode->i_mapping->nrpages);
> 		goto out_unfreeze;
> 	}
> 
> 	blk_queue_logical_block_size(lo->lo_queue, arg);
> 	blk_queue_physical_block_size(lo->lo_queue, arg);
> 	blk_queue_io_min(lo->lo_queue, arg);
> 	loop_update_dio(lo);
> out_unfreeze:
> 	blk_mq_unfreeze_queue(lo->lo_queue);
> 
> 	return err;
> }
> 
> So looks like invalidate_bdev() did actually not truncate all the pages under some circumstances....
> 
> The problem only happens when '--sector-size 4096' is specified, with the default sector size is always works. It does not call loop_set_block_size() in the default case I guess.
> 
> The loop0 device has certainly be used by other testcases before, most likely with the default block size. But at the time of this run, no loop device is currently active (losetup shows nothing). 
> 
> Anyone have an idea what goes wrong here? 

It returns '-EAGAIN' to ask userspace to try again.

I understand loop_set_block_size() doesn't prevent page cache of this
loop disk from being dirtied, so it isn't strange to
see lo_device->bd_inode->i_mapping->nrpages isn't zero after sync_blockdev()
& invalidate_bdev() on loop.

> 
> This happens on upstream kernels on the s390x platform, but I can't tell if is related to the platform or a specific kernel version. 

It can be reproduced easily when you run buffered write on loop disk,
meantime keeping to change block size from one to another on this loop.


Thanks,
Ming

