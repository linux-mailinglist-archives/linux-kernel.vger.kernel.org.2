Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D5442CD9D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhJMWPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhJMWPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:15:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76B5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EWaTJUUpatS09XDZQ1dQh5D8/b7V8Zk8ePbKnUtgH+g=; b=FLbqjvga786CmsPEv3PlJ00Z6K
        582hmG4k0dcADtjzgo447grZZtGfObUOA2ght/328SNwhq1H3GTim51LyQv1HwsBKuGNqUwXTjFch
        xHGNwjz9FfpJNIK8xfSlb/tFUSCaAU3nC1Rc8phK0BYRYXJvXRUaGCPypyut0oiORUkgJYQbVNJ6A
        tVEyvtvxF+/4ju8V4Dgk/SAREL4ZM8NdlBkzmMMaxzY9c6kPY8pu7g34hfnSkjSLlH8CQ80ZFjdvQ
        PqKA3qPdiIt02/nbAsuURF+UDcyzRWMDj0oATLww5AHf5z43g0kMhDrwSTnpqtxtEnJWW6J82dSTj
        I42h/u0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mamSb-007qEU-Lo; Wed, 13 Oct 2021 22:11:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BFAF30030B;
        Thu, 14 Oct 2021 00:10:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CA36212B3C88; Thu, 14 Oct 2021 00:10:53 +0200 (CEST)
Date:   Thu, 14 Oct 2021 00:10:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YWdZbdo1fVd7JbBA@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013203927.zbruy2ux7dug6ljk@treble>
 <YWdNgt47MhYTttux@hirez.programming.kicks-ass.net>
 <20211013214907.pqr3mr2m4xrh426y@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013214907.pqr3mr2m4xrh426y@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:49:07PM -0700, Josh Poimboeuf wrote:
> So you've got a WARN_ON_ONCE, a BUG_ON, and a too-deep feature check,
> all in the name of supporting this scheme.  ok...

Mostly because I'm way too lazy to type out that table. With the thunks
being in .S, I really don't see that getting messed up, they even in
their own special section too.

> If performance of the linear lookup were a real concern then you could
> just put rax and r11 at the beginning of the array.

That would mean the table would have to be { __thunk, reg_idx }, which
is even more yuck.
