Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE8E4437FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhKBVo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhKBVoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:44:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7305FC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 14:42:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r8so580145wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=++s5U25AmrtB0jRnPpON4TpfrUm8lCjgAhvwZZmMcyk=;
        b=ypsj6Ztj6KKT7yYtszeRDXqjLyZmFUoIc+pxUWoktkz3jaSW6u2HbXU9Bl27QlJsl0
         IWvAbSyqQ0WxqnNA+uYNY973Li8SVWTmbRsqnS11uD6ZwfizcpG3d0twxYCkNSiFdZ8A
         yajUdx3i+Tn1HCidgUivgNykquHBWP/isqlmQY7+Nzjv9Z5FnpKswnFgweJTvVPjQ2Mb
         aMd0ytn8pyd8gAAfCxVvIy7VFJoxgv11UiuwG1pkK5jdHWmP8I9DBnl5oFmChc0h4wIY
         hJUzmoQKiTrYN+UauG/GalqSk3lqXw/Q25UCoakaIc3KigU0ObihOu3kT2sed6VD3B7M
         DBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=++s5U25AmrtB0jRnPpON4TpfrUm8lCjgAhvwZZmMcyk=;
        b=EsbxtxlshTtYP4Ged4I+X7CIN5UJsqnnFIvVxwr9kx92pSZLx05syi4K6CJmasJ50Z
         VIWFwgGbRA8ZRTNFDKlCeJqg+TSgSeMWM0OUCmAFfzdRkEOQjpiezSyd0JkI+OYIgAk3
         CMIpTcwW68BnL082lC3z2UKWkIyvTDTl66s35v1wIanX/yw23y5PQIh0RYfyUJaYUOMH
         wC1Yqhl9cxQP5F/YPyfD9ZSiOZXWRjlvDL0YiNgmU2IwJr7EUVIOJp7JJ4a3UaV/lsEH
         mp9FzfYIzrcfMGLFHmA/odIP+AY3OOa0kT6yBQs/YtjrUrXch2ikaRBmZOL3owZ+It39
         Fhrg==
X-Gm-Message-State: AOAM5306XgmDjgozoY25NcwDfKm37JTOMrWyrgXvn7ipQK7T3MYMAhjc
        vqFZFnJQZM5+gQwSI0tqrndHTg==
X-Google-Smtp-Source: ABdhPJzr8YmQqLyUSmCkYejogwjzQiAMastwvkFjwXPWrtwricO0JbZ/1JZUr6s7j1zCifzs7f6EIQ==
X-Received: by 2002:adf:a28f:: with SMTP id s15mr49491954wra.138.1635889338120;
        Tue, 02 Nov 2021 14:42:18 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id e12sm217581wrq.20.2021.11.02.14.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 14:42:17 -0700 (PDT)
Date:   Tue, 2 Nov 2021 22:42:16 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] backlight: led_bl: Add support for an "enable" GPIO
Message-ID: <YYGwuCmORnjFRHMk@Red>
References: <20211102100455.2016610-1-clabbe@baylibre.com>
 <20211102111942.xd7eqz2zrtb7zotc@maple.lan>
 <20211102112514.75v7evbdp4ccyyt5@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102112514.75v7evbdp4ccyyt5@maple.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Nov 02, 2021 at 11:25:14AM +0000, Daniel Thompson a �crit :
> On Tue, Nov 02, 2021 at 11:19:42AM +0000, Daniel Thompson wrote:
> > On Tue, Nov 02, 2021 at 10:04:55AM +0000, Corentin LABBE wrote:
> > > From: Jean-Jacques Hiblot <jjhiblot@ti.com>
> > > 
> > > This patch adds support for an "enable GPIO".
> > 
> > Before taking this kind of change is there a good reason why backlight
> > should manage the GPIO? I thought that the LED subsystem was a sub
> > system for LEDs (not LED controllers). In other words if you direct
> > that the LED be lit up then isn't it the LED driver's job to manage
> > the GPIO and ensure that it lights up?
> 
> Sorry... I should have paid more attention to my sense of d�j� vu with
> this patch.
> 
> This approach was discussed and rejected when we first introduced the
> led_bl driver:
> https://lore.kernel.org/linux-leds/20190705100851.zn2jkipj4fxq5we6@devuan/
> 

Hello

I am sorry, I didnt checked if the patch was already submitted or not.

Regards
