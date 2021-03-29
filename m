Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96FE34D0C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhC2NAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhC2NAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:00:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B823C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:00:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g20so6568923wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jCUqg4nsEzEqtyzud18lcBEpBdMMiZlVAoErgBu3JkY=;
        b=vOt0R8wK8tF4UmjM2P1wuE4cJ7w969xRcI1DYLEWFa4igqbgEv4O6XjVlYwnX9sbOD
         OT+wp3zgGntZ3aYtYDC0aHemcddiilzD/v+jvl4QgQyOnb9JTNR3xcuvG2RLLlYDFFv4
         fMj+2HOhvCYOdoxXgc8zNK4lrfsFrFPyOwjgvS5p4KK4mODTquxlX9IRmlXLXW/m6rTZ
         lePrVC7xWVIyaqmxnSB9esvMPa5g+1Aqrwl+IhdU2HaAQwQEvrAxgjD4zvMR3ujyDTmg
         9kN0oAr3pxjDZPxMSEdCYcr0BWS3C66EFc0Y45lkUME1vK923EMkDwlJ8QGv+ZxozsVi
         tytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jCUqg4nsEzEqtyzud18lcBEpBdMMiZlVAoErgBu3JkY=;
        b=TTMbNihBcgr+9BgLm+f+LAII5aZiBJ3Nj1Jn5ejJgH7Z4fj/C5YPID8hNDyY2t7GR/
         pnH1VMJj06W632OtmsiyJfil8Kq9elCtvXafNkrYelm1/w1g/YFJfibOfaHICAEUjiRx
         M5jHLlKIjjml6KmbJKQyn6MFIshNwVib3p01Rca62IM1II+ZIHiRR3TJ+xRW8hD6OFE/
         Kc3S2lQN9VKh7ZhsQsz5nPq7YJfLtx1DuVXEGCY7OerVeZV58ZDq1ZBVPPagCxEUlmTV
         vL2HX0L35786++UKnO1HMzvKZrRQzL0ZBkUC1x3L9jfxfnxWFLbZ6NjpRCToK3K0V2Qh
         BYww==
X-Gm-Message-State: AOAM533yFgpj8i4QErj/XO2ib4c3edEKbDOLGrszBERKz2+0t8IHqxex
        hVDlijcFDhl+Y0AODA1Bx0gHsQ==
X-Google-Smtp-Source: ABdhPJyQFDQ3f0eu2peFHQzda+vDUvw89r6ri/h5SbAo6VJHOhtIUv6JMIaMb1sGCHNr1ab0gPPiDA==
X-Received: by 2002:a1c:4382:: with SMTP id q124mr25026035wma.16.1617022809717;
        Mon, 29 Mar 2021 06:00:09 -0700 (PDT)
Received: from dell ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id t1sm34302738wry.90.2021.03.29.06.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:00:09 -0700 (PDT)
Date:   Mon, 29 Mar 2021 14:00:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 23/25] HID: hid-sensor-hub: Move 'hsdev' description to
 correct struct definition
Message-ID: <20210329130007.GE2916463@dell>
References: <20210326143458.508959-1-lee.jones@linaro.org>
 <20210326143458.508959-25-lee.jones@linaro.org>
 <20210329123020.10250228@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210329123020.10250228@jic23-huawei>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021, Jonathan Cameron wrote:

> On Fri, 26 Mar 2021 14:34:56 +0000
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/hid/hid-sensor-hub.c:54: warning: Function parameter or member 'hsdev' not described in 'hid_sensor_hub_callbacks_list'
> > 
> 
> Perhaps nice to mention that this was a result of
> 
> ca2ed12f163b ("HID: hid-sensor-hub: Processing for duplicate physical ids")

I only tend to do that for Fixes: tags, but Greg has made it clear
that these patches are not suitable for stable.

> > Cc: Jiri Kosina <jikos@kernel.org>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Cc: linux-input@vger.kernel.org
> > Cc: linux-iio@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>

> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks dude, much appreciated.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
