Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252CA3FFB9B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348175AbhICINh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348162AbhICINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:13:35 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14847C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 01:12:36 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so5687887otk.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 01:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYFuqTMJDaSGzBqj0N8ZsJWA2n+2LB/4OzK3j+yo80g=;
        b=LqaKFr4ieNaDSx4/7sC84S3BWSh38y2bLT0amWlt7lK8+J69KJDQxTbooSrFLLWQy4
         WAeTVZ4KtWujiqwwmr6FIVx2pTJqTDLjDZ/xcS1qftQaajDYmUu6orVeyQ88hmiE8jEB
         R9+TFnqdIbzEn2vr7w0ftTmiVFThRsF0Et72yA63T9XWC7sQfoVc1R95VLQ8mdT1uhZf
         /rBH+GKiZOXvJC1slviIf/L15gZODZDSuyPDKbMzT/odJ0D+6hxMHJdA2tAM442wdInQ
         jWIU8QYVhuoy/JMgOlSQw6kd0h+NgRnI0bnDiPfi5G4omY7MTZ0xQRC+KQib8F18YPTD
         bWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYFuqTMJDaSGzBqj0N8ZsJWA2n+2LB/4OzK3j+yo80g=;
        b=T6o6XfcxnnlcprmS52HBGsPGEIxc4Di8N75ptiDxoavgGFIPKHS2wTwj/EEWkAILRo
         8AELuaZCrIXabl3fSSyoCOJwbSm2Z0J63gWEt1z05ja6Vky1u7lYOzv7658GAalqWGxY
         yfSHZT3Czaled9rz1ZcuAvqvNUHYiOdV0eJsLZT6i6piu04CIv9gZ74Nmd/yAJm8dp//
         nNXKOBfleHWALkdZxipRTGxq8dAhsLw4rgbKJYfvk/33H9RmzhbYw+OkTeaJBjodzV72
         dpDpIGu9lXhHPMGKyU4hCWZLDTV6MvjAkXoHbFFI4dZT87BhkJbDJ+zELYzsds+P67u6
         kCfA==
X-Gm-Message-State: AOAM533Y4NOMzCoGUAFJ5dMGVpu4kmrffT2wVhgW5T9xHeq9Ci0+e17B
        GR6qPD+MuEa/a9Tv3+G9AvIPmFI1bCRwilS0/MWHKw==
X-Google-Smtp-Source: ABdhPJx9DqYm52WI3nuvdfP+/HC3bQbC4EKQ8sIUiE08OVgMI6gi+Ed4TSmuiRXKV4YnyBPkSzwv1+FYRr2fp9+vUgU=
X-Received: by 2002:a05:6830:3114:: with SMTP id b20mr2073419ots.17.1630656755231;
 Fri, 03 Sep 2021 01:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000022749505cb06942c@google.com>
In-Reply-To: <00000000000022749505cb06942c@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 3 Sep 2021 10:12:24 +0200
Message-ID: <CANpmjNN8TOPdy-9w8Y432N9tm9Fn6E-SD9QxDp6Frh-uYefykA@mail.gmail.com>
Subject: Re: [syzbot] net-next build error (4)
To:     syzbot <syzbot+c61aaee16441c4fa206a@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, bp@alien8.de, davem@davemloft.net,
        hpa@zytor.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org,
        rafael.j.wysocki@intel.com, rppt@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: x86/setup: Explicitly include acpi.h

On Thu, 2 Sept 2021 at 19:33, syzbot
<syzbot+c61aaee16441c4fa206a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9e9fb7655ed5 Merge tag 'net-next-5.15' of git://git.kernel..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16e87c6d300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd61edfef9fa14b1
> dashboard link: https://syzkaller.appspot.com/bug?extid=c61aaee16441c4fa206a
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c61aaee16441c4fa206a@syzkaller.appspotmail.com
>
> arch/x86/kernel/setup.c:916:6: error: implicit declaration of function 'acpi_mps_check' [-Werror=implicit-function-declaration]
> arch/x86/kernel/setup.c:1110:2: error: implicit declaration of function 'acpi_table_upgrade' [-Werror=implicit-function-declaration]
> arch/x86/kernel/setup.c:1112:2: error: implicit declaration of function 'acpi_boot_table_init' [-Werror=implicit-function-declaration]
> arch/x86/kernel/setup.c:1120:2: error: implicit declaration of function 'early_acpi_boot_init'; did you mean 'early_cpu_init'? [-Werror=implicit-function-declaration]
> arch/x86/kernel/setup.c:1162:2: error: implicit declaration of function 'acpi_boot_init' [-Werror=implicit-function-declaration]
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000022749505cb06942c%40google.com.
