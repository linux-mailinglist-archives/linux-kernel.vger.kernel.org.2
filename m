Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078853B4313
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhFYMYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:24:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45434 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFYMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:24:18 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D04B421C99;
        Fri, 25 Jun 2021 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624623716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pAj1upETTIyHAZ/PkSRbshacc33JaBnwwpRJoNDa32c=;
        b=xyc6A4xctkd1tWu+GXqPEdu8UDgKldkATgON6UUtpNfDsstz8y7+RMNMAPpMdKgiD/Koce
        F8x6TQD1OA2Geetl2U4zF2ZnQNM82njAjVvey26iyUOURCUX2JRuXuoNFTO0BliMlAZ0vq
        XmkRALVOoiaGm9frJudpdSZvVXlMy6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624623716;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pAj1upETTIyHAZ/PkSRbshacc33JaBnwwpRJoNDa32c=;
        b=kfcmTV4mrN8XaQoL843ZMEYuw2Xgtc3ZZTjlz7IJmlEXmhN0pJSl7OlAy4Lk/v/iW5Cwjs
        X1lvSo5naec9mnCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BEB6511A97;
        Fri, 25 Jun 2021 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624623716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pAj1upETTIyHAZ/PkSRbshacc33JaBnwwpRJoNDa32c=;
        b=xyc6A4xctkd1tWu+GXqPEdu8UDgKldkATgON6UUtpNfDsstz8y7+RMNMAPpMdKgiD/Koce
        F8x6TQD1OA2Geetl2U4zF2ZnQNM82njAjVvey26iyUOURCUX2JRuXuoNFTO0BliMlAZ0vq
        XmkRALVOoiaGm9frJudpdSZvVXlMy6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624623716;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pAj1upETTIyHAZ/PkSRbshacc33JaBnwwpRJoNDa32c=;
        b=kfcmTV4mrN8XaQoL843ZMEYuw2Xgtc3ZZTjlz7IJmlEXmhN0pJSl7OlAy4Lk/v/iW5Cwjs
        X1lvSo5naec9mnCQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id /xKJLWTK1WBmRQAALh3uQQ
        (envelope-from <dwagner@suse.de>); Fri, 25 Jun 2021 12:21:56 +0000
Date:   Fri, 25 Jun 2021 14:21:56 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] Handle update hardware queues and queue freeze more
 carefully
Message-ID: <20210625122156.x5yzoobuaaec5hss@beryllium.lan>
References: <20210625101649.49296-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625101649.49296-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 12:16:47PM +0200, Daniel Wagner wrote:
> this is a followup on the crash I reported in
> 
>   https://lore.kernel.org/linux-block/20210608183339.70609-1-dwagner@suse.de/
> 
> By moving the hardware check up the crash was gone. Unfortuntatly, I
> don't understand why this fixes the crash. The per-cpu access is
> crashing but I can't see why the blk_mq_update_nr_hw_queues() is
> fixing this problem.
> 
> Even though I can't explain why it fixes it, I think it makes sense to
> update the hardware queue mapping bevore we recreate the IO
> queues. Thus I avoided in the commit message to say it fixes
> something.

I just discussed this with Hannes and we figured out how the crash is
fixed by moving the blk_mq_update_nr_hw_queues() before the
nvme_fc_create_hw_io_queues()/nvme_fc_connect_io_queues().

First of all, blk_mq_update_nr_hw_queues() operates on the normal
tag_set and not the admin_tag_set. That means when we move the
blk_mq_update_nr_hw_queues() before the nvme_fc_connect_io_queues(), we
update the mapping to only CPUs and hwctx which are available. When we
then do the connect call nvmf_connect_io_queue() we will only allocate
tags from queues which are not in the BLK_MQ_S_INACTIVE anymore. Hence
we skip the blk_mq_put_tag() call.

> Also during testing I observed the we hang indivinetly in
> blk_mq_freeze_queue_wait(). Again I can't explain why we get stuck
> there but given a common pattern for the nvme_wait_freeze() is to use
> it with a timeout I think the timeout should be used too :)

The nvme_wait_freeeze() is probably not needed at all,
__blk_mq_update_nr_hw_queues() already calls blk_mq_freeze_queue(). So
there this is not needed at all. Furthermore, if we move
blk_mq_update_nr_hw_queues() in front of nvme_fc_create_hw_io_queues()
there can't be any pending I/Os because there are not queues.
