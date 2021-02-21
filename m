Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD0320C19
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 18:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhBURoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 12:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhBURom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 12:44:42 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829F0C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 09:44:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a17so51583416ljq.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 09:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0IhBs4HMtKz7YORBU4IAL4nDz7KXpbOEFLNXeCIWis=;
        b=H6SiTirFcSmwn3bblUVMIMxOw22CbGN7bnu7Lg55R+1Oj6C+Xfi0mSCIZKW+vidndy
         nqg3PCoqv4WHJCpkV+P+7Jb5aL1/0P8tKggaDFj9LoI0UGA41XGvHcoPV84p2L4ivyFL
         JzwT2JsLwk0pyFTTJM6UlaE1UJwqxYPjNVspY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0IhBs4HMtKz7YORBU4IAL4nDz7KXpbOEFLNXeCIWis=;
        b=YTkLzvlmb0XuaKihi2Au19+dmcVEmol7LGCq3WPBObciroglE7+9AOMTruAPlnGCHw
         JmNq+CqQjIDrnCg3RQe4Z67KADLeaqd0WolNjP8V87LAYCJoQf3ZaUFOvo1i9FU7Tpn/
         D+mL6fG8+AX29eIPRzeFLcWdmqTFyG4eyGo8cJgvNa7je3UHHgOOGuYTsxJZBLmjV/vX
         lkrTE3ZLGF3eERI9CrYhyMQvGcRTqDGBoEoFa9oHJA3KsYQUKKALF8zYGQNxpt7+ggi2
         NsfTU5l1vtfcBG/rhRF2PIjKrwnqiQPUYINytmEdT1Q/XsQ6ONJ7YSMxoQv2yD0yf568
         JbDA==
X-Gm-Message-State: AOAM5318LY/XFln5pvvBn/TPYU6v8ePk+E5vtIQB3zDKcx7ZsDhJdcT8
        SDtCnCrVnCtTK3SCXpHuBH0YVwosg1cvig==
X-Google-Smtp-Source: ABdhPJz5b8wwxpFR8PdW2l1FAFm0VeLqN4Gaih/5weASg78YkaeWLXUN8i+/uLySjXkcGP/ULeOZWA==
X-Received: by 2002:a2e:5c02:: with SMTP id q2mr9795857ljb.81.1613929439589;
        Sun, 21 Feb 2021 09:43:59 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id r4sm796401ljg.60.2021.02.21.09.43.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 09:43:59 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id o16so46903857ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 09:43:58 -0800 (PST)
X-Received: by 2002:a2e:3910:: with SMTP id g16mr11680177lja.61.1613929438472;
 Sun, 21 Feb 2021 09:43:58 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001fb73f05bb767334@google.com> <0000000000000ca18b05bbc556d6@google.com>
 <CAHk-=wiEBTD884i-U9DU7aDdRxXuz66Q1r-rKTiJUzZoYFgp+g@mail.gmail.com>
 <YDFJKR5uG1N+g9TL@zeniv-ca.linux.org.uk> <YDFJpF216gaPavrc@zeniv-ca.linux.org.uk>
In-Reply-To: <YDFJpF216gaPavrc@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Feb 2021 09:43:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrG7-eCVDtAyYVDv0nxKVhvPr3g+US_8506cwe2XF0XQ@mail.gmail.com>
Message-ID: <CAHk-=wjrG7-eCVDtAyYVDv0nxKVhvPr3g+US_8506cwe2XF0XQ@mail.gmail.com>
Subject: Re: [git pull] work.namei stuff (v2)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        snovitoll@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 9:40 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> NOTE: I'm less than thrilled by the "let's allow offloading pathwalks
> to helper threads" push, but LOOKUP_CACHED is useful on its own.

Well, that is getting fixed separately, so I think this is all good.
Still helper threads, but no longer kernel helper threads.

             Linus
