Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4B3B9058
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 12:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbhGAKK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 06:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhGAKKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 06:10:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC66C061756;
        Thu,  1 Jul 2021 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o+Aax4uE+m6fcXLvXgWJDu1X9ATz+Q3i3NF2yZCfb8I=; b=NOVYcQw4AHMjpDWt81floQmDhW
        gx6CHtJhi7+r9s6BsNvwXZoagmOabcOf/VIqlAliyB5pdrlg1iisvZ/Rnf5dMSRnYKkqHdXiEVQtf
        Fh11P7t3MJRQyq6YFvvQ8owuJorgaewuZ3Z6EyZeZ2RmoDVnOx81VyBpN40HPK6iNrYUJWhJM2hj9
        a7yfuaKREV5jHW9HLIHIiIB6qGPYCRjfzjQ8cufQ29qpundtl1RHaqWwPDHlBeLNKXxcWW5tfIGK6
        gNzIlVJsa8Yeb3s/FoYJQh4dE79HXJy6iIfo3BaSDt8zn2o6zFT88/QOhhoXssLC4KPJ7yeQ2OscV
        S8wjhc0g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lytbI-006Qv5-VE; Thu, 01 Jul 2021 10:07:25 +0000
Date:   Thu, 1 Jul 2021 11:07:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Removed a warning while compiling with a cross
 compiler for parisc
Message-ID: <YN2T1LKfA8pTJuBU@infradead.org>
References: <20210630214233.235942-1-abd.masalkhi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630214233.235942-1-abd.masalkhi@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the proper fix is the to apply the

"reduce stack footprint printing bdev names"

series and then just use the new printf specifier to print the bdevname.
