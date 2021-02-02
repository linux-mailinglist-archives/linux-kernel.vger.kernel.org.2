Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EFE30C8EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbhBBSDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbhBBSAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:00:32 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BBBC06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:59:52 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id u20so8193586iot.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzDi96523sahyObx2Yd6Yye0zu9EowaSoOEtWhQZYPw=;
        b=ApRAVOsXkXemdTCGFDc8VtFnTyUzSGGWZWyjtGq5r2fILEpMKNtTROIkk2yPTZ+Fcl
         a+JTO4wDHcxHH0nBnd7clvNVnsgyjAENynekaYLoakU8+UAYEnz69j0tTtU+Yzd6PEJd
         Stndn4AoK/aTpazox13ynrwj+Hs0m9NGZ3T3FHrGwKpT4k3bSOV54sYPLXewJdQv0jpl
         U7Deq5VVnIp1uyhVkYRWQIA4BTfND/zJK9+aomgRWPzX4KeIdasjkC6fVRUW/ZPpjgLS
         xhs20pm7+KU8uA1UH4p8KbGKNQibVAYPl3GA7PhUY1aWdTgATXgkHIJNnP6JspI+FB4P
         2aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzDi96523sahyObx2Yd6Yye0zu9EowaSoOEtWhQZYPw=;
        b=WGzJQTzrZb3+FW9/ohFa8J+K8GihWjkakQlTtu6KwRvacYzDnZe9eiwuaZT2OFtuOD
         dtC/JXk1oymbvopZMnkwkN/UlDMJMoI7Vx0An3kJXT6ChVBCEmn+mkJloXL0aw9QsKZf
         Udkb56cCt/ZAk7f3D1eb9GaK3+DXVshQcgRoKctudIbJRXGJwwykGkKtZ81RQjTLCjW2
         6tZsoO7jS+EmK9lRf0P/YSyBk6wpawOvzw7IHkN0hlVXYw+1728cmdnPVTl5sMJxRKR+
         wxQRD1IB9xaCKNlKKUtY7cDNZUufCmMURL6Z29n1PYsywUx4JTrfGF6KejmvgOWJ5i19
         z3NA==
X-Gm-Message-State: AOAM533Hx78iI9PvCWCpxqGFPKJrZq1Gaq/Ls64Ze/mvR2qwQwVr8rY1
        V/TrzEMHNYsrU1NAIehQTeDwGUL6JIy6iDDQNpytyeE4hqI=
X-Google-Smtp-Source: ABdhPJyZ3+uPg+spmKYxqmrn5OUa6GKTOb5com8Rvh92LAZ9OOXEJPNKaIyTK0E+2yXbOzqExizxQAJjkKyUzhM3yi0=
X-Received: by 2002:a5d:94cb:: with SMTP id y11mr17689016ior.117.1612288791921;
 Tue, 02 Feb 2021 09:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20210201160420.2826895-1-elver@google.com>
In-Reply-To: <20210201160420.2826895-1-elver@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 2 Feb 2021 18:59:40 +0100
Message-ID: <CANn89iJFvmLctLT99rYn=mCwD8QaJfEaWvawTiVNV4=5dD=Tnw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: fix up truesize of cloned skb in skb_prepare_for_shift()
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        linmiaohe <linmiaohe@huawei.com>,
        Guillaume Nault <gnault@redhat.com>,
        Dongseok Yi <dseok.yi@samsung.com>,
        Yadu Kishore <kyk.segfault@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        netdev <netdev@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        syzbot <syzbot+7b99aafdcc2eedea6178@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 5:04 PM Marco Elver <elver@google.com> wrote:
>
> Avoid the assumption that ksize(kmalloc(S)) == ksize(kmalloc(S)): when
> cloning an skb, save and restore truesize after pskb_expand_head(). This
> can occur if the allocator decides to service an allocation of the same
> size differently (e.g. use a different size class, or pass the
> allocation on to KFENCE).
>
> Because truesize is used for bookkeeping (such as sk_wmem_queued), a
> modified truesize of a cloned skb may result in corrupt bookkeeping and
> relevant warnings (such as in sk_stream_kill_queues()).
>
> Link: https://lkml.kernel.org/r/X9JR/J6dMMOy1obu@elver.google.com
> Reported-by: syzbot+7b99aafdcc2eedea6178@syzkaller.appspotmail.com
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Signed-off-by: Eric Dumazet <edumazet@google.com>
