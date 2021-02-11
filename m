Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A13182F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 02:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhBKBQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 20:16:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhBKBQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 20:16:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0117A6146D;
        Thu, 11 Feb 2021 01:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613006145;
        bh=hWpMFDvhdeaSaUSFOQZMqSuM/fCNtN3RQDyF51Ik2Dc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RcEdLIJowKtFimfaXiZlA9uGx+iwXeZqdOTJJq49GeD1cRMy7b3yiwNdrOZrY8P5q
         c2wx4YG2HNgR4ri1SOm/ZUs6bcnMvErQpNXoT4rewuCYLddHrD53qJUJIqfZg0+aXD
         lzSUSe4lMh/RoFGXD6ccBbP1TECuWEbT7gfI74CXzG/iZbGBdDzzgK27yjei0AZDCs
         zj+rAjRYBQDpHadwaeTtS1EKA36IKyEQLdi1UKOUAg+z9Dgs+GrtVCxTf2PtNCP21W
         igquIYRXEp782mWQgZAQrxdXJtCHhiqLjYoty+LRdCog2vRmP7NdEYQg6qMdDaN/0a
         yGrmf32m30k3A==
Subject: Re: [PATCH] erofs: fix shift-out-of-bounds of blkszbits
To:     Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
Cc:     syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+c68f467cd7c45860e8d4@syzkaller.appspotmail.com
References: <20210120013016.14071-1-hsiangkao.ref@aol.com>
 <20210120013016.14071-1-hsiangkao@aol.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <b950de55-e086-c7f8-0303-6033c589619a@kernel.org>
Date:   Thu, 11 Feb 2021 09:15:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210120013016.14071-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/20 9:30, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> syzbot generated a crafted bitszbits which can be shifted
> out-of-bounds[1]. So directly print unsupported blkszbits
> instead of blksize.
> 
> [1] https://lore.kernel.org/r/000000000000c72ddd05b9444d2f@google.com
> Reported-by: syzbot+c68f467cd7c45860e8d4@syzkaller.appspotmail.com
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Sorry, I missed this patch.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
