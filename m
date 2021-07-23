Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E650F3D33C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 06:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhGWDzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 23:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhGWDza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 23:55:30 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E91BC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 21:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=QbTlxn9eNvcRhBOBCVeh2QYtVCInFts4u5
        beNPEGQnc=; b=sSQhnsyJNfC/M5v9gQ3iNxU8w4XFxBPNG/B6MIhFsCy8GeEqg/
        axSK/20lfKoUy+sZSpXqQtXSQBTB7PLSqa0yOwG7/ui0ibtbN37/z8BHHQjyTw4w
        zKfzOxpG48gsxjcNgQ+ivdua9TYvTikU9d2tGdbjgkEZ+l6mgkBbyNH3U=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygB3fm4KR_pg5NUxAA--.1434S2;
        Fri, 23 Jul 2021 12:35:23 +0800 (CST)
Date:   Fri, 23 Jul 2021 12:29:25 +0800
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
Message-ID: <20210723122925.67a14562@xhacker>
In-Reply-To: <52e3626a-2b40-bda6-de0e-68ea12a86dd9@huawei.com>
References: <87bl6yrcmd.fsf@igel.home>
        <mhng-e14c3232-cc4d-4146-8c93-c60ec81ed272@palmerdabbelt-glaptop>
        <CAOnJCU+Ss0cO1mqr=GDVnpxV075uR+KipSnr7dN93099dAH+vQ@mail.gmail.com>
        <20210722213724.1f12a0e7@xhacker>
        <87zguexslf.fsf@igel.home>
        <20210723075432.098634a2@xhacker>
        <52e3626a-2b40-bda6-de0e-68ea12a86dd9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LkAmygB3fm4KR_pg5NUxAA--.1434S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw45Jr1UCry5XF18tr1kKrg_yoW8Wr18pF
        WUGay3tF4qva4xK3Z2qw18Wa409an7Ja45u3s5Xr13ZFZYg3Z5Xr4IgrWUKFW7Ww1IkayY
        vr4FqFZ7Wrs8Ja7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyIb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
        0_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
        6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7GYLDUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 09:36:47 +0800
tongtiangen <tongtiangen@huawei.com> wrote:

> On 2021/7/23 7:54, Jisheng Zhang wrote:
> > On Thu, 22 Jul 2021 17:42:52 +0200
> > Andreas Schwab <schwab@linux-m68k.org> wrote:
> > =20
> >> On Jul 22 2021, Jisheng Zhang wrote:
> >> =20
> >>> I think we need to pin the stack before calling get_wchan(), could yo=
u please
> >>> try below patch? =20
> >>
> >> Thanks, this fixes the crash for me.
> >>
> >> Andreas.
> >> =20
> >
> > Thanks for testing. I will send out formal patch later
> >
> > Thanks
> >
> > .
> > =20
>=20
> Hi all:
> I tried to reproduced this crash in openSUSE code repo=EF=BC=88=20
> https://github.com/opensuse/kernel =EF=BC=89, but not reproduced successf=
ully.
>=20
>  From the patch of problem repair, the crash is due to task->stack is=20
> released before calling get_wchan, the task state of maybe TASK_DEAD.
>=20
> VMAP_STACK is used to detect kernel stack overflow, there is no=20
> connection between the two, it makes me a little confused.

I believe the bug exists from the first day of riscv mainlined.

Since THREAD_INFO_IN_TASK=3Dy in riscv, so when task stack can be freed
before being destroyed.

When VMAP_STACK=3Dn, task's stack is allocated from linear mapping. When
task stack is freed, the corresponding mapping still exists, and since
get_wchan() only read, no harm is observed so far.

When VMAP_STACK=3Dy, task's stack is allocated from vmalloc area. When
task stack is freed, the corresponding mapping may not exist, so I expect
MMU fault here, thus the kernel panic.

In summary, the bug isn't related with VMAP_STACK, but VMAP_STACK makes
the bug observable.

Thanks


