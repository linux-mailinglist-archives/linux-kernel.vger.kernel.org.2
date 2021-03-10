Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFA233374F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhCJIaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCJIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:30:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B90C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 00:30:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 7so22200867wrz.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 00:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3ilr9Chytc99dzJVMsZAwLaeZzrQPcuZ3XaLXQ1QBY0=;
        b=zHOJKF+SyI6yEGnRKh3OX5KoS/QuFS3VP/c8R/WIuCs/8AKJRI6d2loCLzpB/QAZzn
         1XG860ficzeyV2JigI+Qv7ibKki8MsBZEb/Bm913DrYfdzzOc5UD12/CEKXcNOY0eW51
         eGcngDyvHXtgBQc4cJ9X1ruTWOayE9qBSXvoKffqfNly+wVF/xx/ZN6G5Ja7cWOeu687
         NxSaatAWYsBi2uAXXHPtMX2tdj1KS4ipM+hS/V57FO/9PWlmPUfbg0cNsgqAKTZqPPiI
         PYwWqhEgupsmw7ARi6yuoyzF/e1s+/b8pzxgC23GGt93PridGDdHXmtg/Ax7wZPMNnNw
         szJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3ilr9Chytc99dzJVMsZAwLaeZzrQPcuZ3XaLXQ1QBY0=;
        b=o54ebmCdf+ET1QgHhFm5dGjZJrWKis4SNq1YTez3fiK30uEFJ8gRKdrKIzMPNS3laP
         GrW3GyRjWttdp35oXUEu5u5KZWNblcA3jZ1HHdGScaksUWX1R/fIW+rD7ptBiuOBRYQH
         eVcvSzY27DPux9wxE+s4Zc3DVWpD0H4DikyxVN1uNUTAhzL67gNBUtXOjUl9vdwVxg9a
         HbyQo8P1dekJmh/8xZGTrxOAg25YSg6Yfdc6YjGIjq5/AYMnL1b4Rq5xHocgxbT4WnJ8
         4i6C7+dbkZ5aDv6fyYCpD8ZBvLqLEbguJhYbN2+1lRG6wFiWLx9WCZcoskpwH/smvNKL
         nYLA==
X-Gm-Message-State: AOAM533sMSW7/J5TCrsLUXaHOwGPSuhQLoY9eVbs12vI/swHWgpch7z2
        uULg5QfSO+PO/XplFQPcy1g3/xrRf+Jt5w==
X-Google-Smtp-Source: ABdhPJypDrJJUnScjwafTP5SrISI0r7uunc7ObEd/3/KisvbdTiDQtSTObGKhsPE24OVmey5NjVS9w==
X-Received: by 2002:a5d:6ca6:: with SMTP id a6mr2183711wra.179.1615365048017;
        Wed, 10 Mar 2021 00:30:48 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id n186sm7922962wmn.22.2021.03.10.00.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 00:30:47 -0800 (PST)
Date:   Wed, 10 Mar 2021 08:30:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: dbx500-prcmu: Use true and false for bool
 variable
Message-ID: <20210310083045.GC4931@dell>
References: <1615348439-57732-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1615348439-57732-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021, Jiapeng Chong wrote:

> Fix the following coccicheck warning:
> 
> ./include/linux/mfd/db8500-prcmu.h:723:8-9: WARNING: return of 0/1 in
> function 'db8500_prcmu_is_ac_wake_requested' with return type bool.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   - Make the commit message more clearer.

I already fixed and applied this.

Please take a look at my reply to v1.

>  include/linux/mfd/db8500-prcmu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
