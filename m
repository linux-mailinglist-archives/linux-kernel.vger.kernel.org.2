Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844A040A24C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbhINBFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:05:25 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:46769 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbhINBFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:05:24 -0400
Received: by mail-il1-f198.google.com with SMTP id o5-20020a92c685000000b0023832088b13so1226052ilg.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lkuAH26yQOlGfKXblDYiAOWW8Flrjdt2FI+BYcMEb54=;
        b=l76A2q8OIOXv8ugYtr87IWI9JmEUPXD/lhX3kpdPjP7q1ZRvh3qgLPXz8hqubjBu6N
         mLf7dKk3aiLuPw4IQb3bnTRwRkiiCnCZoxbcMWW16+omRcWDy35dmCz1VD+QPuNkkMvH
         0+mBYoWIsvg21hiC1RR+YfV3gsORruQC3CVyeiNu0KZB7vuSJC+oUfV9iHNRJr5EQLdx
         a2HJ35P9xYiGucwOABwSEoj5oG3x/50yphDYHWMphW3+llhEMBHD7bYrHABaDho3UP5O
         0jVWQebnbtFmSmjcl1tsBMH1+jMrrUtZqqZ37oUKHqNiimTjJJmG10B3NYW+Ec/qew0z
         7oAA==
X-Gm-Message-State: AOAM530UjqubpPqm47oGekvCA9pbLnfv8Sq9CsplgkZ1GHARWWD7fvdB
        CQxAa0wYe+VPDdjNQTmERxQd5saysL3Yh3uQP2OE5OZIHowe
X-Google-Smtp-Source: ABdhPJxnMCzs9SaZqkSRrEgYOeXV7AsHgsGgbPXcL7CkduBMcsrSHeR0/8S3Lqjt096iy0RNiUzERIAUlcC1IXMPzHhlgR3GG4T8
MIME-Version: 1.0
X-Received: by 2002:a6b:b88a:: with SMTP id i132mr11300524iof.215.1631581448021;
 Mon, 13 Sep 2021 18:04:08 -0700 (PDT)
Date:   Mon, 13 Sep 2021 18:04:08 -0700
In-Reply-To: <8428f733-ae95-f57b-8d42-6c7a279f4d84@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1b11505cbea28c2@google.com>
Subject: Re: [syzbot] general protection fault in io_uring_register
From:   syzbot <syzbot+337de45f13a4fd54d708@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        johalun0@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+337de45f13a4fd54d708@syzkaller.appspotmail.com

Tested on:

commit:         7981f41e io_uring: pin SQPOLL data before unlocking ri..
git tree:       git://git.kernel.dk/linux-block io_uring-5.15
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d93fe4341f98704
dashboard link: https://syzkaller.appspot.com/bug?extid=337de45f13a4fd54d708
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
