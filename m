Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CECF36A087
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhDXJ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhDXJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:28:29 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777CFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:27:51 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id d25so19184121vsp.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlGWPl25FCa96zci06+ZWbGtm3tUuzzsH67YozYxWGE=;
        b=sTf+76tWRNc4bSEDLdNAg0wexuK5dsnVUl1FWko6IsXWXz/k/VwT0CaZf0e8mls9yX
         vu1RB8IyOarHBHxpzItwynwKzCbzaS/+MMT0KRiBZ4rA9605WPwZXHYHgDe2k2FM09bp
         CQSd3E0bqSC5dT8cBVIvvaqyKr1+Oh1dB/0gHOlSeDAKII+SYBYSPnbpJPId9kXMYaFI
         c+kLweW2xBC/8F4ZmsxPywClM4LWKtZjjikKmFAEF4k0AFqs2/8c3Fxh+xnDKHyL1SvO
         aIp4bkXU6+SNL+jFNhEFUDMeX31he7KDwDtASt+FhQfviO6tbx9s2pm+MPI7iRjsI55U
         vybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlGWPl25FCa96zci06+ZWbGtm3tUuzzsH67YozYxWGE=;
        b=JRjZ4FMB2fIZ26dRbuY4GVbJ76luakWPAgxK4yMuJ4EEEl4qFG9452Rld9k1oZ852D
         NyOPsLRxdWSG0uctqjj6eGk7/I8U7EsmU9S1cM+FwHWdFEsBKw8rnD7nCE7uJn7qUyH/
         yQcjxJN1mURhbsm7Zd8iAoTWWW2ENMIswNYhdY4bPimkb0G2itEH3b+jBqCbQLLtfvUs
         hs2LmwD/tEEeCf4wejDFAQaEhYSFLsJX8nAndF0rU66kPIhjxO6PFuYjtBYf5PZg3PPo
         npgXPu1bj3zh//CtAbex1VeMTrH1RivSwII04K6643XSqkmbuC4RaSfCNouUXuc1rCv4
         AxQQ==
X-Gm-Message-State: AOAM533mCM7K8zPJKJpLGaRGuj3rUPQBcWI9veoJVSC/YPaR42WwUd/2
        +ds3pTKoaxF9uQ5oIefjrin9s3U9Rjf9+1aDOc03Rh7DR/o=
X-Google-Smtp-Source: ABdhPJzewChMoUIj259gk1Tr7mqAnTRL0xv0ExATevzweUjTPS5Pzj3bXAxO4wZu56lswZD7wmGZZCObG+AIzQh6yKo=
X-Received: by 2002:a05:6102:322f:: with SMTP id x15mr6785842vsf.9.1619256470690;
 Sat, 24 Apr 2021 02:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <1619213997-5475-1-git-send-email-jrdr.linux@gmail.com> <da39ded9-7222-8530-2388-aef3879d1ca3@amd.com>
In-Reply-To: <da39ded9-7222-8530-2388-aef3879d1ca3@amd.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 24 Apr 2021 14:57:39 +0530
Message-ID: <CAFqt6zbnK6xVvsy5F7ZbOfKhQhfUnv5tPwp+d-_rwxK6TnJUhQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Added missing prototype
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>, evan.quan@amd.com,
        Dennis.Li@amd.com, Luben Tuikov <luben.tuikov@amd.com>,
        jonathan.kim@amd.com, dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 5:03 AM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2021-04-23 um 5:39 p.m. schrieb Souptick Joarder:
> > Kernel test robot throws below warning ->
> >
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:125:5: warning:
> >>> no previous prototype for 'kgd_arcturus_hqd_sdma_load'
> >>> [-Wmissing-prototypes]
> >      125 | int kgd_arcturus_hqd_sdma_load(struct kgd_dev *kgd, void
> > *mqd,
> >
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:227:6: warning:
> >>> no previous prototype for 'kgd_arcturus_hqd_sdma_is_occupied'
> >>> [-Wmissing-prototypes]
> >      227 | bool kgd_arcturus_hqd_sdma_is_occupied(struct kgd_dev *kgd,
> > void *mqd)
> >          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:246:5: warning:
> >>> no previous prototype for 'kgd_arcturus_hqd_sdma_destroy'
> >>> [-Wmissing-prototypes]
> >      246 | int kgd_arcturus_hqd_sdma_destroy(struct kgd_dev *kgd, void
> > *mqd,
> >          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Added prototype for these functions.
> The prototypes are already defined in amdgpu_amdkfd_arcturus.h. I think
> we just need to add a #include in amdgpu_amdkfd_arcturus.c.
>

Right. I missed that file. Will send v2.

> Regards,
>   Felix
>
>
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index dc3a692..8fff0e7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -316,6 +316,11 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
> >                                  enum amd_ip_block_type block_type);
> >  bool amdgpu_device_ip_is_idle(struct amdgpu_device *adev,
> >                             enum amd_ip_block_type block_type);
> > +int kgd_arcturus_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
> > +                             uint32_t __user *wptr, struct mm_struct *mm);
> > +bool kgd_arcturus_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd);
> > +int kgd_arcturus_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
> > +                                     unsigned int utimeout);
> >
> >  #define AMDGPU_MAX_IP_NUM 16
> >
