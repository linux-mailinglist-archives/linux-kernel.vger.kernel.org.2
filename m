Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D9B3B1DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhFWPkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:40:19 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60215 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhFWPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:40:19 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MfqCF-1lKXCo30JN-00gHdF; Wed, 23 Jun 2021 17:37:59 +0200
Received: by mail-wr1-f46.google.com with SMTP id h11so3155246wrx.5;
        Wed, 23 Jun 2021 08:37:59 -0700 (PDT)
X-Gm-Message-State: AOAM532Iic5skdug6B0NJgIQNYsmMt5ULEVDPRbsWVwWzfPqf7Jh3pnH
        iiQDP4n0F7pL+CpvDjVw8BAn/zEjtZeUXqFMjYM=
X-Google-Smtp-Source: ABdhPJyBbj5Pm/lt5QEZ9/ukavK4e4a6Akcrh3OkRCgWAd0YKSJxsqqB9rr7QOm5LlXYeAiFQ5/m9Hb73+YYGuKylew=
X-Received: by 2002:a5d:5650:: with SMTP id j16mr736136wrw.99.1624462679365;
 Wed, 23 Jun 2021 08:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
 <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com>
 <08e101d76842$94f78a60$bee69f20$@codeaurora.org> <20210623151746.GA4247@lst.de>
In-Reply-To: <20210623151746.GA4247@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Jun 2021 17:35:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com>
Message-ID: <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com>
Subject: Re: how can we test the hexagon port in mainline
To:     Christoph Hellwig <hch@lst.de>
Cc:     Brian Cain <bcain@codeaurora.org>,
        Sid Manning <sidneym@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UVrRONGH7WEEgxmi9CsYT9lyiBJLfqqh+xpmwQxeq9OlN0ToPuk
 4vdYpzs8xI1FotMDS22WTPQAbNxOIrgLt48U2+rSlNIdON3SzLbcIbjUrvrT3ZaWOU0sEbC
 Z3dWPz/je7k+I6uZW3VzA0GI/LI+4UolwWOWKvCnvAIoCM0Y8uEOL5prf55GJ62FUFUPG6T
 UMrT/aQfrHKAxHNcsIEHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LU7Yf9EZG/E=:4cqFOmEps5v8tnKljicZXN
 4LXmehJrCAWtvh82GsxVK3TfgfQZtEUp9gp8k3dX2sk8MWdPLppwZFdEhBg0QMYj86K63YPak
 Lnr9vcchEG1hYMRE91H+tugnhVK9McORmtdz+aW+jhwOziJRE/9cLSXBxjwoL6qS8yAcoeHkl
 ORoVZ586/U5V6sJW5TElsD8Sf1i3712coGBJv06+pawEVi35XB57pEMyzNlLKqVYzCRsue+r6
 lUO97EqX/HjZlrPH7iJsOziBnvIEOZEentXIDYzwAec5HmOmsGHzmpyW4ZaGuzaNtRWXFtMZX
 JtsSnjrbAwi3davxBRYsy4SIlM1FPrJz9M+BvamcQ6qKWjVWs/R9cc6U2AUuL2ve8NoxXdKD/
 KTjO1SSzDCFiTX9dl9rAIXVQJ0Gb9YsZDHPyqHdeak1M9WZwTyyatHE6pjCsgm4vKbX2pDzod
 0O4HDNyL1A9ZUmph1tCp3oAtFFhXlEoiQi8eiWJv5hi+nxrlMrz+1TBfeEwIHNKtCbxpwblO0
 0N6OvWJG2xwrXDOyrJ8yYQ8dTSw8Lj7XNP+StINHC2NDHApxF0l/ITVJs/msEj2ZWqAjF2f1X
 9nm6BRqRq62FzyZYNRYGJ9JM5Qf/gPeZe0+kgK2ZdiJFrQLV+EB8HCwMbGBNJwpZPO9EuDLMl
 sofM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 5:17 PM Christoph Hellwig <hch@lst.de> wrote:
>
> It seem like it still isn't complete enought for a kernel build, though:
>
> $ export CROSS_COMPILE=/opt/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/hexagon-unknown-linux-musl-
> $ make ARCH=hexagon LLVM=1 oldconfig
> ...
> scripts/Kconfig.include:40: linker 'ld.lld' not found

I tried this using the prebuilt binaries from apt.llvm.org:

$ make ARCH=hexagon LLVM=1 O=obj-hexagon CROSS_COMPILE=hexagon-linux-
LLVM_IAS=1 CC=llvm-12 defconfig modules vmlinux
<stdin>:1515:2: warning: syscall clone3 not implemented [-W#warnings]
#warning syscall clone3 not implemented
 ^
1 warning generated.

Doing the same thing with allmodconfig results in an internal error
with clang-12
while compiling kernel/locking/lockdep.c. Same thing with clang-13.
After turning
off lock debugging, it seems fine.

       Arnd
