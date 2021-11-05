Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344324463FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhKENVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhKENVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:21:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330A9C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 06:18:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n29so1982195wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7/iipoqAGtlWfjdTn7pIa/UV1IVALV2EMEK2Ldis3ok=;
        b=ifXSu3YxdOWGJi9BpmMWnOWrVxdbHBjFXP/MC6gBHwOfp/tRp602TJzZp83L8zi9gC
         4TIiZETw5Zfvmnlrgma13J0NB9/IY0RnIftxjY3qyORHJOa5ft2S1MDCKespwqBDHy5X
         2fSiRlliFxIdbfA/46iK/DBjX9P8+jmEVwNSbaw7U6MYM/0VZFN9X1l18+oV7is/ugE/
         Ldzd1ayvE5qOPCENJlcA2S9ktEb3FwxBlyvHejTgnGM5nsut7MW47QXuVPlY2SYQ5iaN
         EZ/N4vTS6X4oKsJhsaaQ1ItC5COwZR3Gc4xUwW9jGB+JnS8YzhUZ98BISrACH8u0YqK7
         74rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7/iipoqAGtlWfjdTn7pIa/UV1IVALV2EMEK2Ldis3ok=;
        b=qZZlGf7iRC/5eKK2MsMiLAaOHa75TsWN1OZM4N/4Oe56GSjnrvh+W6QI4fHNRuEOX3
         OWQZkj2yoki5BaxSLry16HNyac4WcJB4dpMqx/KdtHl4Y39XPdXRGb3mynYgG7iElHwz
         vRomYQi1CDss8kiIPOt9lwSIvecuTY+8us9qkgSHpnLA2tgX5NsdH9eJzaUP0T6Xq24N
         dq7qY/W/0xxc24lSp88hVqHz7EJJbmXzoEFVQvDqHX7bD+LeOMChkQxhXX6pJ1ruMBri
         iA9lst/ZnjaZe0wPbovR4UQ9NNL3rHAiUca4rUm7rTNntR2uEfjHzPeDZr7R+dBEAmml
         0/Bw==
X-Gm-Message-State: AOAM530x82FDM+8VUlIFS0ndkq/219hVp44Ci9fa8/Ss+jAxl+sX9GcC
        NhyU/6iIG4C+mQd7etcfxDuQfA==
X-Google-Smtp-Source: ABdhPJwQHnoAVNWxU1bfYrJ+W2Anf3+K6IUO09ZgJAtRW1a3a3m9FMJj2FO8krg/xKbG0Vzc18WZlg==
X-Received: by 2002:adf:f10d:: with SMTP id r13mr74756968wro.414.1636118333680;
        Fri, 05 Nov 2021 06:18:53 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o26sm11155063wmc.17.2021.11.05.06.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 06:18:53 -0700 (PDT)
Date:   Fri, 5 Nov 2021 13:18:51 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6] backlight: lp855x: Switch to atomic PWM API
Message-ID: <20211105131851.6p2jmo54b4jts2mo@maple.lan>
References: <YYQfThRqabp4A7Dz@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYQfThRqabp4A7Dz@fedora>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:58:38PM -0300, Maíra Canal wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
