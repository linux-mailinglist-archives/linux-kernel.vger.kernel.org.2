Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EB03CBC06
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhGPStN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhGPStM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:49:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8674C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 11:46:16 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h4so14072968ljo.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTghoLbCDRsPHlkRfT2BpYoQqjaMPL1wM1ryXor/pl8=;
        b=Yo1YBV6yujkR2ygTqgd5q5YaFSVLTQIFEqJcPs/7a2NvLrNu4b9HsgEKc9l4Z/a7RX
         MHhfB3JJX4pkfmb+eheeIr9JMh/cg5ONr2o3OpRj7HkBWfVJ5/C3VNBingxpl6lmoVKr
         IRK1aaDAd7SQGcEIlO35zB/5FUHncTwx8qSSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTghoLbCDRsPHlkRfT2BpYoQqjaMPL1wM1ryXor/pl8=;
        b=ZX4IaIBLXe7gxuhTUsB/wH+3ioBuy0GIr5dDb07LUjX18L4LJJ5aEm/oGt4KOp+/Sx
         Glp6YNmBHDd3Bj93tK1kFTmqJGIOfMxwmcGtpjjyBgQibyOLdCD/7uDdX6GDC1FrQeQ0
         b72glwzWY+Gn+fad1YGG09d+UzVBEg3WgFhaca8PTTafNoNowmxq5EQCTyjWXszh3FkX
         Q3eltj4Rb7vaaKXZhxPQxH9jshzcnC1ZSxbQQSzy3+V4X/JZTwsV5A3QyNteDBFaq3Fp
         H1RajgxBslnBI8zSz8LF229igHqAPn43AKdMO9ZlucTXJn51sCsG2YKgn2XPFARdiCAZ
         kvFw==
X-Gm-Message-State: AOAM533vFg9nH+5dBU4tckc4JxEn8kvxIpNZbsh7cDKJqhogYIXxmAGp
        tpk4Q0oSwkjPm4DuLPHyvmmbh96m2Jx0h+Dk
X-Google-Smtp-Source: ABdhPJwWqwFigHAjDSQrQG44fpUYtsEiFn5RW5iUKZ04TFym+oeG9Eoj8WvwCz4G6aBnFw56cY216Q==
X-Received: by 2002:a2e:9582:: with SMTP id w2mr10176824ljh.49.1626461175077;
        Fri, 16 Jul 2021 11:46:15 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id k11sm705110lfm.133.2021.07.16.11.46.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 11:46:14 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id g8so11740341lfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 11:46:13 -0700 (PDT)
X-Received: by 2002:a05:6512:2347:: with SMTP id p7mr8834152lfu.253.1626461173698;
 Fri, 16 Jul 2021 11:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210715215753.4a314e97@rorschach.local.home> <CAHk-=wiWdG6jqKhdU62b06-DtESVxHVK8MA23iV+6fB5hnGEAw@mail.gmail.com>
 <20210716143705.56001390@oasis.local.home>
In-Reply-To: <20210716143705.56001390@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Jul 2021 11:45:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWosrcv2=6m-=YgXRKev=5cnCg-1EhqDpbRXT5z6eQmg@mail.gmail.com>
Message-ID: <CAHk-=wjWosrcv2=6m-=YgXRKev=5cnCg-1EhqDpbRXT5z6eQmg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: histogram fix and take 2 on the
 __string_len() marcros
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 11:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> So how do you want this implemented?
>
> #define __assign_str_len(dst, src, len)                                 \
>         do {                                                            \
>                 strscpy(__get_str(dst), (src) ? (const char *)(src) : "(null)", len); \
>                 __get_str(dst)[len] = '\0';

What? That "__get_str(dst)[len] = '\0';" is pointless and wrong.

That's the _point_. strscpy() does the whole NUL termination
correctly, in ways that strncpy() never ever did.

But I also want to know what the actual _semantics_ of the source is.
Your "memcpy()" example implies that the source is always a fixed-size
thing. In that case, maybe that's the rigth thing to do, and you
should just create a real function for it.

So two choices:

 (a) either just plain strscpy() works (or, if you want NUL padding,
use strscpy_pad()).

 (b) you have very odd source/destination semantics, and it should be
its own function that explains it.

Note how in neither case is it ok to just make random inline code with
no explanations for the odd crazy code. Make a function that actually
describes what you want, documents it, and be done with it.

strncpy() is garbage. It should never be used in new code.

And random semantics that are undocumented and just implemented as a
illegible mess in a header file is not ok either.

                Linus
