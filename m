Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB4D3ED47F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhHPNCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhHPNCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:02:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FDFC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:02:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r7so23599300wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KPWJKOlPjeyDb3fAxtx2j5zqy1mEAS/aOviHwpLJkcw=;
        b=Uca2Z73AvdyZDUWygjav7haKMpo2uqKqIJSEdzOCgL5ZvJi1IYo9hDqMisZsn+DYUX
         OvhNwcIo4JyRpndvv/VIgwnBdgkGZf75RvUDw1Ambl9wOhYy52XL7k+XqBdCEf7DXqWA
         P2JYKMR2Ig8tL4bhV5hJrmdFZfUthlagIo4yC35Fg8BvYPzuP5qU+KtJ9uFJLEmfnWoC
         6FUcS8xriYqdwLb/vsUBR7vpm6p5wjjzTiFI0T5j7yFs8F5y1uerM9+J7Zakw+lMiqDP
         kXZhaszKkxr76yckcr3/YvEUmJzRRuryPXbdMhVP8hp1bROZZpw2DNz8IUxtlz2N+DEH
         PGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KPWJKOlPjeyDb3fAxtx2j5zqy1mEAS/aOviHwpLJkcw=;
        b=qbv5L87N6/HuXo2gPFDxUXgObx5W23pxlsMcwUbP+y4R0HSWtov4Bw9B9o0OcvWtt3
         NUnKdW8GZA0rajaRNEXcLNExWOAhvUMsV+knQzZcDpkRz57jpsp8X/nmgIEIyRgf2vsf
         nKzUzQu0dQeHjpGOomnS5B9Spxnip4fMJg3PnWE1g3/nHNNWN+VsYLwJsdKMYxqpdo9x
         lWEFNftAFP0d2mEGzgvpghmfuCnc7rdRRo/OEBWas4qVPXN789CV9FcYnGRtQUapNMT+
         9NV/ZH84iyyL9qi5j1fIzvcWtuTIEWf1xMckO9MjVUVLSXzzJ0YUif0gwbSP1VDLGnrt
         ARYQ==
X-Gm-Message-State: AOAM5332OyOXaxpDakzeRSwoQMrz3HNzMYZfHyQ+yyFPReWVGu3j+Xp7
        zWMnOpu48I4lPnGoNa+CM9Qcm1jbtREAbEJI
X-Google-Smtp-Source: ABdhPJxSgWHeofgzUT5bmY8er3BPAleO269o7f3LswxczjcO/nrL+ntqLN/L386GSXtCXFgIcqZLuw==
X-Received: by 2002:a5d:688c:: with SMTP id h12mr18495280wru.313.1629118926997;
        Mon, 16 Aug 2021 06:02:06 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id i8sm10389918wma.7.2021.08.16.06.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 06:02:06 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:02:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] TQMx86: TQMx110EB and TQMxE40x MFD/GPIO support
Message-ID: <YRphzEn8T1HxE3I8@google.com>
References: <cover.1626429286.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1626429286.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021, Matthias Schiffer wrote:

> v3:
> - Removed Fixes tag from patch 3 again
> 
> v2: 
> - A number of new patches (more hardware support and a few fixes)
> - Patches 1-3 have gained Fixes tags
> - Patch 2 depends on 1, so maybe we can push the GPIO patch through the
>   MFD tree to keep them together?
> - The change in patch 7 was somewhat controversial. I've added a
>   warning, but it is the last patch of the series, so it doesn't affect
>   the rest of the series if it is rejected.
> 
> Matthias Schiffer (7):
>   gpio: tqmx86: really make IRQ optional

>   mfd: tqmx86: clear GPIO IRQ resource when no IRQ is set
>   mfd: tqmx86: remove incorrect TQMx90UC board ID
>   mfd: tqmx86: fix typo in "platform"
>   mfd: tqmx86: add support for TQMx110EB and TQMxE40x
>   mfd: tqmx86: add support for TQ-Systems DMI IDs
>   mfd: tqmx86: assume 24MHz LPC clock for unknown boards

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
