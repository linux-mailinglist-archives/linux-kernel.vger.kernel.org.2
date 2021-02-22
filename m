Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CCB3219F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhBVOPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhBVNl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:41:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D1C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EfVvR7GomTLRo5PTmpl8uRGdpK5w46dmW4PmUeyQHvI=; b=QrXAAXipiBIVfs4GsZfAOAHG4v
        RYf6falt44k7+foQwqqBA8JNWw6xx/x85LMOQ/JJe1IrKds1Cfy7L3sM87Oz2McFzJWZFvObleSFi
        Iip6RW1/wiwWJef4YasuMmCqufY54NBS365l8tEOCSXxXkoqpbY2Vf8hkVoCKDoDqokhb/kaRdP7r
        GJgUMoRbl/ZMFBFVNjeJoRiO6J5GPWz7p43CiZp02I5yAsAZlPlyYBoU9ofa5YnomnBf+jf6iFR4p
        ceEG6gJsMOS56NKAQrslV92TcS5zmPNKXSKXFpQVBiZKsYKkUxWWBWLl/imED57em/FL+30cFUfWy
        MCNczeyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lEBRM-006d7B-IE; Mon, 22 Feb 2021 13:39:58 +0000
Date:   Mon, 22 Feb 2021 13:39:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <20210222133956.GH2858050@casper.infradead.org>
References: <20210215155141.47432-1-laoar.shao@gmail.com>
 <20210215155141.47432-4-laoar.shao@gmail.com>
 <YDOluaRK2CHtQyQD@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDOluaRK2CHtQyQD@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 01:38:17PM +0100, Petr Mladek wrote:
> Another question where to push this change. It is pity the we
> finalized it in the middle of the merge window. It has to spend
> at least few days in linux-next.
> 
> I would like to hear from Andy before I push it into linux-next.
> There is still theoretical chance to get it into 5.12 when Linus
> prolongs the merge window by one week. it has been delayed by
> a long lasting power outage.

Usually new code has to be in linux-next by -rc5 or so.  This is
definitely too late for 5.12, but it's nice and early for 5.13!
