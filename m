Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806D93F05DE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbhHROML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238113AbhHROMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:12:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7EFC610A7;
        Wed, 18 Aug 2021 14:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629295896;
        bh=Gz6CCkSmBpJBb//SixnJg3yiMy1j4X3NG4qAXGzi90I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TbR8t2PxXP85BxY8iJ+zv5suFPI9j1kMGjLSwWK9VduVeQFuRlKImvkjsPw08I2Nc
         Yfwo/E+C8mIZFpLimYl7JWnNbJIKPj3UYGQcN4zK5+j6TpobFdyG50rzAqJ3F8kvOh
         Vg0ZUSkB2qJchlBANicVCPgJo+cZQODlryiAxmDwK2821L9era9oxHjI+3jdSBye+z
         g8NeXkTMfgfy/bWuQqxBP1ulrBHvhKEZIegyCQBP7dHEb4gLVKRR+OrTjiVcajhJlC
         bM80Z0PUcRBMjZVx1yzH7BmffNGMgbA99rx4/we9EnGgqrOyWHoZZqxt54Dr72eCCS
         81c1dPppV5HyA==
Subject: Re: [PATCH v1.1 1/2] erofs: add support for the full decompressed
 length
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Lasse Collin <lasse.collin@tukaani.org>,
        nl6720 <nl6720@gmail.com>
References: <20210813052931.203280-2-hsiangkao@linux.alibaba.com>
 <20210814152727.78451-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <e3144a66-c5e6-6f2b-88a9-74730972abff@kernel.org>
Date:   Wed, 18 Aug 2021 22:11:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210814152727.78451-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/14 23:27, Gao Xiang wrote:
> Previously, there is no need to get the full decompressed length since
> EROFS supports partial decompression. However for some other cases
> such as fiemap, the full decompressed length is necessary for iomap to
> make it work properly.
> 
> This patch adds a way to get the full decompressed length. Note that
> it takes more metadata overhead and it'd be avoided if possible in the
> performance sensitive scenario.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
