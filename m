Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8483A337F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 20:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFJSqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFJSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:46:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Av0VDrjTWxCk/CljDRNDCub1sCxNvQ1GxDN3sYJG65M=; b=niWX7k/KRIxm8S3HH4i6O4aGTh
        cv+FlKwCelbEa3wtyOp78bLtmKd6uQBKRhvaxuPNFXRVuvWstyN9GgjBzrUM0Uwz1vRdsrhXrYR2b
        gI1UPvTT9Rykh9x1rfONypIpK0/BVD7JTLHLE5MTBUh7JHBZs37eIv/B9LYNO8PC0f4OoOWsWPQ40
        fk2X/eIC0uZTLfQwXbCWZLBEzTVtJf/2JyC0McXV61Ikb9O/wDrrdvWYiFHrWBhrdeVASUoIl7ptN
        /V/m2moTeLh0SofgoOKuKaX5WefIWmIyzkUrjFMIswcMTDyXXQBQM9ZtMtsSiK30C98f/aT59hUOJ
        zGVGFHjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lrPec-001wgL-Js; Thu, 10 Jun 2021 18:43:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 603AA3001E3;
        Thu, 10 Jun 2021 20:43:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4078520299B51; Thu, 10 Jun 2021 20:43:45 +0200 (CEST)
Date:   Thu, 10 Jun 2021 20:43:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, linux-kernel@vger.kernel.org,
        samitolvanen@google.com, ndesaulniers@google.com,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 01/13] objtool: Rewrite hashtable sizing
Message-ID: <YMJdYdCR0vD2t2WC@hirez.programming.kicks-ass.net>
References: <20210506193352.719596001@infradead.org>
 <20210506194157.452881700@infradead.org>
 <YMJWmzXgSipOqXAf@DESKTOP-1V8MEUQ.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMJWmzXgSipOqXAf@DESKTOP-1V8MEUQ.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:14:51AM -0700, Nathan Chancellor wrote:

> This patch as commit 25cf0d8aa2a3 ("objtool: Rewrite hashtable sizing")
> in -tip causes a massive compile time regression with allmodconfig +
> ThinLTO.

Moo... the allyesconfig builds I used it on were much faster, but that
was on regular GCC vmlinux.o after linking.

> Adding Sami because I am not sure why this patch would have much of an impact
> in relation to LTO. https://git.kernel.org/tip/25cf0d8aa2a3 is the patch in
> question.
> 
> If I can provide any further information or help debug, please let me know.
> 
> If you are interested in reproducing this locally, you will need a
> fairly recent LLVM stack (I used the stable release/12.x branch) and to
> cherry-pick commit 976aac5f8829 ("kcsan: Fix debugfs initcall return
> type") to fix an unrelated build failure. My script [2] can build a
> self-contained toolchain fairly quickly if you cannot get one from your
> package manager. A command like below will speed up the build a bit:

Would something like llvm-13 from Debian be good enough?

$ clang-13 --version
Debian clang version 13.0.0-++20210418105309+a0898f0cecc7-1~exp1
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
