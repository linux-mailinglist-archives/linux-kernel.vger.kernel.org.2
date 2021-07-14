Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18F23C7B14
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 03:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbhGNBeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 21:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237286AbhGNBeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:34:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4EB56128B;
        Wed, 14 Jul 2021 01:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626226284;
        bh=GhhAgrzg6+D3QZxWK/qCyoqLLb801ORLrL4xD0yZs7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1jfYwAwWnlof215iZQWp18105XkOaH44dMKb/2tpkwfIWo/PnFEQpMjYpij0Rcy1K
         /jmfPGqEx8TD+03EXZXQU1gSvpqoI0/HYNuI7z8OVFuK9H0ExwEDHXjd11ccXidEm0
         DrCK/UbiAz4LXhaAhbAFnzRf5N4JK4FKSj9aS4Po=
Date:   Tue, 13 Jul 2021 18:31:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: call flush_dcache_page in memcpy_to_page and
 memzero_page
Message-Id: <20210713183123.699769a1b0ee95d69606c35d@linux-foundation.org>
In-Reply-To: <20210713055231.137602-2-hch@lst.de>
References: <20210713055231.137602-1-hch@lst.de>
        <20210713055231.137602-2-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2021 07:52:30 +0200 Christoph Hellwig <hch@lst.de> wrote:

> memcpy_to_page and memzero_page can write to arbitrary pages, which could
> be in the page cache or in high memory, so  call flush_kernel_dcache_pages
> to flush the dcache.

I assume this presently is not known to cause any problems, but that
some problems might be discovered in the future?  In which case,
should we cc:stable?

