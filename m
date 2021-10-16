Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78342FFD6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 05:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbhJPDJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 23:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbhJPDJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:09:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87268C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 20:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L/u1jz2ZjO59G/mhMy7DaW6H5SexRSSBkWhXcv0LO1E=; b=MDonnBz3inA9Tp9tuI6qU3zMVD
        IyE9a8bRtLwlf/m8+wEXilOVmM2S2QDkOsV31B3u8DijPUNFYV4Cnz0gr5iDMwwFwqJAIBDb58vEn
        hzHKhnghtesjmycSzNjXJ2dZdPni1KU6pIVcBn/iSdNfkiXBMvdqg/I5ltbZUwmdjKjb5hn5/GNka
        FQsBT+ZLN0NiJSkiYGBa8J31U90I8dRKKvbP4tklIFYbcPHdKXTaooEkAa3qg/mbSRoUBx+OxfshE
        Icqz8zPUhWvufg3uYB9TI4rP8A2O9qBkxFD1cmpbf+JD7e+aVb4iKvsLpiDl0SO2bcujDG66WD1hg
        esGq55+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mba0t-009RTm-Tc; Sat, 16 Oct 2021 03:05:53 +0000
Date:   Sat, 16 Oct 2021 04:05:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip current when memcg reclaim
Message-ID: <YWpBf2VUr/w507ak@casper.infradead.org>
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
 <20211015130035.aacc18a4d1ee141b306c2272@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015130035.aacc18a4d1ee141b306c2272@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 01:00:35PM -0700, Andrew Morton wrote:
> On Fri, 15 Oct 2021 14:15:29 +0800 Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> 
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > 
> > Sibling thread of the same process could refault the reclaimed pages
> > in the same time, which would be typical in None global reclaim and
> > introduce thrashing.
> 
> "None" -> "node", I assume?

I think that's "non-global", ie memcg based.
