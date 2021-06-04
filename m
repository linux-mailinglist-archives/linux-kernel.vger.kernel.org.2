Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81F739B18F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 06:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhFDEnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 00:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhFDEnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 00:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55D30613D8;
        Fri,  4 Jun 2021 04:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622781698;
        bh=EA8m/h6ZeO+GWthj96A3zUYlh51ysfiRNwAyTmIX7l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7sqf64bVucUL2q7sGo9fbSOqUKogUkgrcoggDWwuEAgaIAtV/xR9NZL0XjbVZdru
         d0Yx1yIDNuKqxKvLuBUDC5lH9moaVfyG2K4IP3Gq3foPA5LbFAB4k7sgJmLRnoRa3m
         yEQYKtDYCNAr6tok/i6l0BdB/vzRONugSOhEnfEk/QIB/jjW3whSFMxrBksJsu2mUi
         k7LMgriMrize7VxYh/BpaG+WLdNzdtn60yry1wnMOJRUMMdAmKJqxnc9DwCD20cBr0
         JLjMO3EGoGps7kjXD3u1MCe7WDrSPK8HgH70XGwHhPs30478EiO3Fw1BGQa4rmJ5DI
         /A9SnJWI13Rhw==
Date:   Thu, 3 Jun 2021 21:41:36 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up /sys/fs/f2fs/<disk>/features
Message-ID: <YLmvADDywB9toKpW@google.com>
References: <20210603220834.1949988-1-jaegeuk@kernel.org>
 <YLl2kEZEDuIjrlfO@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLl2kEZEDuIjrlfO@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03, Eric Biggers wrote:
> On Thu, Jun 03, 2021 at 03:08:34PM -0700, Jaegeuk Kim wrote:
> > Let's create /sys/fs/f2fs/<disk>/feature_list/ to meet sysfs rule.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  Documentation/ABI/testing/sysfs-fs-f2fs |  18 ++-
> >  fs/f2fs/f2fs.h                          |   3 +
> >  fs/f2fs/sysfs.c                         | 152 +++++++++++++++++++++++-
> >  3 files changed, 168 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > index 5088281e312e..43b2cde80b70 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -203,7 +203,23 @@ Description:	Shows total written kbytes issued to disk.
> >  What:		/sys/fs/f2fs/<disk>/features
> >  Date:		July 2017
> >  Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> > -Description:	Shows all enabled features in current device.
> > +Description:	<deprecated: should use /sys/fs/f2fs/<disk>/feature_list/
> > +		Shows all enabled features in current device.
> > +		Supported features:
> > +		encryption, blkzoned, extra_attr, projquota, inode_checksum,
> > +		flexible_inline_xattr, quota_ino, inode_crtime, lost_found,
> > +		verity, sb_checksum, casefold, readonly, compression,
> > +		encrypted_casefold, pin_file.
> 
> Isn't pin_file a feature of the implementation, not of a particular filesystem
> instance?  I.e. something that should go in /sys/fs/f2fs/features/, not here.

Done.

> 
> Likewise for encrypted_casefold, as it is implied by encryption && casefold.

I think encrypted_casefold needs to be in both places:
1) kernel support by kconfig, 2) on-disk support by feature support.

> 
> > +
> > +What:		/sys/fs/f2fs/<disk>/feature_list/
> > +Date:		June 2021
> > +Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> > +Description:	Expand /sys/fs/f2fs/<disk>/features to meet sysfs rule.
> > +		Supported features:
> > +		encryption, block_zoned, extra_attr, projquota, inode_checksum,
> > +		flexible_inline_xattr, quota_ino, inode_crtime, lost_found,
> > +		verity, sb_checksum, casefold, readonly, compression,
> > +		encrypted_casefold, pin_file.
> 
> Is it intentional that the file has "blkzoned" but the directory has
> "blk_zoned"?

I tried to sync this with /sys/fs/f2fs/features/block_zoned. Let me add
a comment in the doc.

> 
> Also, your code has another difference -- "project_quota" is used instead of
> "projquota".  But that's not mentioned above.

Ditto.

