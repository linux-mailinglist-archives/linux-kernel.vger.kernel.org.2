Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B68D3FFBA0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348190AbhICIPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348177AbhICIPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:15:47 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4653FC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 01:14:48 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso5727108ota.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uUWdhYM5DsWR8yzVOZBpySwPmRDi+irTyHSxQBi1Jc=;
        b=W1MyPOyB1j98UnxjNvMa6STDSgGBvBfkTEqrTbrvVwkvPsQ4oHRiNxiFoDibRe3inu
         XkeYhi+Q5o4bRFj1uZzljoyuhLWPURp9xS6gURGoSSEcBSzc/CkuoVXgDGiM3SW3M5y4
         YYuAeGyAFYywBfeFuSRQ29h2xue9VRJurnJJAakeaTxrArIst9biNix/sgEFoC9U47y0
         pyvzWCX+v7pnDvqyDjdhkBOZUXrlSXFP4sYkM+2OvNFaBpaMtMErYUP0hOtyuAIu8f5R
         BN+uU9tkPRyYwziA2ougXolIUczQB8tLd4sw+fg28FMOL9IDBFYb+ggp1CFYBfNLDT//
         cjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uUWdhYM5DsWR8yzVOZBpySwPmRDi+irTyHSxQBi1Jc=;
        b=jXGIkQVwHvZlZdr3N9CIraG3BG+F9WnLgEauhgae/w3HwJrtP+Fw8mA7i7NCRIxAlm
         1IMQ5rQWPTwDDM0+zcF+KG4kW2+u9+hE2QPabDdSEXTFRrVYUJIFeP5eenVUPRfzP8uh
         JBtLyqw5YyDJ7UQRDDwEls7BGegBje9YbRFRrzt/zNbXpxmVeTSCeuKKAYPxvV3OpnaO
         glGZOP2kytKdUb8mKhZA7u2y6ofSyupPdzJhTEGTP+NERwt/W8gv9k4ptXc88HkIaUYy
         W++QZAqtnlskYzLXA7EuW6GvG1rZ55qDB2EaOgUYQGxqM9AYlciSfh3QT3xwYfnNogef
         ObBg==
X-Gm-Message-State: AOAM532a1pMd8NrcrP3IYwWyxoVi1VVN/ClyUqAJl4aRIgo24piRyI7I
        yvH0FUsP6jQAClr5BF4l9hQX5111Y2AJ+Cq8CjEJxg==
X-Google-Smtp-Source: ABdhPJxOHa43+/4XgM8xkdIAhtvrj5Uw+u2abRaPJ16HEWRDINduJ5ovsIgediP01+/Lf4fMVKPFUM5C1qH6FQoxWy0=
X-Received: by 2002:a9d:4104:: with SMTP id o4mr2200950ote.251.1630656887458;
 Fri, 03 Sep 2021 01:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cdb6a905cb069738@google.com>
In-Reply-To: <000000000000cdb6a905cb069738@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 3 Sep 2021 10:14:36 +0200
Message-ID: <CANpmjNP2JEyFO_d9Dxkw5h6WQL70AhDsxkyoFTizvo+n3Ct3Tg@mail.gmail.com>
Subject: Re: [syzbot] net build error (3)
To:     syzbot <syzbot+8322c0f0976fafa0ae88@syzkaller.appspotmail.com>
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

On Thu, 2 Sept 2021 at 19:34, syzbot
<syzbot+8322c0f0976fafa0ae88@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d12e1c464988 net: dsa: b53: Set correct number of ports in..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=125c2886300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd61edfef9fa14b1
> dashboard link: https://syzkaller.appspot.com/bug?extid=8322c0f0976fafa0ae88
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8322c0f0976fafa0ae88@syzkaller.appspotmail.com
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000cdb6a905cb069738%40google.com.
