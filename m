Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74845397803
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhFAQ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAQ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:28:25 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3E3C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:26:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j14so14985828wrq.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3qOQncXWcmTagrRnUN7xPwpRuDjJHMU3NDeiXjxsC04=;
        b=Q4UQpith9NJSzA3Ospei0Bw1mvGVa0w89R29XVu0wKwJvBGcEVnUtMRn8e9xMKE0AK
         2Ap4Q8kWdiQ6iBjPAwFPvOk4vIpQVkbGQpHo0yF34mcg+gbyZxY4Q4TmiTFxKGhdjliu
         gpHMHprjHINFQeXihuzRgGaHRwwJab9S7xk0l9HRhEKybgx20hxnks8hG4P0MjMMgonv
         /Fo607iUYWugl6neBdvC0KuG2IPQDnttRH/iGRaLS3/7cNkkrpwickMj0WLfejmbQOLX
         l/G6ODram+H62iUiXJ25jEtgl1LZnmc0136U8jBZdaxOGtNVRZmeKJiN3Woh1onCPEKF
         HztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3qOQncXWcmTagrRnUN7xPwpRuDjJHMU3NDeiXjxsC04=;
        b=pav3vBHt6hDlV72apadDiK8sygp58JPVltcFcGG0jQbb7b2TpPmWReNiiwns4oAq0N
         ZqWFDvjq2g/AnBqL7r6H9mJPaCP4vhnrARSM1QLi801zt4D9MMYBYGrhRLpiRNYLBrdg
         mEj2YEda5kOrR17VLtBem4lP4EM5jIcUHp9prG1EL6n/EUJGBlLB8tQoRgQIMSxIEKhQ
         8aefSNmRJ5Q4I3t+5F7DhF3Er/5Ojp8W8x+qxyBMimNAp/tgiJhN5Qj7EgNpcf9vPokL
         nS1+U+rLwyPMxQy/96OEA4pVhT+UBu9h8R7fTYBs/BkYAsxz18ONLj/vbyp4UBMM7uJd
         qMOQ==
X-Gm-Message-State: AOAM530G8xvYZUywJ/8xKiVTMWioj5NJYm0WqRXFZ/JhE+9MHea968tg
        Gl+x/I5zBvX4+OCoTVkXsPV2HA==
X-Google-Smtp-Source: ABdhPJzz/8Ro1pa/8xroirV4pUUj3sHXXH1wBBHnxdukJhb7RDxwxT+OyE6j+YMnWmfO587jWBJfqw==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr27799191wrf.130.1622564801308;
        Tue, 01 Jun 2021 09:26:41 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id h15sm10735wmq.1.2021.06.01.09.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:26:40 -0700 (PDT)
Date:   Tue, 1 Jun 2021 17:26:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     arnd@arndb.de, robh+dt@kernel.org, Marek Vasut <marex@denx.de>,
        jagan@amarulasolutions.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH 04/13] dt-bindings: mfd: stm32-timers: remove
 #address/size cells from required properties
Message-ID: <20210601162638.GF2165650@dell>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-5-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210415101037.1465-5-alexandre.torgue@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021, Alexandre Torgue wrote:

> address-cells and size-cells can't be declared as "required" properties
> as they are not needed if subnodes don't have a "reg" entry.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
