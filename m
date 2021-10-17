Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AABB4305CD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 03:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbhJQBUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 21:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhJQBUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 21:20:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1405B61040;
        Sun, 17 Oct 2021 01:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634433513;
        bh=2pEJnugvv7r5TasV5ZvP9ZxHWn1aHcIZhOlEuKX4vNI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hUdK4oHAXEVI1OUUdA0gqGTQWCW1cB+WIXZSdNO67/FJ+ql97fsNqf0hhzlycGNs3
         ML6uywFaduVrl+fiz9RT78IkRLlEg5CPqLmoDbMGuTb8atqf6sn1gCbGLFudeoKSPO
         VoPFO2a9e4i6TwbtHspoHNco6ccBcURWZN//EBA9pUFndHCqybWvgzniZdJ81AR/VQ
         4R4/MJ/U0gLaX9HVxdgPrhNr+mIZhDKsSzw3RtC6po7Mw96uA5b2mbtBgYyG46fa3Y
         /Ns/L2bX/NNCwLIPUFLuHmc9hUu2Sac6yD7YU9fkHnnFihvWub/7UaJMdbmobfpQfb
         vDrOG9lmenpFw==
Message-ID: <428311ea-a1ed-599c-44b0-9558c61495eb@kernel.org>
Date:   Sun, 17 Oct 2021 09:18:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 1/2] erofs: decouple basic mount options from
 fs_context
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Yan Song <imeoer@linux.alibaba.com>,
        Changwei Ge <chge@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20211007070224.12833-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211007070224.12833-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/7 15:02, Gao Xiang wrote:
> Previously, EROFS mount options are all in the basic types, so
> erofs_fs_context can be directly copied with assignment. However,
> when the multiple device feature is introduced, it's hard to handle
> multiple device information like the other basic mount options.
> 
> Let's separate basic mount option usage from fs_context, thus
> multiple device information can be handled gracefully then.
> 
> No logic changes.
> 
> Cc: Liu Bo <bo.liu@linux.alibaba.com>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
