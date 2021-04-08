Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23894357965
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 03:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhDHBOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 21:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhDHBOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 21:14:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98079C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 18:14:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id ay2so171970plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 18:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Rtnw+JWutGb7TkIjf3ereHxImgRoMW09qLlBuzhiEOU=;
        b=dWJH3Njh93bhKpaP8EcWR0s5ijzb480tRMQyQZ0rnQVOqA5arObDDxzsoJBQWfVNHJ
         3XXjcN0ccDRSfd2QczjeRsfv4dzmgIjLHOfHvIbcqt5s3bISb+wO5svAuGJCFjZS1fLw
         n6PM7EZgB3Z8W5zu4O9V2DjfLUAGIVDYjFydI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Rtnw+JWutGb7TkIjf3ereHxImgRoMW09qLlBuzhiEOU=;
        b=XoqI2x3fj42ZOXJqN6EWwVkxf6spXKJiKFEdKAsA+rjf1wgXl0jTJY99uo24UXBSYc
         tVJeOeCrKMNZ+AvdORFSCBp91Tjnxesk1NXa72LrzLAI/yFmliASevjEooAYqHztThyL
         +LG4QbETS2/oU99TqVtsHVLn5BYvORlMEiv1b5q2PqGkZnqtpRxJcmoDKPGZM06ZcdPn
         dc32Hnkb0lSViHMlqXVwa4NcOEHMyohDqTp6PGPWa2+yhc4ypR5R+abVT4FSejadXTOj
         Cm72p+twFgArn4xJZfzBjKsEYIqRlLnhCQKogIS/XxMQ1uI+IXB4zEhsVLUJnxhX2zcS
         9d3Q==
X-Gm-Message-State: AOAM532qrUb49im/Fb4z7v0AjVYfLun2kNH2WjdrCE921BAlhU2fgNtY
        bq1sbgTyZnL3j2f6euQCr5dS0w==
X-Google-Smtp-Source: ABdhPJzYmSkvhr9OeHTLmra4k2CH/7HpZ3KyKXVFvDIPQz6VjdIb9d86XPcfZ+RfjFkHh+TXi1m12w==
X-Received: by 2002:a17:90b:1904:: with SMTP id mp4mr569354pjb.193.1617844445194;
        Wed, 07 Apr 2021 18:14:05 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e193:83c5:6e95:43de])
        by smtp.gmail.com with ESMTPSA id i7sm23307682pfq.184.2021.04.07.18.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 18:14:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YG27p1AhiOKJOm+y@alley>
References: <20210331030520.3816265-1-swboyd@chromium.org> <20210331030520.3816265-4-swboyd@chromium.org> <YG27p1AhiOKJOm+y@alley>
Subject: Re: [PATCH v3 03/12] dump_stack: Add vmlinux build ID to stack traces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Date:   Wed, 07 Apr 2021 18:14:03 -0700
Message-ID: <161784444323.3790633.7333033697525505279@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Petr Mladek (2021-04-07 07:03:19)
> On Tue 2021-03-30 20:05:11, Stephen Boyd wrote:
> > Add the running kernel's build ID[1] to the stacktrace information
> > header.  This makes it simpler for developers to locate the vmlinux with
> > full debuginfo for a particular kernel stacktrace. Combined with
> > scripts/decode_stracktrace.sh, a developer can download the correct
> > vmlinux from a debuginfod[2] server and find the exact file and line
> > number for the functions plus offsets in a stacktrace.
> >=20
> > This is especially useful for pstore crash debugging where the kernel
> > crashes are recorded in the pstore logs and the recovery kernel is
> > different or the debuginfo doesn't exist on the device due to space
> > concerns (the data can be large and a security concern). The stacktrace
> > can be analyzed after the crash by using the build ID to find the
> > matching vmlinux and understand where in the function something went
> > wrong.
> >=20
> > Example stacktrace from lkdtm:
> >=20
> >  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNIN=
G+0x28/0x30 [lkdtm]
> >  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cg=
roup uinput xt_MASQUERADE
> >  CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de20566=
2d5a9e0d4c580f19a1
>=20
> I tried "echo l >/proc/sysrq-trigger" and get:
>=20
> [   75.123014] CPU: 1 PID: 5079 Comm: bash Kdump: loaded Not tainted 5.12=
.0-rc6-default+ #169 00000080ffffffff0000000000000000
> 00000000
>=20
> It does not look like an unique ID. I have already reported this for
> v2. But you sent v3 just 8 hours later before I was able to provide
> more details.

Cool thanks! I'll look into it. Does kdump get the build ID properly
without these patches applied?
