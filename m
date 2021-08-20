Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101723F2B98
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhHTL4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:56:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49768 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbhHTL4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:56:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B4EFD21F55;
        Fri, 20 Aug 2021 11:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629460521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TO8SPS42MqtUgER5AvlMEomQQplZq9qOHXpgo20Scrk=;
        b=kvs9bcNGubJH4ZnJkboxY/xli6iMNsaCm9srblPmUkUp9bC61imZQDz4eoQ3zMo70Obwxr
        yiFSOR4f56RmogCgx80MArxynga3Hs/FwILY6MmbWN1PHUn6nZI9QC9yKzCgvUKjZUVJrZ
        kUHGfJSPRAHm4k2doOCQgU9fsscS1EE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629460521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TO8SPS42MqtUgER5AvlMEomQQplZq9qOHXpgo20Scrk=;
        b=5knjeyv2pt/rSDf5q/9BS8fw8r+GScRhnWksQVbjUEnaQs7QCbHyk0CUNP1cSr2fXQIiio
        3wY3MN9CMPgpIeBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A388D13AD0;
        Fri, 20 Aug 2021 11:55:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id tSOtJymYH2FIfgAAGKfGzw
        (envelope-from <dwagner@suse.de>); Fri, 20 Aug 2021 11:55:21 +0000
Date:   Fri, 20 Aug 2021 13:55:21 +0200
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
Message-ID: <20210820115521.alveifzvad3zuwh4@carbon.lan>
References: <20210818120530.130501-1-dwagner@suse.de>
 <20210820084832.nlsbiztn26fv3b73@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820084832.nlsbiztn26fv3b73@carbon.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 10:48:32AM +0200, Daniel Wagner wrote:
> Then we try to do the same thing again which fails, thus we never
> make progress.
> 
> So clearly we need to update number of queues at one point. What would
> be the right thing to do here? As I understood we need to be careful
> with frozen requests. Can we abort them (is this even possible in this
> state?) and requeue them before we update the queue numbers?

After starring a bit longer at the reset path, I think there is no
pending request in any queue. nvme_fc_delete_association() calls
__nvme_fc_abort_outstanding_ios() which makes sure all queues are
drained (usage counter is 0). Also it clears the NVME_FC_Q_LIVE bit,
which prevents further request added to queues.

I start wonder why we have to do the nvme_start_freeze() in the first
place and why we want to wait for the freeze. 88e837ed0f1f ("nvme-fc:
wait for queues to freeze before calling update_hr_hw_queues") doesn't
really tell why we need wait for the freeze.

Given we know the usage counter of the queues is 0, I think we are
safe to move the blk_mq_update_nr_hw_queues() before the start queue
code. Also note nvme_fc_create_hw_io_queues() calls
blk_mq_freeze_queue() but it wont block as we are sure there is no
pending request.
