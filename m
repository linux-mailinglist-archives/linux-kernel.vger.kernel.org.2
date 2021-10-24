Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06394388A8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhJXLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 07:44:54 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44493 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229867AbhJXLox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 07:44:53 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19OBfg7F014001;
        Sun, 24 Oct 2021 13:41:42 +0200
Date:   Sun, 24 Oct 2021 13:41:42 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86-ml <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>
Subject: Re: [PATCHSET v2 0/2] tools/nolibc: Fix startup code bug and small
 improvement
Message-ID: <20211024114142.GA13494@1wt.eu>
References: <20211023134323.GA5881@1wt.eu>
 <20211024020616.395038-1-ammarfaizi2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024020616.395038-1-ammarfaizi2@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 09:11:30AM +0700, Ammar Faizi wrote:
> Hi Willy,
> This is a patchset v2, there are 2 patches in this series.
> 
> [PATCH 1/2] is a bug fix. Thanks to Peter who reported the bug, fixed
> in [PATCH 1/2] by me.
> 
> [PATCH 2/2] is just a small improvement to minimize code size, no
> functional changes.
> 
> Detailed explanation in the commit message.
> Please review!

Many thanks Ammar, both look good, I've queued them and am now reviewing
the ABI and code for other archs in case I did the same mistake for the
alignment at other places (i386 comes to mind).

I'll also have a look at the exit calls your mentioned.

Thanks!
Willy
