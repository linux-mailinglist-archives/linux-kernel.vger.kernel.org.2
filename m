Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6C343C2FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 08:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbhJ0G37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 02:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ0G36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:29:58 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B374C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:27:33 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso2208048otl.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5MA0nKaJS7rcKDOA11AogxOix+nFaUOE1ImuxJcYDA=;
        b=dhBwKbOwAYMYUz8ceeSMwYnJ2lR/PGywrlD85bksuK1tiAvOCsz5t7EUX3S55FZL7S
         NXmERTWq28ZYUbGMQgpqMWmYOmpdBwB6RCyFKRzxoe8kUGfcPzOABUiFKPQabVVoJS82
         bDPe9hX/D2BrGGon2yVji4Sw4lObhibBHcOzmgwScrLLMloNkUC1XqgvyAD7UuHbIGNV
         UZBeunMcN8aNQRTbfFgkAC0BMZ92ZesLNIt2zRy32nhHA+11LmajHRjqgrMjE/Avtynj
         /xcsEJV7uL/jozYEJRXrPVgHFNYCR3G9FPcYjqJVM9FtaekepPuofAeYuESJUq5ztK+S
         MA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5MA0nKaJS7rcKDOA11AogxOix+nFaUOE1ImuxJcYDA=;
        b=pW3JY2J5YBP/Y2+2rDqJYWtHg1OWzAIb8N1FNTx/BM/z9sxNvXbmFnZBXTi+BNLUvI
         4UFICcrxJ6PdJuO78K4suqHMX74c4P/8xezYLAo9jO510sBEICiSBg2n/mCFvVXYeqRZ
         MUnyspwkjyRup2vzPaRjvwGItxmwEBFJ2ARQF/4NjKahKdgk/Mr/C4azl0nmCpf6udo3
         YvGNkOHpq8heABbRTPRh+iOUGVjQvYx5rShdEYTD9KBHJDOV58Ae/i7CJYS55WnIiznX
         2lfkfmnpj1eD8WRW37Ag+7ct4Wg+0uFN9tOP/3epS8Z2qAyksFKW+YOmhyqZwch/UkFv
         /fNw==
X-Gm-Message-State: AOAM533d3sMxnI0xV4Gjam/hymOT4rta3Ah7tPPALEa8CARMYEEZUDKL
        J+FFlaiyiz0gfckJ1cjIRmMz62dC0r3R1CjEQne+pg==
X-Google-Smtp-Source: ABdhPJy2xK1uraUN/Ksh8TjZCc0phOz1L3tGsEYpRQ7MnWJpQbgphMlWiHyYTyBBsJeRe1zFo7HaIOtHHY2HTKDnUGw=
X-Received: by 2002:a05:6830:1acc:: with SMTP id r12mr3925895otc.196.1635316052608;
 Tue, 26 Oct 2021 23:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c87fc005cef26865@google.com> <ade6c05e-fe82-c61a-bf02-8c8fcd918a75@suse.com>
In-Reply-To: <ade6c05e-fe82-c61a-bf02-8c8fcd918a75@suse.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Oct 2021 08:27:21 +0200
Message-ID: <CACT4Y+ZQOrbeT5_Z+DnUskQkX94ztc+bQ0O=SYa1LgV0mswBAg@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in sisusb_open
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+fd9d03311cdce9a9ec36@syzkaller.appspotmail.com>,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, thomas@winischhofer.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 at 16:40, 'Oliver Neukum' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
>
> On 22.10.21 17:10, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    2f111a6fd5b5 Merge tag 'ceph-for-5.15-rc7' of git://github..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15a3aaf0b00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=61f4d9af07d3bbdf
> > dashboard link: https://syzkaller.appspot.com/bug?extid=fd9d03311cdce9a9ec36
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d4e9fcb00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1444ada4b00000
>
> Hi,
>
> do I understand the reproducer correctly in that it just creates a
> device and then
> does nothing?

Hi Oliver,

Yes, it looks like it connects some device and executes some handshake
sequence and then does nothing beyond that.
