Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5575D34F0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhC3SPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhC3SOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:14:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC61DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EmF3w0hVBC+ZHp4W/qPPZe6sZHzkhbeBfjQ3MKRFYro=; b=EDlR7dilO/eQopvezzwA0Q1ZSO
        k6zRfW5EHL+XY4O3DIZJLbIw+0cOGxCL4xjdCug1AP7C/FfC1RGqRrZzp6Y+Z+6qRN/QvI3EAks9o
        GCR4FdtUhTB7HFfoBSiRdTijILL1hSSkZohmFXlZrOTSh5F3XQoTjXPrKP2iJ0qMp7l+uG0oSmsH9
        Hw3SeDTRSXzH1cekN49tXNAe8p6ksHxH6pa25wyc/DhzN4WlFFCFnN6Wgf+Khj8+9XGfx9WMMuoub
        DDxXTamO/qb++ckAHrRmjvp/RMEkfE3l9n86dhsAdTu9aAD2MDW802leWhcAHHpYsdayrNzCTow1Z
        j2is8msQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRIs7-003Px1-Aq; Tue, 30 Mar 2021 18:13:51 +0000
Date:   Tue, 30 Mar 2021 19:13:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greentime Hu <green.hu@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] nds32: flush_dcache_page: use page_mapping_file to avoid
 races with swapoff
Message-ID: <20210330181347.GQ351017@casper.infradead.org>
References: <20210330175126.26500-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330175126.26500-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 08:51:26PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Commit cb9f753a3731 ("mm: fix races between swapoff and flush dcache")
> updated flush_dcache_page implementations on several architectures to use
> page_mapping_file() in order to avoid races between page_mapping() and
> swapoff().
> 
> This update missed arch/nds32 and there is a possibility of a race there.
> 
> Replace page_mapping() with page_mapping_file() in nds32 implementation of
> flush_dcache_page().
> 
> Fixes: cb9f753a3731 ("mm: fix races between swapoff and flush dcache")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
