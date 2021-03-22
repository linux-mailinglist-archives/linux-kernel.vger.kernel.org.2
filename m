Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA95B34478A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhCVOjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCVOjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:39:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF690C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:39:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u5so21688429ejn.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9ZVRQe7UeIN1LaSWsj2SqLYuOC4omeooOyWyJLqzmEA=;
        b=jm/VrtqygC2uUDLEIFFET3iSwZoRcv1psnX3kDuqYG46aL4J899amACu9tpZ798o0j
         W6BOF3jMeIG3QvfVWpsaCmLmrK7N1YqvAfrO5Fow03qJD8HbnkdResTEUvsG0TL0fyhn
         0+0TGVJcdnmZSOfG51mXIdT4iN3ASsec7SoJyPV7biycLZzJK3H8LhBB8TeizeyDH+8U
         j2omx5lCeqENx/1gmKeXBg9i9JD5Dkk2dy+s8NOh4nFb67qjCOaxMQLJMXsTt7dQJQ4Q
         WKghZD+8Xw72TF1T+vAjoR4pBYENXRjKxG4PcaaPDbD2eQWtgQ+W4i3+r5+msJ3WLMMi
         mCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9ZVRQe7UeIN1LaSWsj2SqLYuOC4omeooOyWyJLqzmEA=;
        b=ig4VrIE2Xzo96FaRliQzS2WDUEUf7ttnwWBgYq8IPsadPvI1XB9DLEgucTuLyQN44S
         1ZCuaJO0P4QrpUnNB0GGUHi9OXMihmQlYAmDXOmsOb1WPSVtbdD+cUWnftCH3oVbI9+e
         oDYtOgh/v/z54k1+ZDPzE2iqxRlHKLkFLJpMXgY7xJrXC/jFaSPQDEs7DNEy3Y6GYXlh
         PyDXV/b9pIMt++wF9e5NeskzRLkUhPUqmthNVC0yuFKCSg7oHe1odFsyjR0DQfei31Cp
         WZKSNjQ+1jxjAbAYkmdIIFaCQO4ltP/Dz63RoHXJZZAgytvkgCIIdE3kZhS7jM+G4XZ/
         THFg==
X-Gm-Message-State: AOAM532F3eJaDap897teRpfBaixx3MVpSLFCDWrkNpn3bPVnsFCvm3Be
        PVHRjoFLkXCTC4WbhxzdIRub5lfaNd80ig==
X-Google-Smtp-Source: ABdhPJzWZyCyCMO1CPU+p7ACKSVrqLRCKV8o5cHzW4NOFBu6VlTCubpFKio6mel4VDM5N7/5Ko+Ilg==
X-Received: by 2002:a17:906:b817:: with SMTP id dv23mr36207ejb.281.1616423956637;
        Mon, 22 Mar 2021 07:39:16 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id kj3sm9879110ejc.117.2021.03.22.07.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:39:16 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:39:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] mfd: intel-lpss: Switch to use the software nodes
Message-ID: <20210322143914.GU2916463@dell>
References: <20210301144222.31290-1-andriy.shevchenko@linux.intel.com>
 <20210301144222.31290-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301144222.31290-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021, Andy Shevchenko wrote:

> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Software node was always created for the device if it was
> supplied with additional device properties, so those nodes
> might as well be constant.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-acpi.c | 24 +++++++++++++++++++----
>  drivers/mfd/intel-lpss-pci.c  | 36 +++++++++++++++++++++++++++--------
>  drivers/mfd/intel-lpss.c      |  2 +-
>  drivers/mfd/intel-lpss.h      |  4 ++--
>  4 files changed, 51 insertions(+), 15 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
