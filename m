Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1563E2EF8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 19:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbhHFRph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhHFRpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:45:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F0DC0613CF;
        Fri,  6 Aug 2021 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qRduPNPCLfBMTFYoq3QGcw3w+yL4nRTomePXW3/qUjU=; b=iqeWAgdtlkNbV8x9UpOR22Kofq
        vOZK1ssLyeBoWZ6PDtdLTbF21sQzm4KeIOOlGD0Xs6Dkf3ypCp/Vp1wesR8+RiSCT+im1Oc3gxOJW
        dBrg/iKozPAmVjNh/ri6w0VGgybsTFZp+m445sNHeCCR+TPBcqloIfDTZ/njdo/hUHXpah+E6g70s
        sWhe6WJ8RsenGANYYvYfV+vEntvL8O1lGzL5pldMrAPdLCNSLq/uGNbEit2kSIBbF6GS4EnRcRSNC
        Ib4lvbL2z90SJV7tSOi2SPnoXv9ooHjtQAzdrDVQnDLeEuCBhJH1rDYfTrSnYRQydKkGTvyf8DJK5
        4SItqBXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mC3tz-006QB3-Ln; Fri, 06 Aug 2021 17:45:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E17498632E; Fri,  6 Aug 2021 19:44:57 +0200 (CEST)
Date:   Fri, 6 Aug 2021 19:44:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mete Polat <metepolat2000@gmail.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jesper Nilsson <jesper@jni.nu>, Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v2] rbtree: remove unneeded explicit alignment in struct
 rb_node
Message-ID: <20210806174457.GA2184@worktop.programming.kicks-ass.net>
References: <YQ1ToK8EMdAO4CyH@precision>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQ1ToK8EMdAO4CyH@precision>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 05:22:08PM +0200, Mete Polat wrote:
> Commit e977145aeaad ("[RBTREE] Add explicit alignment to sizeof(long) for
> struct rb_node.") adds an explicit alignment to the struct rb_node due to
> some speciality of the CRIS architecture.
> 
> The support for the CRIS architecture was removed with commit c690eddc2f3b
> ("CRIS: Drop support for the CRIS port")
> 
> So, remove this now unneeded explicit alignment in struct rb_node as well.
> 
> This basically reverts commit e977145aeaad ("[RBTREE] Add explicit
> alignment to sizeof(long) for struct rb_node.").
> 
> The rbtree node color is stored in the LSB of '__rb_parent_color'.
> Only mask the first bit in '__rb_parent()', otherwise it modifies the
> node's parent address on m68k.

I still don't believe for a second this will actually work. We rely on
rcu_assign_pointer() and rcu_dereference() to work on the
rb_{left,right} members, and I don't think any architecture can provide
single copy atomic loads and stores that are not naturally aligned (eg.
when they straddle a cache or page boundary).

