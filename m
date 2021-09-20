Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E37C411387
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbhITL3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhITL27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:28:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6BBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 04:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r3NU0H/RsEeSxxnq4qhEldF8r/YZ0YN+JMp18J6EmQQ=; b=BL9A4dj1YzIgQFtxraXGv52UtI
        1UeO2jcBTF7w+oSJQqmOVK7ynRxrtYRKIHCp9PjFWF7Afed4KWtKVQZrtY2CRW7gujKVYhkSbxkX8
        1uhuV+1nf2i44MCy2a7529G+3Zi5RqZaCzCFAwRxd62eg8dQUO8hZPaQ+1G66pYniyn/U4vZDU8Bv
        HtKxpfaF8e4W46CRkovI+k93GKIdDw/a7pG2xFyZeEEjtAcEaQw9MsEFXe5I2e9PnB+k+fZwtxm29
        jyuRyMoU7UcKDi3RFAWCWjEa5sXono8dyPuf1k0/kTGttm2d2CoSvoXgu8gW2dLAxrYeNQ4+F9fGb
        RGOFwMrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSHSJ-004VG9-I7; Mon, 20 Sep 2021 11:27:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 089C73001EA;
        Mon, 20 Sep 2021 13:27:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE485212D6917; Mon, 20 Sep 2021 13:27:26 +0200 (CEST)
Date:   Mon, 20 Sep 2021 13:27:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.15-rc2
Message-ID: <YUhwHsx8n0KJWgQP@hirez.programming.kicks-ass.net>
References: <163207602242.947088.16824174748243890514.tglx@xen13>
 <CAHk-=wiFY6Ys0bOrUUsocp_1YHt_9aEBi9CtPt4N0bRUTY8+5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiFY6Ys0bOrUUsocp_1YHt_9aEBi9CtPt4N0bRUTY8+5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 01:10:45PM -0700, Linus Torvalds wrote:
> On Sun, Sep 19, 2021 at 11:28 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >
> > -       atomic_add(READER_BIAS - bias, &rwb->readers);
> > +       /*
> > +        * _release() is needed in case that reader is in fast path, pairing
> > +        * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
> > +        */
> > +       (void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);
> 
> Ugh. This really needs fixing.
> 
> atomic_add() is already much more than release-ordered on x86, and
> atomic_add_return_release() is much more expensive on some uarchs.

Is that XADD really more expensive? I don't think I've ever seen that.
Anyway, sure, we can go create atomic_{add,sub}_release() and replace
the few occurences we have of this (a quick grep shows this is the 3rd
such).
