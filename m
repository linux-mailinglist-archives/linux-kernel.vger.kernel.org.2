Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D679942C319
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhJMO3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbhJMO3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:29:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 898E260ED4;
        Wed, 13 Oct 2021 14:27:18 +0000 (UTC)
Date:   Wed, 13 Oct 2021 10:27:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Gavin Shan <gshan@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [BUG] WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:493
Message-ID: <20211013102716.4a7c3800@gandalf.local.home>
In-Reply-To: <40dd8b91-7f4f-0f5f-bf15-504c0960c802@arm.com>
References: <20211012141131.3c9a2eb1@gandalf.local.home>
        <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
        <40dd8b91-7f4f-0f5f-bf15-504c0960c802@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 09:40:11 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> I have run this test on x86 platform many times before (although not recently)
> without any problem and never had this bug report before. Wondering if there
> are recent changes on x86 platform, causing these warning.

As noticed in my conversation with Linus, this warning was there before
your updates, as it was in 5.14-rc2.

> 
> Gavin,
> 
> Although unlikely, was there something on the series which might have
> changed pud_huge_tests() ?

Not sure. But my test box that triggers this is open now, and I'll add
Linus's debug patch and see if I can retrigger it.

-- Steve
