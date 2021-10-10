Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1B428126
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 14:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhJJMPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 08:15:47 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:41726 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhJJMPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 08:15:46 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Oct 2021 08:15:46 EDT
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id A55C514CD0E;
        Sun, 10 Oct 2021 21:07:02 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-23) with ESMTPS id 19AC6uss023128
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 10 Oct 2021 21:06:57 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-23) with ESMTPS id 19AC6tpm125346
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 10 Oct 2021 21:06:56 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 19AC6qQ4125340;
        Sun, 10 Oct 2021 21:06:52 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     angus@akkea.ca, linux-kernel@vger.kernel.org, kay.sievers@vrfy.org,
        lennart@poettering.net, harald@redhat.com,
        gregkh@linuxfoundation.org, david@fubar.dk, tytso@mit.edu,
        alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org,
        pali.rohar@gmail.com
Subject: Re: [PATCH] fs: fat: Make the volume label writable when mounted
References: <20211007095639.5002-1-martink@posteo.de>
Date:   Sun, 10 Oct 2021 21:06:52 +0900
In-Reply-To: <20211007095639.5002-1-martink@posteo.de> (Martin Kepplinger's
        message of "Thu, 7 Oct 2021 09:56:39 +0000")
Message-ID: <874k9pccdf.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Kepplinger <martink@posteo.de> writes:

> The motivation for this change (probably) has its origin in a whishlist
> for the kernel that popped up in 2011, see
> https://lore.kernel.org/lkml/1319135973.1020.9.camel@mop/

I'm ok this patch if some userspace wants to use in real world.

The whole point of this should be to provide access without any race,
however this looks like broken many ways.

> +/* protect access to the FAT fs label */
> +DEFINE_MUTEX(label_mutex);

nothing reason to be global lock (iow, should be per-sb)?

> +	/* code found in inode.c */
> +	fat_get_blknr_offset(sbi, i_pos, &blocknr, &offset);
> +	bh = sb_bread(sb, blocknr);
> +	if (!bh) {
> +		fat_msg(sb, KERN_ERR,
> +			"unable to read inode block for updating (i_pos %lld)",
> +			i_pos);
> +		return -EIO;
> +	}

reading dir block manually, this can read full of dir blocks for fat32?

> +	de = NULL;
> +	err = fat_get_label_entry(root_inode, &bh, &de);
> +	if (err)
> +		return err;
> +
> +	if (label) {
> +		fat_msg(sb, KERN_INFO,
> +			"rename directory label from %.11s to %.11s",
> +			de->name, label);
> +		mutex_lock(&label_mutex);
> +		strncpy(de->name, label, MSDOS_NAME);
> +		mark_buffer_dirty(bh);
> +		sync_dirty_buffer(bh);
> +		brelse(bh);
> +		mutex_unlock(&label_mutex);

race with normal dir operations?

> +	if (sbi->fat_bits == 32) {
> +		if (label) {
> +			fat_msg(sb, KERN_INFO,
> +				"rename partition label from %.11s to %.11s",
> +				b->fat32.vol_label, label);

nothing reason to output message for user input.

> +			mutex_lock(&MSDOS_SB(sb)->s_lock);
> +			b->fat32.state |= FAT_STATE_DIRTY;
> +			memcpy(b->fat32.vol_label, label, MSDOS_NAME);
> +			mutex_unlock(&MSDOS_SB(sb)->s_lock);
> +		} else {
> +			b->fat32.state &= ~FAT_STATE_DIRTY;
> +			fat_msg(sb, KERN_INFO, "partition label is %.11s",
> +				b->fat32.vol_label);
> +		}

why do you touch dirty state?

> +	} else {
> +		if (label) {
> +			fat_msg(sb, KERN_INFO,
> +				"rename partition label from %.11s to %.11s ",
> +				b->fat16.vol_label, label);
> +
> +			mutex_lock(&MSDOS_SB(sb)->s_lock);
> +			b->fat32.state |= FAT_STATE_DIRTY;
> +			memcpy(b->fat32.vol_label, label, MSDOS_NAME);
> +			mutex_unlock(&MSDOS_SB(sb)->s_lock);
> +		} else {
> +			b->fat32.state &= ~FAT_STATE_DIRTY;
> +			fat_msg(sb, KERN_INFO, "partition label is %.11s",
> +				b->fat16.vol_label);
> +		}
> +	}

ditto

> +	mark_buffer_dirty(bh);
> +	sync_dirty_buffer(bh);
> +	brelse(bh);

why need to sync here?

> +	if (!user_attr) {
> +		label = NULL;
> +		goto print_only;

This outputs only label to dmesg, too strange syscall design. Probably,
we would be better to delete label or such for NULL.

> +	label = newlabel;
> +	err = copy_from_user(label, (void *)user_attr, MSDOS_NAME);

do we need cast here?

> +	if (err) {
> +		fat_msg(sb, KERN_ERR,
> +			"copy_from_user failed %d bytes not copied\n", err);
> +		return -EFAULT;

user fault should not output message basically.

> +		for (i = 0; i < len; i++) {
> +			c = label[i];
> +			if ((c < 'a' || c > 'z') && (c < 'A' || c > 'Z')) {
> +				if ((c < '0' || c > '9') && c != 0x20)
> +					return -EINVAL;

IIRC, label allows much more characters.

> +	err = fat_set_directory_volume_label(file, label);
> +	if (err == -ENOENT) {
> +		fat_msg(sb, KERN_ERR, "no label entry. please reformat\n");
> +		strncpy(label, "NO NAME    ", MSDOS_NAME);

no label entry should be normal state, and should not output message

> +	} else if (err) {
> +		fat_msg(sb, KERN_ERR, "error setting directory label\n");
> +		return err;
> +	}
> +
> +	err = fat_set_partition_volume_label(file, label);
> +	if (err) {
> +		fat_msg(sb, KERN_ERR, "error setting partition label\n");
> +		return err;
> +	}

strange messages, how interacting with the user should be basically the
job of userspace tools.

> diff --git a/include/uapi/linux/msdos_fs.h b/include/uapi/linux/msdos_fs.h
> index a5773899f4d9..b666bca09238 100644
> --- a/include/uapi/linux/msdos_fs.h
> +++ b/include/uapi/linux/msdos_fs.h
> @@ -104,6 +104,7 @@ struct __fat_dirent {
>  #define FAT_IOCTL_SET_ATTRIBUTES	_IOW('r', 0x11, __u32)
>  /*Android kernel has used 0x12, so we use 0x13*/
>  #define FAT_IOCTL_GET_VOLUME_ID		_IOR('r', 0x13, __u32)
> +#define VFAT_IOCTL_SET_LABEL		_IOW('r', 0x14, __u32)

maybe FAT_IOCTL_SET_LABEL is better.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
