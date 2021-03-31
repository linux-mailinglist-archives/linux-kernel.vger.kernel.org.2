Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82934F5D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhCaBKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41843 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232893AbhCaBKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:12 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XM1Wjnz9sWK; Wed, 31 Mar 2021 12:10:10 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <e4d1aae7604d89c98a52dfd8ce8443462e595670.1615809591.git.christophe.leroy@csgroup.eu>
References: <e4d1aae7604d89c98a52dfd8ce8443462e595670.1615809591.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/math: Fix missing __user qualifier for get_user() and other sparse warnings
Message-Id: <161715297749.226945.13016701345166471627.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 12:00:09 +0000 (UTC), Christophe Leroy wrote:
> Sparse reports the following problems:
> 
> arch/powerpc/math-emu/math.c:228:21: warning: Using plain integer as NULL pointer
> arch/powerpc/math-emu/math.c:228:31: warning: Using plain integer as NULL pointer
> arch/powerpc/math-emu/math.c:228:41: warning: Using plain integer as NULL pointer
> arch/powerpc/math-emu/math.c:228:51: warning: Using plain integer as NULL pointer
> arch/powerpc/math-emu/math.c:237:13: warning: incorrect type in initializer (different address spaces)
> arch/powerpc/math-emu/math.c:237:13:    expected unsigned int [noderef] __user *_gu_addr
> arch/powerpc/math-emu/math.c:237:13:    got unsigned int [usertype] *
> arch/powerpc/math-emu/math.c:226:1: warning: symbol 'do_mathemu' was not declared. Should it be static?
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/math: Fix missing __user qualifier for get_user() and other sparse warnings
      https://git.kernel.org/powerpc/c/e448e1e774dc0ca307c17e961daf7ede2e635c57

cheers
