Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6756341D00E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 01:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347611AbhI2XiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 19:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347598AbhI2XiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 19:38:05 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34803C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:36:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s75so4355893pgs.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HvaI2CnuZMRocUAuxkU7bar+LZuGwxIpo51W/3LktMo=;
        b=IzZJtmb6XxyCwoSIO0qgrnxryeU2MYm1rpNv/ndfOQDtKcsnWAMrW4mZ3WsKGl/aG+
         poBzt8xkzTPqt9azAVAO934HmwF8/0mnwV7qSaOADaUnNbiyuagGu6yF1uxWkp5L+eeF
         vycTIH5/Xt8zjyHBmEpdDpkd64hX72U3gbFxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HvaI2CnuZMRocUAuxkU7bar+LZuGwxIpo51W/3LktMo=;
        b=klqOeTcULmB86K135PeB22kCdaKsx+ZOl9ZOBblLxG4mu/oGrMWvRuaMqVX/dAd98A
         DvGoL/dYhYKSDRGCKB7s0Ul35g0/mnY4WRJdIF2m1sjDE8DNCQJY0CJ5DP4r0PQDEL5Q
         TgfgeDfpD7gpprBtyzqCAUscxfDqxdwXcaMSS+dyVA+OqIqe040IOTf7JMPj6Cnj4hhi
         sMs9/8PmBh119b3EQ0XwTSCg7ZugxEiLjRpKa/QQX7BDsRDora8pOiIXn61/pMxL87ze
         Ba490OlIQMGge7QcrHCvGmb62liwKKiiq4G0f2XDPH17zXz9qPBRgosY6jxU+CGNE9Lq
         /i1A==
X-Gm-Message-State: AOAM533Sf14HWFcmiPmlI8dRvBYjPaZJ0ioddswfhC92OYycV86f192y
        iUFxLN5LwFYAwwbxZdj1ZXjTtg==
X-Google-Smtp-Source: ABdhPJye82JkSQN1O7fDsiSS5dX3XnisZ+GDoPSTfJmU1gPBVBfE/Kx8CJ6vRQBhUVApKr+eL1+l9A==
X-Received: by 2002:a05:6a00:22cd:b0:43c:9b41:e650 with SMTP id f13-20020a056a0022cd00b0043c9b41e650mr1189646pfj.60.1632958583660;
        Wed, 29 Sep 2021 16:36:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:2f10:2763:4825:1f01])
        by smtp.gmail.com with UTF8SMTPSA id p16sm2949687pja.24.2021.09.29.16.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 16:36:23 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:36:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org, swboyd@chromium.org,
        skakit@codeaurora.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: pmk8350: Make RTC disabled by default;
 enable on sc7280-idp
Message-ID: <YVT4dZHRcYlIXK7Q@google.com>
References: <20210929153553.1.Ib44c2ac967833d7a3f51452d44d15b7b8d23c1f0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210929153553.1.Ib44c2ac967833d7a3f51452d44d15b7b8d23c1f0@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 03:38:14PM -0700, Douglas Anderson wrote:
> The RTC on the pmk8350 is not useful on all boards. Some boards may
> not provide backup power to the PMIC but might have another RTC on the
> board that does have backup power. In this case it's better to not use
> the RTC on the PMIC.
> 
> At the moment, the only boards that includes this PMIC are sc7280-idp
> and sc7280-idp2. On sc7280-idp I'm not aware of any other RTCs, but
> sc7280-idp2 has a Chrome OS EC on it and this is intended to provide
> the RTC for the AP.
> 
> Let's do what we normally do for hardware that's not used by all
> boards and set it to a default status of "disabled" and then enable it
> on the boards that need it.
> 
> NOTE: for sc7280-idp it's _possible_ we might also want to add
> `allow-set-time;`. That could be the subject of a future patch if it
> is indeed true.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
