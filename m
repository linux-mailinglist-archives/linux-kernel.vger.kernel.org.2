Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C33BF0C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGGUfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:35:17 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34889 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhGGUfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:35:16 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MacjC-1lTo9A15lS-00c9qk for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021
 22:32:34 +0200
Received: by mail-wr1-f49.google.com with SMTP id u8so4532250wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 13:32:34 -0700 (PDT)
X-Gm-Message-State: AOAM531Fdq24I7PWuAl9Ov3izobJQPjNr045TN89FfYJIDnO43BDHcne
        8wxDPebhL7KvIV2TLC/xC1F1wFjumqROVdyvn1Y=
X-Google-Smtp-Source: ABdhPJy5VJu6z99q3WHol0nhDN/0Tj/f1dApJZX2WjGYW0msrEn7r8yPypCRoa8aEUTZStmiUyCIyFYosfATXOPW91Q=
X-Received: by 2002:adf:e107:: with SMTP id t7mr30232628wrz.165.1625689953891;
 Wed, 07 Jul 2021 13:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210704230137.28915-1-rdunlap@infradead.org> <024360ce-41b2-c072-f399-7e87f516bfd0@linux-m68k.org>
In-Reply-To: <024360ce-41b2-c072-f399-7e87f516bfd0@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Jul 2021 22:32:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3sqC4nFsP=3cnz-zYjKRLHun5NSgSF31ZJErsYX7yP=g@mail.gmail.com>
Message-ID: <CAK8P3a3sqC4nFsP=3cnz-zYjKRLHun5NSgSF31ZJErsYX7yP=g@mail.gmail.com>
Subject: Re: [PATCH] m68k/coldfire: change pll var. to clk_pll
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        uclinux-dev@uclinux.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8zyvy0k7VUBXfHNNdRrphHrlIN0OxkAKRYe87MQIU6yg/njnWQs
 ivzttn9z1v6UWX0AydQ1zE+IFTPkPY1wY3OIHs21zwlCKh5rOWiNPPv90lgvDwKTY3oyeLG
 5QFiYkZVmgYiIhW8NooCWCef9nG+ykhcsT9Y0bbzDYxOm6KP31Hgr5vVfhJ/B7I4UZEO2w1
 ojTraAD/uMbODHRBg8JcQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RzIAP7G8+2M=:If51RreiZLeXWANPpgsJlm
 gBfWNRy+HTJIzfktXM6ffkUsgXNHVwz4f/MQsT1YXTW4zZ46iVSnsbWqAyCmz8ZaibyLYVPpO
 xGzaQRQ+QnPysiJ7YYu5YxmWj3uFLyPTlURDEzDmM1bj0OCtuQ6M/TMSEsZfNix94wjUVdthg
 vbumwIZ+Ccz1OgpKBOwO1uZ8zXvrBzoFvJfLOpB2/hCB4hwIckeepUWON7xkcWmC+FrSdXtyb
 XF6eF3athjIhiApfoq5cse+k+yiCrmGo7wE+7onUDTi+/Z49qKBxmGe90r01ow4eOinE7mF5m
 i5AKJME02EqIaiyGKzAOR0bl9pw4O5wEyI1HgUkxvZLgGaingm0iuyu/ZCRhTVLdDbbWIxUk+
 bTGhQpzgZLJjcZ7F7cdRxUX0zOM4wosx+jkBvTeSzrb7cuvmg/CYYlkBOW3fHZzJp7RrmNPtI
 New8L9r5m47sTZ+8RkqBU8VS9K0t0Jogkmqug6FJq/4xMxP63m3xqHUSkG8kwug3CGaafr0CD
 PIlFxAQQbtH7mBXaz+pwwtf9+WBZylJKWR/zwZ1ceOTCxzg0uai9I4HS3afBOw4xHdVuODgGG
 xHkiBNoROwqFDdfBeTiO0MFejMBwU9f4YzHcAKDXesyP7iF1jz0KGC+ESy/MmoH4EptKgxo4V
 RcMsTK+TSmjEwcWJnvV6vIDGavEKNhZl5jt/0fDCFAGttr26/qsAUmReOEKFZ+T/rz0cIXBQu
 4lhkU1YRf74PChjBKKMr+pcjpm33ZjRDRcqJFECLckn717tBSf3S38QOIhI4yRofAXeawW9gG
 gZp5DRZlK1a8AkGRqEGAsmoVBpha6kvXnhLa+XQeeiRmF+kxQ9cgVg4psbRMmcrFTC50ns8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 2:30 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 5/7/21 9:01 am, Randy Dunlap wrote:
> > DEFINE_CLK() makes the variable name be clk_xyz, so variable
> > 'pll' should instead be 'clk_pll'.
> >
> > In file included from ../arch/m68k/coldfire/m525x.c:12:
> > ../arch/m68k/coldfire/m525x.c:29:30: error: 'pll' undeclared here (not in a function)
> >     29 |  CLKDEV_INIT(NULL, "pll.0", &pll),
> >        |                              ^~~
> > ../include/linux/clkdev.h:30:10: note: in definition of macro 'CLKDEV_INIT'
> >     30 |   .clk = c, \
> >        |          ^
> > In file included from ../arch/m68k/coldfire/m525x.c:21:
> > ../arch/m68k/include/asm/mcfclk.h:43:27: warning: 'clk_pll' defined but not used [-Wunused-variable]
> >     43 |         static struct clk clk_##clk_ref = { \
> >        |                           ^~~~
> > ../arch/m68k/coldfire/m525x.c:25:1: note: in expansion of macro 'DEFINE_CLK'
> >     25 | DEFINE_CLK(pll, "pll.0", MCF_CLK);
> >        | ^~~~~~~~~~
> >
> > Fixes: 63aadb77669a ("m68k: coldfire: use clkdev_lookup on most coldfire")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Greg Ungerer <gerg@linux-m68k.org>
> > Cc: linux-m68k@lists.linux-m68k.org
> > Cc: uclinux-dev@uclinux.org
> > Cc: Arnd Bergmann <arnd@arndb.de>
>
> Thanks Randy.
>
> Arnd: since this has hit mainline do you want me to pick it up
> in the m68knommu git tree and push to Linus from there?

Yes, that would be good. Sorry I completely missed the bug report and the
earlier fix.

        Arnd
