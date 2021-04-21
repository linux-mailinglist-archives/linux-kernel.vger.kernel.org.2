Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146E3366C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbhDUNPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:15:25 -0400
Received: from ozlabs.org ([203.11.71.1]:49019 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242025AbhDUNJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:44 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FQLVG5gBNz9vFN; Wed, 21 Apr 2021 23:09:10 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        naveen.n.rao@linux.vnet.ibm.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <22cadf29620664b600b82026d2a72b8b23351777.1618927318.git.christophe.leroy@csgroup.eu>
References: <22cadf29620664b600b82026d2a72b8b23351777.1618927318.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/2] powerpc/inst: ppc_inst_as_u64() becomes ppc_inst_as_ulong()
Message-Id: <161901050268.1961279.15476787728772841493.b4-ty@ellerman.id.au>
Date:   Wed, 21 Apr 2021 23:08:22 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 14:02:06 +0000 (UTC), Christophe Leroy wrote:
> In order to simplify use on PPC32, change ppc_inst_as_u64()
> into ppc_inst_as_ulong() that returns the 32 bits instruction
> on PPC32.
> 
> Will be used when porting OPTPROBES to PPC32.

Applied to powerpc/next.

[1/2] powerpc/inst: ppc_inst_as_u64() becomes ppc_inst_as_ulong()
      https://git.kernel.org/powerpc/c/693557ebf407a85ea400a0b501bb97687d8f4856
[2/2] powerpc: Enable OPTPROBES on PPC32
      https://git.kernel.org/powerpc/c/eacf4c0202654adfa94bbb17b5c5c77c0be14af8

cheers
