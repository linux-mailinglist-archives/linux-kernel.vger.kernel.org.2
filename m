Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D0543330B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhJSKEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhJSKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:04:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E42C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7FVsVPuYzpGnNLbgwSWp+79QwvjsSfjv5RyJ2RaDOtk=; b=iQ0TCCGCGOMXs3ID/bkI47EG29
        m5en2wbluE7VFJ2b4TynGwVpRllt8P9d4ONtfIdkhl4KN4GUIybmOliUiuwfstPt9n0yPk0vrUu4A
        07cufqFB4lbGQgGtDTqN253KF9yQglheS+8CKPQhdsHv8tfYOMkNmmXGXryydHXeW9DPMygQDQSZQ
        GDBQXJTX+SYO+SBz222VxMVVAYbgzgFCBM/LN/072JRnSi3CnUkLypExUO3h3ZtWTKQnIbcxCN+1s
        PWwG2uwoHYF15AEd8dxuDSngRPlCCpahXXl2RfcKihW403VUHnz3DlbjLXUtdc6oiA0q+yQyIiTz5
        rRJs1XYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mclwp-00Akm6-6v; Tue, 19 Oct 2021 10:02:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7CEB830024D;
        Tue, 19 Oct 2021 12:02:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64B2721BE9697; Tue, 19 Oct 2021 12:02:18 +0200 (CEST)
Date:   Tue, 19 Oct 2021 12:02:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YW6XqiOkWG/avY29@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <YWmPCF+g+sF4+ieh@zn.tnic>
 <20211015165635.GH174703@worktop.programming.kicks-ass.net>
 <20211018225905.86034-1-alobakin@pm.me>
 <YW6SqH1R7stXk2GG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW6SqH1R7stXk2GG@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 11:40:56AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 18, 2021 at 11:06:35PM +0000, Alexander Lobakin wrote:

> > WARN in patch_retpoline:408: addr pcibios_scan_specific_bus+0x196/0x200, op 0xe8, reg 0xb88ca
> > WARN in patch_retpoline:408: addr xen_pv_teardown_msi_irqs+0x8d/0x120, op 0xe8, reg 0xb88ca
> > WARN in patch_retpoline:408: addr __mptcp_sockopt_sync+0x7e/0x200, op 0xe8, reg 0xb88ca
> > [...]
> > (thousands of them, but op == 0xe8 && reg == 0xb88ca are always the same)
> > 
> > I know this reg calculation is about to be replaced, but anyway ;)
> 
> Well, I was sorta hoping to keep that with something like:
> 
>   https://lkml.kernel.org/r/YWgA+vbWCdGLZhq5@hirez.programming.kicks-ass.net
> 
> Anyway, let me try and reproduce.

Using: make O=defconfig CC=clang-13 -j80 -s

( is actually defconfig+kvm_guest.config,
  and clang-13 from debian/testing )

on https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core

It seems to 'just' work:

spectre_v2=retpoline,amd:

gets me two very sad and lonely replacements:

 [] SMP alternatives: retpoline at: 0xffffffff82e764b4 (ffffffff82e764b4) len: 5 to: __x86_indirect_thunk_rbx+0x0/0x20
 [] SMP alternatives: ffffffff82e764b4: orig: e8 07 d3 18 ff
 [] SMP alternatives: ffffffff82e764b4: repl: 0f ae e8 ff d3

 [] SMP alternatives: retpoline at: 0xffffffff82e76f39 (ffffffff82e76f39) len: 5 to: __x86_indirect_thunk_rdi+0x0/0x20
 [] SMP alternatives: ffffffff82e76f39: orig: e8 02 c9 18 ff
 [] SMP alternatives: ffffffff82e76f39: repl: 0f ae e8 ff d7

The rest is R11 and therefore doesn't actaully fit.

For spectre_v2=off everything gets replaced, and that also seems happy.

 [] SMP alternatives: retpoline at: pm_check_save_msr+0x24/0x30 (ffffffff81d2ef24) len: 5 to: __x86_indirect_thunk_r11+0x0/0x20
 [] SMP alternatives: ffffffff82603eb0: [3:5) optimized NOPs: 41 ff d3 66 90
 [] SMP alternatives: ffffffff81d2ef24: orig: e8 97 49 2d 00
 [] SMP alternatives: ffffffff81d2ef24: repl: 41 ff d3 66 90
