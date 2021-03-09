Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14F3328F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhCIOqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhCIOqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:46:08 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BF6C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:46:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d139-20020a1c1d910000b029010b895cb6f2so6623965wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V+vFwrxZ7wWmtPaHeuSbktTnjmyK4w7BNL8hDFLnkf4=;
        b=UzdZRCCVsYEu1+p2lMp9gi/N7gqurRy0i9kXas9/aetc5c4c+/7jJNDyJ2jqRxxjR6
         jtLtfEdTpveI0QKrGvhEWzGiy+fUOqPJLwfNMVx24FLSfPFltE+hq5Zk9wppHYw1miBe
         RIqnPyj4daZhu03yP2a6KFppT4kQWg1pjadLiVq5Iczymcl0PahSjdZ0kw6CSnuq58Ti
         bbNwcYuF1TNJKrP4r7x/7x55YtO2dpg3ZZJ7YQs+y2uJAd5Z2DHoL2J3vFxsEDnMbJU3
         9+kaxL2mxIuVFnbuDc66lh6FrXUG4H594rEW/iA1ZksUMpLEF5LFK47Dtcpgtk4C556h
         zjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V+vFwrxZ7wWmtPaHeuSbktTnjmyK4w7BNL8hDFLnkf4=;
        b=pEfK+eOXpDOktOdYCcD/IifGR2k27nvO8Ewl7cF1mthI361Bqp+0wuOsP3THHh6fYw
         //f53teHbYOOTSrPYWUxHsgMruVRm/+ZDUbLU66uze+/1oEasUf6G3wyK38oN+RJ5zCY
         Y8KUy1fFm6lTjiTWtO4ge/K0dosqn3EA1jlCNhAb/X+ZAuZJN0nG76qVLd4sFyVBQ9fr
         FnSqY37Iwo5Y3HjBcz/zQxbUGAAD8Q6BpjATN9P0x/6LucEC4ft1Ovw1+lrOUbWU0cJI
         Bu3rYT6hK8YBDZcDEom1Y6ro52HdcCwiZyHvJ7lAIzWGa4aBy5Y46sVMIRXp3fHos/Ao
         VbVg==
X-Gm-Message-State: AOAM530U2WnYXoheMTOvUeUSbPIs7BrLnkn0Y0Pq8rV06jpBvIs1Z0oo
        z+pvsLRl9wFm39HQN/KObB1YzlQ0t7fWlQ==
X-Google-Smtp-Source: ABdhPJzTkll5Ss5MzkWVquBaiCKQNw6kiY3p5pS1FTKKa1r8LPydpnojhPlV1KcyOnBX9X0/xp67Hw==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr4524568wml.86.1615301166378;
        Tue, 09 Mar 2021 06:46:06 -0800 (PST)
Received: from dell ([91.110.221.192])
        by smtp.gmail.com with ESMTPSA id j136sm4612067wmj.35.2021.03.09.06.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 06:46:05 -0800 (PST)
Date:   Tue, 9 Mar 2021 14:46:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: lm3533: Switch to using the new API kobj_to_dev()
Message-ID: <20210309144604.GQ4931@dell>
References: <1614073344-68361-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1614073344-68361-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021, Yang Li wrote:

> fixed the following coccicheck:
> ./drivers/mfd/lm3533-core.c:361:60-61: WARNING opportunity for
> kobj_to_dev()
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/mfd/lm3533-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixed up the commit message a bit and applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
