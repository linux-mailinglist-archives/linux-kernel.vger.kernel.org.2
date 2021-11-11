Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008C244DDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 23:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhKKWvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 17:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhKKWvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 17:51:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C781C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 14:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=P8dbu6bq4K+PWUujkU4hjoft1+fqI27MatlMJ/QyGuI=; b=DIEtXFmC2F85m71vwyPLcjKOQk
        XjZEbHKR4s6o9R+TJFbZJAX5w6NIoGC4G7Tyr4UiU2sDuxm/bM/DqzgQfEXijaLfYzbsZMB+nW2Pg
        3fS5axfaKR/QoXehw3rpT5x08XLk3pdS95g4GbvhgzZTXlpNNp6aQoUMl8nKH29W8h0noSg8OSL0n
        bfGMRaMuz1qL/dM15gvBb/UkqsFSNFor48hNDm5vJjOo3uKFAeVY6JWhl++NRpUh8COLKxDqePUS7
        nbT7OL0ngCIQOs/4Ikle6bmn7BGmq4XLLkOsvsgEBmXO9v2HT1XAil0vxpAZBxgPPz22kmyXqe6R9
        rLTU1SPQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlIrp-008vaU-R6; Thu, 11 Nov 2021 22:48:25 +0000
Date:   Thu, 11 Nov 2021 14:48:25 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     mst@redhat.com, david@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Subject: update_balloon_size_func blocked for more than 120 seconds
Message-ID: <YY2duTi0wAyAKUTJ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following splats with a kvm guest in idle, after a few seconds
it starts:

[  242.412806] INFO: task kworker/6:2:271 blockedfor more than 120 seconds.
[  242.415790]       Tainted: G            E     5.15.0-next-20211111 #68
[  242.417755] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  242.418332] task:kworker/6:2     state:D stack:    0 pid:  271 ppid: 2 flags:0x00004000
[  242.418954] Workqueue: events_freezable update_balloon_size_func [virtio_balloon]
[  242.419518] Call Trace:
[  242.419709]  <TASK>
[  242.419873]  __schedule+0x2fd/0x990
[  242.420142]  schedule+0x4e/0xc0
[  242.420382]  tell_host+0xaa/0xf0 [virtio_balloon]
[  242.420757]  ? do_wait_intr_irq+0xa0/0xa0
[  242.421065]  update_balloon_size_func+0x2c9/0x2e0 [virtio_balloon]
[  242.421527]  process_one_work+0x1e5/0x3c0
[  242.421833]  worker_thread+0x50/0x3b0
[  242.422204]  ? rescuer_thread+0x370/0x370
[  242.422507]  kthread+0x169/0x190
[  242.422754]  ? set_kthread_struct+0x40/0x40
[  242.423073]  ret_from_fork+0x1f/0x30
[  242.423347]  </TASK>

And this goes on endlessly. The last one says it blocked for more than 1208
seconds. This was not happening until the last few weeks but I see no
relevant recent commits for virtio_balloon, so the related change could
be elsewhere.

I could bisect but first I figured I'd check to see if someone already
had spotted this.

  Luis
