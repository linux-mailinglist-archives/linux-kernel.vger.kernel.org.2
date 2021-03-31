Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6CE350656
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhCaSbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbhCaSau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:30:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EB8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:30:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so1706492pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E3akzTza0anlsw0kDmjuitire0zoENmNGom6YkKRbb0=;
        b=GDMGzzOlXXf9lKbR8Oyq0Jy/eIFe09Iu4lnFmh4jivU8AqRhVDvyvhV+KGXIQnsFym
         uTRgySHzNY7u4XH2zhrJz10a8Hc9PJsqPPPDeAYLXBQDLvqfqpZHS2OFNYHwVbmHVeRT
         AKvIVayV3D1Vw3i7937jjqg6Ms8nNkwt7CsxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E3akzTza0anlsw0kDmjuitire0zoENmNGom6YkKRbb0=;
        b=d7wcmDkp6flD08wSPM0OGd5WdInRuGMUJNWgXy3bYB0cOCJU7r94t1vk3MB85HdrXZ
         XUBvD0szj+ysLb/9+bL8kkV8rK3EMn1/Cckt9tNGJKhtBuNTHkt88xcOYE8+UnSqc+T5
         x/ooIQBmN21i9l2JvJS30AFWAQxYXTgePOVkSpETCU6TBO8osJQa5yA2jk/4pTo5ICpY
         mkUQVmsxgYnfJzafpzO2nJbM9CqOd+H9AxB1s/n7qgqx24+WkRdIw8QHNUUI2IFUV+t2
         whQd44nJldmO+7DoWqMkMWLcJneOR+J/A3s5cr9+es/9IiLOfG8mqIp7lXybai94jwRE
         Wl6Q==
X-Gm-Message-State: AOAM531l23IThYV6sPZ4SrrLhRpoT/Q53zLyLXI4UlS08cgaI8UpL3PH
        hlvHXexSw51/REUcD4gt8794BQ==
X-Google-Smtp-Source: ABdhPJyByoilkpbgrS5DpAaLNhj+V6k8dWS7ArOMatm3zQ/evMVAiWPdeSm+u1LlxFwve5Jxlo0QOQ==
X-Received: by 2002:a17:902:c407:b029:e7:2272:d12e with SMTP id k7-20020a170902c407b02900e72272d12emr4421008plk.52.1617215450020;
        Wed, 31 Mar 2021 11:30:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:74b3:8070:8b1:c494])
        by smtp.gmail.com with UTF8SMTPSA id q14sm3059959pff.94.2021.03.31.11.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 11:30:49 -0700 (PDT)
Date:   Wed, 31 Mar 2021 11:30:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH V3 3/5] arm64: dts: qcom: sc7280: Add RPMh regulators for
 sc7280-idp
Message-ID: <YGS/2FSP8cq2ZiEU@google.com>
References: <1617192339-3760-1-git-send-email-skakit@codeaurora.org>
 <1617192339-3760-4-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1617192339-3760-4-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 05:35:37PM +0530, satya priya wrote:
> Add regulator devices for SC7280 as RPMh regulators. This ensures
> that consumers are able to modify the physical state of PMIC
> regulators.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

I did not verify the voltage ranges. The datasheet specifies some
ranges, but apparently the settings in the AOP are what really
matters [1].

[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1615816454-1733-4-git-send-email-skakit@codeaurora.org/#24051523
