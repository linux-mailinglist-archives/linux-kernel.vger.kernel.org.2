Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E78363A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbhDSEFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:05:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237509AbhDSEFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:05:19 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVq4zx6z9vHr; Mon, 19 Apr 2021 14:04:35 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, mahesh@linux.ibm.com, alistair@popple.id.au,
        ravi.bangoria@linux.ibm.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        christophe.leroy@csgroup.eu, peterz@infradead.org,
        sourabhjain@linux.ibm.com, haren@linux.ibm.com, mpe@ellerman.id.au,
        aik@ozlabs.ru, mikey@neuling.org, hbathini@linux.ibm.com,
        jniethe5@gmail.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, maddy@linux.ibm.com, paulus@samba.org,
        Xiongwei Song <sxwjean@me.com>, kan.liang@linux.intel.com,
        leobras.c@gmail.com, akpm@linux-foundation.org, nathan@kernel.org,
        walken@google.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1618398033-13025-1-git-send-email-sxwjean@me.com>
References: <1618398033-13025-1-git-send-email-sxwjean@me.com>
Subject: Re: [PATCH v5] powerpc/traps: Enhance readability for trap types
Message-Id: <161880480749.1398509.13854338250258784964.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 14:00:07 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 19:00:33 +0800, Xiongwei Song wrote:
> Define macros to list ppc interrupt types in interttupt.h, replace the
> reference of the trap hex values with these macros.
> 
> Referred the hex numbers in arch/powerpc/kernel/exceptions-64e.S,
> arch/powerpc/kernel/exceptions-64s.S, arch/powerpc/kernel/head_*.S,
> arch/powerpc/kernel/head_booke.h and arch/powerpc/include/asm/kvm_asm.h.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/traps: Enhance readability for trap types
      https://git.kernel.org/powerpc/c/7153d4bf0b373428d0393c001019da4d0483fddb

cheers
