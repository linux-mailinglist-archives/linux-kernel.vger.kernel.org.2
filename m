Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22D3892A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354869AbhESPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354777AbhESPbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:31:03 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94D8FC06138D
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=N5oDKef5Tw90YKktAChc3BuhuB4OG2LUMj
        wkINxvuoQ=; b=YaaX28Xs1QIo9I7RDkJMf4Wnm4I8OnNxzmn+1pnaxtorpKG6HQ
        KY0P0+zkGb7G+cdGQaeRi2ofJ9uUulqi/X9v9otymK+Yko6/hf3Ol6t2gD368Iap
        p5UsGbsbVeBU7hd5MqhhOwgrkw6HxLXVRfESoVULOZ7bTGAZYdtjUoEj4=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygD3iNO+LqVgf7MDAQ--.1274S2;
        Wed, 19 May 2021 23:29:02 +0800 (CST)
Date:   Wed, 19 May 2021 23:23:41 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: Fix W+X mappings at boot
Message-ID: <20210519232341.782bab6c@xhacker>
In-Reply-To: <35618c9a-acae-bc4f-e403-d06c0476166c@ghiti.fr>
References: <20210516170038.7de9c866@xhacker>
        <35618c9a-acae-bc4f-e403-d06c0476166c@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LkAmygD3iNO+LqVgf7MDAQ--.1274S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1UKFWfJw13Jr1kAw4fZrb_yoW7XFWDpF
        W5JwnxCrW8tw1xGr9Fkry5Zr1jqr1UA3W3tr17AF1rZF1UGw1jqr18Jr4xWFyq93ykZFn3
        tryqv3yUKw4qyaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
        GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5PpnJUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 May 2021 17:26:53 +0200
Alex Ghiti <alex@ghiti.fr> wrote:

> Hi Jisheng,

Hi Alex,

