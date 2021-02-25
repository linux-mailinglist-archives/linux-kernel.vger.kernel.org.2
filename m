Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DFB3241F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhBXQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:17:48 -0500
Received: from verein.lst.de ([213.95.11.211]:38442 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233896AbhBXQOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:14:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1EC7968BEB; Wed, 24 Feb 2021 17:14:05 +0100 (CET)
Date:   Wed, 24 Feb 2021 17:14:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, "Ewan D . Milne" <emilne@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/3] block: avoid to drop & re-add partitions if
 partitions aren't changed
Message-ID: <20210224161402.GB9127@lst.de>
References: <20210224035830.990123-1-ming.lei@redhat.com> <20210224081825.GA1339@lst.de> <YDY3SqyNTeiYMdpG@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDY3SqyNTeiYMdpG@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 07:23:54PM +0800, Ming Lei wrote:
> > > The two patches changes block ioctl(BLKRRPART) for avoiding drop &
> > > re-add partitions if partitions state isn't changed. The current
> > > behavior confuses userspace because partitions can disappear anytime
> > > when calling into ioctl(BLKRRPART).
> > 
> > Which is the f***king point of BLKRRPART and the behavior it had
> > since day 1.  Please fix the application(s) that all it all the time
> > instead of bloating the kernel, as said before.
> > 
> 
> ioctl(BLKRRPART) can be called without changing partition table in
> fdisk, cfdisk, sfdisk, systemd and blockdev at least, and it isn't only
> on one single application. Even for blockdev, not sure if it can be fixed
> because '--rereadpt' is simply one subcommand.

I can also do all kinds of other bad things when I really want to.  So
if a privileged user uses *fdisk, or explicitly calls
blockdev --rereadpt, we can expect this behavior, and all of them above
should not be frequent.

It seems like the main culprit is systemd, so please look into what is
going wrong there.
