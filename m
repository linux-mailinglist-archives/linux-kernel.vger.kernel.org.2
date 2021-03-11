Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5263336F14
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhCKJnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:43:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:60188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhCKJnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:43:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC78DAC16;
        Thu, 11 Mar 2021 09:43:45 +0000 (UTC)
Date:   Thu, 11 Mar 2021 10:43:45 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi,

On Fri, Mar 05, 2021 at 11:57:30AM -0800, Sagi Grimberg wrote:
> Daniel, again, there is nothing specific about this to nvme-tcp,
> this is a safeguard against a funky controller (or a different
> bug that is hidden by this).

As far I can tell, the main difference between nvme-tcp and FC/NVMe,
nvme-tcp has not a FW or a big driver which filter out some noise from a
misbehaving controller. I haven't really checked the other transports
but I wouldn't surprised they share the same properties as FC/NVMe.

> The same can happen in any other transport so I would suggest that if
> this is a safeguard we want to put in place, we should make it a
> generic one.
> 
> i.e. nvme_tag_to_rq() that _all_ transports call consistently.

Okay, I'll review all the relevant code and see what could made more
generic and consistent.

Though I think nvme-tcp plays in a different league as it is exposed to
normal networking traffic and this is a very hostile environment.

Thanks,
Daniel
