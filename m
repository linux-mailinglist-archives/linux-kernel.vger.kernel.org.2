Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629133141AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhBHVYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbhBHUPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:15:46 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387A5C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 12:15:06 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v123so15793321yba.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 12:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhcum4svcwC3SWklBj+aaK7FBNJdNhmD/wa+W4RHGu8=;
        b=f7uI5JraEv9QXV+p+V19S0imUKncdPHnrjOKXW19rYNpjk/hD2mg1dJwYpFBDUNiQI
         Kl37cEutp1yx5A1kvpTfMVRlPom5pQyn7cw7nPjZsMou/pZjb9MJbU0zViM9kkzSghWd
         Ymgp40I3L101/HEzFNuprdaynHhvG375mk08r5qbvcLAtWGYGlGGralpp/TlOsfoPE2g
         WPmhSXxP6NvM24m5T4kL2I/0+2CneUIfJWKh9xj+TR6Mr/Z2QzOwXun4aM+a6TNY4Bwt
         ZTF7dnclnk9t+PN8ZgSaleEGwz0HC7hOzmy30hjCBGj9XiQrKhV+rrinbpfUqflrobW5
         0Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhcum4svcwC3SWklBj+aaK7FBNJdNhmD/wa+W4RHGu8=;
        b=Da9S5NlKAKAN/nG7SGiju07gvEfoHs+IogXlZI47Qbc3KyKBN0seE6MwbuJTU0Bl8e
         3L0LHiwqJakVyRk8A038e3qqEEXLIlnMKHg1yPB2GX6bEjp6TqIAbwZAR6UbqBcrpNyK
         4iixqJVoyzeo3ZfqVIu54n6iiAs/64P8d17gT/sbNiPeh56ahVZEnAJigTS03TT58xfr
         iQImbEhiLZtSrrjqSJlACULDFEbwWPi15X6+CKYhoamkoLs9D2LGb3NIWujaU2pr1B0Z
         u02ywM96TR2UP9Id9oUHKimmFGo0Nxf3oUSq7DCZjl54/mCmQTjoUcUhq8PwTdI4dECA
         2OJw==
X-Gm-Message-State: AOAM533LNRb/cK69dPW3KgvIArW2/5BVkwUYx8KxWoCzp5BAwUrn49kh
        rqBx/TrApn1NcexmZCuSBUrBeLggXaDPIxFNCf0=
X-Google-Smtp-Source: ABdhPJzFyhofWkTpH8X2Kp+zcRKRk19PRpzHNNV2QnNFmaM5JV8l9C63rSQ1LAvnllaDcHwx/s15WSmUSxghZ9grTmY=
X-Received: by 2002:a25:d94b:: with SMTP id q72mr7769190ybg.135.1612815305553;
 Mon, 08 Feb 2021 12:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20210208175824.381484-1-bigeasy@linutronix.de>
 <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com> <20210208190735.ibq44r5pc4cwzt7j@linutronix.de>
In-Reply-To: <20210208190735.ibq44r5pc4cwzt7j@linutronix.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 8 Feb 2021 21:14:54 +0100
Message-ID: <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Remove in_interrupt() usage.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 8:07 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Yes.

In what way?

> No. If you know the context, pass it along like this is done for
> kmalloc() for instance.

What do you mean?

> The long term plan is not make it available to
> divers (i.e. core code only where the context can not be known).

Sounds good.

Cheers,
Miguel
