Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E768A331B70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhCIAIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:08:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231334AbhCIAH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:07:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 695E061554;
        Tue,  9 Mar 2021 00:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615248479;
        bh=hh6W4mb3ILZuAEfS/9qpYK9HmLfYcB44uqr5rewvqiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5Qtd1psIuOnnPSSLk66PHnUOWZ0U9zWdOh/dEFU3bbnDfny0T2AYUGq50iD47mjA
         mLbyLRO3bPBooxXftkfNdeN6KimUVhtoXa9WkWxSXvPaX/WnsdxRHMeOToGK1SbEYZ
         dzaU7HBdq64z2FWXTmiaDLrPOl5uSw3tJMm9VLQFgxgd+Y2YjlOzEPqQer+jly3oSr
         7nU1eZZVqHwFQE7Cr4ay8ygLO7olkV+16tM/dAI5wOVL+NMG8KjRVFhATlWL2MT+1r
         NvnAPLQ/ORo6IEJAZR05uFFIwl4heCyMXWlqNvLDl69BvSsRyo28jSK8XQgXTDWsI6
         tsNbJ8+lUJGTQ==
Date:   Mon, 8 Mar 2021 16:07:57 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: expose # of overprivision segments
Message-ID: <YEa8XfQvBsmABpY6@google.com>
References: <20210302054233.3886681-1-jaegeuk@kernel.org>
 <920469a9-45d3-68e3-1f8d-a436bdd60cfe@huawei.com>
 <YD5wQRX+HnltBvEM@google.com>
 <YD6HjZG7QMS6Z3Tb@google.com>
 <05b43d3e-d735-ae34-5a4f-3d81a4fc8a9b@huawei.com>
 <YEEd1q5nz9EYGy8H@google.com>
 <ee90aac8-bc84-0a85-e1b8-f51c40c77535@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee90aac8-bc84-0a85-e1b8-f51c40c77535@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05, Chao Yu wrote:
> On 2021/3/5 1:50, Jaegeuk Kim wrote:
> > On 03/04, Chao Yu wrote:
> > > On 2021/3/3 2:44, Jaegeuk Kim wrote:
> > > > On 03/02, Jaegeuk Kim wrote:
> > > > > On 03/02, Chao Yu wrote:
> > > > > > On 2021/3/2 13:42, Jaegeuk Kim wrote:
> > > > > > > This is useful when checking conditions during checkpoint=disable in Android.
> > > > > > 
> > > > > > This sysfs entry is readonly, how about putting this at
> > > > > > /sys/fs/f2fs/<disk>/stat/?
> > > > > 
> > > > > Urg.. "stat" is a bit confused. I'll take a look a better ones.
> > > 
> > > Oh, I mean put it into "stat" directory, not "stat" entry, something like this:
> > > 
> > > /sys/fs/f2fs/<disk>/stat/ovp_segments
> > 
> > I meant that too. Why is it like stat, since it's a geomerty?
> 
> Hmm.. I feel a little bit weired to treat ovp_segments as 'stat' class, one reason
> is ovp_segments is readonly and is matching the readonly attribute of a stat.

It seems I don't fully understand what you suggest here. I don't want to add the
# of ovp_segments in <disk>/stat, since it is not part of status, but put it in
<disk>/ to sync with other # of free/dirty segments. If you can't read out easily,
I suggest to create symlinks to organize all the current mess.

> 
> > 
> > > 
> > > > 
> > > > Taking a look at other entries using in Android, I feel that this one can't be
> > > > in stat or whatever other location, since I worry about the consistency with
> > > > similar dirty/free segments. It seems it's not easy to clean up the existing
> > > > ones anymore.
> > > 
> > > Well, actually, the entry number are still increasing continuously, the result is
> > > that it becomes more and more slower and harder for me to find target entry name
> > > from that directory.
> > > 
> > > IMO, once new readonly entry was added to "<disk>" directory, there is no chance
> > > to reloacate it due to interface compatibility. So I think this is the only
> > > chance to put it to the appropriate place at this time.
> > 
> > I know, but this will diverge those info into different places. I don't have
> > big concern when finding a specific entry with this tho, how about making
> > symlinks to create a dir structure for your easy access? Or, using a script
> > would be alternative way.
> 
> Yes, there should be some alternative ways to help to access f2fs sysfs
> interface, but from a point view of user, I'm not sure he can figure out those
> ways.
> 
> For those fs meta stat, why not adding a single entry to include all info you
> need rather than adding them one by one? e.g.

You can add that in /proc as well, which requires to parse back when retrieving
specific values.

> 
> /proc/fs/f2fs/<disk>/super_block
> /proc/fs/f2fs/<disk>/checkpoint
> /proc/fs/f2fs/<disk>/nat_table
> /proc/fs/f2fs/<disk>/sit_table
> ...
> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > > > ---
> > > > > > >     fs/f2fs/sysfs.c | 8 ++++++++
> > > > > > >     1 file changed, 8 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > > > > > index e38a7f6921dd..254b6fa17406 100644
> > > > > > > --- a/fs/f2fs/sysfs.c
> > > > > > > +++ b/fs/f2fs/sysfs.c
> > > > > > > @@ -91,6 +91,13 @@ static ssize_t free_segments_show(struct f2fs_attr *a,
> > > > > > >     			(unsigned long long)(free_segments(sbi)));
> > > > > > >     }
> > > > > > > +static ssize_t ovp_segments_show(struct f2fs_attr *a,
> > > > > > > +		struct f2fs_sb_info *sbi, char *buf)
> > > > > > > +{
> > > > > > > +	return sprintf(buf, "%llu\n",
> > > > > > > +			(unsigned long long)(overprovision_segments(sbi)));
> > > > > > > +}
> > > > > > > +
> > > > > > >     static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
> > > > > > >     		struct f2fs_sb_info *sbi, char *buf)
> > > > > > >     {
> > > > > > > @@ -629,6 +636,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
> > > > > > >     F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
> > > > > > >     F2FS_GENERAL_RO_ATTR(dirty_segments);
> > > > > > >     F2FS_GENERAL_RO_ATTR(free_segments);
> > > > > > > +F2FS_GENERAL_RO_ATTR(ovp_segments);
> > > > > > 
> > > > > > Missed to add document entry in Documentation/ABI/testing/sysfs-fs-f2fs?
> > > > > 
> > > > > Yeah, thanks.
> > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > >     F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
> > > > > > >     F2FS_GENERAL_RO_ATTR(features);
> > > > > > >     F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
> > > > > > > 
> > > > > 
> > > > > 
> > > > > _______________________________________________
> > > > > Linux-f2fs-devel mailing list
> > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > .
> > > > 
> > .
> > 
