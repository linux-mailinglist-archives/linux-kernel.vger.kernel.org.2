Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51722352FE0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbhDBTmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:42:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660F3C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 12:42:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dm8so6399141edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XrSGH66xwdwA3DVi+6+f8HWhCdsxrE6U6W4y5ctj2Q4=;
        b=Ws2by10q56OGsqje9GWtYH9lJX+D0DsIK9FevOLR2Odg9OxAXlCsgsuKkGyPlDThPF
         3fsC10FjE05o2kuA0CEMiMREHSEWhWU12ibG/pLEZFZQCpQcr/WuYAINpjE9i3BbRpes
         cVUzX55Y1DEVFwhAnsBkeeeDXSWdl7uzz+ppieS45GtGnxrgl6ktSbVnjR1MC2Pk4J8m
         nJ7pktha1q3NWOOQe9mzUNHtAI9LM13Sw6t1LIiLAjP27jxmI+bxqY3eaHn+A80Y6LCz
         pJuW5mOFWZsIJ7RshEIcBk0NX/SOVOQHsDZLQw0d9YKs5+aMkCFEYIxqmghHHG3cmzLk
         kBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XrSGH66xwdwA3DVi+6+f8HWhCdsxrE6U6W4y5ctj2Q4=;
        b=RD8dRk4OzBLgVJuR+i2bGkqYkSxrX8WlU7tT/QtG7HQc8SFD8mUuKjQ5MowXNt45lE
         JcubpMH/FEeFTTzz4N12ZlEE9twLOwRbqBGN5WRZ7PdQ5X2aaZU5+zCdIm0QZWfBRvT3
         5EDWvCYjAlmxf/dNBxrsD+1t/fBckrG58tLULcbcMIWj4B/zqzaSCsh6sKFC8eqtMysN
         jzRRfjg5+W80XXGW+IahG7HlqK9CPWMY7LCCkw1zPLD7+MqtDy4aVrmscpFPxgMB/B42
         jhFdO0dPNytOK9wyPbOsK4bEU2bVbOYoExyq6HTuQ8T4WTIZ5pWNFqzs2lx4myxJTLcG
         3zeQ==
X-Gm-Message-State: AOAM532jd9K7HzMMMzEWJxu7ohRZoZi4YghS6ZpzJIMh5eCj+V7CIGnL
        4dMfUW6W8ePJnPNyWkOMMvaVyeCMIh6bznIJtt0hOA==
X-Google-Smtp-Source: ABdhPJxzy359wHu2Yn4LaE759PINVilNx6VfC7DhRK8dvnBNU0mXCFyroDTOjFaJj9qHFqrYixySWt7KczSaZEQ50/Q=
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr17308556edu.268.1617392534134;
 Fri, 02 Apr 2021 12:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210402094042.9218-1-gi-oh.kim@ionos.com> <CAKwvOdkFJ_WFpt2+rnNR3tbrdFky2NnEOWSG7MhgLrBHJAOEVw@mail.gmail.com>
In-Reply-To: <CAKwvOdkFJ_WFpt2+rnNR3tbrdFky2NnEOWSG7MhgLrBHJAOEVw@mail.gmail.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Fri, 2 Apr 2021 21:41:38 +0200
Message-ID: <CAJX1YtbvVCkzP9AyTd_hZXzN9LV=YgxOZRO17zZRCgTB=MFj3w@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Introduce sysfs_streqcase
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 8:17 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Thanks for the patch!
>
> + akpm (please remember to run ./scripts/get_maintainer.pl on your patch files)
>
> On Fri, Apr 2, 2021 at 2:41 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
> >
> > As the name shows, it checks if strings are equal in case insensitive
> > manner. I found some cases using strncasecmp to check the entire
> > strings and they would not work as intended.
> >
> > For example, drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c uses
> > strncasecmp to check that the input via sysfs is "mi". But it would
> > work even-if the input is "min-wrongcommand".
> > And also drivers/pnp/interface.c checks "disable" command with
> > strncasecmp but it would also work if the command is "disable-wrong".
>
> Perhaps those callers should be using strcasecmp then, rather than strncasecmp?
>
> Also, if they're being liberal in accepting either case, I don't see
> why the sysfs nodes should be strict in rejecting trailing input at
> that point.
>



On Fri, Apr 2, 2021 at 8:17 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Thanks for the patch!
>
> + akpm (please remember to run ./scripts/get_maintainer.pl on your patch files)
>
> On Fri, Apr 2, 2021 at 2:41 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
> >
> > As the name shows, it checks if strings are equal in case insensitive
> > manner. I found some cases using strncasecmp to check the entire
> > strings and they would not work as intended.
> >
> > For example, drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c uses
> > strncasecmp to check that the input via sysfs is "mi". But it would
> > work even-if the input is "min-wrongcommand".
> > And also drivers/pnp/interface.c checks "disable" command with
> > strncasecmp but it would also work if the command is "disable-wrong".
>
> Perhaps those callers should be using strcasecmp then, rather than strncasecmp?
>
> Also, if they're being liberal in accepting either case, I don't see
> why the sysfs nodes should be strict in rejecting trailing input at
> that point.
>

strcasecmp does not work when a user inputs the command with echo.
We can force the human to use 'echo -n' but there are also some applications
that pass the command with \n. If the command includes \n, strcasecmp does
not work.

In short, I need a function working well for both case-insensitive string and
a string followed by '\n'.

I am not native speaker of English. I think the below example can show
my problem.

Below is the original code. That code does not work because of the \n
in the command.

char buf[] = "mi\n";

if (strcasecmp(buf, "min-inflight")  == 0 ||
    strcasecmp(buf, "mi") == 0)
    printf("inflight\n");
else if (strcasecmp(buf, "min-latency") == 0 ||
    strcasecmp(buf, "ml") == 0)
    printf("latency\n");
else
    printf("wrong\n");

Below is the current code in RTRS module. We replaced strcasecmp with
strncasecmp.
That works well but ugly and error-prone.

size_t len = 0;
len = strlen(buf);
if (buf[len - 1] == '\n')
    len--;
if (strncasecmp(buf, "min-inflight", 12)  == 0 ||
    (len == 2 && strncasecmp(buf, "mi", 2) == 0))
    printf("inflight\n");
else if (strncasecmp(buf, "min-latency", 11) == 0 ||
    (len == 2 && strncasecmp(buf, "ml", 2)) == 0)
    printf("latency\n");
else
    printf("wrong\n");

I think sysfs_streqcase could be the best option as below.

if (sysfs_streqcase(buf, "min-inflight") ||
    sysfs_streqcase(buf, "mi"))
    printf("inflight\n");
else if (sysfs_streqcase(buf, "min-latency") ||
    sysfs_streqcase(buf, "ml"))
    printf("latency\n");
else
    printf("wrong\n");


I think that case is not my own problem.
I think some code handling debugfs and sysfs also have the same problem.

>
> This should be declared in
> include/linux/string.h
> in order for others to use this (as 0day bot notes).

Thank you for the kind review.
I will add the declaration if I get the positive feedback for sysfs_streqcase.

>
> > +
> >  /**
> >   * match_string - matches given string in an array
> >   * @array:     array of strings
> > --
> > 2.25.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
