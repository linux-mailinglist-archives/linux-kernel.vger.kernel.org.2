Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356C9382AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbhEQLYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbhEQLYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:24:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C92CC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:23:07 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c20so5302388qkm.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGXyzC3xCgpRlUaTw4nhuXE8ujIwP8PHRI02BxbUIzk=;
        b=hHnlguesEZvTDV6FOr8biYKXwcmYfPCRrejdnY94HsmRi2/jQTnWUY4HKqmrXf8ozA
         TTjZe/epTZyVJHXPeLl1mpSV0TzB0gxtGp15c8cP8u5caTgj/Z0BDwryv9yU0JgYt/Zi
         VeQZh9Pe4j3DdVPKJAxyHIfONc95kupj3AR2ygeJOk9Py5pZgm3CsfGPq8ODhYpYx6zg
         xMtgAJdMG9IpQr6T/a3G3/GbIfbVnKu6F3qIm6a5xoacOiNBOc9jZW1rar6TCl1wWe8n
         HHRMZYs2AoqT8MOgUGqpdetz8TRZWgNqOVFuGdOTVRHqsx5iyug639wN4Hm2Dy7zHkg+
         rIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGXyzC3xCgpRlUaTw4nhuXE8ujIwP8PHRI02BxbUIzk=;
        b=mic1xFWc85stPKKDWViIRpuxzUYMGaEzYJbTbXue3G7410gG3PzDCNNOh6KrGplWKf
         m8pR3r7vfLNkwEqyDiwCh0VlH8R8DHxhMPtZEH3uI5Q6JX592wfZQ1+27rvOghoFi2K2
         8ujkHzDZ+AGDWAeUKdBj7IBmEt1EqbiudTnLcCBb0TCbs8vvY+Vy1sOOzVG7za357Z3j
         S9891aGFFqNapT45x0OMW07F2nBIbln6Wxzrd6Z1o/SxTzqiwhTbxD684zKF7j0pLKca
         1r5Hdom36nVKf1OO0ydM3PW1w8PdAsMBe0/BhoLy2XvmDX7oixrfWnLsIQrNGVZxuS2C
         r5RA==
X-Gm-Message-State: AOAM530/CBxknR/XhCY09iC0kBMJtLXSHTBUVyBUhijqMilZNOGHzqHl
        TPzmW6INjZo1iRtQorwfYHgmKM7fRhTzHjGhp01u2w==
X-Google-Smtp-Source: ABdhPJwgPIEbKldHHF9kAFjl5ptOQnByTRSDuEzK1mg0bz7f2HWmxIgJRgFHN3bsULOZlBTHNecgUD8eHFY2e+kgTlU=
X-Received: by 2002:a37:c20a:: with SMTP id i10mr56682524qkm.350.1621250585598;
 Mon, 17 May 2021 04:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000005887605c284c0c9@google.com>
In-Reply-To: <00000000000005887605c284c0c9@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 May 2021 13:22:54 +0200
Message-ID: <CACT4Y+YUYhGr9yTmW4ZHYp_Wa6sEoTTwtAD2JSS4kfc-0fcnjA@mail.gmail.com>
Subject: Re: [syzbot] net-next boot error: can't ssh into the instance (4)
To:     syzbot <syzbot+f9386e897a8781058604@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 1:18 PM syzbot
<syzbot+f9386e897a8781058604@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    392c36e5 Merge branch 'ehtool-fec-stats'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a7cbf9d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a90b0da0842a411c
> dashboard link: https://syzkaller.appspot.com/bug?extid=f9386e897a8781058604
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f9386e897a8781058604@syzkaller.appspotmail.com


Not sure if this was a flake or not:

[  109.072545][    T1] systemd[1]: Timed out waiting for device
dev-ttyS0.device.
 [K[ [0;1;31m TIME  [0m] Timed out waiting for device dev-ttyS0.device.
[  109.118547][    T1] systemd[1]: Dependency failed for Serial Getty on ttyS0.

but this is very old.

#syz invalid
