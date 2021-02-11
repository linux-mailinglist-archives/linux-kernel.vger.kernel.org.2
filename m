Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88F4318B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 13:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhBKMpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 07:45:10 -0500
Received: from gate.crashing.org ([63.228.1.57]:58691 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhBKM31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:29:27 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 11BCMD5w030851;
        Thu, 11 Feb 2021 06:22:13 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 11BCMCwY030849;
        Thu, 11 Feb 2021 06:22:12 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 11 Feb 2021 06:22:11 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/bug: Remove specific powerpc BUG_ON()
Message-ID: <20210211122211.GC28121@gate.crashing.org>
References: <694c7195c81d1bcc781b3c14f452886683d6c524.1613029237.git.christophe.leroy@csgroup.eu> <1613036567.zvyupcz926.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613036567.zvyupcz926.astroid@bobo.none>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 08:04:55PM +1000, Nicholas Piggin wrote:
> Excerpts from Christophe Leroy's message of February 11, 2021 5:41 pm:
> > As modern powerpc implement branch folding, that's even more efficient.

Ah, it seems you mean what Arm calls branch folding.  Sure, power4
already did that, and this has not changed.

> I think POWER will speculate conditional traps as non faulting always
> so it should be just as good if not better than the branch.

Right, these are not branch instructions, so are not branch predicted;
all trap instructions are assumed to fall through, like all other
non-branch instructions.


Segher
