Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C833D4887
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 18:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhGXP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 11:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGXP3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 11:29:12 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 577BDC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=GAR4WWqAXHVgE5qg2lxEmsawH6VzLA7G6o
        qKmn9MhG0=; b=vARQtY1nDQKC1pwGtR68vqFZtjr/vwNUZIl2fqttkiMKIBpv/6
        j12/vL8IB7AwXjCBtD+cvfvJuyVh9VofF3OSlygCJv4t7RxoCk29vkZP5ajjd9LF
        oXtDich8vvxMGI0i2tOr2NyXbxt4Sgz9SpO6lS0nTffYNwgybiW0z2AG8=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAnL3cdO_xgxE0+AA--.8738S2;
        Sun, 25 Jul 2021 00:09:01 +0800 (CST)
Date:   Sun, 25 Jul 2021 00:02:58 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] riscv: stacktrace: Fix NULL pointer dereference
Message-ID: <20210725000258.1ca59266@xhacker>
In-Reply-To: <CAOnJCU+h9uwBP57Nhh2tX9boOeQ9eV-_jjY0zSzUqhmi2Ptd2A@mail.gmail.com>
References: <20210716214051.32eea3a8@xhacker>
        <CAOnJCU+h9uwBP57Nhh2tX9boOeQ9eV-_jjY0zSzUqhmi2Ptd2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygAnL3cdO_xgxE0+AA--.8738S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryftrWUZF1DJw1xKF13twb_yoWrCrWfpF
        15JF17CrW8Jr1xtw17tr15ZF15Ar1DAa43Jr9xAr1FyFyUWr1UXw18tFW5WF1qyrn5Ja4x
        trn0gws2vr4DJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy2b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
        0_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
        6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOb18UUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi @Palmer,

On Fri, 16 Jul 2021 07:07:24 -0700
Atish Patra <atishp@atishpatra.org> wrote:

> On Fri, Jul 16, 2021 at 6:47 AM Jisheng Zhang wrote:
> >
> > From: Jisheng Zhang <jszhang@kernel.org>
> >
> > When CONFIG_FRAME_POINTER=y, calling dump_stack() can always trigger
> > NULL pointer dereference panic similar as below:
> >
> > [    0.396060] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc5+ #47
> > [    0.396692] Hardware name: riscv-virtio,qemu (DT)
> > [    0.397176] Call Trace:
> > [    0.398191] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000960
> > [    0.399487] Oops [#1]
> > [    0.399739] Modules linked in:
> > [    0.400135] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc5+ #47
> > [    0.400570] Hardware name: riscv-virtio,qemu (DT)
> > [    0.400926] epc : walk_stackframe+0xc4/0xdc
> > [    0.401291]  ra : dump_backtrace+0x30/0x38
> > [    0.401630] epc : ffffffff80004922 ra : ffffffff8000496a sp : ffffffe000f3bd00
> > [    0.402115]  gp : ffffffff80cfdcb8 tp : ffffffe000f30000 t0 : ffffffff80d0b0cf
> > [    0.402602]  t1 : ffffffff80d0b0c0 t2 : 0000000000000000 s0 : ffffffe000f3bd60
> > [    0.403071]  s1 : ffffffff808bc2e8 a0 : 0000000000001000 a1 : 0000000000000000
> > [    0.403448]  a2 : ffffffff803d7088 a3 : ffffffff808bc2e8 a4 : 6131725dbc24d400
> > [    0.403820]  a5 : 0000000000001000 a6 : 0000000000000002 a7 : ffffffffffffffff
> > [    0.404226]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 0000000000000000
> > [    0.404634]  s5 : ffffffff803d7088 s6 : ffffffff808bc2e8 s7 : ffffffff80630650
> > [    0.405085]  s8 : ffffffff80912a80 s9 : 0000000000000008 s10: ffffffff804000fc
> > [    0.405388]  s11: 0000000000000000 t3 : 0000000000000043 t4 : ffffffffffffffff
> > [    0.405616]  t5 : 000000000000003d t6 : ffffffe000f3baa8
> > [    0.405793] status: 0000000000000100 badaddr: 0000000000000960 cause: 000000000000000d
> > [    0.406135] [<ffffffff80004922>] walk_stackframe+0xc4/0xdc
> > [    0.407032] [<ffffffff8000496a>] dump_backtrace+0x30/0x38
> > [    0.407797] [<ffffffff803d7100>] show_stack+0x40/0x4c
> > [    0.408234] [<ffffffff803d9e5c>] dump_stack+0x90/0xb6
> > [    0.409019] [<ffffffff8040423e>] ptdump_init+0x20/0xc4
> > [    0.409681] [<ffffffff800015b6>] do_one_initcall+0x4c/0x226
> > [    0.410110] [<ffffffff80401094>] kernel_init_freeable+0x1f4/0x258
> > [    0.410562] [<ffffffff803dba88>] kernel_init+0x22/0x148
> > [    0.410959] [<ffffffff800029e2>] ret_from_exception+0x0/0x14
> > [    0.412241] ---[ end trace b2ab92c901b96251 ]---
> > [    0.413099] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> >
> > The reason is the task is NULL when we finally call walk_stackframe()
> > the NULL is passed from __dump_stack():
> >
> > |static void __dump_stack(void)
> > |{
> > |        dump_stack_print_info(KERN_DEFAULT);
> > |        show_stack(NULL, NULL, KERN_DEFAULT);
> > |}
> >
> > Fix this issue by checking "task == NULL" case in walk_stackframe().
> >
> > Fixes: eac2f3059e02 ("riscv: stacktrace: fix the riscv stacktrace when CONFIG_FRAME_POINTER enabled"

Missed a ")" at the end here, do you want a resend?

PS: This patch is missed for twice.

Thanks

> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/kernel/stacktrace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> > index bde85fc53357..7bc8af75933a 100644
> > --- a/arch/riscv/kernel/stacktrace.c
> > +++ b/arch/riscv/kernel/stacktrace.c
> > @@ -27,7 +27,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
> >                 fp = frame_pointer(regs);
> >                 sp = user_stack_pointer(regs);
> >                 pc = instruction_pointer(regs);
> > -       } else if (task == current) {
> > +       } else if (task == NULL || task == current) {
> >                 fp = (unsigned long)__builtin_frame_address(1);
> >                 sp = (unsigned long)__builtin_frame_address(0);
> >                 pc = (unsigned long)__builtin_return_address(0);
> > --
> > 2.32.0
> >
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv  
> 
> 
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
> 


