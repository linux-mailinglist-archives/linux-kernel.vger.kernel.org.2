Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E145B3B8934
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 21:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhF3ThN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 15:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhF3ThL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 15:37:11 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00C5C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 12:34:42 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id e1-20020a0568200601b029024ea261f0ccso668317oow.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/iOfKm8Iao2lnEDiXuVXkhdoDSAmPD02L6Go09Galk=;
        b=aRtt5v/XSPRRplkBM50G26ktqpLURc9s+fzFCYrEE/zIXSxiZ/MHA2CSUuzqkw/IqG
         zmnOWdCW4v/HIHJtlzXhNMUzCsnn8AuB8VwkHYvPCO9tkvrwwikwQCW9T2pa90auAkzy
         f/uHfzCRxovSMaZgRvgiLPLgwHpFC7VyOO6tZIVFLgezCqRy23wD9Fx+wCSD8r0wO3Yp
         yDUbl9Ms5UzKe2jTygNQgWr2prCo8g2r2AkK95ykAhfAMBdtNoM9dHFqzyYU2vAvmC4u
         YYNLEMX/7TA1WnrVh8WhrJrk3xM4eoPDZjQr3HNRMITGeTNKALwwY/x7aH5nima+WfzD
         VMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/iOfKm8Iao2lnEDiXuVXkhdoDSAmPD02L6Go09Galk=;
        b=ZuHtYV57qKoJbxoBspoCRlTI4zeWmTUE4ZEk34zPnV7nlV85Untl1c2uTzW+iDMXvl
         f+k+dvKzbc8CPzWCBQsj+23AmvmFTQlNH0ssPcneYJFVZehSu9DUNS9aHBK4+VAbinux
         e0xp3h34d5V/VocyuRADgA2ik1pToUXzwBKwuGKcCBQsW4VN6JJHMc1Kalt9HLl+C8qN
         rdpnI9QBq5oOq7ac675axHoPYBfwy/QQUUhOK7buTVCfnPUdapES78SAuM1QxPmp/pyy
         LzDZQ813CgvHYPfq2P1sGdnDGgpgk1KP/XF9m2Pxth8PNOL4GKK+x36CNJn7vOgf3jos
         EyjQ==
X-Gm-Message-State: AOAM531PsFvWiIYddNMp75FYffeUKj8Ml6NJ/FBDEDMif13zlWdquVeK
        14AHFmABH9FYB3MnbSzM0tGczd0TfssY12mFGJrfPg==
X-Google-Smtp-Source: ABdhPJxhJRxXgIwYjfIZ8HUyLFDhIoKbk0orSRffkmceyffNiCzjG4acjI3uHM1W/9tFIBPDRAZnKjB4jOR3k6nfCfo=
X-Received: by 2002:a4a:956f:: with SMTP id n44mr9708434ooi.54.1625081681837;
 Wed, 30 Jun 2021 12:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxxH9KVgJ7k0P5LX3fTSa4Pumcmu2NMC4P=TrGDVXE2ktQ@mail.gmail.com>
 <YNIaFnfnZPGVd1t3@codewreck.org> <CAJfuBxywD3QrsoGszMnVbF2RYcCF7r3h7sCOg6hK7K60E+4qKA@mail.gmail.com>
 <CAJfuBxw-JUpnENT9zNgTq2wdHqH-77pAjNuthoZYbtiCud4T=g@mail.gmail.com>
 <CAJfuBxxsye593-vWtXz5As0vBCYEMm_R9r+JL=YMuD6fg+QGNA@mail.gmail.com> <YNJQBc4dawzwMrhn@codewreck.org>
In-Reply-To: <YNJQBc4dawzwMrhn@codewreck.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 30 Jun 2021 21:34:30 +0200
Message-ID: <CANpmjNPyjTKd7tSPbQ6G75H3djHtWqipmVzNWguPU+mdnH3uag@mail.gmail.com>
Subject: Re: [V9fs-developer] KCSAN BUG report on p9_client_cb / p9_client_rpc
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     jim.cromie@gmail.com, kasan-dev@googlegroups.com,
        v9fs-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 at 23:03, Dominique Martinet <asmadeus@codewreck.org> wrote:

> jim.cromie@gmail.com wrote on Tue, Jun 22, 2021 at 02:55:19PM -0600:
> > heres a fuller report - Im seeing some new stuff here.

There are lots of known data races. A non-exhaustive list can be seen
here: https://syzkaller.appspot.com/upstream?manager=ci2-upstream-kcsan-gce

> Thanks, the one two should be the same as p9_client_cb / p9_client_rpc
> and p9_client_cb / p9_virtio_zc_request are very similar, and also the
> same to the first you had, so the patch didn't really work.
>
> I thought after sending it that it probably needs to be tag =
> READ_ONCE(req->tc.tag) instead of just assigning it... Would you mind
> trying that?
>
> > Im running in a vm, using virtme, which uses 9p to share host filesystems
> > since 1st report to you, Ive added --smp 2 to my testing, it seems to
> > have increased reporting
>
> I'm ashamed to say I've just never tried KCSAN... I can give it a try over
> the next few weeks* if that patch + READ_ONCE doesn't cut it

In case it helps, we have this LWN article series:
https://lwn.net/Articles/816850/

Paul McKenney also kindly wrote a summary of some parts of it:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt

There are some upcoming changes to KCSAN that can help filter some
data races that aren't too interesting today -- see linux-next and set
CONFIG_KCSAN_PERMISSIVE=y (the opposite of that is
CONFIG_KCSAN_STRICT=y, but not recommended at this time unless you're
writing complex concurrent code).

Thanks,
-- Marco
