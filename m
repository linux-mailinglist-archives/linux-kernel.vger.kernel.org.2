Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB85A3FBFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbhHaAHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:07:43 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:47148 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhHaAHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:07:42 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKrIV-00HR8r-KE; Tue, 31 Aug 2021 00:06:39 +0000
Date:   Tue, 31 Aug 2021 00:06:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
Message-ID: <YS1yj+mUtvnCab1g@zeniv-ca.linux.org.uk>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de>
 <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx>
 <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
 <YS1OE6FRi4ZwEF8j@zeniv-ca.linux.org.uk>
 <CAHk-=wh57tMaJxcH=kWE4xdKLjayKSDEVvMwHG4fKZ5tUHF6mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh57tMaJxcH=kWE4xdKLjayKSDEVvMwHG4fKZ5tUHF6mg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 03:00:06PM -0700, Linus Torvalds wrote:
> On Mon, Aug 30, 2021 at 2:33 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > There's a place where we care about #PF vs. #MC (see upthread)...
> 
> Interestingly (or perhaps not), that case is a problem case in general
> for "fault_in_pages_readable()".

s/a/the one and only/

> I'm not sure what the right model here is. We might need to make
> fault_in_pages_readable() do things a cacheline at a time, at which
> point those repeat loops start working, and the error code thing
> becomes pointless.

	We really don't want to do that to fault_in_pages_readable();
a separate primitive doing that - perhaps, but fault_in_pages_readable()
is used on fairly hot paths and all callers except this one don't need
anything of that sort.

	Similar for fault_in_pages_writeable() - there's exactly one
caller that needs the same kind of warranties, only there it's in
arch-independent code and I'm fairly sure that it (btrfs ioctl) really
is broken on arm64...
