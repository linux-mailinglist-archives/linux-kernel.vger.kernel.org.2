Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D04C3A5F05
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhFNJVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:21:48 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:53573 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:21:46 -0400
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 769E01BF20A;
        Mon, 14 Jun 2021 09:19:40 +0000 (UTC)
Date:   Mon, 14 Jun 2021 02:19:38 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v3 0/3] 9p: add support for root file systems
Message-ID: <YMcfKqbCq7ZWAyaO@localhost>
References: <20210606230922.77268-1-changbin.du@gmail.com>
 <YMcaEq95T+1GxZz2@localhost>
 <YMca+N0UiGNZ1lSm@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMca+N0UiGNZ1lSm@codewreck.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 06:01:44PM +0900, Dominique Martinet wrote:
> Josh Triplett wrote on Mon, Jun 14, 2021 at 01:57:54AM -0700:
> > On Mon, Jun 07, 2021 at 07:09:19AM +0800, Changbin Du wrote:
> > > Just like cifs and nfs, this short series enables rootfs support for 9p.
> > > Bellow is an example which mounts v9fs with tag 'r' as rootfs in qemu
> > > guest via virtio transport.
> > > 
> > >   $ qemu-system-x86_64 -enable-kvm -cpu host -m 1024 \
> > >         -virtfs local,path=$rootfs_dir,mount_tag=r,security_model=passthrough,id=r \
> > >         -kernel /path/to/linux/arch/x86/boot/bzImage -nographic \
> > >         -append "root=/dev/v9fs v9fsroot=r,trans=virtio rw console=ttyS0 3"
> > 
> > Rather than inventing a pseudo-device /dev/v9fs for this, would it
> > potentially work to use the existing rootfstype and rootflags options
> > for this? rootfstype already determines what filesystem should be used
> > to mount the root, and rootflags already provides options for that
> > filesystem.
> > 
> > For instance, for the above example:
> > rootfstype=9p root=r rootflags=trans=virtio
> > 
> > That would require a bit of fiddling to make rootfstype=9p allow a root
> > that's just the mount_tag. If that isn't an option, then even with
> > root=/dev/v9fs I think it still makes sense to use the existing
> > rootflags for "trans=virtio" rather than creating a new "v9fsroot"
> > option for that.
> 
> This doesn't work as is because of the way the code is written, if
> there's no block device associated with a root=x option right now it
> will lead to kernel panic.
> 
> I replied with folks in Cc but there's another thread on linux-fsdevel@
> with a more generic approach that will build a list of filesystems which
> don't require such a block device (either hardcoded with virtiofs and 9p
> or based on FS_REQUIRES_DEV), thread started there but there's a second
> patch hidden an more discussion below:
> https://lore.kernel.org/linux-fsdevel/20210608153524.GB504497@redhat.com/

The patch later on in that thread (either using a list of
non-block-device filesystems or the version referenced elsewhere that
uses a flag in the filesystem definition) looks really appealing! That's
exactly what I was hoping for. That gets us closer to directly
translating `mount -t type -o options rootdesc` into `rootfstype=type
rootflags=options root=rootdesc` in the general case, rather than having
special cases for different filesystems.
