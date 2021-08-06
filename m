Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DCB3E2920
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245320AbhHFLKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245261AbhHFLKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:10:16 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F7C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 04:09:59 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a19so9453376qkg.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 04:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIl2Wt4oswfNZtiSwlBITJEKQL7QvhfH3PJWamUYOSI=;
        b=OVY18UKsp3ZcaGAI5dwG0qrVmMZNkMsAgISll8qraUlt25JxBNFISaCeVARYu+VrzU
         mI+hDNyd/qorLSPFP1nTqVGa4lbeemywWlrajl+fuxzGwdBrfupmjf6IieJOKlu2SX6Q
         Cg83tVIcV9kb2re3BTh3S7/M7v1oNUBCWexiowlW+vdMdILmZ0+tokToJ/RJJqZeQFB5
         lIqEkHOWIE1CvRFfdZkRpL+5fqO4mfuhbvNVWH8D5r4gblqx45t449zJXjPvId0Ze3Yp
         dOUSBzQIikBMNVvHEDN3zPb+GyUEzUxOvM0UqqAVSJ6daCRJb5XOQP649nO015Oj3Je3
         vJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIl2Wt4oswfNZtiSwlBITJEKQL7QvhfH3PJWamUYOSI=;
        b=KiU6ABK4+s7Vlvf7qQ8m9GsCIDdlLWi9AfoXJ3KoTCzPOWQaYPZwEG0zgZDRP6d2qG
         M0di3Bb+PJYHs5BEBunPQ0iCEzfQ8F1ta3zOZ8SiejgVLCsAP2y/qgTJ3y9ip6ltok2v
         7zZetyOIdN0Tf8kN8B4w3rO5OfQIUii/DszWz4IavlQfOfZYExQuzAuM5KzQK4OJl33V
         sSgTmqO/hiBGeZkTedzNwPD5+AarZamE0p1Z2YxmDz5WqL1O+fQB0/nnSf94SnHxhp2A
         B0BonieqxwghYdY2wqgwFf5o1SWpxAiLyUSnqt79+YAcWvG3mdSgrvY4AF4+9gumWmBZ
         OrjQ==
X-Gm-Message-State: AOAM532Mq7D/VU3EGe+hQ2qyj6BLpGZJmB6vG7cqprt6Po8ehYmReHsR
        kg2YjRfE9FH1W4vx8IPa+56eZqrzepPfhR8+9s/XlQ==
X-Google-Smtp-Source: ABdhPJwP2g6CP+w9oZrV1I9IIi/KjCS4sNSpPtONtJkbja3XMDl0uJSfrIBwajvCPf6WiPhtfjcLCph+O1yNQUyKQG0=
X-Received: by 2002:a05:620a:1428:: with SMTP id k8mr9571399qkj.231.1628248198923;
 Fri, 06 Aug 2021 04:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000295a6a05b65efe35@google.com> <00000000000029363505c748757d@google.com>
 <CAJfpegsyFb3bC=dqUbqhs9055TW95EJO2st7iS-4sPME7Y-cmA@mail.gmail.com>
 <CACT4Y+Zh9Bw8DTZyvoOB_hjXwRQuRN+VHmJ-HfMqOaOu7GyVXA@mail.gmail.com> <CAJfpegu2fR3cP+eR24a1+WBBR=hvz8p2cTfK0x4sNz5c-MMH3Q@mail.gmail.com>
In-Reply-To: <CAJfpegu2fR3cP+eR24a1+WBBR=hvz8p2cTfK0x4sNz5c-MMH3Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 6 Aug 2021 13:09:47 +0200
Message-ID: <CACT4Y+bh6TGBJAwR5UjoPkCLgiSUypUBWVVMcp9bVEWJbFrASA@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in fuse_simple_request
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot <syzkaller@googlegroups.com>,
        syzbot <syzbot+46fe899420456e014d6b@syzkaller.appspotmail.com>,
        areeba.ahmed@futuregulfpak.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 at 11:34, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > Hi,
> > >
> > > I'm not sure what to make of this report.
> > >
> > > Does syzbot try to kill all tasks before generating such a hung task report?
> > >
> > > Does it use the fuse specific /sys/fs/fuse/connections/*/abort to
> > > terminate stuck filesystems?
> >
> > Hi Miklos,
> >
> > Grepping the C reproducer for "/sys/fs/fuse/connections", it seems
> > that it tries to abort all connections.
>
> Hi  Dmitry,
>
> So this could indicate a bug in the abort code of fuse, or it could
> indicate that the test case DoS-es the system so that the abort code
> simply doesn't get the resources to execute.
>
> Can the two be differentiated somehow?

I think we need to take a closer look at what happens here. I've filed
https://github.com/google/syzkaller/issues/498#issuecomment-894185550
for this.
The overall idea is that DoS should not be possible by construction
with various sandboxing so that the system does not report what is not
a bug at all. But it's not always easy to achieve.
