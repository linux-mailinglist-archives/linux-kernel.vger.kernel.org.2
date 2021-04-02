Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4908E352B12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhDBNhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhDBNhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:37:14 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07C4DC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=tZ/LaANIi5M7NtxlP10sRG+XBo+hd4rG5q
        oxm75toyo=; b=PONDGZ1YFHa6lf9fRfKb0aqAiq72Q3hH/M+WnB59LbD4AI3vkb
        TnEPvgc8X7CZbveXLxz5Gj1RvGzpCbKn6/byBaRxFWMb+Hl8PaTJ906+JSb7p7sZ
        olfHi/XLf04+d4GMzyBFTuSyzCndjzLzwyz8Qow2ekl0IYgz5yCTkeME8=
Received: from xhacker (unknown [101.86.19.180])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAXIqz_HWdgWQSLAA--.8753S2;
        Fri, 02 Apr 2021 21:37:04 +0800 (CST)
Date:   Fri, 2 Apr 2021 21:32:06 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     "liaochang (A)" <liaochang1@huawei.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: keep interrupts disabled for BREAKPOINT
 exception
Message-ID: <20210402213206.7db93785@xhacker>
In-Reply-To: <096752a7-21f9-8339-2e76-8c65859fa1d7@huawei.com>
References: <20210330021624.2b776386@xhacker>
        <20210330183316.942215efe8e6e8455ad14113@kernel.org>
        <20210331222244.45a5807c@xhacker>
        <096752a7-21f9-8339-2e76-8c65859fa1d7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LkAmygAXIqz_HWdgWQSLAA--.8753S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF45trWrAr4xCFW7WF1Dtrb_yoW8AryrpF
        WDJa15KF4kJw18Cas2yw1F9ryFyayrGrWfur98Cw1ftrsxt3s5JryIgFW3Wr1rGr12kw1S
        vFWYyry2qa48ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        W3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1GQ6JUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 16:49:47 +0800
"liaochang (A)" <liaochang1@huawei.com> wrote:

> Hi Jisheng,

Hi,

>=20
> =E5=9C=A8 2021/3/31 22:22, Jisheng Zhang =E5=86=99=E9=81=93:
> > On Tue, 30 Mar 2021 18:33:16 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >  =20
> >> Hi Jisheng, =20
> >=20
> > Hi Masami,
> >  =20
> >>
> >> On Tue, 30 Mar 2021 02:16:24 +0800
> >> Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
> >> =20
> >>> From: Jisheng Zhang <jszhang@kernel.org>
> >>>
> >>> Current riscv's kprobe handlers are run with both preemption and
> >>> interrupt enabled, this violates kprobe requirements. Fix this issue
> >>> by keeping interrupts disabled for BREAKPOINT exception.   =20
> >>
> >> Not only while the breakpoint exception but also until the end of
> >> the single step (maybe you are using __BUG_INSN_32 ??) need to be
> >> disable interrupts. Can this do that?
> >> =20
> >=20
> > interrupt is disabled during "single step" by kprobes_save_local_irqfla=
g()
> > and kprobes_restore_local_irqflag(). The code flow looks like:=20
> >=20
> > do_trap_break()   // for bp
> >   kprobe_breakpoint_handler()
> >     setup_singlestep()
> >       kprobes_restore_local_irqflag()
> >=20
> > do_trap_break()  // for ss
> >   kprobe_single_step_handler()
> >     kprobes_restore_local_irqflag() =20
>=20
> Recently, kernel hit BUG_ON() on QEMU after I install a probe at "sys_rea=
d" via kprobe,

TIPS: Each line should not exceed 80 chars

> accoriding to my debugging and analysis it looks like caused by the "irq =
disable" operation for single-stepping.
>=20
> I present a detailed description about this problem in the mail with titl=
e "[PATCH] riscv/kprobe: fix kernel panic when invoking sys_read traced by =
kprobe".
> Looking forward to some feedback,Thanks.
>=20

I will comment that patch.

thanks

