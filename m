Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903CA3F6AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 23:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhHXVGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 17:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbhHXVGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 17:06:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91060C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hY99dBj8BXa4nQSsll4zO9lsRBPP5TAkRTfty6KZ8yY=; b=Dt9M/Zu8lbnYVB73K3IdJJ7WSu
        jWA/b8fAj9kjZMp0Wx15Aj4sLuUsmomOJ6bGquJaFHT8r8WbzYuGqoaRhLUNA99STHI6bKjId3Ijr
        /DUdzySByoeqoIcOcE4I61q88nD32EWQXV5mcXu9NsDRITF3niPydRJtEGRf6gBR0byvsNI8S/AJv
        YLKlUQYQwJcQeOV/INUEWS04/Oigy+gsxdnyV1cwKug7X6bLvJ3metfS53R3DIVDvOERa7uD8Lw4N
        zJC31bWQf3p6dCqb605cpGANGmzjeH7z2FVE4nqrw0Mno33G8TVY9/ZbGaQ/3cAvvFMJiD+acPCCX
        XWxoH1Tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIdbY-00ChXp-Cs; Tue, 24 Aug 2021 21:05:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27492981244; Tue, 24 Aug 2021 23:05:07 +0200 (CEST)
Date:   Tue, 24 Aug 2021 23:05:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning in cfg80211_edmg_chandef_valid() with ThinLTO
Message-ID: <20210824210507.GC17784@worktop.programming.kicks-ass.net>
References: <5913cdf4-9c8e-38f8-8914-d3b8a3565d73@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5913cdf4-9c8e-38f8-8914-d3b8a3565d73@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 01:08:58PM -0700, Nathan Chancellor wrote:

> The LLVM developers are under the impression that this is an issue with
> objtool; specifically quoting Eli Friedman:
> 
> "The backend can, in general, create basic blocks that don't contain any
> instructions, and don't fall through to another block. A jump table entry
> can refer to such a block. I guess certain tools could be confused by this.
> 
> If that's the issue, it should be possible to work around it using '-mllvm
> -trap-unreachable'."

So jump-tables are a weak point; ARM64 was having worse problems than
x86 there, they can't even locate them.

As to having a jump-table entry to an empty block and not falling
through; how are we supposed to know? Emitting them is a waste of space,
so I'd say it's a compiler bug :-))

It's been brought up before; but perhaps we should look at an 'informal'
ABI for jump-tables ?
