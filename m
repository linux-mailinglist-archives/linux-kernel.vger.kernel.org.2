Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD1B3B449F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhFYNjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhFYNjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:39:11 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91A4EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=V/Pda2TGK88NZgYN0v2vuctHbNL3/pWKOS
        4YEYben7Y=; b=yBCujCdEENyRlL5Ag7328rzO/xHR8FXbiKBut08Aok9qwoIfcN
        2Gamw2lAF6wKdnl6uHwqyCZW3TJm5Zc8/Stsgq8qHTTSqt9XIoRanjB/zGSjtIf2
        nOek42UVJKOfhLAVVP9Z3/NdMHDpoLdgU6PP/ordJY6iq+h5gHuWGvNYA=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDn6YHq29VgDxI0AQ--.11530S2;
        Fri, 25 Jun 2021 21:36:42 +0800 (CST)
Date:   Fri, 25 Jun 2021 21:31:04 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix PTDUMP output now BPF region moved
 back to module region
Message-ID: <20210625213104.1e48d544@xhacker>
In-Reply-To: <20210624121721.2828421-1-alex@ghiti.fr>
References: <20210624121721.2828421-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDn6YHq29VgDxI0AQ--.11530S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWrCFWkCw4DAryrWF17ZFb_yoWDXFX_Kw
        18Gas3XrW7tw1F9F4fCFs3urnay34vqFZ3Gw10q3s7A3yrCFnxKa1xtF15XrnxZrZ3GFWr
        Jr97XrWIqr42vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbrkYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07j1VbkUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 14:17:21 +0200
Alexandre Ghiti <alex@ghiti.fr> wrote:

> BPF region was moved back to the region below the kernel at the end of the
> module region in commit 3a02764c372c ("riscv: Ensure BPF_JIT_REGION_START
> aligned with PMD size"), so reflect this change in kernel page table
> output.

Nice catch!

> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

> ---
>  arch/riscv/mm/ptdump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index 0536ac84b730..22d6555d89dc 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -98,8 +98,8 @@ static struct addr_marker address_markers[] = {
>  	{0, "vmalloc() end"},
>  	{0, "Linear mapping"},
>  #ifdef CONFIG_64BIT
> -	{0, "Modules mapping"},
> -	{0, "Kernel mapping (kernel, BPF)"},
> +	{0, "Modules/BPF mapping"},
> +	{0, "Kernel mapping"},
>  #endif
>  	{-1, NULL},
>  };


