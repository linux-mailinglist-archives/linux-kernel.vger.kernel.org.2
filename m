Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF8F363C40
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbhDSHMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbhDSHMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:12:07 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A8C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:11:34 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e13so25025768qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lk+lA1HPdnMubgiG5us3Qj7XzykDt7oRNiJyhFPqYfs=;
        b=D/RG/oWITDCQM85b48ZIcby46IPOecD17d0HbaFcHE3seiL8L4KTtHTtZ7lrZaOixj
         +ys6M801gJ5IiDB7zYKz15g6xUy+p15Ax9FfkQHaseVXYF73cTUsNEnN7rHyCeTs9A4a
         AKJS7eB9tcOhu8+h4kPN6CUjs74wUmGAokEk2eTvrRL17l1iIHxhg6CFpc3tnAF5uYvK
         9oR3uqJqK8z0CL8bZhxMFDMu++PnGTPLchN5WXqh/WfL5EAKF9BdCYuvq6V9lU4bM+f0
         XCKY1bCUuqAGthFJnSKfPNciIiegbuPyRSwHDzt/7w9+JQJc6hY+OM2ZNrj8QbfUCOsU
         Imdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lk+lA1HPdnMubgiG5us3Qj7XzykDt7oRNiJyhFPqYfs=;
        b=obanzOPzNwimZ/g4A+5HAVL+VSnWoL1LxMIPePPFZCnAZQ67FXd5Y61aLDD8wRSOgs
         E8242MFJ0QONP49OluP6QC0jQmvLvdZqmKz3cbibC6/q+DewdQ2FW58uP8+sGcvf88RF
         SeOBKjV4S4KhhXE95/baSeflC6qiijpKZn6SomRwWFBMFb3ebaQlVjHpqAUx/luZNbWU
         d/lA1ftrHtyemm8wK09eXBKzcnUqW0Ct0lnsYw/il4mmvAGArCMXoytNGRSlVZ2VhYvn
         u+DBIu9aCX70oS5WzNsKHuepFX0FGaUexEErhqLLq4nMWhTEAFMoHm6PoRrzApnMtLhE
         uB6w==
X-Gm-Message-State: AOAM532XzAH9+xHRDAhgk/sRkOzh1IcYGED0HmLEWtj3XLhcypiXqmDK
        otMP+g9VGFB+X/5JxT0piU8JKjgbgQpILvsfiYwjng==
X-Google-Smtp-Source: ABdhPJxNmMNo+HC3yaN9zeBpbjPKjYMuNnT0TeVqhuEk12+HcP+3xqO8Ae/0ziXZUespq+Kghgo+18dm2FfuW00fDUg=
X-Received: by 2002:a37:4042:: with SMTP id n63mr10216843qka.501.1618816293153;
 Mon, 19 Apr 2021 00:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000082554705ba5fe454@google.com> <000000000000d91f7905c028bbf4@google.com>
In-Reply-To: <000000000000d91f7905c028bbf4@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 19 Apr 2021 09:11:22 +0200
Message-ID: <CACT4Y+YYphSF5ygTNDdBWpGZaNgEtRCquj-XSTRqWn3va_LOYg@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in usb_remote_wakeup (2)
To:     syzbot <syzbot+85439002c78b774488d8@syzkaller.appspotmail.com>
Cc:     erosca@de.adit-jv.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        zakia@firesystem.co.nz
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 12:41 PM syzbot
<syzbot+85439002c78b774488d8@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 363eaa3a450abb4e63bd6e3ad79d1f7a0f717814
> Author: Shuah Khan <skhan@linuxfoundation.org>
> Date:   Tue Mar 30 01:36:51 2021 +0000
>
>     usbip: synchronize event handler with sysfs code paths
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c89e91d00000
> start commit:   bec4c296 Merge tag 'ecryptfs-5.11-rc6-setxattr-fix' of git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9408d1770a50819c
> dashboard link: https://syzkaller.appspot.com/bug?extid=85439002c78b774488d8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138d0264d00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: usbip: synchronize event handler with sysfs code paths
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:
#syz fix: usbip: synchronize event handler with sysfs code paths
