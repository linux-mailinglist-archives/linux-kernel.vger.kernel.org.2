Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2C23FD878
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbhIALMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:12:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52086 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhIALL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:11:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2E5821FEE2;
        Wed,  1 Sep 2021 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630494662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yHDDGd9NsYI954+uDyB4sPxqRmxrEfuI05uaWYAqUWA=;
        b=uDnFR0VrJifGYhTWTuX7sNA6JM+dYSCJphfou1zA/px0j0uz0AlUUyzEMDEHJttcZQ0nVs
        Q5g/VOVpcJWc/ojO1NLRn3TloBHyO5MuuDxnuEFBSMsrx3ESYiQ+zwz2f/W2mqFgCte4tg
        VW61Kt/vQfdwiA+CXFu83yzBq8Ob3Ws=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6617FA3B95;
        Wed,  1 Sep 2021 11:11:01 +0000 (UTC)
Date:   Wed, 1 Sep 2021 13:11:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC PATCH 1/1] mm: provide one common K(x) macro
Message-ID: <YS9fxXSl5vhs5a+X@dhcp22.suse.cz>
References: <20210901092149.994791-1-oleksandr@natalenko.name>
 <20210901092149.994791-2-oleksandr@natalenko.name>
 <YS9WiF6enhSo8sYc@dhcp22.suse.cz>
 <5529272.KFOknHQvy8@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5529272.KFOknHQvy8@natalenko.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-09-21 12:50:40, Oleksandr Natalenko wrote:
[...]
> ```
> 31 files changed, 104 insertions(+), 90 deletions(-)
> ```
> 
> which is not that horrible.

Still a lot of churn to my taste for something that is likely a matter
of personal preferences and taste. Consider additional costs as well.
E.g. go over additional git blame steps to learn why the code has been
introduced, review bandwith etc...

And just be clear, I am not really opposing this patch I just do not see
a justification and in general I am not super thrilled about cleanups
which are not really necessary for a bigger goal - exactly because of
the additional costs mentioned above.
-- 
Michal Hocko
SUSE Labs
