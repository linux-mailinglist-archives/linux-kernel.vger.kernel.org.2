Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867BB3B65F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbhF1Pqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237272AbhF1Ppy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:45:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F19FA60233;
        Mon, 28 Jun 2021 15:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624895008;
        bh=Q+y2V0I7+R8Os23phWa4M7sQFvLHdurvGVi37dulsbs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=FiJK3qYDTJjb8CLuttLCpPWLPBxf/GwueYcY24YSPhQnFw0qCnO+DS5XRGhji+pMA
         UOXRgTH17a/7L+S6Bt/YWMzjPvIIibpTYJAADMW/keHp8P3fUwWkqwd3ughlPSc4o7
         vR+U05nTytSb17INLY4lq39wzNKwHqSozwl/rMHxzwN2HOknrcPi3Z7tROtj8sVxwM
         +gmrUka8yHz/wyavGSmkbcwUVB5+5AJHYnZU9i7MtMEa0AgFwQjlXXCmsLU/KaLLjp
         lQXM4sP2Z1KsO5ypFDO+c7fh1begOw86d95ab0/U1RAIp0p+2LRGQ4AwAvOSsO0kZF
         SmtdIKhLgy19w==
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove false alarm on iget failure
 during GC
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210622202217.3864743-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <e4a93d52-ec10-9b8f-390a-d238a4a3d9e3@kernel.org>
Date:   Mon, 28 Jun 2021 23:43:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622202217.3864743-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/23 4:22, Jaegeuk Kim wrote:
> This patch removes setting SBI_NEED_FSCK when GC gets an error on f2fs_iget,
> since f2fs_iget can give ENOMEM and others by race condition.
> If we set this critical fsck flag, we'll get EIO during fsync via the below
> code path.
> 
> In f2fs_inplace_write_data(),
> 
> 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) || f2fs_cp_error(sbi)) {
> 		err = -EIO;
> 		goto drop_bio;
> 	}
> 
> Fixes: 9557727876674 ("f2fs: drop inplace IO if fs status is abnormal")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
