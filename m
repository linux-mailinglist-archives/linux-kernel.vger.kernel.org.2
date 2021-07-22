Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A76F3D26CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhGVOy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 10:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhGVOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 10:54:56 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F073C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=8mGNEtej5Km8xU2wjprdiKPrHelNnd1RaT
        +aFgBrUL0=; b=l8rvOHag8XjdDctGhiTTgdn2WsyswSKywIcQnddFrCXF1pkM5a
        L1hfM2PsgjWYsgUuQzU7WyJDA9rGVfqx8OvRoiRNXETCloqXe5EYOiJjW1Jphf0s
        xN1WW3uQOohSMXu+AXcy96ujjVL2s1JQA28BHUZMlENa88TIU19FSHOFk=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygD3jFc1kPlgWmYoAA--.610S2;
        Thu, 22 Jul 2021 23:35:17 +0800 (CST)
Date:   Thu, 22 Jul 2021 23:29:23 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes 0/3] Fixes regarding CONFIG_PHYS_RAM_BASE
Message-ID: <20210722232923.73d65d6b@xhacker>
In-Reply-To: <20210721075937.696811-1-alex@ghiti.fr>
References: <20210721075937.696811-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygD3jFc1kPlgWmYoAA--.610S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GFyDCF15Kw15KFyDuFWUCFg_yoW8JF1xpr
        48Gan5uFyrt34fWFZI9wsrWFW5J3Z7Ja4agrnrX3y0gF10qa1jyF92qw17Zry2g3W8ZF4x
        tFy8Wryru3WjywUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy2b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
        Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOb18UUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 09:59:34 +0200
Alexandre Ghiti <alex@ghiti.fr> wrote:

> The following commits: 
> 
> 7094e6acaf7a ("riscv: Simplify xip and !xip kernel address conversion macros")
> 9b79878ced8f ("riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED")
> 
> expose CONFIG_PHYS_RAM_BASE for all kernel types whereas this value is
> implementation-specific, so that breaks the kernel genericity.
> 
> The first patch in this patchset removes the usage of CONFIG_PHYS_RAM_BASE
> by introducing a new global variable that holds this value.
> 
> The second patch reverts 9b79878ced8f ("riscv: Remove 
> CONFIG_PHYS_RAM_BASE_FIXED").
> 
> The last patch is an optimization 'symmetrical' to the one introduced in
> the first patch: this is not a fix, then it is not necessary to pull
> this into -fixes.
> 

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

> Alexandre Ghiti (3):
>   riscv: Get rid of CONFIG_PHYS_RAM_BASE in kernel physical address
>     conversion
>   Revert "riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED"
>   riscv: Optimize kernel virtual address conversion macro
> 
>  arch/riscv/Kconfig            |  6 ++++++
>  arch/riscv/include/asm/page.h |  9 +++++----
>  arch/riscv/mm/init.c          | 17 ++++++++++++-----
>  3 files changed, 23 insertions(+), 9 deletions(-)
> 


