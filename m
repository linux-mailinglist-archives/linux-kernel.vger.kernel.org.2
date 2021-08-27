Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C089E3F99E3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245421AbhH0NXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245269AbhH0NXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:23:25 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C88C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:22:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0kK4Nzfz9sWc;
        Fri, 27 Aug 2021 23:22:17 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629707037.git.christophe.leroy@csgroup.eu>
References: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629707037.git.christophe.leroy@csgroup.eu>
Subject: Re: (subset) [PATCH v3 1/3] powerpc: Remove MSR_PR check in interrupt_exit_{user/kernel}_prepare()
Message-Id: <163007018206.52768.16263402363741709388.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:16:22 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 08:24:20 +0000 (UTC), Christophe Leroy wrote:
> In those hot functions that are called at every interrupt, any saved
> cycle is worth it.
> 
> interrupt_exit_user_prepare() and interrupt_exit_kernel_prepare() are
> called from three places:
> - From entry_32.S
> - From interrupt_64.S
> - From interrupt_exit_user_restart() and interrupt_exit_kernel_restart()
> 
> [...]

Applied to powerpc/next.

[2/3] powerpc: Refactor verification of MSR_RI
      https://git.kernel.org/powerpc/c/806c0e6e7e97adc17389c8dc1f52d4736f49299b

cheers
