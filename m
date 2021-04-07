Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5544B356897
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350444AbhDGKAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhDGKAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:00:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44E5C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 02:59:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r9so4126000ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ezue5kDeqE0ZtSRkrpYBHuexgmqA31YZEyH6lvl25uw=;
        b=fqfNmPZOVFQDe2AouClgXbDOgSSjo7aUUzPL781A9s2Jo33q0bvg/DD2MWEg4KaSZa
         8ilpB1fN+fA6nmCjXOacIkmkTFzYJpZ0oE34PfRR6j/VEz0AgyZ0N7fA+g0bZGLhvc/9
         PIsvPn50bde8jK6T7XTX077ZjrGW6TbIJDZ98NhLNQBkSNpgyDsgvpHRzzuBeqDCHMOu
         gTuneOPxP7SVUdIZGbhSnEFWEE9mc4smi+GEqVlXS/qxF++tQqBMgUu2i1L4FR87ch14
         /LaZ/Pw5cRuPugRjt0fPwBb7UERuctoxNsthuIPj7uVccqM8L0QwpQHnG/+ZemVvs+gU
         tpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ezue5kDeqE0ZtSRkrpYBHuexgmqA31YZEyH6lvl25uw=;
        b=qP3yT5whDSycaFq1QZT+81SP5OaumFQqU6tSCmKH+hj0+LuXewrqHzHwiFw7jFVtHg
         uIhX6nzDCzBQMUkYD4GhEfgMdjwiNLqcMXJz2GBq7q7f1NCq9L+JPXIUjM1rPisNbxl4
         VpCMatmPUFRNigZ59I1LCE5vvDASzT59Ct1UgznpRwvtkOT//E+QExbQv35qwr8EYml3
         83IcwzTdpEn9207GT5o7WgzWrcLHLDEeWbt2Sql2Ck5MyN7R6RjBxmI7v43P36GuHYtN
         YLXmL/Q15+BWpw933tUsx6/99WALCi1+vMUW+COGQk0gHJo3DXDk4kV43pdOJYjeisaj
         411w==
X-Gm-Message-State: AOAM531YPOUFYP0D9qFyhEkLCvk+ATJNk6I8Zx1sQNzE8y2RlazLLIeD
        L/WTRphF0JYmay99XvxcaSXqZw==
X-Google-Smtp-Source: ABdhPJxL4Zz+RoDOr2oUuFbkluZmflq3AmScLlDyfXoiqHo7QFRUOb1hw2oKuo3f6DMiY/hjF8hftg==
X-Received: by 2002:a17:906:fcaa:: with SMTP id qw10mr1370992ejb.9.1617789592378;
        Wed, 07 Apr 2021 02:59:52 -0700 (PDT)
Received: from dell ([91.110.221.225])
        by smtp.gmail.com with ESMTPSA id e5sm7521056edr.64.2021.04.07.02.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 02:59:51 -0700 (PDT)
Date:   Wed, 7 Apr 2021 10:59:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: arizona: Fix rumtime PM imbalance on error
Message-ID: <20210407095950.GA2961413@dell>
References: <20210407051149.31422-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210407051149.31422-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2021, Dinghao Liu wrote:

> pm_runtime_get_sync() will increase the rumtime PM counter
> even it returns an error. Thus a pairing decrement is needed
> to prevent refcount leak. Fix this by replacing this API with
> pm_runtime_resume_and_get(), which will not change the runtime
> PM counter on error.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/mfd/arizona-irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
