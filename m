Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E442377464
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 00:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhEHWnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 18:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhEHWnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 18:43:22 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D7AC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 15:42:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id p12so16178152ljg.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qvrf78C1VckxwN+Rd5iRKXM/TVBAx3SQ0yt8T9W1XI=;
        b=DHL714aYp4X3y/ZDPD/BxJq1zv4WKtKia+ktMgIzEElXklJlzicJbZPsvSVxT/1xq/
         ll2tgIA7+11guksgQhLfWHypKFmuq96HS2x73V3P8fR1NgWiz+KeFKOCZmlgoTLzSEA6
         tLX8U9qAEO26/nlzd5qfUVlzthZNMMtHZNWBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qvrf78C1VckxwN+Rd5iRKXM/TVBAx3SQ0yt8T9W1XI=;
        b=fGg7mUE8FtYaJCWrmDSI0CTSIjQ+08Qv6TmRiwhr5JaivWu6PmZnKHPEqnJH7zaF5O
         tvj4SGZygYXNxDO+5zDJWqz17w0ZhxHImwjuOWaXcdN5kefbpzF7ElQI3bSDD4is8voB
         Vxv+WvRsIXjwJuPhYielfwGQ7Lx1S8qPKH49wrsvxXKRb3fOV8+bSnCp+0q3kkqDCs0K
         nLYZs9j1cxiJTKGceVuJoVl8CKYRsJacf/OUbYdo1/p4YOE2SXAvQtcgmxcuyGLmkeq+
         C3LobKx/00uiUerMKwXN88HWyKhNR7nzt9JhPbLrfpUPVBnF+Lit2qeGI2Y/wTBomIRg
         lBGg==
X-Gm-Message-State: AOAM533ikfIvT/SBNCrEb1RHTY5Lzdl/3BsnsSnV0EKQWkSgagBtKEuM
        jJwL152B8xxyq3ncQr75SYkKob6KCIcBxxD8ag0=
X-Google-Smtp-Source: ABdhPJxJxU0JMi4P+UctpzOg/XHwj2ewx9K5KjY3shRc+Bcdw7SAtRpGO7DWDkhKoHpU1gj1cBNzLQ==
X-Received: by 2002:a2e:a585:: with SMTP id m5mr13600912ljp.223.1620513737072;
        Sat, 08 May 2021 15:42:17 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u3sm30081ljg.78.2021.05.08.15.42.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 15:42:16 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id i9so11353728lfe.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 15:42:16 -0700 (PDT)
X-Received: by 2002:a19:c30b:: with SMTP id t11mr11039558lff.421.1620513735912;
 Sat, 08 May 2021 15:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
In-Reply-To: <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 15:42:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
Message-ID: <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 2:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, if we go that way, I would make that
>
>         while (dentry != root->dentry || &mnt->mnt != root->mnt) {
>                 int error;
>                 struct dentry *parent = READ_ONCE(dentry->d_parent);

Side note: you've added that READ_ONCE() to the parent reading, and I
think that's a bug-fix regardless. The old code does that plain

                parent = dentry->d_parent;

(after doing the mountpoint stuff). And d_parent isn't actually
guaranteed stable here.

It probably does not matter - we are in a RCU read-locked section, so
it's not like parent will go away, but in theory we might end up with
(for example) pre-fetching a different parent than the one we then
walk down.

But your READ_ONCE() is definitely the right thing to do (whether we
do your re-org or not, and whether we do this "prepend_buffer" thing
or not).

Do you want to do a final version with your fixes?

               Linus
