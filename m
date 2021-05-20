Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B392038B73F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbhETTUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbhETTUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:20:12 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4305CC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:18:51 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso15891181ote.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k4cJT0t0XqH8XRsIxYqfk56ojXIbxXc2e35W87HcykQ=;
        b=qHh6R09e+J7BzRLsfIkrZMaQF90Gh7tDIXX+qeJYMxDO8auMYJ3XchSJ7PZTfNmgWB
         mzdqLCK4X8jPmwYddiEy/c17ZzX1r6f52WgqcYNpLxnre/4+n7JnLiIOGg6b342lwt/M
         RMLeDi31SjXNTCrr6jKqvsRm/x5lldWcKuzMftPWdqjw/DxJXlp2foLpm/nsqPOZEaPL
         tG0Kj7P+apd+zhYkpPBZz2ka2jU8ZlGEAWURsAH/mXDIRhDNGNMjfR4fAqeQu5dn3be+
         oz1NzWMfb2KNeLNLqypWB5HL77m5jsBd9OCSBbSEzWg2b33NwDdr/lM9Kojo91N+3WDr
         oNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k4cJT0t0XqH8XRsIxYqfk56ojXIbxXc2e35W87HcykQ=;
        b=Cv/uFYDfUHIOl8EM6rZQ+Y+a3lWb1PQ/vrsKRqA6PjKNlgvw7auZ9xBSk3UbjpO5tJ
         4uE0KxvIf/4AxyigUtfeAXMLfZxMxOCCcpF6bmCqLUUFVg5WMFhy7zbxG1UoWqD4VwVB
         094w1a3V7bCMOMLPRTWZVMnwhINhPC2tfuj4Cfg3nGCWlKuTUZESFLXWPYP6UUIw9vcO
         IJtNCxhioeJ5o3cgH62PgtCYPD2oiU71z0QcH5ADIImYjj2n+DSInMoFfzzz4ln+DNXG
         pNwlmuBtjCNNApQauMUB6+I/qOSY847xJ/Rj6wcsc762zo2h0yvJ0MwTYbnjBNyoLKkp
         J43Q==
X-Gm-Message-State: AOAM531dnjR6KS5RF6oEDf33IZ9ly4c1uEmTmqN8Robl7CzK7yu5zY+4
        xh3ENeJx8X3HrBG1RZsjjpjiQTlKW5pH6BSSb60=
X-Google-Smtp-Source: ABdhPJwbhch6P7kEoQ/7IE2/9EGX+cfUBP3J4UMXaGAyK0/P18gcZ6qVrnDYx1H+9tG35FMsygm5TBUusV0zgaq6Cpo=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr5113995oti.23.1621538330703;
 Thu, 20 May 2021 12:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org> <20210520120248.3464013-24-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-24-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 May 2021 15:18:39 -0400
Message-ID: <CADnq5_M0=6O3jzTZ-fwbwf4fnJM3YzyodsH0_56Kj7vSt1JZ5Q@mail.gmail.com>
Subject: Re: [PATCH 23/38] drm/amd/amdgpu/gmc_v7_0: Fix potential copy/paste issue
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, May 20, 2021 at 8:03 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:526: warning: expecting prototype =
for gmc_v8_0_set_fault_enable_default(). Prototype was for gmc_v7_0_set_fau=
lt_enable_default() instead
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index 210ada2289ec9..8e282169f99eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -516,7 +516,7 @@ static void gmc_v7_0_get_vm_pte(struct amdgpu_device =
*adev,
>  }
>
>  /**
> - * gmc_v8_0_set_fault_enable_default - update VM fault handling
> + * gmc_v7_0_set_fault_enable_default - update VM fault handling
>   *
>   * @adev: amdgpu_device pointer
>   * @value: true redirects VM faults to the default page
> --
> 2.31.1
>
