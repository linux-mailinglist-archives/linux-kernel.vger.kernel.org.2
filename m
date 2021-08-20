Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C203F3230
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhHTRZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:25:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:47018 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233256AbhHTRZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:25:00 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17KHIkfB024178;
        Fri, 20 Aug 2021 12:18:46 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17KHIjOe024175;
        Fri, 20 Aug 2021 12:18:45 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 20 Aug 2021 12:18:45 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: indirect function call use bctrl rather than blrl in ret_from_kernel_thread
Message-ID: <20210820171845.GS1583@gate.crashing.org>
References: <91b1d242525307ceceec7ef6e832bfbacdd4501b.1629436472.git.christophe.leroy@csgroup.eu> <871r6oe2i8.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r6oe2i8.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 10:15:11PM +1000, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > Copied from commit 89bbe4c798bc ("powerpc/64: indirect function call
> > use bctrl rather than blrl in ret_from_kernel_thread")
> >
> > blrl is not recommended to use as an indirect function call, as it may
> > corrupt the link stack predictor.
> 
> Do we know if any 32-bit CPUs have a link stack predictor or similar?

74xx do.


Segher
