Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77276312689
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 19:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBGR7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 12:59:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:43978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhBGR7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 12:59:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96EA8AC88;
        Sun,  7 Feb 2021 17:58:17 +0000 (UTC)
Date:   Sun, 7 Feb 2021 18:58:14 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc7
Message-ID: <20210207175814.GF32127@zn.tnic>
References: <20210207104022.GA32127@zn.tnic>
 <CAHk-=widXSyJ8W3vRrqO-zNP12A+odxg2J2_-oOUskz33wtfqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=widXSyJ8W3vRrqO-zNP12A+odxg2J2_-oOUskz33wtfqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 09:49:18AM -0800, Linus Torvalds wrote:
> On Sun, Feb 7, 2021 at 2:40 AM Borislav Petkov <bp@suse.de> wrote:
> >
> > - Disable CET instrumentation in the kernel so that gcc doesn't add
> > ENDBR64 to kernel code and thus confuse tracing.
> 
> So this is clearly the right thing to do for now, but I wonder if
> people have a plan for actually enabling CET and endbr at cpl0 at some
> point?

It probably is an item on some Intel manager's to-enable list. So far,
the CET enablement concentrates only on userspace but dhansen might know
more about future plans. CCed.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
