Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F03AC207
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhFREZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:25:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40149 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhFREZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:06 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4J5cQ5z9sj1; Fri, 18 Jun 2021 14:22:55 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        jniethe5@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1621516826.git.christophe.leroy@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 00/12] powerpc: Cleanup use of 'struct ppc_inst'
Message-Id: <162398829384.1363949.8760283426768827075.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 13:50:37 +0000 (UTC), Christophe Leroy wrote:
> This series is a cleanup of the use of 'struct ppc_inst'.
> 
> A confusion is made between internal representation of powerpc
> instructions with 'struct ppc_inst' and in-memory code which is
> and will always be an array of 'unsigned int'.
> 
> This series cleans it up.
> 
> [...]

Applied to powerpc/next.

[01/12] powerpc/inst: Fix sparse detection on get_user_instr()
        https://git.kernel.org/powerpc/c/b3a9e523237013477bea914b7fbfbe420428b988
[02/12] powerpc/inst: Reduce casts in get_user_instr()
        https://git.kernel.org/powerpc/c/9134806e149ebb214f122f0f84254096d3768bb2
[03/12] powerpc/inst: Improve readability of get_user_instr() and friends
        https://git.kernel.org/powerpc/c/042e0860e1c1d60a0ab1ff3f16b7f420573133e0
[04/12] powerpc/inst: Avoid pointer dereferencing in ppc_inst_equal()
        https://git.kernel.org/powerpc/c/036b5560bebc72c61d955ae0b115e8e69da8a563
[05/12] powerpc: Do not dereference code as 'struct ppc_inst' (uprobe, code-patching, feature-fixups)
        https://git.kernel.org/powerpc/c/18c85964b10b7b78a5cb59a4959a5f82fdc77e4c
[06/12] powerpc/lib/code-patching: Make instr_is_branch_to_addr() static
        https://git.kernel.org/powerpc/c/6c0d181daabcba286db9711eef8800b566fb1cce
[07/12] powerpc/lib/code-patching: Don't use struct 'ppc_inst' for runnable code in tests.
        https://git.kernel.org/powerpc/c/e90a21ea801d1776d9a786ad02354fd3fe23ce09
[08/12] powerpc: Don't use 'struct ppc_inst' to reference instruction location
        https://git.kernel.org/powerpc/c/69d4d6e5fd9f4e805280ad831932c3df7b9d7cc7
[09/12] powerpc/inst: Refactor PPC32 and PPC64 versions
        https://git.kernel.org/powerpc/c/077c4dedef09796ade917459a5330e3940fb5860
[10/12] powerpc/optprobes: Minimise casts
        https://git.kernel.org/powerpc/c/afd3287c8872142ec4298a2b77bd9077e2209c9c
[11/12] powerpc/optprobes: Compact code source a bit.
        https://git.kernel.org/powerpc/c/f38adf86ce4fdae84904f420e175ce5806509c4c
[12/12] powerpc/optprobes: use PPC_RAW_ macros
        https://git.kernel.org/powerpc/c/0e628ad2d60896de31148fba00cc73623b8c0aa1

cheers
