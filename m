Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBC7442DC9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhKBM1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhKBM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:27:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D148C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 05:24:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d24so2432366wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VMos205SOp2HQ94smQ+sF54W0/I8oBZxdhBF5kpjNPY=;
        b=d41n3ZgBBbe/wsv5BMyqnK5GyThrUxixLTmnx/SsWsa9G2Xm+euwqxG3a8llFuNbzB
         Tb3bgAOTWyMKQN8RbaDeXBaSsm5XqUrannJMnBNkwh5SJF8e9Li0135GqD6LziAXzPWg
         W0Wp2+qJb0vJ9ouxErlFR5NLuDfB81giKHlAzpW0mjTZr7Effblj01GwYUppzI5jWCJh
         SoudyMh4kO6Db+CfkBDXu/lNRLFVbl/45iN7vLGFh41rwwylc1auUmKxNWBkgyzKvR4Z
         j52VwNgjnUdR4cn/Ceip2jv/55KcBEZv63LzuceudPD8Q4yyLEZRv4TxxG7HEZDNM/TL
         UY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VMos205SOp2HQ94smQ+sF54W0/I8oBZxdhBF5kpjNPY=;
        b=ZTdaV8mMgnfYXS3NF56UeX/FF/Le/3tRqzYeaMBlV8KZccvIuUtzZm0SFg7z1JBeAM
         hTnv/eFxO4BH7xsyyjTqaZd0+kMIHB0aYzbQ4Mvlk6CBDdjAor51Vv8txfjUz0FoFV6t
         MaLHR1ful0QykZWQNS+ac9VBfUlbEqTyHHuZFLI0sMiqwbOkswW+cningiIPaCpEebVL
         +NSHUgDwZXdnSld9anBQTgk2IyRaHIlC507XaH6N4BWaeRjWkpuyffahj6DIB7ln+lmc
         r3fnb+2dZBGz3niBZTfl72ry7wWAwjVH+FCZJjwZGrpuJrW6gVtEjJHBvr1PlLlQsD3D
         1GbQ==
X-Gm-Message-State: AOAM533N5PumW3ze2x5lVcBgc9YC4eQyQjc8EHpi8pwEl1WT8FCHa7qv
        HBQpARPl4zuAzr+LZUOTbCGvBQ==
X-Google-Smtp-Source: ABdhPJx7JovvNqqEnEL3rG3Z4vrBFF0QUSDM0yb2GrZv+Cb1FGIi7QFLbvEGK9B9xsKYKW9gm/nTPg==
X-Received: by 2002:adf:e310:: with SMTP id b16mr47340847wrj.309.1635855864079;
        Tue, 02 Nov 2021 05:24:24 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l7sm11613856wrf.31.2021.11.02.05.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:24:23 -0700 (PDT)
Date:   Tue, 2 Nov 2021 12:24:22 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] backlight: lp855x: Move device_config setting out of
 lp855x_configure()
Message-ID: <20211102122422.k3wzvvcng5ynwcce@maple.lan>
References: <20211101185518.306728-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101185518.306728-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 07:55:15PM +0100, Hans de Goede wrote:
> Move the setting of the lp->cfg pointer to the chip specific
> lp855x_device_config struct from lp855x_configure() to
> lp855x_probe(), before calling lp855x_parse_dt().
> 
> This is a preperation patch for adding ACPI enumeration support.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
