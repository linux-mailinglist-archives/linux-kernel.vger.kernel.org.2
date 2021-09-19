Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A5A410BDA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 16:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhISOXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 10:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhISOXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 10:23:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E62C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y10JfXIf2XYV5MxTL60lbgbnkwxdDgasgVFy6jkggcQ=; b=DJTUwvcrcxBuXG0nLOQsN1yAcz
        FED0Jm3YW1yuy8vjZkfo0C3lBe/rxXQ0xuCfOncT8Nd9zA05NhM0skgVqn5aqkrBWsJYgb8z8zZcH
        Eqg026OA/fATdAhnhRwLRO4zZPUxt/Cor4tfkq9Y8ifw8mgYO1P2JIzgz8miiAqK6AJUeMJtO6X0s
        jOcTY2Iomt7e82CpbcS35TUkM+oTRL0P5UTdR7j3y0r2LLbPtfhBIgRdkdLIxtNUyv5MKItnIERrr
        iUFiH0gagOs1Kki7vNiZiGIwtn+DsOE5PBkn0bz+zM8V4u9cxkCRqmC4rFBOhs1Y5e+4ZQ+8+jmXB
        7O7AmDxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRxhJ-001vRq-1l; Sun, 19 Sep 2021 14:21:44 +0000
Date:   Sun, 19 Sep 2021 15:21:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [RFC v2 PATCH 1/3] mm: add PG2KB/KB2PG helper macros
Message-ID: <YUdHcXHWNs5Px9AD@casper.infradead.org>
References: <20210919131248.489798-1-oleksandr@natalenko.name>
 <20210919131248.489798-2-oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919131248.489798-2-oleksandr@natalenko.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 03:12:46PM +0200, Oleksandr Natalenko wrote:
> +#define PG2KB(x)	((x) << (PAGE_SHIFT - 10))
> +#define KB2PG(x)	((x) >> (PAGE_SHIFT - 10))

This is not an improvement.
