Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1D435760E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhDGUaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhDGUaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:30:23 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFFBC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 13:30:13 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so95347otr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0zVNamgByzrKgHQJQ1E/Ox4qjmJ5yCG4cN84GcuExg=;
        b=GB3IdDFfuL7IVsdVzsZioMKHezjmPR3MpYEKg8qtnIneBZpAek7lyPcYPBjvRtH9GQ
         lFHZXpsh7miaXYGuwdQ6XXXGxvd+jsw+b04xY6WnuRy+fpehpwZVtu6pcJwxFHvDiFFZ
         uwqDwvUlEwz8wTsQncEsSIga7Kw16BBIVBpVW24xqNbfbuo7Teg56nhUQaWcDWZ1qcsx
         Gnpc2VSpfyIR10dFKUuX+nIczBX2wf/AZtMZS94RAKYEuFa84ChWSdtXheFHCTur96iL
         jh+kyRbs89NfjMVKjWInufia3QDtanJ2f+KFAwa7lcM6Last7vpMwVpSJRQoScpCAzGS
         ZbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0zVNamgByzrKgHQJQ1E/Ox4qjmJ5yCG4cN84GcuExg=;
        b=m2L5G/kgG6MMJaP0wRIeSpRRhDVlJRUcQEBCpypijCbhTfOLCWTH0dNZE3A9+R/FuK
         bNUGjIpP5e6yvdnYFtelC3QOsL9rswFbmp3doQsL2Rtr6T8JzzCJyIO+XLLg7YZCr5a5
         Wn2dFD9WwBbWmNXyRk/j2OUM77eW/KDSIHjNPGkuEUsHlu8owpeqFJ97g8IG+rM8x/+h
         CZVQFajY8s8en9Tw0VYmDTILzIzsEI5PdOiArl+HZqSki23HA9OTJa7xs3T9dT/JMx7M
         iwl8oAKAmkVjKkL5J1v2HxtFaj2RaBL4gb0pxRIx1ElWMqrqwwNxmdhM5lDGYPCXDbSP
         h92g==
X-Gm-Message-State: AOAM532r1P97Pp8hwv9SaQm8LuAPRC9fBfiTlY/bdaucBbzPgnkICCfA
        Dce3jlg+yOl6e2qYcnHiE53Noh5oGpk8jqmgOtQ=
X-Google-Smtp-Source: ABdhPJwPprBkjycyR6AGAyH9zvzdnKvkOy+VtZ4WqchAmmUs+Rjn3kqJOg4gn86Y+cm3LLOf8jy5t48A6++btUC5ThY=
X-Received: by 2002:a9d:663:: with SMTP id 90mr4454385otn.311.1617827412358;
 Wed, 07 Apr 2021 13:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210406141148.64795-1-llyz108@163.com>
In-Reply-To: <20210406141148.64795-1-llyz108@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 7 Apr 2021 16:30:01 -0400
Message-ID: <CADnq5_OYk1pBSG4PRqe+RZYtHyy-eYGYBn1=SM_tVLA_4tzK=A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: convert sysfs snprintf to sysfs_emit
To:     Carlis <llyz108@163.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Huang Rui <ray.huang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Xuezhi Zhang <zhangxuezhi1@yulong.com>,
        "Quan, Evan" <evan.quan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 10:13 AM Carlis <llyz108@163.com> wrote:
>
> From: Xuezhi Zhang <zhangxuezhi1@yulong.com>
>
> Fix the following coccicheck warning:
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:1940:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:1978:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2022:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:294:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:154:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:496:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:512:9-17:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:1740:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:1667:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2074:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2047:9-17:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2768:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2738:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2442:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3246:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3253:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2458:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3047:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3133:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3209:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3216:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2410:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2496:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2470:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2426:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2965:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2972:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3006:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3013:8-16:
> WARNING: use scnprintf or sprintf
>
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>

I already applied a similar patch last week.

Thanks,

Alex


> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 58 +++++++++++++++---------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 5fa65f191a37..2777966ec1ca 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -151,7 +151,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>         pm_runtime_mark_last_busy(ddev->dev);
>         pm_runtime_put_autosuspend(ddev->dev);
>
> -       return snprintf(buf, PAGE_SIZE, "%s\n",
> +       return sysfs_emit(buf, "%s\n",
>                         (pm == POWER_STATE_TYPE_BATTERY) ? "battery" :
>                         (pm == POWER_STATE_TYPE_BALANCED) ? "balanced" : "performance");
>  }
> @@ -291,7 +291,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>         pm_runtime_mark_last_busy(ddev->dev);
>         pm_runtime_put_autosuspend(ddev->dev);
>
> -       return snprintf(buf, PAGE_SIZE, "%s\n",
> +       return sysfs_emit(buf, "%s\n",
>                         (level == AMD_DPM_FORCED_LEVEL_AUTO) ? "auto" :
>                         (level == AMD_DPM_FORCED_LEVEL_LOW) ? "low" :
>                         (level == AMD_DPM_FORCED_LEVEL_HIGH) ? "high" :
> @@ -493,7 +493,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>         if (i == data.nums)
>                 i = -EINVAL;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", i);
> +       return sysfs_emit(buf, "%d\n", i);
>  }
>
>  static ssize_t amdgpu_get_pp_force_state(struct device *dev,
> @@ -509,7 +509,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
>         if (adev->pp_force_state_enabled)
>                 return amdgpu_get_pp_cur_state(dev, attr, buf);
>         else
> -               return snprintf(buf, PAGE_SIZE, "\n");
> +               return sysfs_emit(buf, "\n");
>  }
>
>  static ssize_t amdgpu_set_pp_force_state(struct device *dev,
> @@ -1664,7 +1664,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>         pm_runtime_mark_last_busy(ddev->dev);
>         pm_runtime_put_autosuspend(ddev->dev);
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", value);
> +       return sysfs_emit(buf, "%d\n", value);
>  }
>
>  static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
> @@ -1737,7 +1737,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>         pm_runtime_mark_last_busy(ddev->dev);
>         pm_runtime_put_autosuspend(ddev->dev);
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", value);
> +       return sysfs_emit(buf, "%d\n", value);
>  }
>
>  static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
> @@ -1937,7 +1937,7 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
>         if (r)
>                 return r;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", value);
> +       return sysfs_emit(buf, "%d\n", value);
>  }
>
>  /**
> @@ -1975,7 +1975,7 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
>         if (r)
>                 return r;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", value);
> +       return sysfs_emit(buf, "%d\n", value);
>  }
>
>  /**
> @@ -2019,7 +2019,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>         pm_runtime_mark_last_busy(ddev->dev);
>         pm_runtime_put_autosuspend(ddev->dev);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu %llu %i\n",
> +       return sysfs_emit(buf,  "%llu %llu %i\n",
>                         count0, count1, pcie_get_mps(adev->pdev));
>  }
>
> @@ -2044,7 +2044,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
>                 return -EPERM;
>
>         if (adev->unique_id)
> -               return snprintf(buf, PAGE_SIZE, "%016llx\n", adev->unique_id);
> +               return sysfs_emit(buf, "%016llx\n", adev->unique_id);
>
>         return 0;
>  }
> @@ -2071,7 +2071,7 @@ static ssize_t amdgpu_get_thermal_throttling_logging(struct device *dev,
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = drm_to_adev(ddev);
>
> -       return snprintf(buf, PAGE_SIZE, "%s: thermal throttling logging %s, with interval %d seconds\n",
> +       return sysfs_emit(buf, "%s: thermal throttling logging %s, with interval %d seconds\n",
>                         adev_to_drm(adev)->unique,
>                         atomic_read(&adev->throttling_logging_enabled) ? "enabled" : "disabled",
>                         adev->throttling_logging_rs.interval / HZ + 1);
> @@ -2407,7 +2407,7 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
>         if (r)
>                 return r;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> +       return sysfs_emit(buf, "%d\n", temp);
>  }
>
>  static ssize_t amdgpu_hwmon_show_temp_thresh(struct device *dev,
> @@ -2423,7 +2423,7 @@ static ssize_t amdgpu_hwmon_show_temp_thresh(struct device *dev,
>         else
>                 temp = adev->pm.dpm.thermal.max_temp;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> +       return sysfs_emit(buf, "%d\n", temp);
>  }
>
>  static ssize_t amdgpu_hwmon_show_hotspot_temp_thresh(struct device *dev,
> @@ -2439,7 +2439,7 @@ static ssize_t amdgpu_hwmon_show_hotspot_temp_thresh(struct device *dev,
>         else
>                 temp = adev->pm.dpm.thermal.max_hotspot_crit_temp;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> +       return sysfs_emit(buf, "%d\n", temp);
>  }
>
>  static ssize_t amdgpu_hwmon_show_mem_temp_thresh(struct device *dev,
> @@ -2455,7 +2455,7 @@ static ssize_t amdgpu_hwmon_show_mem_temp_thresh(struct device *dev,
>         else
>                 temp = adev->pm.dpm.thermal.max_mem_crit_temp;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> +       return sysfs_emit(buf, "%d\n", temp);
>  }
>
>  static ssize_t amdgpu_hwmon_show_temp_label(struct device *dev,
> @@ -2467,7 +2467,7 @@ static ssize_t amdgpu_hwmon_show_temp_label(struct device *dev,
>         if (channel >= PP_TEMP_MAX)
>                 return -EINVAL;
>
> -       return snprintf(buf, PAGE_SIZE, "%s\n", temp_label[channel].label);
> +       return sysfs_emit(buf, "%s\n", temp_label[channel].label);
>  }
>
>  static ssize_t amdgpu_hwmon_show_temp_emergency(struct device *dev,
> @@ -2493,7 +2493,7 @@ static ssize_t amdgpu_hwmon_show_temp_emergency(struct device *dev,
>                 break;
>         }
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> +       return sysfs_emit(buf, "%d\n", temp);
>  }
>
>  static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
> @@ -2735,7 +2735,7 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
>         if (r)
>                 return r;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", min_rpm);
> +       return sysfs_emit(buf, "%d\n", min_rpm);
>  }
>
>  static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
> @@ -2765,7 +2765,7 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
>         if (r)
>                 return r;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", max_rpm);
> +       return sysfs_emit(buf, "%d\n", max_rpm);
>  }
>
>  static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
> @@ -2962,14 +2962,14 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
>         if (r)
>                 return r;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", vddgfx);
> +       return sysfs_emit(buf, "%d\n", vddgfx);
>  }
>
>  static ssize_t amdgpu_hwmon_show_vddgfx_label(struct device *dev,
>                                               struct device_attribute *attr,
>                                               char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "vddgfx\n");
> +       return sysfs_emit(buf, "vddgfx\n");
>  }
>
>  static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
> @@ -3003,14 +3003,14 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
>         if (r)
>                 return r;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", vddnb);
> +       return sysfs_emit(buf, "%d\n", vddnb);
>  }
>
>  static ssize_t amdgpu_hwmon_show_vddnb_label(struct device *dev,
>                                               struct device_attribute *attr,
>                                               char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "vddnb\n");
> +       return sysfs_emit(buf, "vddnb\n");
>  }
>
>  static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
> @@ -3044,7 +3044,7 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
>         /* convert to microwatts */
>         uw = (query >> 8) * 1000000 + (query & 0xff) * 1000;
>
> -       return snprintf(buf, PAGE_SIZE, "%u\n", uw);
> +       return sysfs_emit(buf, "%u\n", uw);
>  }
>
>  static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
> @@ -3130,7 +3130,7 @@ static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
>  {
>         int limit_type = to_sensor_dev_attr(attr)->index;
>
> -       return snprintf(buf, PAGE_SIZE, "%s\n",
> +       return sysfs_emit(buf, "%s\n",
>                 limit_type == SMU_FAST_PPT_LIMIT ? "fastPPT" : "slowPPT");
>  }
>
> @@ -3206,14 +3206,14 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
>         if (r)
>                 return r;
>
> -       return snprintf(buf, PAGE_SIZE, "%u\n", sclk * 10 * 1000);
> +       return sysfs_emit(buf, "%u\n", sclk * 10 * 1000);
>  }
>
>  static ssize_t amdgpu_hwmon_show_sclk_label(struct device *dev,
>                                             struct device_attribute *attr,
>                                             char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "sclk\n");
> +       return sysfs_emit(buf, "sclk\n");
>  }
>
>  static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
> @@ -3243,14 +3243,14 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
>         if (r)
>                 return r;
>
> -       return snprintf(buf, PAGE_SIZE, "%u\n", mclk * 10 * 1000);
> +       return sysfs_emit(buf, "%u\n", mclk * 10 * 1000);
>  }
>
>  static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
>                                             struct device_attribute *attr,
>                                             char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "mclk\n");
> +       return sysfs_emit(buf, "mclk\n");
>  }
>
>  /**
> --
> 2.25.1
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
