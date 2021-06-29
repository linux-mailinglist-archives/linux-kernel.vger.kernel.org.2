Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E063B6EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 09:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhF2Huz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 03:50:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36030 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhF2Hux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 03:50:53 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 215BA20398;
        Tue, 29 Jun 2021 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624952906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CV14zOE2o7+HNtZtVdan87nKTgQqnJ5Go2CWe21xjUk=;
        b=QDxsnKbPRghqgAqqWVEiRz+w5+ijS7liI5ikU6MMxdK7m4GzIn9jMY9Y+yYj7UmYC+kyc+
        cenbI8MN8ZsTA4A7dST1BKK9QDnO744ZqhjwGbrrQH0MNA0TM+naI/gFIYyVp9Xx6EWrwS
        3Hfck6E+h3m5TOleQn0un/kg3BySvDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624952906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CV14zOE2o7+HNtZtVdan87nKTgQqnJ5Go2CWe21xjUk=;
        b=V2wOJ5LjAXx0XQg8S7Mqh47jnXdumcGjJE/Nf3YYVcfe3tLxPng+FqBTsJnbwRLnnID9vC
        9nE0Me8ypuK+DNDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 0CA3111906;
        Tue, 29 Jun 2021 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624952906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CV14zOE2o7+HNtZtVdan87nKTgQqnJ5Go2CWe21xjUk=;
        b=QDxsnKbPRghqgAqqWVEiRz+w5+ijS7liI5ikU6MMxdK7m4GzIn9jMY9Y+yYj7UmYC+kyc+
        cenbI8MN8ZsTA4A7dST1BKK9QDnO744ZqhjwGbrrQH0MNA0TM+naI/gFIYyVp9Xx6EWrwS
        3Hfck6E+h3m5TOleQn0un/kg3BySvDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624952906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CV14zOE2o7+HNtZtVdan87nKTgQqnJ5Go2CWe21xjUk=;
        b=V2wOJ5LjAXx0XQg8S7Mqh47jnXdumcGjJE/Nf3YYVcfe3tLxPng+FqBTsJnbwRLnnID9vC
        9nE0Me8ypuK+DNDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id mJkQAkrQ2mCVJQAALh3uQQ
        (envelope-from <dwagner@suse.de>); Tue, 29 Jun 2021 07:48:26 +0000
Date:   Tue, 29 Jun 2021 09:48:25 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <20210629074825.s5f2d3ihuyscktg3@beryllium.lan>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
 <YNp50pmlzN6M0kNX@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNp50pmlzN6M0kNX@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 09:39:30AM +0800, Ming Lei wrote:
> On Fri, Jun 25, 2021 at 12:16:49PM +0200, Daniel Wagner wrote:
> > Do not wait indifinitly for all queues to freeze. Instead use a
> > timeout and abort the operation if we get stuck.
> > 
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >  drivers/nvme/host/fc.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index a9645cd89eca..d8db85aa5417 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -2955,7 +2955,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
> >  		dev_info(ctrl->ctrl.device,
> >  			"reconnect: revising io queue count from %d to %d\n",
> >  			prior_ioq_cnt, nr_io_queues);
> > -		nvme_wait_freeze(&ctrl->ctrl);
> > +		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> > +			/*
> > +			 * If we timed out waiting for freeze we are likely to
> > +			 * be stuck.  Fail the controller initialization just
> > +			 * to be safe.
> > +			 */
> > +			return -ENODEV;
> > +		}
> >  		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
> >  		nvme_unfreeze(&ctrl->ctrl);
> 
> Can you investigate a bit on why there is the hang? FC shouldn't use
> managed IRQ, so the interrupt won't be shutdown.
> 
> blk-mq debugfs may help to dump the requests after the hang is triggered,
> or you still can add debug code in nvme_wait_freeze_timeout() to dump
> all requests if blk-mq debugfs doesn't work.

Sure thing, I'll try to find out why it hangs. The good thing is that I
was able to reliable reproduce it. So let's see.
