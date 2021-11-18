Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7444562F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 19:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhKRSzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 13:55:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230446AbhKRSzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:55:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D828461A8A;
        Thu, 18 Nov 2021 18:52:35 +0000 (UTC)
Date:   Thu, 18 Nov 2021 13:52:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Gavin Shan <gshan@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [BUG] WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:493
Message-ID: <20211118135234.0905b6ad@gandalf.local.home>
In-Reply-To: <CAHk-=wj4N=4JsTtXEZi3Hwqao8j-R=HROw=L21+T_28jTyaR=w@mail.gmail.com>
References: <20211012141131.3c9a2eb1@gandalf.local.home>
        <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
        <20211012145540.343541e9@gandalf.local.home>
        <CAHk-=wg6fw130AkO72GPFow9PHvP9odnC5LZ0UaY9bJQuF-C5A@mail.gmail.com>
        <20211022083845.08fe5754@gandalf.local.home>
        <CAHk-=wird-sCbSG3KxNavdD-mFWO1YkT2Qjoeb0Z1Ag4QDNwuA@mail.gmail.com>
        <20211118114746.3329bd33@gandalf.local.home>
        <CAHk-=wj4N=4JsTtXEZi3Hwqao8j-R=HROw=L21+T_28jTyaR=w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 10:33:39 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Gavin, Anshuman? Feel free to tell me what I missed.

Let me know if you would like me to add more debugging. The failure happens
once every few weeks or so.

> 
> Otherwise, we should disable those PUD tests (or fix them, of course).
> 
> For now, I consider this WARN_ON() to be a failure of the testing
> infrastructure, not of the VM code.

For now, I'm just going to comment out those WARN_ON()s in my tests, as it
causes me to have to restart them :-p (I can modify the testing scripts to
restart where it last failed as it is a couple of hours into the tests when
it triggers, but it is still a pain).

-- Steve
