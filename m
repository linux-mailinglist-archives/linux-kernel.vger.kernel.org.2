Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7318C43D77B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhJ0X2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJ0X2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:28:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0752DC061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:26:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g184so4506954pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HR5ARO7Si6PfX/dXB3BRQw0tF8C5aOImPzmLbJKRS68=;
        b=nlQf8zO6uI78TN/hHMKb4DnvQiQs1Zqc2reSwopjutNX0yfjbEw6qik2pMeiX83ka5
         ylRD3FiR9K6hAEgIgkUvu0EYtzJErtq9hPHzWUKbsSffmmZ4DmvNmjA4GqYxfm7WHSIz
         l94jCNt64Gty/sN+mxarPNIF3v/eH4K5zUMy4kHd/xViS89PYubqR+uy7Gb0XYf99lEA
         tyHdUh8DQzUdMYGk+vq1hrg12YHdWyq8deci/s7ThJI8wA2VncC+wlT/FgZuCo1vpsSD
         jFHEAsUA0jP18aQroBoee5STB/78XdltT7LhaC9juU5qec3oB+jlQVyXAvLlXK6P9MKD
         cggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HR5ARO7Si6PfX/dXB3BRQw0tF8C5aOImPzmLbJKRS68=;
        b=N/Q4IbdTqM41F3cF+QBdCY6NaLkmo18NJyGxTeTlhjOeqPDK/ZebuwICjW5yzd4HIp
         q46MWPYVHsB4OS8igNWfSfm+XN9Da/ZRxtI37J8XqOobpVHZXbYac7Ky38SO6AduG/85
         l5h+1X/f46bVNe+UFhKh5cmz3JDYuDIoJSGn0Kj+H+M08w0t8ECKs30/6t52JCR8juko
         mTHlhSZUUQ2j3hQHediw1fGiHnwpyTsxkRogrOz6YnuRp0i94we2aiup/qU/J85h1btP
         738I+xkER/uADnqmpuBKi6oGBqAi993H6p3nmJw/VY+WRCDg1G6aGk8oqAC+MQ7Hn8r2
         aonQ==
X-Gm-Message-State: AOAM531KvDVxshn7RwhLvORXkuIy9VfpcLV07ehxjAO/fk9QI+mA4X2D
        h5zJS9aIox+N3O7+2OTwlo1F0jaqkpY5EAYHJywVMQ==
X-Google-Smtp-Source: ABdhPJwsHHsOlRXVtUk6JpR71VCG91jjeuobOmipSjQtgu5u4HKSJPoOamAz7bUAyKlv3bUcM/F/76zQF/SypatdM6k=
X-Received: by 2002:a63:b212:: with SMTP id x18mr553740pge.345.1635377171205;
 Wed, 27 Oct 2021 16:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211027205919.1648553-1-kaleshsingh@google.com>
 <20211027205919.1648553-3-kaleshsingh@google.com> <20211028065849.76b1bd7151e440881298b523@kernel.org>
In-Reply-To: <20211028065849.76b1bd7151e440881298b523@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 27 Oct 2021 16:26:00 -0700
Message-ID: <CAC_TJvdxEuqkzH+VDNQvWZbLjHj0BKfnCHn647Y9-Ve2UTftRg@mail.gmail.com>
Subject: Re: [PATCH 2/3] tracing/kselftests: Remove triggers with references
 before their definitions
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 2:58 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Kalesh,
>
> On Wed, 27 Oct 2021 13:59:09 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > If an event trigger references a variable defined in another trigger, it
> > has to be removed before the trigger that defines the variable is
> > removed.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  tools/testing/selftests/ftrace/test.d/functions | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> > index 000fd05e84b1..bd9e85f4d626 100644
> > --- a/tools/testing/selftests/ftrace/test.d/functions
> > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > @@ -22,6 +22,15 @@ reset_trigger_file() {
> >       file=`echo $line | cut -f1 -d:`
> >       echo "!$cmd" >> $file
> >      done
> > +
> > +    # remove triggers with references next
> > +    grep -H '\$' $@ |
> > +    while read line; do
> > +        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
> > +     file=`echo $line | cut -f1 -d:`
> > +     echo "!$cmd" >> $file
> > +    done
> > +
>
> Why don't you use 'tac'? I love that idea :)
> Did you find any issue?

Hi Masami,

Thanks for the reviews. As with the first set of patches using tac
gives a regression here, though I'm not sure why it doesn't work -- I
also thought reversing the order would handle any dependencies
correctly.

- Kalesh
>
> I think the function which cleaning up the tracing file should use
> the 'tac' rollback method, because it is natural, simple and robust.
> Then the first loop for removing action triggers is not needed anymore.
>
> Thank you,
>
> >      grep -Hv ^# $@ |
> >      while read line; do
> >          cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
> > --
> > 2.33.0.1079.g6e70778dc9-goog
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
