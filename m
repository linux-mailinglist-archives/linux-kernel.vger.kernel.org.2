Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB44391DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhJYJBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhJYJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:01:41 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAC1C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:59:20 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id o204so14567383oih.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMtv1MlJYbtimIeY9k4qdPc6dVQTgri/qRFILzyjfOw=;
        b=f/TOaAxgnS5Sqf7cFLlSRsaEGB8IwmshdNUmJCie6SlI9fL+AReznkJQr/NX9kMZP0
         TXUbtdV4mLLGrF7HbKrp/KrHuPkmGvP9xuMCiBUG+ipb6rXBrXcfd7Cnwenl6AlfrIPm
         BSVhXE/qytumbvPWnJzU5m1zmnUMrYdoDhXBTamie//W31a8Mwgy9PhZ/z63k5Rdm5je
         UtIGs98FXlYO88xCoLsQg2F9cZRXUunBNC6aIKhjRUGkGHbw/Wd91Wl7yuEXuc2RAyyt
         qu1/VyusyT3mS0rm8YxO1npUIgoYrT1owbawpwN/y9OWB8a493ToJZde+9XzeQquBhc5
         pYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMtv1MlJYbtimIeY9k4qdPc6dVQTgri/qRFILzyjfOw=;
        b=QFLlDdqLQHrIgvw/Vl4KRmyOiLXpSbwB2jcFcbhXlo95WNBItOXrMwEb1ljtCztF3V
         TDPpwDifCUZ2DzBbmx2oG6NGZmnrBZT+aKQelxHOu2RwkrMHuNfnvYQ0uf4U2vltha0J
         INfKNPEMu+cs2qnwAcmFgKI9mYzsUktCE6pAaqiqSRzEz3q+u149O+A0KMyAG8hGVbZ8
         9KmBWupcS1uy7TZvVsrlDm/RijpM22mp/+wR+CXG5Ql2kgn3Wg4h7jR/xVqVhSxXVVql
         wSu1J1bXBiYuqm1VkhZXiCz82Bk+V41GLDtgP8w5e63GbUxCob6rFOXezAUXiVIuKHj4
         bQ3Q==
X-Gm-Message-State: AOAM532bRdg/4D1c9Map+Mxk6c1f3FQeiD5OnCVpZueVHi7axS20kxEW
        mf02HdiIxWq7tyRlOqxMq1V9OOhwYIE9ssNMn0JUwg==
X-Google-Smtp-Source: ABdhPJyyLbBP/HLLAcaQpqaHX1X3fUZb1QoYuqCZ+6fctZal9FCukbtG6YmQ/xoO62cgkbAnR8rOXgDMDus0bE+s9uM=
X-Received: by 2002:a05:6808:ec9:: with SMTP id q9mr21107014oiv.160.1635152359323;
 Mon, 25 Oct 2021 01:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d5efd605ccc6a5df@google.com> <0000000000006f55c405cf287f25@google.com>
In-Reply-To: <0000000000006f55c405cf287f25@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Oct 2021 10:59:08 +0200
Message-ID: <CACT4Y+b7hhoZeEy_V2FgB5Tq39vGq797QyEsWFkXFnXySoqEpQ@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in nf_tables_dump_tables
To:     syzbot <syzbot+0e3358e5ebb1956c271d@syzkaller.appspotmail.com>
Cc:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 at 09:42, syzbot
<syzbot+0e3358e5ebb1956c271d@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a499b03bf36b0c2e3b958a381d828678ab0ffc5e
> Author: Florian Westphal <fw@strlen.de>
> Date:   Mon Sep 13 12:42:33 2021 +0000
>
>     netfilter: nf_tables: unlink table before deleting it
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13efcb0cb00000
> start commit:   9bc62afe03af Merge tag 'net-5.15-rc3' of git://git.kernel...
> git tree:       net
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e917f3dfc452c977
> dashboard link: https://syzkaller.appspot.com/bug?extid=0e3358e5ebb1956c271d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14374e5f300000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: netfilter: nf_tables: unlink table before deleting it
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks legit:

#syz fix: netfilter: nf_tables: unlink table before deleting it
