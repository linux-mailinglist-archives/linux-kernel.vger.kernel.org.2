Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422D23C9483
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 01:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbhGNXcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 19:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235198AbhGNXcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 19:32:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C977460E08;
        Wed, 14 Jul 2021 23:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626305351;
        bh=KiaUNthSqIm6qp0ZYhb+eE2W5WkK/bRcOtub2aM1quQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AB5cc9RBEQTtdOfs9KDcS6XQpfo6Q1bSZITsx5AZYcwWdsRA+RimOL5kujnZIgI8o
         SKKA3f5XOS5crug806jLMl9kEHR7zTo7TBlN5BWvTxNUl/VWxZA2+4LLa1H8q6vVYC
         aQ+DLQOMVd5Vk+BoA2ZYQO0RImD48uDL8QE3aK6A=
Date:   Wed, 14 Jul 2021 16:29:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     <serapheim.dimitro@delphix.com>, <urezki@gmail.com>,
        <wangkefeng.wang@huawei.com>, <weiyongjun1@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] mm/vmalloc: fix wrong behavior in vread
Message-Id: <20210714162910.4cb5434f7745dcf7ce9d85c2@linux-foundation.org>
In-Reply-To: <20210714015959.3204871-1-chenwandun@huawei.com>
References: <20210714015959.3204871-1-chenwandun@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 09:59:59 +0800 Chen Wandun <chenwandun@huawei.com> wrote:

> commit f608788cd2d6 ("mm/vmalloc: use rb_tree instead of list for vread()
> lookups") use rb_tree instread of list to speed up lookup, but function
> __find_vmap_area is try to find a vmap_area that include target address,
> if target address is smaller than the leftmost node in vmap_area_root,
> it will return NULL, then vread will read nothing. This behavior is
> different from the primitive semantics.

What is "the primitive semantics"?  Does this refer to behaviour prior
to f608788cd2d6?

> The correct way is find the first vmap_are that bigger than target addr,
> that is what function find_vmap_area_exceed_addr does.

Is this problem observable from userspace?  If so, what are the effects
and what must an application do to trigger it?
