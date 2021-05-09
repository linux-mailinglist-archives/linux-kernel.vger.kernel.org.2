Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988F5377505
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 05:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhEIDCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 23:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhEIDCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 23:02:44 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D4BC061573
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 20:01:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a36so16506544ljq.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 20:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c00F5gdQd8J96Q6xsAfPKXtIOJ12DymA7I1VC+ABJMI=;
        b=ZXbbWzGH/eL1fUAgVLnCJUUj6r+YqzdqdDMv0ikvcdMmVSBjVlBU3527+tNRCUaiSM
         7m8ZTZPhoRTWkoXcymBN+P2y/Luf4xF3yzPt9VOXchyeMYTKTr57ivdXERQucDgeqYM2
         ShoIySWR1fYr4SscaXtb78xNk5uidMng7rfzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c00F5gdQd8J96Q6xsAfPKXtIOJ12DymA7I1VC+ABJMI=;
        b=q6jGsSaS9KPERgjxSeI2AGGBhGy2p4K7nUXbgX1KGGafvwtFIftlDDODArwygU6XyR
         iW0iS4LAoZ/k68AgxEbe/WlXGNdK5OtPIiFs6363V2EBEcytkdTsgi0oVFwYNH40GgpX
         fTujnxjPf3acay7MVrCi9Ztiw5WGkwiIQXmSCgnFKS8f3OBSCoHpcy+UepdvEmC4Ltb2
         hjh+L/6r4dVViMQv3uPxomO0zN85L9POlgjbUha3M+KSGkp2q0J4gR/e4zwFERD8MTF6
         yXP/QwQr+slPIHRiEbT5Kit+7/oTWCJ/w5qizbc7NmlhpG1Me5v3phhp5J6wAGSijK2j
         USUg==
X-Gm-Message-State: AOAM5301BAUSYk8ZENQrPqTdX5mW9MyejUpGHHpL4PNiXPFK9szqf3cy
        r796Js7b/IhNuXl50YFyBg7CE2NOsbElvXazWt0=
X-Google-Smtp-Source: ABdhPJwORR8Ysb0fJlR/GTZz64uMFNvdAiw7yKD/yAZhuDfwHskEsBOmUiJcgWRn3VjLrC6Fx4P1Fw==
X-Received: by 2002:a05:651c:2009:: with SMTP id s9mr10340409ljo.31.1620529298709;
        Sat, 08 May 2021 20:01:38 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id w23sm1773648lfu.132.2021.05.08.20.01.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 20:01:38 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id s25so16558923lji.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 20:01:38 -0700 (PDT)
X-Received: by 2002:ac2:5e6e:: with SMTP id a14mr11470223lfr.201.1620528822658;
 Sat, 08 May 2021 19:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk> <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
 <CAHk-=wiOPkSm-01yZzamTvX2RPdJ0784+uWa0OMK-at+3XDd0g@mail.gmail.com> <YJdIx6iiU9YwnQYz@zeniv-ca.linux.org.uk>
In-Reply-To: <YJdIx6iiU9YwnQYz@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 19:53:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wih_O+0xG4QbLw-3XJ71Yh43_SFm3gp9swj8knzXoceZQ@mail.gmail.com>
Message-ID: <CAHk-=wih_O+0xG4QbLw-3XJ71Yh43_SFm3gp9swj8knzXoceZQ@mail.gmail.com>
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

On Sat, May 8, 2021 at 7:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Re READ_ONCE() - we are wrapped into
> read_seqbegin_or_lock(&rename_lock, &seq) there, so it's more about
> being explicit than about correctness considerations.

Well, part of this all is that the next step is that "vsnprintf()"
with '%pD' would basically use prepend_entries() with just the RCU
lock.

That said, even with the rename lock, that will only cause a retry on
rename - it won't necessarily fix any confusion that comes from the
compiler possibly silently re-loading 'parent' multiple times, and
getting different pointers due to a concurrent rename.

Now, those different results should all be individually ok, due to RCU
freeing, but it's _really_ confusing if 'parent' might be two
different things within the same iteration of the loop.

I don't see anything truly horrible that would happen - mainly "we'll
prefetch one parent, and then due to reloading the pointer we might
actually _use_ another parent entirely for the next iteration", but it
really is best to avoid that kind of confusion.

                Linus
