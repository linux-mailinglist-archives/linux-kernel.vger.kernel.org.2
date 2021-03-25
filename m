Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A193498AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCYRwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:52:15 -0400
Received: from ms.lwn.net ([45.79.88.28]:44908 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhCYRvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:51:48 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C365831A;
        Thu, 25 Mar 2021 17:51:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C365831A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616694707; bh=rA7cqcRlp71tozs/M/FK0n4noqD5Di3oUen8vZOp+2A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sDWDxFTf6cMcYFpPzdbhtJw8UWmoZnoJcii2gabnrfefA91RA5LYmWUvgtlVCNduN
         2T6GRqj2fE6+Hi/FkmdN0ktRxYeeFeuBQfzrVKNqhF3zslZWZ4QjHNWfOU4Mto4gJn
         VNrGlkvB3aArIhZPzEQet/+ET5y7kyKbVnhE29i/SqoyCororfyQrX82Rx0O2pPPcp
         E13k8f11Y+1uX/ij5UVpWo74TJ4p/PhTvMwkllC87pHoCVNehJw2Ej0Fc659fFmYdC
         FYmuJSTSJzgmA/+9+b3lZpn0SWCq2IlbYxen53k/Mzn8E/wqKwid/TDhleTctIwoiW
         9hOyHTt/CXwSg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        hirofumi@mail.parknet.co.jp, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH] docs: filesystems: Fix a mundane typo
In-Reply-To: <20210319015848.19515-1-unixbhaskar@gmail.com>
References: <20210319015848.19515-1-unixbhaskar@gmail.com>
Date:   Thu, 25 Mar 2021 11:51:47 -0600
Message-ID: <87ft0j15qk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

> s/provisoned/provisioned/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/filesystems/vfat.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/vfat.rst b/Documentation/filesystems/vfat.rst
> index e85d74e91295..760a4d83fdf9 100644
> --- a/Documentation/filesystems/vfat.rst
> +++ b/Documentation/filesystems/vfat.rst
> @@ -189,7 +189,7 @@ VFAT MOUNT OPTIONS
>  **discard**
>  	If set, issues discard/TRIM commands to the block
>  	device when blocks are freed. This is useful for SSD devices
> -	and sparse/thinly-provisoned LUNs.
> +	and sparse/thinly-provisioned LUNs.

Applied, thanks.

jon
