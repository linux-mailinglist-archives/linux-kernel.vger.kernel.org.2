Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FE73F7257
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbhHYJzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbhHYJzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:55:10 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266A3C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:54:25 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i3-20020a056830210300b0051af5666070so44308839otc.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u292+T+PmNvvzzkHWgQqQyq2ET9S9Sd8vOWw3NIaxU8=;
        b=fdYoLhyAPa70zFflHkbc0jPuLAmarJelaiV3EHuGBC/x6BSW9INC3reopeOhNwOrqd
         fOuDF0G5YMfSVhbcXIhd6XIm2wtPJXNq9DU4g52Dh2vMTXdN1l3feSj1mDkAAxuIVwqL
         d52eeW/FPCDLsePj1vTohQn63Z621mFMjkrwxrHKPmiXQyiVlF4TBSa6MHkAyNX3WplF
         QsljTBxdjH02ED28l/YVKOwF0vcI4bYx3sPmZ+LiGc3ib75jm5RDYFaHEEYxRq5K/2iN
         fDtAACYtC3OrjCoPrmfvB0Wbz18jEgiBYBuL3ewMzNNccpQPqSP9ro42Il0zkqr5fCok
         aK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u292+T+PmNvvzzkHWgQqQyq2ET9S9Sd8vOWw3NIaxU8=;
        b=eqkzdWGNUk1Kz6CjBZjbWvFttmJZmpulrBc6SipXDixtV+ik5nP2zWmiWt38PCr4xF
         o7ALiTAPGk2BS/IZp58Mmp6SoyvAngwNYl26doAhcHY2X9ePP7nMioYlX1Px8MIZPee5
         Qk9jumRpqNXt0fuHz1oxcXkKahnL/dka7LQu93NnHEM/cJHGtetDL9jz1Wqv7lCPNT1+
         UewwGKt4stL2S+hAvRycYlhK02BR02O7wmCgY2EubAt0IaPRLQiSpeNH4GlfVMeVcqi4
         Qj5NubCPbLD4/6NPZQq/nKTYJP7fkYPLt5/wI3LKgjvGcKWOc9q+qRrb+xAp0SOa+k6J
         y76A==
X-Gm-Message-State: AOAM532J9vHw+5sEIw22oUTeP15S5LZvHlMB4TOazqQEZE5rpAdfXEI/
        1kiaDd0hwnpWMYeH8YR5lG1BvjZlmnu+oFx61ngTUQ==
X-Google-Smtp-Source: ABdhPJw06OWfSSBQZ90EY4CXd+Zmvqbypk7F8T9q6crqFZCrAOl83adjr3qFW1g6VdvZOZGe1cBQw2A+a5HSTLvCuTY=
X-Received: by 2002:a05:6830:88:: with SMTP id a8mr36303165oto.233.1629885264254;
 Wed, 25 Aug 2021 02:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
 <20210825092116.149975-5-wangkefeng.wang@huawei.com> <CAG_fn=X9oaw0zJrcmShNcvd3UsNSFKsH3kSdD5Yx=4Sk_WtNrQ@mail.gmail.com>
In-Reply-To: <CAG_fn=X9oaw0zJrcmShNcvd3UsNSFKsH3kSdD5Yx=4Sk_WtNrQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 25 Aug 2021 11:54:12 +0200
Message-ID: <CANpmjNN4=ckdTcSKJNurmW3BNyU-V4QTJbR0cm4s-whW3ykRHw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: kfence: Only load kfence_test when kfence is enabled
To:     Alexander Potapenko <glider@google.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
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

On Wed, 25 Aug 2021 at 11:31, Alexander Potapenko <glider@google.com> wrote:
> On Wed, Aug 25, 2021 at 11:17 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >
> > Provide kfence_is_enabled() helper, only load kfence_test module
> > when kfence is enabled.
>
> What's wrong with the current behavior?
> I think we need at least some way to tell the developer that KFENCE
> does not work, and a failing test seems to be the perfect one.

Like Alex said, this is working as intended. The KFENCE test verifies
that everything is working as expected, *including* that KFENCE was
enabled, and has already helped us identify issues where we expected
it to be enabled! Trying to run the test when KFENCE was intentionally
disabled is therefore not a useful usecase.

Please drop this patch.
