Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4493062D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbhA0R64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344389AbhA0R6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:58:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD19DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iyQVp0N93KHyZqK0aJ5ANoXsqKjq6qul+8q9iBSlY/0=; b=QZQUBs0T++CbjmuNDPEruUIliI
        fMdaFzCJPjqjsbB1KTbSBNzaq87aSZZVhsunU6oiYJnpztjfuPKPgZuLGxBOUWsY95sf/Cn0pnAgQ
        4zopY+UvovEO6Lpq1lvc7nIbbaPJfmD2YgZ6ePT+4U1Cu+KkRSERNrjtoL5QJv+wQJ8jWMZZyqWTn
        K707rCo5r4A9UfgXK4AqSvoIX/10cxo3+oroS3PNKRFh0qSwY20/wHQHUcVvAw5LruTIpHbTobG7q
        3w4pg8c8lUZanbgYIi8Jg4HZgiH4+KzVBV/TWSd3DboBuBa7kUEvJii+WKXEuyjLDm3eS/S6NpZRq
        fR+2v54g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4p4Y-007Jy6-Vo; Wed, 27 Jan 2021 17:57:47 +0000
Date:   Wed, 27 Jan 2021 17:57:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        kuba@kernel.org
Subject: Re: [PATCH] fs: export kern_path_locked
Message-ID: <20210127175742.GA1744861@infradead.org>
References: <20210125154937.26479-1-kda@linux-powerpc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125154937.26479-1-kda@linux-powerpc.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 06:49:37PM +0300, Denis Kirjanov wrote:
> the function is used outside and we have a prototype
> defined in namei.h

Huh?  It is only used in drivers/base/devtmpfs.c, and
kernel/audit_*.c.  Absolutely no need to export it for that.

