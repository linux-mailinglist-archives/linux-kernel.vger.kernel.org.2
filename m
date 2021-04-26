Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A0A36BB46
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhDZVha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbhDZVh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:37:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C594AC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:36:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr7so11611422pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9rgsKAhhtuNFQZ+aAjo0/P+CP1GY/CUNPL3lrWCrY7Q=;
        b=KCMSZTW9Ftcr13No+8u70KquNfAPMGogImNCw5IKcikbvDCOMZqC97h0yt7wljPgqc
         vsJAhRFGYghaNeSxEQcaTGOSQuwMJRZOibqfBZigFfiqk8NUGCrUyqnr+aLo0UoSu5C0
         mF44U/JTukrAFrga5TNdsjSwg8n+4vzvb+f6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9rgsKAhhtuNFQZ+aAjo0/P+CP1GY/CUNPL3lrWCrY7Q=;
        b=SIBM+9P9Zo81DXSDt3Wvgf8Dsvza9WmlV/t5MN3lF1pmhqx4kCY/y0BzuOA/TYalti
         zfpNMcZT4PpTokfzsQ0O1xgZ5oXrl2xhlH07PunP/cQw5fJ7tMbk3ZPbSaMG70FVcHc0
         mjkjeKQM8uvhXkNuUg1xBhsPj+uM9vi2w33NtNYeCos0ARXc5UyqFQK3Lo6GyqhHDi9N
         yyzA+dax7AxF+ZLSyp4NGGLYe1Qlnp15do36jgixRHepJggDC8+NuDJ1kk2TI4ds31/4
         g/j9Qtklez3huhXVj+Q5iEhWmC7spZvD2pjSBaXz4RLc/DO9DQ8T468OEfFl8NAIqYfZ
         sS1A==
X-Gm-Message-State: AOAM531ydT7iczxZzyECh0ZqThom1G03fo2eIaJsty9K/w9oyMLMBi1M
        RNNZK3HnJKB0dTMBNjvnHtFuGg==
X-Google-Smtp-Source: ABdhPJyD6BoGT/s6yCpqFgaXtkry8ClFp2fYPOJChJ8sXblm3fM/5l4uwqy9109mOJugem9Jelj5Bw==
X-Received: by 2002:a17:90b:224d:: with SMTP id hk13mr24061527pjb.218.1619473005256;
        Mon, 26 Apr 2021 14:36:45 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3a16:de17:8721:d706])
        by smtp.gmail.com with UTF8SMTPSA id 18sm482678pji.30.2021.04.26.14.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 14:36:44 -0700 (PDT)
Date:   Mon, 26 Apr 2021 14:36:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, manafm@codeaurora.org
Subject: Re: [PATCH V2 2/3] ARM: dts: qcom: Add device node support for TSENS
 in SC7280.
Message-ID: <YIcya8X4O/y6uuWC@google.com>
References: <1619202177-13485-1-git-send-email-rkambl@codeaurora.org>
 <1619202177-13485-3-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1619202177-13485-3-git-send-email-rkambl@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 11:52:56PM +0530, Rajeshwari wrote:
> Added device node for TSENS controller and critical interrupt support in SC7280.

nit: use present tense to describe what a patch does

> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
