Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A61B346D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhCWWeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbhCWWdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:33:13 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA8BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:33:10 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so20828590otb.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQiKUKE5LLzicC3GKIFkGS/5vOBpAIjzN60rfAG7hx0=;
        b=ln3YC/bUhKNlzIEJ3ZE3sM/keoGMMudHYuDAIpapuO8438z/OfvvIZkgC0TDqW9pnq
         PjFzBWUt8ykTbsS2cOr83vEk1kz6DeSiipcqF/ezxIhR7BsySrztPBHj54vjDtXWhIeG
         xAIJ6jCh7n8I4wdNQntaGbs8XmjEX1r8cW8NestjjS6HPFW+6vncPwG11Zu27BM7Z/Ov
         UnAVVbFszxg71nlW+BjR0qXttWuJceZpMQihlnC8ZsOsZlCn88GS5HHrtKGaeGSH6Mo/
         1rFYg72VD8fp7rr+MnLUo4hrsBDuN4992y7Y079PvDVHElFERMtQ6KMHHbYPbU+Yk2QC
         4Sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQiKUKE5LLzicC3GKIFkGS/5vOBpAIjzN60rfAG7hx0=;
        b=qil2iWFDFStlYhPToDCj3Eje5t6j1kPnxQ1l9Qpw8FlvwIJJw6FudYccQ1JaES/BOf
         LjwZ+/vhjkVEwhst4mLpqYeA3J8GnAvp9bBBLAG7hnSmtv1HrTI3tn0h9uSFDCYxHn1p
         uX6STa5fkRdR8K70F8I0pZxXEVvtc6Yngm5N6V4xmbL08YUvLg5+h2f5WR8zFNbU89R5
         KhowEIFzBKJbQYeP/njNV/tTPM1/9+mWGCaD369QxD5RxRKYKIVIJmuQgr7ZtbkXFT1J
         iVY+ilNHgYOP9NmfJndQo/Hcniudmbsm8j7d+QhuGAYl/SyG6ofPVI9Rf/oxtl7No14V
         Bg9A==
X-Gm-Message-State: AOAM533dTBh637FmD2PmOFH28xDySrK5qViBafdBo2Br6uvRTdSPgcRn
        sDzvICQlmLj4gfK/5AvOyyQTBMKzmv0P6/mcCn4XCabt2XkhMg==
X-Google-Smtp-Source: ABdhPJxu0OoySGVMTd7sJM5YkmJY8LNkwzSW5lFYxqruzkVag08kTs/00Xr70UMVHrAWidfKL+RvIAj0KGHRCR59ZZQ=
X-Received: by 2002:a9d:5508:: with SMTP id l8mr475105oth.233.1616538789586;
 Tue, 23 Mar 2021 15:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210323062303.19541-1-tl445047925@gmail.com> <CACT4Y+atQZKKQqdUrk-JvQNXaZCBHz0S_tSkFuOA+nkTS4eoHg@mail.gmail.com>
In-Reply-To: <CACT4Y+atQZKKQqdUrk-JvQNXaZCBHz0S_tSkFuOA+nkTS4eoHg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 23 Mar 2021 23:32:57 +0100
Message-ID: <CANpmjNMFfQs6bV4wrigfcWMwCvA_oMwBxy9gkaD4g+A1sZJ6-Q@mail.gmail.com>
Subject: Re: [PATCH] kernel: kcov: fix a typo in comment
To:     tl455047 <tl445047925@gmail.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 at 07:45, 'Dmitry Vyukov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> On Tue, Mar 23, 2021 at 7:24 AM tl455047 <tl445047925@gmail.com> wrote:
> >
> > Fixed a typo in comment.
> >
> > Signed-off-by: tl455047 <tl445047925@gmail.com>
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>
> +Andrew, linux-mm as KCOV patches are generally merged into mm.
>
> Thanks for the fix

FYI, I believe this code may not be accepted due to this:

"[...] It is imperative that all code contributed to the kernel be legitimately
free software.  For that reason, code from anonymous (or pseudonymous)
contributors will not be accepted."

See Documentation/process/1.Intro.rst
