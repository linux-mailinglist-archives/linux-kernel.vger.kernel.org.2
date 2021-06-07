Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D8D39E495
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhFGQ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 12:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhFGQ6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 12:58:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D28260FEF;
        Mon,  7 Jun 2021 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623085016;
        bh=CGWwZ0B5Yt1bOk3aGjgmlwf36RYxJNKPqpmqpOCx2xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7qpuDOqXRQve/5XFZ3bapJKWyjEaAzb6CMJ8pbZGuLRO5/ziVBb1+mPln5cRRDfI
         jp7BTihHnEOa8KvFsbNQ1qUnvo4ldXoQE3czUsQ+1m7qhpmX2Ui6gfY5Y/poW4aNa4
         jDpRgfokaYMOemsFzkgSkzLhAgl7KsIasxfuN2mLYSSEQLPI0fnauTH6IQWPHI6sKk
         5UHx7m/X0oAmsUCEi2s4CPoo4ew7wHnpHwRBX7DiMYcEA9T/ZTBEKc0NqpiYmC+Ptd
         84ObhTkO5/3wPiknxN1fioWhetPDUpUlA0CzhExmfc9/XKQocGr0eRRzlZzrWg5K9C
         ZF4/JSrECc47g==
Date:   Mon, 7 Jun 2021 09:56:55 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: introduce FI_COMPRESS_RELEASED
 instead of using IMMUTABLE bit
Message-ID: <YL5P15nLsc/3GQOY@google.com>
References: <20210525204955.2512409-1-jaegeuk@kernel.org>
 <20210525204955.2512409-2-jaegeuk@kernel.org>
 <95b5669f-a521-5865-2089-320e2a2493de@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b5669f-a521-5865-2089-320e2a2493de@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06, Chao Yu wrote:
> On 2021/5/26 4:49, Jaegeuk Kim wrote:
> > Once we release compressed blocks, we used to set IMMUTABLE bit. But it turned
> > out it disallows every fs operations which we don't need for compression.
> > 
> > Let's just prevent writing data only.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> BTW, we need to expose .i_inline field to userspace since there is no
> way to check status of inode whether it has released blocks?

Need to add some in F2FS_IOC_GET_COMPRESS_OPTION?

> 
> Thanks,
