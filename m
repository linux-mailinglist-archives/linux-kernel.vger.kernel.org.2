Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F62344EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhCVSgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhCVSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:35:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Rl+fpF7nw2v6vDCF7gkFj9YxtY+9uWMh+gGI7FFHeJw=; b=oS13UTpVDkfitZDJJQI7pldZVT
        42OvFaFYBhhlEl0Q5RL3KJ2Dp/Wbui9q28TSjopAVr4Ir+D909UXPhreQjR1Siy1scboXBygLM1Yh
        X2q7G1l/8lBi7cnmAyjHYhQvHp2LoYLCWM55Pwr8yI+Z2rLJUlU2jIGcCZ1OqlJgsmjxBvSnUTuFU
        tpGIkIbDMYeqN5ebTQNwc0BhZJeidAZBltuNATUODIZqYOQ/U7IH5pZycZ0+lK07ruF1QhdAO2jC5
        VHRbS7bnIgUPbIi9vCfuvBBrfKTJtSdVLHNPbU2DhIYmcGZzhxMBGITXu337pij1StVfd/ubyuf0Y
        FSbdF81A==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPOL-008vG0-QS; Mon, 22 Mar 2021 18:35:16 +0000
Subject: Re: [PATCH v2] ntfs: fix incorrect kernel-doc comment syntax in files
To:     Aditya Srivastava <yashsri421@gmail.com>, anton@tuxera.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, corbet@lwn.net,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <CAKXUXMxU_7YBqyEeip5kpN5LpYmtR0MFF4QbdtOebxJHC1pkTA@mail.gmail.com>
 <20210322171131.14347-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <30d75349-4f62-d442-9976-ed921ed23dfe@infradead.org>
Date:   Mon, 22 Mar 2021 11:35:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322171131.14347-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 10:11 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are certain files in fs/ntfs which follow this syntax, but the
> content inside does not comply with kernel-doc.
> Such lines were probably not meant for kernel-doc parsing, but are parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'),
> which causes unexpected warnings from kernel-doc.
> 
> E.g., presence of kernel-doc like comment in the header for
> fs/ntfs/attrib.c, causes these unexpected warnings by kernel-doc:
> "warning: Incorrect use of kernel-doc format:  * ntfs_map_runlist_nolock - map (a part of) a runlist of an ntfs inode"
> "warning: Function parameter or member 'ni' not described in 'ntfs_map_runlist_nolock'"
> "warning: Function parameter or member 'vcn' not described in 'ntfs_map_runlist_nolock'"
> "warning: Function parameter or member 'ctx' not described in 'ntfs_map_runlist_nolock'"
> "warning: expecting prototype for c(). Prototype was for ntfs_map_runlist_nolock() instead"
> 
> Similarly for other files too.
> 
> Provide a simple fix by replacing such occurrences with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Also fix enum documentation format at "ntfs_compression_constants", in
> fs/ntfs/compress.c, by prefixing 'enum' keyword to the comment
> description.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes in v2:
> - prefix 'enum' keyword at "ntfs_compression_constants - enum of constants used in the compression code" comment in fs/ntfs/compress.c
> - modify comment message correspondingly
> 
>  fs/ntfs/aops.c     | 2 +-
>  fs/ntfs/aops.h     | 2 +-
>  fs/ntfs/attrib.c   | 2 +-
>  fs/ntfs/compress.c | 8 ++++----
>  fs/ntfs/dir.c      | 4 ++--
>  fs/ntfs/inode.c    | 2 +-
>  fs/ntfs/mft.c      | 2 +-
>  fs/ntfs/runlist.c  | 2 +-
>  8 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> index bb0a43860ad2..1024cdec136a 100644
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * aops.c - NTFS kernel address space operations and page cache handling.
>   *
>   * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
> diff --git a/fs/ntfs/aops.h b/fs/ntfs/aops.h
> index f0962d46bd67..2dcd46befdff 100644
> --- a/fs/ntfs/aops.h
> +++ b/fs/ntfs/aops.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
> -/**
> +/*
>   * aops.h - Defines for NTFS kernel address space operations and page cache
>   *	    handling.  Part of the Linux-NTFS project.
>   *
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index d563abc3e136..2911c04a33e0 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * attrib.c - NTFS attribute operations.  Part of the Linux-NTFS project.
>   *
>   * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index d2f9d6a0ee32..e4e7587e8f7b 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * compress.c - NTFS kernel compressed attributes handling.
>   *		Part of the Linux-NTFS project.
>   *
> @@ -19,7 +19,7 @@
>  #include "ntfs.h"
>  
>  /**
> - * ntfs_compression_constants - enum of constants used in the compression code
> + * enum ntfs_compression_constants - enum of constants used in the compression code
>   */
>  typedef enum {
>  	/* Token types and access mask. */
> @@ -41,12 +41,12 @@ typedef enum {
>  	NTFS_MAX_CB_SIZE	= 64 * 1024,
>  } ntfs_compression_constants;
>  
> -/**
> +/*
>   * ntfs_compression_buffer - one buffer for the decompression engine
>   */
>  static u8 *ntfs_compression_buffer;
>  
> -/**
> +/*
>   * ntfs_cb_lock - spinlock which protects ntfs_compression_buffer
>   */
>  static DEFINE_SPINLOCK(ntfs_cb_lock);
> diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> index cd96083a12c8..518c3a21a556 100644
> --- a/fs/ntfs/dir.c
> +++ b/fs/ntfs/dir.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * dir.c - NTFS kernel directory operations. Part of the Linux-NTFS project.
>   *
>   * Copyright (c) 2001-2007 Anton Altaparmakov
> @@ -17,7 +17,7 @@
>  #include "debug.h"
>  #include "ntfs.h"
>  
> -/**
> +/*
>   * The little endian Unicode string $I30 as a global constant.
>   */
>  ntfschar I30[5] = { cpu_to_le16('$'), cpu_to_le16('I'),
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index f5c058b3192c..4277d0fd7d88 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * inode.c - NTFS kernel inode handling.
>   *
>   * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 0d62cd5bb7f8..d197d402933a 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * mft.c - NTFS kernel mft record operations. Part of the Linux-NTFS project.
>   *
>   * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
> diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
> index 97932fb5179c..0d448e9881f7 100644
> --- a/fs/ntfs/runlist.c
> +++ b/fs/ntfs/runlist.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * runlist.c - NTFS runlist handling code.  Part of the Linux-NTFS project.
>   *
>   * Copyright (c) 2001-2007 Anton Altaparmakov
> 


-- 
~Randy

