Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBBF30F348
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbhBDMjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbhBDMjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:39:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6819EC061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NjY5liFAlk+AQiAuqlneZkVZMjMxiky/Okh0XWtNNUY=; b=jgQNlr2Asr/peAmVBvLbuI7Zzm
        4YECc6L6RVdMJjBfC3gzUjus9oPzwhHkzLpTn2cA0/8Ad/zo6dZJzex3IuV8Cl4dWuuF/BfDY0esw
        1xDtrS72MXJdeTM+5/TCW4viT0iqy3BVBff/BIkD9O9eZF0d5NBVal28pKbkrVAtutf0XcAUVsQK+
        0PnN1rNWW4vPz3jO1799PTL3Dr2Wii5K7FLmo4FLBSlubTjAv4A81LHGS+DSLwngZoiVmMmKJ/yx6
        b0AQarcu1Je4J48SNyDmcNBjSgWL9O8UBT1+EtDyi18yfBjVBVeC80yfmPOgjNS4wN1oIEHBhyQy5
        ajN7Zj3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7dtf-000rrw-Rc; Thu, 04 Feb 2021 12:38:09 +0000
Date:   Thu, 4 Feb 2021 12:38:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: Correct obsolete comment of page_get_anon_vma()
Message-ID: <20210204123807.GE308988@casper.infradead.org>
References: <20210203093215.31990-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203093215.31990-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 04:32:15AM -0500, Miaohe Lin wrote:
>   * Since there is no serialization what so ever against page_remove_rmap()
> - * the best this function can do is return a locked anon_vma that might
> - * have been relevant to this page.
> + * the best this function can do is return a refcount increased anon_vma
> + * that might have been relevant to this page.

Just s/a locked/an/
there's no need to mention again that the refcount
is increased.
