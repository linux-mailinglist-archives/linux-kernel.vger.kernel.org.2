Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4F03B6B78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 01:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbhF1Xk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 19:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbhF1Xkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 19:40:41 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E7C061787
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 16:38:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id z3so2876661qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 16:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miYY2dmUa8aOm4aFUUNNkSxFLOIn70qDkiO0NjVvZko=;
        b=nV8UvqlMp80EZh03fJr7ThFcbJyzi6eYcMjOZYU/YWtPbhj0fi2Bc/uhP5P/k9heDu
         V7/GzY+XyI83HS9tzCN6IN3uhhp/AqVgWd1JH+pTpQmRpEZb5+izLOpQESgRoZXGYEF4
         07PiqC06/UlBCuh87w2WO52BugnaUrs3/WxS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miYY2dmUa8aOm4aFUUNNkSxFLOIn70qDkiO0NjVvZko=;
        b=OOFmCQrsE+sK/iitj709le/kKYRxztwaJsr3GjYVCzt0tPs60tJWHP3DZ4xWeRXEjy
         v0zuiPqNsAnJ+h21RRTtFLzXLzzapFyC/a7OoR7xmPlVq6CNojQoBm+Npd9oQrYGFvb0
         So6AlTxQSVCd8cLopG5w45TY+uMsbc9Qhcycxap1UWO3st7dezE+MaYlLsQmcMqG3rty
         EVaQ0D/Gs4gPO26+VT9RZ7ffKGJvB+sXWwH/kfZPshot1KgY6b2ZOhF18KaQzJYTSzbt
         8rGFWfa5lzcUiN3+YE8lI0r/FvOhiav/7eUXY2e6zKVFyXrN5PmbBzl+xDBw6X13UqdA
         Ra/w==
X-Gm-Message-State: AOAM530e2l6prD4DmBnSm2it04onSTsNas2jGanWlNqlCXbeiSNl17Jo
        XSPze+Dg2XUBY8QEms0CjRlvPEigznkcSg==
X-Google-Smtp-Source: ABdhPJxmdpJYJ0owvvWi+uhysZaxfObYzpmCdKgDSi29DmMj/+3YHkqpZiRW48MGVOWtofBrNt+S9A==
X-Received: by 2002:a05:620a:813:: with SMTP id s19mr8122429qks.33.1624923492387;
        Mon, 28 Jun 2021 16:38:12 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id o66sm11557917qkd.60.2021.06.28.16.38.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 16:38:11 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id i4so21376877ybe.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 16:38:11 -0700 (PDT)
X-Received: by 2002:a25:dc50:: with SMTP id y77mr18847228ybe.405.1624923491186;
 Mon, 28 Jun 2021 16:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210625052213.32260-1-vkoul@kernel.org> <20210625052213.32260-2-vkoul@kernel.org>
In-Reply-To: <20210625052213.32260-2-vkoul@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Jun 2021 16:37:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XsUbyB4enDobda3eDoTpCqdgVogyC3YWGe9rsjgR1REw@mail.gmail.com>
Message-ID: <CAD=FV=XsUbyB4enDobda3eDoTpCqdgVogyC3YWGe9rsjgR1REw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] soc: qcom: geni: move GENI_IF_DISABLE_RO to common header
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 24, 2021 at 10:22 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> GENI_IF_DISABLE_RO is used by geni spi driver as well to check the
> status if GENI, so move this to common header qcom-geni-se.h
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 1 -
>  include/linux/qcom-geni-se.h    | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
