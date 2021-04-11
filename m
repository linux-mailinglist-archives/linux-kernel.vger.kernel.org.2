Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABD635B6FE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbhDKVXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 17:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhDKVXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 17:23:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8845AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 14:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cAdrF5XVA29PkCzu3UHP6JSDGaBAyXDC096AhR872kM=; b=ZzryI12tFu5JOWfOPNwC+93JkE
        jKbN6ld7hpjKj91AIN1LdTJqtuFPDpt+BMYMscIP5F9inUODkjErgYRJqNqBa8G0IvCtLBZe+1a5Z
        SuH1wokIU7BecL21W5+joyCe6IaJSL3Bd8pdCd+cRTsWdpwq1IIE5gktTMpMdLJqZCyNyVmK+oklR
        vW1JMV0WRGSyo9VtQjGP3vFkDxKduRCtkeilm5rP/zZGoc8/RHljSz5EMG0tO6ryvZf0ZOeOu6zd/
        0b1425AsoAI5+MV98xbJSmPnsCbKht8fnvLMRzVFkLq/O0Hg6eZdOOrklwzRWTSP2/HSEaQit8Kl5
        xty3s13w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVhXg-003Sb5-0U; Sun, 11 Apr 2021 21:22:52 +0000
Date:   Sun, 11 Apr 2021 22:22:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: eliminate "expecting prototype" kernel-doc
 warnings
Message-ID: <20210411212251.GE2531743@casper.infradead.org>
References: <20210411210642.11362-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411210642.11362-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 02:06:42PM -0700, Randy Dunlap wrote:
> Fix stray kernel-doc warnings in mm/ due to mis-typed or missing
> function names.
> 
> Quietens these kernel-doc warnings:
> 
> ../mm/mmu_gather.c:264: warning: expecting prototype for tlb_gather_mmu(). Prototype was for __tlb_gather_mmu() instead
> ../mm/oom_kill.c:180: warning: expecting prototype for Check whether unreclaimable slab amount is greater than(). Prototype was for should_dump_unreclaim_slab() instead
> ../mm/shuffle.c:155: warning: expecting prototype for shuffle_free_memory(). Prototype was for __shuffle_free_memory() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: Matthew Wilcox <willy@infradead.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
