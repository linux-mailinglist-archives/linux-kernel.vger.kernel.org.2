Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC43C312423
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 12:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhBGLys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 06:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhBGLvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 06:51:00 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26214C061786
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 03:50:17 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o7so8464273pgl.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 03:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9IDMWbwqRjWQ88sXAJ6HnXN8J78RgV5vzOEqBH3b4Q=;
        b=FQRIE1jcDkARAu2aLteEtkCYM+mzS8So7WE025WE1MR1R2ZhSDDYzpEPVPAuAdwcBy
         1bGRd9KwluSFPRY5jBBRpu5w2Xv7U6W2T6souo+wq23w3hVZLeDz4W3JP8AmOvqrA0al
         cMSrZWSBI6bptzWr2swc+PwNqUMITqp4ghKfAnFKXJ72J6IFeK0lLSjDE/L4VWq4R1d7
         Xtkiy6YdMGM77ybqeZqrx5mAu+6wrXg65NOSF75kpwXvAfB5ps5cNFCRiaZ3BOLtTITh
         9k1CVSCtP9t1UcJO/Rhsa+MhRA6qrILxpyQw0IV0L2AZ1XWcs/rK1S7fYybFLmSpRNxm
         6Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9IDMWbwqRjWQ88sXAJ6HnXN8J78RgV5vzOEqBH3b4Q=;
        b=cTB6lzWn3GWUDBDVduHCnjKn9IUzjFIBtsBapPa3Gdddg2UdZxzIeXQ4at3Bqxn03/
         7S7m4m7rijFKElHXXcBGZ6D3SwpPIo23g3445aPEKlrp+DJjtbj7ZP4FmPilEMMrAYmG
         G+3c+nQYZOBPKtDur7rsFs8vWuyFrQcImBgLvwyvb5Pf7Pe0XepPBLc4dEr35Qp6xSR3
         3ienC4egKO6i/qswNPWtx/EqtIO6+b5U6Pv21+AeiLdv032INhfZuFyG42SBkF6dDEjw
         qBJqEfDBc6LPePBpdHi4Xz1I4BvUetD2h6lHmdig+Dn/ZLfG9GLn6MoZzHzU15fP14WI
         Qz2Q==
X-Gm-Message-State: AOAM530EP1XyWLCGSImxJG9SwKHh8H1ViRkk1FIHT5SAG0DRdFQH2Qes
        XDChlSg7Cs7UPdIf8Yke4CkqT4sedl5YymJjtsE=
X-Google-Smtp-Source: ABdhPJzz5FdA9mEQewbiXnFzXEt1wrrogcNRuo7SNvUl32EpRPuHX6xINSjHPx8e8zZxX0GRokJnVbP32CTj3jsgjcQ=
X-Received: by 2002:a63:e50:: with SMTP id 16mr12682906pgo.74.1612698616412;
 Sun, 07 Feb 2021 03:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20210206053109.78205-1-dong.menglong@zte.com.cn>
 <CAHp75VfMYOz+qexix_TujGfUgFAtUXdbS=ekVdE_4cwRv5W8pw@mail.gmail.com> <CADxym3bsqAH969H-P8SSam+_gbjgWkxP90Zh-RnzDaOJuwD3ig@mail.gmail.com>
In-Reply-To: <CADxym3bsqAH969H-P8SSam+_gbjgWkxP90Zh-RnzDaOJuwD3ig@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 7 Feb 2021 13:50:00 +0200
Message-ID: <CAHp75Vc50sMfOLSk3nfPcAqfeKeCJ7_MiTKzwksZFt078J-+DA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: socket: use BIT_MASK for MSG_*
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "dong.menglong@zte.com.cn" <dong.menglong@zte.com.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 5:29 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
> On Sat, Feb 6, 2021 at 4:20 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Saturday, February 6, 2021, <menglong8.dong@gmail.com> wrote:

> > It makes it more confusing if you understand the difference between BIT_MASK() and BIT(). I think you have to use the latter. And note () when referring to the function or macro.
>
> I replaced BIT_MASK() with BIT() in the patch of v2, and it looks much
> more tidy.
> I can't figure out the difference between BIT() and BIT_MASK(), seems
> the latter one more safe... isn't it?

BIT_MASK() operates on top of (long) bitmaps when you already know the
address of the certain word you would like to change. When the
parameter is constant it will be helpful only in some (rare) cases,
where you define a (long) bit mask, which has a bit, like 65, set. For
most of the cases it's not needed. It's rare that hardware operates on
bitmaps longer than data bus width.


-- 
With Best Regards,
Andy Shevchenko
