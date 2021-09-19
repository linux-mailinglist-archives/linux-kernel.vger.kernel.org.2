Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5DE410DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhISXgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhISXgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:36:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70B4A60F93;
        Sun, 19 Sep 2021 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632094513;
        bh=9BtKLYV2SwBw6eP4jLE8SnXaFNs5TvaXNr7aenlK12s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DlSpik6RVVa7VHRdC0EnN/kzXP6U/KvMjcl3auo2ncWjFHhvq41pfqhcpy4JbrH3D
         LahJd1hyvD22J1weWMrTq1jL1WkibFYQjIm9AVLyxzNOcP5kTf6/SiDi0Y9CsLhDCC
         U1jP6ujJUJCHDTNLNLQyZ/3XyGMWxPpvMGcIlRtw=
Date:   Sun, 19 Sep 2021 16:35:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Weizhao Ouyang <o451686892@gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
Message-Id: <20210919163511.9f82c3634cf48d3769ccab42@linux-foundation.org>
In-Reply-To: <20210917061432.323777-1-o451686892@gmail.com>
References: <20210917061432.323777-1-o451686892@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021 14:14:32 +0800 Weizhao Ouyang <o451686892@gmail.com> wrote:

> After related migrate page updates, sync up latest migrate_reason to
> migrate_reason_names, page_owner use it to parse the page migrate
> reason.

A slight problem.

> Fixes: d1e153fea2a8 ("mm/gup: migrate pinned pages out of movable zone")
> Fixes: 26aa2d199d6f ("mm/migrate: demote pages during reclaim")

d1e153fea2a8 is from May 2021, so a -stable backport would be appropriate.

But 26aa2d199d6f is only in 5.15-rc1, so no cc:stable.

So can you please prepare this as a two-patch series with the first
patch (which fixes d1e153fea2a8) marked cc:stable?

Thanks.
