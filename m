Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05839397E44
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFBBzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhFBBzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:55:10 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D09C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 18:53:28 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so1089520otp.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=808lPJMNU82vuLNkoBWoEKGDD/4g6v7JuN8FunnyIsk=;
        b=VL8wFpkBPgI4HBcqRUWarcnxOsuRa/i+iLDJxEU2m/kLzWfJRuBiF9vbvP1xY6+KDk
         dF+1W4IIpTAW4x/7W4/XYjXti/JMQXXOwnDS9ZdXLCljddZ41Qu4NUS4pgm0ibHSNLIR
         jsT3MtKtL+QPVaqdevbl3XmnzloUdZPPN58t6jNBchRCAPsNfAZs4AayNzxObTOgvRoT
         afPUNCTB6IKen0P2Q+UmgNL31F0NukXEg0+w1w8YF0fJqTHQmn027HEA7PJWWVIDxaaR
         CiExGVD91Q+ps+Pqyf3su39qSXg0j/nEAImxOWGc36HuE/DFshuAWyrAgbAqXNeZ+WCm
         csCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=808lPJMNU82vuLNkoBWoEKGDD/4g6v7JuN8FunnyIsk=;
        b=e79ZCUbqMaBu0ofZRkGk4CvcmcWF/ByxDtwDmngiFmxJcUHprfXZB6Dwc0BB+PHjtq
         qg4LCb+lzsozK6rMAmoA1DV7tTyVk0g5vljntooBvuaVabu2/47VKWFKeBKODyz0+r9a
         Gzs1vU7US6jPa8C8a6ajEnyARtBYST9NTe2kE9eyQQsiLbKH4J8vAOxmrDqX3HpE7v0g
         LQMr0XyUIqm9wNkF4lZPU+b/UysMXOg9UE2RrhV7SLG8LK2I2RqwjjMEbBcwBZU5LZRW
         lsiFPL1Od7QIDpzGHWblnQ2RO6r8oKmoDKLF9rW9wOQBIdaJchjh069Rt9oNLYsE/9br
         yMFA==
X-Gm-Message-State: AOAM533Fe2ZW62zQWHO2WO+GtSFS2THA1hcsX78cCqegJrUe85ATzKap
        Eytpe3SZ5mMfmX+8BJLNpqM4UlmulSBWo5hscmY=
X-Google-Smtp-Source: ABdhPJz8yiekIq60HpZI8GZkZq5YHICKRQnCgncgu6RV2PrJA7tU6O32SuN5NUgI3LiNfC/UmkuhLRYqjG/iPOCN3jY=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr24871519otl.132.1622598803212;
 Tue, 01 Jun 2021 18:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210528070217.9204-1-yuehaibing@huawei.com>
In-Reply-To: <20210528070217.9204-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Jun 2021 21:53:12 -0400
Message-ID: <CADnq5_M2dSDqafpgEvuaRZRHk1j0=obTyYcYX0GGRGiBzs5eMQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/radeon/radeon_pm: use DEVICE_ATTR_RW macro
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 3:18 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Use DEVICE_ATTR_RW() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I'm not convinced this really buys us anything other than code churn,
but I don't have a particularly strong opinion of others feel
differently.

Alex


