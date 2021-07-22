Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F09D3D24E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhGVNLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231925AbhGVNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626961931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESge0KHDhWJ77b/8SSXjjC4o9lBAjOzbV5TN7hr2oSw=;
        b=Y2fEjWvjo1CRh7MVWK7G33YNEp8dAKr+H62Qx30LUgdzeS1tDyw6nzrCaRw2uWM8l80LzG
        XFRTVfcuUStdIGUQKC+jEf2BafQIXOLw/6QZvuNXuNUvgOKVOsnXcAF5i3xV3KwB6IMDjd
        G2xx0+rsqPQEqzzMbdFe/YXliB/MeGw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-haYXAOJiNBG6TNzXW8Zllw-1; Thu, 22 Jul 2021 09:52:10 -0400
X-MC-Unique: haYXAOJiNBG6TNzXW8Zllw-1
Received: by mail-wr1-f69.google.com with SMTP id h11-20020adffa8b0000b029013a357d7bdcso2477775wrr.18
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 06:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=ESge0KHDhWJ77b/8SSXjjC4o9lBAjOzbV5TN7hr2oSw=;
        b=GhEGh4HJkQhRm2FeCO7w1b3q4UOnWWIFwSSxSu0fEa6DTCcTimAj2AGIdbLSkKwJ7l
         bjX4uaMytt6bYfYLNez0/uXXUnX3NAE35ojVIe0IMB/1d+XVvFYYGlT/+pnui5ukztJf
         5Ayzw8wrytBXttW/tfkqqOiZ9M18PgwlotyIA9EwFqwDSdcHl4x0zk7QPB5tP3IzSvEY
         sLpkitF6ajg1VxKtIcIn7B9UDIkGX1HYoh+EGe7K6xGtvBfiJAkhV2Ron+IkzmL7B4J5
         /868UDVObdRBUaCwODm5g7iiCRkNKpg9Re9/WxNM6d802Xy9nG2p2M7fTf+q6PNJRFRY
         64gA==
X-Gm-Message-State: AOAM5322NYN9BIqk6WsuWeLwZ3lfRIsItLHaLEqE8P/VbhJ0tiH3hxig
        gH6+ucdzDvBKpQp8lBrigVE4xh9/sLMVZw1X9um7u5ORIsXQnQyU38EhM+ewVbHmMX7sdAeSAuG
        lzVhfu/AFCZHrKUvGDJa08gLC
X-Received: by 2002:a05:6000:1b0c:: with SMTP id f12mr48780159wrz.225.1626961929007;
        Thu, 22 Jul 2021 06:52:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYVurwPTRb97ntwTd8UIDowdCWmKx3cnpZmclnzQMDREqVCvrbQz316b0cKwU/u4lpKBycHQ==
X-Received: by 2002:a05:6000:1b0c:: with SMTP id f12mr48780142wrz.225.1626961928817;
        Thu, 22 Jul 2021 06:52:08 -0700 (PDT)
Received: from 0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa (0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:ffda:0:2059:8730:b2:c370])
        by smtp.gmail.com with ESMTPSA id c125sm3063781wme.36.2021.07.22.06.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 06:52:08 -0700 (PDT)
Message-ID: <2b8e94f7a401fc98a7fce3daaa9fd63e7324e426.camel@redhat.com>
Subject: Re: [Cluster-devel] [syzbot] WARNING in __set_page_dirty
From:   Steven Whitehouse <swhiteho@redhat.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+0d5b462a6f07447991b3@syzkaller.appspotmail.com>
Cc:     cluster-devel@redhat.com, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Date:   Thu, 22 Jul 2021 14:52:02 +0100
In-Reply-To: <302c13da-9bca-efb4-9659-6a0e9979c0bb@redhat.com>
References: <000000000000b25bb805c798a1a5@google.com>
         <20210721145801.8ca097bc1d9ad3d0018517bd@linux-foundation.org>
         <302c13da-9bca-efb4-9659-6a0e9979c0bb@redhat.com>
