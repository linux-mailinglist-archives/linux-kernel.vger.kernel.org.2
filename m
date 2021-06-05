Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49439CA25
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 19:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhFERRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 13:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhFERRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 13:17:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F38EC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 10:15:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p20so15823480ljj.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3r8c/PTMZwMqkgH83feAIels2f8yAyQNtEiVpRoaizw=;
        b=MqZfknYtp9SYSYE6iaWHs/w+Je/9u6UjyPO6InNrHOPGgBRJKqetRq+vSXh51mzLwP
         Eu5nE0ozRg8V+kNd5TPZ5Im0reN4TBhQXYLpube2j3xJ97DIO0o8ORyjvwD1Ct1xmHB/
         HkJRz/Qs/g9BrDFgH2R639NGxXcGGmwvSirfdC7x9wPyqhNkFESFBP+nOdS5tOn6gUSM
         rxKtPoAB1pV51xG1Do2t2MuVciIMkxp0j4rbGNR2yZDzr878mcNYvrd+rSSDQnBXiFkF
         gbO1cV/u/YHf9JS7kTq08rXX7lTl6oCqXm9m3P/iiNSA1N2HdUsgl7fSPn99dlZBlpDl
         pluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3r8c/PTMZwMqkgH83feAIels2f8yAyQNtEiVpRoaizw=;
        b=cxAnYgXJwGUjugUNUJa4sbXOfP7L7X3w2hhwrgxr/qTCrs2Hm4WdfL7Ke9nUA7BTZp
         nfiXhjU9CrbQWs4li29pYE6zTGYig/51/8B1QEkrmTKmwvq8g9Uu7PqhS4b3Q5tvVJKT
         jIftxPtfusjcrpobk8QIMQAPmQIBbMVDaGE4eQ1w73wTl9UuPt5M49Nq2czANcn0KJQu
         cinIH7iFd1h/jC4/tHILufDZlMJJBtLZqgP22vQs3D7Q6MboVll/ynUicAlMjLzdocGJ
         frGDF1Q1m3IvRvNDhPBXHTSSasTFN1jExpvoZa88EIcWWO+xGKO0g7/hrPwpwKGgcGlr
         KJ1w==
X-Gm-Message-State: AOAM532KwJ5JNGjBjk7IWs8grMBgb+MbgBjQrNxX16QhrR6fQhjpJfUB
        sh7l6nHilSpMZgnbO+F6E/0=
X-Google-Smtp-Source: ABdhPJy5QjD5CpgQ5ozKwKiwOrHpygFaxD97QJQ1zN5Pe++ViHiowKQjWqjFxIegDJH4uFjXR2wTog==
X-Received: by 2002:a2e:bf14:: with SMTP id c20mr8081405ljr.57.1622913330897;
        Sat, 05 Jun 2021 10:15:30 -0700 (PDT)
Received: from hyperiorarchmachine.localnet (dcx7x4ybp09ts--z5-7ry-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:2cf7:60ff:fe99:fedc])
        by smtp.gmail.com with ESMTPSA id d40sm99630lfv.102.2021.06.05.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 10:15:30 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [PATCH v3 1/1] pgo: Fix allocate_node() v2
Date:   Sat, 05 Jun 2021 20:15:29 +0300
Message-ID: <2268220.EOMg9uvDZY@hyperiorarchmachine>
In-Reply-To: <202106041104.929FFB3@keescook>
References: <20210604165819.7947-1-jarmo.tiitto@gmail.com> <202106041104.929FFB3@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Kees Cook wrote perjantaina 4. kes=C3=A4kuuta 2021 21.06.37 EEST:
> >=20
> > I grep -R'd where the memory_contains() can be found and it is only
> > found in #include <asm-generic/sections.h>
>=20
> That's true, but the way to use "asm-generic" is to include the
> top-level "asm" file, so that architectures can override things as
> needed.
>=20
Thanks, I didn't know that.

> > I cross my fingers and await if this is my first accepted patch. :-)
>=20
> I tweaked it a bit and applied it (see the separate email).
>=20
> Thank you!
>=20
> -Kees
>=20
> --=20
> Kees Cook
>=20

Whoa!=20
Thanks, I'm glad it worked out. :-)

Btw. I have almost forgotten that I once wrote code=20
(that I didn't send) for the GCC gcov subsystem that also enabled=20
=2Dfprofile-generate/use for the kernel.
However the Clang PGO looks much more approachable and
easier to hack on since the profile data format is simpler.

So starting to work on this felt just natural to me. :-)

=2DJarmo



