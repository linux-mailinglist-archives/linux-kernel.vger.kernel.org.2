Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553FF3F3B92
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhHURDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhHURDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:03:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290CEC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:02:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f1so886999plg.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HTFLhWisTNLRIx4NTlvnb8zMtfi4Uwgkrquy0wqd74=;
        b=CL4GyunjSvjkUb3nw9klbGSUZKKv14t780WUflmlEdS7mdCWLDZ0tl5NaGd39USl4Q
         ++OpD5POBw2IQr2lqQV+uL7wLgpKMMiCmWUQp35TAWm6wcY70KxtKwKFKgmYJZVIq1aO
         nQwQq1GsWsIkbQkRznKEZO2wWs5gwn4wfRhfoj6jyVZ1WiyOv9710kL070MBPOUZpMhq
         oon7xSg9Dzq1k8Q++D3u6/QGPEGsQT4q33hDS6uQM/A0MQyMCRHLDK1z+PZGHxgV8BJ3
         tRSO3a8nRGD1dU9VlNAL+DmufZZCL1BayjomDDTSQyLwjPljWhLNcnLWiVDV6jzyWaP1
         l1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HTFLhWisTNLRIx4NTlvnb8zMtfi4Uwgkrquy0wqd74=;
        b=afIolm3p0C6WtTLDfO5DSE/4dpXLR5oFj9wYEmOHqWW4woxdzL3PSh3s86F1uTWeDK
         gU70kGlWI6BaKUuKgWo4hg4+pCTPPPGSxsFRngcr1E6SjPqdi217FJrtKRu1RgHEwsyI
         U3wvSGDQlfyJcs+nfrnCVJ4AFVDyaIqgIlvsHtMmn34vh6C0p9b3HsNcr2n38sR/T8Os
         CfXB7jU19jI4da0H2rqaTTKXeqngTyoa+SqXEHXFFNHXATsg/ulRiJLsMZzPQ/dkHP/m
         kAQxyqjq0hkpXKAsVHiU9pD8pjrOQN9gLfrZ1Hk4QaGqLVhsQeOej2IjawzEWMS/EL6F
         3uyg==
X-Gm-Message-State: AOAM530nT09vGEkPtqKd8mFTOXU/XbbpfPxQSfZKJVDtT0eTO1ZH6omm
        4NlpRDEWkcHFdg9g5x0MHGQ36pNER9R9NODcVeRQ/GDz5lphsw==
X-Google-Smtp-Source: ABdhPJwQCZj+SdVJpFLkj9iH5Cwtl9rfF9GijnwS91rX8chEmvKxPq8upLIQdclNlup5JI6n5h21D6bbqUKcrxdh6Qo=
X-Received: by 2002:a17:902:6ac6:b0:133:230b:e8bc with SMTP id
 i6-20020a1709026ac600b00133230be8bcmr723484plt.22.1629565354706; Sat, 21 Aug
 2021 10:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210821105615.6307-1-phil@philpotter.co.uk> <2360857.63PHMDANz2@localhost.localdomain>
In-Reply-To: <2360857.63PHMDANz2@localhost.localdomain>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 18:02:23 +0100
Message-ID: <CAA=Fs0=KXjYEJqPeuNjEdWEZQ91QC6gJSuSa4y0X9BqfOXEw5g@mail.gmail.com>
Subject: Re: [PATCH v2] staging: r8188eu: change declaration of Efuse_Read1ByteFromFakeContent
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2021 at 13:17, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On Saturday, August 21, 2021 12:56:15 PM CEST Phillip Potter wrote:
> > Remove forward declaration of Efuse_Read1ByteFromFakeContent function
> > from core/rtw_efuse.c, as the function is defined in full directly
> > after this and therefore this forward declaration is redundant.
> >
> > In addition, convert the storage class of the function to static, as the
> > function is only used with rtw_efuse.c, and tidy up the signature
> > alignment.
> >
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >
> > V1: Removed forward declaration.
> > V2: Takes account of feedback from Michael Straube and Fabio M. De
> >     Francesco to make storage class of the function static.
>
> Thanks!
>
> Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>
> Cheers,
>
> Fabio
>
>

Thanks Fabio.

Regards,
Phil
