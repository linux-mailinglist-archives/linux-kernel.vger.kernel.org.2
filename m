Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B913E36DE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhHGS4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 14:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhHGS4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 14:56:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D59F60EBC;
        Sat,  7 Aug 2021 18:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628362591;
        bh=R4KUtAstqXIu436XTZFaUdZcmaVE6hSEsEnvEkhR7y8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t7dPrU/1MCltJi1oDzxqNIGo8JYvyP0pLs2pCPY7uRqI5e568Vl/aHvm0NZGCTLB2
         L+UrsPJUiV/enlnUkL2hsFUkon0/2pbXXixkCE7Yh3EHC3xnAixdACATkopZhCaN9f
         zVZb5wDA/YrXr2zfqXAtGNVtT9Mw9qWCazjXCPxY=
Date:   Sat, 7 Aug 2021 11:56:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <shakeelb@google.com>, <guro@fb.com>,
        <songmuchun@bytedance.com>, <willy@infradead.org>,
        <alexs@kernel.org>, <richard.weiyang@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] mm, memcg: get rid of percpu_charge_mutex lock
Message-Id: <20210807115625.b09fdf35b0251206b252e19a@linux-foundation.org>
In-Reply-To: <20210807082835.61281-4-linmiaohe@huawei.com>
References: <20210807082835.61281-1-linmiaohe@huawei.com>
        <20210807082835.61281-4-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2021 16:28:35 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> We should get rid of percpu_charge_mutex lock as Johannes Weiner said,

I'll skip this one for now - it all seems rather uncertain.
