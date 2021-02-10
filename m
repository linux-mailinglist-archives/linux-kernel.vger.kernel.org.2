Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4B316760
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhBJNCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhBJM5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:57:53 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642EBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:57:31 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DbKY2037Wz9sWR; Wed, 10 Feb 2021 23:57:24 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <72c7b9879e2e2e6f5c27dadda6486386c2b50f23.1612612022.git.christophe.leroy@csgroup.eu>
References: <72c7b9879e2e2e6f5c27dadda6486386c2b50f23.1612612022.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc/32s: Change mfsrin() into a static inline function
Message-Id: <161296172491.3178259.6717759918429909544.b4-ty@ellerman.id.au>
Date:   Wed, 10 Feb 2021 23:57:24 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Feb 2021 11:47:26 +0000 (UTC), Christophe Leroy wrote:
> mfsrin() is a macro.
> 
> Change in into an inline function to avoid conflicts in KVM
> and make it more evolutive.

Applied to powerpc/next.

[1/3] powerpc/32s: Change mfsrin() into a static inline function
      https://git.kernel.org/powerpc/c/fd659e8f2c6d1e1e96fd5bdb515518801cd02012
[2/3] powerpc/32s: mfsrin()/mtsrin() become mfsr()/mtsr()
      https://git.kernel.org/powerpc/c/179ae57dbad1b9a83eec376aa44d54fc24352e37
[3/3] powerpc/32s: Allow constant folding in mtsr()/mfsr()
      https://git.kernel.org/powerpc/c/b842d131c7983f8f0b9c9572c073130b5f2bcf11

cheers
