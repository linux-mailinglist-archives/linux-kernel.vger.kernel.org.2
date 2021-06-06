Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EC039CEE9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFFMOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhFFMOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:14:02 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91855C06178B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:12:12 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb3G4c1Kz9sfG; Sun,  6 Jun 2021 22:12:10 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        mhiramat@kernel.org, davem@davemloft.net,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <40a43d6df1fdf41ade36e9a46e60a4df774ca9f6.1620896780.git.christophe.leroy@csgroup.eu>
References: <40a43d6df1fdf41ade36e9a46e60a4df774ca9f6.1620896780.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/2] kprobes: Allow architectures to override optinsn page allocation
Message-Id: <162298132158.2353459.12128294246619463248.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:41 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 09:07:51 +0000 (UTC), Christophe Leroy wrote:
> Some architectures like powerpc require a non standard
> allocation of optinsn page, because module pages are
> too far from the kernel for direct branches.
> 
> Define weak alloc_optinsn_page() and free_optinsn_page(), that
> fall back on alloc_insn_page() and free_insn_page() when not
> overriden by the architecture.

Applied to powerpc/next.

[1/2] kprobes: Allow architectures to override optinsn page allocation
      https://git.kernel.org/powerpc/c/7ee3e97e00a3893e354c3993c3f7d9dc127e9c5e
[2/2] powerpc/kprobes: Replace ppc_optinsn by common optinsn
      https://git.kernel.org/powerpc/c/b73c8cccd72ac28beaf262fd6ef4b91411fc8335

cheers
