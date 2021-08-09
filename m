Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA9A3E41EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhHII63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:58:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39460 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbhHII62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:58:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ADD161FDAD;
        Mon,  9 Aug 2021 08:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628499487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DcWWQK19Xa6GOBXM7LflCcqBUTWsQXKfbG2mDyL0SxU=;
        b=padfdtL4ld65kA1j8ASFunpTuCaQEeDyeltyz6XAOhqz+lA7V01Vkx08xKncHn8cXQN15B
        FcjnC0XRgwDa7iRVNGgiiP5MeDchU1WbdMa2I06fIzTlfKCzJSBfHTCNFftPLrlssgkt5D
        fg/ZIMh06KcKGDEHaZx1mBhezmfPnpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628499487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DcWWQK19Xa6GOBXM7LflCcqBUTWsQXKfbG2mDyL0SxU=;
        b=tEH0w+p3OnOz/t86IhLTtsNTIxHjArVIP4uUz0SIdIA6/6AIE+7gPMhivvQcO8vJJygI9g
        upu+H6b3V9IsatCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9CE43132AB;
        Mon,  9 Aug 2021 08:58:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id FIfbJR/uEGG6KwAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 09 Aug 2021 08:58:07 +0000
Date:   Mon, 9 Aug 2021 10:58:07 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v4 8/8] nvme-rdma: Unfreeze queues on reconnect
Message-ID: <20210809085807.p5agrbuqxhlznmkr@carbon>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-9-dwagner@suse.de>
 <46d4d7cb-314a-3822-f59d-00588609421a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d4d7cb-314a-3822-f59d-00588609421a@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi,

On Fri, Aug 06, 2021 at 12:59:15PM -0700, Sagi Grimberg wrote:
> 
> > During the queue teardown in nvme_rdma_teardown_io_queues() freeze is
> > called unconditionally. When we reconnect we need to pair the freeze
> > with an unfreeze to avoid hanging I/Os. For newly created connection
> > this is not needed.
> > 
> > Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >   drivers/nvme/host/rdma.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > index de2a8950d282..21a8a5353af0 100644
> > --- a/drivers/nvme/host/rdma.c
> > +++ b/drivers/nvme/host/rdma.c
> > @@ -901,6 +901,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
> >   			error = PTR_ERR(ctrl->ctrl.admin_q);
> >   			goto out_cleanup_fabrics_q;
> >   		}
> > +	} else {
> > +		nvme_unfreeze(&ctrl->ctrl);
> 
> That seems misplaced.. unfreezing the I/O queues when setting up the admin
> queue?

Indeed. After looking again on it, this should be almost identically to
the tcp.c fix in nvme_rdma_configure_io_queues.

BTW, I am working on getting a RDMA test setup running. Hopefully I have
all the right licenses on the array.

Daniel
