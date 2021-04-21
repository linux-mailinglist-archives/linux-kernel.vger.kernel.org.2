Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673E8366C57
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbhDUNOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241983AbhDUNJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:40 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EC1C061342
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:09:07 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FQLV74fxFz9vF7; Wed, 21 Apr 2021 23:09:03 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     sxwjean@gmail.com, Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <e1147287bf6f2fb0693048fe8db0298c7870e419.1618847273.git.christophe.leroy@csgroup.eu>
References: <e1147287bf6f2fb0693048fe8db0298c7870e419.1618847273.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc/8xx: Enhance readability of trap types
Message-Id: <161901050214.1961279.6836507660126364944.b4-ty@ellerman.id.au>
Date:   Wed, 21 Apr 2021 23:08:22 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 15:48:09 +0000 (UTC), Christophe Leroy wrote:
> This patch makes use of trap types in head_8xx.S

Applied to powerpc/next.

[1/3] powerpc/8xx: Enhance readability of trap types
      https://git.kernel.org/powerpc/c/0f5eb28a6ce6ab0882010e6727bfd6e8cd569273
[2/3] powerpc/32s: Enhance readability of trap types
      https://git.kernel.org/powerpc/c/7fab639729ce4a0ecb3c528cd68b0c0598696ef9
[3/3] powerpc/irq: Enhance readability of trap types
      https://git.kernel.org/powerpc/c/e522331173ec9af563461e0fae534e83ce39e8e3

cheers
