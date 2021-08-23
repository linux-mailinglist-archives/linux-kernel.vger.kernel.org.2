Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA1F3F51D1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhHWUPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhHWUO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:14:59 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E251C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:14:16 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id y14-20020a0568302a0e00b0051acbdb2869so32839767otu.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=TngxpKOqHyiFNvNt+d4zJ7KjMao3ugf0Hy1vQTAHJQA=;
        b=ForlFMkfhRw3yADgfJ9NwDwZ7hfaZlMvpYJHU1pOkK0fdhqBOjKqSpzR6lzRNGaqvR
         E7dSfG3jlD0wy2M8pazICgH/qVcQcs1utgcS8ZgooKoyX+v2Y2Rjj3mn0PCzkDKt9T4j
         v1Kl0BMjLPcMTJhxKqS4yt1m+fJGIFVyK5GXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=TngxpKOqHyiFNvNt+d4zJ7KjMao3ugf0Hy1vQTAHJQA=;
        b=Ug1QjNbfTb3wnFBZz1jjM3RS13x18M184EAr9kpxRl0jmM6jlfUqbDZ+nOp2MP6w5V
         1qHKt80HdQx4GYeOUGUs3LZlB4oksiaYdtbCJsrqopb45fC5PXWe3zCVegFTw6kPH3eI
         52F1C5rDoGlm1F4Icvzv45XiXFLuFhMME4zB6eRbJZM2CX4DAy3vpVId/6C1SKI5hjjd
         RNZhkfK9ZhMP6FD7+qkusC2vHoTaloP1EVQp/BX5Btxa/cpGpI0jARW0a3Diwm0bFCbU
         ilZabVqAJirOHj3Hd4dACHgovAzQAqfbzfuw2VJ63ZiufOEKGLJD1Xa7WiQi0cWzSMVG
         kkQA==
X-Gm-Message-State: AOAM532NtR8WoM+R+q6YFh/MGCHCWOhgSguf9fVOJtH/ViAOw2gjLaf3
        joXwgrdzTO45dhPJjP5yzMruyHLfNbYckexRlyoFcSQV6Ko=
X-Google-Smtp-Source: ABdhPJzisd6wkOv8VP3EiiFnuLYPOzWwdTHcMUuPi0eL8twDhZeeq5HPrLV4aGCPBkz0C8n7x0246zhO1PfURaXig+c=
X-Received: by 2002:a54:468d:: with SMTP id k13mr236255oic.125.1629749655968;
 Mon, 23 Aug 2021 13:14:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Aug 2021 15:14:15 -0500
MIME-Version: 1.0
In-Reply-To: <1629344185-27368-4-git-send-email-sibis@codeaurora.org>
References: <1629344185-27368-1-git-send-email-sibis@codeaurora.org> <1629344185-27368-4-git-send-email-sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 23 Aug 2021 15:14:15 -0500
Message-ID: <CAE-0n51ZtuPeK+77YUygOBOj4YAQjq=0CX7bH5udu+8HQw55gA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] dt-bindings: remoteproc: qcom: Update Q6V5 Modem
 PIL binding
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mka@chromium.org, robh+dt@kernel.org,
        saiprakash.ranjan@codeaurora.org, will@kernel.org
Cc:     ohad@wizery.com, agross@kernel.org, mathieu.poirier@linaro.org,
        robin.murphy@arm.com, joro@8bytes.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, evgreen@chromium.org,
        dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-08-18 20:36:18)
> Add a new modem compatible string for QTI SC7280 SoCs and introduce the
> "qcom,ext-regs" and "qcom,qaccept-regs" properties needed by the modem
> sub-system running on SC7280 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
