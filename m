Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAA4326630
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBZRPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBZRPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:15:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:14:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e9so3704942pjs.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wWJe3j5ckaWir9TeAb8ZwP65wOLwTqkHtBw2V8lbAqY=;
        b=evYgZSC4DDFmhKlArf+8HlKTDBVLjwUzeCnwDjt/R0dd11ekqtRKmwmVQh9X1/o+QK
         C4ZC3fO5REafAvsqEa6SBuWJN1RZsNoGMqlZ5fftv1xyd3H43AzKzrgPKsfpM0YnH/UU
         DQ4bE/5KlIo4IduRnQBLDCUxJ3UO8Krxgp0gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wWJe3j5ckaWir9TeAb8ZwP65wOLwTqkHtBw2V8lbAqY=;
        b=Tpjuit8sWIcXbu80KH1+brPOsUBFH2+lXg32cBYaumhcwAIrJhjUQkaBkxRyOcTxMU
         w/EPkDk9LSLuzJuPdCwXQA4ilRWT4F50qlF4/ZMtQjlRIk59K/7R+6r9YsLAscrJ6Hi+
         XG4QsZTL3UmMm6/PJiDM5P1u2rjpsT+YXQv0gSHUWXspmf9gULdw+X08b1HDpvH4XLDB
         Zj2XfhkbgnvZ8ddVOEYRZTEfRvT2GZR4xG0/58a9dRVqHEHXYGVVuARb5/zK9F9nOz2C
         RDLNde1Uglw9dBSYAviP4O5TlBr9rxL3XCG4LMZam55krRlCZBYJvIS43f4RULe+BdD1
         Ju6A==
X-Gm-Message-State: AOAM532M5XgjtCTRIX8Wcr4COQxJTH6LyXgOseXC9gpPL/xvYSWkT2zl
        Jog9KiPbnsfP80zuFmJhtdjVNQ==
X-Google-Smtp-Source: ABdhPJzWllqzKQv4IzOEdxdz5kDhi/vfnYpxR9nKS/UY55QcjENpVMyAKjxSaDuMB1p79kg//TwwKg==
X-Received: by 2002:a17:90a:bf0e:: with SMTP id c14mr4447289pjs.38.1614359661803;
        Fri, 26 Feb 2021 09:14:21 -0800 (PST)
Received: from localhost ([2620:15c:202:1:41c3:38a7:86a4:a6e9])
        by smtp.gmail.com with UTF8SMTPSA id v126sm9501985pfv.163.2021.02.26.09.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 09:14:21 -0800 (PST)
Date:   Fri, 26 Feb 2021 09:14:18 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] arm64: dts: qcom: Add sc7180-lazor-coachz skus
Message-ID: <YDksakXxf4OqiCEY@google.com>
References: <20210225221310.1939599-1-dianders@chromium.org>
 <20210225141022.13.I3d1f5f8a3bf31e8014229df0d4cfdff20e9cc90f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225141022.13.I3d1f5f8a3bf31e8014229df0d4cfdff20e9cc90f@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:13:10PM -0800, Douglas Anderson wrote:
> This is a trogdor variant.  This is mostly a grab from the downstream
> tree with notable exceptions:
> - I skip -rev0.  This was a super early build and there's no advantage
>   of long term support.
> - I remove sound node since sound hasn't landed upstream yet.
> 
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@chromium.org>
> Cc: Judy Hsiao <judyhsiao@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Matches downstream except for the sound node and -rev0, which are
mentioned in the commit message. Also looks sane to me otherwise
from a high level inspection.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
