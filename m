Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695DF314352
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 23:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhBHWzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 17:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhBHWzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 17:55:07 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268D4C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 14:54:27 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id t25so15816720otc.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 14:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kVUOEc5nkXmVvfZidGnyIjkcOxFERzMz3epUtID1enM=;
        b=HnBDHRhtT5UEp7iPoSHsC38SU/teqOAMudFS/tRIWgMSz/HRv5hjIF3E42OPTc2jby
         zkGe4KLfxuujJnSJ5+rjhLCzG+I8FCGeve+XqieANDs7k2Xv7Yp7y1Vf42I7AV5TjTTO
         Yr8Focc9SbKedfVNZGW6OYr+JoxVlonA3VUmkNnGmgd8iuSN7z4D6K5GhC75Z4wG0a7b
         BRo+0iixfOVaTdXnhgNxCBgdpF+McR5mmLTRJ12RorJdJ9WZK+pQOMDHu8eXZUjWJ0+m
         B7nS+1kmc0eNDYbXmd/DOLB08vClYB0J0dbv3CxTu+W+2BgZXi0AeAAigUg5Kggi1k5g
         Y1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kVUOEc5nkXmVvfZidGnyIjkcOxFERzMz3epUtID1enM=;
        b=mKT/u4+nMFo3gMvVsLEB0tHrHUVAkGjRA47MkcVZW3IzJJqCooh3omoj1hc2JMhgeb
         l9w4dy6H5F/Jn1Gi7ZshE8AJ/xZcrNM6bLV7crPnv3LDdLKkXenQ71rHcmA/x1QETl4B
         Sj4O5Z22h/SanNhRATwkRQm0+IFthiY3og7Tc6zI8dMuj3jZH426gTC6dEQNshLECisP
         ZlE1MUU67wc65EMiTNe5i4P53vZPuxIzDmAinPT6CoPXcrr/J1/XIkozlxOkDMEgfuDC
         9TuKYiN+JCeaJSJvJdZk/vVeI7u313wnQL1pwQwjdMJmtA61HP1TEDc2r6RjTT9RdeCe
         0Byw==
X-Gm-Message-State: AOAM530g3Hdw166hbUh97TfY8Luikzgh9NRI4uJ2HgCgpJhRtGu+4U5Q
        XicePcGaV+UxebDUoAXgscSf7Q==
X-Google-Smtp-Source: ABdhPJy6ZAJf2785F9OGdiYnUNfZToYJLrL7FwNOvKftEOKRek5KVmb6Aw4ovS2MYtwBFFBVOVFkwA==
X-Received: by 2002:a9d:27e3:: with SMTP id c90mr10623578otb.2.1612824864438;
        Mon, 08 Feb 2021 14:54:24 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w124sm853165oiw.40.2021.02.08.14.54.22
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 08 Feb 2021 14:54:23 -0800 (PST)
Date:   Mon, 8 Feb 2021 14:54:20 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Seth Forshee <seth.forshee@canonical.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Down <chris@chrisdown.name>,
        Amir Goldstein <amir73il@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] tmpfs: disallow CONFIG_TMPFS_INODE64 on alpha
In-Reply-To: <20210208215726.608197-1-seth.forshee@canonical.com>
Message-ID: <alpine.LSU.2.11.2102081451180.4656@eggly.anvils>
References: <20210208215726.608197-1-seth.forshee@canonical.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021, Seth Forshee wrote:

> As with s390, alpha is a 64-bit architecture with a 32-bit ino_t.
> With CONFIG_TMPFS_INODE64=y tmpfs mounts will get 64-bit inode
> numbers and display "inode64" in the mount options, whereas
> passing "inode64" in the mount options will fail. This leads to
> erroneous behaviours such as this:
> 
>  # mkdir mnt
>  # mount -t tmpfs nodev mnt
>  # mount -o remount,rw mnt
>  mount: /home/ubuntu/mnt: mount point not mounted or bad option.
> 
> Prevent CONFIG_TMPFS_INODE64 from being selected on alpha.
> 
> Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
> Cc: stable@vger.kernel.org # v5.9+
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Thanks,
Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  fs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 3347ec7bd837..da524c4d7b7e 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -203,7 +203,7 @@ config TMPFS_XATTR
>  
>  config TMPFS_INODE64
>  	bool "Use 64-bit ino_t by default in tmpfs"
> -	depends on TMPFS && 64BIT && !S390
> +	depends on TMPFS && 64BIT && !(S390 || ALPHA)
>  	default n
>  	help
>  	  tmpfs has historically used only inode numbers as wide as an unsigned
> -- 
> 2.29.2
