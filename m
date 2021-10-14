Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D242D217
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhJNGGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:06:32 -0400
Received: from verein.lst.de ([213.95.11.211]:48689 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhJNGGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:06:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC47068B05; Thu, 14 Oct 2021 08:04:23 +0200 (CEST)
Date:   Thu, 14 Oct 2021 08:04:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Cleanup per-namespace chardev deletion
Message-ID: <20211014060422.GA24897@lst.de>
References: <CGME20211013150421uscas1p297a8bd51cf3f3b68dcef3a1c87da2959@uscas1p2.samsung.com> <20211013150413.320133-1-a.manzanares@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013150413.320133-1-a.manzanares@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 03:04:19PM +0000, Adam Manzanares wrote:
> Decrease reference count of chardevice during char device deletion in order to
> fix a kmemleak. Add relese function for the device associated chardev and moved
> ida_simple_remove into the release function.
> 
> Fixes: 2637bae (nvme: introduce generic per-namespace chardev)
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>

This looks good, but the subject seems wrong.  This isn't a cleanup
but a fix.  I can fix up the subject when applying it.
