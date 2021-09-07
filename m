Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2076402E19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345510AbhIGSEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345186AbhIGSD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:03:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3313FC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 11:02:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q21so6327804plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2weBeywvOEXC5XErzYCuvvm79mVZTfNqiqYDEqubPug=;
        b=Kr2+KLY7opTqUIU+u+Lc6Ug5DzUQH7stZPCCwPT5HQxZ6Vxg3kX35IpCC2jXuaiGln
         4bihfZcFC7yNtcOZGs3h5NLMRTFoHoBaYMCX9vUAAYmDVrK9DE74fecY6PxU7F2Y/P35
         iJMpRZpJMUnxsw5mw8+HFxl9oh+scl398q3+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2weBeywvOEXC5XErzYCuvvm79mVZTfNqiqYDEqubPug=;
        b=VaTCTjo2l11mnxxxkBUQjIYU216PBvNsZYK3ooDbAmBMXkvL0ZVOAndPw/1O3LyA6n
         xk7RoPtkRiaRwLmNZz7p43cZ5ASWt9amMmP85UomLPrsi3VCd5a/8Q+cEOVy/XdvZcs2
         RDhKDgTvrPCr6wY5pib3K3LmTsIgcOC729tKeJBxhil3oGH/xYAZk8l4OqMW2/5iHxnD
         8+9DJv724pkumnhpsEgdYA6fxXPX+KI3Cj0jQx7vqazcJBWHsYUgv73zO9NWRXsqWUih
         SESbi+uGRJfIcoFNjhrvuw8FUP0KqzVGhvaxDcW3yHK/QjWITIeC5tcKv629wdIP4i3O
         2DXQ==
X-Gm-Message-State: AOAM532Jn1nPYNT5ATb6vpO6U1aSt4z2SBzZNBuL9xhY/EX48ohDIMoW
        R2Pr9p/cR3YXniNJBmw8xyIwGfAoFI3/Iw==
X-Google-Smtp-Source: ABdhPJwRBAYPyCs1dQvYzDwJtOAEZSUH5xaG1xTYvosb6J45UjzmW/nYEQWNGiPI9wYAHP7XL19qTg==
X-Received: by 2002:a17:90a:8a98:: with SMTP id x24mr5874492pjn.25.1631037771781;
        Tue, 07 Sep 2021 11:02:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c6b2:7ae:474d:36f6])
        by smtp.gmail.com with UTF8SMTPSA id x16sm13806273pgc.49.2021.09.07.11.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 11:02:51 -0700 (PDT)
Date:   Tue, 7 Sep 2021 11:02:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        swboyd@chromium.org, kgunda@codeaurora.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] leds: Add pm8350c support to Qualcomm LPG driver
Message-ID: <YTepSUrCPKT7caqc@google.com>
References: <1630924867-4663-1-git-send-email-skakit@codeaurora.org>
 <1630924867-4663-3-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1630924867-4663-3-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 04:11:06PM +0530, satya priya wrote:
> Add pm8350c compatible and lpg_data to the driver.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
