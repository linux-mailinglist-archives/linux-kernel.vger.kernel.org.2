Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3D8450751
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhKOOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhKOOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:43:36 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D7AC061766
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 06:40:36 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso27829868ots.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 06:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mG8lh6BBVoPcqkpcdF5hHU3Rz1pA4sg03dlH/N+8Cg=;
        b=P4Wkr+j1GlIkdchvHdfwiOP/+Ip47VbZXqXxT043fBYWhAIfBICYQYDa+myknT/Qlj
         paq65WnNv7ZOYAyrOzFARrFVmHTsevihAnanT/1FlORBV6YA5Dk4qjO82o/klNSOm9CQ
         qoBwmgfScRIE56j2yw+oBkeHhfT2xMVyO6z9feqPJkpLPukEUsrSHMwm8zlPEdOERbyu
         hGFCrQE+qyXZf/3sof0yI9LNlr74s+z9p5DmHrf3M6rFDT6bE4K9soPdkiNc+tOivhje
         Ca2X845q76cnj4F8OJ3kb3jAhs/yEcIuBT3s4OKYrz/1QIZvwTKNBXjMLrMU68KDhkPl
         SJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mG8lh6BBVoPcqkpcdF5hHU3Rz1pA4sg03dlH/N+8Cg=;
        b=LSAlGCi9z80rjXsfpNDXRzNlZI6tkAoiehczFfNWP55//eDPTzc/JUx86PXrqLKWvp
         wm+K2APm530P6y14XKRg0W0pbgjKVVFR7B+Z17g7TjBcY+oDVURxmlD8n0tWHxgsOINw
         qtCfDOCqgLZUTgEbsvNhnV9guXAKyUSYLWscNgUkSc4cB26AhHFCkf/FQCirGLawTJgF
         bz/aNaZtqQgEnjXwrP/+UVbaWCrrj5UjlVmWMfhhg9x5wgBxLl6mwZbSEkfDSWfSnPIR
         dYTcwhGCMYw9ELDZJ2NT8fE+H94DzqX8SxjPyJ1e5TvfVbNFJ6bg71dZIECzL3JXDJjS
         +cxg==
X-Gm-Message-State: AOAM530l6pECMlHC+Xg4IUItFNG1Ks1ApqD7ezb+Oqo6G2JbdtRBYtZk
        eGG6q+XjK4IudPoOwBzaMhmfrhuGMSi+2nf22yHtMA==
X-Google-Smtp-Source: ABdhPJzCqc6If8MhAoNJk/O2ejAH9Z5mx2h1iay9CLE7nekTx5H4E/OQTfuNxyQEWGjeDEruZgxnteilXWDXkyIb0zU=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr31541498otl.329.1636987235754;
 Mon, 15 Nov 2021 06:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20211115085630.1756817-1-elver@google.com> <YZJw69RdPES7gHBM@smile.fi.intel.com>
In-Reply-To: <YZJw69RdPES7gHBM@smile.fi.intel.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 15 Nov 2021 15:40:24 +0100
Message-ID: <CANpmjNMcxQ1YrvsbO-+=5vmW6rwhChjgB20FUMKvHQ9HXNwcAg@mail.gmail.com>
Subject: Re: [PATCH] panic: use error_report_end tracepoint on warnings
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wei Liu <wei.liu@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Alexander Popov <alex.popov@linux.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 at 15:38, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 15, 2021 at 09:56:30AM +0100, Marco Elver wrote:
> > Introduce the error detector "warning" to the error_report event and use
> > the error_report_end tracepoint at the end of a warning report.
> >
> > This allows in-kernel tests but also userspace to more easily determine
> > if a warning occurred without polling kernel logs.
>
> ...
>
> >  enum error_detector {
> >       ERROR_DETECTOR_KFENCE,
> > -     ERROR_DETECTOR_KASAN
> > +     ERROR_DETECTOR_KASAN,
> > +     ERROR_DETECTOR_WARN
>
> ...which exactly shows my point (given many times somewhere else) why comma
> is good to have when we are not sure the item is a terminator one in the enum
> or array of elements.

So you want me to add a comma?

(I'm not participating in bikeshedding here, just tell me what to do.)

Thanks,
-- Marco
