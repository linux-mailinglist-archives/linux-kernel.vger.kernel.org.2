Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CCE3A1CF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFISpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhFISp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:45:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BBE2613AC;
        Wed,  9 Jun 2021 18:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623264213;
        bh=vQ1SsFfCywlqRQRnaHRZ0AG6i982cLly1NBLPalQ438=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNq0WJ0yN5xclxnJkMdACG3Nq7ICu17YRELK6TYkDFTbdsmlCv+C6JxITHWzlqi22
         ZKw1TUCA62EdnA12aBTi+YKko9SRWAy3wKyrLQ6tCw5EJicYpB5pks9D1qK1vOMn17
         FPKQ9mNwgC0IZA3FzV8Qw6Q368AlvIkeg65SFSHJim10xmlGe2URIopbZymCTEl3bm
         JGdcCCNIsR/LZcLmK+Lv8Cnr7aJZ8E9UDUJbCc0pr3NRvVZ40OZnN0rPS9TfziWNWg
         L/x90essw1KJFOjv4iCrSzKAJD1wP70/mdKFQmD10HuwiANoFbNbisicFaGDSf/Ocu
         LOSKgO+P8ufNw==
Date:   Wed, 9 Jun 2021 11:43:31 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: introduce FI_COMPRESS_RELEASED
 instead of using IMMUTABLE bit
Message-ID: <YMEL06gZC5n3J2bX@google.com>
References: <20210525204955.2512409-1-jaegeuk@kernel.org>
 <20210525204955.2512409-2-jaegeuk@kernel.org>
 <95b5669f-a521-5865-2089-320e2a2493de@kernel.org>
 <YL5P15nLsc/3GQOY@google.com>
 <3f2c2543-c8a4-3477-76af-5c7614b643e8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2c2543-c8a4-3477-76af-5c7614b643e8@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08, Chao Yu wrote:
> On 2021/6/8 0:56, Jaegeuk Kim wrote:
> > On 06/06, Chao Yu wrote:
> > > On 2021/5/26 4:49, Jaegeuk Kim wrote:
> > > > Once we release compressed blocks, we used to set IMMUTABLE bit. But it turned
> > > > out it disallows every fs operations which we don't need for compression.
> > > > 
> > > > Let's just prevent writing data only.
> > > > 
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > 
> > > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > > 
> > > BTW, we need to expose .i_inline field to userspace since there is no
> > > way to check status of inode whether it has released blocks?
> > 
> > Need to add some in F2FS_IOC_GET_COMPRESS_OPTION?
> 
> We should not change this interface, in order to keep its compatibility for
> userspace usage. How about adding it in F2FS_IOC_GET_COMPRESS_OPTION_EX?

Hmm, or need to add it in getflags?

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
