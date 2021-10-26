Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FEF43BE27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbhJZXx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbhJZXxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:53:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05BEC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0lW0nywobAhfvx+Rkg2aIOHXuEPbjaEywp8tzeijQnY=; b=EolnIW9mx3J0RUHxcvClKo9Fbg
        m4hG8it/zH474ircewrDmA988rctW+DLv7MGG54ruE0QeQ4tY/uoyP+i0Ao8VsSDsb0qvocAb2hqg
        TqPd40v9I1wA9lBd2O+slDvBKDUfwMkAm/bDGAUq5/qtHZFLL1GzIHvBcPEiiTqt/ktEx28YDWa2m
        2PbXPDqQ0qfYn9MZYGOtVmJOtJZgu37WlyTWORfE39s9KGYrXEwoK0yimgpSQBZ90oEdsYrQ1VKkv
        y1F3EFhJbs5h9Hwer4whVM9FysA9lNu5Q6Mts6D0D/1rRo5SP4hGODwK7Q6X0kOeScU4xgdVrlV8A
        EEJUaOFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfWCT-00HGNC-4w; Tue, 26 Oct 2021 23:49:56 +0000
Date:   Wed, 27 Oct 2021 00:49:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] hugetlb: remove unnecessary set_page_count in
 prep_compound_gigantic_page
Message-ID: <YXiUHZOWnRsOM2HX@casper.infradead.org>
References: <20211026220635.35187-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026220635.35187-1-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 03:06:35PM -0700, Mike Kravetz wrote:
> In commit 7118fc2906e29 ("hugetlb: address ref count racing in
> prep_compound_gigantic_page"), page_ref_freeze is used to atomically
> zero the ref count of tail pages iff they are 1.  The unconditional
> call to set_page_count(0) was left in the code.  This call is after
> page_ref_freeze so it is really a noop.
> 
> Remove redundant and unnecessary set_page_count call.
> 
> Fixes: 7118fc2906e29 ("hugetlb: address ref count racing in prep_compound_gigantic_page")
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
