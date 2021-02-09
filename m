Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8531315318
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhBIPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:45:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:49660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232561AbhBIPpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:45:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 990B3AD57;
        Tue,  9 Feb 2021 15:45:07 +0000 (UTC)
Date:   Tue, 9 Feb 2021 16:45:07 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] objtool: Support the stack swizzle
In-Reply-To: <20210209091600.075402197@infradead.org>
Message-ID: <alpine.LSU.2.21.2102091644240.31501@pobox.suse.cz>
References: <20210209091600.075402197@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021, Peter Zijlstra wrote:

> Hi!
> 
> Implement objtool support for the x86_64 stack swizzle pattern.
> 
> This means we can use the minial stack swizzle:
> 
>   mov %rsp, (%[tos])
>   mov %[tos], %rsp
>   ...
>   pop %rsp
> 
> from inline asm, with arbitrary stack setup. The ORC data for the Top-of-Stack
> will use the SP_INDIRECT CFA base. In order for this to work, SP_INDIRECT needs
> to first dereference and then add the offset to find the next frame.
> 
> Therefore we need to change SP_INDIRECT (which is currently unused) to mean:
> (%rsp) + offset.
> 
> Changes since v1 include:
> 
>  - removed the !callee saved reg restriction by using the vals[] array
>    over the regs[] array.
> 
>  - per the above, removed the patches creating the regs[] scratch space.
> 
>  - more comments.
> 
>  - rebased to tip/objtool/core

I haven't tested it, but it all looks good to me.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
