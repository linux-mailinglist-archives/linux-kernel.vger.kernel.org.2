Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210F9413A13
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhIUS2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhIUS2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:28:20 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602CBC061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:26:51 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id w1so23854843ilv.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIAwjoyqZOQgLyB/HfPgsMnh+X9W5oz1oq4yBUHKI9E=;
        b=jzSWPHHWdg6/T2XFMBtYdmEyJq3e/SuFWIfwNR6dmxqZC9edwDT+EqSkSGgOqMN2AL
         nt+rkZwUeXRAVd+Fr6HYBfuC+/kO7LAq9vtcWmkEuir9IHbq6e511FqFZGHIkmdb/niH
         q5yt5OJ4S/Aq0Hk28XceO8a3+E0nwJfjweegjZF9n8Y28aYOTuOaWGsfYCLm44tfxLHC
         LQTmJ0MctJfkaDEk2kik5xAYVZICUHfThX4/4+ngigp/Z9eUYRYXNkoNe/GBJkEZBMgr
         Q3qyth8UB5xeEtPuVxtOsLkb3VRqWyugedJU40EZJ2ymHo2GdM6FJ9BpOQyvlH21Fh9Z
         5Mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIAwjoyqZOQgLyB/HfPgsMnh+X9W5oz1oq4yBUHKI9E=;
        b=VMXUTncRhQAVsP0iiTbleNgGA336goZciS8jvddk0njlaoSLOcvZ84SPfX70v33/IL
         JtDg0WxKgGYydTP56vbRL/shNNu9CgiHY0L9rzdlSgYG0mcGy3HfmuGxpev3ySVqoiSk
         4E78Qxcn3AftaOHK46rDgH1K7KWMpukVm/UxFAwtzT0cIHzN3wTJDa2RAp5OYUFPZ3IQ
         I65ApLoK7yBV7pRJQiP3w5QHqI1FDN/KABfwMR03aD1UGxhDK8q79QqGmHOinsTGr6qJ
         AHMPh9eE0543m2xN24nyaIR/b063tGWp+3YzPK6zoJzBhuj1RLqts77rgy7jOSPLMJIv
         MepQ==
X-Gm-Message-State: AOAM532gvIcAHEKnSE7DWfI12BOdar5dOXPvQI3I9fohuW4djNi5hZHJ
        0yFH2oSZULSfF+meGl5ECj0JMcwPzvh0f9edlyz++Q==
X-Google-Smtp-Source: ABdhPJyyGhiWSc0MI8yMRYcV7DheCrh8Ap/YzlNY5R6XZxuT4TFBSl3Eont0d5Knysn/4110iYh0yOL/nwiPFiEYTcQ=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr22413467iln.275.1632248810601;
 Tue, 21 Sep 2021 11:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210921163323.944352-1-axelrasmussen@google.com> <YUoaDr2wsW8wtk5Z@t490s>
In-Reply-To: <YUoaDr2wsW8wtk5Z@t490s>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 21 Sep 2021 11:26:14 -0700
Message-ID: <CAJHvVcj68inRrpmw0pJq9qFc20JzG8+s7b31HkXQcsLcAJN_0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 10:44 AM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Axel,
>
> On Tue, Sep 21, 2021 at 09:33:21AM -0700, Axel Rasmussen wrote:
> > diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> > index 10ab56c2484a..2366caf90435 100644
> > --- a/tools/testing/selftests/vm/userfaultfd.c
> > +++ b/tools/testing/selftests/vm/userfaultfd.c
> > @@ -79,10 +79,6 @@ static int test_type;
> >  #define ALARM_INTERVAL_SECS 10
> >  static volatile bool test_uffdio_copy_eexist = true;
> >  static volatile bool test_uffdio_zeropage_eexist = true;
> > -/* Whether to test uffd write-protection */
> > -static bool test_uffdio_wp = false;
> > -/* Whether to test uffd minor faults */
> > -static bool test_uffdio_minor = false;
>
> IMHO it's not a fault to have these variables; they're still the fastest way to
> do branching.  It's just that in some cases we should set them to "false"
> rather than "true", am I right?
>
> How about we just set them properly in set_test_type?  Say, we can fetch the
> feature bits in set_test_type rather than assuming it's only related to the
> type of memory.

We could do that, but it would require opening a userfaultfd, issuing
a UFFDIO_API ioctl, and getting the feature bits in set_test_type. And
then I guess just closing the UFFD again, as we aren't yet setting up
for any particular test. To me, it seemed "messier" than this
approach.

Another thing to consider is, for the next patch we don't just want to
know "does this kernel support $FEATURE in general?" but also "is
$FEATURE supported for this particular memory region I've
registered?", and we can't have a single global answer to that. It
seemed a bit cleaner to me to write the code as if I was dealing with
that case, and then re-use the infrastructure I'd built for patch 2/3.

Basically, I didn't initially have a goal of getting rid of these
variables, but it ended up being the cleanest way (IMHO).

Just trying to explain the thinking. :) In the end, I think it's a
stylistic choice and don't feel super strongly about it, either way
could work. So, I can change it if you or others do feel strongly.

>
> Thanks,
>
> --
> Peter Xu
>
