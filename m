Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF863B5524
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 22:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhF0UlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 16:41:14 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:40436 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231473AbhF0UlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 16:41:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UdpbFBM_1624826326;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UdpbFBM_1624826326)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Jun 2021 04:38:47 +0800
Date:   Mon, 28 Jun 2021 04:38:45 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: erofs: update my email address
Message-ID: <YNjh1XYptQu0ozuI@B-P7TQMD6M-0146.local>
References: <20210627133229.8025-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210627133229.8025-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 09:32:29PM +0800, Chao Yu wrote:
> Old email address will be invalid after a few days, update it
> to kernel.org one.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>

Acked-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93ce2b8c1b44..7fa367400f7d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6763,7 +6763,7 @@ F:	include/video/s1d13xxxfb.h
>  
>  EROFS FILE SYSTEM
>  M:	Gao Xiang <xiang@kernel.org>
> -M:	Chao Yu <yuchao0@huawei.com>
> +M:	Chao Yu <chao@kernel.org>
>  L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
> -- 
> 2.22.1
