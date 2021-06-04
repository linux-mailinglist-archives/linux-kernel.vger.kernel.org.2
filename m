Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12E439B626
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFDJnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:43:32 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:35628 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhFDJnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:43:31 -0400
Received: by mail-lf1-f46.google.com with SMTP id i10so13171134lfj.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ei8pyLo4r4uT7uyrXWXyiKmrptGk/QFssNB0l4EQmXM=;
        b=LJg9jPjDJ5utzM3LEUHQdWR++Rn2mykXQh0hvn7DDiogfRrfLMNAPWX3qyvh0ra/Ab
         sWWpswmUIZ0I6xq97Ji+GotUdRkZIX9xAtHCSDemKNoHineEQIJyF306akaUH5cMc2Zf
         9w9gGSGBGVYsZ9mqCzAcPuQ7bLI/S/1CxB/xhef+fW5n+qjp9KOw5W+v8MtM2pgBimrD
         Wj6Q9qjMlb9hOksv55rlHpDXGUKCdWQrfoAOv4whpDQEUkgXNSBfxOvvlqe42i3YQuvF
         pYMdQgMCTm0K7//5HEMyQSQXs9PmbM1SEgg4EAa0JOdv+8FXXp8LOf6KYaXi9Vp/UcaM
         K/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ei8pyLo4r4uT7uyrXWXyiKmrptGk/QFssNB0l4EQmXM=;
        b=iILANZ6fixRKETZP/e5tyT17BwQPZo3vgt0ea3WEgVsLiMPXp/R/pncEMlFEJ61bMY
         sryAXee/oasyKJTGeM9joxL+BkxMnbuvzWYNzN4cbXCS5z6Ae9N3L13LSrfrKV4ucqDp
         ubhH4FgQrQR11W54PchYhpJCvCAR+5UxoE8d1wDncjbALURz1CDz5/hpFa8YOsPJ0ftf
         Zp5MXShFphXXM+q/wfMYiRqlHUtIDtB/ofJgAvSDblSmDUztklTJ7pzeQOH9315LF8P2
         xtvQ4+x72svkeo0e4w5vxZa19UrjOSFaHdL/eysjSsu5NKOMtmwrL8teLXmfrzQLj0K9
         uYMA==
X-Gm-Message-State: AOAM533IhSqFcORIjGOKSpJJfOyfP0JvILUFhDkz5g0uzCieqjuvsG81
        z4MiGqa3nmICs/tn6SYiekE=
X-Google-Smtp-Source: ABdhPJxPmKWiOcrWFZ0FnXgYuaKnYFk+HfDcWcDqr/q2+syOKDNyJ3L90z4hz8mVk60BwLqEr+6mJA==
X-Received: by 2002:a05:6512:3da0:: with SMTP id k32mr2225018lfv.1.1622799629489;
        Fri, 04 Jun 2021 02:40:29 -0700 (PDT)
Received: from hyperiorarchmachine.localnet (dcx7x4ycc2b7s--vdqzfy-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:42b0:76ff:fe23:6d08])
        by smtp.gmail.com with ESMTPSA id q127sm656224ljq.88.2021.06.04.02.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 02:40:28 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [PATCH v2 1/1] pgo: Fix allocate_node() v2
Date:   Fri, 04 Jun 2021 12:40:27 +0300
Message-ID: <3979125.JPf0czqrma@hyperiorarchmachine>
In-Reply-To: <202106031436.132E0ED9A@keescook>
References: <20210603133853.5383-1-jarmo.tiitto@gmail.com> <d7e94352-0b24-1ab1-8b54-b6ffd4347963@kernel.org> <202106031436.132E0ED9A@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote perjantaina 4. kes=C3=A4kuuta 2021 0.36.39 EEST:
> On Thu, Jun 03, 2021 at 02:14:24PM -0700, Nathan Chancellor wrote:
> > On 6/3/2021 6:38 AM, Jarmo Tiitto wrote:
> > > Based on Kees and others feedback here is v2 patch
> > > that clarifies why the current checks in allocate_node()
> > > are flawed. I did fair amount of KGDB time on it.
> > >=20
> > > When clang instrumentation eventually calls allocate_node()
> > > the struct llvm_prf_data *p argument tells us from what section
> > > we should reserve the vnode: It either points into vmlinux's
> > > core __llvm_prf_data section or some loaded module's
> > > __llvm_prf_data section.
> > >=20
> > > But since we don't have access to corresponding
> > > __llvm_prf_vnds section(s) for any module, the function
> > > should return just NULL and ignore any profiling attempts
> > > from modules for now.
> > >=20
> > > Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> >=20
> > I agree with Nick on the comments about the commit message. A few more =
small
> > nits below, not sure they necessitate a v3, up to you. Thank you for the
> > patch!
>=20
> It would make my life easier to get a v3. :) I agree with all of
> Nathan's suggestions. :)
>=20
> Thanks!
>=20
> -Kees
>=20
> --=20
> Kees Cook
>=20
Hello,

Ok, I'll make the requested changes, noted by Nathan and post v3 patch soon=
=2E :-)
Btw. These patches were  based on kees/for-next/clang/features branch.

Thanks for patience.
=2DJarmo



