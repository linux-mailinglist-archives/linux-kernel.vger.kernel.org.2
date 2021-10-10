Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7984842812C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 14:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhJJMUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 08:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231892AbhJJMUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 08:20:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B25A560D42;
        Sun, 10 Oct 2021 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633868299;
        bh=iLj2MpGB1WIVyMpUNkkS49LMRVq2pz/qDF6FnIC1qWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sovEQ2HVT7iYQZSPiDHcR3JgAiLt1L/nkeY3g5uIoYS8BFns1FVCkx0k0iMXaTzdq
         K60bnx8lxuMZ9fBlESH+Ddq96E0EnorytJ6MqdooTRB6x6yfmDx984gEYU96liEmV8
         yyn/CXtUje3tmqmGsuKf8//6LqqWy94VzFtpiWPd19+ZlHr71jQ/v7zuojrpni8mkD
         dKbYdjPvwFYneJwzTH8ftbUWzNqynNBEDgBWKjsRec7rvUXg8oHoYk5z8vDFNeEW1s
         P4cn2ECIBCKZJb7MJI0KRbgQl4uhO7jyIxjO/dS81eg1nHcW3hXDRPMJOe+3DAMz5Y
         26LS9Y6TkQyFw==
Received: by pali.im (Postfix)
        id E45A8795; Sun, 10 Oct 2021 14:18:16 +0200 (CEST)
Date:   Sun, 10 Oct 2021 14:18:16 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, angus@akkea.ca,
        linux-kernel@vger.kernel.org, kay.sievers@vrfy.org,
        lennart@poettering.net, harald@redhat.com,
        gregkh@linuxfoundation.org, david@fubar.dk, tytso@mit.edu,
        alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org
Subject: Re: [PATCH] fs: fat: Make the volume label writable when mounted
Message-ID: <20211010121816.fdvn6uiiteszbnql@pali>
References: <20211007095639.5002-1-martink@posteo.de>
 <874k9pccdf.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k9pccdf.fsf@mail.parknet.co.jp>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sunday 10 October 2021 21:06:52 OGAWA Hirofumi wrote:
> > diff --git a/include/uapi/linux/msdos_fs.h b/include/uapi/linux/msdos_fs.h
> > index a5773899f4d9..b666bca09238 100644
> > --- a/include/uapi/linux/msdos_fs.h
> > +++ b/include/uapi/linux/msdos_fs.h
> > @@ -104,6 +104,7 @@ struct __fat_dirent {
> >  #define FAT_IOCTL_SET_ATTRIBUTES	_IOW('r', 0x11, __u32)
> >  /*Android kernel has used 0x12, so we use 0x13*/
> >  #define FAT_IOCTL_GET_VOLUME_ID		_IOR('r', 0x13, __u32)
> > +#define VFAT_IOCTL_SET_LABEL		_IOW('r', 0x14, __u32)
> 
> maybe FAT_IOCTL_SET_LABEL is better.

Please do not introduce a new fs specific ioctls. There is already
vfs-agnostic FS_IOC_SETFSLABEL ioctl, look at manpage:
https://man7.org/linux/man-pages/man2/ioctl_fslabel.2.html

I have WIP patches which adds support for FS_IOC_SETFSLABEL ioctl into
kernel vfat driver. But it is not possible to implement this ioctl
properly until issues with encoding are fixed in vfat driver. Some of
dependency patches I have sent to ML as RFC series:
https://lore.kernel.org/lkml/20210808162453.1653-1-pali@kernel.org/

If you have a time and motivation, I can send you my unfinished WIP
patches which implements FS_IOC_SETFSLABEL ioctl for vfat.
