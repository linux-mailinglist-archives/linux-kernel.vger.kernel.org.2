Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB7379087
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhEJOWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhEJOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:20:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E8C0612FD
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:55:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s6so18776898edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X1GN9jjr1sr5SF8TMBUGPKB0M3z7GbSlMPn/rKhxoD4=;
        b=Gbf6fZxSutxrXTzDLAQIfQt917wthp5zZ3dS9T8KKg3+zYQkdGhnggZ24zxxokIXee
         F8p+6BFvBe5aOjPtAqBaQ3prl/paZtDVWmUg03bL/86oqj/MBlQXsxNyNk9gaGt+4Zrr
         1b/C29PrzlRyh7aeuE2Ep2+wbZ0ND2X/w0eZ2HG2/XVNpmYpRwhok+OWXsSIx7luIVdA
         xZA/A7H3z0iGx84NjT/7h21iSrEvhBAvWoZfOfhkFL/LHu2T5mA4pq8Zs0mFxSFhhs/z
         R3PUI98RVlHkiFKcm+dxtTqYFs90+fn3WuYkGGWd8k6SrK+njliOqm/RvlWT4EZaIiMJ
         E+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X1GN9jjr1sr5SF8TMBUGPKB0M3z7GbSlMPn/rKhxoD4=;
        b=LTOaeRXGaLyx+sTkkTRfBxwEhaOwvGTr3W8z3tjgGPYyTbjy86hllxvOX3GLoH8KlS
         omvsm1/ohQ3R4IHlb9726A8p7aLOGPwfZA5rR1vZK5oB1oY67uz3H9AtMq2D85kALtYK
         pcqxxyJ7Eyr++F8s9SA3bUnCVGRtY6D+tuueA+oHeJr52UaAuMUwB3gqnxckmetsf2Tc
         807tHhxb65buY/FhIlY4DBvyK9WIqu9ApEm5a0imWekXLkLfQsg/HJUj9XWHq4wjCAYW
         idANukZGFW3OUvTb/wOry+It2dwYexLs3KsMCaUYs7d5O2IA/VsOx/bo88QSCzDkFkpT
         Lv2Q==
X-Gm-Message-State: AOAM531+uldALGFJZSa2A+XXEDQb/EFHTKvseCH6gOuSiFLyzfH9Efdw
        mtLLeni41p8tBrZL/PLCgC6SXQ==
X-Google-Smtp-Source: ABdhPJzSSz8yReI04+r2vG3aBxaQGpDRgafIkEHoG8HATWT4V1/bL9wRh6nZ/APWhuW0Hhc5vHHNUw==
X-Received: by 2002:a05:6402:546:: with SMTP id i6mr3874089edx.376.1620654957029;
        Mon, 10 May 2021 06:55:57 -0700 (PDT)
Received: from [192.168.1.14] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id f4sm11365823edx.30.2021.05.10.06.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 06:55:56 -0700 (PDT)
Subject: Re: [PATCH v5 15/25] media: venus: venc: use
 pm_runtime_resume_and_get()
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <cover.1620314616.git.mchehab+huawei@kernel.org>
 <3253ef1fdb3256642edecc0ad9e6556aa529590b.1620314616.git.mchehab+huawei@kernel.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <7b4c69d1-bb76-7cbb-9de8-d90b51bd1358@linaro.org>
Date:   Mon, 10 May 2021 16:55:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3253ef1fdb3256642edecc0ad9e6556aa529590b.1620314616.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/21 6:25 PM, Mauro Carvalho Chehab wrote:
> Commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter")
> added pm_runtime_resume_and_get() in order to automatically handle
> dev->power.usage_count decrement on errors.
> 
> Use the new API, in order to cleanup the error check logic.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Tested-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>


-- 
regards,
Stan
