Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6014636DEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 20:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243602AbhD1SP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 14:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243447AbhD1SP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 14:15:28 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7046C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:14:42 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id z25-20020a9d65d90000b02902a560806ca7so486878oth.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRZo4tjbQkODypjbD5IbSY7MNhOk04d/kV8UYGlt1QI=;
        b=Rh2Uy9oDFm5EBMMlX5tL/ldVgHDZJGjFlBPv4AZ5gqrBe2bvOlRcrf0kv4KuNhcKbB
         VA9D9rfuD/VUU0KCBQuMkjph6NSOR3Lr2ZL9q+L9K58HSbsnuID1A3b3+UbtYwhkBxPZ
         tEv11MQd3M6D87nXhTBq11NTpCj0Hhk4/kHfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRZo4tjbQkODypjbD5IbSY7MNhOk04d/kV8UYGlt1QI=;
        b=OsM2qd8iJ2EcJyYLEXaCHKGEiv/GrsF/4lCSTx0JL+Tl7BgVVE58R5Xz47vQRLF5Gz
         7pPsk4EkL5gmsZJz4Nq2FeRzvXKZ1bR1zo7GcMnHX2lnw/xArvG1ksRxdw/Hn/Qy3HUi
         VdoMt1RnOviHv27UwyQUYfPk+n93p5PY5fQOE+FXkXg0om2t6K7nmR83XlDQS/EA7Z+S
         CYjxIqVDxbZ1FWqTDRFhyy2gHjQ7scjUUogZBuxmB3LmToUVPXOGpAez7hxy/N50zsNq
         zKlJVw444M98b553SikKnZjkIMgEXuqTFmyB2u1okfEs6EEBzTXCOwWes0AIFYG25qeV
         xYIA==
X-Gm-Message-State: AOAM530lMJLJT2HXl9q2KwLvihYEopkfmIiYX4rkV4gFgNCuPj92kavl
        vsmJEwtRyoKGbCj0tTnMTh2rPdiJ7tGBysmqbYVca860Uh0=
X-Google-Smtp-Source: ABdhPJzzjgjH88cyHmwoGyK2rHu9q5UGZGkY5dVGMsZTRqHr3GgmcBCSxPnhoq6A/5JPNueu4u3jDlfWM8pC7Hg0uxQ=
X-Received: by 2002:a05:6830:2103:: with SMTP id i3mr24767663otc.303.1619633682393;
 Wed, 28 Apr 2021 11:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txMo5f9QvPqdzt8g3CmUpyDFf2Q_0XS4V1FyjHX8WQPRA@mail.gmail.com>
 <CAHk-=wh22MOMM5Paw-dHVvkp6W+UKx8mv_TNJ1TY9iaAMS1rLQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh22MOMM5Paw-dHVvkp6W+UKx8mv_TNJ1TY9iaAMS1rLQ@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 28 Apr 2021 20:14:31 +0200
Message-ID: <CAKMK7uHn_qFrfK9Dkd41NdXd-VHFsbH4gdnX3+J=0GQ_H0C0Mw@mail.gmail.com>
Subject: Re: [git pull] drm for 5.13-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 7:07 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 27, 2021 at 8:32 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > There aren't a massive amount of conflicts, only with vmwgfx when I
> > did a test merge into your master yesterday, I think you should be
> > able to handle them yourself, but let me know if you want me to push a
> > merged tree somewhere (or if I missed something).
>
> The conflict was easy enough to resolve, but was unusual in that my
> tree had vmwgfx fixes that weren't in the development tree (ie that
> commit 2ef4fb92363c: "drm/vmwgfx: Make sure bo's are unpinned before
> putting them back").
>
> Usually when I merge stuff, I can see that the fixes that were pushed
> to my tree are also in the development branch. Not so this time.

Maybe we're overdoing it a bit, but we're trying to not backmerge all
the time for no reason at all. Only when someone requests it due to
more more patches for the dev tree that need both stuff from -fixes
and -next. Also keeps you entertained during the merge window :-) Plus
I think it keeps us more honest with really just pushing minimal
bugfixes to -fixes to keep conflicts reasonable and all that.

But if it's a bit overdone I guess we can backmerge a bit more often.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
