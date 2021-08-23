Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9513F51D7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhHWUPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhHWUPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:15:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E72C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:14:32 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso18702636otv.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=imeFijr1ufQz/lyVbyX52fuMyimnJkFupP8Ym2EmTQo=;
        b=kIQLdC4l7hlpNTMxCAbMmy0l5zXzSOn85mn4Y1Lyvye5+7+wJ/9HAFxD7fWcE3+5B4
         5ijwMcBoO5e8PI16oP7CZ+c+KiJJm3dj51IxjfoiqxbshKwSperqs66DniUnS6ruQIDv
         sm4uUCQhJN4iiCp2GovuPFeW9UgadiAiIIvM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=imeFijr1ufQz/lyVbyX52fuMyimnJkFupP8Ym2EmTQo=;
        b=RDnkiuz5w7OA4hJrV77piwo2kJ+3NquuGc9OdsPBpxMPirPrbltj5MbSU6BgajUvPq
         fLOqxh7pErBrNu+9Xr58c5IQ0WKm2TFw4yWmv2ogRUM4Cx67Rra/pCBLB/VIWIxSE2EI
         kH2ozSS16yxRS96WZ/UDVgop+6LV5CI0kCw310zNLY51ZYrH2Btj0WFpe8tam8M5HN1G
         +KU94WGhkLe3VABAu7T4urr30H0Hh7plVJTxTXB2zZHxXF8h2WI1X/A7VgYux5xdowOC
         RbFW5IE8RtO6UgPQBfjRYahVLy7YqqxRQ83OD407MLRCRzXWFLksFsqxybEXrfxlOe78
         C83A==
X-Gm-Message-State: AOAM532/6Jg4vo/3zZcGi7PPFtFdDrtV7We+6tK+KIdHjNoTRtVqmVOs
        OR1WjxjCympyAgOtcF7JS9PG08i+/uFHKGGrCw9X7g==
X-Google-Smtp-Source: ABdhPJw2HcWyJlmraQaLOXE+VoqCAcv4OB/hNC1N5xlm5WxZRCrdxX8xQZ/oi0DgFlhYMnxtW2ar3P94+BlSUgfx+iQ=
X-Received: by 2002:a05:6830:2b24:: with SMTP id l36mr12752645otv.25.1629749671375;
 Mon, 23 Aug 2021 13:14:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Aug 2021 15:14:30 -0500
MIME-Version: 1.0
In-Reply-To: <1629344185-27368-3-git-send-email-sibis@codeaurora.org>
References: <1629344185-27368-1-git-send-email-sibis@codeaurora.org> <1629344185-27368-3-git-send-email-sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 23 Aug 2021 15:14:30 -0500
Message-ID: <CAE-0n52PEJnsW1bGNZcRuRJVaAPK2CHn9jepjNvRy6=BearZNg@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] remoteproc: qcom: pas: Add SC7280 Modem support
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

Quoting Sibi Sankar (2021-08-18 20:36:17)
> Add support for booting the Modem DSP found on QTI SC7280 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
