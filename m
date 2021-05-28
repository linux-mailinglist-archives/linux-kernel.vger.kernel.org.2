Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C83C3946F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhE1S15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhE1S14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:27:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCDBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:26:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z17so4167866wrq.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GB90gywFXxz6C4VQo267CgkB+2UX9a38YgOqAiS33gE=;
        b=Se6XEw+2WJidqePob89BwGd7MIJwxqyJbrY1ASEOs5LH1t9FqSSaqdfPuiSz5Ch8LC
         BRUdEaGCM5uzrimuqnG9dAWJuoVYDr98kCvPRuU3OqawlnbSEdmollFndMcVp68byCr3
         K9CY+Aa7kVZtBlTDUyx3ood2yz/sjpdSVrX/yn6RzbkL4oYEhm+Cg/F2A+KOBs9JMbm1
         WUuJbpKxI23rbmeSormT6VN3z3JSaHxVuQRGHylGr9ID6jVr2dcfdEpthpjgZE7NFEUD
         VR7QZYI5iQZdc7NWD+NUNB353NQzPFdUkFWs5oxCVReoHiMLB/vhetMhVGGcITLYUBZY
         TKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GB90gywFXxz6C4VQo267CgkB+2UX9a38YgOqAiS33gE=;
        b=ovmnbJh3sbBcDzdqTPTThGYJE3CdlntvGAYePUGJF1rneyu4DIKvwL6BrDWPuWGSQR
         cpF9GWOSeELRT0oE3Fc41D0NWdEE9Yrtw4EOpJ9DZGBmrQiFdntxG4hlZugW6L1LrgIe
         6fsncemR/Btvo0HKc/FaCIyX6lzPM5TMeedTYGazpQWSyNDVH96AWFeI4WvEiL39O+ka
         r54u9J9cMewISXF/b/6baaHdp8C6d/4aVAC4ksVSfj4NR74HFnb9p4gSo8EoUFjkt0jU
         OsTEAsQT6V6Sq7FmoHMblvYLi0RjzHceEugR6a2o+BELCosJbMq9ku0K1kKuhR+7ldK7
         CiPw==
X-Gm-Message-State: AOAM531rz5tR2qEaVRlrRw+d2pZcNP2qzkDK49QqZL1re2+NnPBP8bB4
        D3WYTqaPxzM0hl8ptmNSvaKweA==
X-Google-Smtp-Source: ABdhPJwPtOD2198lQyApL0Qva918Tg+Ju/9BKJTcfdW0irv0YwWm+lrrOhzaY6jmtfC50E2y6j7ABQ==
X-Received: by 2002:adf:9f51:: with SMTP id f17mr9941105wrg.3.1622226379152;
        Fri, 28 May 2021 11:26:19 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id h15sm7263730wmq.1.2021.05.28.11.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 11:26:18 -0700 (PDT)
Date:   Fri, 28 May 2021 19:26:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com
Subject: Re: [PATCH] mfd:Add SUNIX mfd & PCIe driver
Message-ID: <20210528182617.GS543307@dell>
References: <20210528095845.6991-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210528095845.6991-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021, Moriis Ku wrote:

> From: Morris Ku <saumah@gmail.com>
> 
> Add SUNIX mfd & PCIe driver
> 
> Cc: Jason Lee <jason_lee@sunix.com>
> Cc: Taian Chen <taian.chen@sunix.com>
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  sdc_mfd.c | 513 ++++++++++++++++++++++++++++++++++++++++++++++++++++++

To be frank, this is a bit of a mess.

Let's take one step back for a moment.

Please tell me how this compares to any existing driver currently
present in drivers/mfd.  I'm 100% sure this H/W is not different to
anything we've seen before.  Thus, my advice is to base it off of a
piece of code that has been previously accepted and take it from
there.

>  sdc_mfd.h |  61 +++++++
>  sdc_pci.c |  92 ++++++++++
>  3 files changed, 666 insertions(+)
>  create mode 100644 sdc_mfd.c
>  create mode 100644 sdc_mfd.h
>  create mode 100644 sdc_pci.c


-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
