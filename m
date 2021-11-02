Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B396442CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhKBLlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:05 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:54147 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhKBLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:40:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7FX39fHz4xcC;
        Tue,  2 Nov 2021 22:38:24 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <316c543b8906712c108985c8463eec09c8db577b.1629732542.git.christophe.leroy@csgroup.eu>
References: <316c543b8906712c108985c8463eec09c8db577b.1629732542.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: Don't use lmw/stmw for saving/restoring non volatile regs
Message-Id: <163584790541.1845480.12718539739212562295.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 15:29:12 +0000 (UTC), Christophe Leroy wrote:
> Instructions lmw/stmw are interesting for functions that are rarely
> used and not in the cache, because only one instruction is to be
> copied into the instruction cache instead of 19. However those
> instruction are less performant than 19x raw lwz/stw as they require
> synchronisation plus one additional cycle.
> 
> SAVE_NVGPRS / REST_NVGPRS are used in only a few places which are
> mostly in interrupts entries/exits and in task switch so they are
> likely already in the cache.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Don't use lmw/stmw for saving/restoring non volatile regs
      https://git.kernel.org/powerpc/c/a85c728cb5e12216c19ae5878980c2cbbbf8616d

cheers
