Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E064F32415B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbhBXPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbhBXPhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:37:55 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88275C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 07:36:53 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id d2so3022650edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 07:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ji4BzJAQTuKp7DKTd2/l/jJe85G+oyb88MSqcOQIPcA=;
        b=nhJ2TEc9D954m2fmyp5t8t7hJTdxfopcBqtHu9wVsn5KLseijAl9KUPnpG7ywhzlTf
         fkr3SJqtGld4KfbBPtR6j5y/QNVK86Y3shePJVsksHlmISu3GKmyqfhPNMTrAGP/9a39
         vB0Y2AOegdmTaBbqQlX1U1pfff3bLA7a/7D3sW4xzWO5XHDpJr10lEjYeZ+HlNYkF2QC
         tG/S3KajEB1wgoan1EdBGf04KkkGOP+Z56FiRauMXPmRobp/OusHvxMICffzZ/72G8ns
         HgdLkUJ529S1AAwkudZDrI0RVWpKo9XrTopc0hbWcEronl6tqkds0ii74/HZyC9IpYBT
         Y/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ji4BzJAQTuKp7DKTd2/l/jJe85G+oyb88MSqcOQIPcA=;
        b=NAPWD5KWjTiIyygpeMw+2F6aUYOyC3/YX1cfdawYMV6kzlLQhSbhU/CTZoIxiSeulb
         CvXgTK58fUJvwepX75mP21M9BGCUoxU2JydTfO2hnnQko5EzsKopwRMdv5iMGCHpAR5v
         GY9NBvxziYI1v8HHtPRVp2f6SRtIUp9tpBR+Kid3bTs6kI3zqfQAtOtx14jTu+ZB5YUS
         o920OcaeZxRMgmaWlHHj2aoud40eSgQQYhUansv6xgMNFKvYrBbPBOl51aRYR6K3XEyb
         vszfXGG/pPoK3hkz7VWdsGquIIM/+7tOtihNm6le3kOFlfl8fp7xGfwIHM8iFh6t4voS
         lDmw==
X-Gm-Message-State: AOAM531VKFqRy32Pv9IHK3brF4Fdhm9kfBM2QWRYKCYSbjKUXfGnJIMz
        +LhMjtAKV5+gtYePVm1u5AXFEwc6unz65JgGt9vptEm9
X-Google-Smtp-Source: ABdhPJypVFQDXuXdKTrlFsegIYz2rvz2bQ+ux+ytJLboHYJ5K5LYIJdTg0KTOkN/Uqpr5HMy4a8QBQ6NeGXKFqYoRHM=
X-Received: by 2002:a05:6402:348c:: with SMTP id v12mr11144995edc.314.1614181012339;
 Wed, 24 Feb 2021 07:36:52 -0800 (PST)
MIME-Version: 1.0
References: <1613970647-23272-1-git-send-email-daizhiyuan@phytium.com.cn> <CAG_fn=WqixC0B+dW50gRFn3Qm63rQ5x6jP+2eGVAkRcuBOwQ6A@mail.gmail.com>
In-Reply-To: <CAG_fn=WqixC0B+dW50gRFn3Qm63rQ5x6jP+2eGVAkRcuBOwQ6A@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 24 Feb 2021 16:36:41 +0100
Message-ID: <CA+fCnZdSS9RojAAeF-tNT6jsFtUm34C1Khpsqz0N=4duDe+bqQ@mail.gmail.com>
Subject: Re: [PATCH] mm/kasan: switch from strlcpy to strscpy
To:     Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 8:45 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Mon, Feb 22, 2021 at 6:10 AM Zhiyuan Dai <daizhiyuan@phytium.com.cn> wrote:
> >
> > strlcpy is marked as deprecated in Documentation/process/deprecated.rst,
> > and there is no functional difference when the caller expects truncation
> > (when not checking the return value). strscpy is relatively better as it
> > also avoids scanning the whole source string.
>
> Looks like a good thing to do.
>
> > Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> Acked-by: Alexander Potapenko <glider@google.com>
>
> > ---
> >  mm/kasan/report_generic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> > index 8a9c889..fc7f7ad 100644
> > --- a/mm/kasan/report_generic.c
> > +++ b/mm/kasan/report_generic.c
> > @@ -148,7 +148,7 @@ static bool __must_check tokenize_frame_descr(const char **frame_descr,
> >                 }
> >
> >                 /* Copy token (+ 1 byte for '\0'). */
> > -               strlcpy(token, *frame_descr, tok_len + 1);
> > +               strscpy(token, *frame_descr, tok_len + 1);
> >         }
> >
> >         /* Advance frame_descr past separator. */
> > --
> > 1.8.3.1
> >

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
