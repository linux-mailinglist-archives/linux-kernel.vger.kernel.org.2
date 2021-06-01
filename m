Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67719396FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhFAJHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbhFAJHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:07:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD4AC061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 02:05:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r13so7190700wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QUhFDerstAxyr6irnBl9NkzT4WPnjlKKvbshPAIqkEo=;
        b=zp1SXtpN6hI4oCC7g2rQTyveZKKAmnfThCEFh62kVdPD/vOx9tT1bU11furJACA9jc
         xKLyYaC359IN8CjRC+m/PYOJdzk6hInee+eHfgqmvdMXLcAIruekkKL/ef8393m2/EYq
         Y1X2vCmx9MvxSDppHu6/HbGcacLSxpgrZXn7n3cwzdxAYw6VGpyavc0W/pPpy8XDL0Uw
         W3kKW1NV2QWBqT2NO5CjZ9Dhp4yBQg9a2+5q7j+S5TJPYxTzbTz7gdXladf8FNTCcsBB
         uFoT7Cix/te4xC+qNwSnCCr4t7xY8Vny/hAoXl65tbN2zt2HTvESyE+en7sLaI+N1Mvj
         p6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QUhFDerstAxyr6irnBl9NkzT4WPnjlKKvbshPAIqkEo=;
        b=dpLAkuBkqfZMvCRCuslfs0lXTGt8HWXvLdGPsBEB6ubjKaxTKyep0R6MIv3txPlv0I
         cuOIn9FjtxFuwPWP0KxhOXa/f31d24FrQD0qE4vdyIOgb6+orVdH8x76EZXfVuzO2mS4
         70H0mQ7kNJg9Ij0k+CsYp6lWWDF6eccA9RD6YORLOHThB3ZjbeSo2Tisw6a2bPMuujsd
         TWe7/RRQb84i18AwHTAVZpAYJ7ckjfXaPDz0hlrAPVXGdtwNhyYxK658MlbB3Q9EXcrk
         u9dkRjbvb5ERUzENFz/jAQsYYkLfqbM0pRYMLr5/Zcd1QL9f+NmO8JCR/xjwr+e+Gs/S
         qk8A==
X-Gm-Message-State: AOAM533FeOTVhnauBgHztGXVyaIhoJmL5w23YHUwjjtzZYkt5+oHHrWZ
        N01+2EDbItjwFfugIaIgui8tGdeL2VnTXQ==
X-Google-Smtp-Source: ABdhPJygUor20K3OIq567hnldrC5HmWzjLbOh8a7I75zpzh3M6JmIsAQRxyFjm/LT8Uahw5lSSJsuA==
X-Received: by 2002:a1c:a484:: with SMTP id n126mr3623693wme.34.1622538352946;
        Tue, 01 Jun 2021 02:05:52 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id 92sm2668837wrp.88.2021.06.01.02.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:05:52 -0700 (PDT)
Date:   Tue, 1 Jun 2021 10:05:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        John Lenz <lenz@cs.wisc.edu>,
        Richard Purdie <rpurdie@openedhand.com>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 03/15] leds: led-class: Fix incorrectly documented param
 'dev'
Message-ID: <20210601090550.GZ543307@dell>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
 <20210528090629.1800173-4-lee.jones@linaro.org>
 <YLDBnIx/4L/O0oa0@ada.ifak-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YLDBnIx/4L/O0oa0@ada.ifak-system.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021, Alexander Dahl wrote:

> Hello,
> 
> Am Fri, May 28, 2021 at 10:06:17AM +0100 schrieb Lee Jones:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/leds/led-class.c:521: warning: Function parameter or member 'dev' not described in 'devm_led_classdev_unregister'
> >  drivers/leds/led-class.c:521: warning: Excess function parameter 'parent' description in 'devm_led_classdev_unregister'
> > 
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: John Lenz <lenz@cs.wisc.edu>
> > Cc: Richard Purdie <rpurdie@openedhand.com>
> > Cc: linux-leds@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/leds/led-class.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> > index 2e495ff678562..16271a1de12a7 100644
> > --- a/drivers/leds/led-class.c
> > +++ b/drivers/leds/led-class.c
> > @@ -513,7 +513,7 @@ static int devm_led_classdev_match(struct device *dev, void *res, void *data)
> >  
> >  /**
> >   * devm_led_classdev_unregister() - resource managed led_classdev_unregister()
> > - * @parent: The device to unregister.
> > + * @dev: The device to unregister.
> >   * @led_cdev: the led_classdev structure for this device.
> >   */
> >  void devm_led_classdev_unregister(struct device *dev,
> 
> Fixes: ca1bb4ee4c3a ("leds: Introduce devres helper for led_classdev_register")

Kernel-doc fix-ups do not qualify for Stable unfortunately.

> Reviewed-by: Alexander Dahl <ada@thorsis.com>

Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
