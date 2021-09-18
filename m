Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8C4107CE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 19:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbhIRRXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 13:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbhIRRX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 13:23:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB2EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 10:22:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i4so47310873lfv.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VJ9K4Ss0fO8sq3w3fi+s1XQy4Iv3mwXh4Uemm8nutng=;
        b=HtuwRZUCtjojC6VdTZELWNXgY00qcbptQey5+LTejhwWo5g8CMmknjSym9G74RH6Ma
         oPcVOCFM0bvoDz0JDWFOmLoHw2mzTecjQrEShzwr3fyltdeg/Yk3k9bXEJyFI8+DILmo
         Zn76QBbRztSInJyQGaDYETcYPmfh81XD1W72o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VJ9K4Ss0fO8sq3w3fi+s1XQy4Iv3mwXh4Uemm8nutng=;
        b=r8qUsmcizAN4ncd+qk21GvCkF7vDGDgZ99uljoRUffQRfRzJUQXomXX9x4Ti5Yh12s
         xwiCMHrjV05PmZdKW/hFXNpbKIoFeQM4YbgqCQcXlJY4odig7v02Gl++odAjnZBUskRg
         QejN9Amz/E6chPRl7e+gdS9h+f9o7jR58TtD4brIdF0X4kWxvgvJ5b8i9y+IsLW5aZ/C
         ptIgZcL+m5q3wf2cAVsxdcFwvmiORGy+VJbKDHkBsE0euD5EqARr7yVqvjuX8ZU7jcXM
         /ZhHkS4zPz176RKtHD85n6H4w+RX3OZbop8FPHZ0MvotjInsrygNVyncrlpW1AL5t56K
         DNNw==
X-Gm-Message-State: AOAM5301g/Qh6MltZ8Fu7By5yadEov/Augk6oHWWIyXqEqEOVfzZ2t3H
        baSvmdw91RT+8nYyWQxsZ4YD4LUAlMf+KhpQLm0=
X-Google-Smtp-Source: ABdhPJw69ApbVPbXIE0O4v+urTKBunEWNF5gHaHRmBi01o9Vmmju+9kO27YyzcwAx0KmImguJj4GVA==
X-Received: by 2002:a05:6512:3183:: with SMTP id i3mr12059059lfe.104.1631985723726;
        Sat, 18 Sep 2021 10:22:03 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id k15sm1186871ljg.45.2021.09.18.10.22.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 10:22:01 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id c8so46863328lfi.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 10:22:00 -0700 (PDT)
X-Received: by 2002:a05:6512:94e:: with SMTP id u14mr12398440lft.173.1631985720656;
 Sat, 18 Sep 2021 10:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210918095134.GA5001@tower> <202109181311.18IDBKQB005215@valdese.nms.ulrich-teichert.org>
 <CAHk-=whY5mLggPSr2U00mqgUbRJYnYSxtNZm4FnEtQrHftYr8Q@mail.gmail.com> <56956079-19c3-d67e-d3f-92e475c71f6b@tarent.de>
In-Reply-To: <56956079-19c3-d67e-d3f-92e475c71f6b@tarent.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Sep 2021 10:21:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj=fFDt6mkiOmRs7pdcYJSibqpVvwcG9_0rbVJEjBCsw@mail.gmail.com>
Message-ID: <CAHk-=wgj=fFDt6mkiOmRs7pdcYJSibqpVvwcG9_0rbVJEjBCsw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Thorsten Glaser <t.glaser@tarent.de>
Cc:     Ulrich Teichert <krypton@ulrich-teichert.org>,
        Michael Cree <mcree@orcon.net.nz>,
        Guenter Roeck <linux@roeck-us.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 10:17 AM Thorsten Glaser <t.glaser@tarent.de> wrote=
:
>
> Considering you can actually put ISA cards, 8 and 16 bit both,
> into EISA slots, I=E2=80=99d have assumed so. I don=E2=80=99t understand =
the
> =E2=80=9CEISA only=E2=80=9D question above.

Oh, it's so long since I had one of those machines I didn't even
remember that EISA took ISA cards too.

But yeah, there are also apparently PCI-based alpha machines with
actual ISA card slots.

            Linus
