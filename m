Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146D73E0C87
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 04:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbhHECxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 22:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhHECxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 22:53:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B13C61037;
        Thu,  5 Aug 2021 02:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628132014;
        bh=572pJp3ee6li9WZRwxOQIDTFDcCjD3QXQ/WZjb6zgeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmTDblh1tN1+QpEn+UvacJuYWlWX2dRSB1HpSLCWKRADbTV2s8nU+MlZKus2a9l4O
         MZMTI2ZpJYFLionCOsOPEtRzI0zg5VXm5HhD1gtUuIpoLOn+8qyQNQftQNSHB5drpf
         gKX+0LkMljb+neOdNispQ6zOL2XfMHnDk94R/+83Zr1s+hWJ9ilNApaeNNuOx6iYqY
         aiTBgnr9dQ4PJWn6KFf67gNMcQErsXI+2+5mwtfcgYrBnTH13GZXGctPhmHABxSZEp
         iMabJW1UZyRE2wVX64u+eqynXW/WuchP4U0CnMXVMMHe4a5o7M11C68z5gScVyMDrJ
         Zz9qqHylVsgJw==
Date:   Wed, 4 Aug 2021 19:53:32 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [RFC v3] f2fs: extent cache: support unaligned extent
Message-ID: <YQtSrIx0/sAipDs4@google.com>
References: <20210804022348.1414543-1-chao@kernel.org>
 <YQsIj0wKk6YbN/FJ@google.com>
 <YQsmfm3ibU6bhvZr@google.com>
 <0dad9863-4aa2-3ea3-fd97-457aa635ed66@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dad9863-4aa2-3ea3-fd97-457aa635ed66@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05, Chao Yu wrote:
> Jaegeuk,
> 
> On 2021/8/5 7:45, Jaegeuk Kim wrote:
> > Chao,
> > 
> > How about this?
> > https://github.com/jaegeuk/f2fs/commit/d6bbe121bc24dfabfedc07ba7cb6e921fb70ece0
> 
> Looks more clean, thanks,
> 
> > 
> > I'm digging one bug in __insert_extent_tree w/ the patch tho.
> 
> Shouldn't we initialize @ei in f2fs_update_extent_tree_range(), otherwise,
> __try_merge_extent_node(&ei) -> __is_extent_mergeable() will do the check
> w/ uninitialized c_len of @ei.

Fixed some bugs, but still getting another data corruption.

https://github.com/jaegeuk/f2fs/commit/c5d97919c55b467392407b60c1a7b1e3e81721ff

> 
> > > On 08/04, Chao Yu wrote:
> > > > +	if (from_dnode)
> > > > +		goto skip_reading_dnode;
> 
> Wrong condition here, thanks for fixing.
> 
> Thanks,
