Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851C3414C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbhIVOq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhIVOq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:46:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ABDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:44:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i23so7675322wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/UqkiTbQCfJh5aABZrPoa9gs1Z/m7zmL0lEew+YjSOQ=;
        b=seuC0u61i0x7pS7Xo8kiRlaehRAAefbeFxGUsduKdMNSkng4Qw7oOU1ze8bSXvpWAn
         Pk2Y3pQS5EAtzqnKWQLSiCXZa8OiZcLKoBgtXoUnUfntOAVXh+Xyxlc4nz1S/L0+AUP9
         x3kfBetezgTtoGRtgD3xIdrGs7CvQymxnqT3/wJize6rdjWyC4s0i46AlBCeJEX7hZ17
         s+oxz+okN5w6OvSitqWQvrSiUrzL+X7yyo9vsDDL7JO6Ys0slU0d8LdcKrb/p+2vroQ0
         4tew94R/Y2cvh6d1dGzHGABTMn5u7hWQFzKPkhWnacNek1z8kJ4A+NVXbd4buDj3N3u+
         izyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/UqkiTbQCfJh5aABZrPoa9gs1Z/m7zmL0lEew+YjSOQ=;
        b=cZFhJMyld+E/RAAtUloKHIvG08VjoYBiNC2auvb6Znhu5yEw2AfJvfTQmNyXV87H/3
         f8/xqNODeL1XABqwqHX7mB47YTYK9IJD+1UPm0Uejr6CVEqWoEVCIaByg7z0uEIT2tU9
         JS5LFLbhz5M2ipeAFcMrjuna03GboZOTdV2aiSzQ8rQTROoUNcct/MmM/KIofl7kQt59
         QpbzsVxDHaFBgMRM4DuJiPi+DZFy6EodwfCSLoZFfiCDLDc4BpJt5zJbn2YT9zTiBD/A
         /MjwFszMfOJFmhsrEhfUEASJgQ8qPI/fHSwaMFzms8kbad4svYigNfswHhHbYg7zQfB/
         5M8w==
X-Gm-Message-State: AOAM532NTqFQHFPJyPVgVkiTmbIJg5L9dKf7rF03GQTjgTSoG2pAieFF
        L4cYdptUMzf0Od/Ee3F2NwKZREEo8WVDGA==
X-Google-Smtp-Source: ABdhPJyWH1QP4/43lGXC2dLB3FM/736vIA3wf9mwa+WrXSFNRhitUbAd8IErf/T6mYfcvuZokEOIjQ==
X-Received: by 2002:a5d:4d02:: with SMTP id z2mr43278757wrt.8.1632321897201;
        Wed, 22 Sep 2021 07:44:57 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id w5sm2375705wra.87.2021.09.22.07.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 07:44:56 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:44:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] mfd: cros_ec: drop unneeded MODULE_ALIAS
Message-ID: <YUtBZp4iA38846Pd@google.com>
References: <20210916170534.138395-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210916170534.138395-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021, Krzysztof Kozlowski wrote:

> The MODULE_DEVICE_TABLE already creates proper alias.  Having another
> MODULE_ALIAS causes the alias to be duplicated:
> 
>   $ modinfo cros_ec_dev.ko
> 
>   alias:          platform:cros-ec-dev
>   srcversion:     F84A69D2156719A4F717A76
>   alias:          platform:cros-ec-dev
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/mfd/cros_ec_dev.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
