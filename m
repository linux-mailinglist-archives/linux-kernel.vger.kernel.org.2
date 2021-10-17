Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C87A4309FB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbhJQP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237062AbhJQP2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:28:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A552560FE3;
        Sun, 17 Oct 2021 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634484353;
        bh=TOvsoeiySltB72C7sSNt1d8uqiFoxmRPAjkjMfeeol0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QsjUkaYNRsVESwdCPwmI1F+YLL7snIqEvi7bzc+tO2kgP+trWZ4t8rJxsNZEk64QS
         9qfIgn6dNRfNfIQXiZ4rxOqC1+/dM0Z7haP8yh7OH5B0C3iTyYbE6BfX96POKxc+qu
         qXOFmOhts8SZ7Ix6tCqkSVYC8hDR6XYYCnpXZI8KD/IL9CvY+p+S1mk+poDMCkMvD2
         wTWoZAh5CZ2x5uMmM9GEpOm5UEjsXtFdHpZ12FGQXy6/RRMv1jR5HdePed3MJvy3wk
         Bw7bwBTtpnesCu7KzAOfskQbRfOxGtPqUa2y+PiBV41nbtEh0bwXfymxjrTDvT3/Y8
         hia8GHlE+ASyg==
Message-ID: <c56a53cc-3c63-4b87-7d32-2a5a36b48008@kernel.org>
Date:   Sun, 17 Oct 2021 23:25:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/3] erofs: get compression algorithms directly on
 mapping
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211008200839.24541-1-xiang@kernel.org>
 <20211008200839.24541-2-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211008200839.24541-2-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/9 4:08, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Currently, z_erofs_map_blocks_iter() returns whether extents are
> compressed or not, and the decompression frontend gets the specific
> algorithms then.
> 
> It works but not quite well in many aspests, for example:
>   - The decompression frontend has to deal with whether extents are
>     compressed or not again and lookup the algorithms if compressed.
>     It's duplicated and too detailed about the on-disk mapping.
> 
>   - A new secondary compression head will be introduced later so that
>     each file can have 2 compression algorithms at most for different
>     type of data. It could increase the complexity of the decompression
>     frontend if still handled in this way;
> 
>   - A new readmore decompression strategy will be introduced to get
>     better performance for much bigger pcluster and lzma, which needs
>     the specific algorithm in advance as well.
> 
> Let's look up compression algorithms in z_erofs_map_blocks_iter()
> directly instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
