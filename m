Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E81E3B4E1E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhFZKl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:41:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhFZKlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:41:15 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GBr2M6XqQz9ssP; Sat, 26 Jun 2021 20:38:51 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <d48bf0184a1de185eb0ed3282247f8a294710674.1624632537.git.christophe.leroy@csgroup.eu>
References: <d48bf0184a1de185eb0ed3282247f8a294710674.1624632537.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/interrupt: Use names in check_return_regs_valid()
Message-Id: <162470384873.3589875.14660623720559661053.b4-ty@ellerman.id.au>
Date:   Sat, 26 Jun 2021 20:37:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 14:49:09 +0000 (UTC), Christophe Leroy wrote:
> trap->regs == 0x3000 is trap_is_scv()
> 
> trap 0x500 is INTERRUPT_EXTERNAL

Applied to powerpc/next.

[1/1] powerpc/interrupt: Use names in check_return_regs_valid()
      https://git.kernel.org/powerpc/c/b064037ea4104120418ccbf39951a6d529a9d6d5

cheers
