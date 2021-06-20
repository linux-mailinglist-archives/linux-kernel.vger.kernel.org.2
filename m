Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249113ADC73
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 05:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFTDjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 23:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFTDjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 23:39:21 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D04C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 20:37:08 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id i34so5599897pgl.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 20:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dW+rXMivkypYzYHMcF6QYYWPgqFmfhvJSvjVwf9dI5k=;
        b=JNUYNv9AOR1lrhnnONzsRq5uMlitQSi46YiTtAGBzxM8WtGPHEnpfD0xU5g/U+5ehm
         Tvv8RY7A44J1t2yjeV7wFv1Ait0SzpzGdfGsk6/OBsl03/lmllBgWcO10l4fsBFzh/cz
         qaaY059u610zbatao1tFtEv76D2RRaecya3XWpqQL5tJvpaIIIJ2ss3hljfKnnHtFk+N
         gVwYyUWE3Yo3AyOsbQQv/Nzed0Psq9ge9+jhnuIDDIVDt81g3Y8eqjQNGYFMt/WHulwP
         30V1Tai1gLeni/SrW8/oMb+XJLD0rcYGRJclMOHIE3tvjLdM/I/xvOsSHNim2if7Mpn4
         DI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dW+rXMivkypYzYHMcF6QYYWPgqFmfhvJSvjVwf9dI5k=;
        b=OhAZPuTpIfq2NFtGI3wAWmnEy6TpJuoTunBfgCuiCWyDP2Q3zEln75tleGCBCmtk0X
         7x/EdtEowlDmBwSMdJvFW+VfMwfW+XS9cJXLDkqpUjKsv1AdrNa4sFwAWEBf4zRQFtUb
         ZnP4XeNMCkkUdhwCBb1Jz1pkzUJ+cm6jc5kR9uIhNUhkvnlP/09XwMoBJE+VZjR7L6H9
         xrMhTaO2Gid/QCxc18x04ucaiwql3cccwVqzyEgYPvl6UzR9dlnBh9SWte2BRdpGeEH1
         QzHX78nwzgNSUcvYFKkdCMPVUi/NUe+7Rond6RApGlSSyHW0oG2Kb5Q3Vk8KvACR0Sj3
         YiWQ==
X-Gm-Message-State: AOAM5317efqmczWqQ8PLAJKXgYXA8IRYBcnDVLpfVePHTgASI99s85JQ
        WKiHsFf6iB0mRQa/IkIywA0=
X-Google-Smtp-Source: ABdhPJzb7imTNOPSeeqdB7VaWtVCpMcEeqDkcxglpprDFK0XgZIqHrnz5S249B+Nva35TcKhiBS6XA==
X-Received: by 2002:a05:6a00:1a4a:b029:2ff:b1c:e3fd with SMTP id h10-20020a056a001a4ab02902ff0b1ce3fdmr13132129pfv.1.1624160228221;
        Sat, 19 Jun 2021 20:37:08 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id r134sm7916047pfc.68.2021.06.19.20.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 20:37:07 -0700 (PDT)
Date:   Sun, 20 Jun 2021 11:36:59 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Changbin Du <changbin.du@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v3 0/3] 9p: add support for root file systems
Message-ID: <20210620033659.s7rohai7dzwpgjur@mail.google.com>
References: <20210606230922.77268-1-changbin.du@gmail.com>
 <YMcaEq95T+1GxZz2@localhost>
 <YMca+N0UiGNZ1lSm@codewreck.org>
 <YMcfKqbCq7ZWAyaO@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMcfKqbCq7ZWAyaO@localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 02:19:38AM -0700, Josh Triplett wrote:
> On Mon, Jun 14, 2021 at 06:01:44PM +0900, Dominique Martinet wrote:
> > Josh Triplett wrote on Mon, Jun 14, 2021 at 01:57:54AM -0700:
> > > On Mon, Jun 07, 2021 at 07:09:19AM +0800, Changbin Du wrote:
> > > > Just like cifs and nfs, this short series enables rootfs support for 9p.
> > > > Bellow is an example which mounts v9fs with tag 'r' as rootfs in qemu
> > > > guest via virtio transport.
> > > > 
> > > >   $ qemu-system-x86_64 -enable-kvm -cpu host -m 1024 \
> > > >         -virtfs local,path=$rootfs_dir,mount_tag=r,security_model=passthrough,id=r \
> > > >         -kernel /path/to/linux/arch/x86/boot/bzImage -nographic \
> > > >         -append "root=/dev/v9fs v9fsroot=r,trans=virtio rw console=ttyS0 3"
> > > 
> > > Rather than inventing a pseudo-device /dev/v9fs for this, would it
> > > potentially work to use the existing rootfstype and rootflags options
> > > for this? rootfstype already determines what filesystem should be used
> > > to mount the root, and rootflags already provides options for that
> > > filesystem.
> > > 
> > > For instance, for the above example:
> > > rootfstype=9p root=r rootflags=trans=virtio
> > > 
> > > That would require a bit of fiddling to make rootfstype=9p allow a root
> > > that's just the mount_tag. If that isn't an option, then even with
> > > root=/dev/v9fs I think it still makes sense to use the existing
> > > rootflags for "trans=virtio" rather than creating a new "v9fsroot"
> > > option for that.
> > 
> > This doesn't work as is because of the way the code is written, if
> > there's no block device associated with a root=x option right now it
> > will lead to kernel panic.
> > 
> > I replied with folks in Cc but there's another thread on linux-fsdevel@
> > with a more generic approach that will build a list of filesystems which
> > don't require such a block device (either hardcoded with virtiofs and 9p
> > or based on FS_REQUIRES_DEV), thread started there but there's a second
> > patch hidden an more discussion below:
> > https://lore.kernel.org/linux-fsdevel/20210608153524.GB504497@redhat.com/
> 
> The patch later on in that thread (either using a list of
> non-block-device filesystems or the version referenced elsewhere that
> uses a flag in the filesystem definition) looks really appealing! That's
> exactly what I was hoping for. That gets us closer to directly
> translating `mount -t type -o options rootdesc` into `rootfstype=type
> rootflags=options root=rootdesc` in the general case, rather than having
> special cases for different filesystems.
Bellow is all the parameters of non-block rootfs support.
 nfs:    nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
 cifs:   cifsroot=//<server-ip>/<share>[,options]
 v9fs:   v9fsroot=<tag/ip>[,options]
 mtd:    root=mtd:<identifier> or root=ubi:<identifier>
 virtiofs: root=fstag:<tag>

The main problem is we lack a generic handing for non-block rootdev. I think
maybe we can unify all of above.
 non-block:  root=<type>:<identifier>
 blockdev:   root=<bock-dev-path> or root=<blockdev major/minor>

Then:
 nfs:    root=nfs:[<server-ip>:]<root-dir>  rootflags=[nfs-options]
 cifs:   root=cifs://<server-ip>/<share>    rootflags=[options]
 v9fs:   root=9p:<tag/ip>                   rootflags=[options]
 mtd:    root=mtd:<identifier>              rootflags=[options]
 ubi:    root=ubi:<identifier>              rootflags=[options]
 virtiofs: root=virtiofs:<tag>              rootflags=[options]

And maybe we can also remove all the special fs code out of init/do_mounts.c.

-- 
Cheers,
Changbin Du
