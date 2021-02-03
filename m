Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4716530D83C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhBCLNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:13:55 -0500
Received: from foss.arm.com ([217.140.110.172]:38002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234093AbhBCLNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:13:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0696DD6E;
        Wed,  3 Feb 2021 03:12:45 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.11.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59F653F719;
        Wed,  3 Feb 2021 03:12:43 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:12:40 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org
Subject: Re: [RFC PATCH 1/5] arm64: Move instruction encoder/decoder under
 lib/
Message-ID: <20210203111240.GB55896@C02TD0UTHF1T.local>
References: <20210120171745.1657762-1-jthierry@redhat.com>
 <20210120171745.1657762-2-jthierry@redhat.com>
 <20210202101755.GB59049@C02TD0UTHF1T.local>
 <9c01f293-2c98-43e6-a497-89610fe5970e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c01f293-2c98-43e6-a497-89610fe5970e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 09:26:45AM +0100, Julien Thierry wrote:
> On 2/2/21 11:17 AM, Mark Rutland wrote:
> > On Wed, Jan 20, 2021 at 06:17:41PM +0100, Julien Thierry wrote:
> > > Aarch64 instruction set encoding and decoding logic can prove useful
> > > for some features/tools both part of the kernel and outside the kernel.
> > > 
> > > Isolate the function dealing only with encoding/decoding instructions,
> > > with minimal dependency on kernel utilities in order to be able to reuse
> > > that code.
> > > 
> > > Code was only moved, no code should have been added, removed nor
> > > modifier.
> > > 
> > > Signed-off-by: Julien Thierry <jthierry@redhat.com>
> > 
> > This looks sound, but the diff is a little hard to check.
> 
> Yes, I was expecting this change to be hard to digest.
> 
> > Would it be possible to split this into two patches, where:
> > 
> > 1) Refactoring definitions into insn.h and insn.c, leaving those files
> >     in their current locations.
> 
> I'm not quite sure I understand the suggestions. After this patch insn.h and
> insn.c still contain some definitions that can't really be used outside of
> kernel code which is why I split them into insn.* and aarch64-insn.* (the
> latter containing what could be used by tools).

Sorry; I hadn't appreciated what was getting left behind. With the
series applied I see that's some kernel patching logic, and AArch32 insn
bits.

How about we invert the move, and split those bits out of insn.c first,
then move the rest in one go, i.e.

1) Factor the patching bits out into new patching.{c,h} files.

2) Move insn.c to arch/arm64/lib/

3) Split insn.* into aarch64-insn.* and aarch32-insn.*

... if that makes any sense?

We might not even need to split the aarch32 bits out given they all have
an aarch32_* prefix.

> > 2) Moving insn.h and insn.c out to arch/arm64/lib/, updating includes
> > > With that, the second patch might be easier for git to identify as a
> > rename (if using `git format-patch -M -C`), and it'd be easier to see
> > that there are no unintended changes.
> 
> But it is more a split than a rename (at least in this patch). But I'm happy
> to do this in another way.

I think the above suggestion might solve that, unless I've missed
something?

Thanks,
Mark.
