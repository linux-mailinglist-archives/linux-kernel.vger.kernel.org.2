Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3CE430FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 07:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhJRFzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 01:55:36 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44362 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhJRFze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 01:55:34 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19I5qawh016132;
        Mon, 18 Oct 2021 07:52:36 +0200
Date:   Mon, 18 Oct 2021 07:52:36 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from
 the clobber list
Message-ID: <20211018055236.GA15718@1wt.eu>
References: <20211013090339.622070-1-ammar.faizi@students.amikom.ac.id>
 <dRLArKzRMqajy1jA86k0vg-ammarfaizi2@gnuweeb.org>
 <69kbMOkWb6SB69o0ulPlhA-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69kbMOkWb6SB69o0ulPlhA-ammarfaizi2@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 03:25:06PM +0700, Ammar Faizi wrote:
> Linux x86-64 syscall only clobbers rax, rcx and r11 (and "memory").
> 
>   - rax for the return value.
>   - rcx to save the return address.
>   - r11 to save the rflags.
(...)

Now queued, thank you Ammar. I'll pass the series to Paul once we're
done with the remaining patches.

Willy
