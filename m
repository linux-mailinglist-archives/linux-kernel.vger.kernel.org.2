Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9063C3C7BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhGNCZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbhGNCZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:25:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A99FC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 19:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B3fKLu6x90gYniUL5gogEh9zBG7fF7DVZEYNuV5m4q0=; b=NtmylrsCgZ2SnKyzsjA02m/cpv
        Lojz2OtZCoq0uRMf8PJ1ERJm7b4U6OFL3HBn4sYNo0F8qsLxnkDI1Xu9uJde8fY7DlXIGEZHqERMM
        LQEeUpvKEDDAq9sqPEZp+TaLJPVza+4VOfoF5nBJ4JYSb2FiDCiZkYfCWBhwxTlKEKsX0URFO5RZn
        cUWANCeH+X8PJT6JLwEddaQSaw/cFaU55CRCo2PvgfaEqEsNyvsOs+gukMhIDmETdWzjM0ttjqt4W
        JdNk2UNAnqVFCL8qzUMuZLFhv/OrWv8r5gTOvCKrDoXT90VBbahCDaMGw7m4vQbaUKA877XeYFGDF
        1377F20w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3UVw-001kkZ-4U; Wed, 14 Jul 2021 02:20:51 +0000
Date:   Wed, 14 Jul 2021 03:20:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Make copy_huge_page() always available
Message-ID: <YO5J/OSGQvHp1npk@casper.infradead.org>
References: <20210712153207.39302-1-willy@infradead.org>
 <20210713191244.553680171f9fab3bf6e0889b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713191244.553680171f9fab3bf6e0889b@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 07:12:44PM -0700, Andrew Morton wrote:
> On Mon, 12 Jul 2021 16:32:07 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Rewrite copy_huge_page() and move it into mm/util.c so it's always
> > available.  Fixes an exposure of uninitialised memory on configurations
> > with HUGETLB and UFFD enabled and MIGRATION disabled.
> 
> Wait.  Exposing uninitialized memory is serious.  Can we please include
> full info on this flaw and decide whether a -stable backport is justified? 
> If not, why not, etc?

Well, the code was only merged this merge window, so as long as it goes
in in the next few weeks, there's no need to trouble -stable with it.
