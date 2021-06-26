Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803E73B4E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhFZKlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:41:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54041 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhFZKlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:41:13 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GBr2L23Yqz9srZ; Sat, 26 Jun 2021 20:38:50 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <5ab3a517bc883a2fc905fb2cb5ee9344f37b2cfa.1622818435.git.christophe.leroy@csgroup.eu>
References: <5ab3a517bc883a2fc905fb2cb5ee9344f37b2cfa.1622818435.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/4] powerpc/32: Interchange r10 and r12 in SYSCALL_ENTRY on non booke
Message-Id: <162470384189.3589875.8770118604128642309.b4-ty@ellerman.id.au>
Date:   Sat, 26 Jun 2021 20:37:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 14:54:12 +0000 (UTC), Christophe Leroy wrote:
> To better match booke version of SYSCALL_ENTRY macro, interchange
> r10 and r12 in the non booke version.

Applied to powerpc/next.

[1/4] powerpc/32: Interchange r10 and r12 in SYSCALL_ENTRY on non booke
      https://git.kernel.org/powerpc/c/10e9252f043ecda0dad7cde6ef87db5d10dff2c7
[2/4] powerpc/32: Interchange r1 and r11 in SYSCALL_ENTRY on booke
      https://git.kernel.org/powerpc/c/275dcf24e253f4f5b200bc8cca5eac32a23b08c8
[3/4] powerpc/32: Reduce code duplication of system call entry
      https://git.kernel.org/powerpc/c/4bd9e05ac7b8b1f7d0c28702cb684417501a5e39
[4/4] powerpc/32: Avoid #ifdef nested with FTR_SECTION on booke syscall entry
      https://git.kernel.org/powerpc/c/a27755d57e0b8c1109a6b1485e52a5f9d51bd4eb

cheers
