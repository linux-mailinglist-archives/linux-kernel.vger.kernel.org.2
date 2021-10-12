Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1225C42AD2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 21:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhJLTVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 15:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232486AbhJLTVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 15:21:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DBA360F3A;
        Tue, 12 Oct 2021 19:19:36 +0000 (UTC)
Date:   Tue, 12 Oct 2021 15:19:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Gavin Shan <gshan@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [BUG] WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:493
Message-ID: <20211012151934.0f4aa9f4@gandalf.local.home>
In-Reply-To: <CAHk-=wg6fw130AkO72GPFow9PHvP9odnC5LZ0UaY9bJQuF-C5A@mail.gmail.com>
References: <20211012141131.3c9a2eb1@gandalf.local.home>
        <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
        <20211012145540.343541e9@gandalf.local.home>
        <CAHk-=wg6fw130AkO72GPFow9PHvP9odnC5LZ0UaY9bJQuF-C5A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 12:15:40 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Or it's something specific to your setup, but that sounds unlikely.
> 
> You might add some debugging to the x86 pud_set_huge() function,
> something like the attached (obviously entirely untested) patch.

I'll add this to the patches that get applied before my tests run (which
mostly just disable things unrelated to my code, like i915 warnings :-p)

But my box is continuing its test suite, so I'll add it when it finishes,
and then run more tests to try to trigger it again.

-- Steve
