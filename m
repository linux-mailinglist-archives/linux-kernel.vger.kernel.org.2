Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CED31137A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhBEV0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:26:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233209AbhBEVXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:23:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62EF764FBB;
        Fri,  5 Feb 2021 21:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612560194;
        bh=kRHZZ1h7x0Pk7KF/tYHb3v57j2RpZMRpvK1byyUmgJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MzobuA5zaLMYeNYL2TIiedzsv9DSS6n3wvB6ZeTBSejQDL5SK6YuCNEbEPa3itirl
         b06aLeEpIFLysSCaroHEdjZZJhLPtc7impfNYiz/2i0v5eG5V2R8ENTCc399D5dJ7g
         I/tG3RHfg97v98ZalHHEl9JTQLDFHRDc8B3OaJTg=
Date:   Fri, 5 Feb 2021 13:23:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     Hugh Dickins <hughd@google.com>, Chris Down <chris@chrisdown.name>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Don't use 64-bit inodes by defulat with 32-bit
 ino_t
Message-Id: <20210205132313.95ce9fd932ca96667fd5db83@linux-foundation.org>
In-Reply-To: <YB2wz8dKnjZv4bdT@ubuntu-x1>
References: <20210205202159.505612-1-seth.forshee@canonical.com>
        <20210205124157.c9d855a373362d7bf3d811a7@linux-foundation.org>
        <YB2wz8dKnjZv4bdT@ubuntu-x1>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 14:55:43 -0600 Seth Forshee <seth.forshee@canonical.com> wrote:

> On Fri, Feb 05, 2021 at 12:41:57PM -0800, Andrew Morton wrote:
> > On Fri,  5 Feb 2021 14:21:59 -0600 Seth Forshee <seth.forshee@canonical.com> wrote:
> > 
> > > Currently there seems to be an assumption in tmpfs that 64-bit
> > > architectures also have a 64-bit ino_t. This is not true; s390 at
> > > least has a 32-bit ino_t. With CONFIG_TMPFS_INODE64=y tmpfs
> > > mounts will get 64-bit inode numbers and display "inode64" in the
> > > mount options, but passing the "inode64" mount option will fail.
> > > This leads to the following behavior:
> > > 
> > >  # mkdir mnt
> > >  # mount -t tmpfs nodev mnt
> > >  # mount -o remount,rw mnt
> > >  mount: /home/ubuntu/mnt: mount point not mounted or bad option.
> > > 
> > > As mount sees "inode64" in the mount options and thus passes it
> > > in the options for the remount.
> > > 
> > > Ideally CONFIG_TMPFS_INODE64 would depend on sizeof(ino_t) < 8,
> > > but I don't think it's possible to test for this (potentially
> > > CONFIG_ARCH_HAS_64BIT_INO_T or similar could be added, but I'm
> > > not sure whether or not that is wanted). So fix this by simply
> > > refusing to honor the CONFIG_TMPFS_INODE64 setting when
> > > sizeof(ino_t) < 8.
> > 
> > How about changing s390 Kconfig so that CONFIG_TMPFS_INODE64 is not enabled?
> 
> I did do that for our config. I see the s390 defconfig has it enabled,
> so I will send a patch for that too. But the fact that it can be
> configured that way and that the code behaves badly still seems
> problematic.

I meant

--- a/fs/Kconfig~a
+++ a/fs/Kconfig
@@ -203,7 +203,7 @@ config TMPFS_XATTR
 
 config TMPFS_INODE64
 	bool "Use 64-bit ino_t by default in tmpfs"
-	depends on TMPFS && 64BIT
+	depends on TMPFS && 64BIT && !S390
 	default n
 	help
 	  tmpfs has historically used only inode numbers as wide as an unsigned
_


