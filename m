Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8624326275
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhBZMOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhBZMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:14:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5D2C06178B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 04:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W+BHG2rTIxJEd48HjrwhvEiIlo5wfdJwA+Qad46qFNo=; b=Yqx4Zk38X8po2iPpxD21IYnw5q
        JiwCQiOlnWy8V33H9DnKo8WMuIGJuPGf/KJQ1n6K09aRWsQdsW2CRKebm89xlHrTi8wy5aJa16pj7
        +yUhqvwa/J7HaO72DH6Y/4q+85xGe3TzjDyreMA2joUFI7fXuLN9lqBa0AYJV58U5u6gjdfWBb0VP
        37nnyUaGwARo1F8zLA9lwoJZ48SjcNQ89uCRKp8Qgqq2qspncObQsdU48NPFsDqSGc38K2Kq4QRMK
        84N3/UqkR7UwoRmJ06j0A6NLbNKp3M397qwZb2mLAqCD1noaUL3pTG1PUb2Az63fwJrC/B4G+DBHF
        lQ2Q9W5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFbze-00By35-2u; Fri, 26 Feb 2021 12:13:15 +0000
Date:   Fri, 26 Feb 2021 12:13:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        vbabka@suse.cz, guro@fb.com, hannes@cmpxchg.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v2 3/3] mm: use PF_ONLY_HEAD for PG_active and
 PG_unevictable
Message-ID: <20210226121314.GB2723601@casper.infradead.org>
References: <20210224084807.2179942-1-yuzhao@google.com>
 <20210226091718.2927291-1-yuzhao@google.com>
 <20210226091718.2927291-4-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226091718.2927291-4-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 02:17:18AM -0700, Yu Zhao wrote:
> All places but one test, set or clear PG_active and PG_unevictable on
> small or head pages. Use compound_head() explicitly for that singleton
> so the rest can rid of redundant compound_head().

How do you know it's only one place?  I really wish you'd work with me
on folios.  They make the compiler prove that it's not a tail page.
