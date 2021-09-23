Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302E94161EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbhIWPVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241947AbhIWPVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:21:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3162B60F12;
        Thu, 23 Sep 2021 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632410378;
        bh=bxMbjbmYYlx+gwAQqIXMFemqzoYdMwKRAZ+eUGI26/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vb34QMohIOyVon1B7SCV4j1uJ+VDUB7CR0IPaLvORzuFVP5Z64hqaug+KkQsYH79V
         kNEqRAQaSKTOxZZ7hHjEvrFlD+ciVlgzN4NUeWKSv38bjWgoZTRXZTxP84PMEMSIVU
         /wu0Q+Jd0qzwuHbzzemg5N8JocPZtOnhPPpn9hn/mt+y52w7tWX6YKu6kHtgB6HrBH
         sN9EdwLGy/DlO/M3LiipYqdCWRVUnW5WukRRySaKRk5Oi3pmWQHXOwUrofOwh9dtp0
         uHDSsYqUnArWhDprfSBS+JxNZfBNjH8z4MYrAURvdUGK9HRGtsBdYCWIJSKSnKSkXL
         G+HNOwLRMTg5Q==
Date:   Thu, 23 Sep 2021 23:19:20 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix misbehavior of unsupported chunk format check
Message-ID: <20210923151919.GC1852@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210922095141.233938-1-hsiangkao@linux.alibaba.com>
 <926fb1a9-174e-26de-c9ed-70aa0a01d394@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <926fb1a9-174e-26de-c9ed-70aa0a01d394@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 11:09:25PM +0800, Chao Yu wrote:
> On 2021/9/22 17:51, Gao Xiang wrote:
> > Unsupported chunk format should be checked with
> > "if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL)"
> > 
> > Found when checking with 4k-byte blockmap (although currently mkfs
> 
> That means for 4k-byte blockmap, chunkformat should be zero, right?

Yeah, correct. It's a regression of 4kb chunk blockmap..

> 
> > uses inode chunk indexes format by default.)
> > 
> > Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
> > Cc: Liu Bo <bo.liu@linux.alibaba.com>
> > Cc: Chao Yu <chao@kernel.org>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thanks!

Thanks,
Gao Xiang

> 
> Thanks,
