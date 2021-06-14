Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDAF3A5EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhFNJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhFNJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:04:12 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3685FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 02:02:10 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id CA9A2C020; Mon, 14 Jun 2021 11:02:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623661325; bh=AE8xWq3+O6y8F4JIxC9P1TzjZjOLXYNQVdQLQm0W2PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=3ISs6qI8xXvss0UhLXH7OC25/miPDXriKk7/HaF77S72iDnZbySAYKvv4xyBjM5hX
         nHwbnBI8IxPwHdcP2mR8VoAwn624EIFIpk28AcOvyDW9m21l5UEMC/Nx5VwSkspQZo
         AQfe+U8K9FE9makBwwWuDniWr+5s7+DxSLhVDKGG20b8BCmvzepHyfWdrevLzt0Oh8
         OwD9s0Jmwxi/Y9HS4vcJ8IIzUPMx+vz6h2h4HWcsD3KSHhzKlebZx8fye2NO4y3zis
         kVQc+TRhaR9RKXf5xJUZziSwfB2sSpZ3V8OSPzuQHpt3y+FQA/xgCXVqQlq+gfG64J
         ZWL8ySBHfBs0w==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 17624C01B;
        Mon, 14 Jun 2021 11:02:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623661324; bh=AE8xWq3+O6y8F4JIxC9P1TzjZjOLXYNQVdQLQm0W2PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1rsHoPVY22AMd4p7M+BgKFly+4EE6cYp8gmk0Mm8Sbi7fW4uGFQQjEzHl/1Au0mA
         mFlFh1o4zuEvkPEJELUswT6QHeCxZ6UvaYB+bzNVwc5z3hj90IQknbh5IKYow7HKkr
         zrAYvK58PRZlqvYPxexGngL260zjelfN3qer0QLd39EdQ59jkM39UZ0BsYepLiu+lj
         BnQ6ZJR7a+84I5T6VRHMgIsGQornIU/xD6NgMvVXMUqIB71s/bw9yLc7mtdG3yLS4r
         r+RK451He4pIyklmmsE7kvcAalQdcQI588/CJ2Any0jJg4OMbR/IUvETv4k6OcisCO
         MVHMEsxynqJ4g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id df5f9604;
        Mon, 14 Jun 2021 09:01:59 +0000 (UTC)
Date:   Mon, 14 Jun 2021 18:01:44 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v3 0/3] 9p: add support for root file systems
Message-ID: <YMca+N0UiGNZ1lSm@codewreck.org>
References: <20210606230922.77268-1-changbin.du@gmail.com>
 <YMcaEq95T+1GxZz2@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMcaEq95T+1GxZz2@localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Triplett wrote on Mon, Jun 14, 2021 at 01:57:54AM -0700:
> On Mon, Jun 07, 2021 at 07:09:19AM +0800, Changbin Du wrote:
> > Just like cifs and nfs, this short series enables rootfs support for 9p.
> > Bellow is an example which mounts v9fs with tag 'r' as rootfs in qemu
> > guest via virtio transport.
> > 
> >   $ qemu-system-x86_64 -enable-kvm -cpu host -m 1024 \
> >         -virtfs local,path=$rootfs_dir,mount_tag=r,security_model=passthrough,id=r \
> >         -kernel /path/to/linux/arch/x86/boot/bzImage -nographic \
> >         -append "root=/dev/v9fs v9fsroot=r,trans=virtio rw console=ttyS0 3"
> 
> Rather than inventing a pseudo-device /dev/v9fs for this, would it
> potentially work to use the existing rootfstype and rootflags options
> for this? rootfstype already determines what filesystem should be used
> to mount the root, and rootflags already provides options for that
> filesystem.
> 
> For instance, for the above example:
> rootfstype=9p root=r rootflags=trans=virtio
> 
> That would require a bit of fiddling to make rootfstype=9p allow a root
> that's just the mount_tag. If that isn't an option, then even with
> root=/dev/v9fs I think it still makes sense to use the existing
> rootflags for "trans=virtio" rather than creating a new "v9fsroot"
> option for that.

This doesn't work as is because of the way the code is written, if
there's no block device associated with a root=x option right now it
will lead to kernel panic.

I replied with folks in Cc but there's another thread on linux-fsdevel@
with a more generic approach that will build a list of filesystems which
don't require such a block device (either hardcoded with virtiofs and 9p
or based on FS_REQUIRES_DEV), thread started there but there's a second
patch hidden an more discussion below:
https://lore.kernel.org/linux-fsdevel/20210608153524.GB504497@redhat.com/


My preferred approach right now would be to go with their approach, and
adjust the documentation Changbin Du wrote here, to have the best of
both worlds.

-- 
Dominique
