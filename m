Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A2B410705
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 16:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbhIROZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 10:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbhIROZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 10:25:18 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 604E2C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=crGu5Ix8RGnS81l9weqFdrV+bdJ/ykn6g7
        LznH09ImM=; b=KlLIDMji0jKgdLYqe1kKdPBEJKEmQ/+DjJVdNxdruF4XPZ/wNb
        q/rE3CGOYWsPdOk7vtiutxvl7M7QGWs72Be36DqDLpV7gloHvOzpD+Jjt1+5kQM8
        7IQ1B67PdqZ76vI1Rgp7+BRr4PIFB2RURFbCMkwNyCuTvpzFXf+cfqNZE=
Received: from xhacker (unknown [101.86.20.138])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBnb7tw9kVhXP4YAA--.2092S2;
        Sat, 18 Sep 2021 22:23:45 +0800 (CST)
Date:   Sat, 18 Sep 2021 22:17:13 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Chen Huang <chenhuang5@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Darius Rad <darius@bluespec.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] riscv: improve unaligned memory accesses
Message-ID: <20210918221713.289f63bb@xhacker>
In-Reply-To: <9200c4c2-44b9-480e-6970-5188640fb00a@huawei.com>
References: <20210916130855.4054926-1-chenhuang5@huawei.com>
        <20210917221429.4d3a15ca@xhacker>
        <9200c4c2-44b9-480e-6970-5188640fb00a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LkAmygBnb7tw9kVhXP4YAA--.2092S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1kJF4kCryUXF1rur13twb_yoW5GFW5pa
        1UCFnI9FZ8tr1xGFZ2qwn5uF1Yv3yfWFy7Jr43t34UuF1qvFy7Zr42gFWDGasxJrn7C34j
        gr4SvFnrua45Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
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

On Sat, 18 Sep 2021 09:14:05 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> On 2021/9/17 22:14, Jisheng Zhang wrote:
> > On Thu, 16 Sep 2021 13:08:53 +0000
> > Chen Huang <chenhuang5@huawei.com> wrote:
> > =20
> >> The patchset improves RISCV unaligned memory accesses, selects
> >> HAVE_EFFICIENT_UNALIGNED_ACCESS if CPU_HAS_NO_UNALIGNED not
> >> enabled and supports DCACHE_WORD_ACCESS to improve the efficiency
> >> of unaligned memory accesses.
> >>
> >> If CPU don't support unaligned memory accesses for now, please
> >> select CONFIG_CPU_HAS_NO_UNALIGNED. For I don't know which CPU
> >> don't support unaligned memory accesses, I don't choose the
> >> CONFIG for them. =20
> > This will break unified kernel Image for riscv. Obviously, we will have
> > two images for efficient unaligned access platforms and non-efficient
> > unaligned access platforms. IMHO, we may need alternative mechanism or
> > something else to dynamically enable related code path. =20
>=20
> it won't break unified kernel Image for riscv, if one SoC choose
>=20
> CPU_HAS_NO_UNALIGNED, the single Image won't support unaligned memory

the "unified" means the kernel Image has to support all RV64GC or RV32GC So=
Cs.
To make the Image works for both efficient unaligned access and inefficient
unaligned access, I think we'd better make "inefficient unaligned access"
default behavior, the use alternative etc. tech to patch related code path
for efficient unaligned access.


>=20
> accesses, indeed, it depends on the CONFIG, and now, arm/powerpc/m68k has

linux Distributions doesn't have enough background of which config options
must be enabled.

>=20
> similar configuration.

I have little knowledge of powerpc or m68k, but there are serveral different
defconfig files for arm, for example multi_v7_defconfig and multi_v5_defcon=
fig.
The previous v7 version enables HAVE_EFFICIENT_UNALIGNED_ACCESS while
the later v5 doesn't. Will you persuade riscv maintainers to accept one more
defconfig file?

Thanks

>=20
> Yes,=C2=A0 it could be an optimization via alternative mechanism or somet=
hing=20
> else to
>=20
> dynamically enable related code path later.
>=20
> >
> > Regards
> > =20
> >> Changes since v1:
> >>   - As Darius Rad and Jisheng Zhang mentioned, some CPUs don't support
> >>     unaligned memory accesses, add an option for CPUs to choose it or =
not.
> >>
> >> Chen Huang (2):
> >>    riscv: support HAVE_EFFICIENT_UNALIGNED_ACCESS
> >>    riscv: Support DCACHE_WORD_ACCESS
> >>
> >>   arch/riscv/Kconfig                      |  5 ++++
> >>   arch/riscv/include/asm/word-at-a-time.h | 37 +++++++++++++++++++++++=
++
> >>   2 files changed, 42 insertions(+)
> >> =20
> >
> > .
> > =20


