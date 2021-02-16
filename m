Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4331CD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhBPPzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhBPPzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:55:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BDE664D9E;
        Tue, 16 Feb 2021 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613490900;
        bh=KFPdQpy+hKbJ+DnvTlX9CTGk1+OUNb7Jti63BkjZxM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAfSCgtHlR8D3ean5JJ45Nigwu12GAt7lEG4FZivurakw/RU6XWlZIfuAm7GfVRTi
         Z+kq981/hzh6jgx9BfYAKJ2YYrAirwygBVfu0odxzPhyDwRCRCCPwF4nxHL1b4Ult8
         nVIReDkMtnHUO0uXj/pzkuSae1cxiOJqvrRplun8=
Date:   Tue, 16 Feb 2021 16:54:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ftrace: Do not reference symbols in sections without size
Message-ID: <YCvq0hkIvgcKAas2@kroah.com>
References: <20210215164446.530f6311@gandalf.local.home>
 <20210216000504.axm3k4xho47c6drz@treble>
 <20210215200639.67141685@oasis.local.home>
 <20210215210057.4ceb6339@oasis.local.home>
 <YCumppsKxaheg/II@kroah.com>
 <20210216095121.4fe321dc@gandalf.local.home>
 <20210216154539.qac763oef4czrtss@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216154539.qac763oef4czrtss@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 09:45:39AM -0600, Josh Poimboeuf wrote:
> On Tue, Feb 16, 2021 at 09:51:21AM -0500, Steven Rostedt wrote:
> > On Tue, 16 Feb 2021 12:04:06 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > Thanks for this.
> > > 
> > > Should I also queue these up for 4.9 and 4.14 which do not have these
> > > commits in them either (but somehow do not show the problem, yet)?
> >
> > This bothers me. I want to know exactly why this is a problem.
> 
> I actually see the same problem with 4.9 and 4.14, using the same
> config.

Ok, that's good to know.

> It's very config-specific.  Something has to convince the toolchain to
> not reference those two weak functions by section.

I've queued up all 3 patches (Steven collapsed 2 into 1 it seems) for
4.4.y, 4.9.y, and 4.14.y now.

> > That said, it is fine to backport those patches, and I would include 4.9
> > and 4.14, as I would think you have a similar requirement that we have in
> > the stable-rt trees. That is you shouldn't experience a regression going
> > from an older kernel to a newer one because the older one had a fix
> > backported to it that a newer one did not. Basically the same rationale that
> > all fixes go into Linus's tree before backporting. We do the same on the
> > stable-rt, where all fixes go in all maintained stable trees that are newer
> > than the one you are backporting to.
> > 
> > Although, it does allow more to be traced than what recordmcount enables.
> > But hopefully it doesn't cause any issues. Maybe I should do some ftrace
> > testing before you go and release any of those stables with those patches.
> > 
> > I'm looking to see if this new "feature" of binutils isn't causing trouble
> > elsewhere. I'm thinking that ftrace is just the canary here.
> 
> It already caused quite a bit of trouble with objtool (as did a previous
> similar change by the Clang assembler).

I feel like we go through this every major binutils release.  Why isn't
"build the Linux kernel" part of the binutils regression test suite by
now?  :)

thanks,

greg k-h
