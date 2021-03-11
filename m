Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE543373F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhCKNae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:30:34 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:60205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbhCKNaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:30:22 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MvaSG-1lchYb2wze-00sgQN for <linux-kernel@vger.kernel.org>; Thu, 11 Mar
 2021 14:30:19 +0100
Received: by mail-ot1-f49.google.com with SMTP id j8so1477327otc.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:30:19 -0800 (PST)
X-Gm-Message-State: AOAM531umgbj+FCnJDceJRj4GaRiccARmpNrIKaTG+8UWnUzL24+IEMY
        6eLs7SDYjwURX1TzIu7IEy8j0CBZiP1x4UoCfxg=
X-Google-Smtp-Source: ABdhPJymJfvkqhsENJytHtyhy6y8b5actQdcwjySPRN08LMSa8kvGEpzyFf8CrwqONTlnOL2eXvcvSlTLpRKBcQsagg=
X-Received: by 2002:a05:6830:14c1:: with SMTP id t1mr6862240otq.305.1615469418444;
 Thu, 11 Mar 2021 05:30:18 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
In-Reply-To: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Mar 2021 14:30:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
Message-ID: <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Aa7MmQe2MEXA4G+p5zJjn7wbyzQb/sWKnviGys8nTh6SAJBDzMk
 zx420cCayQE2lGohzpTbp0NO2J8uvIDg9073J2f+Fn+Nw35pS+yQB/GwfEJ9XFrPNep+UgE
 pEhWWcwOAmKQsY2iyIpNI2iq74/jqsa3W1OlXcv/ouOVyZED596bbxpV1d+zT9kKbZZs/V5
 ZdrcWzBl9D/rPE0lpiz+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VRGwYrMgOFA=:Kf/IH8IcFioSuUAiWaanCv
 8m2SHCtkEQA/Zt95jxgTo34cNCeWSVv7/XBuUhtytwKjiaawsV2ggv3xvDUzBQSoXl33aTcDH
 EXcw9HtawL6F7yw6BR1npYHGBInrcHN/qt0O9yLuyDd9yjGwUENdNVJI6sMcWRloywmjbEf8R
 v3Z5AWcyak/IoJAJFUoBEsCjwdyFRxKZt7a0uuPZnVSvRpx5zZF1IphT8Lncxg7x1lIMdWSdW
 Dy9aqGXFBvbYcHSNiQAhBYzeCG5A/Yz6k0q+zaNKcv/WP6oqFhSFEHBLMid5OJePDhzcurg4g
 0o3CXQObvdiGY+aVWGuuXh7LM1Vg7FlCWli82p6mPyfI4Yn/h6bg6E/YxRel5Xy+oxQ4O6lYl
 TQuZF0YlGsEgy21tbX+t9kppiZVd7asSS+XDEZn44Eu9FBWiWAPJKAFfMsytB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:38 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> The instances found few arm64-specific issues that we have not
> observed on other instances:

I've had a brief look at these:

> https://syzkaller.appspot.com/bug?id=1d22a2cc3521d5cf6b41bd6b825793c2015f861f

This one  doesn't seem arm64 specific at all. While the KASAN report has shown
up on arm64, the link to
https://syzkaller.appspot.com/bug?id=aa8808729c0a3540e6a29f0d45394665caf79dca
seems to be for x86 machines running into the same problem.

Looking deeper into the log, I see that fw_load_sysfs_fallback() finds
an existing
list entry on the global "pending_fw_head" list, which seems to have been freed
earlier (the allocation listed here is not for a firmware load, so presumably it
was recycled in the meantime). The log shows that this is the second time that
loading the regulatory database failed in that run, so my guess is that it was
the first failed load that left the freed firmware private data on the
list, but I
don't see how that happened.

> https://syzkaller.appspot.com/bug?id=bb2c16b0e13b4de4bbf22cf6a4b9b16fb0c20eea

This one rings a bell: opening a 8250 uart on a well-known port must fail
when no I/O ports are registered in the system, or when the PCI I/O ports
are mapped to an invalid area.

It seems to be attempting a register access at I/O port '1' (virtual
address 0xfffffbfffe800001 is one byte into the well-known PCI_IOBASE),
which is an unusual place for a UART, traditional PCs had it at 0x3F8.

This could be either a result of qemu claiming to support a PIO based UART
at the first available address, or the table of UARTS being uninitialized
.bss memory.

Definitely an arm64 specific bug.

> https://syzkaller.appspot.com/bug?id=b75386f45318ec181b7f49260d619fac9877d456

A freed entry on the timer list caused a bug when adding another entry.

The allocation from alloc_fdtable does not seem to be the one at fault,
as the fdtable does not contain a timer. Several of the linked kasan reports
point to ext4_fill_super() as the code that allocated and freed the timer
list entry, so it's possible that this is the same timer that later fails to
be inserted if we ever get to kfree(sbi) without killing the timer first.

I don't see how that could happen, but the code was recently rewritten
in c92dc856848f ("ext4: defer saving error info from atomic context")

> https://syzkaller.appspot.com/bug?id=5a1bc29bca656159f95c7c8bb30e3776ca860332

I see that reiserfs_xattr_jcreate_nblocks() is dereferencing a NULL
inode pointer -- inode->i_sb has offset 0x30. However, that doesn't
make any sense with the call chain, as the pointer was newly allocated
and checked for NULL.

      Arnd
