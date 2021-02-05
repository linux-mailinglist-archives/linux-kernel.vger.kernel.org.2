Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A368A3112CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhBETGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 14:06:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230399AbhBETAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 14:00:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD39564F95;
        Fri,  5 Feb 2021 20:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612557718;
        bh=4ZWW8hUuPa5dPG125V2iEZsrPT8+OXIjRrQ4Rj9bvpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FHz7Uf3NdrqKvSuZsiFNBBbpgRUDEmNFQhvQUNxrBN3OVNylMmK2+610apgqB1IsO
         aR908QslNGt/1fDPzQrxp98ipXr7b6QqZ0vkAcUmjrEwtJ5Yhj3JrOk4OBJsDibIJf
         jb8MuIHp89Hqw60jV09vtiUCBQpYNBRKflgf7kV4=
Date:   Fri, 5 Feb 2021 12:41:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     Hugh Dickins <hughd@google.com>, Chris Down <chris@chrisdown.name>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Don't use 64-bit inodes by defulat with 32-bit
 ino_t
Message-Id: <20210205124157.c9d855a373362d7bf3d811a7@linux-foundation.org>
In-Reply-To: <20210205202159.505612-1-seth.forshee@canonical.com>
References: <20210205202159.505612-1-seth.forshee@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Feb 2021 14:21:59 -0600 Seth Forshee <seth.forshee@canonical.com> wrote:

> Currently there seems to be an assumption in tmpfs that 64-bit
> architectures also have a 64-bit ino_t. This is not true; s390 at
> least has a 32-bit ino_t. With CONFIG_TMPFS_INODE64=y tmpfs
> mounts will get 64-bit inode numbers and display "inode64" in the
> mount options, but passing the "inode64" mount option will fail.
> This leads to the following behavior:
> 
>  # mkdir mnt
>  # mount -t tmpfs nodev mnt
>  # mount -o remount,rw mnt
>  mount: /home/ubuntu/mnt: mount point not mounted or bad option.
> 
> As mount sees "inode64" in the mount options and thus passes it
> in the options for the remount.
> 
> Ideally CONFIG_TMPFS_INODE64 would depend on sizeof(ino_t) < 8,
> but I don't think it's possible to test for this (potentially
> CONFIG_ARCH_HAS_64BIT_INO_T or similar could be added, but I'm
> not sure whether or not that is wanted). So fix this by simply
> refusing to honor the CONFIG_TMPFS_INODE64 setting when
> sizeof(ino_t) < 8.

How about changing s390 Kconfig so that CONFIG_TMPFS_INODE64 is not enabled?

> Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

With a cc:stable, I assume?


