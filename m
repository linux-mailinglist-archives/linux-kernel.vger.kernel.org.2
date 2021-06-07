Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B6D39D72B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFGI1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:27:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F3C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 01:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lYimeQvfov2wnqeOE0GNZZwploWBweMmgrN4dpYrUrQ=; b=A3j5IATMFzjKkRcSrV+SFIyuAw
        VqoxxQWSPn6P3N3tmG8GA1YOCdTfXWYZV+EhjZEgZtVDgS1ojsq1bsll0QIu4j2ZezMJWHd9OUs6L
        jX9uT2OE1gHCP0Z2O127GnxiUokTtQFsGe7PpMGJAOn/eUx9mMXoQPeriQZqLdUZqlgODpFHPmMpa
        UpJAscbCUSkW4E+J/p8FsvIqatXz2vXnfmY77xMl/dlIC2Fn0lvDeuzoEGtJezOWeYEhE1E8QDlSz
        tskoa8zxpdKrflnBqtEtJbgkdksQLi7RQsMD1KwKieNXqfZ13d8dX8+LJFRvZDW0sCX1InVKq2yMj
        GXkM10/g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqAZT-00FWqx-9N; Mon, 07 Jun 2021 08:25:23 +0000
Date:   Mon, 7 Jun 2021 09:25:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, kernel@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Export tracing_start() and tracing_stop()
Message-ID: <YL3X7yRr1+yW/PHU@infradead.org>
References: <20210602080118.21627-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602080118.21627-1-vincent.whitchurch@axis.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 10:01:18AM +0200, Vincent Whitchurch wrote:
> tracing_stop() is very useful during hands-on debugging for getting the
> trace to stop exactly when the problem is detected.  Export this to
> modules.
> 
> Personally, I haven't yet found the need to use tracing_start() from
> code since I usually start tracing via tracefs, but export that too for
> symmetry since it may have its uses together with tracing_stop().

NAK, no exports for unused symbols.
