Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4560845C91E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242076AbhKXPsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhKXPss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:48:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EECAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:45:38 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a18so4976189wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gCMiGATfuKFNvhjai5hA/48G/fLNoKNdO6OP8Yup/4M=;
        b=CkVbdCaWAb6m0dMBGC8Z5BlM58LWgarAQ32uX/q68uQ2I7F/F79VZTOtG4VdFtGYH6
         EJhU5vuiztCdt0BeO5KBNWOXooV71TSgaKa1F+HQpc0gWJLXW1IIdxJ3N5o5hH+b9jxo
         vo6pyuonFjbHgwbaVEYKXh1di5e2iEcDl3trvUEmitnxkAMNIz6HlFQ9dQZf7p4qKfH1
         Ja3ycs8GWgi1l55P0Y5N085pVrbzUENtRW3sfCoSSR6CpvmlF80TpPkD63+5wnHyNYkp
         umEgbcqeaBj22ptswj7tffLKUIZMvmRw4P5w6SFR9JBQEQzhxHDFWh+XL6x6rW5yHnIQ
         hYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gCMiGATfuKFNvhjai5hA/48G/fLNoKNdO6OP8Yup/4M=;
        b=zrKk/XOSBX3qlWYPUq9+s0tuzIMz2XNLgtrNc0dWI3KZPrXh7NQaGMG7tiiD2zSh51
         zdoDxlDZ2U7E48F/9F7LrEAQEI7yEqIAQOXFtJZ9hx245KuLv1WF/2SfcGW9TJu6I2ns
         +TDPHVDFFCrauk99LXg4oGcrqZcMDq0Jk7C6YYZq0vJbaUW1IDi5frUXJAKPr1T6os/h
         WrWlswsW8pkhyFOqz8v7XwiNFE/JM0tFUwJc623QLxZeA4/a7qhCftMBQrZp6gNryZKk
         l7RrKS33g7KNLCDh3e0zjk6DCoJ6Yyyyk+VJLiiwiOppUU9pnWpruoyZyWjw1n5OhuRH
         YbEg==
X-Gm-Message-State: AOAM532pyuMgVeR7gkpebK3cQlNEYVvNbWl5tHpx/2qQzreggGyw1Roi
        IwdTMIkMWU+NGNI3IA2CcHEYng==
X-Google-Smtp-Source: ABdhPJxKP1EIe2YzDKu+gyYM9Ufj1TC/VyWllVX+bm0/ENSsvPRD/xHmWkwLeOOlgh8S00FJaVOL1A==
X-Received: by 2002:adf:ce03:: with SMTP id p3mr20439457wrn.145.1637768736246;
        Wed, 24 Nov 2021 07:45:36 -0800 (PST)
Received: from google.com ([2.31.167.61])
        by smtp.gmail.com with ESMTPSA id o4sm219343wry.80.2021.11.24.07.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:45:35 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:45:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        marcel.ziswiler@toradex.com,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: stmpe: Support disabling sub-functions
Message-ID: <YZ5eGRC7XhrbgsN7@google.com>
References: <20211027082155.206449-1-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211027082155.206449-1-francesco.dolcini@toradex.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021, Francesco Dolcini wrote:

> From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> 
> Add support of sub-functions disabling. It allows one to define
> an stmpe sub-function device in devicetree, but keep it disabled.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> Hello,
> the main reason for this patch is to allow enabling/disabling sub-fuctions
> using DTS overlay to enable more flexibility on SoM/Carrier boards
> combinations.
> ---
>  drivers/mfd/stmpe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
