Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB3423944
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbhJFIAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbhJFIAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:00:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14881C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:58:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v17so5994406wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uCvLZpthRtLw9J2e0dZt5jixJRR9nvmQHa4fpaouL4s=;
        b=s7AhNCJnIZYraVKPzqQf/DlIWMkCrQk5/W9khEPcQIae3YaF4aYv0rjqaEJjdszDrt
         ygEqCw/gSMjwvk/4rClXWZfcXAZRoZFsR7pp2QoOW3iexddVyEbweLDdtsFKVngwGpSc
         zwe/rntlB5PmLq4U81LohZH4+QOF4AbW4guT/pZcHtTavfsYlSAg1TReQh0Ac86H7ek4
         eA8Kr6/u6e52LSQhHk38XZ+w0c3Xz9nBS/QDyKFFYAFmZbGebSZP6M6obKsaGrGasYp+
         K9/oHYVqoXZVHG7xbSxEnEiErKYuOe1cSW6rIUmyQkhobfkodpVQIigwhOzeRZfsTZe3
         istA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uCvLZpthRtLw9J2e0dZt5jixJRR9nvmQHa4fpaouL4s=;
        b=kqMad1IC8gaImu5qD6i0ukBqslkSJJYXguO6ipDvpCxSrO61WRfWWB2/xeVlP4ZDtT
         GzAYtciWtNWZs+0js5OsBdpYqcDEtiGumu1oGo8lsro+MT1S6Oht5cCK5U+ID6d9pHPo
         HlnkuLCDmwVwSET5q1ZCcLlgRY5TmUQCB4/yqL7NjQgWZo1lvI/56ckZO4OXRhRQ2vYK
         ag5QckukPu9Eao8yUHkCmcGLHE2Yv/nRp+ufMRY0MHZGj8d5fRqiaWp2qy+/Pxl5RAf9
         xZgkAojQiAMTOMlJ3I3Yf2vYhnANXfORety1ueWQ/Hfg+UgQdt+E8X2cDKdEjX+PTC4e
         Y1gw==
X-Gm-Message-State: AOAM53199c5J7hNXHarV03HHLBWQctJNMlST1R5dAYMQ3B/Itrjd65PZ
        AdFFRXHz5kCf8OioBWZ/psxriQ==
X-Google-Smtp-Source: ABdhPJxY14nEcYn74AmPQN8Q/ord0ogQGSaDZZ/ooO7AF54xAZtR0QPR+DvBy8xZ3aDDvr7DswORmA==
X-Received: by 2002:adf:b19c:: with SMTP id q28mr27001218wra.348.1633507104602;
        Wed, 06 Oct 2021 00:58:24 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id d8sm21288609wrv.80.2021.10.06.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 00:58:24 -0700 (PDT)
Date:   Wed, 6 Oct 2021 08:58:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mfd: Add missing of_node_put for loop iteration
Message-ID: <YV1XHt0ykUKCfibv@google.com>
References: <20210528115126.18370-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210528115126.18370-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021, Krzysztof Kozlowski wrote:

> Early exits from for_each_child_of_node() should decrement the
> node reference counter.  Reported by Coccinelle:
> 
>   drivers/mfd/mfd-core.c:197:2-24: WARNING:
>     Function "for_each_child_of_node" should have of_node_put() before goto around lines 209.
> 
> Fixes: c94bb233a9fe ("mfd: Make MFD core code Device Tree and IRQ domain aware")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/mfd/mfd-core.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
