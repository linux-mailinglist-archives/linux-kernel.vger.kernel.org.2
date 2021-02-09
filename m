Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FC4314BE7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhBIJku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhBIJhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:37:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F48FC06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pKuqYN0adcqK1zSAgBcXljgM9Ed6YIRcmlCJKNvvk4o=; b=Iyqk2zQO41TwUEcir4bjsDLLsL
        Mpgf6TLmM6NwIikXO+Tl3B+7CYPwxfe1ogG+gnfF/W/24XPusJp87b8jacwbuyBT6ffjXHnrueZYP
        lsFCMMj/FNu8W3PGUINE5x0bVXd6QfRHAqnVFlLM6noYU2joiVXyMC56vWzIEBVC9iixg+t7HWhA6
        u0hfuaIDMXTvWbus33qFjrhc818n2hNS/pknHQYnnEL6BB/gQt1/OREw6ITXPerNP27Lsnyx3z7Qr
        AinMBdp8tLWMvjpKCgmzdtxnvaKQJku+rq4BWYaLv8jzcx1pFfeWTIH05W9/sXynd/0pPl3LncXMe
        kkjkEXzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9PRc-0005wz-RK; Tue, 09 Feb 2021 09:36:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 748E33010D2;
        Tue,  9 Feb 2021 10:36:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 61F442BB568DB; Tue,  9 Feb 2021 10:36:25 +0100 (CET)
Message-ID: <20210209091600.075402197@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 09 Feb 2021 10:16:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 0/3] objtool: Support the stack swizzle
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Implement objtool support for the x86_64 stack swizzle pattern.

This means we can use the minial stack swizzle:

  mov %rsp, (%[tos])
  mov %[tos], %rsp
  ...
  pop %rsp

from inline asm, with arbitrary stack setup. The ORC data for the Top-of-Stack
will use the SP_INDIRECT CFA base. In order for this to work, SP_INDIRECT needs
to first dereference and then add the offset to find the next frame.

Therefore we need to change SP_INDIRECT (which is currently unused) to mean:
(%rsp) + offset.

Changes since v1 include:

 - removed the !callee saved reg restriction by using the vals[] array
   over the regs[] array.

 - per the above, removed the patches creating the regs[] scratch space.

 - more comments.

 - rebased to tip/objtool/core