Organization: Red Hat UK Ltd
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2021-07-22 at 08:16 -0500, Bob Peterson wrote:
> On 7/21/21 4:58 PM, Andrew Morton wrote:
> > (cc gfs2 maintainers)
> > 
> > On Tue, 20 Jul 2021 19:07:25 -0700 syzbot <
> > syzbot+0d5b462a6f07447991b3@syzkaller.appspotmail.com> wrote:
> > 
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    d936eb238744 Revert "Makefile: Enable -Wimplicit-
> > > fallthrou..
> > > git tree:       upstream
> > > console output: 
> > > https://syzkaller.appspot.com/x/log.txt?x=1512834a300000
> > > kernel config:  
> > > https://syzkaller.appspot.com/x/.config?x=f1b998c1afc13578
> > > dashboard link: 
> > > https://syzkaller.appspot.com/bug?extid=0d5b462a6f07447991b3
> > > userspace arch: i386
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to
> > > the commit:
> > > Reported-by: 
> > > syzbot+0d5b462a6f07447991b3@syzkaller.appspotmail.com
> > > 
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 8696 at include/linux/backing-dev.h:283
> > > inode_to_wb include/linux/backing-dev.h:283 [inline]
> > > WARNING: CPU: 0 PID: 8696 at include/linux/backing-dev.h:283
> > > account_page_dirtied mm/page-writeback.c:2435 [inline]
> > > WARNING: CPU: 0 PID: 8696 at include/linux/backing-dev.h:283
> > > __set_page_dirty+0xace/0x1070 mm/page-writeback.c:2483
> >  
> 
> Okay, sorry for the brain fart earlier. After taking a better look, I
> know exactly what this is.
> This goes back to this discussion from April 2018:
> 
> https://listman.redhat.com/archives/cluster-devel/2018-April/msg00017.html
> 
> in which Jan Kara pointed out that:
> 
> "The problem is we really do expect mapping->host->i_mapping ==
> mapping as
> we pass mapping and inode interchangebly in the mm code. The
> address_space
> and inodes are separate structures because you can have many inodes
> pointing to one address space (block devices). However it is not
> allowed
> for several address_spaces to point to one inode!"
> The problem is that GFS2 keeps separate address spaces for its
> glocks, and they
> don't correspond 1:1 to any inode. So mapping->host is not really an
> inode for these,
> and there's really almost no relation between the glock->mapping and
> the inode it
> points to.
> 
> Even in the recent past, GFS2 did this for all metadata for both its
> media-backed glocks:
> resource groups and inodes.
> 
> I recently posted a patch set to cluster-devel ("gfs2: replace
> sd_aspace with sd_inode" -
> https://listman.redhat.com/archives/cluster-devel/2021-July/msg00066.html) in
> which
> I fixed half the problem, which is the resource group case.
> 
> Unfortunately, for inode glocks it gets a lot trickier and I haven't
> found a proper solution.
> But as I said, it's been a known issue for several years now. The
> errors only appear
> if LOCKDEP is turned on. It would be ideal if address spaces were
> treated as fully
> independent from their inodes, but no one seemed to jump on that
> idea, nor even try to
> explain why we make the assumptions Jan Kara pointed out.
> 
> In the meantime, I'll keep looking for a more proper solution. This
> won't be an easy
> thing to fix or I would have already fixed it.
> 
> Regards,
> 
> Bob Peterson
> 
> 

The reason for having address_spaces pointed to by many inodes is to
allow for stackable filesytems so that you can make the file content
available on the upper layer by just pointing the upper layer inode at
the lower layer address_space. That is presumably what Jan is thinking
of.

This however seems to be an issue with a page flag, so it isn't clear
why that would relate to the address_space? If the page is metadata
which would be the most usual case for something being unpinned, then
that page should definitely be up to date.

Looking back at the earlier rgrp fix mentioned above, the fix is not
unreasonable since there only needs to be a single inode to contain all
the rgrps. For the inode metadata that is not the case, there is a one
to one mapping between inodes and metadata address_spaces, and if the
working assumption is that multiple address_spaces per inode is not
allowed, then I think that has changed over time. I'm pretty sure that
I had checked the expectations way back when we adopted this solution,
and that there were no issues with the multiple address_spaces per
inode case. We definitely don't want to go back to adding an additional
struct inode structure (which does nothing except take up space!) to
each "real" inode in cache, because it is a big overhead in case of a
filesystem with many small files.

Still if this is only a lockdep issue, then we likely have some time to
figure out a good long term solution,

Steve.



