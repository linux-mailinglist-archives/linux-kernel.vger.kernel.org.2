Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECB53AC1F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhFREZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:25:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60569 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231284AbhFREY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:24:58 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m485hncz9sXG; Fri, 18 Jun 2021 14:22:48 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <f7f4d4e364de6e473da874468b903da6e5d97adc.1620713272.git.christophe.leroy@csgroup.eu>
References: <f7f4d4e364de6e473da874468b903da6e5d97adc.1620713272.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Force inlining of csum_add()
Message-Id: <162398828953.1363949.250127564614690986.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 06:08:06 +0000 (UTC), Christophe Leroy wrote:
> Commit 328e7e487a46 ("powerpc: force inlining of csum_partial() to
> avoid multiple csum_partial() with GCC10") inlined csum_partial().
> 
> Now that csum_partial() is inlined, GCC outlines csum_add() when
> called by csum_partial().
> 
> c064fb28 <csum_add>:
> c064fb28:	7c 63 20 14 	addc    r3,r3,r4
> c064fb2c:	7c 63 01 94 	addze   r3,r3
> c064fb30:	4e 80 00 20 	blr
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Force inlining of csum_add()
      https://git.kernel.org/powerpc/c/4423eff71ca6b8f2c5e0fc4cea33d8cdfe3c3740

cheers
