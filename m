Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F763BECCA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 19:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhGGRIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 13:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhGGRIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 13:08:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9111C061574;
        Wed,  7 Jul 2021 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d3VM6WT6D5YL/WJ5V7RszIEGS7pxSO5TS9NGv7itCmU=; b=gPlz2ujtqcODOZy73CeHy4SqNb
        pEeMt2zOH/pBPwn43VYADVC5ffumABTnaxNJFHq7Rbqqs8WsM3xtimmi5bVvpouDVdyF0JMDxnDnR
        pKnDbtzl28dWqF8iNqZNjHJqlyQ3aHnJoWoywLAK/i/TxK9+V2aJemZjNx20YlhvseFxN4Vjimrqz
        u+Fd8Cdeu8/8lrMaaUnbCclH9/soUbf+n741MsHiofGmkodZ/LJA79HepwZ8VUtb3WSpua5fa2OiK
        xwZy9qrmpyyv3XbE0WzFmmdhQNKY7VK5zyIvYuobRjaW7BJbkLOuHIzLclTONAzeHVPWmB4m4l4uv
        +1HXYCwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1Azi-00CcFj-GQ; Wed, 07 Jul 2021 17:05:56 +0000
Date:   Wed, 7 Jul 2021 18:05:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH] mm: try_to_unmap() is now void
Message-ID: <YOXe8jb3uOXFq0j7@casper.infradead.org>
References: <20210707161614.13001-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707161614.13001-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 09:16:14AM -0700, Randy Dunlap wrote:
> Fix the "CONFIG_MMU is not set" case of converting
> try_to_unmap() from bool to void.
> (as seen on m68k/coldfire)

hch sent basically the same patch on Monday
