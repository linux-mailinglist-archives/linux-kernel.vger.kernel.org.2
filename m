Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D733113AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhBEVdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:33:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44862 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhBEVdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:33:25 -0500
Received: from mail-oo1-f70.google.com ([209.85.161.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1l88iX-0002UW-BQ
        for linux-kernel@vger.kernel.org; Fri, 05 Feb 2021 21:32:41 +0000
Received: by mail-oo1-f70.google.com with SMTP id w12so4300615ooo.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 13:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CEv7KXRFEUe4RabAT7u4Z8pYuWuDZpwIcUXyT5w5004=;
        b=Wr6u7PGzWuwpBajW2WMIjCEDHn9ySnI+Kz/C8l3338Z03zqxZmgamW5PFD/d7NH+pW
         ETP+iaityiE16NGhEY/AV8CJURkAJHM7vi+S2glKRAm6hOaCRyacGTZ9WTPc0kQ4APoO
         3YVNpdFKN+MxkrH1HMwppJQcU8mZOHwwQjLSN/FdMafc/Eem6GLGFGhGoAuq7Tv0HnBv
         OltQ9hg9lrYxbEMwD7l9lKrqhvBzbdWN52cITRbZ2VrQi2U1gA2BAWYK1P0IOHH5ua0z
         K+z7XF7rNqV4ka+0VK3Puoq45TAySnPGJsBGAWZ/fYZePnr6WmZRyIk7/v7XjxYEyEwY
         b9tA==
X-Gm-Message-State: AOAM53353Rg2zxpwUZGPX3y/SvqKLvyqGpHeYIqojuC7w60iunvmjVWv
        vAXjFq55KXuSdYFrp6AAWp5ITPqjHYAo5BhQcuNpANGzUXixOuwLCE3VO0/6Mro7LCePJTlLase
        7mjpGbHNhJGeFLq35KCe5l7hiGkENQ6vqTrqna8+uEA==
X-Received: by 2002:a9d:640e:: with SMTP id h14mr4936430otl.198.1612560760284;
        Fri, 05 Feb 2021 13:32:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHmyw8xcHOH58QlRlJy8oBPLSHbIgkypwOLDZRy4/OKOBQPzyOfGREhmnboaGpyxGE+SGHRg==
X-Received: by 2002:a9d:640e:: with SMTP id h14mr4936420otl.198.1612560760071;
        Fri, 05 Feb 2021 13:32:40 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:2b7:eb67:ff8d:8b15])
        by smtp.gmail.com with ESMTPSA id l133sm1997908oia.37.2021.02.05.13.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:32:39 -0800 (PST)
Date:   Fri, 5 Feb 2021 15:32:38 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Chris Down <chris@chrisdown.name>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Don't use 64-bit inodes by defulat with 32-bit
 ino_t
Message-ID: <YB25dmD3Gpsu6QCL@ubuntu-x1>
References: <20210205202159.505612-1-seth.forshee@canonical.com>
 <20210205124157.c9d855a373362d7bf3d811a7@linux-foundation.org>
 <YB2wz8dKnjZv4bdT@ubuntu-x1>
 <20210205132313.95ce9fd932ca96667fd5db83@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205132313.95ce9fd932ca96667fd5db83@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 01:23:13PM -0800, Andrew Morton wrote:
> On Fri, 5 Feb 2021 14:55:43 -0600 Seth Forshee <seth.forshee@canonical.com> wrote:
> 
> > On Fri, Feb 05, 2021 at 12:41:57PM -0800, Andrew Morton wrote:
> > > On Fri,  5 Feb 2021 14:21:59 -0600 Seth Forshee <seth.forshee@canonical.com> wrote:
> > > 
> > > > Currently there seems to be an assumption in tmpfs that 64-bit
> > > > architectures also have a 64-bit ino_t. This is not true; s390 at
> > > > least has a 32-bit ino_t. With CONFIG_TMPFS_INODE64=y tmpfs
> > > > mounts will get 64-bit inode numbers and display "inode64" in the
> > > > mount options, but passing the "inode64" mount option will fail.
> > > > This leads to the following behavior:
> > > > 
> > > >  # mkdir mnt
> > > >  # mount -t tmpfs nodev mnt
> > > >  # mount -o remount,rw mnt
> > > >  mount: /home/ubuntu/mnt: mount point not mounted or bad option.
> > > > 
> > > > As mount sees "inode64" in the mount options and thus passes it
> > > > in the options for the remount.
> > > > 
> > > > Ideally CONFIG_TMPFS_INODE64 would depend on sizeof(ino_t) < 8,
> > > > but I don't think it's possible to test for this (potentially
> > > > CONFIG_ARCH_HAS_64BIT_INO_T or similar could be added, but I'm
> > > > not sure whether or not that is wanted). So fix this by simply
> > > > refusing to honor the CONFIG_TMPFS_INODE64 setting when
> > > > sizeof(ino_t) < 8.
> > > 
> > > How about changing s390 Kconfig so that CONFIG_TMPFS_INODE64 is not enabled?
> > 
> > I did do that for our config. I see the s390 defconfig has it enabled,
> > so I will send a patch for that too. But the fact that it can be
> > configured that way and that the code behaves badly still seems
> > problematic.
> 
> I meant
> 
> --- a/fs/Kconfig~a
> +++ a/fs/Kconfig
> @@ -203,7 +203,7 @@ config TMPFS_XATTR
>  
>  config TMPFS_INODE64
>  	bool "Use 64-bit ino_t by default in tmpfs"
> -	depends on TMPFS && 64BIT
> +	depends on TMPFS && 64BIT && !S390
>  	default n
>  	help
>  	  tmpfs has historically used only inode numbers as wide as an unsigned
> _

Ah. s390 does appear to be the only architecture that doesn't use
unsigned long for ino_t, so that seems good to me. I can send a patch if
you want, but seems like you've already got one ...

Seth
