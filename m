Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AEC44CA41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 21:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhKJUOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 15:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbhKJUOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:14:05 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB8DC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:11:17 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bu18so8870683lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIXih9GU4NqMypYA7Dr0jx2NlckxBXybX3o8wMySwgY=;
        b=MQpfLdrsLMfMXyJmeTe28PO4JMQ8+aF4itutOZof98/e/JVNK5SVfuOuBrERPM5N8u
         6mpxv0niiGe5BfL40P44TG06AHv5J623lJJyaJj6x5hsuofw47Ce+ZMABbD/82KtEioN
         Xav9pRS6lItXHD1UvAGLhVAgb4+KIV8KA8cJvIYYNeNIkHn6lSltMwkpaVuCu/KvNjM2
         SLBIyx8W75J4NJJFaWO9+/Z4fmTwFc1tmYO5beFns1XsnEq6mAlqSqS1fosYesOEpNa4
         wmk9LwgBiKK0mfW7OjLIMVQrgkn9ZZDJh/vdtKfOdY9rdeLSz/gWYOo/1jON7VrjIAmJ
         ogmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIXih9GU4NqMypYA7Dr0jx2NlckxBXybX3o8wMySwgY=;
        b=pvpoim2/NIL3RKnfapB0M1JZsbH70YHG3ynvZkGdoD7/+uba+aHhflxDkumaRfzODj
         yNr2wWofGI0nTPRl7Ry23GLFzeDbrZC9+1mVt/LLCtgNMy2l8mIcQIXiGFW6fXASybS/
         mRkVsLuFu0rwn+hdxnqO9ZyTWWOoPJjgCQsVPNn9XficzOnajiEageectKn/3OC/D5n0
         smGPWJVAJbSwRGIZ34dIOynnOdvdJSNbnSBZ3b2WzrvpYl9g0rQgmUNjx2xgnBmErbXI
         QCe3Xd+DC8UazzaD0yRvK8Vc6Zm+8Fe8RCgN5BSwxzs8qOb5KZEybsV0rP6YY4Qo/uSv
         MHaA==
X-Gm-Message-State: AOAM530VaKjG6oQDX+fZTUfwpceol/drg4SbpXXwJ8S/CXW6DoAM0/Hq
        eEQB9E76UT7SfxJAJ7ocCeLjuaQbcBDA9zol2EfWROMS568=
X-Google-Smtp-Source: ABdhPJy2Xe5owYl4nyUoytHp4HNepVE4HMcKJ3NX6Ap63uZwX3DgnXdFw7bQADviO7nj7SnQ/PcbHrb00w+GsF6cmxU=
X-Received: by 2002:a05:6512:150e:: with SMTP id bq14mr1695406lfb.444.1636575075479;
 Wed, 10 Nov 2021 12:11:15 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a3ZuL9TQbj+tGkdvRRmEv_jT3OvzmaoFKHwdw=5J1w_SA@mail.gmail.com>
 <20211110180359.2338349-1-anders.roxell@linaro.org> <CAKwvOdkoKvjecTfxbRwZ=BYirvy-Jq64pHtHuct8oWgExv1xPw@mail.gmail.com>
In-Reply-To: <CAKwvOdkoKvjecTfxbRwZ=BYirvy-Jq64pHtHuct8oWgExv1xPw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Nov 2021 12:11:04 -0800
Message-ID: <CAKwvOdnNKHJ++8vJS7WvaZX1aRZHk5uA7LP+S=ApSjRcU4QDkQ@mail.gmail.com>
Subject: Re: [PATCHv2] selftests: timens: exec: use 'labs()' over 'abs()'
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 12:09 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Nov 10, 2021 at 10:04 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > When building selftests/timens with clang, the compiler warn about the
> > function abs() see below:
> >
> > exec.c:33:8: error: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
> >                         if (abs(tst.tv_sec - now.tv_sec) > 5)
> >                             ^
> > exec.c:33:8: note: use function 'labs' instead
> >                         if (abs(tst.tv_sec - now.tv_sec) > 5)
> >                             ^~~
> >                             labs
> >
> > Rework to store the time difference in a 'long long' and pass that to
> > llabs(), since the variable can be an 'int', 'long' or 'long long'
> > depending on the architecture and C library.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

ah, gmail doesn't do a great job at showing the subject when a v2 is
sent in-reply-to.  Should the oneline mention llabs rather than labs
now?

>
> > ---
> >  tools/testing/selftests/timens/exec.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
> > index e40dc5be2f66..04439e6ac8a2 100644
> > --- a/tools/testing/selftests/timens/exec.c
> > +++ b/tools/testing/selftests/timens/exec.c
> > @@ -21,6 +21,7 @@
> >  int main(int argc, char *argv[])
> >  {
> >         struct timespec now, tst;
> > +       long long timediff;
> >         int status, i;
> >         pid_t pid;
> >
> > @@ -30,7 +31,8 @@ int main(int argc, char *argv[])
> >
> >                 for (i = 0; i < 2; i++) {
> >                         _gettime(CLOCK_MONOTONIC, &tst, i);
> > -                       if (abs(tst.tv_sec - now.tv_sec) > 5)
> > +                       timediff = tst.tv_sec - now.tv_sec;
> > +                       if (llabs(timediff) > 5)
> >                                 return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
> >                 }
> >                 return 0;
> > @@ -50,7 +52,8 @@ int main(int argc, char *argv[])
> >
> >         for (i = 0; i < 2; i++) {
> >                 _gettime(CLOCK_MONOTONIC, &tst, i);
> > -               if (abs(tst.tv_sec - now.tv_sec) > 5)
> > +               timediff = tst.tv_sec - now.tv_sec;
> > +               if (llabs(timediff) > 5)
> >                         return pr_fail("%ld %ld\n",
> >                                         now.tv_sec, tst.tv_sec);
> >         }
> > @@ -70,7 +73,8 @@ int main(int argc, char *argv[])
> >                 /* Check that a child process is in the new timens. */
> >                 for (i = 0; i < 2; i++) {
> >                         _gettime(CLOCK_MONOTONIC, &tst, i);
> > -                       if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
> > +                       timediff = tst.tv_sec - now.tv_sec - OFFSET;
> > +                       if (llabs(timediff) > 5)
> >                                 return pr_fail("%ld %ld\n",
> >                                                 now.tv_sec + OFFSET, tst.tv_sec);
> >                 }
> > --
> > 2.33.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
