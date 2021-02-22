Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C959D320EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 02:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhBVBIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 20:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhBVBIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 20:08:05 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32088C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 17:07:25 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e8so14539722ljj.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 17:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UH4IPTgqw8AV3WlrSAJLfYK0v76O6zMRzSlgWb6EEEk=;
        b=epNELKSmVgggxleUs/hUx8T5udyukRpdhNESQ+whKzNkBUy6vGiMQQL3+A5y/lgi86
         +wlCZKqU5cjhFnP3qkh2TQzHIEdpPg79WhCQCoWMn/JtXFV7I/H28CrBZaOs6sPM1AjU
         MGE+52zLo6WA9tDVuM0CFPYrOyrvsgWxn/oxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UH4IPTgqw8AV3WlrSAJLfYK0v76O6zMRzSlgWb6EEEk=;
        b=tHsylHaAfAYu1x9LhjwNcD9QGFH5+dbOrP98rXaV6mh8jSvK1tj+h+cxGfF7i1T7vV
         v75k3RFPsAEbmpC84pFYNubmSv5+6b1bmlZN1sBwyloerxDaCC/lseAopLukLQnXH5Fk
         6fbEIUrdJKfLQ9ogyKMPss67YPioRstfWU6xkP1GWwjq8DGH2rf1+vqxMc83LgHkRjHd
         rqZ22gaaIpwAKNfBdjyQU/y3p31yPlMZ8UjaSNQxLwsK3qBthOK8GENe5g010a7sDPih
         bzoqcy0QQhq3xN6RAwgDdlET7J1ltPHVSy+CboEgXIc41KskXLv3S8HJxw2QI1ZCpgwO
         wQHg==
X-Gm-Message-State: AOAM533OgONb9PScKIP8/Q2aeBdm7BCtbme/+ER3cMCIB7MNGYrbXos/
        w8gAW+kxppvCql4uLvSCXH4til73xGgEEw==
X-Google-Smtp-Source: ABdhPJyxqk7WC7zCrYvoU+Z2XQ19LZfXYVO50g/SoptdEmRlpD3fpRQP4JP/PH8OeaEJMS7nr+2YCw==
X-Received: by 2002:a05:6512:906:: with SMTP id e6mr12433352lft.224.1613956043361;
        Sun, 21 Feb 2021 17:07:23 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id j2sm1713712lfe.134.2021.02.21.17.07.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 17:07:22 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id q14so53364741ljp.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 17:07:22 -0800 (PST)
X-Received: by 2002:ac2:5184:: with SMTP id u4mr7249839lfi.487.1613956041861;
 Sun, 21 Feb 2021 17:07:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRkn65jgVW5fTRWOrDe+dXQD-_-BTN+rZ8Kcq5qxFi45Q@mail.gmail.com>
In-Reply-To: <CAHC9VhRkn65jgVW5fTRWOrDe+dXQD-_-BTN+rZ8Kcq5qxFi45Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Feb 2021 17:07:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjs1S_63iF509z6-ZJSXbm5rASYYykMAcOLzjP46eYuRQ@mail.gmail.com>
Message-ID: <CAHk-=wjs1S_63iF509z6-ZJSXbm5rASYYykMAcOLzjP46eYuRQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.12
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 1:57 PM Paul Moore <paul@paul-moore.com> wrote:
>
> - Add support for labeling anonymous inodes, and extend this new
> support to userfaultfd.

I've pulled this, but I just have to note how much I hate the function
names. "secure inode"? There's nothing particularly secure about the
resulting inode.

It's gone through the security layer init, that doesn't make it
"secure". ALL normal inodes go through it, are all those inodes thus
"secure"? No.

Naming matters, and I think these things are actively mis-named
implying things that they aren't.

              Linus
