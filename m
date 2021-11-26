Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51BF45F37E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 19:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbhKZSLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 13:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbhKZSJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 13:09:46 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DF2C0698DE
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:43:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j3so20243635wrp.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+UiEjSqoBFBgDOwxCHk8r4IzVtO6WbDb+y5dL5FQNl0=;
        b=Ds76xZJZFvBCPEGIOn4ocNh2icSMOKzcFfamHHzKT9g5iWCNiTMpi2eLY1nYpDqEab
         wxel8g1pL+J26LdzG7CirWO1ycfeVj0Kp8qaekQjWJwmf+WZ1yj776zSlgSLuEYCoYfh
         LUgT73N+zl0SQHcb0NI3okm7Um+7/3sdcaH96yZkrQVqtiy8S8CeyQa+QbGE+f+9fLFc
         X+UB6WRadIJJhRloTc3tg8r6eIFxCQ2S8t35LWK+3Ii73y0EsXsIOIVYrcP8CawBJKh7
         a8vY3SvraYNP+K2BzDOIPo+o0/24lzrXHjG5CcDCSiciJe/KYHL7zx+h+WDILLcTpdi5
         lCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UiEjSqoBFBgDOwxCHk8r4IzVtO6WbDb+y5dL5FQNl0=;
        b=hXNS8w/KQRK6OVw1YS2rnDVLlVC+i4cb7MQzhxOdaUG1e+NW1dqPSF3hdwOONOGl4f
         k1aO4hTUDA47kx/vFL6RXPzKh8DYeDJTmyYSoZmjauLG2HTMetMOqVXq5tbfmN52tMK6
         9hljOnc1k06TFatWq6Zq+IhhKxOjaU2AOZbwI5RAQCBg+TH2jPzoRtVmaCwJ7/VNt0aY
         bauJ82A2l0G6/0yEwgykGLl0IDI0ykFtW2L4li/vM7haXUl6sRQ1OpSQ8p8Ex6nB0Sa+
         MfXqKKLyWjv14Pn4x9nsKkRrPctTExEiHeqJPv4SaAEts46EpheVglPsI8/37BAtPkKI
         Mprw==
X-Gm-Message-State: AOAM530Nvs2iA7Rakh/gLFpB3yie0QD8JfCAYyWH9ZFoAgAJ0hW7U52c
        lEhYybS55dP9fv2Ds6SI4wHwPnC+YQ8eaA==
X-Google-Smtp-Source: ABdhPJxL9i6DqGu2i3SUDyRY0OaKl05jJ/i8KtMtVxYY/r6AqeH/OBwdOEDYMIKg8yM1hed+eFfLVg==
X-Received: by 2002:a5d:67cb:: with SMTP id n11mr15459406wrw.504.1637948606244;
        Fri, 26 Nov 2021 09:43:26 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:70b:e5b5:f868:20cf? ([2a01:e34:ed2f:f020:70b:e5b5:f868:20cf])
        by smtp.googlemail.com with ESMTPSA id 21sm6580682wmj.18.2021.11.26.09.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 09:43:25 -0800 (PST)
Subject: Re: [PATCH v6 3/7] powercap/drivers/dtpm: Simplify the dtpm table
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-3-daniel.lezcano@linaro.org>
 <CAAYoRsURO1tf03nfiki1uaXYEmTKQyYKUeTyKW+vefrVzCO7jg@mail.gmail.com>
 <CAJZ5v0hcuq0qriHbc=XHbCo8fJMAV1dbCBws3M9GktN17aCE_g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <acb3ac6c-d6e6-c3f7-6b04-12d3a1fbf0a1@linaro.org>
Date:   Fri, 26 Nov 2021 18:43:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hcuq0qriHbc=XHbCo8fJMAV1dbCBws3M9GktN17aCE_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 18:21, Rafael J. Wysocki wrote:
> Hi Doug,
> 
> On Fri, Nov 26, 2021 at 6:08 PM Doug Smythies <dsmythies@telus.net> wrote:
>>
>> Hi Daniel,
>>
>> This patch introduces a regression, at least on my test system.
>> I can no longer change CPU frequency scaling drivers, for example
>> from intel_cpufreq (A.K.A intel_pstate in passive mode) to intel_pstate
>> (A.K.A. active mode). The task just hangs forever.
>>
>> I bisected the kernel and got this commit as the result.
>> As a double check, I reverted this commit:
>> 7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c
>> on kernel 5.16-rc2 and the issue was resolved.
>>
>> While your email is fairly old, I observe that it was only included as of
>> kernel 5.16-rc1.
>>
>> Command Example that never completes:
>>
>> $ echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status
>>
>> syslog excerpt attached.
> 
> This looks like it may be problematic:
> 
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index f6076de39540..98841524a782 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -204,7 +204,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>        return ret;
> }
> 
> -int dtpm_register_cpu(struct dtpm *parent)
> +static int __init dtpm_cpu_init(void)
> {
>        int ret;
> 
> so please try to remove the __init annotation from dtpm_cpu_init() and
> see if that helps.

Yes, actually that should be called only if it is configured properly.
The dtpm_cpu just initializes itself unconditionally, I did not figured
out there is the usually allyesconfig used by default by the distros.

That should be fixed with a proper DT configuration [1]

[1]
https://lore.kernel.org/all/20211124125506.2971069-3-daniel.lezcano@linaro.org/

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
