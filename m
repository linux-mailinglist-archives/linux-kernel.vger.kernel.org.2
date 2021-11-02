Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18854442CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhKBLlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:35 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:58305 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhKBLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fj1KMBz4xdB;
        Tue,  2 Nov 2021 22:38:33 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Stan Johnson <userm57@yahoo.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu>
References: <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in kernel mode
Message-Id: <163584790970.1845480.2701645430318676678.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:49 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 16:52:09 +0200, Christophe Leroy wrote:
> dcbz instruction shouldn't be used on non-cached memory. Using
> it on non-cached memory can result in alignment exception and
> implies a heavy handling.
> 
> Instead of silentely emulating the instruction and resulting in high
> performance degradation, warn whenever an alignment exception is
> taken in kernel mode due to dcbz, so that the user is made aware that
> dcbz instruction has been used unexpectedly by the kernel.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: warn on emulation of dcbz instruction in kernel mode
      https://git.kernel.org/powerpc/c/cbe654c779616807e1e6823c3bdbfe07a10562b8

cheers