>=20
> On 16/05/2021 11:00, Jisheng Zhang wrote:
> > From: Jisheng Zhang <jszhang@kernel.org>
> >=20
> > When the kernel mapping was moved the last 2GB of the address space,
> > (__va(PFN_PHYS(max_low_pfn))) is much smaller than the .data section
> > start address, the last set_memory_nx() in protect_kernel_text_data()
> > will fail, thus the .data section is still mapped as W+X. This results
> > in below W+X mapping waring at boot. Fix it by passing the correct
> > .data section page num to the set_memory_nx().
> >=20
> > [    0.396516] ------------[ cut here ]------------
> > [    0.396889] riscv/mm: Found insecure W+X mapping at address (____ptr=
val____)/0xffffffff80c00000
> > [    0.398347] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/ptdump.c:258 not=
e_page+0x244/0x24a
> > [    0.398964] Modules linked in:
> > [    0.399459] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc1+ #14
> > [    0.400003] Hardware name: riscv-virtio,qemu (DT)
> > [    0.400591] epc : note_page+0x244/0x24a
> > [    0.401368]  ra : note_page+0x244/0x24a
> > [    0.401772] epc : ffffffff80007c86 ra : ffffffff80007c86 sp : ffffff=
e000e7bc30
> > [    0.402304]  gp : ffffffff80caae88 tp : ffffffe000e70000 t0 : ffffff=
ff80cb80cf
> > [    0.402800]  t1 : ffffffff80cb80c0 t2 : 0000000000000000 s0 : ffffff=
e000e7bc80
> > [    0.403310]  s1 : ffffffe000e7bde8 a0 : 0000000000000053 a1 : ffffff=
ff80c83ff0
> > [    0.403805]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 6c7e7a=
5137233100
> > [    0.404298]  a5 : 6c7e7a5137233100 a6 : 0000000000000030 a7 : ffffff=
ffffffffff
> > [    0.404849]  s2 : ffffffff80e00000 s3 : 0000000040000000 s4 : 000000=
0000000000
> > [    0.405393]  s5 : 0000000000000000 s6 : 0000000000000003 s7 : ffffff=
e000e7bd48
> > [    0.405935]  s8 : ffffffff81000000 s9 : ffffffffc0000000 s10: ffffff=
e000e7bd48
> > [    0.406476]  s11: 0000000000001000 t3 : 0000000000000072 t4 : ffffff=
ffffffffff
> > [    0.407016]  t5 : 0000000000000002 t6 : ffffffe000e7b978
> > [    0.407435] status: 0000000000000120 badaddr: 0000000000000000 cause=
: 0000000000000003
> > [    0.408052] Call Trace:
> > [    0.408343] [<ffffffff80007c86>] note_page+0x244/0x24a
> > [    0.408855] [<ffffffff8010c5a6>] ptdump_hole+0x14/0x1e
> > [    0.409263] [<ffffffff800f65c6>] walk_pgd_range+0x2a0/0x376
> > [    0.409690] [<ffffffff800f6828>] walk_page_range_novma+0x4e/0x6e
> > [    0.410146] [<ffffffff8010c5f8>] ptdump_walk_pgd+0x48/0x78
> > [    0.410570] [<ffffffff80007d66>] ptdump_check_wx+0xb4/0xf8
> > [    0.410990] [<ffffffff80006738>] mark_rodata_ro+0x26/0x2e
> > [    0.411407] [<ffffffff8031961e>] kernel_init+0x44/0x108
> > [    0.411814] [<ffffffff80002312>] ret_from_exception+0x0/0xc
> > [    0.412309] ---[ end trace 7ec3459f2547ea83 ]---
> > [    0.413141] Checked W+X mappings: failed, 512 W+X pages found
> >=20
> > Fixes: 2bfc6cd81bd17e43 ("riscv: Move kernel mapping outside of linear =
mapping")
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   arch/riscv/mm/init.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 4faf8bd157ea..4c4c92ce0bb8 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -746,14 +746,18 @@ void __init protect_kernel_text_data(void)
> >   	unsigned long init_data_start =3D (unsigned long)__init_data_begin;
> >   	unsigned long rodata_start =3D (unsigned long)__start_rodata;
> >   	unsigned long data_start =3D (unsigned long)_data;
> > -	unsigned long max_low =3D (unsigned long)(__va(PFN_PHYS(max_low_pfn))=
);
> > +#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
> > +	unsigned long end_va =3D kernel_virt_addr + load_sz;
> > +#else
> > +	unsigned long end_va =3D (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
> > +#endif
> >  =20
> >   	set_memory_ro(text_start, (init_text_start - text_start) >> PAGE_SHI=
FT);
> >   	set_memory_ro(init_text_start, (init_data_start - init_text_start) >=
> PAGE_SHIFT);
> >   	set_memory_nx(init_data_start, (rodata_start - init_data_start) >> P=
AGE_SHIFT);
> >   	/* rodata section is marked readonly in mark_rodata_ro */
> >   	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIF=
T);
> > -	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
> > +	set_memory_nx(data_start, (end_va - data_start) >> PAGE_SHIFT);
> >   }
> >  =20
> >   void mark_rodata_ro(void)
> >  =20
>=20
> Thank you for taking the time to fix this, I had read a report here=20
> https://github.com/starfive-tech/linux/issues/17 but had no time yet to=20

I didn't know this github repo, in fact I don't have a beaglev board ;)
=46rom the log, this is the same issue as I saw on Qemu.

> track this down.
>=20
> Your fix seems good to me, but it intrigued me to see that for 32b=20
> kernels, the whole linear mapping is mapped as executable and then here,=
=20
> we remove this attribute. So I came up with a patch to map the kernel=20
> correctly once at first time and avoid fixing this mapping afterwards. I=
=20

Your solution looks better.

> added you in cc of this patch, any comment is welcome.
>=20

I'm reading your patch. Will comment it soon.

Thanks


