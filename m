Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBFC40C6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhIOODE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbhIOODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:03:02 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DC49C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=2L9JYSzARBFCFAncpekcNa31rHUDF9/m9r
        +5y91THK4=; b=FeOwuQ62Uk/tfdPwutnlutV3ozdSAJacLK2CTSyRFeOTZ1qXfK
        0ytSf8OCFafr9sSEALToAWnk3ts20VDuFMWsxx7ruxYB1fDBPf6WhmEJsuUp8LIc
        140MZzSy3MhFs8StzHLZKTXQRdlC8xJtzIQ7ZnHpetHr/hS+i8ECxYYEc=
Received: from xhacker (unknown [101.86.20.138])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCX0qme_EFhlqQBAA--.880S2;
        Wed, 15 Sep 2021 22:01:02 +0800 (CST)
Date:   Wed, 15 Sep 2021 21:54:32 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: Re: [PATCH] scripts/sorttable: riscv: fix undelcred identifier
 'EM_RISCV' error
Message-ID: <20210915215432.02a5e08e@xhacker>
In-Reply-To: <20210913030625.4525-1-miles.chen@mediatek.com>
References: <20210913030625.4525-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCX0qme_EFhlqQBAA--.880S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw18JrW5CFWkuFy7tFy8AFb_yoW8Jw43pa
        yYk345tFyrAF1xu3ZrCryrXF18Gw4vyw45GrsxWw18A3WFqFsYkr42yw1Y9FW5Wr97uryF
        krsFg34UGa1jk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
        GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8rcTPUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021 11:06:25 +0800
Miles Chen <miles.chen@mediatek.com> wrote:

> Fix the following build break by adding a conditional definition
> of EM_RISCV in order to allow cross-compilation on machines
> which do not have EM_RISCV definition in their host.
> 
> build break log from [1]:
> scripts/sorttable.c:352:7: error: use of undeclared identifier 'EM_RISCV'

Looks strange I can't reproduce it. FWICT, this may be seen with some old
toolchains.

> 
> [1] https://lore.kernel.org/lkml/e8965b25-f15b-c7b4-748c-d207dda9c8e8@i2se.com/
> 
> Cc: Jisheng Zhang <jszhang@kernel.org>
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 54fed35fd393 ("riscv: Enable BUILDTIME_TABLE_SORT")
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

> ---
>  scripts/sorttable.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index f355869c65cd..6ee4fa882919 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -54,6 +54,10 @@
>  #define EM_ARCV2	195
>  #endif
>  
> +#ifndef EM_RISCV
> +#define EM_RISCV	243
> +#endif
> +
>  static uint32_t (*r)(const uint32_t *);
>  static uint16_t (*r2)(const uint16_t *);
>  static uint64_t (*r8)(const uint64_t *);


