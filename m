Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5F414D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbhIVPj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhIVPj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:39:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2E426105A;
        Wed, 22 Sep 2021 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632325106;
        bh=sLAEuM02C4QCweaybMs7XQEl3DnrzQCjZvYWaMErhow=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qkHvBqFP+n+i1FNhisynQVVPQt8Y2e7eC6KpSNNx4OjKP6Zk2SrFnMK792fWP6Uy0
         WED7+1UG14G/28P16G3fnZfxj4TGSkCW+Qw/jmmB+B4WOt6jKXGNY6LKJ16kJqdp//
         vtyYyozQaB+8qo4DyqZFaRPZeJuFfpyhfx6uXzW2eabSTg4HyJUfmSjl8RhkL521rA
         nR0dTESEwnnl28yepRByATEEWKNOoQr26kbjIgFhZGgHa9GJ7lrkS9WN8a2JNIYF3j
         8pT7oUa1fjPxNwkoFBck7+QTW0Ny2FHeqGgCql20c+OVWPscFbetwk4LGfJDjIcHgu
         DY1fnTrFvFPRQ==
Subject: Re: [PATCH] f2fs: fix up f2fs_lookup tracepoints
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
References: <20210921143730.82649-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5a68db09-a5a4-6d53-65b8-3abaff6b174d@kernel.org>
Date:   Wed, 22 Sep 2021 23:38:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210921143730.82649-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/21 22:37, Gao Xiang wrote:
> Fix up a misuse that the filename pointer isn't always valid in
> the ring buffer, and we should copy the content instead.
> 
> Fixes: 0c5e36db17f5 ("f2fs: trace f2fs_lookup")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
