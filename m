Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255933204BA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhBTJdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhBTJdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:33:13 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F2CC061786
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 01:32:33 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id u8so8212319ior.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 01:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aU6EkxCmwm7ZBRSmBHpzJ3NMym8iTR9+L0yAeuHl2no=;
        b=JKdp44i6/7tt87YblVoGu5BePf6hR8nDWAOdFU858sv4zx8DCezAdMEhOkLkRdwR0Z
         aRnbX2auMDWY1leI9eHXymj55Kc/0zIJeLIFD0OTphIlB7fVgYBom5qZYqnSH8KdkKf3
         5d2QXWOS01+YxTcMfEz+3rXETLNPHvyIPp39g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aU6EkxCmwm7ZBRSmBHpzJ3NMym8iTR9+L0yAeuHl2no=;
        b=ji71n1aLp+IlMVYiYRGQTDk8W8uJkD+ItYuoQocK9iHwlasNe8Ca/KHmGvNCbPtYyV
         ZGjf9yjuJo60KH3x9sJao+O6eXfXFHR8oTWXlZOnjWIAI8wKX+EFDTGPLECkWnDMqEAO
         XjKz4x2P2SC9FR71v64XR8ZubXwkMZHn8gwDV8alMoEk822KGGk+WP/1CmoLnj7xVXqU
         /0uFokeu44TprBy7KU9mOcuEKqaD4JGg7UFGvZ4ERLhBnhzEQs97B7HulEW3EKP8CXt5
         rw4gVGEQei4e4BNxKnpYwLvql28IIk1rdKXoKwPbnUZPTLZFZuYUD9exBwZDnuQOLoaI
         /w9w==
X-Gm-Message-State: AOAM530wjCuPZByP7nH6HFDQSS+XUNdiBNdOvxsJ6ccGMd3PSn3jzuwf
        qP2mZT1Qh2wB1T+58it83ALkkM+bxg5a6agnfG3CM5qDOYL2Gw==
X-Google-Smtp-Source: ABdhPJy9+8rFJRyqb13qpXN/WGIXGRMB+TI4QoPX4sEJyIu3pwNk0TzxUxWso0+gt/5AMbiV2W47tZ+iUUVpFZjnxhg=
X-Received: by 2002:a5d:8719:: with SMTP id u25mr7657714iom.103.1613813552699;
 Sat, 20 Feb 2021 01:32:32 -0800 (PST)
MIME-Version: 1.0
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sat, 20 Feb 2021 01:31:57 -0800
Message-ID: <CAMp4zn9oEb6bJJLQWjSE1AFg6TqwkF3FOvFk2VSkKd+0Kj7TCg@mail.gmail.com>
Subject: seccomp: Delay filter activation
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Hariharan Ananthakrishnan <hari@netflix.com>,
        Keerti Lakshminarayan <keerti@netflix.com>,
        Kyle Anderson <kylea@netflix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've run into a problem where attaching a filter can be quite messy
business because the filter itself intercepts sendmsg, and other
syscalls related to exfiltrating the listener FD. I believe that this
problem set has been brought up before, and although there are
"simpler" methods of exfiltrating the listener, like clone3 or
pidfd_getfd, but these are still less than ideal.

One of the ideas that's been talked about (I want to say back at LSS
NA) is the idea of "delayed activation". I was thinking that it might
be nice to have a mechanism to do delayed attach, either activated on
execve / fork, or an ioctl on the listenerfd to activate the filter
and have a flag like SECCOMP_FILTER_FLAG_NEW_LISTENER_INACTIVE, which
indicates that the listener should be setup, but not enforcing, and
another ioctl to activate it.

The later approach is preferred due to simplicity, but I can see a
situation where you could accidentally get into a state where the
filter is not being enforced. Additionally, this may have unforeseen
implications with CRIU.

I'm curious whether this is a problem others share, and whether any of
the aforementioned approaches seem reasonable.

-Thanks,
Sargun
