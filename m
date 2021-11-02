Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA992442CD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhKBLlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhKBLlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178E8C061764
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:38:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Ff57Nhz4xct;
        Tue,  2 Nov 2021 22:38:30 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <c3f9ec9950394ef939014f7934268e6ee30ca04f.1630398566.git.christophe.leroy@csgroup.eu>
References: <c3f9ec9950394ef939014f7934268e6ee30ca04f.1630398566.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/time: Remove generic_suspend_{dis/en}able_irqs()
Message-Id: <163584790697.1845480.13077572464095477965.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:46 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 08:29:35 +0000 (UTC), Christophe Leroy wrote:
> Commit d75d68cfef49 ("powerpc: Clean up obsolete code relating to
> decrementer and timebase") made generic_suspend_enable_irqs() and
> generic_suspend_disable_irqs() static.
> 
> Fold them into their only caller.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/time: Remove generic_suspend_{dis/en}able_irqs()
      https://git.kernel.org/powerpc/c/e606a2f46c72ec399bb9be194f6df95ea8ec3b1b

cheers
