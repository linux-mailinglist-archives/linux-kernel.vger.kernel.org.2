Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9873DB7E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 13:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbhG3LeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 07:34:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52480 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhG3LeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 07:34:21 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46D812234D;
        Fri, 30 Jul 2021 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627644856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kX5/D1kNNfSxnELQugyjnXmfspN2PAywSz5Hr8O+2hc=;
        b=vYLzoLXcRbkJU8My1j7TsQfqNInHzfxhGBGKYmN7aqJGXn/eZnN8aEK1AtHmVIMOb79HWI
        i7bX9RaoGbAgN3ZBrJJU9ICi5GRY1BkdbgCwVWELlYvRzK/erZGp4TuWQh9OlU6xsQf8co
        GdJw2nGJieVlAyJSwI3iFGi2v2EFWBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627644856;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kX5/D1kNNfSxnELQugyjnXmfspN2PAywSz5Hr8O+2hc=;
        b=UrkA6GbCMHP3sMMNHq+PtPdL1iKnNJqr8FuCJS79mt7bo0aA4c4J7iENK8rgVQ5Ki0FiNU
        ac6+2Strx7S6bVCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 36C6B137C2;
        Fri, 30 Jul 2021 11:34:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id u1UhDbjjA2FWRwAAGKfGzw
        (envelope-from <dwagner@suse.de>); Fri, 30 Jul 2021 11:34:16 +0000
Date:   Fri, 30 Jul 2021 13:34:15 +0200
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
Message-ID: <20210730113415.wezsrvxv5cu4yz4x@beryllium.lan>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124800.i2lo3hal7kjfc7rk@beryllium.lan>
 <20210726172704.j6cbv2qmox2cl2dz@beryllium.lan>
 <20210730094907.5vg7qebggttibogz@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730094907.5vg7qebggttibogz@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 11:49:07AM +0200, Daniel Wagner wrote:
> On Mon, Jul 26, 2021 at 07:27:04PM +0200, Daniel Wagner wrote:
> > FTR, I've tested the 'prior_ioq_cnt != nr_io_queues' case. In this
> > scenario the series works. Though in the case of 'prior_ioq_cnt ==
> > nr_io_queues' I see hanging I/Os.
> 
> Back on starring on this issue. So the hanging I/Os happen in this path
> after a remote port has been disabled:

It turns out, the same happens with TCP as transport. I've got two
connection configured and block traffic on the target side with
iptables rules. This is what I see

 nvme nvme16: creating 80 I/O queues.
 nvme nvme16: mapped 80/0/0 default/read/poll queues.
 nvme nvme16: new ctrl: NQN "nqn.2014-08.org.nvmexpress:NVMf:uuid:de63429f-50a4-4e03-ade6-0be27b75be77", addr 10.161.8.24:4420
 nvme nvme17: creating 80 I/O queues.
 nvme nvme17: mapped 80/0/0 default/read/poll queues.
 nvme nvme17: new ctrl: NQN "nqn.2014-08.org.nvmexpress:NVMf:uuid:de63429f-50a4-4e03-ade6-0be27b75be77", addr 10.161.8.24:4421
 nvme nvme17: starting error recovery
 nvme nvme17: failed nvme_keep_alive_end_io error=10
 nvme nvme17: Reconnecting in 10 seconds...
 nvme nvme17: failed to connect socket: -110
 nvme nvme17: Failed reconnect attempt 1
 nvme nvme17: Reconnecting in 10 seconds...
 nvme nvme17: failed to connect socket: -110
 nvme nvme17: Failed reconnect attempt 2
 nvme nvme17: Reconnecting in 10 seconds...
 nvme nvme17: creating 80 I/O queues.
 nvme nvme17: Successfully reconnected (3 attempt)

 Call Trace:
  __schedule+0x2d7/0x8f0
  schedule+0x3c/0xa0
  blk_queue_enter+0x106/0x1f0
  ? wait_woken+0x80/0x80
  submit_bio_noacct+0x116/0x4b0
  ? submit_bio+0x4b/0x1a0
  submit_bio+0x4b/0x1a0
  __blkdev_direct_IO_simple+0x20c/0x350
  ? blkdev_iopoll+0x30/0x30
  ? blkdev_direct_IO+0x4a2/0x520
  blkdev_direct_IO+0x4a2/0x520
  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
  ? generic_file_read_iter+0x84/0x140
  ? __blkdev_direct_IO_simple+0x350/0x350
  generic_file_read_iter+0x84/0x140
  blkdev_read_iter+0x41/0x50
  new_sync_read+0x118/0x1a0
  vfs_read+0x15a/0x180
  ksys_pread64+0x71/0x90
  do_syscall_64+0x3c/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

I think all transport handle the unfreezing incorrectly in the
recovering path. At least for TCP and FC I could test this. I don't have
and RDMA setup but this code looks suspiciously the same.. I think the
nvme_unfreeze() needs to be called always not just in the case where the
number of queues change.
