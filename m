Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7809B3F75D3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241238AbhHYNYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240040AbhHYNYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:24:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDC1C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CmSgdsaAjueGvNIdPuNiDOvcgpGwdj7s/+pHGH6xL70=; b=YHWxIz55cKrRfyixgXMJEFU62O
        p0PGQbl3EXw9IRbPu5TBn2yoEwH6MzCGrEBcWtPSoS3zqdCn7Sam6ncn46o5NkY78T0PnRUjntZU9
        L/8kurvrn910QLqoRptn/krFOGg3R3KZFSzrTatTKFSu5TgZ7RLz1jWNI3H3v2AsL6eAui78m+RSv
        ae6sNbd9b4QlF2Rr3ANfI8ihRVmqGfkn+JwQufyyLfZKLRYL3eD7ypc1EPP6J+OB6KOcOhw1738al
        gRuy3KTppgtGTWPURpkOAAFngHJCvoy43OXGoj7/S0LIfaZiMUy7OE1ogFUI1RV2yOu7o50yZ9Iu9
        Ni9QR4Gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIsqi-00CKGt-0B; Wed, 25 Aug 2021 13:22:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B47D43005AD;
        Wed, 25 Aug 2021 15:21:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A36A92CB0954F; Wed, 25 Aug 2021 15:21:46 +0200 (CEST)
Date:   Wed, 25 Aug 2021 15:21:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Li RongQing <lirongqing@baidu.com>, dbueso@suse.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rbtree: stop iteration early in rb_find_first
Message-ID: <YSZD6suya8fR/2uY@hirez.programming.kicks-ass.net>
References: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
 <YSYr7nqql825rHol@hirez.programming.kicks-ass.net>
 <20210825115332.GA4645@lespinasse.org>
 <20210825115859.GB4645@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825115859.GB4645@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 04:58:59AM -0700, Michel Lespinasse wrote:
> > NAK. This looked slightly wrong before, and is more wrong after.

> Actually, my explanation is wrong too :) but so is the code.
> A failing example would searching 10 in the following tree
> 
> 
>                         10
> 		       /
> 		      5
> 		       \
> 		        10
> 
> The search would stop after visiting node 5, and miss the leaf which
> is the expected node to be returned.

Just to clarify; the current code *does* work here. The proposed patch
breaks it.
