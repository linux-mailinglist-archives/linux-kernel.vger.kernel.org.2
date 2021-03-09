Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EAA332569
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhCIMXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCIMXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:23:03 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C5FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 04:23:03 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id o1so9971038qta.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 04:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaluU7+laoFdMSiGRBWBubnNaFQ2+/bheB0XmnEpIQE=;
        b=OLFv3V6CAG8by+JMnfVRckkvkcAz28M62/0ZaQ6aULLqQG7AHZL/XPixSN0tTJM+/Z
         2TUCOW0gEDToBb7hIWk9r6qyoneNkot3tt8fG9M7hGZpN4JmTNVJ6YOATpKUw3DLEPVc
         mtcxKAer/EPhqeLJWBgr/bBQ9AZWFo/sKk3etYhgYLG7Pk5Nh56Qimmwfey+fuOrEfVd
         qA8rmSTiwDrplWq0fIzTTEYHGWRvU84GWQ45BcG+hnF5dnHSleffx9YdW+7ujgwN/PuH
         h4zlHn4GowuBSUAMULQOFW74LK0FKcIhBnWyIuW663VkdB0Fg+GGqiw4Zo3QUewYbOah
         kbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaluU7+laoFdMSiGRBWBubnNaFQ2+/bheB0XmnEpIQE=;
        b=gCheF4Rx3OeNn4N70IA70YiV7k2mJ0g9/ApoUYMI1rLcXvEwXesNzO95O8YcPS5ZV9
         cILmNzeN3oiyl9kkkD22+avwljhLlT2mJfKpHwUsxv6rfDF6dAwWyvZszmj/I2naqbSR
         yDX03zi29h7nPO8z5KQ5FAAUFMAhJmaqfVOfdr06t6RJ9uJTcH2br/jrqURx3Tww58Od
         kEh5u0BaIyOwYBRa6LuUHWTetwlETcoHNEQxRvh14Y6zdRNmYVuYKRynNq7YJfzsSvIV
         uEeOEoFfn0r8B9fdMbplppRRvCfbq2C66kZ4J+QZtTd5Pk5SfYeHIDr8ArURSGx/z6Xf
         V1mA==
X-Gm-Message-State: AOAM532dt8eqdKEmq1DsS6Evc0t/FzSaCRcwE5IIJ0w22Ai6L9Vlu7gG
        vUeJhuIsDaajEGxadxECPJkcVa86c6NvpGMC/12dVA==
X-Google-Smtp-Source: ABdhPJzmCfVC17pIjfZ+Ylf4jNQ4ubkjeGaI7xNlJT7//0VcLhKn1VKZ81xMeGpysCFzfG9otBPceL+QqaCD4ka5aZg=
X-Received: by 2002:ac8:5908:: with SMTP id 8mr24749802qty.66.1615292581938;
 Tue, 09 Mar 2021 04:23:01 -0800 (PST)
MIME-Version: 1.0
References: <000000000000217e4d05bd18e750@google.com> <s5him601rr3.wl-tiwai@suse.de>
In-Reply-To: <s5him601rr3.wl-tiwai@suse.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 9 Mar 2021 13:22:50 +0100
Message-ID: <CACT4Y+bWYQu3h8pJaX4GS1JdJpPheE416TJH4=K5zOaseAH4Fg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in usb_audio_disconnect
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 12:38 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 09 Mar 2021 12:32:18 +0100,
> syzbot wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    4641b323 Add linux-next specific files for 20210305
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=103252ead00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b87b6a083d302a90
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ffad4c74b3b3ea3aa9c3
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1122d35cd00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f6476cd00000
> >
> > The issue was bisected to:
> >
> > commit 9799110825dba087c2bdce886977cf84dada2005
> > Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Date:   Thu Mar 4 04:34:16 2021 +0000
> >
> >     ALSA: usb-audio: Disable USB autosuspend properly in setup_disable_autosuspend()
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166d91ead00000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=156d91ead00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=116d91ead00000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ffad4c74b3b3ea3aa9c3@syzkaller.appspotmail.com
> > Fixes: 9799110825db ("ALSA: usb-audio: Disable USB autosuspend properly in setup_disable_autosuspend()")
> >
> > usb 1-1: USB disconnect, device number 2
> > ==================================================================
> > BUG: KASAN: use-after-free in usb_audio_disconnect+0x750/0x800 sound/usb/card.c:918
>
> This must be fixed by the commit that was already merged to sound.git
> tree today:
> c5aa956eaeb0 ("ALSA: usb-audio: fix use after free in usb_audio_disconnect")


#syz fix: ALSA: usb-audio: fix use after free in usb_audio_disconnect
