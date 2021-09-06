Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD85A4020A1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 22:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbhIFUGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 16:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhIFUGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 16:06:38 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D5BC061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 13:05:33 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id z5so15493140ybj.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 13:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lm4jdiDuWbqAv4O7YJ6wZ0vVIEpUpOQJ86d4UA/6SjA=;
        b=I5fTuvgnT9HxQ8xV0WPigXQzCZJUNgH1XdAnBxrfTTXtABBsN58Equ7pN+lofptQr5
         v8AJZEUyQ5CEVJ1PuLnXmMsIggU6WfCOxXtAskYJS3GsrojX31Qqk/lQu3VEDJXYq6Gi
         F3LhosFyS3VlcpzONHNaDcLIchdgiL5v4NA35UZSDxOFigjbi3/k2ZSVwDtxBAdMLeEh
         PiApND73vDcx4gkZyX2ovCBhM57vfLg6OLSOS0lritofSJz4hrdw/sM8mUdEhTGvv1aw
         U7mhhYqzmX6t+hCI8DkX+hR+3KQpqsrlj3AtMfivn9VVLvlapxzhUfpCVoN9HAmKa7Ej
         E3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lm4jdiDuWbqAv4O7YJ6wZ0vVIEpUpOQJ86d4UA/6SjA=;
        b=LF/AkYlLwQBZl7Ugz9kJHHHgligetCrPhgtk3M8z8+nyZZa/LrBS+7I+pHwQnS+BDJ
         6Y4Hn2KfHMq1Qx+7i97KWEgjYTbTI6Jb0MQymfM7Wu9P5krYjYxuMQjKhYx26chyawp5
         sIXAWMyhCD3aXv7YAkWx3/Tfs+4ZkRhICAyZ/Uy7SkcCxOEXPEAJQeeuaq7zgtJ0H0By
         3ttcpCAJqD7yhBwdiNCwaQmGMuAZTj38fV0926b59y3YfBVutF9QoFksu8dgdMSWT/Be
         bqtMeJxJ/HjzlYHxiM3kb6n/P3mtP+7MRL72iNX+WrLlyT7X0gJgeCqTksUdh+H9u4X1
         eplA==
X-Gm-Message-State: AOAM532OqTsOBFWw8+5Fqx2Iw4sEs9qrxSQuC95rxiM32NIefmgmr36V
        vwXPR5hGhoZUag5csjkgM1K6Pc9+wU2Sl5nR2G3ECw==
X-Google-Smtp-Source: ABdhPJxRjqK/FZ4AoWTnkr8ASqTSmfC1tsb9qFvW2zNIHqFPVPi5jMbxh0tyslfhYDzSJFTj5fVm7boyJH+vPTsyD1I=
X-Received: by 2002:a25:3046:: with SMTP id w67mr18083671ybw.134.1630958732615;
 Mon, 06 Sep 2021 13:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210830044425.2686755-1-mizhang@google.com> <20210830044425.2686755-3-mizhang@google.com>
 <CANgfPd_46=V24r5Qu8cDuOCwVRSEF9RFHuD-1sPpKrBCjWOA2w@mail.gmail.com> <YS5fxJtX/nYb43ir@google.com>
In-Reply-To: <YS5fxJtX/nYb43ir@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Mon, 6 Sep 2021 13:05:21 -0700
Message-ID: <CAL715WJUmRJmt=u4Gi3ydTpbTGy2M5Wi=CbF9Qs8GNRK8g5FAA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests: KVM: use dirty logging to check if page
 stats work correctly
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ben Gardon <bgardon@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 9:58 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Aug 30, 2021, Ben Gardon wrote:
> > On Sun, Aug 29, 2021 at 9:44 PM Mingwei Zhang <mizhang@google.com> wrote:
> > > diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> > > index af1031fed97f..07eb6b5c125e 100644
> > > --- a/tools/testing/selftests/kvm/lib/test_util.c
> > > +++ b/tools/testing/selftests/kvm/lib/test_util.c
> > > @@ -15,6 +15,13 @@
> > >  #include "linux/kernel.h"
> > >
> > >  #include "test_util.h"
> > > +#include "processor.h"
> > > +
> > > +static const char * const pagestat_filepaths[] = {
> > > +       "/sys/kernel/debug/kvm/pages_4k",
> > > +       "/sys/kernel/debug/kvm/pages_2m",
> > > +       "/sys/kernel/debug/kvm/pages_1g",
> > > +};
> >
> > I think these should only be defined for x86_64 too. Is this the right
> > file for these definitions or is there an arch specific file they
> > should go in?
>
> The stats also need to be pulled from the selftest's VM, not from the overall KVM
> stats, otherwise the test will fail if there are any other active VMs on the host,
> e.g. I like to run to selftests and kvm-unit-tests in parallel.

That is correct. But since this selftest is not the 'default' selftest
that people normally run, can we make an assumption on running these
tests at this moment? I am planning to submit this test and improve it
in the next series by using Jing's fd based KVM stats interface to
eliminate the assumption of the existence of a single running VM.
Right now, this interface still needs some work, so I am taking a
shortcut that directly uses the whole-system metricfs based interface.

But I can choose to do that and submit the fd-based API together with
this series. What do you suggest?