> ---
>  drivers/gpu/drm/radeon/radeon_pm.c | 56 ++++++++++++------------------
>  1 file changed, 23 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
> index 3861c0b98fcf..edf10cc3947e 100644
> --- a/drivers/gpu/drm/radeon/radeon_pm.c
> +++ b/drivers/gpu/drm/radeon/radeon_pm.c
> @@ -352,9 +352,8 @@ static void radeon_pm_print_states(struct radeon_device *rdev)
>         }
>  }
>
> -static ssize_t radeon_get_pm_profile(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    char *buf)
> +static ssize_t power_profile_show(struct device *dev,
> +                                 struct device_attribute *attr, char *buf)
>  {
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct radeon_device *rdev = ddev->dev_private;
> @@ -366,10 +365,8 @@ static ssize_t radeon_get_pm_profile(struct device *dev,
>                           (cp == PM_PROFILE_HIGH) ? "high" : "default");
>  }
>
> -static ssize_t radeon_set_pm_profile(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    const char *buf,
> -                                    size_t count)
> +static ssize_t power_profile_store(struct device *dev, struct device_attribute *attr,
> +                                  const char *buf, size_t count)
>  {
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct radeon_device *rdev = ddev->dev_private;
> @@ -406,9 +403,8 @@ static ssize_t radeon_set_pm_profile(struct device *dev,
>         return count;
>  }
>
> -static ssize_t radeon_get_pm_method(struct device *dev,
> -                                   struct device_attribute *attr,
> -                                   char *buf)
> +static ssize_t power_method_show(struct device *dev,
> +                                struct device_attribute *attr, char *buf)
>  {
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct radeon_device *rdev = ddev->dev_private;
> @@ -418,10 +414,9 @@ static ssize_t radeon_get_pm_method(struct device *dev,
>                           (pm == PM_METHOD_PROFILE) ? "profile" : "dpm");
>  }
>
> -static ssize_t radeon_set_pm_method(struct device *dev,
> -                                   struct device_attribute *attr,
> -                                   const char *buf,
> -                                   size_t count)
> +static ssize_t power_method_store(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 const char *buf, size_t count)
>  {
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct radeon_device *rdev = ddev->dev_private;
> @@ -462,9 +457,8 @@ static ssize_t radeon_set_pm_method(struct device *dev,
>         return count;
>  }
>
> -static ssize_t radeon_get_dpm_state(struct device *dev,
> -                                   struct device_attribute *attr,
> -                                   char *buf)
> +static ssize_t power_dpm_state_show(struct device *dev,
> +                                   struct device_attribute *attr, char *buf)
>  {
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct radeon_device *rdev = ddev->dev_private;
> @@ -475,10 +469,9 @@ static ssize_t radeon_get_dpm_state(struct device *dev,
>                           (pm == POWER_STATE_TYPE_BALANCED) ? "balanced" : "performance");
>  }
>
> -static ssize_t radeon_set_dpm_state(struct device *dev,
> -                                   struct device_attribute *attr,
> -                                   const char *buf,
> -                                   size_t count)
> +static ssize_t power_dpm_state_store(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    const char *buf, size_t count)
>  {
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct radeon_device *rdev = ddev->dev_private;
> @@ -506,9 +499,9 @@ static ssize_t radeon_set_dpm_state(struct device *dev,
>         return count;
>  }
>
> -static ssize_t radeon_get_dpm_forced_performance_level(struct device *dev,
> -                                                      struct device_attribute *attr,
> -                                                      char *buf)
> +static ssize_t power_dpm_force_performance_level_show(struct device *dev,
> +                                                     struct device_attribute *attr,
> +                                                     char *buf)
>  {
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct radeon_device *rdev = ddev->dev_private;
> @@ -523,10 +516,9 @@ static ssize_t radeon_get_dpm_forced_performance_level(struct device *dev,
>                           (level == RADEON_DPM_FORCED_LEVEL_LOW) ? "low" : "high");
>  }
>
> -static ssize_t radeon_set_dpm_forced_performance_level(struct device *dev,
> +static ssize_t power_dpm_force_performance_level_store(struct device *dev,
>                                                        struct device_attribute *attr,
> -                                                      const char *buf,
> -                                                      size_t count)
> +                                                      const char *buf, size_t count)
>  {
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct radeon_device *rdev = ddev->dev_private;
> @@ -658,12 +650,10 @@ static ssize_t radeon_hwmon_get_pwm1(struct device *dev,
>         return sprintf(buf, "%i\n", speed);
>  }
>
> -static DEVICE_ATTR(power_profile, S_IRUGO | S_IWUSR, radeon_get_pm_profile, radeon_set_pm_profile);
> -static DEVICE_ATTR(power_method, S_IRUGO | S_IWUSR, radeon_get_pm_method, radeon_set_pm_method);
> -static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR, radeon_get_dpm_state, radeon_set_dpm_state);
> -static DEVICE_ATTR(power_dpm_force_performance_level, S_IRUGO | S_IWUSR,
> -                  radeon_get_dpm_forced_performance_level,
> -                  radeon_set_dpm_forced_performance_level);
> +static DEVICE_ATTR_RW(power_profile);
> +static DEVICE_ATTR_RW(power_method);
> +static DEVICE_ATTR_RW(power_dpm_state);
> +static DEVICE_ATTR_RW(power_dpm_force_performance_level);
>
>  static ssize_t radeon_hwmon_show_temp(struct device *dev,
>                                       struct device_attribute *attr,
> --
> 2.17.1
>
