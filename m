Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9324A3521D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhDAVoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbhDAVoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:44:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EE1C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pxQ8kqbt9T0p3DLe5CD0aqP94HyRcCjrKtOKaXgZFjY=; b=BQiQ2PGdrVIUvBfkYaLa91pKJV
        q8irj7QJ8e8KQ5lG2AIKYUTOZz/qSfJOOMTLBUYiefa5UJuwKHE0EXdkCa5tx5YZc96vAN3qeWePP
        79GVU5cuKmobrZAONqE2OmovDJJPf90L+POB3bvc1cDoTJ3gda/TTA/2QGf94oAvGN4XG0BOvPWLj
        BgzFZsTCdAtNqI3ML3l3xj74RMdmGFWphuigvEy1xGaopRlT3Qs7YFZlpZAbN91KXy/miQvrReSbN
        71Fiie/DskCPG+xO5QYOtizA0SkyS3aX/tz6QfWg1X9iM6sUVPZP2MQ+5cL7+oUgoXoJxiN0lugCG
        PBebJunA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lS56C-006mp2-Io; Thu, 01 Apr 2021 21:43:41 +0000
Date:   Thu, 1 Apr 2021 22:43:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: page_owner: use kstrtobool() to parse bool option
Message-ID: <20210401214332.GJ351017@casper.infradead.org>
References: <20210401210909.3532086-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401210909.3532086-1-slyfox@gentoo.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 10:09:09PM +0100, Sergei Trofimovich wrote:
> I tried to use page_owner=1 for a while noticed too late it had
> no effect as opposed to similar init_on_alloc=1 (these work).
> 
> Let's make them consistent.
> 
> The change decreses binary size slightly:
>    text    data     bss     dec     hex filename
>   12408     321      17   12746    31ca mm/page_owner.o.before
>   12320     321      17   12658    3172 mm/page_owner.o.after
> 
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-mm@kvack.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Seems to me there are a few other places that could benefit from this.

kmemleak_boot_config()
early_kasan_flag()
early_kasan_flag_stacktrace()
nonx32_setup()

maybe others?  grep is our friend.
