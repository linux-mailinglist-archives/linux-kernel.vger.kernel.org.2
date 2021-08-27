Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798E13F99E0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245416AbhH0NXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245363AbhH0NXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:23:22 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425F9C0611BD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:22:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0k76mjHz9sXN;
        Fri, 27 Aug 2021 23:22:07 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <000a28c51808bbd802b505af42d2cb316c2be7d3.1629216000.git.christophe.leroy@csgroup.eu>
References: <000a28c51808bbd802b505af42d2cb316c2be7d3.1629216000.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/ptrace: Make user_mode() common to PPC32 and PPC64
Message-Id: <163007016280.52768.4828261616849206237.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:16:02 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2021 16:00:14 +0000 (UTC), Christophe Leroy wrote:
> Today we have:
> 
> 	#ifdef __powerpc64__
> 	#define user_mode(regs) ((((regs)->msr) >> MSR_PR_LG) & 0x1)
> 	#else
> 	#define user_mode(regs) (((regs)->msr & MSR_PR) != 0)
> 	#endif
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ptrace: Make user_mode() common to PPC32 and PPC64
      https://git.kernel.org/powerpc/c/19e932eb6ea47f4f37513eb2ae0daee19117765c

cheers
