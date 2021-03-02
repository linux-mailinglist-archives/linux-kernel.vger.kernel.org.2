Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A04632AD4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384291AbhCBVfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378234AbhCBSpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:45:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1208860234;
        Tue,  2 Mar 2021 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614710671;
        bh=Jez+zQ5zpYVsw8ZRUjYBKwlw+LBdVJxKIm2weKJgcAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QgZZ/lRmbVso3uOmcSejiJnTRnZ9yzOkv44srGRjw/oqUQ1P0VDt2zzCALLelceGo
         nw1tWuK7MoM0hFugbabeY0B5prc0uOBz03Lk8MBDqNZr6MWJlRcn1Nezxv6oq22VRD
         jhw43n4UcLZW3U1hwlLeLafkoa2kwp+aTLfoSfboU94jjFoDR95VYZRES2VvypK+0p
         9OzgwLwHWBmpsvkAwJ9lzXrabW99SsSoeKK/NoyDWWvim42iDimyshbHxW1kUWkZ+N
         le0+e4MqcombT7q3wAvDr6wY4HdRdDrM9LWDEdrTblZ8Ho16yUzggqoOg6Cw0zO7uG
         2KMWdlHAWERug==
Date:   Tue, 2 Mar 2021 10:44:29 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: expose # of overprivision segments
Message-ID: <YD6HjZG7QMS6Z3Tb@google.com>
References: <20210302054233.3886681-1-jaegeuk@kernel.org>
 <920469a9-45d3-68e3-1f8d-a436bdd60cfe@huawei.com>
 <YD5wQRX+HnltBvEM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD5wQRX+HnltBvEM@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02, Jaegeuk Kim wrote:
> On 03/02, Chao Yu wrote:
> > On 2021/3/2 13:42, Jaegeuk Kim wrote:
> > > This is useful when checking conditions during checkpoint=disable in Android.
> > 
> > This sysfs entry is readonly, how about putting this at
> > /sys/fs/f2fs/<disk>/stat/?
> 
> Urg.. "stat" is a bit confused. I'll take a look a better ones.

Taking a look at other entries using in Android, I feel that this one can't be
in stat or whatever other location, since I worry about the consistency with
similar dirty/free segments. It seems it's not easy to clean up the existing
ones anymore.

> 
> > 
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >   fs/f2fs/sysfs.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > index e38a7f6921dd..254b6fa17406 100644
> > > --- a/fs/f2fs/sysfs.c
> > > +++ b/fs/f2fs/sysfs.c
> > > @@ -91,6 +91,13 @@ static ssize_t free_segments_show(struct f2fs_attr *a,
> > >   			(unsigned long long)(free_segments(sbi)));
> > >   }
> > > +static ssize_t ovp_segments_show(struct f2fs_attr *a,
> > > +		struct f2fs_sb_info *sbi, char *buf)
> > > +{
> > > +	return sprintf(buf, "%llu\n",
> > > +			(unsigned long long)(overprovision_segments(sbi)));
> > > +}
> > > +
> > >   static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
> > >   		struct f2fs_sb_info *sbi, char *buf)
> > >   {
> > > @@ -629,6 +636,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
> > >   F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
> > >   F2FS_GENERAL_RO_ATTR(dirty_segments);
> > >   F2FS_GENERAL_RO_ATTR(free_segments);
> > > +F2FS_GENERAL_RO_ATTR(ovp_segments);
> > 
> > Missed to add document entry in Documentation/ABI/testing/sysfs-fs-f2fs?
> 
> Yeah, thanks.
> 
> > 
> > Thanks,
> > 
> > >   F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
> > >   F2FS_GENERAL_RO_ATTR(features);
> > >   F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
> > > 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
