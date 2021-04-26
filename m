Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E6636BB3F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhDZVed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhDZVec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:34:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDBAC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:33:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso6074095pjn.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2gqjqGKMmdY1c54QBWMIfXnF5vggO77yZIZgJZZpaUI=;
        b=PxGTyMuyRjj+Z4cDoYFCCiZh9bcZQ0ETOYy8cGS8urgBFIwH0N3lizGv9Kzkc/MUTF
         ZMyPvvHBWSzWEgSI4L+sVYDBlrJfBiTgAJjY2eHBpOfh/FBEqOoTjTziFifbD866Auqx
         18xJCGTRacDmbDbmZPe9YLwIUN6KTWVj2ilYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2gqjqGKMmdY1c54QBWMIfXnF5vggO77yZIZgJZZpaUI=;
        b=OCh1MVQ269RXUzHX7IvCdUBNdbXvhT89eg8OBtfV5G3BFSFZLMLJZZ4tZOonDkrj+y
         YNs4LKKevj0txEqOn3W8a/Dca/s8skQm1PchzlE4kpd5iBzb6mVM5fnVnJj4Db1S9St9
         QK2QT/EzsvLDJfqyvs/TpJhRCdkcd2rIGRR2qLo41xORdlC9tUVlyLqgJUFOzJYiCH4t
         lvesdAUdjvKp2Jfnf/G0LOGQpegIia9QN1fkXLVqeEZRGlDPFeaRUKJWpciHRgR2ctE6
         lhzGAJMfUxx5UeQouz9d69GSolrD3u2ncFYzFJYO31GyETGxXck7CsUDEqexPvOXLZsi
         UhSA==
X-Gm-Message-State: AOAM532kuHJbBCClTd5WV3pTRCa2tJlhUOQFQYEAvsApD9ffROZT4G11
        EVq3KIgMLYydRABOE+QeinEOEA==
X-Google-Smtp-Source: ABdhPJyFXC6sob9x+LwIedI3fkp8qCKwcb1urDmHU4J3LWavE7Dw52zZN8AEKXm4UIzmsTKo/q7sQQ==
X-Received: by 2002:a17:90a:1990:: with SMTP id 16mr1243139pji.172.1619472828397;
        Mon, 26 Apr 2021 14:33:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3a16:de17:8721:d706])
        by smtp.gmail.com with UTF8SMTPSA id r3sm12082473pgn.82.2021.04.26.14.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 14:33:47 -0700 (PDT)
Date:   Mon, 26 Apr 2021 14:33:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, manafm@codeaurora.org
Subject: Re: [PATCH V2 1/3] dt-bindings: thermal: tsens: Add compatible
 string to TSENS binding for SC7280
Message-ID: <YIcxuqvCkqnyN6/S@google.com>
References: <1619202177-13485-1-git-send-email-rkambl@codeaurora.org>
 <1619202177-13485-2-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1619202177-13485-2-git-send-email-rkambl@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 11:52:55PM +0530, Rajeshwari wrote:
> Added compatible string in TSENS dt-bindings for SC7280.

nit: use present tense to describe what the patch does

> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
