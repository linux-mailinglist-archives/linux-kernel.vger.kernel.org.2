Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040F83550A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbhDFKQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbhDFKQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:16:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1104EC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 03:16:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso9008277wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oyIf/x1l5BfzE7VF1G+hmZ5fvaHAS0ZsNoW+4Cxe2pc=;
        b=lpHCeEmTYmpp3dv39j2GK0W6pYHt3nK4abRD1Lt8TofuRYc+0PeGuRAoID1n9je/h6
         sciNQIovVHSmNcJefPFeVQEKHxPTPVOnBd/1sCWJOZSbhXC1GmAt46ImGkad04HHGFk1
         LF6CxDE8KVMx1vXfoiDADRhtxQmytrgsMGFQM/cKBtkPtpwi2y81sUxhhDSrYZPvIXYZ
         /h4Jx2+f4Iw3Z5Ph/OwvCohY1qRBYfI3gm+FCOHhVpaDF+kqz9N0uSlrqkByWzJevRM5
         lA8SwpIM51LvQWk3sszq3OyfWdOHukx4lMLUrNsk1uRD4Xg6u3lza/LHkaC1qzjrn1Ga
         H2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oyIf/x1l5BfzE7VF1G+hmZ5fvaHAS0ZsNoW+4Cxe2pc=;
        b=L/K2kPB7MpH3AbtnSz7SVWnwq0lh1OSGzU0Kbe7KYAws/OLkGHCu9FTiO4cEAM88YG
         o/2c0yQCV9Owp7/5bKo/ROVcMkAcxrUy3bM4j/VdfX9JKY7yrwqU6ms9m2vLbb0i2cNZ
         Dw+HIZhCLEvFlfYtbsbZh0bNxzRGrNpW6+eRSoP2wXWwtIWHUvJ+I9ZymlByqAZPysgO
         oVsgODk7m0yVSYZBQoOG0f9lk3Z69ZGPdnjF0ZZcRKhx+oPfoK3QX+LkmpiG8tqufOMl
         ITca+ozBLTg5+QKtBTtPiiDSsUBGjyITxFiH4u8i1TidDkVjgccN5+wr8VtJqvEpWpxc
         2A5Q==
X-Gm-Message-State: AOAM531rGWUAWjROIDqTXo1sJAGbnyIF8gq1k45UNc9S1B4XiPjFAqXD
        xHOoZCqWkSyAatI7DB12djgbtg==
X-Google-Smtp-Source: ABdhPJyRBdWfyZF7odkRc/rVdzu6OWDZtlPPm4/fVx3syA+o0ENWmozYw3JONODf2yOiyCU3Hrj98w==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr3483585wmc.6.1617704178588;
        Tue, 06 Apr 2021 03:16:18 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d506:6f5d:adb6:da14? ([2a01:e34:ed2f:f020:d506:6f5d:adb6:da14])
        by smtp.googlemail.com with ESMTPSA id w7sm6525106wrt.15.2021.04.06.03.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 03:16:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: power_allocator: maintain the device
 statistics from going stale
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210331163352.32416-1-lukasz.luba@arm.com>
 <20210331163352.32416-2-lukasz.luba@arm.com>
 <b27e0c79-de27-f9b1-ad16-17825b302615@linaro.org>
 <1f0710d5-cd78-dfff-1ce2-bba5f6e469b7@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1a0b6e4a-1717-91d6-a664-d50e6aa8a809@linaro.org>
Date:   Tue, 6 Apr 2021 12:16:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1f0710d5-cd78-dfff-1ce2-bba5f6e469b7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2021 10:44, Lukasz Luba wrote:
> 
> 
> On 4/2/21 4:54 PM, Daniel Lezcano wrote:
>> On 31/03/2021 18:33, Lukasz Luba wrote:
>>> When the temperature is below the first activation trip point the
>>> cooling
>>> devices are not checked, so they cannot maintain fresh statistics. It
>>> leads into the situation, when temperature crosses first trip point, the
>>> statistics are stale and show state for very long period.
>>
>> Can you elaborate the statistics you are referring to ?
>>
>> I can understand the pid controller needs temperature but I don't
>> understand the statistics with the cooling device.
>>
>>
> 
> The allocate_power() calls cooling_ops->get_requested_power(),
> which is for CPUs cpufreq_get_requested_power() function.
> In that cpufreq implementation for !SMP we still has the
> issue of stale statistics. Viresh, when he introduced the usage
> of sched_cpu_util(), he fixed that 'long non-meaningful period'
> of the broken statistics and it can be found since v5.12-rc1.
> 
> The bug is still there for the !SMP. Look at the way how idle time
> is calculated in get_load() [1]. It relies on 'idle_time->timestamp'
> for calculating the period. But when this function is not called,
> the value can be very far away in time, e.g. a few seconds back,
> when the last allocate_power() was called.
> 
> The bug is there for both SMP and !SMP [2] for older kernels, which can
> be used in Android or ChromeOS. I've been considering to put this simple
> IPA fix also to some other kernels, because Viresh's change is more
> a 'feature' and does not cover both platforms.

Ok, so IIUC, the temperature is needed as well as the power to do the
connection for the pid loop (temp vs power).

I'm trying to figure out how to delegate the mitigation switch on/off to
the core code instead of the governor (and kill tz->passive) but how
things are implemented for the IPA makes this very difficult.

AFAICT, this fix is not correct.

If the temperature is below the 'switch_on_temp' the passive is set to
zero and the throttle function is not called anymore (assuming it is
interrupt mode not polling mode), so the power number is not updated also.

My suggestion is to do the following:

	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,

					&switch_on_temp);
	if (ret)
		return ret;

	if ((tz->temperature < switch_on_temp)) {

		/* Nothing to do */
		if (tz->last_temperature < switch_on_temp)
			return 0;

		/* Switch off */		
                tz->passive = 0;
                reset_pid_controller(params);
                allow_maximum_power(tz);
                return 0;
        }

	/* Collect the power numbers */
	...


Two birds in a shot.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
