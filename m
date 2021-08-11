Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F17D3E8E96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbhHKK0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:26:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50720 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbhHKK0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:26:17 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C49081FE29;
        Wed, 11 Aug 2021 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628677553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dIVroiF9CWXaHpVcigCtxn4G9TJ5tno4t7MoqivtmBE=;
        b=b+SuKVfs3TEK9nrziOok74mNZMgUtiymJF99t0VR8N6PbJOj4rqd7s7kiJeR5uwkFJE3V1
        qUuRkJhU8f8/CcC6xfB8bQ3ZpF2d4GnhJg1XqaXKt8Voxto9QGaBYOa1VSDjUz72YRjtih
        Dfku/ugQMlkKEyOeoAWGJMbPyGnXvFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628677553;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dIVroiF9CWXaHpVcigCtxn4G9TJ5tno4t7MoqivtmBE=;
        b=88LED16uP9Jki6B+ocpzbFNhVd5PaojtVuvOjAht+8CLWYWTDGJ9K3HcZ5vgvumzwoISXg
        sp9gxICXsIV91YAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id ABDC8131F5;
        Wed, 11 Aug 2021 10:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id MS2KKbGlE2GbDgAAGKfGzw
        (envelope-from <dwagner@suse.de>); Wed, 11 Aug 2021 10:25:53 +0000
Date:   Wed, 11 Aug 2021 12:25:53 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
Message-ID: <20210811102553.auradulozluc5ond@carbon.lan>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-3-dwagner@suse.de>
 <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
 <20210809085250.xguvx5qiv2gxcoqk@carbon>
 <01d7878c-e396-1d6b-c383-8739ca0b3d11@grimberg.me>
 <20210811010718.GA3135947@dhcp-10-100-145-180.wdc.com>
 <079108ce-6ca0-800e-e3df-29d015a4530c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <079108ce-6ca0-800e-e3df-29d015a4530c@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 10:57:58PM -0700, Sagi Grimberg wrote:
> > > I think we should always wait for the freeze to complete.
> > 
> > Don't the queues need to be started in order for the freeze to complete?
> > Any enqueued requests on the quiesced queues will never complete this
> > way, so the wait_freeze() will be stuck, right? If so, I think the
> > nvme_start_queues() was in the correct place already.
> 
> Exactly what I was trying to point out (poorly though)

Thanks for explaining. I think I got the general idea what the different
states are doing and what the transitions are now. (famous last words).

Anyway, the first three patches are the result of debugging the case of
'prior_ioq_cnt != nr_io_queues'. Starting the queues before updating the
number of queues lookes strange.

I suppose in the case 'prior_ioq_cnt > nr_io_queues',
nvme_tcp_start_io_queues() should be successful and we do the
blk_mq_update_nr_hw_queues(). In the other case we should land in the
error recovery.

Wouldn't it make sense to always exercise the error recovery path if we
detect 'prior_ioq_cnt != nr_io_queues' and reduce the number of things
which can go wrong?

Daniel
