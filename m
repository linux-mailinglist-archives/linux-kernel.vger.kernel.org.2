Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9297441A0B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhI0Uz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbhI0Uzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:55:46 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A3C061770
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:54:06 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so26170986otb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MGYW2K0iuLK8RkBAXf2F5PgItucjdLFQiH7EkOY3vGw=;
        b=cBFf9BO83URzKYyMTmgPq43hBPhyJkeo8LtgtCbhO9EVCY6L10n/pMfWRdiVlKBkdd
         6w+VEL9jFqKoUKYNMvHzNF3sxsJ+oVX7LBcD89sr/REhe2heiK4yqHhroxcQNmKgZ6Ff
         spI9/s7iNlN2uXQ3cfkESDZDb1PukerJF/3mM3Zc+wZW+XGU/nUL+X9k0f4wGj3IKF0+
         dkHz5ORUqhubXWJSlKkeCMj9/FSAOs6W5Sy7h9+7hvuGlk2iz6/2+tRFauLMEMIC9Dyr
         PI7GxkCqoCO1mVwlOaIdFrTCMhHbi6eyysFnI6moIUPjHUIG97MOASHwh8aEDYfFpbF+
         ZGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MGYW2K0iuLK8RkBAXf2F5PgItucjdLFQiH7EkOY3vGw=;
        b=CEQu8Tp3qZ8hZ6Q/BFGfRTgZG6Q3FvFl4a0BDeRv9WIsLm9rLpE8HHHfBAIMHZp5qh
         jm1XCzBV9/HAMjaGKpCFw6C7K3ytG0DClbI97923/N/PR0S+/eVnKQ25WgBBF5gybqhv
         Ke+wOUnwtQXjAb+Vp1M0JT6+WGJpJfKK30cSRV80dwA2I+SneJHmdw1JMChpmmpbUo8f
         lgEGQwHAn/EMRQ10DFHPCPH3F5DEoJgPcgl74piQn01yZYH94vWXzrPXycSVPUghmGiI
         319qKfbM4pORUBHgTw+urPvuUK1Vh58nSsxcpdsqr5gSLFHs0445NQaHTOm/jy89CJTw
         UmqA==
X-Gm-Message-State: AOAM530pPIC0saFGlYBa2gC3zy9I5Z1TRSSXzv3sDdllr3Mv1bHZkaNv
        Uk42iW/ix74pL5Az3R2jwRMoEg==
X-Google-Smtp-Source: ABdhPJx/pQIOSrHgQjJiLg69yRsvaUhSv8d5bYzxxsuy6moK/+MVgcvqHbjUTe8Mk3IlEJQ3gRMlRQ==
X-Received: by 2002:a05:6830:200d:: with SMTP id e13mr1849537otp.341.1632776045599;
        Mon, 27 Sep 2021 13:54:05 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l2sm455543otl.61.2021.09.27.13.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:54:05 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     robh+dt@kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        mka@chromium.org, swboyd@chromium.org
Cc:     rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, ohad@wizery.com,
        rishabhb@codeaurora.org, sidgup@codeaurora.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        linux-remoteproc@vger.kernel.org, agross@kernel.org
Subject: Re: (subset) [PATCH v7 02/13] dt-bindings: remoteproc: qcom: pas: Add QMP property
Date:   Mon, 27 Sep 2021 15:54:02 -0500
Message-Id: <163277598156.1471158.10663016354664633920.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1631800770-371-3-git-send-email-sibis@codeaurora.org>
References: <1631800770-371-1-git-send-email-sibis@codeaurora.org> <1631800770-371-3-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 19:29:19 +0530, Sibi Sankar wrote:
> The load state power-domain, used by the co-processors to notify the
> Always on Subsystem (AOSS) that a particular co-processor is up/down,
> suffers from the side-effect of changing states during suspend/resume.
> However the co-processors enter low-power modes independent to that of
> the application processor and their states are expected to remain
> unaltered across system suspend/resume cycles. To achieve this behavior
> let's drop the load state power-domain and replace them with the qmp
> property for all SoCs supporting low power mode signalling.
> 
> [...]

Applied, thanks!

[02/13] dt-bindings: remoteproc: qcom: pas: Add QMP property
        commit: e73c632b18a936b5489068d2418a58ea95b49469

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
