Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8484841A0C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhI0U4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbhI0Uz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:55:58 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11B0C06124D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:54:07 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso26117290otv.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0YJQxMmnGDV43S6qCKWqkxM+F/CgheJgmjjy6liRV8=;
        b=L1bSbwFbF0AOdyEi2vlfKUBgRtemomi6OmLbIk+NL1SWIsGeeMNFUDZ6m8Qz/GUrH+
         k12swiS5MpY63k4IzuLywo14RwybloAExptULNULKAhIGneUH46d3ruvZSQOHb0tOnkD
         64hSWbK0QFKuO5f8ZHljDhKJX3i0Og7TReW5yGbigyUCZUuE3Jsr/YcaqdlJ/WK1lLCP
         W6Te9+bSKILW/VOg/nxnSbYc3QusLoG5ish4OpIePR5ogME8Sq7YYPYeGm8QEBFzgmAf
         EuXkenpJwihR7V6UElWQn30yFCYyUQtZYfWwfb+VBA6wBdcxXfpYhi+uQvdkp99XTBW7
         IXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0YJQxMmnGDV43S6qCKWqkxM+F/CgheJgmjjy6liRV8=;
        b=CQIFWTvvVEfKMZeYcc6zWFkF+MF3YAGe0ljQcK7Mr3NQYo1vUaFuDS9RBT23qH+3TP
         6uBqRW/YjKLTEtInWOK/h1BO5qNNJdfzelWNndZjmM9/AaVnmjGBHKFeQPGIRWQO/zMd
         Y/I2KQvcFgFwu8kzGBcZVd8bG3BptPjAwg0/KASbtDPqXKyLMY1eOULSvMZdb+MbqZ7T
         tkclrqXsjVl7MWqUdlbvNKiRq5AzGHl5FQJSJ1DGNn0nsiGGSXWpOCViWfZhxN7YqD1a
         NEVp/wfs+0hQuzlXZbVeaGkJWzCcVpxXUhe0MKjddkvzYT/u37KokqY4KGJo/75mfV2h
         eS1Q==
X-Gm-Message-State: AOAM533p0w6HJbLXIO2TuYtW5GajL3dUwd0A0VnPc6U4ls1PjVhV+xMI
        4U8Vk99FmvzDMGJWa31ebHqPVQ==
X-Google-Smtp-Source: ABdhPJw59jTcTxZyQisD/bKNDk32TvwDIXY0esd5bQvCDGxYsikQ7DkPzChVVudrHTKZ3TXfNyqHmQ==
X-Received: by 2002:a9d:6347:: with SMTP id y7mr1747419otk.241.1632776047321;
        Mon, 27 Sep 2021 13:54:07 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l2sm455543otl.61.2021.09.27.13.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:54:07 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     robh+dt@kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        mka@chromium.org, swboyd@chromium.org
Cc:     linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, ohad@wizery.com,
        rishabhb@codeaurora.org, sidgup@codeaurora.org,
        devicetree@vger.kernel.org, agross@kernel.org, rjw@rjwysocki.net,
        dianders@chromium.org
Subject: Re: (subset) [PATCH v7 04/13] remoteproc: qcom: q6v5: Use qmp_send to update co-processor load state
Date:   Mon, 27 Sep 2021 15:54:04 -0500
Message-Id: <163277598156.1471158.16807304307260432755.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1631800770-371-5-git-send-email-sibis@codeaurora.org>
References: <1631800770-371-1-git-send-email-sibis@codeaurora.org> <1631800770-371-5-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 19:29:21 +0530, Sibi Sankar wrote:
> The power domains exposed by the AOSS QMP driver control the load state
> resources linked to modem, adsp, cdsp remoteprocs. These are used to
> notify the Always on Subsystem (AOSS) that a particular co-processor is
> up/down. AOSS uses this information to wait for the co-processors to
> suspend before starting its sleep sequence.
> 
> These co-processors enter low-power modes independent to that of the
> application processor and the load state resources linked to them are
> expected to remain unaltered across system suspend/resume cycles. To
> achieve this behavior lets stop using the power-domains exposed by the
> AOSS QMP node and replace them with generic qmp_send interface instead.
> 
> [...]

Applied, thanks!

[04/13] remoteproc: qcom: q6v5: Use qmp_send to update co-processor load state
        commit: c1fe10d238c0256a77dbc4bf6493b9782b2a218d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
