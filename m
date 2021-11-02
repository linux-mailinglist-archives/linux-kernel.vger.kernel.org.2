Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83A4442CD1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhKBLlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:07 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:52257 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhKBLlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7FZ14QSz4xcF;
        Tue,  2 Nov 2021 22:38:26 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <057c40164084bfc7d77c0b2ff78d95dbf6a2a21b.1632503622.git.christophe.leroy@csgroup.eu>
References: <057c40164084bfc7d77c0b2ff78d95dbf6a2a21b.1632503622.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Activate CONFIG_STRICT_KERNEL_RWX by default
Message-Id: <163584791243.1845480.10223684012984375431.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:52 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021 19:13:53 +0200, Christophe Leroy wrote:
> CONFIG_STRICT_KERNEL_RWX should be set by default on every
> architectures (See https://github.com/KSPP/linux/issues/4)
> 
> On PPC32 we have to find a compromise between performance and/or
> memory wasting and selection of strict_kernel_rwx, because it implies
> either smaller memory chunks or larger alignment between RO memory
> and RW memory.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Activate CONFIG_STRICT_KERNEL_RWX by default
      https://git.kernel.org/powerpc/c/fdacae8a84024474afff234bdd1dbe19ad597a10

cheers
