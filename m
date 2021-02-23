Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A0D322FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhBWRu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhBWRu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:50:56 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50510C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:50:16 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q23so4158627lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RIOXTWzCBo9kaKKKhV+lNmVK6jNZryLKKiOWzuthoA=;
        b=RDqPtn/GvPV/0IQ2yQwfbgZqSgnhV/N4HmlL3wG9u1n2FceHvEYyALJedvcD28S5/s
         +VhDYHpce4StBdKQSUPYJ8PonODxd+YWPKZYUklUhfgAhDyW8TFVUQi3DEfM8J6NruG7
         4IYTJpXwekQROqFzShXlho+bHYhb8n7H+NIX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RIOXTWzCBo9kaKKKhV+lNmVK6jNZryLKKiOWzuthoA=;
        b=MM98WumtMtgbZo7kYbBqtGk1l176q91WPP3F11b8YbPRopQzc9kgISoWDOkRKpg7aL
         2NNUefb9xpQNkja6BL2eOES1HctMw9sBALcYxIluS69HXrsZzmmflaLD0xiY+6slz/jO
         DnqwvnF/M6fCoGJvFb+3EJumQJofeNsvvDSMymN7bs+mym78r1EQnHwCgzaZpMEairny
         DGnSCbot+R/XtqpuA9v5cHEIwPQ/6QcMM4NBc+aH/8+9NGh1alH3YIxNZKHN/Ch9s+1b
         ZfQBNugo7FOKp6xmTCYuc50J0Qbg/hVzpxYaa9vvRW8uUhZ4quLuv/tvZpQPIi8jWdZQ
         moWQ==
X-Gm-Message-State: AOAM533mvPFFzS6b5WN1YA+W5eH8fNUE7UtALzGreq29B4oN7TB0IJfy
        JrUrP0bFeuFK9+3Tt43PLd9G/opk/QNOdw==
X-Google-Smtp-Source: ABdhPJzdRVfam1oK0V06wdWB67WxXRXzPCOwRpuNn//n0B+Mtwz1C6yGB/lFuszgR9t3VXdKNDKnow==
X-Received: by 2002:a2e:9116:: with SMTP id m22mr5610112ljg.498.1614102614588;
        Tue, 23 Feb 2021 09:50:14 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h11sm2148982lfc.298.2021.02.23.09.50.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 09:50:13 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id u4so64115099ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:50:13 -0800 (PST)
X-Received: by 2002:a2e:3910:: with SMTP id g16mr17074964lja.61.1614102613085;
 Tue, 23 Feb 2021 09:50:13 -0800 (PST)
MIME-Version: 1.0
References: <202102221504.0418BE2D1@keescook>
In-Reply-To: <202102221504.0418BE2D1@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Feb 2021 09:49:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgUS-vqCk_d0wwBWgk4tRgFpYvfyob5y28c85msqpbjuw@mail.gmail.com>
Message-ID: <CAHk-=wgUS-vqCk_d0wwBWgk4tRgFpYvfyob5y28c85msqpbjuw@mail.gmail.com>
Subject: Re: [GIT PULL v2] clang-lto for v5.12-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        George Burgess IV <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 3:11 PM Kees Cook <keescook@chromium.org> wrote:
>
> While x86 LTO enablement is done[1], it depends on some objtool
> clean-ups[2], though it appears those actually have been in linux-next
> (via tip/objtool/core), so it's possible that if that tree lands [..]

That tree is actually next on my list of things to merge after this
one, so it should be out soonish.

            Linus
