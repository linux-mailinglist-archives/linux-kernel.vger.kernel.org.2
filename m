Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4BB31975E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 01:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhBLAUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 19:20:51 -0500
Received: from ozlabs.org ([203.11.71.1]:33479 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhBLAUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 19:20:38 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DcDf21YQpz9sRf; Fri, 12 Feb 2021 11:19:54 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <5ae4d545e3ac58e133d2599e0deb88843cb494fc.1612768623.git.christophe.leroy@csgroup.eu>
References: <5ae4d545e3ac58e133d2599e0deb88843cb494fc.1612768623.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: Preserve cr1 in exception prolog stack check to fix build error
Message-Id: <161308904010.3606979.18330739657598413446.b4-ty@ellerman.id.au>
Date:   Fri, 12 Feb 2021 11:19:54 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 07:17:40 +0000 (UTC), Christophe Leroy wrote:
> THREAD_ALIGN_SHIFT = THREAD_SHIFT + 1 = PAGE_SHIFT + 1
> Maximum PAGE_SHIFT is 18 for 256k pages so
> THREAD_ALIGN_SHIFT is 19 at the maximum.
> 
> No need to clobber cr1, it can be preserved when moving r1
> into CR when we check stack overflow.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Preserve cr1 in exception prolog stack check to fix build error
      https://git.kernel.org/powerpc/c/3642eb21256a317ac14e9ed560242c6d20cf06d9

cheers
