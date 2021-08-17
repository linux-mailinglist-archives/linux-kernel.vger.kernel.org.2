Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDCF3EF0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhHQRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhHQRVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 13:21:31 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED86C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 10:20:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y34so42750015lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NiKTumcxK3zbWymWmeoCtw+XIrZL7iXfa8NnINXFFdQ=;
        b=ol1JWvVLZ6N+Ufee9ZVYYnNNvs7XXqEUhDOOvXHkv7+hFQkGLXjCf6rfhSI1tBS/WC
         sip5eEbObVm5bHwhY9m5n/Eol31AWyn6tomH3UPJ7E5mSCBTzwEXLReBtnSk/tB3AksE
         61zjtXOw15cF9HloLeFcHlpQjZf6akFytgf1u6yAvRjBFS/tWiFxf/rYON4YXZGkA0lf
         uoyYCS2AWCEm29pKHur1gBSN/qFSRnFjH5y//2wyogwc1WRwj7/YSQguxXzctKMw5ySn
         9BpPgNgeAbQ6jpMRczubQ+M/VJzBzfhB4W2P1PXQ+o1txQU8yr9m9oUzKObVh01akOKq
         5uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NiKTumcxK3zbWymWmeoCtw+XIrZL7iXfa8NnINXFFdQ=;
        b=t7YU4m9t/RV26v1NP3bvX9TM+s8tgU4qk39z/UdkodTCLrBAMUsQrgfgCE07A5JAer
         aCIK1jIvc2vwvFzbTy/FFTe/fhp4zP8O68gynBD537TiryYvTjWIMqGzgvMg4IKjFoF2
         YFb4fA+0xswymYlZik2fdz28wGegMZGeQkaOdGUV+SNy961HbokX19FqN0k99VQ/SxNL
         srptOVJm9sHD3TceyKt4orfh8lI7qJ0U1ryhuSD2vkfMjhB9FFPFWi/+vrZf+iBszUYS
         fvrCQs2yvmnsvWQYqWlni/Y+gbVbY00u0nCoHh67w1E8Lrx+8I1Y5YXfo1PuYeml9g4+
         0XYw==
X-Gm-Message-State: AOAM531fCE6KkpxZUZEzRvHG66fU+kKtey3p0gvrVWuPSUypLCU9mqsi
        9h+7La/42ha9lYn4evVWV4Y=
X-Google-Smtp-Source: ABdhPJwXdFTAlZU2oO3/vJEy8drzCS98YkYbfTxSrfghuikebTK+KAENX4h+oWDHpXypuL3Nib/3vg==
X-Received: by 2002:a05:6512:38ab:: with SMTP id o11mr3324394lft.5.1629220855957;
        Tue, 17 Aug 2021 10:20:55 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id f10sm241444lfr.303.2021.08.17.10.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:20:55 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:20:53 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Do not use driver own alloc wrappers
Message-ID: <20210817172053.6gyy3nhpc75pygod@kari-VirtualBox>
References: <20210817143848.245324-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817143848.245324-1-kari.argillander@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 05:38:48PM +0300, Kari Argillander wrote:
> Ntfs3 driver contains self made alloc wrappers. Problem with these
> wrappers is that we cannot take off example GFP_NOFS flag. It is not
> recomended use those in all places. Also if we change one driver
> specific wrapper to kernel wrapper then it would look really wierd.
> People should be most familiar with kernel wrappers so let's just use
> those ones.
> 
> Driver specific alloc wrapper might also confuse some static analyzing
> tools, but I do not have real world example.

Actually I do. checkpatch.pl will now give following warnings so
checkpatch was triggered with self made wrappers.

WARNING: Prefer kcalloc over kzalloc with multiply
#170: FILE: fs/ntfs3/bitmap.c:686:
+	wnd->free_bits = kzalloc(wnd->nwnd * sizeof(u16), GFP_NOFS);

WARNING: Prefer kmalloc_array over kmalloc with multiply
#179: FILE: fs/ntfs3/bitmap.c:1357:
+		new_free = kmalloc(new_wnd * sizeof(u16), GFP_NOFS);

WARNING: Prefer kcalloc over kzalloc with multiply
#284: FILE: fs/ntfs3/frecord.c:2053:
+	pages = kzalloc(pages_per_frame * sizeof(struct page *), GFP_NOFS);

WARNING: Prefer kcalloc over kzalloc with multiply
#302: FILE: fs/ntfs3/frecord.c:2136:
+	pages = kzalloc(pages_per_frame * sizeof(struct page *), GFP_NOFS);

WARNING: Prefer kmalloc_array over kmalloc with multiply
#1016: FILE: fs/ntfs3/index.c:684:
+	offs = kmalloc(sizeof(u16) * nslots, GFP_NOFS);

WARNING: Prefer kmalloc_array over kmalloc with multiply
#1025: FILE: fs/ntfs3/index.c:706:
+		ptr = kmalloc(sizeof(u16) * new_slots, GFP_NOFS);

> Following Coccinelle script was used to automate most of this patch:
> 
> virtual patch
> 
> @alloc depends on patch@
> expression x;
> expression y;
> @@
> (
> -	ntfs_malloc(x)
> +	kmalloc(x, GFP_NOFS)
> |
> -	ntfs_zalloc(x)
> +	kzalloc(x, GFP_NOFS)
> |
> -	ntfs_vmalloc(x)
> +	kvmalloc(x, GFP_NOFS)
> |
> -	ntfs_free(x)
> +	kfree(x)
> |
> -	ntfs_vfree(x)
> +	kvfree(x)
> |
> -	ntfs_memdup(x, y)
> +	kmemdup(x, y, GFP_NOFS)
> )
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
> 
> Christoph also nack about these so I CC him.
 
