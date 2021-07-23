Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95783D3427
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 07:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhGWE6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 00:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhGWE6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 00:58:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF45EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 22:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6cBwPCsOZ++wLb4UCT0Xq/SyB5mdeN8xQUIRPXaCoDw=; b=VOhiCjf23YLkFSePWt57pQ8dZR
        izSSgoO3gTSzOiiGbFXL1M0LXt7iUtQexBHCrVJyP3MRfO/UPnV7v/raq0X3bl4+JtRSHy0LSYRTU
        NKQ8BONTgWqL+/ohV3afs710vhwI7UIcIELObbP31PyzmlF8064Kt1s/5xZxOiajS6GnClJ84eKAX
        RIf4H5snp0qucsbaiB1zkeQ4bFlLQc0R/1hafK4moTHMVi1dVrYqPnTMnMD6d1gaiBBCy6PcCR+0h
        /CShgNFweWUm1cBjmVwYsPh6FNbdQZ9hF282H82fPAdHPSR0Yy8vTWkQ9Q/Jmy9afp6QpzYRj5EGm
        gjqOUwMw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6ntH-00B1qa-FT; Fri, 23 Jul 2021 05:38:33 +0000
Date:   Fri, 23 Jul 2021 06:38:31 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: remove export of pcpu_base_addr
Message-ID: <YPpV15qhGLkwdzeq@infradead.org>
References: <20210722185814.504541-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722185814.504541-1-gregkh@linuxfoundation.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 08:58:14PM +0200, Greg Kroah-Hartman wrote:
> This is not needed by any modules, so remove the export.

Looks good.  Note that all non-static users only want the delta,
so this could be cleaned up with a helper as well.  Also
__addr_to_pcpu_ptr and __pcpu_ptr_to_addr__pcpu_ptr_to_addr are
never actually overriden by arch code, so we can remove the ifndef
there.

Reviewed-by: Christoph Hellwig <hch@lst.de>
