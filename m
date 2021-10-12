Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C47742A0B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhJLJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:09:03 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44171 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235868AbhJLJI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:08:58 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19C96crM030348;
        Tue, 12 Oct 2021 11:06:38 +0200
Date:   Tue, 12 Oct 2021 11:06:38 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Message-ID: <20211012090638.GD28951@1wt.eu>
References: <20211012052822.GA28951@1wt.eu>
 <20211012083644.543775-1-ammarfaizi2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012083644.543775-1-ammarfaizi2@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 03:36:44PM +0700, Ammar Faizi wrote:
> I have tried to search for the documentation about this one, but I
> couldn't find any. Checking at `Documentation/x86/entry_64.rst`, but
> it doesn't tell anything relevant.
(...)

OK thanks for the detailed story, thus I didn't miss any obvious
reference.

> My stance comes from SO, Telegram group discussion, and reading source
> code. Therefore, I don't think I can attach the link to it as
> "authoritative information". Or can I?

You're right, that's not exactly what we can call authoritative :-)

> When I sent this patch, I also added entry_64.S's maintainers to CC
> list. In hope they can help to at least acknowledge it. Mainly because
> I can't find the documentation from Linux that tells about this.
> 
> Andy, Thomas, Ingo, Borislav, H. Peter.
> 
> Could one of you shed some light so that I can attach the link to your
> message in the commit message?

Let's indeed wait for any of the x86 maintainers to confirm your
analysis.

Thanks!
Willy
