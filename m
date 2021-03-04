Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDA432C94D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392520AbhCDBGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453030AbhCDAl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:41:57 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEE3C061760
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 16:41:17 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w18so17560157pfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 16:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=bzAk7xOxXBZJjA3PKx6u2cISfvd/uRWO9F02o3/MMeU=;
        b=VOLPs70aVMFs2vJeZPRuE4qTRxzmALGXdaIbqfjIEx9ZOMWrtmjR6N3pMc1d3R7va6
         6Mt4Uq4Tz1FS52fkP2pMt0iUQl/7fmN5+5zCiz+ryop/R8PC1dAlVsN/1PZYi7Ig3Lfb
         psoJQVLU2eEwhPeQ2zoZ7almzzBnC7b4gk4cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=bzAk7xOxXBZJjA3PKx6u2cISfvd/uRWO9F02o3/MMeU=;
        b=eIvuA9eeeEiU2CEyOdXvYiEe2hKAdq2PUt6eGYr/dGMazdbkVXGl1eZ4yJLSlngfvZ
         YNKbFqmdhK2PZi8Zc1mawMar93j0WJgNBH1Ueq+cQvzpkXR4cc0IWHIrur8NSj4s6HFn
         4VrwCO11kfVWNppNnYikLfITi+CjPDzNDkcCWxNIWH0fMCF1jKQwAAqcY4fzHcAnyPtY
         C0K46PO7oozad2itBtqvfaf+jCC7CPFPgnfnqlzjtl6xzCu9gf3qPtxm+tFnpHbaHx3m
         q0QCNWR1LovxFDLUCwRK/ikcuk2Vg8wsIOq4tN0Xhny6CwagDyfp+zsDH+7X4T71Y05q
         V6JA==
X-Gm-Message-State: AOAM533jqXBsRtsUgyo/ztjEP97fryCukOvnzjK9KQM0lRlEiekLCmQ6
        IYd89dxMfi47QitwUvzV6gTgNuHvIVsm4A==
X-Google-Smtp-Source: ABdhPJxeRI4/UEukQjyhdO0eNGf32XVTuZwJuylcZGQb9qKLTxOrV57sdm7g17D6iwSPk8ACYYlf1Q==
X-Received: by 2002:a62:3085:0:b029:1ec:a570:682c with SMTP id w127-20020a6230850000b02901eca570682cmr1433409pfw.28.1614818477383;
        Wed, 03 Mar 2021 16:41:17 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id k9sm7226023pji.8.2021.03.03.16.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 16:41:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <161472770533.1478170.3061709841985494537@swboyd.mtv.corp.google.com>
References: <20210301174749.1269154-1-swboyd@chromium.org> <20210301174749.1269154-2-swboyd@chromium.org> <CAHp75VcCjYm59-BQ0paPDCV97N5mgcq_OAdeixgUDEnAuG2qMg@mail.gmail.com> <161472770533.1478170.3061709841985494537@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH 1/7] buildid: Add method to get running kernel's build ID
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 03 Mar 2021 16:41:15 -0800
Message-ID: <161481847514.1478170.15409325926185522779@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2021-03-02 15:28:25)
> (HTML mail?)
>=20
> Quoting Andy Shevchenko (2021-03-01 15:33:06)
> >=20
> >=20
> > On Monday, March 1, 2021, Stephen Boyd <swboyd@chromium.org> wrote:
> >     @@ -147,3 +158,31 @@ int build_id_parse(struct vm_area_struct *vma,
> >     unsigned char *build_id,
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 put_page(page);
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> >     =C2=A0}
> >     +
> >     +static void build_id2hex(char *dst, const unsigned char *src, __u3=
2 size)
> >     +{
> >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0bin2hex(dst, src, size);
> >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0dst[2 * size] =3D '\0';
> >     +}
> >     +
> >=20
> >=20
> >=20
> > If you are so only printing this via printf(), just use %20phN. No need=
 for a
> > separate function.
> >=20
>=20
> Makes sense. The downside is that we may have to calculate the build ID
> many times then by searching the notes section? Unless we can test the
> whole array very quickly for "not initialized" or stash another bool
> like "build_id_initialized". The kdump code would also need to take a
> printk format then. This seems better as is but let me know if you
> disagree strongly and I can change more code.

I am using memchr_inv() now to check for an all zero array. That seems
fairly cheap so I think it should be OK. We trade-off a small amount of
time for a few more bytes savings.
