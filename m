Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504404161C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241852AbhIWPLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241792AbhIWPLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:11:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34A0561211;
        Thu, 23 Sep 2021 15:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632409769;
        bh=oA+WWs5P3iaZypn5jU4SpKYZzff2WutgvUss6C8I1ls=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OpjLqQ3wJS0mnuI98GptpCEetjJ7ryrKPRZawRxcJyOjz39Wm0twQ88tzZObVtMa9
         QirClY/g+GQBLZejLEdyBfzOjNXKsC8u85V5dflPNMap/uUNEpb4PbYBWqazCivDFw
         H1CeAhEm7ctFniGz5gqTchtFCM7PmG7d14tcezwZGUo7yhVbFREvm4RmiW4Vx6F0wc
         4WM7ylAKNg00kdQNmWhhvx9MxVp5DT7oMWgkYHMm2QA9FOmnbvua9/xgug/pzRWpYI
         mEno+UW5OxERAGrRNu1ijGqrngs6+dF99CMPNCbq3VGnxP2JfOZVFXYMhHrksK8y0S
         S0mBdZrDOo02w==
Subject: Re: [PATCH] erofs: fix misbehavior of unsupported chunk format check
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20210922095141.233938-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <926fb1a9-174e-26de-c9ed-70aa0a01d394@kernel.org>
Date:   Thu, 23 Sep 2021 23:09:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210922095141.233938-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/22 17:51, Gao Xiang wrote:
> Unsupported chunk format should be checked with
> "if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL)"
> 
> Found when checking with 4k-byte blockmap (although currently mkfs

That means for 4k-byte blockmap, chunkformat should be zero, right?

> uses inode chunk indexes format by default.)
> 
> Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
> Cc: Liu Bo <bo.liu@linux.alibaba.com>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
