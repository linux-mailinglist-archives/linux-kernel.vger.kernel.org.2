Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE87B395903
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhEaKhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhEaKhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 06:37:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B8DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:36:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g8so7551887ejx.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9r9VRf/fh7JhFL3DqDJ/NjbEIHDh6XFA5801Gx2Ynyk=;
        b=Zf7mcTnY272iyzHvBsmzRMda+V+cFit5Eo1vUf7LL0dzyhGgf2Ysm+3S/tH3z4xSqe
         tWXibCER7qDiHqXPJbFJE9OUOzwwSIAP7vBjT9ugqlCujV843ItIudURxruALsJi2BFf
         yfMkP32S02tt3bEcbFlNlw9FNMQ0OPshwfcwIjeXXWquSqM0mbSoEQiBoK8nPbZhs57k
         DJtgJLakDBrBWglE5zYV4g82L95RvNpXVyNVDnry6Uj42+48HFDFvymL0QmOcYRBDCgJ
         uBIdnwRrPsIoHZquAG/zT3tHl3I5d6qRL1RYhm1bmbRecXmv2X4HfO5txcYCttlixvax
         1ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9r9VRf/fh7JhFL3DqDJ/NjbEIHDh6XFA5801Gx2Ynyk=;
        b=Hi/U6QiSILzzHmj7Clz6+HCkTjnOHcnKOT2u/Jzw2ItKMy5iEawzJjO+TTcnmB5Et/
         sM3lL3yX+ema076yPGOMfgnWM0yj6WjtvRcTwYDhI8Q6RoBhaFN/IiU/m2yiLOiqqN0x
         Hd4Qz0SmtNeqw7Aw6TmQk20rXkqbBzG/gOS0DWH3fn5yxWnu4kaakMfEbxuT7dXzw+u+
         v8CaGs74kyC5Z2eHJJGMsvkjP42HT7dvhTjL4UkTvrE53/kK1BDmGwtf3hUg4lqqEIx3
         s5FCzL15Iw7x1hLAwf3d2OuXzsLkrSPBTxr4chfGBp02c0t0bY9IVyvkEcXZISGMiHi6
         g2bA==
X-Gm-Message-State: AOAM531Y3W5FPce+zF4Lt261KgmqRIzQ9mq1TLI09jrGyRj9+dEJWUol
        WudJsGbHhxmiL26C8MB0y10gnfeX2bYqR//US3U=
X-Google-Smtp-Source: ABdhPJyKjq9jnfbGqJEu4tSP4G16v/ZoRcbJ/3fwt8Idm7VIY/oPi23f1tRxmZELIAzodGmnz9aa6rrAQL63pv+smm0=
X-Received: by 2002:a17:906:3c44:: with SMTP id i4mr4648872ejg.135.1622457360124;
 Mon, 31 May 2021 03:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210528140500.GS24442@kadam> <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
 <CAD-N9QVjhDDJxRnNrDzwt05BNijr1o11nE8xjvq8GrakEJ8EuQ@mail.gmail.com>
 <20210531044022.GU24442@kadam> <CAD-N9QWBBP6_Wwi4z3e4yJM-tS54=1=CcvAA+2__Qj8NsTLq9g@mail.gmail.com>
 <20210531070337.GV24442@kadam> <CAD-N9QU-uqFr=b1hMi1h1ytq2Uf2XKL44f9OHBRhM70zhkiO7w@mail.gmail.com>
 <CAD-N9QW5C2ssA7H_U+eiM=SbsPj29Ooo6Sk=r4d1qELbZQjuPA@mail.gmail.com>
 <20210531084613.GX24442@kadam> <CAD-N9QVAdaitDcM6BGfwvNR=gMf7G6DK00n0Ev6ucXc6xNFFpw@mail.gmail.com>
 <20210531093817.GY24442@kadam>
In-Reply-To: <20210531093817.GY24442@kadam>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 31 May 2021 18:35:33 +0800
Message-ID: <CAD-N9QUTZ49CvrhW76pTUDOp8y=29JXxR45Z_W53qVz0PJHVLw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: control led: fix memory leak in snd_ctl_led_register
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 5:38 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, May 31, 2021 at 05:10:49PM +0800, Dongliang Mu wrote:
> > Hi Dan,
> >
> > I wonder if we shall split the current patch into two patches, one
> > patch for each memory leak. It is better to satisfy the rule - "one
> > patch only fixes one issue".
> >
> > We should absolutely fix all these memory leaks. But one patch for two
> > different bugs with different objects and different paths is not very
> > suitable.
> >
>
> I would just send one patch, because I only see it as one bug.  But you
> do what you think is best.

If you think they are the same bug, that's great. Just send and apply
only one patch as it is. I will not send version v2.

BTW, could you please show me the syzbot link for the bug you tried to
resolve? If it is not from syzbot dashboard, can you please show the
bug report?

>
> regards,
> dan carpenter
>
>
