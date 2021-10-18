Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9816C4329C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhJRWbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRWbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:31:42 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCCEC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:29:30 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id h19so5072526uax.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WItCIYqsbUPD72nHnvN17yFYFOS1ObilaTg0MnWhimM=;
        b=dfoc7S8/Ww6cb3NZc2WR8BnkW61SdjoUUknDFAqPDsTjN2OGWw5ekLyXgujJ1yiH56
         xodp4yJUDU7UjrsrhGXw5UsRD8R646yFugInFb1Y8ANaKFhmod9D4CPiDOX/miZa39Gi
         BgL9Pxb2c593rdhJAsq/ItBTN3tdvyDE/cpQZmh+55gJZ1ZVumx0Pdkd8DS4fLae+D5v
         3PPyB2ykikWT8CgLz+3XUfcR/GMKTdiHkdz39If8nz4Joj6c9nhKSvWqXga1XhdQsqPT
         Eh+/Bt80zk2VboT+ji0IjxTOU2kTvHu2Sd09C3XXmc9GVYmc4hUziJMnWbuUfn7tIYpn
         ccuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WItCIYqsbUPD72nHnvN17yFYFOS1ObilaTg0MnWhimM=;
        b=eDWRq9L7dYRC71bjlyaWOlySM39wkoI7yJTGUrio+NGfjQBVchxrKD0kqZIJVBfCmP
         l8aTUPFKYkZA5vlYApGZBlr4D1OPTvL2O8jIPFfLu5LMtyAFLfQ/ZdFZpxdK3b54yTeT
         NO8/6/DQnA5Ag5r6371CyYCVITkhr92k3RsjJKRdY6iE6XCciJ5FD4Zud8dRQLbjSTZp
         wjCo3Cp8DIsDewOwJ8QABL79FQ9lh5bhFM/D36B+ex5z2lTG1dwmTX8lw4XpnBP01ET+
         XN5pZF8qiBTL7kj9iTiDc9sScDaW/ogN/6fk78fMEEd+7/vxSZ8/QbkqeikAxuzCnRs2
         cF6w==
X-Gm-Message-State: AOAM531jeSnLrvI79kzA/dEtZbGA/O3ZXuCaux4M7vJPn28YYoDztHUD
        Sq6l3Yt2CVCK1xKoaq9p/LiNDDeiFxJEyywh/P7nzw==
X-Google-Smtp-Source: ABdhPJxKfsOl9FEnAEeKJ0XGXYrwHdf/vb/TXC58stZbzaYrFfwE0gRvb37yCTeOMtYt2iO6UMwF0yEC69mwE801bY4=
X-Received: by 2002:ab0:49ca:: with SMTP id f10mr28590033uad.61.1634596169392;
 Mon, 18 Oct 2021 15:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
 <87ee9pa6xw.fsf@disp2133> <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
 <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
 <878rzw77i3.fsf@disp2133> <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
 <20210929173611.fo5traia77o63gpw@example.org> <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
 <20210930130640.wudkpmn3cmah2cjz@example.org> <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
 <878rz8wwb6.fsf@disp2133> <87v92cvhbf.fsf@disp2133> <ccbccf82-dc50-00b2-1cfd-3da5e2c81dbf@infomedia.dk>
 <87mtnavszx.fsf_-_@disp2133> <87fssytizw.fsf_-_@disp2133> <871r4itfjw.fsf_-_@disp2133>
 <877dearzfo.fsf_-_@disp2133>
In-Reply-To: <877dearzfo.fsf_-_@disp2133>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 18 Oct 2021 16:29:18 -0600
Message-ID: <CAOUHufbWriGhH-CVZYF-WSH6H7Y7QvFen1_bOG_dQ15ozXhoFQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] ucounts: misc cleanups
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Rune Kleveland <rune.kleveland@infomedia.dk>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "containers\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 11:55 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
>
> The following changes are a set of miscellaneous fixes that makes
> the ucount code a little bit easier to read.  There are all things
> that I ran into while helping hunt the crazy reference count
> bug.
>
> I am aiming these at the next merge window and 5.16 rather than bug
> fixes to get into the current 5.15.
>
> Eric W. Biederman (4):
>       ucounts: In set_cred_ucounts assume new->ucounts is non-NULL
>       ucounts: Remove unnecessary test for NULL ucount in get_ucounts
>       ucounts: Add get_ucounts_or_wrap for clarity
>       ucounts: Use atomic_long_sub_return for clarity
>
>  kernel/cred.c   |  5 ++---
>  kernel/ucount.c | 20 +++++++++++++-------
>  2 files changed, 15 insertions(+), 10 deletions(-)

Thanks for the cleanups. Tested the whole series on the latest 5.15-rc6.

Tested-by: Yu Zhao <yuzhao@google.com>
