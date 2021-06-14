Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4461E3A5EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhFNJAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:00:04 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:59441 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:00:02 -0400
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 247DD100008;
        Mon, 14 Jun 2021 08:57:55 +0000 (UTC)
Date:   Mon, 14 Jun 2021 01:57:54 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v3 0/3] 9p: add support for root file systems
Message-ID: <YMcaEq95T+1GxZz2@localhost>
References: <20210606230922.77268-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606230922.77268-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 07:09:19AM +0800, Changbin Du wrote:
> Just like cifs and nfs, this short series enables rootfs support for 9p.
> Bellow is an example which mounts v9fs with tag 'r' as rootfs in qemu
> guest via virtio transport.
> 
>   $ qemu-system-x86_64 -enable-kvm -cpu host -m 1024 \
>         -virtfs local,path=$rootfs_dir,mount_tag=r,security_model=passthrough,id=r \
>         -kernel /path/to/linux/arch/x86/boot/bzImage -nographic \
>         -append "root=/dev/v9fs v9fsroot=r,trans=virtio rw console=ttyS0 3"

Rather than inventing a pseudo-device /dev/v9fs for this, would it
potentially work to use the existing rootfstype and rootflags options
for this? rootfstype already determines what filesystem should be used
to mount the root, and rootflags already provides options for that
filesystem.

For instance, for the above example:
rootfstype=9p root=r rootflags=trans=virtio

That would require a bit of fiddling to make rootfstype=9p allow a root
that's just the mount_tag. If that isn't an option, then even with
root=/dev/v9fs I think it still makes sense to use the existing
rootflags for "trans=virtio" rather than creating a new "v9fsroot"
option for that.

- Josh Triplett
