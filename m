Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ECA3DE876
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhHCIbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234423AbhHCIbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:31:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A916D60249;
        Tue,  3 Aug 2021 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627979484;
        bh=kaFiBCMyltN5FpAyAo2YUnCHUvxKizCTit1xdiH0r2s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AZoz65hjBICpIy2wfNjGs7LizvOEARyYte6SP16y2QrehZtzH3KKtiw2MxojoO4fr
         ew9xBp/e8sTeSiVtvsRCtaNH8NzW2raH8lslTUU/nWBT/ardQQQoCHJQ8rAgt1yuou
         rxpNxJh4k6NrJT9kk5PVY60Fm36Gnc4QFk1bM+tZwGLSSvFfvJek1/FGbEjcAY9phZ
         2cwnYd9rWbbV2TTGVJP2QrV51C1koS1FV3MhsRMS/U3vCvENty0aoNtwIXuZA9fkVZ
         0fhbkLfspeE9zAxTyfEhQQIWtKh6Rg6r66oXzxZSt9GrCcg9CGnSXdQ3E5BJtPoTIM
         UkcR5if4FGv2g==
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add sysfs node to control ra_pages
 for fadvise seq file
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
References: <20210803042245.2297259-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <e7683629-d862-aab2-18a1-4bee84acee48@kernel.org>
Date:   Tue, 3 Aug 2021 16:31:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803042245.2297259-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/3 12:22, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> fadvise() allows the user to expand the readahead window to double with
> POSIX_FADV_SEQUENTIAL, now. But, in some use cases, it is not that
> sufficient and we need to meet the need in a restricted way. We can
> control the multiplier value of bdi device readahead between 2 (default)
> and 256 for POSIX_FADV_SEQUENTIAL advise option.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

I guess you can add below tag directly in v3. :)

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
