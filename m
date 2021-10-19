Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EE64331A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhJSI55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:57:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36584 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbhJSI54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:57:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0717221976;
        Tue, 19 Oct 2021 08:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634633743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9RwzVBFGDFRteBRtUaexR2o4mqwWh6zXF3EufALmmMY=;
        b=dQqIxNFcfFg+sPk1JmTQ1nYBdSadedzTUdQ7cmmDplqweHL6D/vRExRJ/hfmCwAcaIyTJl
        8DGp7M/Q8bDp9Hrqj0zBih55aVt+rLj+T7q5/A8SMEvmuQ8HE95ulnKB/o9Rvz3WCreST/
        UOTaTB4NgxP9opPckBVds+4SGXHh41Q=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 54989A3B81;
        Tue, 19 Oct 2021 08:55:42 +0000 (UTC)
Date:   Tue, 19 Oct 2021 10:55:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: skip current when memcg reclaim
Message-ID: <YW6IDchljdzbxvDU@dhcp22.suse.cz>
References: <1634628576-27448-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634628576-27448-1-git-send-email-huangzhaoyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-10-21 15:29:36, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Reclaiming pages from current LRU will introduce page thrashing during direct
> reclaiming. Have all memory contraint groups steal pages from the processes
> under root(Non-memory sensitive) or other groups with lower thresholds(high
> memory tolerance) or the one totally sleeping(not busy for the time being,
> borrow some pages).With regard to all groups trapping into direct reclaim,
> retry if first round failed and all groups still compete fairly.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> patch v2: grant current second chance if previous reclaiming failed

It would be really better to wait until a discussion around the previous
version is concluded before posting another one.
Btw. this changelog has some serious gaps in both the problem and
solution description. Please spend some time looking at other changelogs
for MM patches to get some idea about the level of details that we
usually require.

Thanks!
-- 
Michal Hocko
SUSE Labs
