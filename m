Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6FD3D4E4D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhGYOql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 10:46:41 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45673 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhGYOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 10:46:34 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M6DSo-1m16Sd1m5g-006jPr for <linux-kernel@vger.kernel.org>; Sun, 25 Jul
 2021 17:27:03 +0200
Received: by mail-wr1-f45.google.com with SMTP id w12so7843684wro.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 08:27:03 -0700 (PDT)
X-Gm-Message-State: AOAM5331e+qhQA0tCiggEZQNOI4YVC7/wxHBFQtZHYpMyGhp+yH/5uRW
        w62f5x7BGng2dHDepDhP/lrbylREDjClZ+1DOik=
X-Google-Smtp-Source: ABdhPJz+LrpWMcr3RgdECxl1tgvMH+HHI4zaLgGuepPsN9p5W1KckSbFbCirQqp5ev5fQBZ2kkE16ia/luyBzT/FH68=
X-Received: by 2002:adf:e107:: with SMTP id t7mr14882265wrz.165.1627226823080;
 Sun, 25 Jul 2021 08:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210725104618.365790-1-geert@linux-m68k.org>
In-Reply-To: <20210725104618.365790-1-geert@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 25 Jul 2021 17:26:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2qD3LFic8L_3-KCnuVL6J8M_SLFsdj0c-n258MsUPKuQ@mail.gmail.com>
Message-ID: <CAK8P3a2qD3LFic8L_3-KCnuVL6J8M_SLFsdj0c-n258MsUPKuQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix asm register constraints for atomic ops
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@uclinux.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9POAPdti3BXu1KKcAXBIMmmZqhM6Gm1czDMpyfXhMXZml+m15bd
 7MsmaoqUG35lo1ZGaKEe5ZXwYfSblZltdHLR48tYjRLMvw6xccvi4o4InwjVbET+9Q4+xCE
 6HQVL9YCo+QgfNyhfdBd3pnFJf+njcZcyTH2h5M07YYaSYgxyCa8XtjJNU4BjpPeQoSYu0m
 azO6ceIqqrwQrkG4X3WTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TRJD+djduPg=:6ElPWRKqOLDd0GyJvwFIDk
 TPWSq+Prg9S+v7e2/7dgzfKyL1p88rdnHQOLiCD6MmtqH14RRc3vdqYG2Wjkhn0HRMRQpzdEz
 fxQvAohmSC5aBU2d5H1k39jtsBbtng3rkWoLYrv3zRZ2mTDbHEsCOJFdPJYnL2ZL4tDef5DWu
 upikkkI5BkFO4vCq2I1UIGtjTdmkCZ1uynX2rVKKJKBMGirXCAMNJLoR+0cPXo7DGxRXhAYfG
 p0gTbkZsPAq4aKCuKND6tduwxe57S8dPpmVQPpibbHMWssRh3HIw24LXdwh3m7X5rAMoJqNqj
 ElwIHDEB5CwqQ6zZetHxrMm3KDfNCLifU2Yg5Yxu4q04MmPBoJAyiltH9TLbp1izM2Cn2uv5X
 e6BI+d2HKDtRVFy/oOjUQQbIjRQHGACcIbsoFnF1l3kFAxD4N8H50D8fAR21Ln0CEtXz18F0K
 jog6oWIq/9BFKfSUvpaCFja9YzVY2n/zJNYd232BTmgM1PGyzgmeM/ShZTw5AZKMuz4OgzXbE
 BsAqaBjKw0ZksMMecnD3W6Wb26I6WA8Ueits4+NgT+oFlGfBOSeJLA6QPEqXTLOY02cl3wRad
 l8uCda7r3nvdDb2WEFHd0DCZo3Wub+xXdwSdefPP5fljC0ZcNyiKysHdOcpjeHtmWujb2XFlX
 ePOxspZSspoD1Dk5txQC8ttRoc2OGOQEQuIWHdvr6EcVmHCS9mh0RrPw+Eh8Zsnljxeswnae/
 3vK2+v8zz3Wfo1i+XcfBA8na3Ao9kFe/rbHoutJV3R8LxScdtzMHdgGgyR8o1THbo6Ty3wN1I
 4KNMvjRernrR4NH7nEjmN1IFaPT70omDztzDe2SaIB1N0fEw88Yb4kB7C+jUNMTmuyJGaCAKK
 UF1CwgZAEuOvyuXSSOEJoVIQ9Cjb/amO8UnIfboOv6UWiIaTyMEO9Nsi9kUW/YLzkB65S8qis
 84H50pyQVJgKW/FtZjTzPO0pIg+Jkb+PopY4nv548OdaZiey1kuql
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2021 at 12:46 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Depending on register assignment by the compiler:
>
>     {standard input}:3084: Error: operands mismatch -- statement `andl %a1,%d1' ignored
>     {standard input}:3145: Error: operands mismatch -- statement `orl %a1,%d1' ignored
>     {standard input}:3195: Error: operands mismatch -- statement `eorl %a1,%d1' ignored
>
> Indeed, the first operand must not be an address register.  Fix this by
> adjusting the register constraint from "g" (general purpose register) to
> "d" (data register).
>
> Fixes: e39d88ea3ce4a471 ("locking/atomic, arch/m68k: Implement atomic_fetch_{add,sub,and,or,xor}()")
> Fixes: d839bae4269aea46 ("locking,arch,m68k: Fold atomic_ops")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Alexander Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Personally, I have never seen this failure in an 68020+ build, but I can
> reproduce it on Coldfire with the config provided by lkp (with bogus
> CONFIG_RMW_INSNS=y).

This fixed the problem for me in the 68020 build with all compiler versions.

Tested-by: Arnd Bergmann <arnd@arndb.de>
