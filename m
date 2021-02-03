Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C01730D97B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhBCMFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbhBCMF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:05:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B938BC061788
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=x6XqPpYo5MHKtixtEwpX7gUQl3bYQytMY7ahqtvkiwA=; b=2YkIauJMEd8IkBdVE8lNf4DElN
        yAyR1djJVdjzaHHT/a6yWzuO/08R92DPt4WpfIKMX+PNtMoTAAJQFq3DYXVilyZzM3LKA6lofm3qT
        ksIwy3jO/cmkvrFqHvyTrbALkIrEaHHtQ37MgbK4heIJnv2BvUI1bI/lTSUH+3VKAB+pFWBOjWj1S
        DM4KH3tdUlOV78OJz/+a88Zq875xga9Vvv86pFzAL3J1FibLn0zhfupes4/4QwAJo92hbCc2PPJbx
        ds/rXWUcthG6UA/7gRhWme497e+lFDY2J9G8dPCi8HWhUIjP1x0QDUF3ehdHTCs0wQh5JvdN0JKdI
        Pu8AIXDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7Gtl-0007gs-Hn; Wed, 03 Feb 2021 12:04:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 581B030066E;
        Wed,  3 Feb 2021 13:04:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4A5C82BD45B68; Wed,  3 Feb 2021 13:04:40 +0100 (CET)
Message-ID: <20210203120222.451068583@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 13:02:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 0/5] objtool: The stack swizzle again
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The stack swizzle is current again, these patches implement objtool support for
the native x86_64 stack swizzle pattern.

It allows Thomas to use his preferred minimal stack swizzle without (much)
limitations.

We used to use SP_INDIRECT with hints back before the entry code rewrite, the
current code relies on asm with a frame-pointer setup, but that all needs to
change again.

Avoid the hint abuse and detect the pattern directly.


