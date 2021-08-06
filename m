Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE193E28A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbhHFKdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:33:25 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:55164 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbhHFKdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:33:24 -0400
Received: by mail-il1-f197.google.com with SMTP id o6-20020a056e020926b0290221b4e37e75so4323751ilt.21
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1nsTUtLl/XNEj2R0gdBgbLR1WT+4nRbfq0Z5jt4tfSk=;
        b=N/TscdKqfFxFb8138GHGMeOoO6aTZLjZ77uL5IoQFXN1vNMFZ2YJUd4wrhGJcYdxWx
         dSWU3b19FqeUcqmOhTflBkRz9kaQrIJN6M48ws6+gZL8r2KUONlNaccO3NVzStBTVFCM
         KZY9oC6wJ4JW2zWVqECxFMLcTEQtfSS+e6pkj2BP0u2a4MBfbnMHKJp/wrKuaPfYrPFW
         ZuTqQM9FIOXP7Q8VNTR7EMWmiRC8yFqF5IdPVhO+Bl+aT/zhQquGHqroMTJi+kpTd0u2
         yymjcDAF8rBrx9xSyoGCClzPnfbxXVlvh8YgAUipTEG1DH4Am3pWxntbKvk/P15HqXtl
         /61w==
X-Gm-Message-State: AOAM532BJDtfTJhq1Idd6Bsc7jPRA5qDdq0Jvn6XxFnuFVuXkB5YkAY6
        DMNAWeAZMKrAfoA89XF+R2frm/y9+/t94GBTDFfcoxdYkb26
X-Google-Smtp-Source: ABdhPJxYsmwtjg8JlsWjL6y+/14LVfgv7IjtjUAPQb8R8xh9IF1nYszq6JSuUVsEu1E2ClmpoxCvxHOxzXyQUw5M/RpqskPYU/b0
MIME-Version: 1.0
X-Received: by 2002:a6b:dc10:: with SMTP id s16mr433441ioc.61.1628245987926;
 Fri, 06 Aug 2021 03:33:07 -0700 (PDT)
Date:   Fri, 06 Aug 2021 03:33:07 -0700
In-Reply-To: <83e78e3f-2645-0c84-0255-da88e1b48466@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7a5cc05c8e18f5d@google.com>
Subject: Re: [syzbot] WARNING in io_ring_exit_work
From:   syzbot <syzbot+00e15cda746c5bc70e24@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, hdanton@sina.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+00e15cda746c5bc70e24@syzkaller.appspotmail.com

Tested on:

commit:         369fdcf5 io-wq: fix lack of acct->nr_workers < acct->m..
git tree:       git://git.kernel.dk/linux-block io_uring-5.14
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e83fda0fd4c345d
dashboard link: https://syzkaller.appspot.com/bug?extid=00e15cda746c5bc70e24
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
