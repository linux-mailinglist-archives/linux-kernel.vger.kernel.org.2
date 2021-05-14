Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0BA380708
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhENKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:19:11 -0400
Received: from foss.arm.com ([217.140.110.172]:46566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232983AbhENKTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:19:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2BA5169E;
        Fri, 14 May 2021 03:17:57 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.0.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89D813F719;
        Fri, 14 May 2021 03:17:50 -0700 (PDT)
Date:   Fri, 14 May 2021 11:17:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org, aou@eecs.berkeley.edu,
        arnd@arndb.de, bcain@codeaurora.org, benh@kernel.crashing.org,
        chris@zankel.net, dalias@libc.org, davem@davemloft.net,
        deanbo422@gmail.com, deller@gmx.de, geert@linux-m68k.org,
        green.hu@gmail.com, guoren@kernel.org, ink@jurassic.park.msu.ru,
        James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com,
        jonas@southpole.se, ley.foon.tan@intel.com, linux@armlinux.org.uk,
        mattst88@gmail.com, monstr@monstr.eu, mpe@ellerman.id.au,
        nickhu@andestech.com, palmer@dabbelt.com, paulus@samba.org,
        paul.walmsley@sifive.com, rth@twiddle.net,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@synopsys.com, ysato@users.sourceforge.jp
Subject: Re: [PATCH 05/33] locking/atomic: openrisc: avoid
 asm-generic/atomic.h
Message-ID: <20210514101741.GA30645@C02TD0UTHF1T.local>
References: <20210510093753.40683-1-mark.rutland@arm.com>
 <20210510093753.40683-6-mark.rutland@arm.com>
 <YJ2dud8alZgKmiQ3@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ2dud8alZgKmiQ3@antec>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 06:44:25AM +0900, Stafford Horne wrote:
> On Mon, May 10, 2021 at 10:37:25AM +0100, Mark Rutland wrote:
> > OpenRISC is the only architecture which uses asm-generic/atomic.h and
> > also provides its own implementation of some functions, requiring
> > ifdeferry in the asm-generic header. As OpenRISC provides the vast
> > majority of functions itself, it would be simpler overall if it also
> > provided the few functions it cribs from asm-generic.
> > 
> > This patch decouples OpenRISC from asm-generic/atomic.h. Subsequent
> > patches will simplify the asm-generic implementation.
> 
> This is fine, but just a thought.  If OpenRISC is the only architecture to do
> this then after this patch could we remove the ifndefs from
> asm-generic/atomic.h as additional cleanup?

Yup! That's done in patch 8. :)

I'll expand the wording in this commit message to explicitly mention
that subsequent patches will remove the ifdeferry, rather than just
simplfying the asm-generic implementation.

[...]

> Acked-by: Stafford Horne <shorne@gmail.com>

Thanks!

Mark.
