Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097AD3D33D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 06:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhGWEF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 00:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhGWEF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 00:05:57 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9A76C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 21:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=RmTFR5sHYq+p4KauoZP/+FHafSyPUXZ/4/
        /YrkOuHv4=; b=AuaH15T+Drpa92yftNj9Ipz3eeGHqMV0QiPOFACxcspsLszpUF
        2ULlnO22Qm3w+a758nws38HBc22FbjlIYt3xhoZzSdRUxhDaKn3jAqrEuwb5SAzu
        +r7Wqs8XLQKzS++dO9OSK4a9o1Qbx44q6lMHnb8dRuV+ozzygU6cUB7Qw=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygA3Pv6bSfpgdPkxAA--.1487S2;
        Fri, 23 Jul 2021 12:46:19 +0800 (CST)
Date:   Fri, 23 Jul 2021 12:40:25 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     tongtiangen <tongtiangen@huawei.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] riscv: add VMAP_STACK overflow detection
Message-ID: <20210723124025.669cb4ec@xhacker>
In-Reply-To: <20210723122925.67a14562@xhacker>
References: <87bl6yrcmd.fsf@igel.home>
        <mhng-e14c3232-cc4d-4146-8c93-c60ec81ed272@palmerdabbelt-glaptop>
        <CAOnJCU+Ss0cO1mqr=GDVnpxV075uR+KipSnr7dN93099dAH+vQ@mail.gmail.com>
        <20210722213724.1f12a0e7@xhacker>
        <87zguexslf.fsf@igel.home>
        <20210723075432.098634a2@xhacker>
        <52e3626a-2b40-bda6-de0e-68ea12a86dd9@huawei.com>
        <20210723122925.67a14562@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LkAmygA3Pv6bSfpgdPkxAA--.1487S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4DXw4rWF47JFykArWfAFb_yoW8ZrW5pF
        WUAa1akF4DJF1Ik3Z7Kw18Wa409Fs7A345Z3s5XF13AF9Yqa1rXr42gF45Ka47Gr13C3WY
        vr48KF97Ww45Ja7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyIb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
        6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7y89DUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 12:29:25 +0800
Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:

> On Fri, 23 Jul 2021 09:36:47 +0800
> tongtiangen <tongtiangen@huawei.com> wrote:
>=20
> > On 2021/7/23 7:54, Jisheng Zhang wrote: =20
> > > On Thu, 22 Jul 2021 17:42:52 +0200
> > > Andreas Schwab <schwab@linux-m68k.org> wrote:
> > >   =20
> > >> On Jul 22 2021, Jisheng Zhang wrote:
> > >>   =20
> > >>> I think we need to pin the stack before calling get_wchan(), could =
you please
> > >>> try below patch?   =20
> > >>
> > >> Thanks, this fixes the crash for me.
> > >>
> > >> Andreas.
> > >>   =20
> > >
> > > Thanks for testing. I will send out formal patch later
> > >
> > > Thanks
> > >
> > > .
> > >   =20
> >=20
> > Hi all:
> > I tried to reproduced this crash in openSUSE code repo=EF=BC=88=20
> > https://github.com/opensuse/kernel =EF=BC=89, but not reproduced succes=
sfully.
> >=20
> >  From the patch of problem repair, the crash is due to task->stack is=20
> > released before calling get_wchan, the task state of maybe TASK_DEAD.
> >=20
> > VMAP_STACK is used to detect kernel stack overflow, there is no=20
> > connection between the two, it makes me a little confused. =20
>=20
> I believe the bug exists from the first day of riscv mainlined.
>=20
> Since THREAD_INFO_IN_TASK=3Dy in riscv, so when task stack can be freed
> before being destroyed.

typo: task stack can be freed before task is destroyed

>=20
> When VMAP_STACK=3Dn, task's stack is allocated from linear mapping. When
> task stack is freed, the corresponding mapping still exists, and since
> get_wchan() only read, no harm is observed so far.
>=20
> When VMAP_STACK=3Dy, task's stack is allocated from vmalloc area. When
> task stack is freed, the corresponding mapping may not exist, so I expect
> MMU fault here, thus the kernel panic.
>=20
> In summary, the bug isn't related with VMAP_STACK, but VMAP_STACK makes
> the bug observable.
>=20
> Thanks
>=20
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


