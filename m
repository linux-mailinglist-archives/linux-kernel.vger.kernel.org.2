Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA013E136E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbhHELGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240623AbhHELGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:06:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DFC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 04:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tx6IwywqLdqyvPPkZlXvoqIuPaEhwfU9Pygwcx8CxWY=; b=IT80di+p4r/phKcmJ3DJmWV2AW
        Tbj5CIt2B5gUOLvZIus7tfbeKL34p/3C5DsB4Jakl1naaEwwA64QamobZqv0XHKtRe+/UO6jX5T0D
        CVlpC9vfPEp5apLpGZZqL9oWWqAQAfL9nA5dcGXAK/+4ozmfEk4XoUgdb5zoP4tWN2UogAJsGtdB8
        tHLzR9Zmi7bF+3wDWbPXgBpQBqltQi2qbBbHSRyMyb6MGktGhKXrniB++A3pyeZYlU/833C1d6Yqy
        6i5ggKJ6OY/99/8d8TbFLUyf5fuS5CrsmoEblZKbWXP735Wzncms6E3cBlH0HqpxY5dpycSLnJsAs
        XXxbwalw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBbBi-006su3-Qs; Thu, 05 Aug 2021 11:05:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27204300084;
        Thu,  5 Aug 2021 13:05:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AE0120295B1D; Thu,  5 Aug 2021 13:05:22 +0200 (CEST)
Date:   Thu, 5 Aug 2021 13:05:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: objtool hang/loop?
Message-ID: <YQvF8awy08ZWRElt@hirez.programming.kicks-ass.net>
References: <be49b820-434f-cebe-0902-3d5177239233@infradead.org>
 <20210804183419.k7p3tvqerwgzxpuz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804183419.k7p3tvqerwgzxpuz@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 11:34:19AM -0700, Josh Poimboeuf wrote:
> Can you try this patch from Peter?  It halves the memory usage.
> 
>   https://lkml.kernel.org/r/20210507164925.GC54801@worktop.programming.kicks-ass.net

Oh hey, Josh is back :-)

Just in case you missed it (I'm guessing your inbox is as big a mess as
mine is), that patch is part of the below series that is awaiting your
feedback :-)

  https://lkml.kernel.org/r/20210624094059.886075998@infradead.org
