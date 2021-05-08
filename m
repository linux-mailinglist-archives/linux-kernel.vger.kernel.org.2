Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B39377478
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 00:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhEHW5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 18:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhEHW5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 18:57:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E98BC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 15:56:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v5so3430680edc.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uU2C84LxLUzQFwZElgypUBzdpgy1KMmCT9LOJvhbML4=;
        b=RAYIrloAyTI0escC4FJrZEqff58mGNKpKYKPCWyfaq6tPSVX7E0HvbEpZICexuWOJl
         cTb8VTtrxxvNrokrOEsTOilRR8r0Du+gtbA27yAia0bgOluq1xb1ES21ZBT6x5owDQfQ
         d+VnnukbT/eYVV1K8DnY34CmcMlPrprr6+vgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uU2C84LxLUzQFwZElgypUBzdpgy1KMmCT9LOJvhbML4=;
        b=bRG4PxU5H2T1/JyZTM1F3ti70TuI9jV00r+vviPPZbpWyRtXOLBNgmI0Sm6NNSwztN
         Cgr243F+PBnIWGsF2kTZjLHo2+KUTcFrraWUhh3HAoSad4AXJM/Q/eGFvhZo0Nf8LuTC
         g8fa7ERlq1f25eGbkc57HHvW/SnXogKmQDnqCzkBknQy7WSITQsfMjXr9Lw+IUNGvdVR
         Q1yduMUxnsXRJzdaYcNgfnCjZhE3dK3hjARl5e8nbfE/xBhc5498X71TTbv32PlRxS12
         +iEt0ChCK+lzakzaI+xwTYcYkQHuq71aLwtJ914Rx5achrPKO44GAm1BGO5BMVAv6gkr
         gAFg==
X-Gm-Message-State: AOAM5307wxsICVst6RK5xeOfN+Kwh9xmDOhXoORXMeNIy0QgbNZC4GK+
        XcFQv+AI4gE7l5Kvs2do0e7yZlVtpvik6qaIlDg=
X-Google-Smtp-Source: ABdhPJzw33TEd+Ou6gTI9wsZ5P8SMwITX12cnx1aMZlnsaHcTy5Z2BVuDTecRBh4dPlclMfbL/m8zg==
X-Received: by 2002:a05:6402:1d8f:: with SMTP id dk15mr17589674edb.146.1620514562138;
        Sat, 08 May 2021 15:56:02 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 16sm5973509ejw.0.2021.05.08.15.56.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 15:56:02 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id v5so3430670edc.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 15:56:02 -0700 (PDT)
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr10765354lfg.40.1620514074003;
 Sat, 08 May 2021 15:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk> <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
In-Reply-To: <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 15:47:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOPkSm-01yZzamTvX2RPdJ0784+uWa0OMK-at+3XDd0g@mail.gmail.com>
Message-ID: <CAHk-=wiOPkSm-01yZzamTvX2RPdJ0784+uWa0OMK-at+3XDd0g@mail.gmail.com>
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

On Sat, May 8, 2021 at 3:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But your READ_ONCE() is definitely the right thing to do (whether we
> do your re-org or not, and whether we do this "prepend_buffer" thing
> or not).

Oh, and looking at it some more, I think it would probably be a good
thing to make __dentry_path() take a

       struct prepend_buffer *orig

argument, the same way prepend_path() does. Also, like prepend_path(),
the terminating NUL should probably be done by the caller.

Doing those two changes would simplify the hackery we now have in
"dentry_path()" due to the "//deleted" games. The whole "restore '/'
that was overwritten by the NUL added by __dentry_path() is
unbelievably ugly.

            Linus
