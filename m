Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D92A381B82
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 00:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhEOWrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 18:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhEOWrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 18:47:01 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCE8C061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 15:45:47 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FjL8T0XPtz9sfG; Sun, 16 May 2021 08:45:44 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cf0a050d124d4f426cdc7a74009d17b01d8d8969.1620465917.git.christophe.leroy@csgroup.eu>
References: <cf0a050d124d4f426cdc7a74009d17b01d8d8969.1620465917.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/uaccess: Fix __get_user() with CONFIG_CC_HAS_ASM_GOTO_OUTPUT
Message-Id: <162111863389.1890426.7179342188504537886.b4-ty@ellerman.id.au>
Date:   Sun, 16 May 2021 08:43:53 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021 09:25:32 +0000 (UTC), Christophe Leroy wrote:
> Building kernel mainline with GCC 11 leads to following failure
> when starting 'init':
> 
>   init[1]: bad frame in sys_sigreturn: 7ff5a900 nip 001083cc lr 001083c4
>   Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> This is an issue due to a segfault happening in
> __unsafe_restore_general_regs() in a loop copying registers from user
> to kernel:
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/uaccess: Fix __get_user() with CONFIG_CC_HAS_ASM_GOTO_OUTPUT
      https://git.kernel.org/powerpc/c/7315e457d6bc342d06ba0b7ee498221c5237a547

cheers
