Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D1A35F004
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhDNIoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243057AbhDNIoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:44:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C58C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:43:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r9so30170220ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6SQfNRGxSjXRzedcsX9gd93FwU4XNVzxarlmDX1+Htg=;
        b=eI+o9nvwetyLFlEebNLWvXJTKP1fojiRNrpkjoQvQXmF8TZDu8IkJxXtAj0iumSH/L
         Oqnhc+/lGuZWPtl24duYGsLFeRXWlLxbRsVwUzOd4+IJ1kEPW7CoJJLSRxp307itbxOJ
         48HMquiHGXIUpopas+i8vMSw2B9eA2bpMNgEfNbXAj4silYIfb+OibEjRXUsBQ56hztY
         zA40sC5EDA4WhSDUp8ykRzEdNoaxDT3ANeyYZdw38wX54PazAXCN6HdqIK16pwGvhKy8
         mF8FQ2csq09pBwYFNZDkFNQIedRM1AXVM4aCZOiEsi+50Kmo+8kFph3Fv3bHXvuVRkHG
         8pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6SQfNRGxSjXRzedcsX9gd93FwU4XNVzxarlmDX1+Htg=;
        b=cG7Xt32Xxsqsc+j3/IQ3roqButs99WURYObAbgp2RtdX2Rrbt960hR1e62SMDbWv48
         o7WIrIUcBNdz8ObKHqEaD/GYH2ODIw6XQ++jcz216vzLx/OrSzNAjauwbzjmfAm8tels
         UfGEUKwNI4wcdAG3651DNG9ryGnV+CpEAzCGq6jMKytkRLHZ4OVQE926/Lwfoh/GPZvS
         nJc7RhRu2YrOjeKFKmLf5vhnnq+zF799lKBKtAwC/sxS6l/RKVLs/FvUdprQalhAQNDp
         Bgu2GUxOsHblP66w820UfZVpmjndENjDV1xkj3UnmkSsK7iOxOR9mgteLudjBdo1mZn1
         lkdA==
X-Gm-Message-State: AOAM532hnaqMLGyAcqV6ghb/DGf9bUsi+Wdsz+ZL8OjDHAFR8HoFWerV
        a+BzZkjcLrlSFDlmZERHEp2Tzw==
X-Google-Smtp-Source: ABdhPJxrggCrqwenEAzEx8qdYXHHJM7yO0JufM40aQaa2b/6v+yl9P6NFhxVbpEmKzkEFdQQwpFneA==
X-Received: by 2002:a17:907:961b:: with SMTP id gb27mr35528345ejc.402.1618389820552;
        Wed, 14 Apr 2021 01:43:40 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id w13sm10935849edc.81.2021.04.14.01.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:43:40 -0700 (PDT)
Date:   Wed, 14 Apr 2021 09:43:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] mfd: abx500: Remove repeated struct declaration
Message-ID: <20210414084338.GI4869@dell>
References: <20210401093052.1004712-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401093052.1004712-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Apr 2021, Wan Jiabing wrote:

> struct ab8500_fg is declared twice. The blew one at 457th line
> is closer to user. Remove the duplicate here.
> Move "Forward declaration" annotation to the suitable place.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  include/linux/mfd/abx500/ab8500-bm.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Please check, but I don't think this patch is valid anymore.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
