Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84B40BD86
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhIOCLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhIOCLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:11:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D17360FA0;
        Wed, 15 Sep 2021 02:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631671791;
        bh=rgZjwT28lKf5bS2kz34I0iU8KQ5dMH60bRht1FuxNGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LP3fxlPEJZpKwQXpAu48QirMdteL+hj+rbmHFM/GmGmUgtCUZ6OpEeyd/yC7RW70z
         MeXCd8qY62fChs3r7ftfFQwNSmrrHLjh55QDGhvT2mb6r3feTlDvJSZw5Yd4HLHmZZ
         pi587E5KOTD1F/RPHWeWZ1yKVVkc0ixgrd3rt5Zo=
Date:   Tue, 14 Sep 2021 19:09:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <david@redhat.com>, <jhubbard@nvidia.com>, <vbabka@suse.cz>,
        <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm/page_isolation: guard against possible putback
 unisolated page
Message-Id: <20210914190951.2e44de6a55a0c7004d5381b3@linux-foundation.org>
In-Reply-To: <20210914114508.23725-1-linmiaohe@huawei.com>
References: <20210914114508.23725-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 19:45:08 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> Isolating a free page in an isolated pageblock is expected to always work
> as watermarks don't apply here. But if __isolate_free_page() failed, due
> to condition changes, the page will be left on the free list. And the page
> will be put back to free list again via __putback_isolated_page(). This may
> trigger VM_BUG_ON_PAGE() on page->flags checking in __free_one_page() if
> PageReported is set. Or we will corrupt the free list because list_add()
> will be called for pages already on another list. Add a VM_WARN_ON() to
> complain about this change.

Are you able to identify a Fixes: here?

Is a cc:stable justified?
