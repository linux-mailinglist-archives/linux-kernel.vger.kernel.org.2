Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA85419F15
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 21:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbhI0T1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 15:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbhI0T1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 15:27:37 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E52EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:25:59 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so20163314otb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCXAWoe2hPDnl6UuxlpuLdgfQU364PBppRCGEYPmVb0=;
        b=mbGQxRgTqATeGY9NASfmguVg9jvSV3496BTmre+jw8LnT1PyWF8ESk/hhQZxTVuXRx
         RA7MY1ggMsy5TuPRrLIEOz2dvGlIe64Bbnb4wSr5ACfkekarDHL0ivpJsBmEvrtkfI0V
         zphtnmLnFCsr3w2K+6yIkZzaPhCki9gXOQ2fwxoWTu47/duXoQFDKIyVF3RrB2Yki8Pn
         XivF82i72WACsannApXQrVsjOSysc1txsJspoawaGIjVY/+sdyQLwtFX052+DrgaHNrK
         7rEsSsKTQeDygsLqRtt8QIgDYWhWRBSZtaEg7elSQnKC3XWr1Uu8m63RL3JW3BXhnv1X
         nDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCXAWoe2hPDnl6UuxlpuLdgfQU364PBppRCGEYPmVb0=;
        b=FQczppgU76L5SnRrdcbgG8ZgolHr8AaM3/fTdC+BdFmhKFE32BhHZN+kjrz0jnhfRh
         2M/Bqwu2Q6eLqmmRumfkHtcXpWh677UnILvK5mLazSPc1aYGsSGbeLZdFjjcI8bPI3/f
         wsltgN3nkMxgQ2KBtIFbHm7qnnYVAErOg6LCoG6eLep10NJpmTz8xT8/WvwvliIMWrZr
         x+aWjRkS6NmOpZaG7Qgvd+RoGjMYtGU8mYIIha+1RTRvQtVXXgk6peINviRD53bbthCt
         yY0Tbf3YhkU4N9GmrEd5ZWeZ2pemuCGUUJL5S2zlsiXXmv27UhGgyPqMJXqxJx1Pa84a
         tv5w==
X-Gm-Message-State: AOAM5339F+dVCddLvhWVwXmvIXjRac3WbVXp4LUf/3F8E5QNTQ/Xa4e1
        jGSGw9BDzQlkQspsrrV4sVthTqsPJbiJEbilKuE=
X-Google-Smtp-Source: ABdhPJzvL6jbsH32X8drgu7cUpkFkANqhgHe2V/FPLLTmzQetUIWUmnyOAuAliaEv2uj54t9YSXftSws04/L1i21t5s=
X-Received: by 2002:a9d:6d14:: with SMTP id o20mr1475135otp.357.1632770758956;
 Mon, 27 Sep 2021 12:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <1632640580-61609-1-git-send-email-yang.lee@linux.alibaba.com> <CAFeW=pYwkZ8=pVi9f-kHGwr-7Gb2OuWYd=LPzHt+yPWRP_gn8w@mail.gmail.com>
In-Reply-To: <CAFeW=pYwkZ8=pVi9f-kHGwr-7Gb2OuWYd=LPzHt+yPWRP_gn8w@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Sep 2021 15:25:48 -0400
Message-ID: <CADnq5_Oi15o3Ok8rDF19bTi_Nzw2mXaF-+v1oH0Ni4bS8pvfpw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix resource_size.cocci warnings
To:     Amos Jianjun Kong <kongjianjun@gmail.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, Sep 26, 2021 at 3:10 PM Amos Jianjun Kong <kongjianjun@gmail.com> wrote:
>
> On Sun, Sep 26, 2021 at 3:17 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>>
>> Use resource_size function on resource object
>> instead of explicit computation.
>>
>> Clean up coccicheck warning:
>> ./drivers/gpu/drm/amd/amdkfd/kfd_migrate.c:905:10-13: ERROR: Missing
>> resource_size with res
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 4a16e3c..f53e17a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -901,8 +901,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
>>
>>                 /* Disable SVM support capability */
>>                 pgmap->type = 0;
>> -               devm_release_mem_region(adev->dev, res->start,
>> -                                       res->end - res->start + 1);
>> +               devm_release_mem_region(adev->dev, res->start, resource_size(res));
>
>
> Looks good.
> Reviewed-by: Amos Kong <kongjianjun@gmail.com>
>
>
>>
>>                 return PTR_ERR(r);
>>         }
>>
>> --
>> 1.8.3.1
>>
