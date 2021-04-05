Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0875354229
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbhDEMoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 08:44:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:41042 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233550AbhDEMoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 08:44:11 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 135CcSjg014265;
        Mon, 5 Apr 2021 07:38:28 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 135CcRoo014264;
        Mon, 5 Apr 2021 07:38:27 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 5 Apr 2021 07:38:27 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Remove powerpc specific definition of 'ptrdiff_t'
Message-ID: <20210405123827.GM13863@gate.crashing.org>
References: <e43d133bf52fa19e577f64f3a3a38cedc570377d.1617616601.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e43d133bf52fa19e577f64f3a3a38cedc570377d.1617616601.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 09:57:27AM +0000, Christophe Leroy wrote:
> For unknown reason, old commit d27dfd388715 ("Import pre2.0.8")
> changed 'ptrdiff_t' from 'int' to 'long'.
> 
> GCC expects it as 'int' really,

It isn't actually defined in the ABI as far as I can see (neither the
old document or the new one), but GCC has defined it as "int" since
forever (which was in 1995), for anything using the SYSV ABI (which
includes powerpc-linux).

> <asm-generic/uapi/posix-types.h> defines it as 'int', and
> defines 'size_t' and 'ssize_t' exactly as powerpc do, so
> remove the powerpc specific definitions and fallback on
> generic ones.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks!

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
