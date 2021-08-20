Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465A53F32EC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbhHTSRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:17:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:48381 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhHTSRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:17:52 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17KIC27u027695;
        Fri, 20 Aug 2021 13:12:02 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17KIC1p7027690;
        Fri, 20 Aug 2021 13:12:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 20 Aug 2021 13:12:01 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: indirect function call use bctrl rather than blrl in ret_from_kernel_thread
Message-ID: <20210820181201.GT1583@gate.crashing.org>
References: <91b1d242525307ceceec7ef6e832bfbacdd4501b.1629436472.git.christophe.leroy@csgroup.eu> <871r6oe2i8.fsf@mpe.ellerman.id.au> <20210820171845.GS1583@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820171845.GS1583@gate.crashing.org>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 12:18:45PM -0500, Segher Boessenkool wrote:
> On Fri, Aug 20, 2021 at 10:15:11PM +1000, Michael Ellerman wrote:
> > Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > > Copied from commit 89bbe4c798bc ("powerpc/64: indirect function call
> > > use bctrl rather than blrl in ret_from_kernel_thread")
> > >
> > > blrl is not recommended to use as an indirect function call, as it may
> > > corrupt the link stack predictor.
> > 
> > Do we know if any 32-bit CPUs have a link stack predictor or similar?
> 
> 74xx do.

7450 and later, that is.  Will I ever get that right, sigh.


Segher
