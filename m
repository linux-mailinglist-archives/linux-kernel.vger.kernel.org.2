Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA44142D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhIVHn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 03:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhIVHn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:43:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A334BC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 00:42:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t8so4111527wri.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=d55eamAySqf8b3clxNZoYmb1gYK8E1S3WLes7WqiIfs=;
        b=En1Lrh7mJNVgVfiySVL3wAibVB+mnm4S6GcLAluUemGC1iyQv+uSCHQEaTfHVObjy8
         XKOJ+SSfS5C8/i1rSH2QC4BBMkqkTQdNa2QXwdqkiMPCv9EyXNF3YE4Sl+gKkIvkobvv
         hM+xBoJ6LP8jak9c+k7JBFdT2syJ00EnZ3UtZw42KWWR1W27AiX5A8RSLzMT+M/Nvvjp
         t05X7P5wZmqhW3z+Byx/KoWs+YkCoYSQepiyQirmaBx9sGaSwagFKHkwqw4flL/V+U9H
         jIr3FdUZSoMSvceDmnAoOvmt9le3rU1Jqu+jp0bCSGo+7PqOvs2MjD4peYfi2JvnnBzs
         e2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d55eamAySqf8b3clxNZoYmb1gYK8E1S3WLes7WqiIfs=;
        b=IuhoWQcDdTwDMZJDbAfm7yLezaxHAkyh3vHRdT2feXbXmzW5FBc5ElcznJCZHiP87+
         zlhvPdbdJPoz1RQxiM9+ermSQO0WFdfEeAThVoxvDZWEgC1NMm54sxys3nAkWXaPdYgO
         oA+5snVZX6BngmYGQPr8Gk6Yt1ZRic5jCEccbwFdYEw0Z1kA3Ua6XO/3hw5cJ7SFckaV
         EHPC2yds/Y8EgS7Y6hKczTI7IcqYGepjJ9OG+nRsggpuk1tMgE8cCET+vRjhmP47IkPH
         +SRyIw+cXfOZxwXsR7hGP3OwDxSw04Eke/QKDQ/y3QNpuTe4ylbAIzAVO5BMSMHk2HCf
         2tHw==
X-Gm-Message-State: AOAM533vEvZG9vlPG98s05sElOtc1Ud1sI741lSq5vUSBeWsfJFJSWc6
        pV3lBoxfTMmWvIETd6r7Fk968w==
X-Google-Smtp-Source: ABdhPJwGkzewC3Vv9V1KSEEwR05eeenEIB8MnobkkJ+f5yCBcI7TqKeLe7zyybS4E80mygjrwaogpw==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr40525701wrx.126.1632296545202;
        Wed, 22 Sep 2021 00:42:25 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id b207sm1129023wmb.29.2021.09.22.00.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 00:42:24 -0700 (PDT)
Date:   Wed, 22 Sep 2021 08:42:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     min.li.xe@renesas.com
Cc:     richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ptp: clockmatrix: use rsmu driver to access i2c/spi
 bus
Message-ID: <YUreX2Mzif7o0C1n@google.com>
References: <1632251697-1928-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1632251697-1928-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021, min.li.xe@renesas.com wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> rsmu (Renesas Synchronization Management Unit ) driver is located in
> drivers/mfd and responsible for creating multiple devices including
> clockmatrix phc, which will then use the exposed regmap and mutex
> handle to access i2c/spi bus.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/ptp/idt8a340_reg.h       | 783 ---------------------------------------
>  drivers/ptp/ptp_clockmatrix.c    | 769 ++++++++++++++++++++------------------
>  drivers/ptp/ptp_clockmatrix.h    | 117 +-----

>  include/linux/mfd/idt8a340_reg.h |  31 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  4 files changed, 460 insertions(+), 1240 deletions(-)
>  delete mode 100644 drivers/ptp/idt8a340_reg.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
