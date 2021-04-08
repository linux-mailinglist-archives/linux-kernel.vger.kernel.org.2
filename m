Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16B9357C0A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhDHF6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:58:12 -0400
Received: from m12-14.163.com ([220.181.12.14]:48245 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhDHF6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=D0/8i
        vkIdl9CSs7eo0BPYXmouHeJyBCfeSBdzmU3usM=; b=IYvLCVnUTf7e+Sjt2ooPq
        /oZW/iGQ/w/HTcQ1z9CwWhY78HUJX/fFH2DUhbWR36vpxqHF7WithIlfHqWaSl6O
        JnGMF+xHgy+6CJceHCsGsvlXcmShe65tDymC8TwPGhIOclsURo4C+oGANdxoeI9A
        rkvfFdK99Fu2IPluVtsrVE=
Received: from carlis (unknown [119.137.53.45])
        by smtp10 (Coremail) with SMTP id DsCowACXr08km25g2l11CQ--.8298S2;
        Thu, 08 Apr 2021 13:56:53 +0800 (CST)
Date:   Thu, 8 Apr 2021 05:56:52 +0000
From:   Carlis <llyz108@163.com>
To:     Alex Deucher <alexdeucher@gmail.com>
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
Subject: Re: [PATCH] drm/amd/pm: convert sysfs snprintf to sysfs_emit
Message-ID: <20210408055652.7e565289@carlis>
In-Reply-To: <CADnq5_OYk1pBSG4PRqe+RZYtHyy-eYGYBn1=SM_tVLA_4tzK=A@mail.gmail.com>
References: <20210406141148.64795-1-llyz108@163.com>
        <CADnq5_OYk1pBSG4PRqe+RZYtHyy-eYGYBn1=SM_tVLA_4tzK=A@mail.gmail.com>
Organization: yulong
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DsCowACXr08km25g2l11CQ--.8298S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3CF1UGrW5WF1xuw17XrWDJwb_yoW8JFWDJo
        Wfur1fXFWxGF1jyrn8Z3y7tasIqa48C3s3Cry5Kr4DGa97t3WFyr43JFs5Za1YgFWrWF48
        Cr13tan5XFW7Wa4rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwrcfUUUUU
X-Originating-IP: [119.137.53.45]
X-CM-SenderInfo: xoo16iiqy6il2tof0z/xtbBIg1uhV3l-HlsFAAAsB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 16:30:01 -0400
Alex Deucher <alexdeucher@gmail.com> wrote:

> On Tue, Apr 6, 2021 at 10:13 AM Carlis <llyz108@163.com> wrote:
> >
> > From: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> >
> > Fix the following coccicheck warning:
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:1940:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:1978:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2022:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:294:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:154:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:496:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:512:9-17:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:1740:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:1667:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2074:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2047:9-17:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2768:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2738:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2442:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:3246:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:3253:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2458:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:3047:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:3133:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:3209:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:3216:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2410:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2496:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2470:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2426:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2965:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:2972:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:3006:8-16:
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm/amd/pm//amdgpu_pm.c:3013:8-16:
> > WARNING: use scnprintf or sprintf
> >
> > Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>  
> 
> I already applied a similar patch last week.
> 
> Thanks,
> 
> Alex
> 
OK.
Thanks,

Xuezhi Zhang
> 
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 58
> > +++++++++++++++--------------- 1 file changed, 29 insertions(+), 29
> > deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_pm.c index
> > 5fa65f191a37..2777966ec1ca 100644 ---
> > a/drivers/gpu/drm/amd/pm/amdgpu_pm.c +++
> > b/drivers/gpu/drm/amd/pm/amdgpu_pm.c @@ -151,7 +151,7 @@ static
> > ssize_t amdgpu_get_power_dpm_state(struct device *dev,
> > pm_runtime_mark_last_busy(ddev->dev);
> > pm_runtime_put_autosuspend(ddev->dev);
> >
> > -       return snprintf(buf, PAGE_SIZE, "%s\n",
> > +       return sysfs_emit(buf, "%s\n",
> >                         (pm == POWER_STATE_TYPE_BATTERY) ?
> > "battery" : (pm == POWER_STATE_TYPE_BALANCED) ? "balanced" :
> > "performance"); }
> > @@ -291,7 +291,7 @@ static ssize_t
> > amdgpu_get_power_dpm_force_performance_level(struct device *dev,
> > pm_runtime_mark_last_busy(ddev->dev);
> > pm_runtime_put_autosuspend(ddev->dev);
> >
> > -       return snprintf(buf, PAGE_SIZE, "%s\n",
> > +       return sysfs_emit(buf, "%s\n",
> >                         (level == AMD_DPM_FORCED_LEVEL_AUTO) ?
> > "auto" : (level == AMD_DPM_FORCED_LEVEL_LOW) ? "low" :
> >                         (level == AMD_DPM_FORCED_LEVEL_HIGH) ?
> > "high" : @@ -493,7 +493,7 @@ static ssize_t
> > amdgpu_get_pp_cur_state(struct device *dev, if (i == data.nums)
> >                 i = -EINVAL;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", i);
> > +       return sysfs_emit(buf, "%d\n", i);
> >  }
> >
> >  static ssize_t amdgpu_get_pp_force_state(struct device *dev,
> > @@ -509,7 +509,7 @@ static ssize_t amdgpu_get_pp_force_state(struct
> > device *dev, if (adev->pp_force_state_enabled)
> >                 return amdgpu_get_pp_cur_state(dev, attr, buf);
> >         else
> > -               return snprintf(buf, PAGE_SIZE, "\n");
> > +               return sysfs_emit(buf, "\n");
> >  }
> >
> >  static ssize_t amdgpu_set_pp_force_state(struct device *dev,
> > @@ -1664,7 +1664,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct
> > device *dev, pm_runtime_mark_last_busy(ddev->dev);
> >         pm_runtime_put_autosuspend(ddev->dev);
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", value);
> > +       return sysfs_emit(buf, "%d\n", value);
> >  }
> >
> >  static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
> > @@ -1737,7 +1737,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct
> > device *dev, pm_runtime_mark_last_busy(ddev->dev);
> >         pm_runtime_put_autosuspend(ddev->dev);
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", value);
> > +       return sysfs_emit(buf, "%d\n", value);
> >  }
> >
> >  static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
> > @@ -1937,7 +1937,7 @@ static ssize_t
> > amdgpu_get_gpu_busy_percent(struct device *dev, if (r)
> >                 return r;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", value);
> > +       return sysfs_emit(buf, "%d\n", value);
> >  }
> >
> >  /**
> > @@ -1975,7 +1975,7 @@ static ssize_t
> > amdgpu_get_mem_busy_percent(struct device *dev, if (r)
> >                 return r;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", value);
> > +       return sysfs_emit(buf, "%d\n", value);
> >  }
> >
> >  /**
> > @@ -2019,7 +2019,7 @@ static ssize_t amdgpu_get_pcie_bw(struct
> > device *dev, pm_runtime_mark_last_busy(ddev->dev);
> >         pm_runtime_put_autosuspend(ddev->dev);
> >
> > -       return snprintf(buf, PAGE_SIZE, "%llu %llu %i\n",
> > +       return sysfs_emit(buf,  "%llu %llu %i\n",
> >                         count0, count1, pcie_get_mps(adev->pdev));
> >  }
> >
> > @@ -2044,7 +2044,7 @@ static ssize_t amdgpu_get_unique_id(struct
> > device *dev, return -EPERM;
> >
> >         if (adev->unique_id)
> > -               return snprintf(buf, PAGE_SIZE, "%016llx\n",
> > adev->unique_id);
> > +               return sysfs_emit(buf, "%016llx\n",
> > adev->unique_id);
> >
> >         return 0;
> >  }
> > @@ -2071,7 +2071,7 @@ static ssize_t
> > amdgpu_get_thermal_throttling_logging(struct device *dev, struct
> > drm_device *ddev = dev_get_drvdata(dev); struct amdgpu_device *adev
> > = drm_to_adev(ddev);
> >
> > -       return snprintf(buf, PAGE_SIZE, "%s: thermal throttling
> > logging %s, with interval %d seconds\n",
> > +       return sysfs_emit(buf, "%s: thermal throttling logging %s,
> > with interval %d seconds\n", adev_to_drm(adev)->unique,
> >                         atomic_read(&adev->throttling_logging_enabled)
> > ? "enabled" : "disabled", adev->throttling_logging_rs.interval / HZ
> > + 1); @@ -2407,7 +2407,7 @@ static ssize_t
> > amdgpu_hwmon_show_temp(struct device *dev, if (r)
> >                 return r;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> > +       return sysfs_emit(buf, "%d\n", temp);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_temp_thresh(struct device *dev,
> > @@ -2423,7 +2423,7 @@ static ssize_t
> > amdgpu_hwmon_show_temp_thresh(struct device *dev, else
> >                 temp = adev->pm.dpm.thermal.max_temp;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> > +       return sysfs_emit(buf, "%d\n", temp);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_hotspot_temp_thresh(struct device
> > *dev, @@ -2439,7 +2439,7 @@ static ssize_t
> > amdgpu_hwmon_show_hotspot_temp_thresh(struct device *dev, else
> >                 temp = adev->pm.dpm.thermal.max_hotspot_crit_temp;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> > +       return sysfs_emit(buf, "%d\n", temp);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_mem_temp_thresh(struct device
> > *dev, @@ -2455,7 +2455,7 @@ static ssize_t
> > amdgpu_hwmon_show_mem_temp_thresh(struct device *dev, else
> >                 temp = adev->pm.dpm.thermal.max_mem_crit_temp;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> > +       return sysfs_emit(buf, "%d\n", temp);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_temp_label(struct device *dev,
> > @@ -2467,7 +2467,7 @@ static ssize_t
> > amdgpu_hwmon_show_temp_label(struct device *dev, if (channel >=
> > PP_TEMP_MAX) return -EINVAL;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%s\n",
> > temp_label[channel].label);
> > +       return sysfs_emit(buf, "%s\n", temp_label[channel].label);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_temp_emergency(struct device *dev,
> > @@ -2493,7 +2493,7 @@ static ssize_t
> > amdgpu_hwmon_show_temp_emergency(struct device *dev, break;
> >         }
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> > +       return sysfs_emit(buf, "%d\n", temp);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
> > @@ -2735,7 +2735,7 @@ static ssize_t
> > amdgpu_hwmon_get_fan1_min(struct device *dev, if (r)
> >                 return r;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", min_rpm);
> > +       return sysfs_emit(buf, "%d\n", min_rpm);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
> > @@ -2765,7 +2765,7 @@ static ssize_t
> > amdgpu_hwmon_get_fan1_max(struct device *dev, if (r)
> >                 return r;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", max_rpm);
> > +       return sysfs_emit(buf, "%d\n", max_rpm);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
> > @@ -2962,14 +2962,14 @@ static ssize_t
> > amdgpu_hwmon_show_vddgfx(struct device *dev, if (r)
> >                 return r;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", vddgfx);
> > +       return sysfs_emit(buf, "%d\n", vddgfx);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_vddgfx_label(struct device *dev,
> >                                               struct
> > device_attribute *attr, char *buf)
> >  {
> > -       return snprintf(buf, PAGE_SIZE, "vddgfx\n");
> > +       return sysfs_emit(buf, "vddgfx\n");
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
> > @@ -3003,14 +3003,14 @@ static ssize_t
> > amdgpu_hwmon_show_vddnb(struct device *dev, if (r)
> >                 return r;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%d\n", vddnb);
> > +       return sysfs_emit(buf, "%d\n", vddnb);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_vddnb_label(struct device *dev,
> >                                               struct
> > device_attribute *attr, char *buf)
> >  {
> > -       return snprintf(buf, PAGE_SIZE, "vddnb\n");
> > +       return sysfs_emit(buf, "vddnb\n");
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
> > @@ -3044,7 +3044,7 @@ static ssize_t
> > amdgpu_hwmon_show_power_avg(struct device *dev, /* convert to
> > microwatts */ uw = (query >> 8) * 1000000 + (query & 0xff) * 1000;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%u\n", uw);
> > +       return sysfs_emit(buf, "%u\n", uw);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
> > @@ -3130,7 +3130,7 @@ static ssize_t
> > amdgpu_hwmon_show_power_label(struct device *dev, {
> >         int limit_type = to_sensor_dev_attr(attr)->index;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%s\n",
> > +       return sysfs_emit(buf, "%s\n",
> >                 limit_type == SMU_FAST_PPT_LIMIT ? "fastPPT" :
> > "slowPPT"); }
> >
> > @@ -3206,14 +3206,14 @@ static ssize_t
> > amdgpu_hwmon_show_sclk(struct device *dev, if (r)
> >                 return r;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%u\n", sclk * 10 * 1000);
> > +       return sysfs_emit(buf, "%u\n", sclk * 10 * 1000);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_sclk_label(struct device *dev,
> >                                             struct device_attribute
> > *attr, char *buf)
> >  {
> > -       return snprintf(buf, PAGE_SIZE, "sclk\n");
> > +       return sysfs_emit(buf, "sclk\n");
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
> > @@ -3243,14 +3243,14 @@ static ssize_t
> > amdgpu_hwmon_show_mclk(struct device *dev, if (r)
> >                 return r;
> >
> > -       return snprintf(buf, PAGE_SIZE, "%u\n", mclk * 10 * 1000);
> > +       return sysfs_emit(buf, "%u\n", mclk * 10 * 1000);
> >  }
> >
> >  static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
> >                                             struct device_attribute
> > *attr, char *buf)
> >  {
> > -       return snprintf(buf, PAGE_SIZE, "mclk\n");
> > +       return sysfs_emit(buf, "mclk\n");
> >  }
> >
> >  /**
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel  

