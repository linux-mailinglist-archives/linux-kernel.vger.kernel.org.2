Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01183893F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355337AbhESQlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355170AbhESQlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:41:52 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BDBC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:40:31 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso3139012oow.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zNCfFA3iTUAR7nfw2vDgYPSNzR16vnK0bYbOgvyHvMI=;
        b=ElwNI54ICQy3kLGRhcPRnjiEVKd3grPlIaCHCbVvlnT7UyBehL+duguyaJuDEGeNla
         LIdGAtPIvVlErfA8WvAp5FJCC1FFRQt4/WlVJTp+Pcoiqg/57+940JXyVdZuB3a7iq2L
         NYwE0kpUTx16BXX+vhmGwwPtFTiQiM+Pvd23jNVrj7OWYXvkP4vzj3xXV2BWXLBhQEJk
         N94EiZmPdTZNWD9NgsXHy9t0wyAPIjVJfY6UH9Ytw+qWHWgABlkV0tfKGImOI5juAq+K
         1wljiSP3B0bzUNflsGoTfpCOITy/YKmiw5Z4UgEjl2iPk7QSQD9jjDv7zhUQ248Kpizr
         7Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zNCfFA3iTUAR7nfw2vDgYPSNzR16vnK0bYbOgvyHvMI=;
        b=EhMtgOAP4tDZa9vEolInTypRrONv/v8An37CjyKQBFS5cFlcbd6v45nDCSX8UHGj/Q
         0nkIRUKQrGrDQRglbYnTGZIP3CEHOsAXz4S2cF6aTZ7udFWb6zqcJveEzi9LPCVjHe75
         Q6Suj+R5r8e9nkOtPq8PqUHPmr2ExXQ/IEjRhwnd1pSZtFhSjVtHyoDtiHmElUj9mbuS
         wG2bxOp+SHIyHoCu2pPVWWgeLO0UV/h6kdjX/uYrUpBkYxmUHn0GI63tbYZQCVPzpEfN
         zMSJ9UgOdKM1rEoY2QiqhmaGHGZRpj+vhZCXt84yBJC/ZBNWDIigyqFZrUnJ1zmOpCOH
         oJqw==
X-Gm-Message-State: AOAM531fzHnKJA+AEx/LVo4v0M04oxdQY0VwGgtfuDRN5V/IZ8bFaBTL
        Rr1GZeKzN5kerFfy4GJjUmHycy46s77Zi/m/Dt8=
X-Google-Smtp-Source: ABdhPJw+067c2L/99GOWZARWXw0ORPgXXpEmAbt8nOwAFfgxloS+AgmpmBOVRQ9uXbAXbjRbOfYF6KedqOaKfQta3Fk=
X-Received: by 2002:a4a:d085:: with SMTP id i5mr142853oor.61.1621442431315;
 Wed, 19 May 2021 09:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <e606930c73029f16673849c57acac061dd923866.1621412009.git.mchehab+huawei@kernel.org>
 <f0589aff-a776-0715-e421-0d9a8cf2cc25@infradead.org>
In-Reply-To: <f0589aff-a776-0715-e421-0d9a8cf2cc25@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 19 May 2021 12:40:19 -0400
Message-ID: <CADnq5_OjJTfwhbEBMFoM-zux8CPDgQhi_6FHpcFYVXYn+CZR7w@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpu: drm: replace occurrences of invalid character
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pushed out to drm-misc-next.  Also fixed up Michel's name.

Alex

On Wed, May 19, 2021 at 11:56 AM Randy Dunlap <rdunlap@infradead.org> wrote=
:
>
> On 5/19/21 1:15 AM, Mauro Carvalho Chehab wrote:
> > There are some places at drm that ended receiving a
> > REPLACEMENT CHARACTER U+fffd ('=EF=BF=BD'), probably because of
> > some bad charset conversion.
> >
> > Fix them by using what it seems       to be the proper
> > character.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thanks.
>
> > ---
> >  drivers/gpu/drm/amd/include/atombios.h       | 10 +++++-----
> >  drivers/gpu/drm/i915/gt/intel_gpu_commands.h |  2 +-
> >  drivers/gpu/drm/i915/i915_gpu_error.h        |  2 +-
> >  drivers/gpu/drm/r128/r128_drv.h              |  2 +-
> >  4 files changed, 8 insertions(+), 8 deletions(-)
> >
>
> --
> ~Randy
>
