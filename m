Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737573628D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbhDPToo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhDPToh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:44:37 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 12:44:12 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXUNq-005q1X-4h; Fri, 16 Apr 2021 19:44:06 +0000
Date:   Fri, 16 Apr 2021 19:44:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
Message-ID: <YHnpBm36PcIINhWi@zeniv-ca.linux.org.uk>
References: <20210416192413.1514419-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416192413.1514419-1-eric.dumazet@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 12:24:13PM -0700, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> We have to loop only to copy u64 values.
> After this first loop, we copy at most one u32, one u16 and one byte.

Does it actually yield a better code?

FWIW, this
void bar(unsigned);
void foo(unsigned n)
{
	while (n >= 8) {
		bar(n);
		n -= 8;
	}
	while (n >= 4) {
		bar(n);
		n -= 4;
	}
	while (n >= 2) {
		bar(n);
		n -= 2;
	}
	while (n >= 1) {
		bar(n);
		n -= 1;
	}
}

will compile (with -O2) to
        pushq   %rbp
        pushq   %rbx
        movl    %edi, %ebx
        subq    $8, %rsp
        cmpl    $7, %edi
        jbe     .L2
        movl    %edi, %ebp
.L3:
        movl    %ebp, %edi
        subl    $8, %ebp
        call    bar@PLT
        cmpl    $7, %ebp
        ja      .L3
        andl    $7, %ebx
.L2:
        cmpl    $3, %ebx
        jbe     .L4
        movl    %ebx, %edi
        andl    $3, %ebx
        call    bar@PLT
.L4:
        cmpl    $1, %ebx
        jbe     .L5
        movl    %ebx, %edi
        andl    $1, %ebx
        call    bar@PLT
.L5:
        testl   %ebx, %ebx
        je      .L1
        addq    $8, %rsp
        movl    $1, %edi
        popq    %rbx
        popq    %rbp
        jmp     bar@PLT
.L1:
        addq    $8, %rsp
        popq    %rbx
        popq    %rbp
        ret

i.e. loop + if + if + if...
