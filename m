Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E129C45B076
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 00:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbhKWXwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 18:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239613AbhKWXwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:52:36 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C81EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 15:49:27 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso1402437otj.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 15:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZ6pBwF1NuzbVzImJ7QGAdV4gsNd/T58S8MXtt6omVM=;
        b=fTZoFX+cx6Va5ji4D3zVGwUKeZ7E43iQgDaAthrMbfJ/BnhQgQQezOW/3JzdS706xs
         yJ4BS2xbfbXrjhLLyoLJ+e3HjWQDuAo3imKP7N/kJlY9nj3S3hVulW5NKlHgLK1pL3AW
         Qi73arkCJGSEl3iaVZfWIYmFFKFu7tamViUAsQqZxGgsr+6fb5wzhgajXs/+Vw0V0Zvk
         UT+MTYotGQtc/DMu4pTvkqLZjDvlak+qtBpNBY8Ly8W61azJ4n/+uDoBagGKTnZWgJP7
         R07ebBr2j2XDbk7X7EGja1KiQqj2vHwOKNOsqTiALniuaTup2mxiXsigfxWo/K1IFXT/
         Ps3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZ6pBwF1NuzbVzImJ7QGAdV4gsNd/T58S8MXtt6omVM=;
        b=Gk64B73ibraoaumjOgQr/lEDOJ/eCpJm1QxTrIyOvCOi2o8hr4Ziy3DdKObFQjpLbp
         bmkb5gC6Gz1KpwJRu/T8tLOqWCz3XVEcd9dp6C+RMTFwvljDWqAUE9YOSCorlJg6U1KO
         4Rn/rdDAjgRNGAaNYHKM83hF1gDvrKSwSmDppT3WeBanl5Gl9p4MY1oaK6nn0DjJZC9H
         dBNqBh31F4Cf/yT1Kde1qsqkOxvcLnsl6wqTvyfgUB9yNyS6Lo0L1p7RIV6qKta6CyiJ
         prOuKt6R+GTZ3s8+iR+e8UwFM9ubUrz3ueF3g5nv/jxDBTck1pkc6d7vHmg8fYkL9IE0
         m1zw==
X-Gm-Message-State: AOAM530soW2uccvw4OQnFKTZeS44/Z2tuiUV6ZQSBUUo6kV1xElZ1GyC
        Pv0/glkki47j6aIYe2hqNgpQL+fbhn8I03yDbTIVO56bWDh8dDnj9uA=
X-Google-Smtp-Source: ABdhPJzxS4DBIwjcle3VRvJgjdsTQlL8lgfqIB5O/DV/uuvWrOs3nV3ub0rGc64u01tfzkD5jS0UyX8oBFWgH69kgjU=
X-Received: by 2002:a05:6830:2646:: with SMTP id f6mr8631680otu.182.1637711366923;
 Tue, 23 Nov 2021 15:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20211122195350.GA166134@makvihas> <52ad7e4f-7164-e868-ca49-2f0fecda3395@gmail.com>
In-Reply-To: <52ad7e4f-7164-e868-ca49-2f0fecda3395@gmail.com>
From:   Vihas Mak <makvihas@gmail.com>
Date:   Wed, 24 Nov 2021 05:19:15 +0530
Message-ID: <CAH1kMwQz3=1uf5cR2sgNrWq6f+6x9icCYXXZLO4V41kS_mTr+w@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove unnecessary NULL check
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> BTW, same can be done in rtw_usb_if1_init().

Yea, I noticed that too. But the NULL check  in rtw_usb_if1_init() has
a follow up "else if", so I didn't change it.

Thanks,
Vihas

On Tue, Nov 23, 2021 at 2:52 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> On 11/22/21 22:53, Vihas Mak wrote:
> > remove unnecessary NULL check surrounding rtw_free_netdev(), as the check
> > is already performed inside rtw_free_netdev() in
> > drivers/staging/r8188eu/os_dep/osdep_service.c.
> >
> > Signed-off-by: Vihas Mak <makvihas@gmail.com>
>
> Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>
>
> BTW, same can be done in rtw_usb_if1_init().
>
>
>
> With regards,
> Pavel Skripkin
