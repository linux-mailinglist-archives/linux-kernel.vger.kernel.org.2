Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD8032D8FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhCDRvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:51:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhCDRu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:50:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 898FD64F1E;
        Thu,  4 Mar 2021 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614880215;
        bh=qHMFp+DR771VBs3rk6GDPx6UFsJ6juz5aNB02nBIg5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWW1+Z/KIX+3MI8iP02qNrvcNPOP8NZZu6SFDBH5Oe5ul1JU69bncfHdVHmB8SH4O
         MShGIqkC2EwvMTd/CryERy/ce5qJ4jn2mL3Esr01pHiEGNjkhXyBYAWYwGqQhQidzU
         v2psMJz8u3uicyhfiDxZz86OWUEuIolZB/Jndi3VLw+hfqwqpsxhP2E8X/TAc6Y8+j
         8GCvp3EYQJX0Qd4/1TP+XCwC8yHqm1KeFMA+cv2iZx38EI5pYu1Gf9sKFK8ute/TjU
         +QF6MdNnF319iQwWpcWTvrIZh5WnJT3BDZAQO42tg+ec2q7MlERjvo71SygLbKHFW1
         +fswrQPMCF/BA==
Date:   Thu, 4 Mar 2021 09:50:14 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: expose # of overprivision segments
Message-ID: <YEEd1q5nz9EYGy8H@google.com>
References: <20210302054233.3886681-1-jaegeuk@kernel.org>
 <920469a9-45d3-68e3-1f8d-a436bdd60cfe@huawei.com>
 <YD5wQRX+HnltBvEM@google.com>
 <YD6HjZG7QMS6Z3Tb@google.com>
 <05b43d3e-d735-ae34-5a4f-3d81a4fc8a9b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05b43d3e-d735-ae34-5a4f-3d81a4fc8a9b@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04, Chao Yu wrote:
> On 2021/3/3 2:44, Jaegeuk Kim wrote:
> > On 03/02, Jaegeuk Kim wrote:
> > > On 03/02, Chao Yu wrote:
> > > > On 2021/3/2 13:42, Jaegeuk Kim wrote:
> > > > > This is useful when checking conditions during checkpoint=disable in Android.
> > > > 
> > > > This sysfs entry is readonly, how about putting this at
> > > > /sys/fs/f2fs/<disk>/stat/?
> > > 
> > > Urg.. "stat" is a bit confused. I'll take a look a better ones.
> 
> Oh, I mean put it into "stat" directory, not "stat" entry, something like this:
> 
> /sys/fs/f2fs/<disk>/stat/ovp_segments

I meant that too. Why is it like stat, since it's a geomerty?

> 
> > 
> > Taking a look at other entries using in Android, I feel that this one can't be
> > in stat or whatever other location, since I worry about the consistency with
> > similar dirty/free segments. It seems it's not easy to clean up the existing
> > ones anymore.
> 
> Well, actually, the entry number are still increasing continuously, the result is
> that it becomes more and more slower and harder for me to find target entry name
> from that directory.
> 
> IMO, once new readonly entry was added to "<disk>" directory, there is no chance
> to reloacate it due to interface compatibility. So I think this is the only
> chance to put it to the appropriate place at this time.

I know, but this will diverge those info into different places. I don't have
big concern when finding a specific entry with this tho, how about making
symlinks to create a dir structure for your easy access? Or, using a script
would be alternative way.

> 
> Thanks,
> 
> > 
> > > 
> > > > 
> > > > > 
> > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > ---
> > > > >    fs/f2fs/sysfs.c | 8 ++++++++
> > > > >    1 file changed, 8 insertions(+)
> > > > > 
> > > > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > > > index e38a7f6921dd..254b6fa17406 100644
> > > > > --- a/fs/f2fs/sysfs.c
> > > > > +++ b/fs/f2fs/sysfs.c
> > > > > @@ -91,6 +91,13 @@ static ssize_t free_segments_show(struct f2fs_attr *a,
> > > > >    			(unsigned long long)(free_segments(sbi)));
> > > > >    }
> > > > > +static ssize_t ovp_segments_show(struct f2fs_attr *a,
> > > > > +		struct f2fs_sb_info *sbi, char *buf)
> > > > > +{
> > > > > +	return sprintf(buf, "%llu\n",
> > > > > +			(unsigned long long)(overprovision_segments(sbi)));
> > > > > +}
> > > > > +
> > > > >    static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
> > > > >    		struct f2fs_sb_info *sbi, char *buf)
> > > > >    {
> > > > > @@ -629,6 +636,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
> > > > >    F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
> > > > >    F2FS_GENERAL_RO_ATTR(dirty_segments);
> > > > >    F2FS_GENERAL_RO_ATTR(free_segments);
> > > > > +F2FS_GENERAL_RO_ATTR(ovp_segments);
> > > > 
> > > > Missed to add document entry in Documentation/ABI/testing/sysfs-fs-f2fs?
> > > 
> > > Yeah, thanks.
> > > 
> > > > 
> > > > Thanks,
> > > > 
> > > > >    F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
> > > > >    F2FS_GENERAL_RO_ATTR(features);
> > > > >    F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
> > > > > 
> > > 
> > > 
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> > 
