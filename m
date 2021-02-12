Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61731975F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 01:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBLAU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 19:20:59 -0500
Received: from ozlabs.org ([203.11.71.1]:34219 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhBLAUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 19:20:38 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DcDf45KfPz9sVX; Fri, 12 Feb 2021 11:19:56 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>, msuchanek@suse.de,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1612898425.git.christophe.leroy@csgroup.eu>
References: <cover.1612898425.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v6 0/2] powerpc/32: Implement C syscall entry/exit (complement)
Message-Id: <161308904799.3606979.14603109971130321553.b4-ty@ellerman.id.au>
Date:   Fri, 12 Feb 2021 11:19:56 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 19:29:26 +0000 (UTC), Christophe Leroy wrote:
> This series implements C syscall entry/exit for PPC32. It reuses
> the work already done for PPC64.
> 
> This series is based on today's next-test (f538b53fd47a) where main patchs from v5 are merged in.
> 
> The first patch is important for performance.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/syscall: Do not check unsupported scv vector on PPC32
      https://git.kernel.org/powerpc/c/b966f2279048ee9f30d83ef8568b99fa40917c54
[2/3] powerpc/32: Handle bookE debugging in C in syscall entry/exit
      https://git.kernel.org/powerpc/c/d524dda719f06967db4d3ba519edf9267f84c155
[3/3] powerpc/syscall: Avoid storing 'current' in another pointer
      https://git.kernel.org/powerpc/c/5b90b9661a3396e00f6e8bcbb617a0787fb683d0

cheers
