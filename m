Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD893112F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhBETQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 14:16:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43983 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhBETOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 14:14:01 -0500
Received: from mail-oi1-f197.google.com ([209.85.167.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1l888n-00008b-Kr
        for linux-kernel@vger.kernel.org; Fri, 05 Feb 2021 20:55:45 +0000
Received: by mail-oi1-f197.google.com with SMTP id y62so2815196oiy.15
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 12:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QkkmoEPfz/PvJc6Yd3AdkXaGpIKT6BSjX72ihLgbl6M=;
        b=pabQk1MmjdrHafNBU4F9cbS9c4mmbvWV7FDqqpKVlCREty5yYxDcj/Gb5pPqr+i6ru
         B7BPnz279gbGdfD9phVx8kxSvBWh+EcKLiwZff5XKmZs/dZ4Tqo0rVsT1AUf5JoEf5Is
         UMtK4JruI6FJDEWGvQj8ftTYVotG8sKiQRc80nclSNXmwz1CxD5ttNybLrky7uTeHQgP
         AbpFjnMRTSw9sSfX/8byDOCNmtYnPJXFqIgQLqTuw/o/fmYjOso6b4ACLtA0yC5p90cS
         nzypfFyNpenrzBKFiXpBTsVNJDqVv7shHx7ywZbGQvP7jyCytCv9qh+XLVnuEJr3LtyL
         sNhw==
X-Gm-Message-State: AOAM533Q87VXLdxGc/KdhQE5aJW9827NAkYS8Yh0IGFzQB5BPkv1huDg
        UTQMHtkw5W6rC/dLqmfn+lzT08SmWMX3osC0hyk4csdm7Llx5ZnAOmmWalDmSQqncChRn2l5f2X
        lYbMIQVYRaIyqfWwcxxPXJLHysy41cyVjN5Jg6zohcA==
X-Received: by 2002:a9d:5f12:: with SMTP id f18mr4749003oti.282.1612558544678;
        Fri, 05 Feb 2021 12:55:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0tPym7+CLOVDwIItrIhMQpOrUvHBE2Npnq1Ypg8kVSSI4F4SVRY3hpqbOBjAH9Y+o3jUn9A==
X-Received: by 2002:a9d:5f12:: with SMTP id f18mr4748993oti.282.1612558544479;
        Fri, 05 Feb 2021 12:55:44 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:2b7:eb67:ff8d:8b15])
        by smtp.gmail.com with ESMTPSA id r1sm2025770ooq.16.2021.02.05.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 12:55:43 -0800 (PST)
Date:   Fri, 5 Feb 2021 14:55:43 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Chris Down <chris@chrisdown.name>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Don't use 64-bit inodes by defulat with 32-bit
 ino_t
Message-ID: <YB2wz8dKnjZv4bdT@ubuntu-x1>
References: <20210205202159.505612-1-seth.forshee@canonical.com>
 <20210205124157.c9d855a373362d7bf3d811a7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205124157.c9d855a373362d7bf3d811a7@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 12:41:57PM -0800, Andrew Morton wrote:
> On Fri,  5 Feb 2021 14:21:59 -0600 Seth Forshee <seth.forshee@canonical.com> wrote:
> 
> > Currently there seems to be an assumption in tmpfs that 64-bit
> > architectures also have a 64-bit ino_t. This is not true; s390 at
> > least has a 32-bit ino_t. With CONFIG_TMPFS_INODE64=y tmpfs
> > mounts will get 64-bit inode numbers and display "inode64" in the
> > mount options, but passing the "inode64" mount option will fail.
> > This leads to the following behavior:
> > 
> >  # mkdir mnt
> >  # mount -t tmpfs nodev mnt
> >  # mount -o remount,rw mnt
> >  mount: /home/ubuntu/mnt: mount point not mounted or bad option.
> > 
> > As mount sees "inode64" in the mount options and thus passes it
> > in the options for the remount.
> > 
> > Ideally CONFIG_TMPFS_INODE64 would depend on sizeof(ino_t) < 8,
> > but I don't think it's possible to test for this (potentially
> > CONFIG_ARCH_HAS_64BIT_INO_T or similar could be added, but I'm
> > not sure whether or not that is wanted). So fix this by simply
> > refusing to honor the CONFIG_TMPFS_INODE64 setting when
> > sizeof(ino_t) < 8.
> 
> How about changing s390 Kconfig so that CONFIG_TMPFS_INODE64 is not enabled?

I did do that for our config. I see the s390 defconfig has it enabled,
so I will send a patch for that too. But the fact that it can be
configured that way and that the code behaves badly still seems
problematic.

> 
> > Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
> > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> 
> With a cc:stable, I assume?

Yes, I forgot that. Thanks.

Seth
