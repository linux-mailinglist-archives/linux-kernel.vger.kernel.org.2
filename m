Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AEA460BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 01:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhK2Ajw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 19:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241577AbhK2Ahu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 19:37:50 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BACCC0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:34:33 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id g9so10917338qvd.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MBM2hgPdaVzuMXpexRjt9ys30h1jhGQorZpjq4Xn3Z0=;
        b=dGj3SnbA5SmtMYNWo3TGvZxNH2l2AzDHFCTcq4HbpfyPEMMIPmvYoKa5o9gapOjyk+
         2kFLZK72wFpJruzN1nLuXzknNoDCZSQ0Srx48iI5uuGzb/y+Ihxt31hH7Q5otYntN8Jz
         UrXCtETMpP2V1kgH0nE8FStDsdEsbw/OYAWUDdyjXCbvoAY13Usbeg5GfLtWWQ8K7cdh
         JqaY/HsS25DeMmzxYpjeOu7BehXH3ZCqidYdVZPTGkn/XNlPsMsHu6l8GcmT0Dbe0hQ1
         9uHdM0taM9YU64w0hxLox3v73cNeDoqhLkBDnyO1Ozi1uJWwlbmtUbx901Q4dyJ9hS0B
         HTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MBM2hgPdaVzuMXpexRjt9ys30h1jhGQorZpjq4Xn3Z0=;
        b=Z/SY5cY53xMYG+FfQtu525vgDfAnhWZ15YZce+Wa9iUcGc7AwxSeOXn062bwyjRJiK
         FHRAlneCUEroYEBEiuCdvs/YPuJOBfbT2hpM4iJ6rlVX1h/8VBzIIMxs0eBj7cFrZzs4
         cVxBh/DBMhr93nHmqc2Nx9kLhzMuJW7i+CmsoiIoQlXn1ISzaJ4R38wGYQG+e9QZaT3I
         AX35ku3QOGuyy/aiqV/K3qEYM6KtUDaAT0rzhwYdEB3rtTO1bFzcqkVjxFJUcjOOe3sH
         unFYc+Clt2pgh8VrUBLkQpB+zhsrvNX7XPpTdU1TCzbfrbS11487EE2EQgwt8OPoyh/4
         bWAA==
X-Gm-Message-State: AOAM532iNlVpuuBqUOMTUryPW43Q058623tRis1BMN+Op2xeSOAoVfYx
        BzwLQOT1WWrvmczI7KgSGyT93lgNkDQLMw==
X-Google-Smtp-Source: ABdhPJzO5gPPfBV+W09kPFiNQECpR/BRbY61wXGLhhGDeoKNy4D3Dx6Gluzmq2+xIF3KxSUuLW0EoQ==
X-Received: by 2002:ad4:5b82:: with SMTP id 2mr26362228qvp.87.1638146072148;
        Sun, 28 Nov 2021 16:34:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i16sm7687059qtx.57.2021.11.28.16.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:34:31 -0800 (PST)
Date:   Sun, 28 Nov 2021 19:34:30 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] fs: btrfs: several possible ABBA deadlocks
Message-ID: <YaQgFhuaQHsND/jr@localhost.localdomain>
References: <44b385ca-f00d-0b47-e370-bd7d97cb1be3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44b385ca-f00d-0b47-e370-bd7d97cb1be3@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 04:23:37PM +0800, Jia-Ju Bai wrote:
> Hello,
> 
> My static analysis tool reports several possible ABBA deadlocks in the btrfs
> module in Linux 5.10:
> 
> # DEADLOCK 1:
> __clear_extent_bit()
>   spin_lock(&tree->lock); --> Line 733 (Lock A)
>   split_state()
>     btrfs_split_delalloc_extent()
>       spin_lock(&BTRFS_I(inode)->lock); --> Line 1870 (Lock B)
> 
> btrfs_inode_safe_disk_i_size_write()
>   spin_lock(&BTRFS_I(inode)->lock); --> Line 53 (Lock B)
>   find_contiguous_extent_bit()
>     spin_lock(&tree->lock); --> Line 1620 (Lock A)
> 
> When __clear_extent_bit() and btrfs_inode_safe_disk_i_size_write() are
> concurrently executed, the deadlock can occur.
> 
> # DEADLOCK 2:
> __set_extent_bit()
>   spin_lock(&tree->lock); --> Line 995 (Lock A)
>   set_state_bits()
>     btrfs_set_delalloc_extent()
>       spin_lock(&BTRFS_I(inode)->lock); --> Line 2007 or 2017 or 2029 (Lock
> B)
> 
> btrfs_inode_safe_disk_i_size_write()
>   spin_lock(&BTRFS_I(inode)->lock); --> Line 53 (Lock B)
>   find_contiguous_extent_bit()
>     spin_lock(&tree->lock); --> Line 1620 (Lock A)
> 
> When __set_extent_bit() and btrfs_inode_safe_disk_i_size_write() are
> concurrently executed, the deadlock can occur.
> 
> # DEADLOCK 3:
> convert_extent_bit()
>   spin_lock(&tree->lock); --> Line 1241 (Lock A)
>   set_state_bits()
>     btrfs_set_delalloc_extent()
>       spin_lock(&BTRFS_I(inode)->lock); --> Line 2007 or 2017 or 2029 (Lock
> B)
> 
> btrfs_inode_safe_disk_i_size_write()
>   spin_lock(&BTRFS_I(inode)->lock); --> Line 53 (Lock B)
>   find_contiguous_extent_bit()
>     spin_lock(&tree->lock); --> Line 1620 (Lock A)
> 
> When convert_extent_bit() and btrfs_inode_safe_disk_i_size_write() are
> concurrently executed, the deadlock can occur.
> 
> I am not quite sure whether these possible deadlocks are real and how to fix
> them if they are real.
> Any feedback would be appreciated, thanks :)
> 

Hey Jia-Ju,

This is pretty good work, unfortunately it's wrong but it's in a subtle way that
a tool wouldn't be able to catch.  The btrfs_inode_safe_disk_i_size_write()
helper only messes with BTRFS_I(inode)->file_extent_tree, which is separate from
the BTRFS_I(inode)->io_tree.  io_tree gets the btrfs_set_delalloc_extent() stuff
called on it, but the file_extent_tree does not.  The file_extent_tree has
inode->lock -> tree->lock as the locking order, whereas the file_extent_tree has
inode->lock -> tree->lock as the locking order.  Thanks,

Josef
