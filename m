Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31E3CB04E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhGPBPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 21:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhGPBPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:15:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D859BC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 18:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=STY4s5pzqccUtW+qUB1iOKanwmw+wdA3y3vXLfLdfbo=; b=fvA4DkjoQc5jRbwwnORSkc+2RS
        dMu+N4IcPWmrBB4oqNjXs8Uw0+hbjStd8LcCifGczeAWaxme+hvi2/B6DGhGXy+J1TL2iKNsAoYBp
        2nHAtsE21mBSqygEAxDCaBpGSoNW5as3HRKs6jSoQ4ijgM42JVm8rknq6YLFvpfcwKqPFOqHP5w+T
        wqmSBseyLqFVVW+06V3a6WoIJEkFoQg7mrRn5Gs/lW830upV2QcxX8sQcLYYIXpX1QDoD2+W4aSTj
        MohRgBrC5dqnuGd9j8T10c/D1V9xVcvZH4oieM3YmvCh2UhBnAfK6rOmWQF4cbAy7lR5ME0tgmnuz
        lw9nDyxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4CNP-0041Of-73; Fri, 16 Jul 2021 01:11:16 +0000
Date:   Fri, 16 Jul 2021 02:10:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de,
        weixugc@google.com, Michal Hocko <mhocko@suse.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH -V10 0/9] Migrate Pages in lieu of discard
Message-ID: <YPDcmzSq2YKS9jZ9@casper.infradead.org>
References: <20210715055145.195411-1-ying.huang@intel.com>
 <20210715123836.ad76b0a2e29c0bbd3cd67767@linux-foundation.org>
 <e571c5d8-4be3-c983-dcc2-aff5217aa055@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e571c5d8-4be3-c983-dcc2-aff5217aa055@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 02:42:07PM -0700, Dave Hansen wrote:
> The end game for auto-migration is to on by default, wherever these
> hardware configurations show up.  Just like THP, I expect this to be
> broadly useful.  But, given the breadth of our user base, I also expect
> it to be nasty for a minority of users.  They'll need a way to turn it
> off, and hopefully they'll also provide feedback so that, if possible,
> we can improve the default behavior and bring them back into the fold.

... or if the THP experience is anything to go by, they continue to
shout loudly about how borken it is for a decade ;-(
