Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD73891ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354824AbhESOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354821AbhESOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:52:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8985FC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:50:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z17so14311932wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jzOpdXiLDWGUEJF2EPWEV2fpTf3RICa3e5yUqeDdorw=;
        b=fmjuW1CE4yNWATIkEhIlhyAcIxhBepjY8dpsjmF2trgLwRV+pzo0bH/7HF3nswJyw9
         tJjev238hlq7nt4aq8KDfWgybqHJQ1sVX3XVwNQYj5WvBXSwPyxY0wwnALzCORKlGvOA
         E1ZkZLwOqheyT+JGldJiWWmlyqeC/ObjpVEGdcx7Tk4f6iYftuJme720nKySAaPYgLvB
         UiYDdHFWvYRKcgYI91gMeWNo7XjlgwZ9ZOybn3JdM8O1CQ2VZIyh1Iy1J2f7t6hLOAzg
         0MEknxvzch90W0UK2WPHLw4NzZkINEn0mpEx+XL8Q4sleiVJ8VSIXtmgadfq6Hv8hoDB
         gPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jzOpdXiLDWGUEJF2EPWEV2fpTf3RICa3e5yUqeDdorw=;
        b=jkZK2E7jNN5i9aMglVPPz5drYlvQSoDg8fuoQ+uXfNpNKVhs0baKAHDbsUTz/RQSK/
         yUoReW6+k38KKqbzq3iYTpxBrWLOhbDzSX2lPgOEcy8p4I6QQkQw+kOV7dWtKQR9UGzT
         rOIrJs3ot3jWt1amT995poa+MhrjrAKC2O34WGXkU7+6venEF9So1tqNHO7vztB5j05u
         BRn4OA2xWfys+n9DTYpJVssnLAbfMmSe4uGDbOxEevjnFDS2bdb7EgOLXwUwcbGTyCcv
         qKt4ij94NCbphZJtDlcu9BOM1ySmc7NMmxs/toJuzcT8tSllIqWg9EEqHhYTk/69QXGg
         rOeg==
X-Gm-Message-State: AOAM533BEOxdbmH5ZfpAU8WdRO8lKDy890QeO6UpvB0Mw62CcOo4mFkn
        GUaKeH57gI2Z2S/ApeUgVNmzPw==
X-Google-Smtp-Source: ABdhPJy4j2tptE/O7091QF9VE/9nmRwj16cpS+71mXYwcpZQStXYpsYFrQKNwdyhvJoa0BGQe/yvAg==
X-Received: by 2002:a5d:534f:: with SMTP id t15mr14628914wrv.206.1621435843140;
        Wed, 19 May 2021 07:50:43 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id d9sm24271551wrx.11.2021.05.19.07.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:50:42 -0700 (PDT)
Date:   Wed, 19 May 2021 15:50:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, pavel@ucw.cz, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, cy_huang@richtek.com
Subject: Re: [PATCH v7 2/4] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Message-ID: <20210519145040.GE2549456@dell>
References: <1621262161-9972-1-git-send-email-u0084500@gmail.com>
 <1621262161-9972-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1621262161-9972-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831 backlight.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> since v7
> - Add allOf property refer to common.yaml.
> - Remove default-brightness/max-brightness description and refer string.
> ---
>  .../leds/backlight/richtek,rt4831-backlight.yaml   | 62 ++++++++++++++++++++++
>  include/dt-bindings/leds/rt4831-backlight.h        | 23 ++++++++
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
>  create mode 100644 include/dt-bindings/leds/rt4831-backlight.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
