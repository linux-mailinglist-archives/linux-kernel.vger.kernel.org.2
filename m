Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8A4410A2B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 08:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhISGKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 02:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhISGKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 02:10:15 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D734FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 23:08:50 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRq0K-005Vgc-NS; Sun, 19 Sep 2021 06:08:45 +0000
Date:   Sun, 19 Sep 2021 06:08:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -rc] init: don't panic if mount_nodev_root failed
Message-ID: <YUbT7H4fD0KvnbLa@zeniv-ca.linux.org.uk>
References: <b83c61f6ab34c8f17672d88e0853a9d324c3d48a.1631610487.git.leonro@nvidia.com>
 <YUbOv01OaWh9fQHp@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUbOv01OaWh9fQHp@unreal>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 08:46:39AM +0300, Leon Romanovsky wrote:
> On Tue, Sep 14, 2021 at 12:12:10PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Attempt to mount 9p file system as root gives the following kernel panic:
> > 
> >  9pnet_virtio: no channels available for device root
> >  Kernel panic - not syncing: VFS: Unable to mount root "root" (9p), err=-2
> >  CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc1+ #127
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> >  Call Trace:
> >   dump_stack_lvl+0x45/0x59
> >   panic+0x1e2/0x44b
> >   ? __warn_printk+0xf3/0xf3
> >   ? free_unref_page+0x2d4/0x4a0
> >   ? trace_hardirqs_on+0x32/0x120
> >   ? free_unref_page+0x2d4/0x4a0
> >   mount_root+0x189/0x1e0
> >   prepare_namespace+0x136/0x165
> >   kernel_init_freeable+0x3b8/0x3cb
> >   ? rest_init+0x2e0/0x2e0
> >   kernel_init+0x19/0x130
> >   ret_from_fork+0x1f/0x30
> >  Kernel Offset: disabled
> >  ---[ end Kernel panic - not syncing: VFS: Unable to mount root "root" (9p), err=-2 ]---
> > 
> > QEMU command line:
> >  "qemu-system-x86_64 -append root=/dev/root rw rootfstype=9p rootflags=trans=virtio ..."
> > 
> > This error is because root_device_name is truncated in prepare_namespace() from
> > being "/dev/root" to be "root" prior to call to mount_nodev_root().
> > 
> > As a solution, don't treat errors in mount_nodev_root() as errors that
> > require panics and allow failback to the mount flow that existed before
> > patch citied in Fixes tag.
> > 
> > Fixes: f9259be6a9e7 ("init: allow mounting arbitrary non-blockdevice filesystems as root")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > I'm not sure if this is the right thing to do, but it works for me.
> > ---
> >  init/do_mounts.c | 3 ---
> >  1 file changed, 3 deletions(-)
> 
> Hi,
> 
> I assume that after Christoph gave his ROB [1], the patch is ok.
> Should I do anything else in order to progress with merging it?

Sits in the local pile; will go to Linus tomorrow...
