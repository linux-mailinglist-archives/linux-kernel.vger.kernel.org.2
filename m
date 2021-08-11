Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3CD3E8786
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 03:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbhHKBHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 21:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235974AbhHKBHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 21:07:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DAED60EE7;
        Wed, 11 Aug 2021 01:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628644040;
        bh=Kzw3EE08cLDDxpFKCb5ghCcQ8BT9rSSf34MuXPqd2js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkpMUw07zaqXpsN6IamkLlptJqRCTggAPkqO/kzKQN5yd9b7wECe4OB5fi0lNoRqE
         bqCVEAoTAuJf5bWouBr88yLnquj85hY/QYn/TlutxszsuF1bKui8XIqitQ3myBBzel
         mp8UzrJbehkoPX/zciSaxEyWwrwgtrAolPzV+ewDdgJwj22DRfBzVsBHMh8yl9y08g
         u8PHKj+UM5hlOeaBX3yVljGP1z313P2kVNxaSQVmG8QS7kWrk+ESFTKU3ZIjRbd/z4
         mI30XJn7GN/byHrxo+dS8KaYvCUypoOsQDQXSjQN9h8yPIfmKHQ+lAbXuU4DPUQ4a+
         d2KV7TWJLT7xg==
Date:   Tue, 10 Aug 2021 18:07:18 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
Message-ID: <20210811010718.GA3135947@dhcp-10-100-145-180.wdc.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-3-dwagner@suse.de>
 <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
 <20210809085250.xguvx5qiv2gxcoqk@carbon>
 <01d7878c-e396-1d6b-c383-8739ca0b3d11@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d7878c-e396-1d6b-c383-8739ca0b3d11@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 06:00:37PM -0700, Sagi Grimberg wrote:
> 
> 
> On 8/9/21 1:52 AM, Daniel Wagner wrote:
> > Hi Sagi,
> > 
> > On Fri, Aug 06, 2021 at 12:57:17PM -0700, Sagi Grimberg wrote:
> > > > -	ret = nvme_tcp_start_io_queues(ctrl);
> > > > -	if (ret)
> > > > -		goto out_cleanup_connect_q;
> > > > -
> > > > -	if (!new) {
> > > > -		nvme_start_queues(ctrl);
> > > > +	} else if (prior_q_cnt != ctrl->queue_count) {
> > > 
> > > So if the queue count did not change we don't wait to make sure
> > > the queue g_usage_counter ref made it to zero? What guarantees that it
> > > did?
> > 
> > Hmm, good point. we should always call nvme_wait_freeze_timeout()
> > for !new queues. Is this what you are implying?
> 
> I think we should always wait for the freeze to complete.

Don't the queues need to be started in order for the freeze to complete?
Any enqueued requests on the quiesced queues will never complete this
way, so the wait_freeze() will be stuck, right? If so, I think the
nvme_start_queues() was in the correct place already.
