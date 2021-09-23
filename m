Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CB641626A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbhIWPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbhIWPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:50:23 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3754DC0613E8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:47:28 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t2so72449qtx.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mQ7J4946rPgf21nD+uOWBbdKEn3T7TjKfOLDKhMFyj8=;
        b=mTZSIMO+GVE3tAo3UxQ/EEydBd45P0gIJQPxkrgTq8B0UZCXkEnrSWUJW6upsdbj4b
         Q+S46nBbvfjWhrTOs9o+HrBmHAMZFTUytwznDahlXAoqa6qg2MP6vaNyZOuChN1SRFzu
         Un9VKdQg/TUxiTBWNI0FymudM9q9M79nvZMV18kDxdGSmdlbfEsK04lmbBG3KPQbo3kc
         erEjMADzPxqjpSJ+2+q9x2dp/eJSDp1B5NrA4Px5JDxD81H+BhV6mFTLHWxar5Xm6nVt
         ZeIvmSvzBEvV2nEiQKYQ0J1EFw3GxobotbcFK7had7vcG47cyKj4Ykd6r9gH51AEzJqp
         Oz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mQ7J4946rPgf21nD+uOWBbdKEn3T7TjKfOLDKhMFyj8=;
        b=ANceBfLKw85YLGzwIQAP11EwyfO12qXHSxNhkYssn/1/rOxpRzf8MUTScuzNk8uBWK
         /RiC3dbnr54VMzptRs+zRfuSVYRVXB93oLaCZhBctRDtrz9VMQBhjuohlxZWkXpJryTN
         1G+UAy5BAsPFtS+CZ3OFaXI8dHBWHta/fxrvcZnAbDItaCEc1sbbS7pOYszsTYdcaS58
         aqLM+gcYeM7iXiExCwrncmuyv7oCDeeHe6M8oET8z7aOv1Mg6SS0/PyAum0bZJ80XP/u
         xEiyAEJTgBmwR34Wk1Zh12CYzk11AncgRBBq5yk6Zn9Gc/0dtNfmmaVRKngZPuq56TQ3
         b4xQ==
X-Gm-Message-State: AOAM532Zx0Id7vUeiWSNlqi9oQ4v9ZwlMlwXS8UGW2fiwTDz+ppsR9In
        qqjcAy2b/sxYWWliGP6RM3lYQD22xzCAQqbepDG+UHWNFRo=
X-Google-Smtp-Source: ABdhPJynQcc8u1IiKdCTBGHiJLmmRjkYQQEfqx/2tsoY0Jci+rVn4TQHwv5aVEvzq1R0nrpz3rCLNrw8sxXrHl0Z4Ik=
X-Received: by 2002:ac8:7482:: with SMTP id v2mr5389401qtq.235.1632412047701;
 Thu, 23 Sep 2021 08:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210923104803.2620285-1-elver@google.com> <20210923104803.2620285-5-elver@google.com>
In-Reply-To: <20210923104803.2620285-5-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 23 Sep 2021 17:46:51 +0200
Message-ID: <CAG_fn=XGFY4kWSzTa4kX4Y0CPOpvQfhBzgZFK184ZptzyC6-CA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] kfence: add note to documentation about skipping
 covered allocations
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 12:48 PM Marco Elver <elver@google.com> wrote:
>
> Add a note briefly mentioning the new policy about "skipping currently
> covered allocations if pool close to full." Since this has a notable
> impact on KFENCE's bug-detection ability on systems with large uptimes,
> it is worth pointing out the feature.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Alexander Potapenko <glider@google.com>

> ---
> v2:
> * Rewrite.
> ---
>  Documentation/dev-tools/kfence.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools=
/kfence.rst
> index 0fbe3308bf37..d45f952986ae 100644
> --- a/Documentation/dev-tools/kfence.rst
> +++ b/Documentation/dev-tools/kfence.rst
> @@ -269,6 +269,17 @@ tail of KFENCE's freelist, so that the least recentl=
y freed objects are reused
>  first, and the chances of detecting use-after-frees of recently freed ob=
jects
>  is increased.
>
> +If pool utilization reaches 75% (default) or above, to reduce the risk o=
f the
> +pool eventually being fully occupied by allocated objects yet ensure div=
erse
> +coverage of allocations, KFENCE limits currently covered allocations of =
the
> +same source from further filling up the pool. The "source" of an allocat=
ion is
> +based on its partial allocation stack trace. A side-effect is that this =
also
> +limits frequent long-lived allocations (e.g. pagecache) of the same sour=
ce
> +filling up the pool permanently, which is the most common risk for the p=
ool
> +becoming full and the sampled allocation rate dropping to zero. The thre=
shold
> +at which to start limiting currently covered allocations can be configur=
ed via
> +the boot parameter ``kfence.skip_covered_thresh`` (pool usage%).
> +
>  Interface
>  ---------
>
> --
> 2.33.0.464.g1972c5931b-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
