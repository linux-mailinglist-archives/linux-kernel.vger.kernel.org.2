Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B45C36531A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 09:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhDTHVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 03:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhDTHU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:20:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42128C06174A;
        Tue, 20 Apr 2021 00:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PheP7FkRkfVSr8ZX7xF4EBpL6tBzEmE1WwGIjQKRjck=; b=MlFnyvGuYfRB5voeWZclqd8+WZ
        QMJj4O47xyDn97sTMf4JV8dTagTauHTEYf03SYqb8BzcOVdwPydVPg5aH0Xz2qs008Pwgu0gyLU5F
        tfL83ZWpkkDNcnD5xj3cS/+tN1vomc7N+0fvzczOyEQY7CAO46wS3SiHOmRfWExWTparZGFyOdu1K
        NYsKIm9/e2E3DiRqUB1sYRLkBzdmVSCNPZSGWShVExYuolTUbSkD4HVyIizyuuJWvm9lWWzjxmC30
        1N+8muIWbJUjgIjz5GcmbXILZ0ABZ5WPn06aYl8k9W4VzSXbW54yWyV1Sdjrawq1sPt6qCPoWqemi
        HMtFiIAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYkf4-00EqqF-Fo; Tue, 20 Apr 2021 07:19:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA93F30013E;
        Tue, 20 Apr 2021 09:19:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5BAF2CEB52BC; Tue, 20 Apr 2021 09:19:04 +0200 (CEST)
Date:   Tue, 20 Apr 2021 09:19:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 09/15] x86/alternatives: Use C int3 selftest but disable
 KASAN
Message-ID: <YH6AaBY5A+x2pmqI@hirez.programming.kicks-ass.net>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-10-samitolvanen@google.com>
 <YHrIc0L5AQukw525@hirez.programming.kicks-ass.net>
 <CABCJKuevfuVbKZPtLrFacXZLk+VtbFgebbyLeK8Xxe7Z3YmwQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuevfuVbKZPtLrFacXZLk+VtbFgebbyLeK8Xxe7Z3YmwQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 08:26:36AM -0700, Sami Tolvanen wrote:
> On Sat, Apr 17, 2021 at 4:37 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > The problem is that the call-site does not respect the regular calling
> > convention, so calling a regular C function is just asking for trouble,
> > which is why it ended up being asm, then we fully control the calling
> > convention.
> 
> Ack. The problem here is that we can't declare an extern static
> function in C. How would you feel about making int3_magic a global
> instead to match the C declaration?

Works for me.
