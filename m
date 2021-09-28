Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93BF41B320
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbhI1Pmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241080AbhI1Pmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:42:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E16C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:40:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v10so80769753edj.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5Xay87n/QyLfotSPr1LQisyjv+dzD7GSD9ECz4iYBA=;
        b=hxHeWzeGcxiwcpHRnzvDoh0BgAH+u/n8tFAOU1yTUlK2GeS5gtml39JCJEQxemZoyk
         HlkZJdd+4LgGJsC7cic4RNnAL9e3IvotliGcyTYey1IyNU8OgtJKQxmwd8Ku+IMdx+iH
         LPMp624WOgq+xtTNfv1EKaUgzsy+tg34C2y9VfGOK9Es9j0P52U1o7BgdI87tVinB7FB
         h8o8DJ8xrJztrqCnahjGV4kqvlAcKo+uVkxhhZ0GtUc0CfWKlicSUsrm/sndGo8f17AE
         sVG2QHTf5Ozbaa8dLdEdJs7iGaMhDeNwTS74ryIk4zzxmn9g5FKexZusEDMYeUuXZ1ef
         G/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5Xay87n/QyLfotSPr1LQisyjv+dzD7GSD9ECz4iYBA=;
        b=rbXEc9wKPChcjNGiCaH1RedlLuYLo3GJMt7m7CUzaiHUSjbIZa1spZeXzC4rg38sTr
         ZcVFwFohvQWbxHG8kPdhRQ/lOgSMZ6+ANCFGq3x1RrHLXr/c7gJzRlCB6DfwQAz64XMT
         /21D/f1rr0Z2JNHf4wYh1MTD9btIG30VQddpyQanVNuSzTnvjzU2YgbE540svACyk5n4
         szsOkxPyATP60853B4JXHuE3q4mqfZTBNhUWstJaeXQzNfAXgkufoYMVRPPbCKOyXaJb
         n5gOS/waqMIvVhc0Y6SbdLvGzAlL8GflCykOk00LcWLq+vufgDlUAkmZpC9a6w7y6Hy4
         iMPg==
X-Gm-Message-State: AOAM531o69vJ6tLOjvc5yWyT61MFZKnno5lERaYrC9AhKwD1teLQkwCT
        VxqL8zTDIsTAGzU1QSyk0EoWwNE90dfP5PArWLY=
X-Google-Smtp-Source: ABdhPJy6hq0n8r/mT3RIgVAGg34y1V6mj2gKAxEILfuKRuh1ALaipiYo4by6+pi/1OaFpvOOXYxWVVCPUQRxqPBTX64=
X-Received: by 2002:a50:e006:: with SMTP id e6mr8093970edl.302.1632843621608;
 Tue, 28 Sep 2021 08:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <35d0ddc1-41cd-16fb-41ea-5529d19c04d2@gmail.com>
 <0000000000005252e105ccee8e1b@google.com> <CAD-N9QUJWifqhNt09xDcu=w0K0o+wYUxpZyqkTs4q5eMp_kVgw@mail.gmail.com>
 <cfec2c6f-34a9-d95e-5f07-c69e74b06450@gmail.com>
In-Reply-To: <cfec2c6f-34a9-d95e-5f07-c69e74b06450@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 28 Sep 2021 23:39:55 +0800
Message-ID: <CAD-N9QXBPjURa5hRU3NNYzps-QSEDp4dPQYCcZN=k6T_crrShw@mail.gmail.com>
Subject: Re: [syzbot] memory leak in __mdiobus_register
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     syzbot <syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, rafael@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 4:15 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> On 9/28/21 10:42, Dongliang Mu wrote:
> > On Mon, Sep 27, 2021 at 7:44 AM syzbot
> > <syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> >>
> >> Reported-and-tested-by: syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com
> >>
> >> Tested on:
> >>
> >> commit:         5816b3e6 Linux 5.15-rc3
> >> git tree:       upstream
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=41799858eb55f380
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=398e7dc692ddbbb4cfec
> >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1147b840b00000
> >>
> >> Note: testing is done by a robot and is best-effort only.
> >
> > Hi Pavel,
> >
> > Confirm the patch you posted [1] is the real fix of this bug report.
> >
> > I tested the patch from Yanfei Xu [2] in my local workspace, and the
> > memory leak is still triggered. In addition, I have pushed a patch
> > request for that patch. The result would prove that patch is not
> > working for this bug.
> >
> > BTW, there occur incorrect fix commits on the syzbot dashboard
> > sometimes. Maybe it should be cleaned in the future.
> >
>
>
> Hi, Dongliang,
>
> thank you for confirmation. As I said in reply to [1] Yanfei's patch is
> also correct, but it solves other memory leak in same function.
>

It's fine as I was debugging this case locally.

> AFAIU, if my patch will be applied too there will be 2 fix patches on
> syzkaller bug report page, so no need to remove Yanfei's patch from bug
> report page :)

I don't understand why Dan in other threads said Yanfei's patch is
also working in the bug report. The patch testing request already
shows the same memory leak still triggers. Really confused.

>
>
> > [1] https://lkml.org/lkml/2021/9/27/289
> > [2] https://www.spinics.net/lists/kernel/msg4089781.html
> >
>
>
> With regards,
> Pavel Skripkin
