Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90E3E41DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhHIIxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:53:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38330 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbhHIIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:53:11 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EE09E21F38;
        Mon,  9 Aug 2021 08:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628499170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bepQzvatgJLao+zb9C6j+oevlY4gKiK09Ngv42kE38g=;
        b=kl3QYAu24ESZk9XuMhHwyyKyrTXhxm8d0J0sTv1O9QwbpBj8HvMUuDZxbbwJ1M73InnMDP
        RLlFN9ZDGq9tSKeE5BYnLUSOZh6HOwEaaw4F5uqfGDiaOFoIYKra4nOVs2pLS1XcjvDXem
        x+DZPpgPZJKRMjCFq7UbW3wHc+KL/aU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628499170;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bepQzvatgJLao+zb9C6j+oevlY4gKiK09Ngv42kE38g=;
        b=R/7gyERwwF+oUn9XMq+YISSU0gyMc3Q8Y/uui8tCDQ/t7fzbAFA5xUMh7ItG4RUzm14vBz
        +lb5sbg8zLTp9BAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D3C23132AB;
        Mon,  9 Aug 2021 08:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id C/auM+LsEGFqKgAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 09 Aug 2021 08:52:50 +0000
Date:   Mon, 9 Aug 2021 10:52:50 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
Message-ID: <20210809085250.xguvx5qiv2gxcoqk@carbon>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-3-dwagner@suse.de>
 <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi,

On Fri, Aug 06, 2021 at 12:57:17PM -0700, Sagi Grimberg wrote:
> > -	ret = nvme_tcp_start_io_queues(ctrl);
> > -	if (ret)
> > -		goto out_cleanup_connect_q;
> > -
> > -	if (!new) {
> > -		nvme_start_queues(ctrl);
> > +	} else if (prior_q_cnt != ctrl->queue_count) {
> 
> So if the queue count did not change we don't wait to make sure
> the queue g_usage_counter ref made it to zero? What guarantees that it
> did?

Hmm, good point. we should always call nvme_wait_freeze_timeout()
for !new queues. Is this what you are implying?


> >   		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
> >   			/*
> >   			 * If we timed out waiting for freeze we are likely to
> > @@ -1828,6 +1822,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
> >   		nvme_unfreeze(ctrl);
> >   	}
> > +	ret = nvme_tcp_start_io_queues(ctrl);
> > +	if (ret)
> > +		goto out_cleanup_connect_q;
> > +
> 
> Did you test this with both heavy I/O, reset loop and ifdown/ifup
> loop?

Not sure if this classifies as heavy I/O (on 80 CPU machine)

fio --rw=readwrite --name=test --filename=/dev/nvme16n1 --size=50M \
    --direct=1 --bs=4k --numjobs=40 --group_reporting --runtime=4h \
    --time_based

and then I installed iptables rules to block the traffic on the
controller side. With this test it is pretty easily to get
the host hanging. Let me know what test you would like to see
from me. I am glad to try to get them running.

> If we unquiesce and unfreeze before we start the queues the pending I/Os
> may resume before the connect and not allow the connect to make forward
> progress.

So the unfreeze should happen after the connect call? What about the
newly created queues? Do they not suffer from the same problem? Isn't
the NVME_TCP_Q_LIVE flag not enough?

Daniel
