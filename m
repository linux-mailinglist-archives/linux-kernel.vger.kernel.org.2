Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B266B35C23F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbhDLJlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbhDLJIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:08:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324C2C061342
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6g0DaWseFgockDKrCtuXPfAoZ1Ief9G/pC6oIUd+GKc=; b=tq8xayhWK/YAKa33COZCV97WFb
        jW8R4qQnCxMRanhJJBy+8VaR2H20wQrqNiFhimLxm9QcD9glNTYt+KvSxnduflYtB1RbCFKATsRJp
        hrjrxBgQ+NiwUOthKF1K5L0D8i9D8dRHipRlMOs6dcm+TbcOqAEH+k7XQ57EZyc7SgmkPeXm54cRG
        fRWasA8mpeoQA9iauG6E+4s//KrMkalfKJHTUoMa3Aq2kBEYwUZC3BGnCmSqkZpXmXgbUQZXXrKbX
        TZtcFubXVKp36Y+6THgXP7hdD9xZc6KjryU/IAUOoAG55Dkow1qi0W2NZOlRSOXiJugU7DjN0YKgg
        y+bAFqNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVsSq-00435H-6m; Mon, 12 Apr 2021 09:02:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4DC76300036;
        Mon, 12 Apr 2021 11:02:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E61752022420C; Mon, 12 Apr 2021 11:02:34 +0200 (CEST)
Date:   Mon, 12 Apr 2021 11:02:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org
Subject: Re: [PATCH 3/7] xen/gntdev: Remove apply_to_page_range() use from
 module
Message-ID: <YHQMqsyXXHwIx7w1@hirez.programming.kicks-ass.net>
References: <20210412080012.357146277@infradead.org>
 <20210412080611.702979288@infradead.org>
 <20210412082721.GC4372@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412082721.GC4372@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:27:21AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 12, 2021 at 10:00:15AM +0200, Peter Zijlstra wrote:
> > --- a/drivers/xen/grant-table.c
> > +++ b/drivers/xen/grant-table.c
> > @@ -1591,6 +1591,43 @@ int gnttab_init(void)
> >  }
> >  EXPORT_SYMBOL_GPL(gnttab_init);
> >  
> > +#include <xen/gntdev.h>
> > +#include "gntdev-common.h"
> 
> Can't we keep the includes at the top of the file?

Probably could, lemme move them.
