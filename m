Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20263DD174
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhHBHqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhHBHqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:46:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22B8C0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 00:45:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h13so6845799wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=b8jW3IOV41KMKmqVpH+AdE0I3WMSTbX/8dDvcRHBAMs=;
        b=aQaWN4h7IGm0JCqpgaw2HOVw0Qsbd6HJLFAO+r8LxOSCwJHW825mmT8bYNlgOxB1iw
         EtjH4/xZ2c2/9a2E8XZ8OJD853/W79XLv+bQHWmVCvTSGBibu4vkt6MabW4eiiw2FEsQ
         n1JaINCWIyipRfaoBF3QJKDzrIrsIX1lrRPz59yIb33VfhPV3szO0xWEHTjLvbkh00nM
         Wd0efPTo4An+XrMoIQtnNxjfY1Pu40qychT3RFqP7jQQMd7cjBFopbjsdMMzExR1NJpI
         dRYvxGoZPcLA1ndgCODkH9+KxU/Qdlgz1Pk1YPU/6tjz1fvuE34ffJbCbN8YFXkn8rt5
         KwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b8jW3IOV41KMKmqVpH+AdE0I3WMSTbX/8dDvcRHBAMs=;
        b=TLNh5RcHnnbmHT5wifNVQgkavdYa4LQYqeoAk1snnjePSVCavf+kZ62CkFTiWcKta0
         ABctxV1fdvKJAHgmZRxZI55URGqghurVONaT4IntCKuul3hGbmKENAX5KnzN+2Ni/biL
         HscQmJSZ5/J/u1T6dJTaDd1bhmltBq6BTQ6/+iNf8EJuHUUyFqGlfdBahz1pMqZ1A6qi
         XtzQIqPnYxQXRZJqvSof3qyVRGUvEn9PbGIvdjWFO2fZT5H71dJ+f9hoNm7uoUCRRf4X
         gpw7vpNUP5aKMMF6RfwTcF++fpfWm1tyt+o6fGgdqShwEG7cQicQhC3HQM+44KYwPl25
         I/8g==
X-Gm-Message-State: AOAM532JTeNO7leC3u5VxovKpcGz4EZ1WvNgbLjFoSeEDL3OKbz1B5UT
        p04Q0F2tTwfXLhAtucOVTQZ8Sg==
X-Google-Smtp-Source: ABdhPJwQQkroMNYDfuvpsIDOf0GjPS2wAm+W/G0POKYBXcirQeTE1zN6cYDtTrMhrEyMTjslZ3pWlw==
X-Received: by 2002:a05:6000:186f:: with SMTP id d15mr4276531wri.89.1627890353495;
        Mon, 02 Aug 2021 00:45:53 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id x16sm10552433wru.40.2021.08.02.00.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 00:45:52 -0700 (PDT)
Date:   Mon, 2 Aug 2021 08:45:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: db8500-prcmu: Adjust map to reality
Message-ID: <YQeir0PbUAEXC26F@google.com>
References: <20210801233314.3150754-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210801233314.3150754-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021, Linus Walleij wrote:

> These are the actual frequencies reported by the PLL, so let's
> report these. The roundoffs are inappropriate, we should round
> to the frequency that the clock will later report.
> 
> Drop some whitespace at the same time.
> 
> Cc: phone-devel@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
