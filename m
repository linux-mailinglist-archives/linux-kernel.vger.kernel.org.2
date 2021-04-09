Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44DA35A50E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhDIR5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:57:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:54049 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234409AbhDIR5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:57:48 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 139HjBG4002289;
        Fri, 9 Apr 2021 12:45:11 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 139Hj6hE002280;
        Fri, 9 Apr 2021 12:45:06 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 9 Apr 2021 12:45:06 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Xiongwei Song <sxwjean@me.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, oleg@redhat.com,
        npiggin@gmail.com, aneesh.kumar@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, mikey@neuling.org,
        haren@linux.ibm.com, akpm@linux-foundation.org, rppt@kernel.org,
        jniethe5@gmail.com, atrajeev@linux.vnet.ibm.com,
        maddy@linux.ibm.com, peterz@infradead.org, kjain@linux.ibm.com,
        kan.liang@linux.intel.com, aik@ozlabs.ru, alistair@popple.id.au,
        pmladek@suse.com, john.ogness@linutronix.de,
        Xiongwei Song <sxwjean@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/traps: Enhance readability for trap types
Message-ID: <20210409174506.GH26583@gate.crashing.org>
References: <20210408140750.26832-1-sxwjean@me.com> <70ece993-12bd-335c-d246-914564eb51dd@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70ece993-12bd-335c-d246-914564eb51dd@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 06:14:19PM +0200, Christophe Leroy wrote:
> >+#define INTERRUPT_SYSTEM_RESET    0x100
> 
> INT_SRESET

SRESET exists on many PowerPC, it means "soft reset".  Not the same
thing at all.

I think "INT" is not a great prefix fwiw, there are many things you can
abbr to "INT".

> >+#define INTERRUPT_DATA_SEGMENT    0x380
> 
> INT_DSEG

exceptions-64s.S calls this "DSLB" (I remember "DSSI" though -- but neither
is a very official name).  It probably is a good idea to look at that
existing code, not make up even more new names :-)

> >+#define INTERRUPT_DOORBELL        0xa00
> 
> INT_DBELL

That saves three characters and makes it very not understandable.


Segher
