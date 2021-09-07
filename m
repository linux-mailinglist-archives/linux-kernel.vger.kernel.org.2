Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E835E402EF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbhIGTbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhIGTbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:31:20 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B8DC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:30:13 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id j12so282116ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfOuA3V/bhaGSLfM+8kkyDGmwsdYvlTYteI9hO4FV+Y=;
        b=qxGrqhtkxJ3P9PF1/eOoax3YESGQ2FMvH5ftKPw4tEjWfKTEt8xD0Umy+i4lcOnC3F
         Nk3jx0Yl1bIJ3pIcRJXPFHgJMjSW+yWwjyEKyFncvbixQ2BC6mVQTHJaJ/YEkefYaMHx
         YFN7ifPEhsWdcLW+YvvzK1uTIOgbeap0/h5d6yZnQuN3sRCH62gL5yt4Gj1VsetixtTL
         DczOEIfLV57OBkHSfhpAl2r3Z4IU5/LUSsu7yoYNwXGMpfjoNOUmMMcK8B5H9/4LpIYS
         1GIZqoBm2C+YqW+PNIT/aGLSVow+mEqN7YibNmJt43nrCXbVrXXglMhXBGvciRSlX5hV
         nZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfOuA3V/bhaGSLfM+8kkyDGmwsdYvlTYteI9hO4FV+Y=;
        b=cX4sjDVTdQVkdcnwftiU13woVgbnT7Ovaabzpk7MjO43OP9giJl/rKFhIO57+WtBAl
         C2zY7lVao9okx2D6U4IrT7q7XV5HAUtfWF7aW9QNdockfbEvkkXLs6gnR3YVmSEupSHl
         rE+pLZTntfd2Kzw/LfJ4wj7wXXdeAnDrqTQGA/mt64ozU0qrlXmv14dNimKGsQe0dcIk
         T7SpsyK5rk8uI5tnSQJsNxp8DxZC6681/NZg24rAC2lwnnCCB1Vwnzd/IM46VfbDfDUV
         EGzhKNbmRgjHCflWbA2Kfktzy2o0AlkbBh+QM3AfFOmOmRtcIR4pH54hQMga2QDbBSTx
         5NyQ==
X-Gm-Message-State: AOAM531bfcnc5T4Pu1Uet2ou691GJSyQvCUsJIE2VOKIu5SvamvKl2f8
        gQduZF3ypjZIHiC0vDIOCTfQlt6d95G5Zklh0y0fbg==
X-Google-Smtp-Source: ABdhPJwrXcVs+UXHHDay0UNgijYVzPYvtCxuzS3w7Yh0sx9pV9sdemLkJUP6yxArthq9QoLikhkPoN542ZR82qpzBJo=
X-Received: by 2002:a05:651c:1601:: with SMTP id f1mr15627004ljq.112.1631043011492;
 Tue, 07 Sep 2021 12:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <303401d0-25c9-d04b-e96d-3ca2aa0a616d@gmail.com>
In-Reply-To: <303401d0-25c9-d04b-e96d-3ca2aa0a616d@gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 7 Sep 2021 12:29:59 -0700
Message-ID: <CAHRSSEy9cYk2cUSQku5fsOjBErj9eEhMuMDQP8SJPJU9UhNOPw@mail.gmail.com>
Subject: Re: [BUG] android: possible ABBA deadlock in print_binder_proc() and binder_get_txn_from_and_acq_inner()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        christian@brauner.io, hridya@google.com, surenb@google.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 7:30 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> Hello,
>
> My static analysis tool reports a possible ABBA deadlock in the android
> driver in Linux 5.10:
>
> print_binder_proc()
>    binder_inner_proc_lock()
>      _binder_inner_proc_lock()
>        spin_lock(&proc->inner_lock); --> Line 662 (Lock A)
>    print_binder_thread_ilocked()
>      print_binder_transaction_ilocked()
>        spin_lock(&t->lock); --> Line 5531 (Lock B)
>
> binder_get_txn_from_and_acq_inner()
>    binder_get_txn_from()
>      spin_lock(&t->lock); --> Line 1833 (Lock B)
>    binder_inner_proc_lock()
>      _binder_inner_proc_lock()
>        spin_lock(&proc->inner_lock); --> Line 662 (Lock A)

Hmm. What kernel version are you looking at? These line numbers don't
match what I see in mainline. Also, the sequence for
binder_get_txn_from_and_acq_inner() looks like this for me:

binder_get_txn_from_and_acq_inner()
    binder_get_txn_from()
      spin_lock(&t->lock); --> Line 1427 (Lock B)
      spin_unlock(&t->lock); --> Line 1431 (Lock B)
    binder_inner_proc_lock()
      _binder_inner_proc_lock()
         spin_lock(&proc->inner_lock); --> Line 256 (Lock A)

Which doesn't have the deadlock hazard.

>
> When print_binder_proc() and binder_get_txn_from_and_acq_inner() are
> concurrently executed, the deadlock can occur.
>
> I am not quite sure whether this possible deadlock is real and how to
> fix it if it is real.
> Any feedback would be appreciated, thanks :)
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>
>
> Best wishes,
> Jia-Ju Bai
