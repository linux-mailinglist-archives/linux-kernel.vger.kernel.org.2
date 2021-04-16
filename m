Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645A6362303
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbhDPOmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:42:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40341 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244373AbhDPOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:41:34 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lXPee-00006o-Nn
        for linux-kernel@vger.kernel.org; Fri, 16 Apr 2021 14:41:08 +0000
Received: by mail-ed1-f69.google.com with SMTP id f1-20020a0564021941b02903850806bb32so1175210edz.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b25TSBS6UiWWLc/aOExDgRNzZidx4yrWBstLaTFqS8Y=;
        b=tCrC3z83GAHx9WAZ34hAOcH545se2PiDh4FYWzbBVhaH3TWhSfVK07FatsLhfJRkCn
         cGFh1xKV+rnt9CURF6UeDo1JpLA0WvIB8KCjaEaOXmmW3JWNV+nf/MFBrvTURAoSis9N
         UAqno0/em4f6uIQqKHhYhZX6pv5eMbr8hkziYYSnxew8mcc+dbmkpNBFJ+tQObIovmyT
         N28W4N4L/WRlrdwf4ORx1Wj2MjxNQ7bXhWjoL30mseKZJh6MN20YDbOYwE+jHkJX0fwA
         VdFoFa/4HKTijOTRrrRJV4JtFkRa8l+/wbNfC6yPEr163XEioPLOrh1M/Q9aDBhCQZEV
         Z6eA==
X-Gm-Message-State: AOAM5331Drxt5Yx6/qNMUElkV6k6UAmMBsJ7RE+BKxQUuvZ98eXkT/m3
        oWBmI9r3eN5pC8Y2K89BPT1rgOeBdzum6Ggl17LojbbK6IO9nHwSFywmWQ3Sqqx0PnRUmQfKQg0
        AKR05nalZ3ghG3uvo/qjd4b0kCHzuh68zjZj6Rg9oqw==
X-Received: by 2002:aa7:c40b:: with SMTP id j11mr10408445edq.219.1618584068507;
        Fri, 16 Apr 2021 07:41:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlc2f00RlqR/ykNACjQsXBZXVvhiN61LyMrfeRQGlPwDyvhCSQPMZ1jgI6EptuQv5bwl2/qQ==
X-Received: by 2002:aa7:c40b:: with SMTP id j11mr10408420edq.219.1618584068345;
        Fri, 16 Apr 2021 07:41:08 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id y7sm5629666edq.88.2021.04.16.07.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 07:41:07 -0700 (PDT)
Subject: Re: [PATCH 36/40] drm/exynos/exynos7_drm_decon: Realign function name
 with its header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akshu Agarwal <akshua@gmail.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-37-lee.jones@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9b6753f4-a448-514d-85b0-2f3ab3049f1c@canonical.com>
Date:   Fri, 16 Apr 2021 16:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210416143725.2769053-37-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2021 16:37, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/exynos/exynos7_drm_decon.c:355: warning: expecting prototype for shadow_protect_win(). Prototype was for decon_shadow_protect_win() instead
> 
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Akshu Agarwal <akshua@gmail.com>
> Cc: Ajay Kumar <ajaykumar.rs@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/exynos/exynos7_drm_decon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
