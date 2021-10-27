Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA02843BEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhJ0BSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbhJ0BSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:18:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BA1C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:15:46 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f5so1232415pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOM1t1mdsB+vMIZOqpURx1Aj73if+RCOkMBAhH7ofr8=;
        b=nYQoGCN+iMpFRaTFW/grBCxnwnU7DV72AjYMkfoswZBVwu4VoaMY2zac0p8Uq8mBle
         WYimfrc0mfs9ZHRINzzZM0Yj9Gj35y4ZxRKc2sZaUOw3KfxpnimTiG1aQ6bhc/LK2S7K
         FvOA6hhPr6qgJ8JnXNmXjcit75eqhMPhsiUlEZJn99y+MvC2umdaX1kcQnbgCjP+x+tD
         xu8tEHfou40vzxdTihhE70AUBygBz0M/0fOeb81G34DPNL5ia9hZlFcTTSV5xPXx6fHX
         uxyXCdrpvq7/gSLTwzoGRs6fxeHnYkOIQ5q2bao/Gjt2TXmZF218tmO7U97GRy6Y2DbX
         UWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOM1t1mdsB+vMIZOqpURx1Aj73if+RCOkMBAhH7ofr8=;
        b=Mi9ptxPb+jY2mzrMGWAeRIVHndYibT2e/Je5n4lKliPLpFrq3OVqzB8kzAfB2y+cnt
         glc/E34axp1ry1jfFAQVe6OXI2lhboJiIwYyq769oGPfyhrG6mumuUWrNDc+8WU2rGg5
         li57RGLtNwDY4gtpRU2nD82cdKeH1TyiLRB+rJEicyGWHMz5NCx1esZI1Ibw5qnkoMeG
         eoZBgP5U4MncQzaYJ0pa3rwzOMH3i7zddZVrh8L05kFHtbAGqAY6XznwnEA4bkNEv2hN
         P0Gy0tBLipQVKJKFcgAqDpLn1ZsUf5AqsAZJjzAMMN4sHQopS/5NfJWznCeS2hRahyPK
         Id+g==
X-Gm-Message-State: AOAM533k7iv2o0h2ljwAK6OP6X8ITQ1tWZggOP3FaXUSgBJCTILtcqf9
        jRCJ9pALDq3sZfCXyLu7X+qVaI8LtyScHWwi5kDGTQ==
X-Google-Smtp-Source: ABdhPJw3HM2ttj24uXzv1jjaRTP+7zt82rESebmzg2uoIpU0RY2pwWx5+jQ2AWdGwdXbHAUl+V/qgzntWNV8ms8J1rY=
X-Received: by 2002:aa7:8246:0:b0:44b:4870:1b09 with SMTP id
 e6-20020aa78246000000b0044b48701b09mr30086990pfn.82.1635297345864; Tue, 26
 Oct 2021 18:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211025200852.3002369-1-kaleshsingh@google.com>
 <20211025200852.3002369-8-kaleshsingh@google.com> <20211026214311.583c728d90d41778c38201dd@kernel.org>
 <CAC_TJvfQQCyuSZqjzC0fuAah84uLgHJv5T+WtR8=9h5fN9nrLA@mail.gmail.com>
 <20211026174420.0056bde2@gandalf.local.home> <CAC_TJveMumb=BkGL53d_rS08uQ35fz1B7cM9jp8eKoCz0MUG_Q@mail.gmail.com>
 <20211026202020.026e7907@rorschach.local.home>
In-Reply-To: <20211026202020.026e7907@rorschach.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 26 Oct 2021 18:15:34 -0700
Message-ID: <CAC_TJvf8areGd1rQMbJV4r+J6JP2-DWXBLQwKRZEOzNWL_rqrQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] tracing/selftests: Add tests for hist trigger
 expression parsing
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, surenb@google.com,
        hridya@google.com, namhyung@kernel.org, kernel-team@android.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 5:20 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Oct 2021 16:36:03 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > On my setup I without any of the changes applied (config hist triggers enabled):
> >
> > ./ftracetests
> >
> > # of passed:  41
> > # of failed:  40
> > # of unresolved:  0
> > # of untested:  0
> > # of unsupported:  32
> > # of xfailed:  0
> > # of undefined(test bug):  0
> >
> > Do all the tests pass for you, before any of the changes in this
> > series? Maybe some of the tests need updating?
>
> All my tests past, and I don't push any code if they fail.
>
> I'd like to understand why you have these failures. Are the test from
> the kernel you are testing?

The results are from the kernel before I apply any of the patches. I
am testing on an Android emulator (cuttlefish) with 5.15.0-rc6 kernel.
The tests clearly work so it must be something on my end. I'll
investigate and get back to you.

Thanks,
Kalesh

>
> -- Steve
