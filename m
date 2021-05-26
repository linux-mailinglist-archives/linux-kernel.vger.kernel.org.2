Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7198391972
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhEZODn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232641AbhEZODl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:03:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DE4861260;
        Wed, 26 May 2021 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622037729;
        bh=ZOZJp2WdVCkYj0Es/mOcXSzkMoXCayinr6ObnjkqIPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rh3DN6RLhMBijEbGzaG1PJ4MXvqxfNzwI1Z/BPu7CjTBiU6+2qj7jTxDtAMHT3CAn
         UteRZbiXBpb0ME66DgLND1TlvprBJd/hYJhePGAZ18Y51bpSEHROrv/lKB0nD9uVg4
         FmI98z2dUxRolzq82jOf7/jq/qgTdqbxOv+eoqRTaXOc3ksB/5njDsivcwAZJ6KkWC
         DjqvHo9iDohV1ECZCZz1QKGs4hHFH33clX8Da3IV1BMBkEJK4Yh8Ih0ppCfLYpfa7z
         CbsklWG7Ryl4NK26rxpPtSvUZtY8Bz7dmHgmaxWDWiqpUZVUjs50Wk+YzLBeR1ooZF
         ArGKleioJnk7Q==
Date:   Wed, 26 May 2021 07:02:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: immutable file can have null
 address in compressed chunk
Message-ID: <YK5U4GmF8BgMR3Kd@google.com>
References: <20210521190217.2484099-1-jaegeuk@kernel.org>
 <33c5c36e-b5e1-cecc-fdc4-28a173a5b0a1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33c5c36e-b5e1-cecc-fdc4-28a173a5b0a1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/26, Chao Yu wrote:
> On 2021/5/22 3:02, Jaegeuk Kim wrote:
> > If we released compressed blocks having an immutable bit, we can see less
> > number of compressed block addresses. Let's fix wrong BUG_ON.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> It looks it will be better to merge this into
> ("f2fs: compress: remove unneeded preallocation")?

Right, fixed there. :)

> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
