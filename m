Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8147A3F28A7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhHTItM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:49:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41396 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhHTItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:49:11 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDA2F22137;
        Fri, 20 Aug 2021 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629449312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCaN0M5amMyZRXL8tzm/AX/hJ8arauZM7tvxoIPOVXY=;
        b=J6uwkYNyjhSkdRI9DQp/ktI23jMY43QGD4lspGzN7ETfV32kT89QCV/g6oDNNPY9BoI3ZI
        ewlvw+eL6vtEEqLBBCTfiEZj8vEqyDWw8bRKnxjQ45Lk6Ynt+mvkL5NGMET9PigBi4QDQ3
        w3cNKXgQ2FEkKo468F9hAyAXjQvqD7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629449312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCaN0M5amMyZRXL8tzm/AX/hJ8arauZM7tvxoIPOVXY=;
        b=3RlKmB/KCREuzvOCADE6fhAT5sFxtWEWxg4Mo7SDzTGdpLPioigWW9+mzLBwAvA4pQR/fa
        063pT9bYeXA3A1BQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AD6881333E;
        Fri, 20 Aug 2021 08:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kc8wKmBsH2FwTwAAGKfGzw
        (envelope-from <dwagner@suse.de>); Fri, 20 Aug 2021 08:48:32 +0000
Date:   Fri, 20 Aug 2021 10:48:32 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v5 0/3] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <20210820084832.nlsbiztn26fv3b73@carbon.lan>
References: <20210818120530.130501-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818120530.130501-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 02:05:27PM +0200, Daniel Wagner wrote:
> I've dropped all non FC patches as they were bogus. I've retested this
> version with all combinations and all looks good now. Also I gave
> nvme-tcp a spin and again all is good.

I forgot to mention I also dropped the first three patches from v4.
Which seems to break her testing again.

Wendy reported all her tests pass with Ming's V7 of 'blk-mq: fix
blk_mq_alloc_request_hctx' and this series *only* if 'nvme-fc: Update
hardware queues before using them' from previous version is also used.

After starring at it once more, I think I finally understood the
problem. So when we do

        ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
        if (ret)
                goto out_free_io_queues;

        ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
        if (ret)
                goto out_delete_hw_queues;

and the number of queues has changed, the connect call will fail:

 nvme2: NVME-FC{2}: create association : host wwpn 0x100000109b5a4dfa rport wwpn 0x50050768101935e5: NQN "nqn.1986-03.com.ibm:nvme:2145.0000020420006CEA"
 nvme2: Connect command failed, error wo/DNR bit: -16389

and we stop the current reconnect attempt and reschedule a new
reconnect attempt:

 nvme2: NVME-FC{2}: reset: Reconnect attempt failed (-5)
 nvme2: NVME-FC{2}: Reconnect attempt in 2 seconds

Then we try to do the same thing again which fails, thus we never
make progress.

So clearly we need to update number of queues at one point. What would
be the right thing to do here? As I understood we need to be careful
with frozen requests. Can we abort them (is this even possible in this
state?) and requeue them before we update the queue numbers?

Daniel
