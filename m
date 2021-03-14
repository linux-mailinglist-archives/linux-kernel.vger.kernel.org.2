Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F6333A413
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 11:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhCNKCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 06:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhCNKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 06:01:26 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C62CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 03:01:25 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Dyw753DkDz9sWQ; Sun, 14 Mar 2021 21:01:21 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        npiggin@gmail.com, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1615291471.git.christophe.leroy@csgroup.eu>
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 00/43] powerpc/32: Switch to interrupt entry/exit in C
Message-Id: <161571587375.138988.10429632737779319110.b4-ty@ellerman.id.au>
Date:   Sun, 14 Mar 2021 21:01:21 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 12:09:25 +0000 (UTC), Christophe Leroy wrote:
> This series aims at porting interrupt entry/exit in C on PPC32, using
> the work already merged for PPC64.
> 
> First two patches are a fix and an optimisation of unrecoverable_exception() function.
> 
> Six following patches do minimal changes in 40x in order to be able to enable MMU
> earlier in exception entry.
> 
> [...]

Patch 1 applied to powerpc/fixes.

[01/43] powerpc/traps: unrecoverable_exception() is not an interrupt handler
        https://git.kernel.org/powerpc/c/0b736881c8f1a6cd912f7a9162b9e097b28c1c30

cheers
