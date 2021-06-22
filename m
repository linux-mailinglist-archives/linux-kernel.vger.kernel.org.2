Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73E3B00BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFVJvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVJvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:51:12 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A16C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:48:55 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so1856401ota.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nD+1l6o05xmy+VeXlqHaYhc8wOEE+zvUKMP+aUukBYM=;
        b=BlLwkz0QZDydr7SNM/bXhFBnc2kM0mgn/8nn8V4kWzH9i/a9lVOPNtE9iMb+8YxrjR
         Mre/2mnFj/gq9qoQWjBGg+cwAKwjWqplxPF1cc4dbTWk2WR6RkvePXJGOcUECIbduaJQ
         Rro3+vkRKKb1LH9E7BcEIjx0ZAZMyfT8ZUiB02OX/3bVF9cBIZGK+wgNd17pxGEtguwR
         Q0JI8sK6nnov+RxBQN5QkiwyIw4DSZSL8ixAkFWnseaVz1p60+VDHqKraA8oZZzw5Zvx
         2B9BJqVag8BpyTihdC9ZYwjxX6haC1k79P/yC3tWAp+JeJAlL+15rgMgthykfR7atUhl
         WMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nD+1l6o05xmy+VeXlqHaYhc8wOEE+zvUKMP+aUukBYM=;
        b=C3CzDp4rBKnxY5xOUM2oTcTYWHokk5RjZY73q8wCmFENPYJ9mOG66gJTKdpCVWqzR8
         wanBgqWJUpvDVNDUWoKsoMFBON1H1dt/Psl0mXCtGm7fUg9oTq8Jmfiz3ZG7QO9Jgk2/
         46OlMDlDZUeYWULxmINQC0jtKK6y5X37kpFPSI/ED+N1YKuLuvmDcNS58mI6dIQJahYx
         2ROjvNf4B7d7vOR23FoE83Wh84Ft0+OTHRRiYFrzycBAPX/jIlkJbcNlvzLhR1NwrjHQ
         g+W5SYI88O+Joa7DHZDppi2KhbsRjq9+o8YCIJkBX9teQi8V4CG2k3iqF7C8Bhcao3kN
         wd8g==
X-Gm-Message-State: AOAM531mEY3vK7cbRj0IxGyJBcheElzX3SRuFl0B8sYDOs8m6R2oW4dQ
        r6fy1f4BdzLygKvhA9TG02oVZEBM6tf64hDW8nfGsA==
X-Google-Smtp-Source: ABdhPJwI4wpym27x4pBWkuYhL+X3gpT+E2b8RxSSxNrlJWT0CL0jEM4nvpVx7PzkmNccX3NLHdQxN4J4vmhAa2geJnw=
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr2377707oto.17.1624355335059;
 Tue, 22 Jun 2021 02:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com>
 <20210620114756.31304-3-Kuan-Ying.Lee@mediatek.com> <CAG_fn=UTfR9yKrkdRDjxFn=vgR_B7kzytm9WDWT14Gh0PLXyJg@mail.gmail.com>
In-Reply-To: <CAG_fn=UTfR9yKrkdRDjxFn=vgR_B7kzytm9WDWT14Gh0PLXyJg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 22 Jun 2021 11:48:43 +0200
Message-ID: <CANpmjNPdaXj0egTTX6CmJonNM2UgbQPqza5Ku9u+ariJ8CQx_Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kasan: integrate the common part of two KASAN
 tag-based modes
To:     Alexander Potapenko <glider@google.com>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 at 11:28, Alexander Potapenko <glider@google.com> wrote:
>
> > diff --git a/mm/kasan/report_tags.h b/mm/kasan/report_tags.h
> > new file mode 100644
> > index 000000000000..1cb872177904
> > --- /dev/null
> > +++ b/mm/kasan/report_tags.h
> Why don't you make it a C file instead?

Yes, good point. report_{hw,sw}_tags.c essentially define it, but it's
called by report.c code.

I think I suggested to make it a header first because there were still
parts that were report_{hw,sw}_tags.c specific, and the helper
function would be used by those 2 to build their version of
kasan_get_bug_type(), but that doesn't seem to be the case anymore.

> > +const char *kasan_get_bug_type(struct kasan_access_info *info)
> If this function has to be in the header, it should be declared as
> static inline.
> But I don't think it has to be there in the first place.
