Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D6F42C669
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhJMQcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:32:45 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44259 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhJMQcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:32:41 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19DGUNSB009348;
        Wed, 13 Oct 2021 18:30:23 +0200
Date:   Wed, 13 Oct 2021 18:30:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Michael Matz <matz@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Message-ID: <20211013163023.GD8557@1wt.eu>
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
 <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <YWbUbSUVLy/tx7Zu@zn.tnic>
 <20211013125142.GD5485@1wt.eu>
 <YWbZz7gHBV18QJC3@zn.tnic>
 <20211013140723.GE5485@1wt.eu>
 <YWbrR1BqI1CxneN/@zn.tnic>
 <20211013142433.GB8557@1wt.eu>
 <alpine.LSU.2.20.2110131601000.26294@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.2110131601000.26294@wotan.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

On Wed, Oct 13, 2021 at 04:24:28PM +0000, Michael Matz wrote:
(...)
> In short:  Ammars initial claim:
> 
> > Linux x86-64 syscall only clobbers rax, rcx and r11 (and "memory").
> > 
> >   - rax for the return value.
> >   - rcx to save the return address.
> >   - r11 to save the rflags.
> > 
> > Other registers are preserved.
> 
> is accurate and I will clarify the psABI to make that explicit.

Many thanks for this very detailed explanation! Ammar, I'll take your
patch.

Thanks all,
Willy
