Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BAE3CAFA8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhGOXae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 19:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhGOXac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:30:32 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECED9C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:27:37 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id u7so8486286ion.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osEHxnbqkKfllh7yBx8CxwUvom3YXLUsPzxXJb1aBZA=;
        b=cGAoy8mJIPCCvX29zvxLWTVOQRmv6EEOzWJ8/xWrGg4dyMpd7yE9RVGKV+V8YerZOR
         4/k3ovRl4fh+qDvsKlPfwkAEBYFdO5H0A60lSBghSfLzhXrWiSL2TQkFQptBSs7+XawY
         nxJkHqm0hiF0A+b4xjjqaYrZAFRDxyK6LnonPHaeACyrkRXaxePyxA3TTCHRVDnEglT9
         z+yDwY7MVzmIBlTyscW+mNjhY1LYjoKU0FEyxNHl73lomm3gfGvuOq3fTZomsZMlD8se
         FoXeIgPB3/VL5ck2iHneRYcz5A+b+30Gkp+gwiSZyGDGfNIJzw234xjgpiyCQ7pqy1Nr
         15SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osEHxnbqkKfllh7yBx8CxwUvom3YXLUsPzxXJb1aBZA=;
        b=gkYEW55evyK0XxibugzWBrZIG/P2qENPzw3+0eh9N+w+vQJf3uY/26Fuoof2TazFjg
         82aQ8y0CpEZojSWMm6fxUbs6z35v7A8msE93uPBCCTmUGIApfWv9wo45uGrd2aDXAUKx
         AxUShvrZ8aKPpAlXtbwD+06twxeRaoKbzdw0Mj7DBzn373RJVLYiq2TXYMb3RoycxHYP
         kdSFit19OPmrx5rbJ/n8y/fCl6qfZ6Ap0EDkJhOC2li10bYJeRujzSL6SMlioZTSZOJh
         CuqJ83GVY2nRVRuKcvSspEhbADzPDvPqlU2le68YffbZLLaZ6c0PYi7KYuCBcjE4MI/I
         QEeg==
X-Gm-Message-State: AOAM530FMbStR3Nuc9B2O8pO+XqC27DgKq7azayixdV5xvmY/+LeCg2L
        WjmP2f08ZfU0RfD6NFPtsHH864wADe4FM4AbIvw=
X-Google-Smtp-Source: ABdhPJw+M3HiAGSiKBJMmx2eP+iFWPacEhDHA7mJnNhxrlxTC9Mg7R9DSCDvYUplDVAfCL+McCrFonbu3lbHNBsae7Y=
X-Received: by 2002:a5e:d512:: with SMTP id e18mr4995700iom.149.1626391657480;
 Thu, 15 Jul 2021 16:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfKyqy+vM0XkP9Yb+znGOTVT4zYCRY3A3nQ7C3WNUVN0g@mail.gmail.com>
 <CAHp75VeL89xaP9xjnigvv7Hki20=b7drp5iZ+ZfhZke6WGWsRA@mail.gmail.com>
 <20210714110218.izcop7grykhfyvll@lem-wkst-02.lemonage> <CAHp75VdGnuOPUKYSc0cFvXEY8Vt7LGiP2pS518=890FfV9Fk=g@mail.gmail.com>
In-Reply-To: <CAHp75VdGnuOPUKYSc0cFvXEY8Vt7LGiP2pS518=890FfV9Fk=g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Jul 2021 01:27:26 +0200
Message-ID: <CANiq72mO9RAUosO0=WWquENZvPHTwo0kpUCHW_1ELeb6uCtTkg@mail.gmail.com>
Subject: Re: [RFC] auxdisplay: Fix oops on hd44780 module unloading
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 4:12 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> I think you meant "RFT" in the subject line.
> Anyway, I have tested it and it seems to be working fine.
>
> Reported-and-tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks for testing Andy -- queued.

Cheers,
Miguel
