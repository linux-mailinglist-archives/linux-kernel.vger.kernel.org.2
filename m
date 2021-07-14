Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713003C7B87
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhGNCPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237349AbhGNCPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:15:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C004461361;
        Wed, 14 Jul 2021 02:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626228765;
        bh=Jwi7AbYEtGfiDNjGtofY5nG3THrr3SBHhR5X4dqayGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bzekOjb1S9qPuBSVgMzCSyGMgVRPTvim7xeFJKIHFbIHtbb7AcRpQCysIyXJCRCDO
         HbsII8uAekH0D+lwmcoO9u4jqjAeCgOal7NHC4oJzyGAerNrAJ/QPlgf1gYhuDI0qt
         End5dbDL2cga4RhOmFvwJ+vNW46tltiiF0qnZaLY=
Date:   Tue, 13 Jul 2021 19:12:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Make copy_huge_page() always available
Message-Id: <20210713191244.553680171f9fab3bf6e0889b@linux-foundation.org>
In-Reply-To: <20210712153207.39302-1-willy@infradead.org>
References: <20210712153207.39302-1-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2021 16:32:07 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Rewrite copy_huge_page() and move it into mm/util.c so it's always
> available.  Fixes an exposure of uninitialised memory on configurations
> with HUGETLB and UFFD enabled and MIGRATION disabled.

Wait.  Exposing uninitialized memory is serious.  Can we please include
full info on this flaw and decide whether a -stable backport is justified? 
If not, why not, etc?

