Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EDC41AA00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhI1Hon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhI1Hol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:44:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A224C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:43:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x7so64961286edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0qSqU2VYMss7j56Y4jsbCCUQTw+ja1sG8brSt524BQ=;
        b=ijFx2HOI6QZbU/PDKwKJCigNlhQj8QkAoR8XUVFuEYSURyUVqiERo04NY0LfrlEemg
         VcNy1UrJQWx0U/MpCOkdPWLGA2LTqCP3EFN26xf0D8M/d0c+W2eUSJqFZEmnQjp/uFab
         ONgH31E8xRoB1c2yExptNkzQfYr0wsxviDVwW6RqfGNizu8LcOnZp1GrVWzhDZhzm0BU
         eTw6PyfJIZixlHb+UIN7yL2exZS2wW0o3IaLyg4FA/UI1Kvk3AvMW/dZwF7LjUTXstHo
         kcBL7gAsdS1uxMsPJcKK2Sbqqr9RZSOg7xkI1wrnj8kkjDvn2jQU3trSrFvYaUu24A9+
         nmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0qSqU2VYMss7j56Y4jsbCCUQTw+ja1sG8brSt524BQ=;
        b=f3W9DkdUTQe6bQUQnOUSFEy2DzG2/bC+avV9F6fdUE+9rYDfdhOBOwgSiGqxwCnwLs
         HBrS0rAKeYGBKt9AGPuC0XiHC/oacleFIAKoWtks5A+Gtgls+C/OGV52p7KrhdZ+jQRt
         1wNYfvFZftTdjqXsGzfcSXVN9Jnxpp/Ln1M3/+liccbsVrsTrbogK0MIT1nLIo2c7vxC
         f2pkrfOaRrZrV2u1VmOJMfuzGo5LlqvQQzqCsXe1TXiimX5+SDbQHOlwSX4z0O8bsIc4
         uRjQpGoOLBrieqqGBEInU9dv8oAqpN42RAIGCMFYYd8An9O4Q0jk9nf/mNj+4oIbZmFX
         IUKQ==
X-Gm-Message-State: AOAM531koB+wNVFLQ+mDXYhSig/g1ozcMlJh8l7LqXDMrzp2Z1mfVcSd
        axb57kRVv2TQB1D9S+CXsOLDl9kgsfM45kWTWqE=
X-Google-Smtp-Source: ABdhPJx2LigFHJyjRvyOx3aJjoJ335xGD2dn/R+QJDHhP2f7G7MXLVLSbGF+bigY3MJjO2x099x66Mxnq5gTTDv7MvQ=
X-Received: by 2002:a17:906:af1a:: with SMTP id lx26mr5048309ejb.563.1632814981032;
 Tue, 28 Sep 2021 00:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <35d0ddc1-41cd-16fb-41ea-5529d19c04d2@gmail.com> <0000000000005252e105ccee8e1b@google.com>
In-Reply-To: <0000000000005252e105ccee8e1b@google.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 28 Sep 2021 15:42:34 +0800
Message-ID: <CAD-N9QUJWifqhNt09xDcu=w0K0o+wYUxpZyqkTs4q5eMp_kVgw@mail.gmail.com>
Subject: Re: [syzbot] memory leak in __mdiobus_register
To:     syzbot <syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>, rafael@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 7:44 AM syzbot
<syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-and-tested-by: syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         5816b3e6 Linux 5.15-rc3
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=41799858eb55f380
> dashboard link: https://syzkaller.appspot.com/bug?extid=398e7dc692ddbbb4cfec
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1147b840b00000
>
> Note: testing is done by a robot and is best-effort only.

Hi Pavel,

Confirm the patch you posted [1] is the real fix of this bug report.

I tested the patch from Yanfei Xu [2] in my local workspace, and the
memory leak is still triggered. In addition, I have pushed a patch
request for that patch. The result would prove that patch is not
working for this bug.

BTW, there occur incorrect fix commits on the syzbot dashboard
sometimes. Maybe it should be cleaned in the future.

[1] https://lkml.org/lkml/2021/9/27/289
[2] https://www.spinics.net/lists/kernel/msg4089781.html

>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000005252e105ccee8e1b%40google.com.
