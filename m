Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1B53EC20D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 12:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbhHNKib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 06:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbhHNKiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 06:38:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E81C0617AE
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 03:37:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so7021476wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 03:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b/Qff+jgXrDhHuuoGtLAHrj3fuh4dTxu/3Q1oLK4n8Q=;
        b=HJL2l1Dpc/J4K4yfvomdt3qXLJ/QLhZOCgHm56mMldgkdC9wNqTT92qrGVVVmiA5E7
         s+eZ3UE+WSVMOV1JuU+RwFoQvSwAI4wAb2c25tFKcIKuJ3P4h3hQMaPjR55zVLF7yqc0
         olArDY5fQ8ls2HjtNV9K3pFVvGeiYr9P9/w9ZuTnEBBa33mkINm4kpD+rLbGNL7r29VG
         xQjtvgY/3wEkqTEpkxGlEF1agw0MtFLoy6fnNOLrQ/U3JjatLVdqQsbpiPxeEHyV5DSN
         s5hqTHCVkbUJ1zsWDacpRnzlBX86KLazem8prxJoxpNxxLs8nGQ4BIR3HDh52W+bmzZL
         hdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/Qff+jgXrDhHuuoGtLAHrj3fuh4dTxu/3Q1oLK4n8Q=;
        b=h2GrNIFAwgXXsBrmJETHgicsxtm9PB6ZWhMey9GpVNzOZ/PQTzX1ZzqaXgHoV7vAZB
         fKWeOpr+9JOXzeAJpY3ELqCyO+UsJdDrj4ZQtI0V3yEyMX0uFne6d+u4NbkhDxnMX32P
         I48eCNLQ4xjY8zW3/n3PYuV+jiw5SVOCYCvfmViYh4Sn1Hkhh2/fAuHeTy0Z3aygqTxs
         ONdF8/ao1YB3rBH/byxYSDCS73353d9ysROVfyUbCqvYG+T1SsLly94YfwH9MdZUcXbd
         Ck2MRGDP12IEbO3w5w929JvGEjIUJVbOIW4IlxFUFezf+rGkVgCOwBi+VFrfjpSJmZvB
         Bymg==
X-Gm-Message-State: AOAM5317P84EvIso2f+qaJVm/TMye4u7lkKCaos+cki0qN8/mRYsQIvO
        v4L0LO0Quk7NEUzgp9GHqPpenJCUn90pB5jp
X-Google-Smtp-Source: ABdhPJzQ48slGMIdnfZowqGimrHWLTCgEUosGpoZOS695J9Vebr2A4e2oYVBp9dC0EG9L+eBMlpU4g==
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr6614718wma.25.1628937463289;
        Sat, 14 Aug 2021 03:37:43 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5df3:d0eb:3945:640d? ([2a01:e34:ed2f:f020:5df3:d0eb:3945:640d])
        by smtp.googlemail.com with ESMTPSA id e17sm4228437wru.7.2021.08.14.03.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 03:37:42 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] cpuidle: tegra: Check whether PMC is ready
To:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210718212706.21659-1-digetx@gmail.com>
 <20210718212706.21659-3-digetx@gmail.com> <YROdQXO4aVLQ8DkP@orome.fritz.box>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8d61d4d5-8e4b-5c18-923c-eceb954e8d5d@linaro.org>
Date:   Sat, 14 Aug 2021 12:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YROdQXO4aVLQ8DkP@orome.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2021 11:49, Thierry Reding wrote:
> On Mon, Jul 19, 2021 at 12:27:06AM +0300, Dmitry Osipenko wrote:
>> Check whether PMC is ready before proceeding with the cpuidle registration.
>> This fixes racing with the PMC driver probe order, which results in a
>> disabled deepest CC6 idling state if cpuidle driver is probed before the
>> PMC.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/cpuidle/cpuidle-tegra.c | 3 +++
>>  1 file changed, 3 insertions(+)
> 
> Rafael, Daniel,
> 
> would you mind if I took this into the Tegra tree? It's got a dependency
> on the PMC driver, which usually goes via the Tegra tree already, and
> there's nothing cpuidle-specific in here, it's all Tegra-specific
> integration quirks.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
