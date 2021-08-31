Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532C93FC941
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhHaOCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:02:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47763 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhHaOCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:02:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GzTQ43Rk0z9sR4;
        Wed,  1 Sep 2021 00:01:48 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629707037.git.christophe.leroy@csgroup.eu>
References: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629707037.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 1/3] powerpc: Remove MSR_PR check in interrupt_exit_{user/kernel}_prepare()
Message-Id: <163041840754.890713.6956967303915843591.b4-ty@ellerman.id.au>
Date:   Wed, 01 Sep 2021 00:00:07 +1000
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

[1/3] powerpc: Remove MSR_PR check in interrupt_exit_{user/kernel}_prepare()
      https://git.kernel.org/powerpc/c/133c17a1788d68c9fff59d5f724a4ba14647a16d

cheers
