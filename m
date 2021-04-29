Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8036EACC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbhD2MrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhD2MrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:47:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53227C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 05:46:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id md17so7142686pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lKZ23VCFKvQ6/HOWqxM0itn4uKSnl0X45UL4mdVA5Go=;
        b=D5CVSQtuJsCpJyyjaftW2XzPxBy5MXHYMRgNjfQDwY9QXVfrAfcdo9QCubnhmlILWG
         BDqoGSYRPlkC4YCLuZUhqUVsLom6f+2VmmRev8QqueILLXv0GVL26ZukWh5hRm0gfApH
         jejUdK+dpQP6Z+sJIfhTWD/EohSIvEMxcBWXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lKZ23VCFKvQ6/HOWqxM0itn4uKSnl0X45UL4mdVA5Go=;
        b=lKvjnJ8RnMtsAXI+a0vM3eo+PQY1RHwArYJy3K8a7wXM2ZTRveTvW0bM+fYHMSVsPy
         4b6ZjbnRxST9eDQoY6pWdJ4dYWe80EceuZyHTS1qRS7OCujiJDFz+o7doAgPOJOuA5OC
         QXNm3vyb1RtafQqMSOC+ZeqlHSHTTCP1R1UK2Q9CyBBiw73/6259xuDUfCCdSYJ3xYO+
         NNZAmZWatscd6MJNVfN2ZoyBgpUGLIPw5kdlIhchuG84XptbuJeLkSiPXXktwf8U464I
         Llm7eCsaoFI5g2KM5CRxDpZ8VeWR7tC485mCH1kHGLCdkVhphb12E290TX2KseqTbFHk
         jVCQ==
X-Gm-Message-State: AOAM531E2g2ngl5qE8uO+gaW1ePw6oUiM9kpcC0z6ggbq8nGkzaDC6fz
        6nkcjCJAAjmRJTkliho3nevv8uMqn+cNQQ==
X-Google-Smtp-Source: ABdhPJwZxlKLO2k//JvjEuPGXSJZ7VfquSt1xd1A1fTwDzseyQ/mWuetZvfMNzxY2mqjjBV8HfjXcg==
X-Received: by 2002:a17:903:185:b029:ed:10bf:6c8a with SMTP id z5-20020a1709030185b02900ed10bf6c8amr25315750plg.8.1619700390887;
        Thu, 29 Apr 2021 05:46:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:59f:ddfb:1a03:fe23])
        by smtp.gmail.com with UTF8SMTPSA id v2sm2242834pgs.19.2021.04.29.05.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 05:46:30 -0700 (PDT)
Date:   Thu, 29 Apr 2021 05:46:29 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add "google,senor" to the
 compatible
Message-ID: <YIqqpUK3wRiq6WT0@google.com>
References: <1619674827-26650-1-git-send-email-rnayak@codeaurora.org>
 <1619674827-26650-2-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1619674827-26650-2-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 11:10:27AM +0530, Rajendra Nayak wrote:
> The sc7280 IDP board is also called senor in the Chrome OS builds.
> Add the "google,senor" compatible so coreboot/depthcharge knows what
> device tree blob to pick
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
