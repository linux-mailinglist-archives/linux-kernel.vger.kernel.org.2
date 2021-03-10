Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4273A33492B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhCJUxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:53:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhCJUwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:52:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7558E64FCA;
        Wed, 10 Mar 2021 20:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615409574;
        bh=9TLZ3UuLAek2YDKYxVEVIbMal/1XxdYrNY1x5nvkKsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsBjUCehd8Lp0wCHjHa8PVi+JxUY0YTRjVLdeHdCXYM2KGpuLz0YvFVKDHOS/Aj9m
         FAZzhvF1sNE2hsY7P6S1zEDVb8x8qfAgprKC90t/RzJZf6Pf6xOHr4E9xM871zYYOj
         Kb+4HbX6ck43X1CM10LbhT7gmkQgzagHt/OOyqgiVD0K/XwBC1CYC7/+1SjEqlzRa+
         bJ7dvyyxYjQvxMKDAOktKukE8WN9d7BKU6hUgc/oIlDFs2b2uJyADP1If61deD6mnM
         ipBVoVDiMoScOs8Gd2ZColy3UTX3mTE1Oq/d7HGUoJ/Gvm01XE9fAlZoVK/PSj6ec4
         wIjEyRfF3QE1g==
Date:   Wed, 10 Mar 2021 12:52:52 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: compress: add compress_inode to
 cache compressed blockst
Message-ID: <YEkxpAp8FQjRUfm6@google.com>
References: <20210202080056.51658-1-yuchao0@huawei.com>
 <46e9924c-0086-cd2a-2e93-7149b92ba27e@huawei.com>
 <YDsleDjeIcpuBXKA@google.com>
 <YEFBAuP26t0RzVHZ@google.com>
 <01a0ff76-6fa7-3196-8760-e7f6f163ef64@huawei.com>
 <YEa66ekikyuPWSyd@google.com>
 <a40929d4-a8de-98ea-8dd8-6c807d8a6adc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a40929d4-a8de-98ea-8dd8-6c807d8a6adc@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09, Chao Yu wrote:
> On 2021/3/9 8:01, Jaegeuk Kim wrote:
> > On 03/05, Chao Yu wrote:
> > > On 2021/3/5 4:20, Jaegeuk Kim wrote:
> > > > On 02/27, Jaegeuk Kim wrote:
> > > > > On 02/04, Chao Yu wrote:
> > > > > > Jaegeuk,
> > > > > > 
> > > > > > On 2021/2/2 16:00, Chao Yu wrote:
> > > > > > > -	for (i = 0; i < dic->nr_cpages; i++) {
> > > > > > > +	for (i = 0; i < cc->nr_cpages; i++) {
> > > > > > >     		struct page *page = dic->cpages[i];
> > > > > > 
> > > > > > por_fsstress still hang in this line?
> > > > > 
> > > > > I'm stuck on testing the patches, since the latest kernel is panicking somehow.
> > > > > Let me update later, once I can test a bit. :(
> > > > 
> > > > It seems this works without error.
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=4e6e1364dccba80ed44925870b97fbcf989b96c9
> > > 
> > > Ah, good news.
> > > 
> > > Thanks for helping to test the patch. :)
> > 
> > Hmm, I hit this again. Let me check w/o compress_cache back. :(
> 
> Oops :(

Ok, apprantely that panic is caused by compress_cache. The test is running over
24hours w/o it.
