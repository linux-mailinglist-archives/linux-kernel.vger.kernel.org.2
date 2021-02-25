Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE2C3259BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhBYWk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhBYWkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:40:25 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4252C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:39:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w18so4007187plc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=MFcjE/WeEn+IVJZnnDEHAQYjU7Vfx+Vn0PTYrMBIKFU=;
        b=KqNSfj9xZCGyrV6LQ6aapAMGI4R5TQKWo617kctqQSCQtQjGB7YF1L26d0NXIEoGlS
         6CM3RbUej77nIuoorMYvIIsuYiXg5r6OX1Mwi6Q64yDJRJ1SsnAIsn4kovpKa5EDYGZV
         nILAg9UOCgPwf8+38FfgPvdO6q9SVYilECZ5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=MFcjE/WeEn+IVJZnnDEHAQYjU7Vfx+Vn0PTYrMBIKFU=;
        b=I7rOexzcLOJ8b8Fzio8+8D8rQ5XJAFyqBMIGTv71aOhb61bmDV/ZG2/UW+OqnnJ01N
         ospMZVm28piYr06Y4GGVA0fldi+I2VqRrL6F1ZQyGLcvcdyHG0KVCM1SHFsD7k4S3LqZ
         XAVsfXMcBovDSY2PQlb8VkIBcG8pAsO9U6dVFMWrvQPFnaHR4nEfQHSAzacvAFbAmhUG
         Abp3NcNrnYZdH5z+qRK8mLedikQvIohXd3TBKdttM7z040wy1NJWgHb3MO8hVRqF1eiN
         QY+ViyxzRIiGvqer6gOPwecU6CfXYO7t7iT2MrLG5OoC5G5gonpEBC6/IQlnJ19lHgLD
         pgoA==
X-Gm-Message-State: AOAM5315ligMeTUTn3X/lnbtUHNhFtWWtL1MBTGqkTLT1n81CYsJunYd
        n+qZ/E3ZRHzkS1Wg5AHq89k/0w==
X-Google-Smtp-Source: ABdhPJwfIEceIF0MkV8wu2chf+y8M9QK7pX8fvuYLa9p1J/EOAR66cE8x9qiLnLJ2TxHL/Jfkotevw==
X-Received: by 2002:a17:902:bf01:b029:e4:3287:f8da with SMTP id bi1-20020a170902bf01b02900e43287f8damr26558plb.45.1614292785077;
        Thu, 25 Feb 2021 14:39:45 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:b942:93a8:e68d:5a90])
        by smtp.gmail.com with ESMTPSA id z22sm7435586pfa.41.2021.02.25.14.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 14:39:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210225103330.v2.3.Ife7768b6b4765026c9d233ad4982da0e365ddbca@changeid>
References: <20210225103330.v2.1.I6a426324db3d98d6cfae8adf2598831bb30bba74@changeid> <20210225103330.v2.3.Ife7768b6b4765026c9d233ad4982da0e365ddbca@changeid>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sc7180: trogdor: Fix trip point config of charger thermal zone
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Antony Wang <antony_wang@compal.corp-partner.google.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 25 Feb 2021 14:39:43 -0800
Message-ID: <161429278310.1254594.15181773052326295788@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2021-02-25 10:33:36)
> The trip point configuration of the charger thermal zone for trogdor
> is missing a node for the critical trip point. Add the missing node.
>=20
> Fixes: bb06eb3607e9 ("arm64: qcom: sc7180: trogdor: Add ADC nodes and the=
rmal zone for charger thermistor")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
