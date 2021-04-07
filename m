Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CC9356F47
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353128AbhDGOvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353135AbhDGOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:50:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D7BC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AiiGNCBjYcZfRgU7sybUVpHDghOneRNQTa+6Qoodddo=; b=WOfw0rgoWKaJU02SiNuw0A82B7
        9r5wfYjhQy5j81NgXRYs+/EdCxqykSktmbma8JypoQ3BjyJUsk/TK05vTWaICdjbXSFSnRd5p/ZHG
        PDoDR1ORkVgcLe+T6f/AU4GyPW2hgVlqOOiX7RWXiOjY1crGgvlIls6GJ+CpmL9evuU3LOBlc/Idq
        9z1TAhFjWQ0HvDzpOy+VR39oXLxtIJFhatB8np3619DrWGMuGzEWgd/iJtpRaiLgLOmmgtfkwwhnZ
        9UAgyNHihUk3iSGcTizTp/bNzwPZBc1R4jhU3va+4RUD2pGUIcOifv5lHlP5us5gGvij/3mzsb3Y9
        TyOvVFmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU9Sx-00EcVC-Ck; Wed, 07 Apr 2021 14:47:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1373300219;
        Wed,  7 Apr 2021 16:47:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8857D2BBEA8E3; Wed,  7 Apr 2021 16:47:34 +0200 (CEST)
Date:   Wed, 7 Apr 2021 16:47:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 09/37] mm: add per-mm mmap sequence counter for
 speculative page fault handling.
Message-ID: <YG3GBhvVt2cQkZVz@hirez.programming.kicks-ass.net>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-10-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407014502.24091-10-michel@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:44:34PM -0700, Michel Lespinasse wrote:
> The counter's write side is hooked into the existing mmap locking API:
> mmap_write_lock() increments the counter to the next (odd) value, and
> mmap_write_unlock() increments it again to the next (even) value.
> 
> The counter's speculative read side is supposed to be used as follows:
> 
> seq = mmap_seq_read_start(mm);
> if (seq & 1)
> 	goto fail;
> .... speculative handling here ....
> if (!mmap_seq_read_check(mm, seq)
> 	goto fail;
> 
> This API guarantees that, if none of the "fail" tests abort
> speculative execution, the speculative code section did not run
> concurrently with any mmap writer.

So this is obviously safe, but it's also super excessive. Any change,
anywhere, will invalidate and abort a SPF.

Since you make a complete copy of the vma, you could memcmp it in its
entirety instead of this.
