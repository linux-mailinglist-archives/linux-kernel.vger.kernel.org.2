Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DD935E4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhDMRLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhDMRLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:11:44 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5750EC061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:11:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id m16so12648576qtx.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHNYLL/AP+nvXt8y93Dpx6n3WojKntO9M4nJQwVI9ko=;
        b=MFe8FAZa7F8uS3oz4b8eTkn3d5Z24Q7Nwtt6zblSCGquDnOpo5YuHBapOf2paZJNEr
         g2l8g2+FYCAy+AOe2GDCLOer5VKn8tPzf297omQkwO2OJBrBszcWjDCfy/XuDpHy7Sef
         8r1Ext8tYoFb1v51zGOljsQ2fRQvGRGQMPsUtd4MQ/bJIeN+GD/+4SIdu2Cc09KTpcwP
         +c3k/kEcwlDPcxs5gea1qiJmDsB3GQv1+iZPxdr9mO948jMyRGOuZ91MBUIvlILhRjkp
         7SMF1WMgAgylPG8lnFdEtuc36Fmruf4ckmjzPnT9tjDFn4eiv2WcsySE5NXe7Bn8OIl2
         sG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHNYLL/AP+nvXt8y93Dpx6n3WojKntO9M4nJQwVI9ko=;
        b=ETOGTvG92TbY2YFZ5KxF21CwHAarbw0yeW5Z7TO2MlzCVblXTXibbXDfySqSKVjYVI
         munWr2aUdv328YYrPMGVOYQY8iFbpzJqQbmkzCHJtrKVTJAxd3u9bGxS5A2NiQpiPSkO
         2gy3ngvQOqXMzIV8GZPH9tUgk7zhXr/lFrSsv5DdoW1zxawbNVghDaSw7zkMUZ0mGuBh
         9WLRMi4EhROhDw1k28D9Hms31zGDL4Y0apjGMNAWryET5lRu4xUjnnm7iI9JAbOnaC8v
         Mr0t6m5A9NsKwLTdqn3nAdVUBLC/0JW/fR+4IObKdE8yA8zPDC71wpu9TupSqCnBYTPD
         yDKg==
X-Gm-Message-State: AOAM531Vq68AP3JqAl4EojmLZPQhkxuVTWTjJFma0Skcrv8uFHXRvsdR
        vI8AuCSROWOxnK7vBK5g7mZn8dN0weymrp/WsmhTCg==
X-Google-Smtp-Source: ABdhPJwARlvDp0sQgoLf8NIWF3sgdl5kkgdDWdHOSjVTgnyvOWxFG26fGmWEoYwpbcifdV7j0tyoxLgN9kfoDr45n4Q=
X-Received: by 2002:ac8:768c:: with SMTP id g12mr15974368qtr.67.1618333882981;
 Tue, 13 Apr 2021 10:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000075c58405bfd6228c@google.com> <CACT4Y+bTjQz=RBXVNrVMQ9xPz5CzGNBE854fsb0ukS-2_wdi3Q@mail.gmail.com>
 <20210413161311.GC1454681@rowland.harvard.edu> <CACT4Y+YEw4iJPxY4b6LPXrU91TODfu09dG=53exvQkwjPBg23w@mail.gmail.com>
 <20210413165724.GD1454681@rowland.harvard.edu>
In-Reply-To: <20210413165724.GD1454681@rowland.harvard.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 19:11:11 +0200
Message-ID: <CACT4Y+aX-cMJxMYmWms3MG-4=Rb9eG_N+pOjorRHoV1MGQXtkA@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in gadget_setup
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 6:57 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, Apr 13, 2021 at 06:47:47PM +0200, Dmitry Vyukov wrote:
> > On Tue, Apr 13, 2021 at 6:13 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > Hopefully this patch will make the race a lot more likely to occur.  Is
> > > there any way to tell syzkaller to test it, despite the fact that
> > > syzkaller doesn't think it has a reproducer for this issue?
> >
> > If there is no reproducer the only way syzbot can test it is if it's
> > in linux-next under CONFIG_DEBUG_AID_FOR_SYZBOT:
> > http://bit.do/syzbot#no-custom-patches
>
> There _is_ a theoretical reproducer: the test that provoked syzkaller's
> original bug report.  But syzkaller doesn't realize that it is (or may
> be) a reproducer.
>
> It ought to be possible to ask syzkaller to run a particular test that
> it has done before, with a patch applied -- and without having to add
> anything to linux-next.

Yes, this is possible:
http://bit.do/syzbot#syzkaller-reproducers

The log of tests executed before the crash is available under the
"console output" link:
console output: https://syzkaller.appspot.com/x/log.txt?x=124adbf6d00000
And this log can be replayed using syz-execprog utility.
