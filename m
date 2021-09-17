Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A114740F399
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbhIQHzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbhIQHzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:55:31 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4921C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:54:09 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w19so12871199oik.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqF5ZNhWXHboCDI+DdhNiPlSQl2K5A1uMEdFDe7/7M4=;
        b=fDGbOfuW2u/AmdcUA7VYG2oW3tXAMAXaTKD/T4pHiseKSg62WUx95HXeHyV4NJmQkd
         XQ3w9AwaO86njJB5ABThQ2MyzFYupJGRS2gHA6o8jTbr7TKkCnKpe31umLqOsVq4trqy
         KjkS1igb1yVMnQeVsaMSCPmPoT3wA/2O7dn1j+0+dQEx88KLyaph1dPT+YIYNwIrlWJe
         UfOfkG9mnSZamCy14NZ/jOvZhpiOt/zz77s32L8HuF3u6l8eO6rO/BnG5EGvhUAdtCpI
         g/OTFxuAtBfP5iJBZ6fzYf04txk7u90xOktLMcEZtb6Szvm81euBAVhGbMuF9RP30lFn
         Rvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqF5ZNhWXHboCDI+DdhNiPlSQl2K5A1uMEdFDe7/7M4=;
        b=ZwqOobIChbTiLIIyHMNz/kNRnqLVHKrSSAwAArHphFNiuYSchgFuX6aaFHNerS/Gc1
         ErCgN11uxbVR6TBIq9PP8acEyDhyu0RD4HT96SjwNfyJ+3k80Sj+t+TanKamnNFzglWp
         +l2RVKKS4OUveg/Rrx8ZgfIh8JMsbuJwq6qvxdSTqrtPUkexOMcetcGuEVjzaWtTV2BO
         gaVR9IfEFkHuafHbhgaM0yBIL5RslZ/W+AifaJLJ8EghuCAD0onOR8U8x8EIJLrlTfrT
         9UBEjXw8NST9U7amV2vGkhBndK/EDt2Vx0TTHd52XrcuuFCf65i6+ayDKJYjRpsrFO5/
         1iMg==
X-Gm-Message-State: AOAM532/iuHvQ6k/ST91s6opz3WfJt8xO8ugUy8cUhTScjUcL9HhFsTf
        y/DB4JZ55i8Wz5JC8WIW2WW/RqV0f/dCsQAsuvnr1FEjcp7yuA==
X-Google-Smtp-Source: ABdhPJxBd8O+oRk4mXWceLP4oIaDyfaPchMClOKVxAMF9p4hAHT2sO8uXzHZcICi6ok2iWo85eJFF/MNc+U/eVN6KZg=
X-Received: by 2002:aca:1109:: with SMTP id 9mr2925257oir.109.1631865248854;
 Fri, 17 Sep 2021 00:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bb5f8605c697fd87@google.com> <000000000000b1e03005cb6230b5@google.com>
In-Reply-To: <000000000000b1e03005cb6230b5@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 09:53:57 +0200
Message-ID: <CACT4Y+b1YFQLeZkH8z_n_-x7s6jmY-p=07vJk89-KZgQXYs1sQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in get_ucounts
To:     syzbot <syzbot+8c3af233123df0578a5c@syzkaller.appspotmail.com>
Cc:     ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sept 2021 at 08:51, syzbot
<syzbot+8c3af233123df0578a5c@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 345daff2e994ee844d6a609c37f085695fbb4c4d
> Author: Alexey Gladkov <legion@kernel.org>
> Date:   Tue Jul 27 15:24:18 2021 +0000
>
>     ucounts: Fix race condition between alloc_ucounts and put_ucounts
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1378d0ed300000
> start commit:   d5ad8ec3cfb5 Merge tag 'media/v5.14-2' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=702bfdfbf389c324
> dashboard link: https://syzkaller.appspot.com/bug?extid=8c3af233123df0578a5c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fedec6300000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: ucounts: Fix race condition between alloc_ucounts and put_ucounts

Looks legit:

#syz fix: ucounts: Fix race condition between alloc_ucounts and put_ucounts
