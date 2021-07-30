Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715993DB649
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbhG3JtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:49:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37334 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbhG3JtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:49:12 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 74B0A220D6;
        Fri, 30 Jul 2021 09:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627638547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tX5/RKu0XyHgoigeyp4NrtKCQbkwtYgFDjsnzfQWEFc=;
        b=QGaXm8DUlon51mxMrT1Hh2u0EE1CIm+k6kIixk7k8iPh3Hbr4fuDDo4RhoNlEUoli6614f
        Ei9diSThe+C06mx8i/7bcBIFfiF1PsQUNluhxgbjCWTMyCRQPy/aEinV6jfPcRdL098HwQ
        YfzsYr9gDOWYjvF+C+Tv8nleLNr3XlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627638547;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tX5/RKu0XyHgoigeyp4NrtKCQbkwtYgFDjsnzfQWEFc=;
        b=9dls7owYLli88ake5BD2Hra8yJI665ZgEXUXF539xtnjS3hfENkA0NATgrWg8E7xra16mf
        b95qxhRpXUtl/LCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5F950137C2;
        Fri, 30 Jul 2021 09:49:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id y8H/FhPLA2FsKgAAGKfGzw
        (envelope-from <dwagner@suse.de>); Fri, 30 Jul 2021 09:49:07 +0000
Date:   Fri, 30 Jul 2021 11:49:07 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v3 0/6] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <20210730094907.5vg7qebggttibogz@beryllium.lan>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124800.i2lo3hal7kjfc7rk@beryllium.lan>
 <20210726172704.j6cbv2qmox2cl2dz@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726172704.j6cbv2qmox2cl2dz@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 07:27:04PM +0200, Daniel Wagner wrote:
> FTR, I've tested the 'prior_ioq_cnt != nr_io_queues' case. In this
> scenario the series works. Though in the case of 'prior_ioq_cnt ==
> nr_io_queues' I see hanging I/Os.

Back on starring on this issue. So the hanging I/Os happen in this path
after a remote port has been disabled:

 nvme nvme1: NVME-FC{1}: new ctrl: NQN "nqn.1992-08.com.netapp:sn.d646dc63336511e995cb00a0988fb732:subsystem.nvme-svm-dolin-ana_subsystem"
 nvme nvme1: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: connectivity re-established. Attempting reconnect
 nvme nvme1: NVME-FC{1}: create association : host wwpn 0x100000109b579ef6  rport wwpn 0x201900a09890f5bf: NQN "nqn.1992-08.com.netapp:sn.d646dc63336511e995cb00a0988fb732:subsystem.nvme-svm-dolin-ana_subsystem"
 nvme nvme1: NVME-FC{1}: controller connect complete

and all hanging tasks have the same call trace:

 task:fio             state:D stack:    0 pid:13545 ppid: 13463 flags:0x00000000
 Call Trace:
  __schedule+0x2d7/0x8f0
  schedule+0x3c/0xa0
  blk_queue_enter+0x106/0x1f0
  ? wait_woken+0x80/0x80
  submit_bio_noacct+0x116/0x4b0
  ? submit_bio+0x4b/0x1a0
  submit_bio+0x4b/0x1a0
  __blkdev_direct_IO_simple+0x20c/0x350
  ? update_load_avg+0x1ac/0x5e0
  ? blkdev_iopoll+0x30/0x30
  ? blkdev_direct_IO+0x4a2/0x520
  blkdev_direct_IO+0x4a2/0x520
  ? update_load_avg+0x1ac/0x5e0
  ? update_load_avg+0x1ac/0x5e0
  ? generic_file_read_iter+0x84/0x140
  ? __blkdev_direct_IO_simple+0x350/0x350
  generic_file_read_iter+0x84/0x140
  blkdev_read_iter+0x41/0x50
  new_sync_read+0x118/0x1a0
  vfs_read+0x15a/0x180
  ksys_pread64+0x71/0x90
  do_syscall_64+0x3c/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

(gdb) l *blk_queue_enter+0x106
0xffffffff81473736 is in blk_queue_enter (block/blk-core.c:469).
464                      * queue dying flag, otherwise the following wait may
465                      * never return if the two reads are reordered.
466                      */
467                     smp_rmb();
468
469                     wait_event(q->mq_freeze_wq,
470                                (!q->mq_freeze_depth &&
471                                 blk_pm_resume_queue(pm, q)) ||
472                                blk_queue_dying(q));
473                     if (blk_queue_dying(q))

