Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528CD39CF63
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 15:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhFFNzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 09:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhFFNzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 09:55:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DDAA6120F;
        Sun,  6 Jun 2021 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622987612;
        bh=T9Mid5vJotYKc1BgooDYJRNtn/k2VlQX+UetnopSvjc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=K0EMoEIPoiytEnK7B4ovvewslqmX+eB63WcCV0ocRdygeYCTmCvmKdK5K6UAWBZki
         m+vFDzkqKBqVgl6lN9Pyb+6f6vyhGO8TpXVraOur5v25UrBkjijp4ePXhcA1M//c3e
         wihHXKIbmjNMD0r/FowSCotYo8W+m69t/q/WdmE0VKtFPIbDqgYI7XoFOyWgYDm8Uw
         z4EolGrMokx9eEdIy3lQ2TrQpVfxp31h8yed1xgr2JMyJp+W7R3R8pUa9k+JYC1DZT
         QugWbQN3lRYYtVKrAEP03HIVbCDiltfVWh2OLAYXtquDB0u972uhKgn4VMzNpYkwGa
         n2mL+wkxvZ40w==
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: introduce FI_COMPRESS_RELEASED
 instead of using IMMUTABLE bit
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210525204955.2512409-1-jaegeuk@kernel.org>
 <20210525204955.2512409-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <95b5669f-a521-5865-2089-320e2a2493de@kernel.org>
Date:   Sun, 6 Jun 2021 21:53:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210525204955.2512409-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/26 4:49, Jaegeuk Kim wrote:
> Once we release compressed blocks, we used to set IMMUTABLE bit. But it turned
> out it disallows every fs operations which we don't need for compression.
> 
> Let's just prevent writing data only.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

BTW, we need to expose .i_inline field to userspace since there is no
way to check status of inode whether it has released blocks?

Thanks,

