Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B77242C097
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhJMMyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:54:09 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44223 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232486AbhJMMyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:54:07 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19DCpgUU008104;
        Wed, 13 Oct 2021 14:51:42 +0200
Date:   Wed, 13 Oct 2021 14:51:42 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
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
Message-ID: <20211013125142.GD5485@1wt.eu>
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
 <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <YWbUbSUVLy/tx7Zu@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWbUbSUVLy/tx7Zu@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Wed, Oct 13, 2021 at 02:43:25PM +0200, Borislav Petkov wrote:
> On Wed, Oct 13, 2021 at 05:23:11AM +0700, Ammar Faizi wrote:
> > "Figure 3.4: Register Usage" is not the answer, if it were, nolibc.h
> > would be broken as it is missing "rdi", "rsi", "rdx" in the clobber list.
> 
> It is not about what happens in practice but what the contract is:
> syscall argument registers can potentially get clobbered and userspace
> should treat them as such. Because if the kernel decides to actually
> clobber them for whatever reason and some userspace thing thinks
> otherwise, then it is the userspace thing's problem as it doesn't adhere
> to the well known ABI.

I agree and that's why my question was about that authoritative doc, to
know the contract (since this one will not change under our feet). But
according to the doc you pointed, here the contract for syscalls is that
only rcx and r11 are clobbered (and rax gets the result). If so, I'm
personally fine with this.

Thanks,
Willy
