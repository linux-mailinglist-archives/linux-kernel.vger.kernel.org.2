Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2DB41FD59
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhJBRSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBRSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 13:18:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804DFC0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bqShy79e/Z6K5vfk14zyDLtX0I5IPDlQiZpIZhz37d8=; b=GcMWFnNkUKLx/mRl8xq1PX+bU5
        EDLMvoLX89jugtardbhC1/9q6x/xHccn1pK6+RpNG48SSwRchXjKo22uklJMATbzE4j17dDHSGUD9
        ozMLLgnboaT9CjjiCa21/qIJcktW/4pO9Q/gL+s2jE5Vf4yhvsSMgCYBBDglLnclLhpVHmYUg+SvR
        f3FwSu8h22ioKbLZ/S4UQJYkpWgn2HxOEUOiTTJ8YyWrAvXb+aAFNEd1Q1KlcPzNgDWMDiNwfEoLd
        rR+MnH5pRFDcijbBI4RqeGoAipy1eRLYKgdQXWP++ojX3S62bpAx7KXgmogdNOJdUtW2bBbp6iWZk
        JCLBgM/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWicA-00FEXG-Av; Sat, 02 Oct 2021 17:16:10 +0000
Date:   Sat, 2 Oct 2021 18:15:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        syzbot <syzkaller@googlegroups.com>,
        "Huang, Ying" <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2] mm/mempolicy: do not allow illegal
 MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind()
Message-ID: <YViTzvQII8al8HYW@casper.infradead.org>
References: <20211001215630.810592-1-eric.dumazet@gmail.com>
 <20211001154949.98956c092734590e781ce672@linux-foundation.org>
 <CANn89i+diZ9cmMo+y3KhBK3xiWbzAsC_RF86=hN4KJ1Kxg1SwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+diZ9cmMo+y3KhBK3xiWbzAsC_RF86=hN4KJ1Kxg1SwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 04:37:40PM -0700, Eric Dumazet wrote:
> > > Issue came with commit bda420b98505 ("numa balancing: migrate on
> > > fault among multiple bound nodes")
> >
> > No cc:stable?  What's the worst-case user-visible impact here?
> 
> I added the more precise tag  :  Fixes: bda420b98505 ("numa balancing:
> migrate on fault among multiple bound nodes")
> I only put Fixes: tag, so that stable teams can use their automation just fine.
> 
> worst-case impact, I am not sure if any application ever used this
> undocumented combinations of flags ?
> Also, it is generally advised that accessing garbage values has
> undocumented behavior.
> A host could for example crash (it certainly does with KMSAN)

mm has special stable rules; fixes only get backported if explicitly
requested instead of automatically like most of the rest of the kernel.
