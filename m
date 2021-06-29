Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6ED3B7199
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhF2Lw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 07:52:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35958 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhF2Lwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 07:52:55 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EE9BA226B2;
        Tue, 29 Jun 2021 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624967427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2Jaf+knojwZG6YGLyThipmM8ejC5N7nj1/HB5+P0gY=;
        b=XYyYF7D37OzXkQOPyit0IEbShy6JrWRlL2rHoG51n2HyXMnIuJjHqczilDXxZ4oNbrcfFZ
        9aihhiz8eJwkoXza3CAkwzDvA8qsANpxwCw6Edp22LlKZB/T/APvr9FGyNFwSdqk4Qrycr
        TgURpcPVHo8GbiL68ijUXLl5BOiKdLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624967427;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2Jaf+knojwZG6YGLyThipmM8ejC5N7nj1/HB5+P0gY=;
        b=3kY8NFo+93qLZ9udZg+9iXyB7U+LV+y72OyUUFjPIqLx7y2JcxVY1LWwlnMAlOhYERhXCr
        hSqEt2szQsUYXZAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id D5AA911906;
        Tue, 29 Jun 2021 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624967427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2Jaf+knojwZG6YGLyThipmM8ejC5N7nj1/HB5+P0gY=;
        b=XYyYF7D37OzXkQOPyit0IEbShy6JrWRlL2rHoG51n2HyXMnIuJjHqczilDXxZ4oNbrcfFZ
        9aihhiz8eJwkoXza3CAkwzDvA8qsANpxwCw6Edp22LlKZB/T/APvr9FGyNFwSdqk4Qrycr
        TgURpcPVHo8GbiL68ijUXLl5BOiKdLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624967427;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2Jaf+knojwZG6YGLyThipmM8ejC5N7nj1/HB5+P0gY=;
        b=3kY8NFo+93qLZ9udZg+9iXyB7U+LV+y72OyUUFjPIqLx7y2JcxVY1LWwlnMAlOhYERhXCr
        hSqEt2szQsUYXZAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id fYEpMwMJ22AzNgAALh3uQQ
        (envelope-from <dwagner@suse.de>); Tue, 29 Jun 2021 11:50:27 +0000
Date:   Tue, 29 Jun 2021 13:50:27 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Wen Xiong <wenxiong@us.ibm.com>, james.smart@broadcom.com,
        linux-kernel@vger.kernel.org, sagi@grimberg.me,
        wenxiong@linux.vnet.ibm.com
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <20210629115027.rtohoxtl7cmycdqr@beryllium.lan>
References: <OFE573413D.44652DC5-ON00258703.000DB949-00258703.000EFCD4@ibm.com>
 <OF8889275F.DC758B38-ON00258703.001297BC-00258703.00143502@ibm.com>
 <YNqX6w8YHO61oqvY@T590>
 <20210629082542.vm3yh6k36d2zh3k5@beryllium.lan>
 <20210629083549.unco3f7atybqypw3@beryllium.lan>
 <YNrhXFgv/gEWbhbl@T590>
 <20210629092719.n33t2pnjiwwe6qun@beryllium.lan>
 <YNrpdy3pJ/3DIxpW@T590>
 <20210629094938.r3h5cb7wwu2v3r3m@beryllium.lan>
 <YNrwnWfsxf8cJcoe@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNrwnWfsxf8cJcoe@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 06:06:21PM +0800, Ming Lei wrote:
> > No, I don't see any errors. I am still trying to reproduce it on real
> > hardware. The setup with blktests running in Qemu did work with all
> > patches applied (the once from me and your patches).
> > 
> > About the error argument: Later in the code path, e.g. in
> > __nvme_submit_sync_cmd() transport errors (incl. canceled request) are
> > handled as well, hence the upper layer will see errors during connection
> > attempts. My point is, there is nothing special about the connection
> > attempt failing. We have error handling code in place and the above
> > state machine has to deal with it.
> 
> My two patches not only avoids the kernel panic, but also allow
> request to be allocated successfully, then connect io queue request can
> be submitted to driver even though all CPUs in hctx->cpumask is offline,
> then nvmef can be setup well.
> 
> That is the difference with yours to fail the request allocation, then
> connect io queues can't be done, and the whole host can't be setup
> successfully, then become a brick. The point is that cpu offline shouldn't
> fail to setup nvme fc/rdma/tcp/loop.

Right, I think I see your point now.

> > Anyway, avoiding the if in the hotpath is a good thing. I just don't
> > think your argument about no error can happen is correct.
> 
> Again, it isn't related with avoiding the if, and it isn't in hotpath
> at all.

I mixed up blk_mq_alloc_request() with blk_mq_alloc_request_hctx().

Thanks for the explanation. I'll keep trying to replicated the problem
on real hardware and see if these patches mitigate it.

Thanks,
Daniel
