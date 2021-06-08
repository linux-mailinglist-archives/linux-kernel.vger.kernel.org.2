Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7C039F6CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhFHMfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbhFHMfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:35:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7B3C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YSGQEI1WX6YiXANPfcZHnOB1Uu7nxLS3hbjqa7fmpSI=; b=NqHKRKUraLAIML21HZSAmknZ4F
        VU5XAZc1pxC1JYcy9gVMgNVLmzW0kR8IhWQOQCr2WAc8FpmKcoi/Lv+Sj0J3I61+d5r3FQXyk2gar
        I/HUhvhoeZr/WgTYH6NnOvkdF8J4uCni+tx1Z0TXe+I36WvE/Yjt0M8y7C7lwOOwOi3OYL3TiHGm5
        KSomQovXbqyDh8p9A3jwiJkkNpowT3Xae/S61GX7UFaTq23bBlPF/1GxUz/xxODH2dqV2AiC+SAx8
        +KpXfOtPcWdWemeJ0sglnemOGsPokjv2ywQSdycZUwXg/bq4LK6QqJLG9eXh8cBdU//QVm4mFRJkH
        z19eDUYw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqau6-00Gw37-10; Tue, 08 Jun 2021 12:32:33 +0000
Date:   Tue, 8 Jun 2021 13:32:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Xu Yu <xuyu@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hughd@google.com,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com
Subject: Re: [PATCH v2] mm, thp: use head page in __migration_entry_wait
Message-ID: <YL9jVYgWYBydOYst@casper.infradead.org>
References: <b9836c1dd522e903891760af9f0c86a2cce987eb.1623144009.git.xuyu@linux.alibaba.com>
 <20210608120026.ugfh72ydjeba44bo@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608120026.ugfh72ydjeba44bo@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:00:26PM +0300, Kirill A. Shutemov wrote:
> But there's one quirk: if split succeed we effectively wait on wrong
> page to be unlocked. And it may take indefinite time if split_huge_page()
> was called on the head page.

Hardly indefinite time ... callers of split_huge_page_to_list() usually
unlock the page soon after.  Actually, I can't find one that doesn't call
unlock_page() within a few lines of calling split_huge_page_to_list().

