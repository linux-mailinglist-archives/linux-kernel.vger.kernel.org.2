Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF73B30D8F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhBCLmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:42:06 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:60337 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234375AbhBCLlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:41:23 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DW09h1qQFz9vFx; Wed,  3 Feb 2021 22:40:39 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Markus Elfring <Markus.Elfring@web.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
In-Reply-To: <5b62379e-a35f-4f56-f1b5-6350f76007e7@web.de>
References: <5b62379e-a35f-4f56-f1b5-6350f76007e7@web.de>
Subject: Re: [PATCH] powerpc/setup: Adjust six seq_printf() calls in show_cpuinfo()
Message-Id: <161235201005.1516112.10488411245763781267.b4-ty@ellerman.id.au>
Date:   Wed,  3 Feb 2021 22:40:39 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 14:56:46 +0200, Markus Elfring wrote:
> A bit of information should be put into a sequence.
> Thus improve the execution speed for this data output by better usage
> of corresponding functions.
> 
> This issue was detected by using the Coccinelle software.

Applied to powerpc/next.

[1/1] powerpc/setup: Adjust six seq_printf() calls in show_cpuinfo()
      https://git.kernel.org/powerpc/c/675b963e2b6007818fe1b0a64b47be40c125246e

cheers
