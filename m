Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40333383976
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244831AbhEQQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346372AbhEQQFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:05:51 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAEEBC0467E9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=ZXsRNWguWbVa0PtAmixG+uiM2qAEjYWOfH
        SwLuA4TyE=; b=EqztZO8DWB8gA3sQFNBpU6PwbOgqEpdc/bTPL2yVNn47iZdzWK
        6sUMGqvRSLsBbD3AJgkf9TbgcKVCzR5I7nqvqX4RUW6zShDmnorVMGrB5FceKPwd
        03Xr7hymxSFVdqRy+q73W9cmxguTaVMm1fghbdBRHhLgd6qSfiDsfGVCk=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygB3f0d+gaJgnBTyAA--.22620S2;
        Mon, 17 May 2021 22:45:18 +0800 (CST)
Date:   Mon, 17 May 2021 22:40:01 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: init: Consolidate vars, functions
Message-ID: <20210517224001.42424097@xhacker>
In-Reply-To: <66c8965d-494f-6c2f-0739-9bee13fc507c@ghiti.fr>
References: <20210516211556.43c00055@xhacker>
        <20210516211922.2110232e@xhacker>
        <66c8965d-494f-6c2f-0739-9bee13fc507c@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygB3f0d+gaJgnBTyAA--.22620S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW8XF1fJw4ktw4kuw43Awb_yoW8JFWrpr
        4FqFW5Ja1kArW7CasFqr4IgFyj9Fn3WFyrJw1UKr1fuFn8Grn8Xw4UWrW5u39FgrWxuF4Y
        vr4jy34qgw4jv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy2b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
        Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5BMNUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 May 2021 21:10:48 +0200
Alex Ghiti <alex@ghiti.fr> wrote:

> Hi Jisheng,
> 
> On 16/05/2021 15:19, Jisheng Zhang wrote:
> > On Sun, 16 May 2021 21:15:56 +0800 Jisheng Zhang  wrote:
> >   
> >> From: Jisheng Zhang <jszhang@kernel.org>
> >>
> >> Consolidate the following items in init.c
> >>
> >> Staticize global vars as much as possible;
> >> Add __initdata mark if the global var isn't needed after init
> >> Add __init mark if the func isn't needed after init
> >> Add __ro_after_init if the global var is read only after init  
> > 
> > Hi Alexandre,
> > 
> > I think kernel_virt_addr can be removed, users can directly use
> > the KERNEL_LINK_ADDR MACRO. Maybe I miss the reason of intrducing
> > it in commit 2bfc6cd81bd17e43 ("riscv: Move kernel mapping outside of
> > linear mapping"), could you please comment?
> > 
> > Thanks in advance  
> 
> kernel_virt_addr will be used when I push my relocatable series since 
> then, the kernel virtual address will be different from 
> KERNEL_LINK_ADDR. I agree this was not needed in 2bfc6cd81bd17e43 
> ("riscv: Move kernel mapping outside of linear mapping"), I'm a bit late 
> in pushing the relocatable series.
> 

Thanks for your information. I think kernel_virt_addr could be __ro_after_init
But I will keep it unchanged until your relocatable series.

thanks

