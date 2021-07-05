Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BE03BC21F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhGERPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhGERPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:15:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C161C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mmf1SlCXCH1ZT5OFVn/BWSXWxmpTl5m114UeltKLQ4Q=; b=HwFMTK/i8xNL8oD7nkfgRIdkoE
        WXFhGBR08wvN/ah07oSzrrXraBD8CiO4AdgEZDAMmtL90BsyO0ksVHvZ511XJn5uaa7+3bPH07izM
        Fs5bKVi4ibuHspaAd7RZ4KZjAjfqT+BRZ5YRz4JsNzp21UeypkEOtl7xv63HjJo9Rubkz8U3XFVQ5
        LsMQappyewDzXhN6rlYlEjiAsZH5IOrb8ZleGH1WCLcPwCBIpemvSERqj20yTXaT+EqazcBfeOxak
        dkwaluphYojVNcjA2+ft61cBZ3i/IfrvtHGTLfZR+GvbwH0BEqMhWp1u7aiy0OUvF02zZPBJA/AzV
        b7OFwqyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0S8x-00EkxJ-IA; Mon, 05 Jul 2021 17:12:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DF56300209;
        Mon,  5 Jul 2021 19:12:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DA5B200E3917; Mon,  5 Jul 2021 19:12:26 +0200 (CEST)
Date:   Mon, 5 Jul 2021 19:12:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/atomic_t: Document cmpxchg() vs
 try_cmpxchg()
Message-ID: <YOM9emXjk2aHYosu@hirez.programming.kicks-ass.net>
References: <20210630153516.832731403@infradead.org>
 <20210630154114.834438545@infradead.org>
 <cac55711-585a-4e08-3b5e-a6890e2f548d@windriver.com>
 <YOMQYQr1loxIuZbU@hirez.programming.kicks-ass.net>
 <YOMgPeMOmmiK3tXO@hirez.programming.kicks-ass.net>
 <137696c1-7782-18f0-f005-a2416edbeac0@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137696c1-7782-18f0-f005-a2416edbeac0@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 11:25:29PM +0800, Xu, Yanfei wrote:
> > +CMPXHG vs TRY_CMPXCHG
> 
> CMPXHG -> CMPXCHG

Yeah, already fixed. I spotted it a minute after sending :/

> > +---------------------
> > +
> > +  int atomic_cmpxchg(atomic_t *ptr, int old, int new);
> > +  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new);
> > +
> > +Both provide the same functionality, but try_cmpxchg() can lead to more
> > +compact code. The functions relate like:
> > +
> > +  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new)
> > +  {
> > +    int ret, old = *oldp;
> > +    ret = atomic_cmpxchg(ptr, old, new);
> > +    if (ret != old)
> > +      *oldp = ret;
> > +    return ret == old;
> > +  }
> 
> I tried to search some comments about atomic_try_cmpxchg(), but failed.
> Maybe I missed it. With your this document, it is more clear now.

OK, good, thanks!

> > +
> > +and:
> > +
> > +  int atomic_cmpxchg(atomic_t *ptr, int old, int new)
> > +  {
> > +    (void)atomic_try_cmpxchg(ptr, &old, new);
> > +    return old;
> > +  }
> > +
> > +Usage:
> > +
> > +  old = atomic_read(&v);                       old = atomic_read(&v);
> > +  for (;;) {                                   do {
> > +    new = func(old);                             new = func(old);
> > +    tmp = atomic_cmpxchg(&v, old, new);                } while (!atomic_try_cmpxchg(&v, &old, new));
> 
> Some unnecessary spaces before "while".

That's due to the diff prepending the line with "+ " which offsets the
tabstop. If you apply the patch the actual document is fine.
