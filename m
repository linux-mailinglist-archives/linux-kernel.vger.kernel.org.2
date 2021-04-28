Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6827E36E018
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241834AbhD1UIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbhD1UHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:07:53 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B535CC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:06:53 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id r3so10856724oic.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vl7A1Bucz63bZ2sNuRyc6lFBD6YydDSFIrYy2XAFbW4=;
        b=V+PDi+r9lcfd6nKjXBqXO7T4yGd0umuQaXFT35w2tV6DrX6On7FxjGWqdF3tS5MSE+
         P+pX2ad6Mtyzf1c4KfvG0i9/O0LgZYK3O1gQjWOZFZDe3UpiaL5jPZ9HtwormPpB9AqP
         Dd9pzkECFx19XuqHapvjUsFVxbCALKkus+6Gzmt7riMQJfy5QbldfUgIEg9y+93qAKO7
         aO8sixH0nO+n5uEt3E9LaBcbDaEjV6aJfCQv0vtFQFhV2YscJemZjO4eIvOQ3Fhm0L6d
         QLRpdqFumHBAi1ZJ98WtnZC4awoXEe8bu2/KJG5+VkeNdS0mEWyELY5ebkIwaupWcxxw
         pZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vl7A1Bucz63bZ2sNuRyc6lFBD6YydDSFIrYy2XAFbW4=;
        b=i3pIn5FXuJaucbbUEbHVOpSt4zYh8J1BFZiTXMU+e3pVozE8JgfaN9iSIgkvSMC7Nc
         GIrRf01nCDjetGaWbspvHsXCr5O1ZH71xFFfrjJlR4ZWLVZlgzzedy27zVTgPvFwbBjC
         Cn4bRQ9QgXxk7Dqq1tGxLiK1/SzefwOr65x3PJ2/S4tjvE+eTb0KysE3biy9EE1NK+b+
         LdfsbrLS5hOpmM2iitsmG14+TEf7T5Bw3XP/pUtnrV5Aj4VNf0ppn2igmm5JUz5pxd7X
         g05lx9lJG0LvdGBdvAAqrc2JjDVgymMt0HDldwk2emMP9doUkXIFV1n848rlMsH84VYc
         4jMg==
X-Gm-Message-State: AOAM532CAHEFPdEV3mKtv9z8z9/Zs1OWAp35IcNt+DJ/VH50JkdeJHGK
        SZxrvhQv6CI+kANYaN9kEMpV6g==
X-Google-Smtp-Source: ABdhPJzAsbDFCLgX6C6JhjCevrUavXR+5G/d1FZkQZ2elBaaEKg8pKvEarGLagSh2TswjmnxMNfDZw==
X-Received: by 2002:a05:6808:18e:: with SMTP id w14mr21763329oic.159.1619640413040;
        Wed, 28 Apr 2021 13:06:53 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x45sm195564otr.35.2021.04.28.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:06:52 -0700 (PDT)
Date:   Wed, 28 Apr 2021 15:06:50 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Cc:     aghayal@codeaurora.org, collinsd@codeaurora.org,
        fenglinw@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add QCOM PMIC PWM driver
Message-ID: <20210428200650.GM1908499@yoga>
References: <20210428155422.GL1908499@yoga>
 <1619635777-2872-1-git-send-email-subbaram@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619635777-2872-1-git-send-email-subbaram@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28 Apr 13:49 CDT 2021, Subbaraman Narayanamurthy wrote:

> >> Add PWM driver to support PWM modules inside QCOM PMIC chips which are accessed
> >> through SPMI bus. Normally, there would be multiple PWM modules with adjacent
> >> address spaces present in one PMIC chip, and each PWM module has 0x100 size of
> >> address space. With this driver, a pwm_chip with multiple pwm_device individuals
> >> is created, and each pwm_device individual is corresponding to one PWM module.
> >> 
> 
> > Exposing this as individual pwm_chips will prevent us from enabling the
> > LED related use cases (patterns and multicolor) that most versions of
> > the hardware support.
> 
> > I proposed [1] a while ago and think this is a better approach. I'll
> > take some time to respin this and send out the next version.
> 
> > [1] https://lore.kernel.org/linux-arm-msm/20201021201224.3430546-1-bjorn.andersson@linaro.org/
> 
> Hi Bjorn,
> Yes, we came across this patch series but this driver (leds-qcom-lpg) is a
> combo one which provides support only for RGB LEDs (or TRI_LED module) along
> with PWM/LPG channels allocated for it. Say, if we've additional PWM channels
> on the same PMIC (that provides user-interface support) or another PMIC
> (non user-interface) that has multiple PWM channels that are not used for LED
> notifications, it would be good to have a separate PWM driver to support such
> channels IMHO. There are couple of use cases we've come across recently.
> 
> 1. Using a PWM channel for controlling external LCD backlight controller
> 2. Using a PWM channel for controlling a haptics actuator
> 

The LPG driver, as it's currently written, support using each channel as
a LED, part of a multicolor LED or as a pwm_chip. It's been tested on
pm8916 (which doesn't have triled or the lut), pm*8994, pmi8996 and
pm8150* in various combinations.

In particular the PWM-only modes that you describe here is how the
driver has been used on db410c, for driving the "backlight GPIO" in the
low-speed connector.

Regards,
Bjorn
