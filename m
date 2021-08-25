Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EC73F7271
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbhHYKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbhHYKAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:00:02 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4AFC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:59:16 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id x10-20020a056830408a00b004f26cead745so54082873ott.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RT/ruHmEJSYewLcThfyctJrU8xPbr8Cf1G+FiOsvBbc=;
        b=kH94v5ZxPDA7JSNS32fZwHKxAXd60dS9blcW/t47MaGYzjYnCKVR19RucXnY57xNKr
         BUrzW/8zOQIKcpWMsaITLqjndyxPgOYKArgLmXMjrv8eavPanrhDnYdJ4XMtUImJ2pQ2
         KBpVSuyz0k1kju91c+0Cv+SMsrvZmMf7EQ3VXi1Ld/R9ZOogfsLocTo7KlnhKbz7t3Bf
         yf1L4Pjtkr1utHQrJxKKNdJiDxUmGOX7XIkK4gFmNhbQuEhRVkWVlryWVInLfVUwoldi
         FoJvcETwbTnVZyeldnHF6u+10bxhp+2VPaVASQNoVY0kLIkzR5f++l3n9FBLUBUN+o+U
         9vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RT/ruHmEJSYewLcThfyctJrU8xPbr8Cf1G+FiOsvBbc=;
        b=pEtX27fTXGWZkDzcoSGLuJ0XQIUxj2wKIhwAUkTwUf/nMYpz2KDQzWxpf1LJiAsg99
         inN0G/d+lBtsd+8lnS+HnXZcRJS6PPwXOPhXKbZb/iskIaCU+FWhibpJRqIC6kjczcOp
         u4ZLe0dPh9BGVKz5wzmu71GA3e2xNyc0geGA6kfhdSdbltbK7pmKxdPy14LnCuHjC0pE
         5tuv9iVfdYH1BOgjK1wtBS9StlmCbDku/JPu0Cott162lMt5YiIc73z4gnIeetN44zF9
         dIkZ4CJDoXR8gr1DeWHdkJ3zA+GZRUC1HHQK6YOgVli20/JTko9A3gttLH1OwPh/j186
         uXPg==
X-Gm-Message-State: AOAM532LF7PdfhT0X56j8NEF6ETWQLoUvWCa7Zct/xXCvKILx7IES3kQ
        LkRnTRiahjBzF/LyMxNW9vPql319NTyutjadX4/6oA==
X-Google-Smtp-Source: ABdhPJx2usLhYzv+VjiLuR95RXRD8SNaj20fFAitgqXBEpUoTneeal2gi19km1Bp9KPiR4r6uJfBVYv99DlHTSaUqlA=
X-Received: by 2002:aca:4589:: with SMTP id s131mr6136352oia.121.1629885556155;
 Wed, 25 Aug 2021 02:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
 <20210825092116.149975-5-wangkefeng.wang@huawei.com> <CAG_fn=X9oaw0zJrcmShNcvd3UsNSFKsH3kSdD5Yx=4Sk_WtNrQ@mail.gmail.com>
 <99daf260-76af-8316-fa9a-a649c8a8d1ab@huawei.com>
In-Reply-To: <99daf260-76af-8316-fa9a-a649c8a8d1ab@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 25 Aug 2021 11:59:04 +0200
Message-ID: <CANpmjNMZ-kNVkCRWDfgEjrR4BT1B0gVNnvao_w3nEM9pA3Epbw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: kfence: Only load kfence_test when kfence is enabled
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 at 11:55, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> On 2021/8/25 17:31, Alexander Potapenko wrote:
> > On Wed, Aug 25, 2021 at 11:17 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >> Provide kfence_is_enabled() helper, only load kfence_test module
> >> when kfence is enabled.
> > What's wrong with the current behavior?
> > I think we need at least some way to tell the developer that KFENCE
> > does not work, and a failing test seems to be the perfect one.
>
> If the kfence is not enabled, eg kfence.sample_interval=0, kfence_test
> spend too much time,
>
> and all tests will fails. It is meaningless. so better to just skip it ;)

But what is your usecase?

I'd like to avoid the export of a new function that is pretty much unused.
