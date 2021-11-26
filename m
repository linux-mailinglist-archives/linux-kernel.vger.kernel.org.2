Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4118045F353
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 19:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhKZSE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 13:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbhKZSCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 13:02:54 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA999C0613F2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:40:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso7269041wmr.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W8td6vEPKxADiJQFmlrhuwiA6Bp6UV5M0SX5QzKONIo=;
        b=BfjoJUobqTMEq9KNZqO/G4e3eTzCqfn2c/zMsEGs8rQ/X/tDm2m7NrxstzLNg3Riux
         LfyMk9cL1qjovsTfZY0HHxyZuCCAKwp73rX5NKILX4c8puU11FV4TRhZRwOAGuUjQvcQ
         8PoxTHipOiU02voQDwN2amVe26qugqcy+18EFrkO9TXbNcp5ki1AW2nSOXdU/BcH3Cfq
         xEgyQMgG1MXZbvjGd9dEvhZ2AKgFKHp9jgYO0o2/v72uU8wU8slXxpgd1SG88VlFb0Hx
         2VjIHLHeJrE+dTwBCjsuXHY6Mk8FjhXW9BA3XW5L0doAzxJGkKKcid7rNcjuuTLoiHyD
         yfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W8td6vEPKxADiJQFmlrhuwiA6Bp6UV5M0SX5QzKONIo=;
        b=Oh8mnD2wRzWWvSqyBji967nfk+T0Dym/yCQl+ylXGBEe3jjtzbJt/hUsFAg4FKnhp9
         AMZ3IHyIw4cMx4Xh3GeFwMPZIIagwxpOQoQV5LPhprp0LWV6GIedCxaLgqcbozfP+Ue2
         X4K+VoHBOEjeUJliRKf3kvhQTyIy+06n8+d7O+veJIPKQMYl8K1TZynodo+7nrNMxlZE
         xBd7leqrwNT+RUFKDUt3riYHg1DKFw1+aLS/81wLTAGIzJWVbHgT1KD1czvzTGnGdIRT
         hg+Jkp2QCiYhlrP9WjHMYq0lL8NzHu5+8QKBuxSsi97VxR2ON7e7ikUxpt8J7Aszvrk4
         oK6w==
X-Gm-Message-State: AOAM532sx9G+LCCFz/HKgAUoR7Qx3tUzahn6TYmuE/pjk/A082saalFQ
        HsMp0HjGJNeultIAN8hcbgVL5Q==
X-Google-Smtp-Source: ABdhPJyiejxvdKECGDvPJh9q3/ZB2Tt7wodvwW7t4tLf9B+VhlzIRvu6qs6lbZmkf/GEBfd7JZIEtA==
X-Received: by 2002:a05:600c:501f:: with SMTP id n31mr16993345wmr.101.1637948429061;
        Fri, 26 Nov 2021 09:40:29 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:70b:e5b5:f868:20cf? ([2a01:e34:ed2f:f020:70b:e5b5:f868:20cf])
        by smtp.googlemail.com with ESMTPSA id l3sm8027009wmq.46.2021.11.26.09.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 09:40:28 -0800 (PST)
Subject: Re: [PATCH v6 3/7] powercap/drivers/dtpm: Simplify the dtpm table
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lukasz.luba@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        gregkh@linuxfoundation.org
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-3-daniel.lezcano@linaro.org>
 <CAAYoRsURO1tf03nfiki1uaXYEmTKQyYKUeTyKW+vefrVzCO7jg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1e75f7ff-4b1b-ff47-2344-903605067693@linaro.org>
Date:   Fri, 26 Nov 2021 18:40:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAAYoRsURO1tf03nfiki1uaXYEmTKQyYKUeTyKW+vefrVzCO7jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 18:08, Doug Smythies wrote:
> Hi Daniel,
> 
> This patch introduces a regression, at least on my test system.
> I can no longer change CPU frequency scaling drivers, for example
> from intel_cpufreq (A.K.A intel_pstate in passive mode) to intel_pstate
> (A.K.A. active mode). The task just hangs forever.
> 
> I bisected the kernel and got this commit as the result.
> As a double check, I reverted this commit:
> 7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c
> on kernel 5.16-rc2 and the issue was resolved.
> 
> While your email is fairly old, I observe that it was only included as of
> kernel 5.16-rc1.

Could it be related to and fixed by:

https://lore.kernel.org/all/20211108062345.273855-1-daniel.lezcano@linaro.org/

?

> Command Example that never completes:
> 
> $ echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status
> 
> syslog excerpt attached.
> 
> ... Doug



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
