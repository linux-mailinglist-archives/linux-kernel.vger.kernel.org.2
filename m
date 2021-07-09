Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C193C27B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 18:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhGIQpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 12:45:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 12:45:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 94C0822329;
        Fri,  9 Jul 2021 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625848978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2GqMGaeS7pORjjou7yseLa8mm5Ypx7LyOSQJgsBCm4c=;
        b=AwMFv4Jl+bcWd9Xaa/+25xWXOMrQ3RMDLYQ8rZGrMYXOS0hpxj8qyOjter2LAqPdwzj4rr
        BmkgM9p35ZPIACyax/m7J90oCQPjhzlmkcelLlKf2ITsWdzHeYAZaHs8Zb+pZrd5dSkPAX
        3t3AlPsl6Z6xvngGIR30fxNGd9okvio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625848978;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2GqMGaeS7pORjjou7yseLa8mm5Ypx7LyOSQJgsBCm4c=;
        b=xQWc6hy5FIe7GG7mws6bWprl9NKG3d7M+l1cH0JqxpMWYdQYhG2L15gZDX5CbasBVxtvgj
        523ocLsybbmxZeDw==
Received: from localhost (unknown [10.163.25.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B4D1CA3B9B;
        Fri,  9 Jul 2021 16:42:57 +0000 (UTC)
Date:   Fri, 9 Jul 2021 18:42:57 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 5/5] nvme-fc: Freeze queues before destroying them
Message-ID: <20210709164257.hzbxrbgjnnooidqe@beryllium.lan>
References: <20210708092755.15660-1-dwagner@suse.de>
 <20210708092755.15660-6-dwagner@suse.de>
 <cd630e81-68c9-c62d-de73-8b0ae33c2cfe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd630e81-68c9-c62d-de73-8b0ae33c2cfe@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Jul 09, 2021 at 09:14:07AM -0700, James Smart wrote:
> Thanks for the note. that definitely helped follow what is being attempted.
> I also agree with Hannes that the comment from the rdma patch should also be
> present to understand what's going on.

Sure will do. Though this has to wait until I am back from holiday
though :)

> Looking at the patch - this is not done in the same place or manner as rdma.
> Freezing and stoppage is prior to cancelling and that doesn't correspond
> where this was added (this is after all cancellations). We also seem to be
> missing a nvme_sync_io_queues() call in the sequence as well. So I believe
> there's more work to be done on this patch.  I'll see what I can do.

Thanks!

> We really need to see about a common layer for transports. So much we do is
> similar. We were ok at the start, but we've drifted apart over time and the
> requirements to the core layer aren't propogating to all transports.

Yes, makes a lot of sense to me to sync the transports implementation a
bit more.

Thanks,
Daniel
