Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445A131677E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhBJNIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230268AbhBJNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612962339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x01ruuxA0cfwcbVBCUqqYJWqKZiSU+Bm+OyEXVm7xtY=;
        b=cXB6VDP99fgpJzgeIa/UJnhEM9OZSAB2ZdiigrqvFNpy10I4XCw4jNRn4XEdY15f6MGd9c
        oS9XqzP/sX58bs3d0HF3b6GY2mmT6AWYOeZjmQtnkUI1iDeAdS/Cy4426cqW1zly4vFP8j
        agzB6StLg8gdeO5sYRzXp/42iMXrKMM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-_1A6827dPNuUPVCBE1rSCA-1; Wed, 10 Feb 2021 08:05:38 -0500
X-MC-Unique: _1A6827dPNuUPVCBE1rSCA-1
Received: by mail-pl1-f199.google.com with SMTP id n2so1648762plc.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x01ruuxA0cfwcbVBCUqqYJWqKZiSU+Bm+OyEXVm7xtY=;
        b=qSjdCFnHxpjXgAiMSKHhruzZMUTOpuXTqsxYkrdWBsbj71dK2RzAQE/bE31Ax317nW
         F2i9p9diO7/WRqZRcjh6KmH5LZR4QUSYMxzoD5XBxoxrmwzl9le3d40uRpQFEcgBwAmQ
         IrZeCzTVg9JjXDU9VFbgbYOUv6IQp/T3X3xM5lmTzC/gNg/7kV/V8Q/hcrvMHvqwbkFZ
         q9vAsgqAJSsRzHznO2U2tVWBk5suYAyma+MQ8Mvuho4uTkClMTYLO8LnaXZQApDpAAnI
         a4Rapk1kkQuooYmd6JkVz9N3MQrSkBsJchAbxzC7P2US18XLLh9uHgkRtgbb8dL8KKZZ
         F4Fw==
X-Gm-Message-State: AOAM532wzt0bYD68c0Eyx8Ml2J1LCW49CG6rIoWLI8lSQVBRRnhB1W6t
        kCnn5FI5RvAf6/FEsjd/buV2HK+yXhw7J9HrvSeYKDOzZbqBeTWNHZya3mDSqD9qZ78IKBnfIet
        8w5j79u6CSBWYInzLl+Rsc11Y
X-Received: by 2002:a17:90a:9912:: with SMTP id b18mr3066428pjp.120.1612962336875;
        Wed, 10 Feb 2021 05:05:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdnKAhSt6eJBEp/ZLzVhLX2BIuwzX2ua4xi+0pCTvmPOXEWG9GP4YnGf6EeZ8KNgbnoje4fw==
X-Received: by 2002:a17:90a:9912:: with SMTP id b18mr3066406pjp.120.1612962336608;
        Wed, 10 Feb 2021 05:05:36 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 124sm2367866pfd.59.2021.02.10.05.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 05:05:35 -0800 (PST)
Date:   Wed, 10 Feb 2021 21:05:25 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot+c68f467cd7c45860e8d4@syzkaller.appspotmail.com
Subject: Re: [PATCH] erofs: fix shift-out-of-bounds of blkszbits
Message-ID: <20210210130525.GB1173803@xiangao.remote.csb>
References: <20210120013016.14071-1-hsiangkao.ref@aol.com>
 <20210120013016.14071-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120013016.14071-1-hsiangkao@aol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Wed, Jan 20, 2021 at 09:30:16AM +0800, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> syzbot generated a crafted bitszbits which can be shifted
> out-of-bounds[1]. So directly print unsupported blkszbits
> instead of blksize.
> 
> [1] https://lore.kernel.org/r/000000000000c72ddd05b9444d2f@google.com
> Reported-by: syzbot+c68f467cd7c45860e8d4@syzkaller.appspotmail.com
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Could you kindly review this trivial syzaller patch as well? Since
"erofs: initialized fields can only be observed after bit is set"
is somewhat serious on some weak-memory-order designed platforms
(no idea why our hisilison ARM64 platform didn't observe it before.)
I intended to prepare this for 5.13 cycle directly with ongoing
multi pcluster / LZMA in-kernel decompresion. But that regression
seems a bit important to upstream for the next 5.12 cycle....

Thanks,
Gao Xiang

> ---
>  fs/erofs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index be10b16ea66e..d5a6b9b888a5 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -158,8 +158,8 @@ static int erofs_read_superblock(struct super_block *sb)
>  	blkszbits = dsb->blkszbits;
>  	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
>  	if (blkszbits != LOG_BLOCK_SIZE) {
> -		erofs_err(sb, "blksize %u isn't supported on this platform",
> -			  1 << blkszbits);
> +		erofs_err(sb, "blkszbits %u isn't supported on this platform",
> +			  blkszbits);
>  		goto out;
>  	}
>  
> -- 
> 2.24.0
> 

