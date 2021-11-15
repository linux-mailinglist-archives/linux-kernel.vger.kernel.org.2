Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E2C45020F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbhKOKNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbhKOKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:12:48 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7CEC0613B9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:09:40 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso19424357otf.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjxaQQAlP137GPcg7neUj3SWU2e+pxtE3HKBOPV3JdQ=;
        b=NzVOqEsSDaO9mCUH4qXmz+xyTienfK7XMGLeAkRKj2IzpM2AGkZb8+JpaYYGiZWZR8
         uqqvrA8JfOITXlAkjlaNBPc1iY6lNSwKRcKZNOdt+HyKL3XlcZcOhMNrzwLkUxieooFE
         J2wc5mnC1OMXRNsgjbl+lQESXvrsCAWQDG1acz7Zo0u9AohZ0OJGQizdAIePR6VKnc0X
         WW/a9zuexzYjltl2klzT+k3t+3GfIVwrgCXjLoeKoRu0ps33IbhCrwUoNAVC2KCe2fco
         pewFaNH8M8qi32K/i7jazBc4hlgnqjMLrP43s3bbfPMKZzoqI7uZ6cFfl9Tyvu61QG4E
         ffJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjxaQQAlP137GPcg7neUj3SWU2e+pxtE3HKBOPV3JdQ=;
        b=m22mNJ/4hL1wT/8mCXErAGmU+cDkiERX5M2uIOYVqjaVrYt6y6XCEmZBcXdb18PHqN
         CaNey2BAklpLkeQgW3IfH+ZEBDrVY8ZQVt3h2OvbaT4jUi+BuXH9ve5BzP51881Mxao6
         a4uJuRyKc+yUOE5vfwKlAR8+57QbNml/Zbh6SqeCST3xQtRSV6eUisslS/MAidFoebmz
         7T09H9lzBgecDN/lw0Oi4q7UTnhIBMr6vVi5w0XY1kZmcU3jSE9hpPg01MHRXlsd5FC/
         Ibt1yPXi5kI9sS15AvVWndvW4OZXZzgJSUgDrINpzSO2CnVMZFSnXt964Sr8bPth5uOX
         48SA==
X-Gm-Message-State: AOAM533TgdFf7s+co9MLDhiZmvSbAm3gX92An4oCt4FRfrY3dNWEhtJI
        HXfOL6194v8gA3APJlklcBwG2+25UyYhgsLWGCk5UA==
X-Google-Smtp-Source: ABdhPJwGcrYnf+NB6iN80f6JjshEqP2H3y1O+o3D//32tHQgeu7qbsBzw4jy850txIU+80oZj38AgWEjEv7jfivh3to=
X-Received: by 2002:a05:6830:1356:: with SMTP id r22mr30067230otq.196.1636970979616;
 Mon, 15 Nov 2021 02:09:39 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003991b905c9cb527a@google.com> <00000000000089a5e805d0916571@google.com>
In-Reply-To: <00000000000089a5e805d0916571@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Nov 2021 11:09:28 +0100
Message-ID: <CACT4Y+anuf4qTHm05JiQ0ShsH__vjgoOhbB12L9VOTRsZapCtQ@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in hwrng_register
To:     syzbot <syzbot+fa0abe20d13faf06353d@syzkaller.appspotmail.com>
Cc:     f.fangjian@huawei.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvivier@redhat.com, mpm@selenic.com, mst@redhat.com,
        syzkaller-bugs@googlegroups.com, tangzihao1@hisilicon.com,
        yuehaibing@huawei.com, zhangshaokun@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 at 07:16, syzbot
<syzbot+fa0abe20d13faf06353d@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 2bb31abdbe55742c89f4dc0cc26fcbc8467364f6
> Author: Laurent Vivier <lvivier@redhat.com>
> Date:   Thu Oct 28 10:11:09 2021 +0000
>
>     hwrng: virtio - don't wait on cleanup
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d4141ab00000
> start commit:   f8e6dfc64f61 Merge tag 'net-5.14-rc6' of git://git.kernel...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=171d57d5a48c8cad
> dashboard link: https://syzkaller.appspot.com/bug?extid=fa0abe20d13faf06353d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cfe231300000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: hwrng: virtio - don't wait on cleanup
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: hwrng: virtio - don't wait on cleanup
