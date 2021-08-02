Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8232B3DDED8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhHBSEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhHBSEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:04:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5418360F51;
        Mon,  2 Aug 2021 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627927436;
        bh=lTMHKpuQuKT3SAkLzzKq9A7yZ9z33kMa3cREBEPph/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKsQ/MxE3IMEJr7tj0WH6znzJGoVVtYVPVKrJtKNyvPZQOYS8QTpgQS0tIFDTs79N
         HTeUSB89LKM6zdu0IkYHDEZjVrNw00677BAHZm1yxuKgjL81AEinp2l+EqDA4LAqTP
         Y2Hv/EzQBXddSgZRpKb/yBJHHzfh1vlDFNsEto+bY/8zxVkS/vymDbFNAB0oELOSUV
         qhSAVMAWimLJe46bwhNHRwN62fN3YJy9z35nTnkT2I3Fb6tT1NNkh7Dy1oWOyvKFDy
         Ht4PZgGbwoQHCpMr0CEGSIjENHgfrb7qrinq5WtDSQeVgE/bB3fAMGSBhgKXl4JDvm
         N0OrdaB3j1eaw==
Date:   Mon, 2 Aug 2021 11:03:54 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
Subject: Re: [RFC NO MERGE] f2fs: extent cache: support unaligned extent
Message-ID: <YQgziuikMr0fvlT7@google.com>
References: <20210707015815.1978-1-chao@kernel.org>
 <YQRQ4kHvdRTBnb10@google.com>
 <51565c85-a475-bcb8-bbb2-e3125c5223a3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51565c85-a475-bcb8-bbb2-e3125c5223a3@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01, Chao Yu wrote:
> On 2021/7/31 3:20, Jaegeuk Kim wrote:
> > On 07/07, Chao Yu wrote:
> > > Currently, it only works in readonly format f2fs image.
> 
> There wouldn't be any race condition because unaligned extent only works
> for ro feature now?

Isn't your patch proposing on writable partition?

> 
> > Is there any race condition between the address in extent_cache and the one in
> > dnode? I feel that we could synchronize it by locking its dnode block.
> 
> Thanks,
