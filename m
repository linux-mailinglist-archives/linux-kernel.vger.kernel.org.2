Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227C933256A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCIMXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:23:11 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:54820 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhCIMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:23:04 -0500
Received: by mail-io1-f70.google.com with SMTP id n15so9986860ioh.21
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 04:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=M/RPd9O6HlovCufiu46RnKolcjArBQRjys4GfdnCY9Y=;
        b=Ah/PqrBt7Om8kdSgaocsIJCM6uu+DCKyzdvE2Ef7tmzjvwtmVJsSpGPjzsCf4n8uNM
         AjJCwr482ESPvObJFDNA4IxFKNgl1Cy3DBhR/A+0isEKsx2+uL0u6aZSGwfbZBawyCjR
         cc1yY8rk2quiTitX9iNfBok9cz2HsS4fiL0n1RqrI/G3sxkxJTgzcjJ2eQgihX4rUpTw
         C1zvsf7vj0ZWg0NA2qcGbWwEXTqUhPyyqLIRxsQwD7dbVpTMsR4uGee/1IjRUBGMcpoH
         YDlbdT3u2w+Ibne0JAh9q8NV2P1veN24vPn1UQRUPBIWJExrMc4cO7oOLz7RiHdz8ehJ
         6RVw==
X-Gm-Message-State: AOAM532u5xbigmxknrYL6++llkYe0TJSYlDAQskBOkd/WM2yi+iR+uJQ
        c63blZ8UGpXuVj90JWFOxm7e0EgdgODGcs+Uw3UnMBI5xc5k
X-Google-Smtp-Source: ABdhPJyNbAfn3ELXKhDpYktoUJpXSgAh/3+Hi1LL95lbpxXNaGiAcRPJLwUHSCy+GbRzgi1MwgNPil0m+dAgNsZgI9LiYHTK9OvG
MIME-Version: 1.0
X-Received: by 2002:a02:a90f:: with SMTP id n15mr28656031jam.110.1615292583929;
 Tue, 09 Mar 2021 04:23:03 -0800 (PST)
Date:   Tue, 09 Mar 2021 04:23:03 -0800
In-Reply-To: <CACT4Y+bWYQu3h8pJaX4GS1JdJpPheE416TJH4=K5zOaseAH4Fg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac694305bd199c9c@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in usb_audio_disconnect
From:   syzbot <syzbot+@syzkaller.appspotmail.com>
To:     "'Dmitry Vyukov' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>
Cc:     alsa-devel@alsa-project.org, kai.heng.feng@canonical.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Mar 9, 2021 at 12:38 PM Takashi Iwai <tiwai@suse.de> wrote:
>>
>> On Tue, 09 Mar 2021 12:32:18 +0100,
>> syzbot wrote:
>> >
>> > Hello,
>> >
>> > syzbot found the following issue on:
>> >
>> > HEAD commit:    4641b323 Add linux-next specific files for 20210305
>> > git tree:       linux-next
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=103252ead00000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b87b6a083d302a90
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=ffad4c74b3b3ea3aa9c3
>> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1122d35cd00000
>> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f6476cd00000
>> >
>> > The issue was bisected to:
>> >
>> > commit 9799110825dba087c2bdce886977cf84dada2005
>> > Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> > Date:   Thu Mar 4 04:34:16 2021 +0000
>> >
>> >     ALSA: usb-audio: Disable USB autosuspend properly in setup_disable_autosuspend()
>> >
>> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166d91ead00000
>> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=156d91ead00000
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=116d91ead00000
>> >
>> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> > Reported-by: syzbot+ffad4c74b3b3ea3aa9c3@syzkaller.appspotmail.com
>> > Fixes: 9799110825db ("ALSA: usb-audio: Disable USB autosuspend properly in setup_disable_autosuspend()")
>> >
>> > usb 1-1: USB disconnect, device number 2
>> > ==================================================================
>> > BUG: KASAN: use-after-free in usb_audio_disconnect+0x750/0x800 sound/usb/card.c:918
>>
>> This must be fixed by the commit that was already merged to sound.git
>> tree today:
>> c5aa956eaeb0 ("ALSA: usb-audio: fix use after free in usb_audio_disconnect")
>
>
> #syz fix: ALSA: usb-audio: fix use after free in usb_audio_disconnect

I see the command but can't find the corresponding bug.
Please resend the email to syzbot+HASH@syzkaller.appspotmail.com address
that is the sender of the bug report (also present in the Reported-by tag).

>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CACT4Y%2BbWYQu3h8pJaX4GS1JdJpPheE416TJH4%3DK5zOaseAH4Fg%40mail.gmail.com.
