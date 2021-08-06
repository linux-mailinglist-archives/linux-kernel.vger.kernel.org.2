Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708ED3E2A31
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbhHFL5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhHFL5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:57:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B434C061798;
        Fri,  6 Aug 2021 04:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GTrZgcQBlZ0LVEw7tZM1GzfrNVvDF1A9jOYPKV5T1co=; b=akN2yaj8Ns/RZ4oltMMVdxaS4T
        WjKJ7Mcrzr2knc0QO9b3cCsKs/gsErwqco94GhO47SEZbplYDNLhPnw+nxGa7HVLiwIWdrfrmai/C
        NHmonw2kBwweLrT/u0k3cqtAw9DqAOlfg3gL5n5eSMd+oao2+Tyhe5rYjWJkw1iHEafcz/VfVBuNg
        KzjfvOaEd7E/qRKFzKaufc5q62e+3pfLQFC2/74PR2tzbCjyzvjYo4qyUC08/CX3Rp0SbXrIh5a5o
        dk0/tgP2u5V6hhnbcr8bdfOM4IWP7NyyLOeI0jhf2BJuQqwbEF+RY7J7zsbWAjMBZhzzEz+oYJL+P
        k7AIIAvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mByTc-006MJU-75; Fri, 06 Aug 2021 11:57:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 816C630003A;
        Fri,  6 Aug 2021 13:57:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 298E520292D1B; Fri,  6 Aug 2021 13:57:21 +0200 (CEST)
Date:   Fri, 6 Aug 2021 13:57:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Mete Polat <metepolat2000@gmail.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jesper Nilsson <jesper@jni.nu>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] rbtree: remove unneeded explicit alignment in struct
 rb_node
Message-ID: <YQ0joVCrc0hTxRXK@hirez.programming.kicks-ass.net>
References: <20210805133213.700-1-lukas.bulwahn@gmail.com>
 <CAK8P3a3aNuxaEtAiewd+Wjc8hKtca0NrcV2kykkNC-qKT_HhzQ@mail.gmail.com>
 <50ad4c8b848bd371b4b42959167ef03d@suse.de>
 <YQwd2puXiSiUWEE1@precision>
 <20210806085245.GB14650@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806085245.GB14650@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 01:52:45AM -0700, Michel Lespinasse wrote:
> I think moving the color to a separate word would be costly, both in space
> (growing the struct rb_node) and in time. Feel free to try it, but I would
> expect the rbtree performance tests to regress significantly.
> 
> __rb_parent() could probably be modified - it only needs to mask one bit,
> I'm not sure why it masks two.
> 
> As to what would happen on 68k... hard to say, but I expect it should
> be fine (if the compiler cared for the structs to be aligned, it
> should do it on its own). Still, not sure how to test that either.

Somewhere, on the infinite length TODO list, I have an item to implement
threaded RB trees, which would need the LSB of the left and right words
too.

In general, the kernel is overflowing with code that (ab)uses the LSBs
of pointers and relies on at least natural alignment. There is
absolutely no point in fixing just this one instance.
