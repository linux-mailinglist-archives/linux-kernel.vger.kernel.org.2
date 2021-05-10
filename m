Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D078379082
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhEJOVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbhEJOTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:19:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B3C0612EF
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:55:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r9so24668431ejj.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R3I+cJ/HNa43p7O9IqL92rD0/3nTNS0rycYZ/LuBU0c=;
        b=a5K0KhtKct36+xmqlnSZCPapHdDRa/7O2xijP3DJyGTifut0orPMQplJgVpY8dflRM
         X6curX44OHAJQs0s3JLI1UC6uKsQnPUVcEZPZkzrUQCEHRHEtN6ZCmVXrSFKjUoRPSKa
         7+iVXt8bwOd3UYXjgoidPxkezauz7k0Wh0Q0NTPwGyi/+8zZWEqOUXRlA6ehSnmYieiw
         Nqlw45izMHuDyY312MsU0v/ri+jSfsY4j00gCTb4gYZJW66tK9+SkiXpGVpAFWlN7Aom
         Bu2Mvp26Uewx+HeVfAr5wJy/JCKsSZshHddl+w6zwR01BwtcQotdDNo+cB0VGjPQ6wGs
         Bv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R3I+cJ/HNa43p7O9IqL92rD0/3nTNS0rycYZ/LuBU0c=;
        b=Mu0MfOglIKfpw/XBnzQYq6W6ZpYJ5gbzRnlqpd4scuwGYua1RICF4q2sPM/mGadi7o
         qsFB/crz1zuh2NjZmTNBhknJEjEUm1GfV4hek63BA8avlcyL4XULS+PmczpZn4+sbE7N
         ItAAzJM7+rFjZOyxKKqFxoSOO/fFWAJZ+Z+4kMfMnxkN0Ik7WVOFWdThnMbulkFtiuBw
         +y3fpVoZyr04jj4SE2mkxejAz/7r72+ToDFW40UcmGaGtpHeyGWfb3ULAfJ5IaKyWAks
         LoYAJuSKXJk+5IYFocFhRP1sTRof3iQAfCdPf4aJUECKUjMfGNl+9qti5po8XjVei5X3
         qxgA==
X-Gm-Message-State: AOAM533S6NI9VZEWLjPTVD458HRH2IAaidxIJn4xEOFejcqDmnFqaUr8
        67R0fYG/uyzlnLnh1Ds2ym3LSw==
X-Google-Smtp-Source: ABdhPJxFCtXatqzsLV0AO+XHmKPYNCl9ZBBC1u1OV6OrJIyxJb57jDU/1J8Dicgytd4+prFSbT2dag==
X-Received: by 2002:a17:906:1d0a:: with SMTP id n10mr8841967ejh.341.1620654920502;
        Mon, 10 May 2021 06:55:20 -0700 (PDT)
Received: from [192.168.1.14] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id z9sm2341077edb.51.2021.05.10.06.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 06:55:20 -0700 (PDT)
Subject: Re: [PATCH v5 14/25] media: venus: vdec: use
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
 <76b4daa74ae49576d37235916d687c36991351eb.1620314616.git.mchehab+huawei@kernel.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <129734bc-d50c-e149-0e8c-ac84573b151f@linaro.org>
Date:   Mon, 10 May 2021 16:55:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <76b4daa74ae49576d37235916d687c36991351eb.1620314616.git.mchehab+huawei@kernel.org>
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
> As a bonus, there's no need to check if ret == 1, as
> pm_runtime_resume_and_get() always return 0 on success.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>


-- 
regards,
Stan
