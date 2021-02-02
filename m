Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D30130CA12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbhBBShu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbhBBSgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:36:10 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34120C06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:35:01 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id h6so23839907oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RaNsjOwqUcbpXCG99ecSA5gio3yAqiFYFr3g6/024ao=;
        b=oU66NOBWuilQ3IJJTCRak0wCivqFBHRtpLV8KyFJ9E2jCjo+KEP2b/2d/NpGkZaG04
         CaPMsaXPPv2M3NJ211eq5XyrnYTBS2SIx70J8Qd4YhJ4+g0E/qqG7CNCVC3djn1zNKrf
         IISxX9belPhDUzdpETpU9xE9au4GbyP7BKNpB3CCOVViPJTITLShhP5p2DaZ+RHKGHym
         5YIQEQcdGbbsphdOBhC9pQJ7lKfwUJPwWsXz7w4S9yInIgEI3OT6X4m55SFWaw2CWdDl
         Lnp3KmG6GdMTemmN6wOzLN2xvaHCsJ3L2usFL2yxRP9dO778m4y4a8gqq72zLWGe6i4r
         XJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaNsjOwqUcbpXCG99ecSA5gio3yAqiFYFr3g6/024ao=;
        b=uW/ymPvJi0jCHya0jcGAnaS3YoYjQPPFHGBNzg/sxR96us0BO7Gyu29Z9Y9GIiy+22
         aq13VGUMpx93H9ASY3uFHZ9Olb8OzT58d9jTtvXcTEMZlC66dGG2NqKbJa8jD04CE01Y
         D1AVavwFA1ku6Dk/N00nE5OXK8Ac9sQk8UNulE/W4VC/yO/mguZQhLt6Pl8Z+aAdA2GL
         jXyeQATwxCve4rnUt3lUlJee1VqRDyh/nNSdPUaNgGXi2TXa6rXrHh4C7Lyz+TRBNGU+
         to9spW9oVYloiDi02OqFfVQFPSOVma9P0Xsx6Vt91YdMAGroeaSKkGGQCJHZr6ZrEIFd
         BWSQ==
X-Gm-Message-State: AOAM531faC/K8Ro+7/rJK/7U1YtiTgkXgZ8v8FlGwCwP/wk9lqEk7CJo
        OJasiqSmzS4aZ2ehsYrrWkpFg2Gcj5tIEgf4j+j58LQLngE=
X-Google-Smtp-Source: ABdhPJye3ZsicRzrycl8+bjdVOEYBswumH+5DWdQICv8tR+PP4/48cip0zejGjJh93USjbAZM8a7K4AOOGtXww0QBk0=
X-Received: by 2002:aca:cf50:: with SMTP id f77mr3686942oig.172.1612290900367;
 Tue, 02 Feb 2021 10:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20210201160420.2826895-1-elver@google.com> <CANn89iJFvmLctLT99rYn=mCwD8QaJfEaWvawTiVNV4=5dD=Tnw@mail.gmail.com>
In-Reply-To: <CANn89iJFvmLctLT99rYn=mCwD8QaJfEaWvawTiVNV4=5dD=Tnw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Feb 2021 19:34:48 +0100
Message-ID: <CANpmjNMRFzXY5FgHXgjm+QVf9BqJ0=RQZZQB1k_kZ=umjZ2qUA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: fix up truesize of cloned skb in skb_prepare_for_shift()
To:     Eric Dumazet <edumazet@google.com>
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

On Tue, 2 Feb 2021 at 18:59, Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Feb 1, 2021 at 5:04 PM Marco Elver <elver@google.com> wrote:
> >
> > Avoid the assumption that ksize(kmalloc(S)) == ksize(kmalloc(S)): when
> > cloning an skb, save and restore truesize after pskb_expand_head(). This
> > can occur if the allocator decides to service an allocation of the same
> > size differently (e.g. use a different size class, or pass the
> > allocation on to KFENCE).
> >
> > Because truesize is used for bookkeeping (such as sk_wmem_queued), a
> > modified truesize of a cloned skb may result in corrupt bookkeeping and
> > relevant warnings (such as in sk_stream_kill_queues()).
> >
> > Link: https://lkml.kernel.org/r/X9JR/J6dMMOy1obu@elver.google.com
> > Reported-by: syzbot+7b99aafdcc2eedea6178@syzkaller.appspotmail.com
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thank you!
