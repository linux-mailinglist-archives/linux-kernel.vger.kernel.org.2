Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79A36DEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 20:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243626AbhD1SRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 14:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbhD1SRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 14:17:30 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B62C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:16:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u23so963353ljk.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQnbqIU21Yz7IsVFuLMZC9b3+5uNVTkHETJ8YPIGjUA=;
        b=Dq/BiUnK4j286jdMxydTWwCSXsnXMY6qTX9rEAcwREkRl5ZWAX6jm02gZEyeA1iIim
         LKML45U97nYBWML0zErNmL9MwW1/fZUSDqPZ4mpkhM2X7NWikuQBZT6iPxq5ADph3Eil
         L0GsmGg/AJUfTFnkGD8TfJdbECN/mbLcT6OgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQnbqIU21Yz7IsVFuLMZC9b3+5uNVTkHETJ8YPIGjUA=;
        b=ttn81K6Nnv3bT+QO83OoMwwYQpZy7Tvrcbkxbfm6UtWCRQEWpp4xWuYkRWgO7Z3aKK
         VulwRqcLzDVTN3ApbYXcfoRWaGJL3trDw0Ok+dGQpNl2IfKcKt32qL1OGQ+Mqq6aXfSC
         sEyw6YOp+1HJ1NoT+6xRmwtqdgVgyJAshUh6NWEYjb5YFmrmkVBIZ/9aKzVDQADbnODH
         5NAM16555k+dNXSWcpFBOtqI5uyX9WdOXnvfUXo71NxSjAO8shNremE1qw45YmpI9Zou
         tizm/y24p5xv8Ht2qeG4biqR8vNA+RGva9e8SANPrjgrrHrIcAQuVQBfB7igNtMlrvGt
         edFA==
X-Gm-Message-State: AOAM530cndiaHr6uG7cMnE3CO4SzZofZOkTUoIFrDOS+e89E94Kpdrgd
        IvgQ7/VuvdYOGVraxh6lHC5UyREeGWvBQpsX
X-Google-Smtp-Source: ABdhPJwu5QYxv31/quY7zThZ/xYQ3POTRSXRD7/R2YXKv8xI2T3Xqkc77JkGlpAVQGAVlKtAWRm0+A==
X-Received: by 2002:a2e:7817:: with SMTP id t23mr20582815ljc.240.1619633803723;
        Wed, 28 Apr 2021 11:16:43 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id r13sm133843lfi.261.2021.04.28.11.16.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 11:16:42 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id a5so36349017ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:16:42 -0700 (PDT)
X-Received: by 2002:a2e:1406:: with SMTP id u6mr20726288ljd.61.1619633802354;
 Wed, 28 Apr 2021 11:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txMo5f9QvPqdzt8g3CmUpyDFf2Q_0XS4V1FyjHX8WQPRA@mail.gmail.com>
 <CAHk-=wh22MOMM5Paw-dHVvkp6W+UKx8mv_TNJ1TY9iaAMS1rLQ@mail.gmail.com> <CAKMK7uHn_qFrfK9Dkd41NdXd-VHFsbH4gdnX3+J=0GQ_H0C0Mw@mail.gmail.com>
In-Reply-To: <CAKMK7uHn_qFrfK9Dkd41NdXd-VHFsbH4gdnX3+J=0GQ_H0C0Mw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Apr 2021 11:16:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=g1khafTYZH_5QhwLHv4iN=e+_F6tGzw8-+aH7wyJ8g@mail.gmail.com>
Message-ID: <CAHk-=wg=g1khafTYZH_5QhwLHv4iN=e+_F6tGzw8-+aH7wyJ8g@mail.gmail.com>
Subject: Re: [git pull] drm for 5.13-rc1
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 11:14 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> Maybe we're overdoing it a bit, but we're trying to not backmerge all
> the time for no reason at all.

Oh, I'm not complaining. I think it's reasonable if some particular
issue doesn't hold up further development.

So my email was more a statement of surprise at a new pattern than
anything else.

            Linus
