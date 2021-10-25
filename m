Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B573439D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhJYRSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhJYRSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:18:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF5C061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:15:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b133-20020a1c808b000000b0032ca4d18aebso10130984wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TUv9ZLhyPeiLA5e9mCDPN+eH77IxAWpHtAvBbtcYi+E=;
        b=q0ul8+l0c66kEq7GU+h4OytC/sWRKvNWw6JABwqmd0qB26iiRAa5dNLNqWA3WQOu0K
         i7hSqcwp+q7x4bdceWbS0EnxDvl/9MwONx0cDYQKyoSpr2ZKMkmfyDb0xR4Akbg6203/
         DAakQ0KmehSg3/Y3LJ32DtyTgG7/Bnnv8stZf+xQx2FVyy1DsnXtUhHyXACxay6yvCK4
         826Tye27PIyvoVVeOTXQqb8cYFWF9TI2mZyadNVH3trI0kXTDgalU0UsuDwIMlW2ySmi
         n4JFPwJ0uXmWzWWdSgPGdGFXPSLMZn4Syf0hqsucn2SUyCW3xJN0KMfSDS8aK4FB+uD3
         Brpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TUv9ZLhyPeiLA5e9mCDPN+eH77IxAWpHtAvBbtcYi+E=;
        b=6jEKH4bGHXv0yvpeGLQgpFEBZGV9CjIG6pX7iXUwea/TN9/deeNxUulduM7d7CXRXy
         nohUxBnT5RHScd2afAOZVXsyQZyv5hPD5GtnODAbyP8gHY5aLaOn+uWJhdIpmEOlL9iD
         nkUsUkBKHrwvWomljzlSIf1N/IRDbquYD2D581ZIMt7ZPWnN8esNsSB38gzxrXT+z6GX
         +oXBSqyYfUk6ift1v9KyrxBk6Zhz6A9FL/6a3pAYyYExFhQS+5jpiBOsHpJLc1sSPbQ7
         zsKPj7nPnch1rKE0qTIi+TBse8DWFxUXaxCnUyHXESclxX7rWkkhUU7hKymj66zO0RQn
         cmgA==
X-Gm-Message-State: AOAM532SxNSjNMp0ZydUy8sYsIPIzX23qU09gK709L85hTubfRB+E/gW
        51Ypw529WYI1jt6j0tFQyGd2I2JpDpJocA==
X-Google-Smtp-Source: ABdhPJyKUO7KJbcLmKgdW0slpjYxFo4/Vqi8UMU8JM7030QYXyq7MeAEbDy9hTrruVpAI19v0IRFXg==
X-Received: by 2002:a1c:155:: with SMTP id 82mr22571518wmb.191.1635182139160;
        Mon, 25 Oct 2021 10:15:39 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r1sm11855186wmr.36.2021.10.25.10.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 10:15:38 -0700 (PDT)
Message-ID: <fac70dcc-2dcc-6c1f-2f71-6936deedb091@linaro.org>
Date:   Mon, 25 Oct 2021 18:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] media: venus: Synchronize probe() between venus_core and
 enc/dec
Content-Language: en-US
To:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211025144345.267107-1-tadeusz.struk@linaro.org>
 <72f8dd7a-66c7-fb50-db23-f98ba753af1d@nexus-software.ie>
 <bba3acc1-cfa1-0c53-75de-f4ffa0a2bc9e@linaro.org>
 <00b817a4-f1ac-6a94-5f1e-836d8d313406@linaro.org>
 <25da5210-8e1f-7183-a8e7-8584f8dd2cef@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <25da5210-8e1f-7183-a8e7-8584f8dd2cef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2021 17:57, Tadeusz Struk wrote:
> agree, but I don't depend on of_platform_populate(). The ordering 
> between the
> three probe functions is enforced by the new sync mutex.

That explanation works for me.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
