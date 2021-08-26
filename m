Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4CE3F89DC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhHZOOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhHZOOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:14:09 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0257C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=PwPdTMkZZMVwu4jau4Iu8OhLTyCA5Uyt5p
        LWWepOgFk=; b=VcyN4UoUV+vPpbVr1PU0cmQBTJJ7N64TgTDTZTDLt+uQ+2y3AE
        N9M1ONap8hnmqjmCkZuE0nDifoTZ/DbJ5+KzkN74TvzM3oQ084Qvc26mBeJBjovS
        3LSrtrF3Nm6dM+mUbD4QM14iYECEXLhkqKgQCaSbBIKpIC6p8br5OFpSg=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBXLv9CoSdhqJ3GAA--.14367S2;
        Thu, 26 Aug 2021 22:12:19 +0800 (CST)
Date:   Thu, 26 Aug 2021 22:06:00 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: improve __ex_table section handling
Message-ID: <20210826220600.4759900b@xhacker>
In-Reply-To: <mhng-1d66757a-1be0-4e46-8bbc-0568ceddfeb3@palmerdabbelt-glaptop>
References: <20210809012509.4983c1d6@xhacker>
        <mhng-1d66757a-1be0-4e46-8bbc-0568ceddfeb3@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygBXLv9CoSdhqJ3GAA--.14367S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1UXFWxWFyDXr43KF45Wrg_yoW8ur43pr
        4Ykw1qkr15CF1kZasrK34jgry8uw4agr1rGryrG348Wa4UXFW0qr17ta4aka1qyFWfJF18
        ZF4kGFyUCw4UA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        W3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
        JbIYCTnIWIevJa73UjIFyTuYvjxUgg_TUUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 23:47:02 -0700 (PDT)
Palmer Dabbelt <palmer@dabbelt.com> wrote:

> On Sun, 08 Aug 2021 10:25:09 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> > From: Jisheng Zhang <jszhang@kernel.org>
> >
> > Enable BUILDTIME_TABLE_SORT to sort the exception table at build time
> > then move exception table to RO_DATA segment.
> >
> > Jisheng Zhang (2):
> >   riscv: Enable BUILDTIME_TABLE_SORT
> >   riscv: Move EXCEPTION_TABLE to RO_DATA segment
> >
> >  arch/riscv/Kconfig                  | 1 +
> >  arch/riscv/kernel/vmlinux-xip.lds.S | 1 -
> >  arch/riscv/kernel/vmlinux.lds.S     | 4 ++--
> >  scripts/sorttable.c                 | 1 +
> >  4 files changed, 4 insertions(+), 3 deletions(-)  
> 
> This seems reasonable, but it's failing for some configurations (at 
> least tinyconfig) saying there is no __ex_table.  I'm not entirely sure 

Nice catch! tinyconfig in riscv means NOMMU which indicates no __ex_table at all.
It seems we have to only enable BUILDTIME_TABLE_SORT for MMU case.

will send out V2 soon.

Thanks

> how that comes about, as we've got them for futexes and uaccess.
> 
> Maybe the right thing to do here is to fix scripts/sorttable.c so it can 
> handle files with nothing to sort?  I think it's just as simple as a 
> successful early out like this
> 
> diff --git a/scripts/sorttable.h b/scripts/sorttable.h
> index a2baa2fefb13..207ddeddb506 100644
> --- a/scripts/sorttable.h
> +++ b/scripts/sorttable.h
> @@ -294,8 +294,9 @@ static int do_sort(Elf_Ehdr *ehdr,
>                 goto out;
>         }
>  #endif
> +       /* If there is no __ex_table section there is no work do to. */
>         if (!extab_sec) {
> -               fprintf(stderr, "no __ex_table in file: %s\n", fname);
> +               rc = 0;
>                 goto out;
>         }
> 
> I'm not entirely sure though -- my logic is essentially just "there's no 
> __ex_table, so there's nothing to sort, so just don't try".
> 
> All the configurations I can actually boot have an __ex_table, so I'm 
> not sure how to test that.
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