> 
> And encrypted_casefold and pin_file don't seem appropriate to include here, as
> mentioned above.

Done.

> 
> > @@ -1665,6 +1665,9 @@ struct f2fs_sb_info {
> >  	struct kobject s_stat_kobj;		/* /sys/fs/f2fs/<devname>/stat */
> >  	struct completion s_stat_kobj_unregister;
> >  
> > +	struct kobject s_disk_feat_kobj;		/* /sys/fs/f2fs/<devname>/feature_list */
> > +	struct completion s_disk_feat_kobj_unregister;
> 
> This is for a particular filesystem instance, not a disk per se.  (A f2fs
> filesystem can use multiple disks.)  So having "disk" in the name doesn't make
> sense.
> 
> Please use more logical names like s_feature_list_kobj,
> f2fs_sb_feature_list_ktype, f2fs_sb_feat_attrs, etc.

Done.

> 
> >  static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> >  		struct f2fs_sb_info *sbi, char *buf)
> >  {
> > +	unsigned long feat_supp = 0;
> > +
> >  	switch (a->id) {
> >  	case FEAT_CRYPTO:
> > +		feat_supp |= f2fs_sb_has_encrypt(sbi) ?
> > +					(1 << FEAT_CRYPTO) : 0;
> > +		fallthrough;
> >  	case FEAT_BLKZONED:
> > -	case FEAT_ATOMIC_WRITE:
> > +		feat_supp |= f2fs_sb_has_blkzoned(sbi) ?
> > +					(1 << FEAT_BLKZONED) : 0;
> > +		fallthrough;
> >  	case FEAT_EXTRA_ATTR:
> > +		feat_supp |= f2fs_sb_has_extra_attr(sbi) ?
> > +					(1 << FEAT_EXTRA_ATTR) : 0;
> > +		fallthrough;
> >  	case FEAT_PROJECT_QUOTA:
> > +		feat_supp |= f2fs_sb_has_project_quota(sbi) ?
> > +					(1 << FEAT_PROJECT_QUOTA) : 0;
> > +		fallthrough;
> >  	case FEAT_INODE_CHECKSUM:
> > +		feat_supp |= f2fs_sb_has_inode_chksum(sbi) ?
> > +					(1 << FEAT_INODE_CHECKSUM) : 0;
> > +		fallthrough;
> >  	case FEAT_FLEXIBLE_INLINE_XATTR:
> > +		feat_supp |= f2fs_sb_has_flexible_inline_xattr(sbi) ?
> > +					(1 << FEAT_FLEXIBLE_INLINE_XATTR) : 0;
> > +		fallthrough;
> >  	case FEAT_QUOTA_INO:
> > +		feat_supp |= f2fs_sb_has_quota_ino(sbi) ?
> > +					(1 << FEAT_QUOTA_INO) : 0;
> > +		fallthrough;
> >  	case FEAT_INODE_CRTIME:
> > +		feat_supp |= f2fs_sb_has_inode_crtime(sbi) ?
> > +					(1 << FEAT_INODE_CRTIME) : 0;
> > +		fallthrough;
> >  	case FEAT_LOST_FOUND:
> > +		feat_supp |= f2fs_sb_has_lost_found(sbi) ?
> > +					(1 << FEAT_LOST_FOUND) : 0;
> > +		fallthrough;
> >  	case FEAT_VERITY:
> > +		feat_supp |= f2fs_sb_has_verity(sbi) ?
> > +					(1 << FEAT_VERITY) : 0;
> > +		fallthrough;
> >  	case FEAT_SB_CHECKSUM:
> > +		feat_supp |= f2fs_sb_has_sb_chksum(sbi) ?
> > +					(1 << FEAT_SB_CHECKSUM) : 0;
> > +		fallthrough;
> >  	case FEAT_CASEFOLD:
> > +		feat_supp |= f2fs_sb_has_casefold(sbi) ?
> > +					(1 << FEAT_CASEFOLD) : 0;
> > +		fallthrough;
> >  	case FEAT_COMPRESSION:
> > +		feat_supp |= f2fs_sb_has_compression(sbi) ?
> > +					(1 << FEAT_COMPRESSION) : 0;
> > +		fallthrough;
> >  	case FEAT_RO:
> > -	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
> > +		feat_supp |= f2fs_sb_has_readonly(sbi) ?
> > +					(1 << FEAT_RO) : 0;
> > +		fallthrough;
> >  	case FEAT_ENCRYPTED_CASEFOLD:
> > -		return sprintf(buf, "supported\n");
> > +		feat_supp |= (f2fs_sb_has_casefold(sbi) &&
> > +				f2fs_sb_has_encrypt(sbi)) ?
> > +					(1 << FEAT_ENCRYPTED_CASEFOLD) : 0;
> > +		fallthrough;
> > +	case FEAT_PIN_FILE:
> > +		feat_supp |= (1 << FEAT_PIN_FILE);
> > +		fallthrough;
> > +	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
> > +	case FEAT_ATOMIC_WRITE:
> > +		if (!a->offset || feat_supp & (1 << a->id))
> > +			return sprintf(buf, "supported\n");
> >  	}
> > -	return 0;
> > +	return sprintf(buf, "not supported\n");
> >  }
> 
> This function doesn't make much sense.
> 
> Part of the problem is that the same function is handling both
> /sys/fs/f2fs/features/ and /sys/fs/f2fs/$s_id/feature_list/.
> 
> All the former needs is to print "supported", since unsupported is indicated by
> the file not being there at all.  So it should simply have its own ->show
> function separate from the one for feature_list/.
> 
> And the feature_list/ ones could just store the F2FS_FEATURE_* bit in
> f2fs_attr::id and check for it using F2FS_HAS_FEATURE().  That would be much
> simpler -- no need for the feat_id enum or the long switch statement.
> 
> Also for feature_list/ it might be better to use "unsupported" than
> "not supported", so that \<supported\> doesn't match...

