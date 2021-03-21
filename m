Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BCD343554
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 23:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhCUWGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 18:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhCUWF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 18:05:58 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E8DC061574;
        Sun, 21 Mar 2021 15:05:57 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id a143so4539005ybg.7;
        Sun, 21 Mar 2021 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fE/qgBK1NmFEZAgpdjYg50H5NNCPMZiuBPujzhGKjw=;
        b=bGjZ88HiH05x7XZl9wxTqvH7Z2oNjDZQ1uEoOzSUe6zlE/wrutGafZzFIVvgnomtmz
         Vb2Cw4SmCnjGo3ciVM+/18pqN3dpEXFYnsQsdjXiPbj83X7n7JlSulIeDet+owGhw3iY
         GsrCqh1L9Bwxfsyenj8JG7TJrfAR/f2hch+DIbOGbgSSDL8qxDY+ySRAnPE9KBjmA3aB
         fLWGNfpYCdT2nPj+ScmhkA46VrcDDZPGIq2EaHTgMO96g2J9IjNZhqQe05Xr9BXYuE2z
         0MpgwIWrnZlxjxT/CNUF3jqwMyonD9j7f5Gb/jQ3JzROSRwb6D1m+Ki5NcB1i74XxJyk
         higA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fE/qgBK1NmFEZAgpdjYg50H5NNCPMZiuBPujzhGKjw=;
        b=jcMjI6qz6zSVLt55NhvbFkIl3sDwaalyOGGz7HfH8k0J5r84DNdFWy2Vem0d1Ysuwl
         2NFnp+Zip6ITVIDf2IaegejULN5XDvqCKpY+wBarkEdnKZlhMmObOJadIy2aA9q9ouV7
         ukxjysjrYPUEYqSPaHJyeFNWx6vd4lRxEWNV3IBFuFfhSzi9cyIhcVwgM/LAfP2+X2Kk
         d8C8xBXIp4EU2+e+q8J+bf4RswS2gbK3nzx1vX5GGlGPNgXFM1G8e/Vhev8rNdC5TMHj
         MSDKqEWSgDW+hqKLREiu7iAtT+uM3kfkqverJX2E+QV/HZraGdGtdsvHKdvnH8XQyZU8
         RgoA==
X-Gm-Message-State: AOAM530Oh0pborHEf2UJx0CxwGzppNZuqC46N/bs0oCJ5HGmcUhdEcyw
        4HADg9OkTBZrWpfun1rjK/fMqZwTI+4So8JWRO8=
X-Google-Smtp-Source: ABdhPJwwPbmoKE3Z5dRLY4eQwTBc2F5WSh1HoZ8h2Y95Qb9z178bVCVa/GNQHDSxR6lv09HHHStdJVgOPKy31tHxjKw=
X-Received: by 2002:a25:d296:: with SMTP id j144mr19995078ybg.33.1616364354655;
 Sun, 21 Mar 2021 15:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210321193705.GA13699@duo.ucw.cz> <CANiq72n=XNwH8JrPfpzTMrHujhCYVzk5BgVmifiVcTk3W_=L2A@mail.gmail.com>
 <20210321205619.GB28813@duo.ucw.cz> <CANiq72=FmY=MQrockHjKay=govJ=Wk51D2tnnLsM9N8HLh207g@mail.gmail.com>
In-Reply-To: <CANiq72=FmY=MQrockHjKay=govJ=Wk51D2tnnLsM9N8HLh207g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 21 Mar 2021 23:05:43 +0100
Message-ID: <CANiq72nSaSVyOcSJ=REdaxoYMhYfv3ARFtVJwW0uMbTxGema6Q@mail.gmail.com>
Subject: Re: Getting Rust to work
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        rust-for-linux@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 10:58 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I tried your config and it worked, so it looks like the problem is
> your old libclang (7) does not recognize some of the flags. If you can
> try a newer LLVM installation, it would be great to confirm it.

Yeah, LLVM introduced asm goto in 9.0 [1], which makes sense if you
were running libclang-7.

[1] https://lists.llvm.org/pipermail/llvm-dev/2019-September/135304.html

Cheers,
Miguel
