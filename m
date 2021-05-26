Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC6739122C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhEZIVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhEZIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:21:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1B7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aIG/lxZzNJNz2zKk7jYKdhX5Sw8rrTPiZTs6Kmx1w0A=; b=uNCYV7F/LGYhqb2Yq3tH5aQmjb
        wdK0js6ixyrzKKI8uUxg7Qm3oGH+8V72dCQsHjwJFJyAKMonz8lfGfRgaEARIcWTsfFyNuE462dJD
        cffN7gHIB7lOi0PVV5xkOa9Ns3mW02GT5domLFCyaSY82LlFIXgrrE6SJL2UBgd7JrJ+SBSvdExY0
        t2x2SfOkDQMSk7D1CPYPloGpHNM4y0TF8Ks1v9StCEBZYEc4VYGRJ/QiD9XkkVv77RRqQhlBox4Qu
        KCfC9/S6g/vG0lrAn1Z9kBtOogmcVMVLDUxU6Q1YM20tX1lHJuQBlQ8n+k4vXcyPkkFwOISpQWJnK
        JG+tpuDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lloks-004JaZ-QZ; Wed, 26 May 2021 08:19:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4DA7300242;
        Wed, 26 May 2021 10:19:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2BA8202492E9; Wed, 26 May 2021 10:19:04 +0200 (CEST)
Date:   Wed, 26 May 2021 10:19:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, keescook@chromium.org,
        akpm@linux-foundation.org, will@kernel.org, ardb@kernel.org,
        luc.vanoostenryck@gmail.com, nivedita@alum.mit.edu,
        masahiroy@kernel.org, samitolvanen@google.com, arnd@arndb.de,
        clang-built-linux@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] kcov: add __no_sanitize_coverage to fix noinstr for all
 architectures
Message-ID: <YK4EeMhKUWQ9E92H@hirez.programming.kicks-ass.net>
References: <20210525175819.699786-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525175819.699786-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 07:58:19PM +0200, Marco Elver wrote:
> Until now no compiler supported an attribute to disable coverage
> instrumentation as used by KCOV.
> 
> To work around this limitation on x86, noinstr functions have their
> coverage instrumentation turned into nops by objtool. However, this
> solution doesn't scale automatically to other architectures, such as
> arm64, which are migrating to use the generic entry code.
> 
> Clang [1] and GCC [2] have added support for the attribute recently.
> [1] https://github.com/llvm/llvm-project/commit/280333021e9550d80f5c1152a34e33e81df1e178
> [2] https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=cec4d4a6782c9bd8d071839c50a239c49caca689
> 
> Add __no_sanitize_coverage for both compilers, and add it to noinstr.
> 
> Signed-off-by: Marco Elver <elver@google.com>

W00t! Thanks guys!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

