Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5223E5515
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhHJI0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhHJI0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:26:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7433C061796
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 01:26:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b6so23518669lff.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=djm4DWbOF22GhsSvHwwgQ4MO8NZc/LJRB+Vb97tWuW0=;
        b=QtQSkDYS9w7avyA8UUAyR1p5yorxliXuFlS5AocLoZh8RLzymJJOhaznYtkRR1WTD5
         j0niLWf+G96pJbeqX2YyGUDJYSG2qwUgtzbhNIku7WnBVHtO0tXJcICn4+zeXuIcaVXD
         bENk6TgC1mpKQN/tMKlIEtmY6eWttigESp5KeiPIq2Fu6hrtyzz6vap2z7gtt3Nxzz7R
         bMlE5Kz4+ywpLvucwqdHorJd2b0uV/PvoQLrI5gSxvGXK1+yiGLSfLDqCpBDEqPSRzWP
         LtVW+VrAP/RKPjh+yxi0J30EbAP0w113KgYXaAjfM7j5dEo7FS/4XSaamI+59oW6Yc08
         Expw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=djm4DWbOF22GhsSvHwwgQ4MO8NZc/LJRB+Vb97tWuW0=;
        b=ZVnLXEVc5RqNYrnEpQr7DYaZnXtwXq1Dsewo9fGncUFN62R8ilGGjyqOqqd08InwEO
         MXxdVQbYwa+xRV9BwQYRAD243eig86sfsroHkH26MT9wkx9gy9jo+cV2NeKWm1CYguZG
         azwpL+8IoAuouMeVCUp3kcxk8xbBHS7a/REZlYk6Ci5Rz98p+MDmXhl/ZMPgElYCHV/c
         /pRguz42PxOaV0QrgMyac4r02pIqbmk9+Z7V4tD42U7x8tcbo04BF58VRGdSQI1uxPa0
         NSdYng+mddZC5+RTfQ6ScCrHbl9B0qzuZyFyCwqP6Y0UWVTPxCsMai/2czjQrbs/qPhm
         dPow==
X-Gm-Message-State: AOAM530nyeG1udu5q8MQ44/rKrd59135scdUF6UxcW121tyfs7BCfLqY
        ZrH4nTraVwgsdl2y6MYnHZjas4YctFTSapCD7y21NQ==
X-Google-Smtp-Source: ABdhPJy+8bv0DEw5D+Cldh+36uB+ypSXDqcR8YNnjehpz758RYuy1Hyme5gswVLwUSfvXz0sBmBXuqjPuDWoFcXT1Lo=
X-Received: by 2002:a05:6512:1141:: with SMTP id m1mr20542919lfg.492.1628583990192;
 Tue, 10 Aug 2021 01:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210722190747.1986614-1-hridya@google.com> <CALAqxLVLMt7rbJBQtFBw-ikBAjKrVgfS8=Nu6NFQbp_gq1m22Q@mail.gmail.com>
 <CA+wgaPOQmY4H9n302YspKuLk9iq9vBzdWBTu19EUUsiQYTUOzQ@mail.gmail.com>
In-Reply-To: <CA+wgaPOQmY4H9n302YspKuLk9iq9vBzdWBTu19EUUsiQYTUOzQ@mail.gmail.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 10 Aug 2021 13:56:19 +0530
Message-ID: <CAO_48GG_=zA39iUzzHD-2b1ktqrTCZ3k8z8V12x48u4SS30_TQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: Set allocation limit for system heap
To:     Hridya Valsaraju <hridya@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hridya,

Apologies for the delay in responding;


On Wed, 4 Aug 2021 at 03:09, Hridya Valsaraju <hridya@google.com> wrote:
>
> On Mon, Aug 2, 2021 at 7:18 PM John Stultz <john.stultz@linaro.org> wrote=
:
> >
> > On Thu, Jul 22, 2021 at 12:07 PM Hridya Valsaraju <hridya@google.com> w=
rote:
> > > This patch limits the size of total memory that can be requested in a
> > > single allocation from the system heap. This would prevent a
> > > buggy/malicious client from depleting system memory by requesting for=
 an
> > > extremely large allocation which might destabilize the system.
> > >
> > > The limit is set to half the size of the device's total RAM which is =
the
> > > same as what was set by the deprecated ION system heap.
> > >
> > > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> >
> > Seems sane to me, unless folks have better suggestions for allocation l=
imits.
> >
> > Reviewed-by: John Stultz <john.stultz@linaro.org>
>
> Thank you for taking a look John!
Looks good to me; I will apply it to drm-misc today.
>
> Regards,
> Hridya
>
> >
> > thanks
> > -john
Best,
Sumit.


--=20
Thanks and regards,

Sumit Semwal (he / him)
Tech Lead - LCG, Vertical Technologies
Linaro.org =E2=94=82 Open source software for ARM SoCs
