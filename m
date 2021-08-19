Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB623F11C7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbhHSDdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237020AbhHSDdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:33:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24F5A6044F;
        Thu, 19 Aug 2021 03:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629343952;
        bh=J7zcvWJK4OZy21e19EhcGy6y2c9vUU1+2tNmbKsF1BA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F2XWpu8YCwp5nqppcPKjiZOzdqvQDP1osizNCVr07bdVh1blCdJfEvkOUfeOzGdwu
         WlWUhM2fgs1QjhRWI8ZyhJiNBqsb/KT1UBzv9IXsQcEqaT921SbdDEU98+u2LHp0OG
         alPf1x2pYsh82yweh6DrhLV45g8Rn673KEhazh6101pY343f/ZQt6zM+E9cLT4k3fe
         znAARZpkuU+ToyhFGbH2I6HihM86KXRn+bOivYFEPh30qZsOSuAevC2ffvG2N+EYWy
         STVMENPyVOLTLGBKtPYsCD4IDnlaq/w9x+xDsDtFl61kMymuBzJ4IYRPk9WD5NOJa8
         UX1NIE7F5lejQ==
Subject: Re: [PATCH 1/2] erofs: introduce chunk-based file on-disk format
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Eryu Guan <eguan@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <8e7291cf-8baf-2a79-997e-4847faa109db@kernel.org>
Date:   Thu, 19 Aug 2021 11:32:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/18 15:07, Gao Xiang wrote:
> Currently, uncompressed data except for tail-packing inline is
> consecutive on disk.
> 
> In order to support chunk-based data deduplication, add a new
> corresponding inode data layout.
> 
> In the future, the data source of chunks can be either (un)compressed.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
