Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BB8426B9C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbhJHN0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhJHN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:26:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E2EC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 06:24:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HQpnT0cp5z4xbR;
        Sat,  9 Oct 2021 00:24:29 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Finn Thain <fthain@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Stan Johnson <userm57@yahoo.com>
In-Reply-To: <0d0c4d0f050a637052287c09ba521bad960a2790.1631715131.git.christophe.leroy@csgroup.eu>
References: <0d0c4d0f050a637052287c09ba521bad960a2790.1631715131.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix kuap_kernel_restore()
Message-Id: <163369938390.3568929.9026666512859787724.b4-ty@ellerman.id.au>
Date:   Sat, 09 Oct 2021 00:23:03 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 16:12:24 +0200, Christophe Leroy wrote:
> At interrupt exit, kuap_kernel_restore() calls kuap_unclok() with the
> value contained in regs->kuap. However, when regs->kuap contains
> 0xffffffff it means that KUAP was not unlocked so calling
> kuap_unlock() is unrelevant and results in jeopardising the contents
> of kernel space segment registers.
> 
> So check that regs->kuap doesn't contain KUAP_NONE before calling
> kuap_unlock(). In the meantime it also means that if KUAP has not
> been correcly locked back at interrupt exit, it must be locked
> before continuing. This is done by checking the content of
> current->thread.kuap which was returned by kuap_get_and_assert_locked()
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/32s: Fix kuap_kernel_restore()
      https://git.kernel.org/powerpc/c/d93f9e23744b7bf11a98b2ddb091d129482ae179

cheers