Done.

> 
> >  static struct f2fs_attr f2fs_attr_##_name = {			\
> >  	.attr = {.name = __stringify(_name), .mode = 0444 },	\
> >  	.show	= f2fs_feature_show,				\
> > +	.offset	= 0,						\
> >  	.id	= _id,						\
> >  }
> 
> There's no need to use the .offset argument if features/ and $s_id/feature_list/
> just used different ->show functions.
> 
> > +#define F2FS_DISK_FEATURE_RO_ATTR(_name, _id)			\
> 
> F2FS_SB_FEATURE_ATTR would be a much better name, since these pertain to a
> filesystem instance (not necessarily a disk), and all the feature attributes are
> read-only.

Used F2FS_SB_FEATURE_RO_ATTR.

> 
> >  static int __maybe_unused segment_info_seq_show(struct seq_file *seq,
> >  						void *offset)
> >  {
> > @@ -1149,6 +1279,15 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
> >  	if (err)
> >  		goto put_stat_kobj;
> >  
> > +	sbi->s_disk_feat_kobj.kset = &f2fs_kset;
> > +	init_completion(&sbi->s_disk_feat_kobj_unregister);
> > +	err = kobject_init_and_add(&sbi->s_disk_feat_kobj,
> > +						&f2fs_disk_feat_ktype,
> > +						&sbi->s_kobj, "feature_list");
> > +	if (err)
> > +		goto put_stat_kobj;
> > +
> > +
> >  	if (f2fs_proc_root)
> >  		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
> >  
> > @@ -1166,6 +1305,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
> >  put_stat_kobj:
> >  	kobject_put(&sbi->s_stat_kobj);
> >  	wait_for_completion(&sbi->s_stat_kobj_unregister);
> > +	kobject_put(&sbi->s_disk_feat_kobj);
> > +	wait_for_completion(&sbi->s_disk_feat_kobj_unregister);
> 
> It seems this should go to its own label.
> 
> Also, please note that it's very easy to get confused between
> /sys/fs/f2fs/features/, /sys/fs/f2fs/$s_id/features, and
> /sys/fs/f2fs/$s_id/feature_list/.  Adding some comments could clarify things a
> lot.

Done.

> 
> - Eric
