Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1EF43B6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhJZQSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237328AbhJZQSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:18:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2EFC061243
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:16:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bp15so20825651lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZldZgKL/h4bHmv3Vt0CK9jGTP+iK5MWhoNbwyCa5+Pc=;
        b=bS/cWlrHjTVpJlUnxukdjVNCfVfe+5pDzNPOwdtPNLW52XF4iZZRZmcx6/iOmA7oV3
         yFDQyZsdldJNl/ooWZnuD3ptspucVPqtHeyygws3OGmokVdHB6e5SHJQYzEAeZR0F4wd
         a+w8P8n/sClWhiKDj2DIvauNcOgAqT1ZkRnGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZldZgKL/h4bHmv3Vt0CK9jGTP+iK5MWhoNbwyCa5+Pc=;
        b=joEapqzXuOzAPybe7thhigYSSAk6DerYq2iiR9T9PJRSIUr5Lif8/c61RuDcsmD+rb
         ZHCdQ4u5MeTE4YulD6qft920SyPgYDiv55Lf5nkZfB8McIDkuEA8rFeB+yrBGxBZ1oQY
         1fAgV13KVTELSivUZzRyhSZ1j8Lx4NL9FsXzbPTbu2jOn/rCoEaY8yi39y0b7Dt8/2uL
         gFVBvcNQwDBiYqrbVQqogmCXfvjWRAof48Xh7YxuqBQn/nxUO91iNbmqix9LcQWOrjT7
         74v9g5MbYD1qYKw60uo5eMyvFb9fyuMQIPmA7OlBayQE9DpKBF/oxAbJuRSyJmlB43hD
         7dLQ==
X-Gm-Message-State: AOAM532xX82FTWPjemobb1FhEZCOwMiS+WBx+ahiwroQRkUWD6ayM27l
        BA/m+DJKpZWFiC5iae1SaEp/SR1HaxSEf93e
X-Google-Smtp-Source: ABdhPJy47BjHkO3wfHAT6Gqx1HTbsEYvdyDT7CGRBiaqKCIm3jxAHCDJPuMaFyR/vEhby+snOBpAGA==
X-Received: by 2002:ac2:561c:: with SMTP id v28mr14205006lfd.604.1635264969182;
        Tue, 26 Oct 2021 09:16:09 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id x12sm1978119lfu.185.2021.10.26.09.16.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:16:08 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id o26so20987559ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:16:08 -0700 (PDT)
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr5213114ljk.191.1635264968138;
 Tue, 26 Oct 2021 09:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-13-ebiederm@xmission.com>
 <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
 <9416e8d7-5545-4fc4-8ab0-68fddd35520b@kernel.org> <CAHk-=whJETM0MHqWQKCVALBkJX-Th5471z5FW3gFJO5c73L6QA@mail.gmail.com>
 <87v91kqt6b.fsf@disp2133>
In-Reply-To: <87v91kqt6b.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Oct 2021 09:15:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiph8wmVDJZiUETH3r_+fWhDvaEz64aA0XNimkSOHf+dw@mail.gmail.com>
Message-ID: <CAHk-=wiph8wmVDJZiUETH3r_+fWhDvaEz64aA0XNimkSOHf+dw@mail.gmail.com>
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 9:58 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Rereading this I think you might be misreading something.

Gaah. Yes, indeed.

> force_siginfo_to_task takes a sigdfl parameter which I am setting in
> force_fatal_signal.

.. and I realized that the first time I read through it, but then when
I read through it due to Andy saying it worries him, I missed it and
thought the handler didn't get reset.

So the patch is fine.

             Linus
