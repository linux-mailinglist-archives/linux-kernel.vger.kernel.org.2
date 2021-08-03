Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009483DF193
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhHCPbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbhHCPbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:31:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D16C0617BC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Cz5tHnLZ/zZ0M40p0aA25QpJI0F0WHRmOpT2TJ8ico=; b=n12drolvofDxEDCjOMRHX0Z/8N
        ckhFuVvy1H2/tcxyFwQw3A7azME0LmjOeLBQMK/Mk32EkHWp8z652Em3qroCfIl4Q84iW7yW+vuaH
        2Ybcvwg3VeN6z8RR9FUHOEDNVO9uMd6Coa2KsNAn8dem/8NCLlF2Z0kAoMXCH0rHc2AMZnuFglogH
        1I8MtVqdH8I4qs0vU/fqm9C8IL2Lfqf9dmjdP1b/S/RWzFxLoimzeY8I2F6/Fn08fWupKAt6K/+Fo
        NBtHdQM14QEjWKpUUKiWATdDZ7YT3BtdULVpagKAMRogCe8UT4ICQ/YkSECWpSKPqTl/T9J/1sFtS
        c4Rat99A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAwMv-004pGY-Th; Tue, 03 Aug 2021 15:30:27 +0000
Date:   Tue, 3 Aug 2021 16:30:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap: Remove the unused get_kernel_page()
Message-ID: <YQlhBRi7dWSwpcFs@casper.infradead.org>
References: <a6137b871658cdbd0cde9fbeecf2168bc8ec87e9.1628002955.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6137b871658cdbd0cde9fbeecf2168bc8ec87e9.1628002955.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 11:07:04PM +0800, Baolin Wang wrote:
> Now there are no users of the get_kernel_page() function,
> thus remove it.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Perhaps you should just send a Reviewed-by: for John Hubbard's patch
on July 29th instead?
