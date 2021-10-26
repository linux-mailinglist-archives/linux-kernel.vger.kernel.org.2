Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EFE43AC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhJZHJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 03:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhJZHJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:09:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED5D160E8B;
        Tue, 26 Oct 2021 07:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635232005;
        bh=RQiaWvZxi6P05j9XkrMk/0RKqbNxLYI79zOYLUTn8dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=T61Hnp6RsutyC52LEy2tcuJcWKRFZ7uzOS/gQLF6Ss0C15fxCyZXz9zZUied95caD
         BTlhah+hmp5lbIZiqty8gh/KWf2tNdl73D0UdXk2sCsaktK4YNbc6AL8hvcP5oCcJx
         3/MH1lAXmdaCAL2GpeNFQrXWeKnDnlOx6vy6ni2MgynFwMIMWdVCUHYzWk1tXP3qwK
         8uPidAZ1xdjSrJoHLM3g3+34EOZTp4oEqpP+iXuSIKEyD65MowLnv9y43ei32v64ar
         z/f/6GA3LZTCtZ4lY5V1CaQ7590/8WOVn0wi70nmVAB7sYpat1dGjLWEDz0XzpbfO/
         i0+M5zvOa5NvA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH -next] mm/damon: fix error return code in damon_reclaim_turn()
Date:   Tue, 26 Oct 2021 07:06:37 +0000
Message-Id: <20211026070637.30044-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025133002.27700-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 13:30:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 25 Oct 2021 20:45:00 +0800 Yang Yingliang <yangyingliang@huawei.com> wrote:
> 
> > If damon_reclaim_new_scheme() fails, it should return
> > error code in damon_reclaim_turn()
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> 
> Thank you for this fix!
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

FWIW, this patch fixes commit 53ab0082dc41 ("mm/damon: introduce DAMON-based
Reclamation (DAMON_RECLAIM)") in -mm[1].

[1] https://github.com/hnaz/linux-mm/commit/53ab0082dc41


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
> > ---
> >  mm/damon/reclaim.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index f5ae4c422555..dc1485044eaf 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -292,8 +292,10 @@ static int damon_reclaim_turn(bool on)
> >  
> >  	/* Will be freed by 'damon_set_schemes()' below */
> >  	scheme = damon_reclaim_new_scheme();
> > -	if (!scheme)
> > +	if (!scheme) {
> > +		err = -ENOMEM;
> >  		goto free_region_out;
> > +	}
> >  	err = damon_set_schemes(ctx, &scheme, 1);
> >  	if (err)
> >  		goto free_scheme_out;
> > -- 
> > 2.25.1
> > 
