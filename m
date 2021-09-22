Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE26414F68
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbhIVRwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbhIVRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:52:39 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E691EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:51:08 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d207so12939369qkg.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rZT2K/Q8MUfaC2qjpJTTFyZ9xAJMAYxQ7cgEJCjq2XY=;
        b=MPds0ZGb7d0+CWzI3IilgsLSQygqyPWCjWlOAXUh2tHeCGrHgpetNvxFmfD6QnhOQV
         1bdl5zXekJR4RUdJYMmgVcLebiNcBUPeRUVsy57tWR2SJvZEqg0xZb8frrm+Wom5QqIT
         mL5HC0qmGPH+zzRqBhXinHZCCIGvLqAs+9S2biycWjurIpNIxmG3M5PU9IuPk9VzCgmK
         Qsnw0QAypE6Sfu8609A3TGaAQ6ue+0MbApyeG7ZX4YH92Fy/L6sCPY+AU3JdXySi60Yw
         WKz0pXYX6Mkcd7YiEgbzEpUyKfBEiTXlEGs1h7v6hyQPpGvXTU+xSDQCWXTGHkOVMoir
         90VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rZT2K/Q8MUfaC2qjpJTTFyZ9xAJMAYxQ7cgEJCjq2XY=;
        b=mUD7rPQ1FJ8ratIVNIbgftV06Mby3BlfPBCpv7FkwgA8luitjT5QCWtxDAQ6bi180A
         aT2HdkSaHTesYoKZf+1tktTky47ubQ6DDx1qviHDd45ZamRhnIaKuH0NX15lbAjSuXZ/
         1hqiE2u7fVYb3A9OKlkugJtPkdqoCrK3I6tNChVdeKyY2kY5eymR2LoOHlgOzSz0kStn
         89bjYSCUfmBnYucbnVBpRozoLi+WckCqGMvpbvkkUeZDByXFBHfRIUs3BTfolVj0VshG
         Sa8rfg6qRxzSWYe1TArBKtJChAISEyub3e49LevQlOO9gJwtZHWwttSi2mPYxjGwjNzf
         592w==
X-Gm-Message-State: AOAM530o19ktieH5AiX3gy3tsY7gOLp3xkw4I4D7YB/1+CcqT0gJ+HXE
        qFz7P0O/PVuBZGKHI8uDTtedKaSiZKW0RoYo22d+hxhWJ/hsSw==
X-Google-Smtp-Source: ABdhPJxZSPLU6e99TrTbzJ6w6df7pzDnSCeIHFgfVnVpx2mXfKFc++W0UqO880O7okYtJcSCtbBn/emVclazGAvdlEg=
X-Received: by 2002:a37:8044:: with SMTP id b65mr531503qkd.150.1632333067678;
 Wed, 22 Sep 2021 10:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210922170903.577801-1-lvivier@redhat.com>
In-Reply-To: <20210922170903.577801-1-lvivier@redhat.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 22 Sep 2021 19:50:31 +0200
Message-ID: <CAG_fn=Xpek=e6drdCBQXUUvd5kAh-Ui7Xfjg6CY=MNpt0KHjqg@mail.gmail.com>
Subject: Re: [PATCH 0/4] hwrng: virtio - add an internal buffer
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-crypto@vger.kernel.org,
        Dmitriy Vyukov <dvyukov@google.com>, rusty@rustcorp.com.au,
        amit@kernel.org, akong@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Matt Mackall <mpm@selenic.com>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 7:09 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> hwrng core uses two buffers that can be mixed in the virtio-rng queue.
>
> This series fixes the problem by adding an internal buffer in virtio-rng.
>
> Once the internal buffer is added, we can fix two other problems:
>
> - to be able to release the driver without waiting the device releases th=
e
>   buffer
>
> - actually returns some data when wait=3D0 as we can have some already
>   available data
>
> It also tries to improve the performance by always having a buffer in
> the queue of the device.

Tested-by: Alexander Potapenko <glider@google.com>
for the series

With these four patches applied, KMSAN stops reporting boot-time
errors in _mix_pool_bytes reported here:
https://www.spinics.net/lists/linux-virtualization/msg46310.html

> Laurent Vivier (4):
>   hwrng: virtio - add an internal buffer
>   hwrng: virtio - don't wait on cleanup
>   hwrng: virtio - don't waste entropy
>   hwrng: virtio - always add a pending request
>
>  drivers/char/hw_random/virtio-rng.c | 84 +++++++++++++++++++++--------
>  1 file changed, 63 insertions(+), 21 deletions(-)
>
> --
> 2.31.1
>
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
