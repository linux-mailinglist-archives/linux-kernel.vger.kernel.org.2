Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFC838CAEB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhEUQZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhEUQZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:25:52 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:24:29 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z1so18777911ils.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=s3TiO4SClJyDInCdOXMYVyRwBESE/9XdyYKBr/TBRzw=;
        b=xD9f/jwqLhWfHwiZxlTKH7cwVlWbuFa6PW7DSiogWZJeTgg3Wfvdvd++MQb0g3Ln74
         iQE98/GHLAw6wtdrzSFU8NpCdI3hoUT32o6aX2X7lDvo+p9S2OH1wZ5wsI0lktjNwemA
         op6jiStYDsM1u0XK68/0NHuL1WFB1Q5fCetT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=s3TiO4SClJyDInCdOXMYVyRwBESE/9XdyYKBr/TBRzw=;
        b=tkt3brP6NcT00IUoJvO5nh3itWU3d0GBFOr6RRZOsl1oI7Iev6ANXQNcg5G9BMXoJF
         CD3S/X4gG486//u2/QhAjkXG18E6TgaDzksfnsfQ0ep6RiIE8YuJhT+tlqqzCQVnpJ3c
         7Vd21xkexDqEEmmhp+Mb+0LEMm1hTJdUT+NLH5b9w/OTUfJ/fz4mTu2fmNIV6/qkAGDR
         lvRpymz6GsQzaEMimivnAUNVDeIIoH0mhshkFuFipDBsCAAuod5X6u4wpVc1MXPZ3xku
         F3bpLSlBPnfVqA7ib/JMyl/1gVsBNL2uBcsbMteW3AudfHS8NxBR8VRna+PKTGSjuBQ6
         NAxQ==
X-Gm-Message-State: AOAM532ZYSLjGRDYYZ0HC4fZa9NPLl4Z39nVbnemxolVRsVPuAn2KC2j
        QaZ5yhat7HVlpRAeQVd5JSBoSFbKUHX8GxikIP+nTw==
X-Google-Smtp-Source: ABdhPJwYWl9iDZt5RNQ+BQ3SUq1rsxOI4G0oVZhviIvZbj3YffXMXuSOg3ayJSV5/q+aLFyD5F2e1uzHjvQnzhtXnTk=
X-Received: by 2002:a92:c56a:: with SMTP id b10mr11327888ilj.17.1621614268707;
 Fri, 21 May 2021 09:24:28 -0700 (PDT)
MIME-Version: 1.0
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 21 May 2021 09:23:52 -0700
Message-ID: <CAMp4zn93WRF5u=et=detunN7exhQNoFctr-7Qb8-a9=As8vaQw@mail.gmail.com>
Subject: Preemption Signal Management
To:     Linux Containers <containers@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy pointed out that we need a mechanism to determine whether or
notifications are preempted. He suggested we use EPOLLPRI to indicate
whether or not notifications are preempted. My outstanding question is
whether or not we need to be able to get insight of what caused the
preemption, and to which notification.

In the past, Christian has suggested just background polling
notification IDs for validity, which is a fine mechanism to determine
that preemption has occurred. We could raise EPOLLPRI whenever a
notification has changed into the preempted state, but that would
require an O(n) operations across all outstanding notifications to
determine which one was preempted, and in addition, it doesn't give a
lot of information as to why the preemption occurred (fatal signal,
preemption?).

In order to try to break this into small parts, I suggest:
1. We make it so EPOLLPRI is raised (always) on preempted notifications
2. We allow the user to set a flag to "track" notifications. If they
specify this flag, they can then run a "stronger" ioctl -- let's say
SECCOMP_IOCTL_NOTIF_STATUS, which, if the flag was specified upon
receiving the notification will return the current state of the
notification and if a signal preempted it, it will always do that.

---
Alternatively (and this is my preference), we add another filter flag,
like SECCOMP_FILTER_FLAG_NOTIF_PREEMPT, which changes the behaviour
to:
1. Raise EPOLLPRI on preempted notifications
2. All preemption notifications must be cleared via
SECCOMP_IOCTL_NOTIF_RECV_STATUS.

Opinions?
