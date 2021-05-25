Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870D43908E2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhEYSZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 14:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhEYSY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 14:24:58 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1387DC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:23:28 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id f22-20020a4aeb160000b029021135f0f404so4340746ooj.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=yLrEWP7K8W4M2KTxVp15RNvgy39Wo8hmbcRL1UT8wm4=;
        b=V9VWUnK0dVgC8ThICcYWKUrpc5Ij5G7O5GkEJ4p5ENwYCzL0XraIlL7+V2VympArHu
         fYoHb2HG1xYjs/HlXUnTUzDNQpLmw6k7RH93cL7rct8xz60XNId/S1K64RwtwiDtmbk8
         LPGbMKWTzXm/fhJM3V+0HuZgmj18yzuR5qlB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=yLrEWP7K8W4M2KTxVp15RNvgy39Wo8hmbcRL1UT8wm4=;
        b=bW0Y9j2T5hWkR7EcaQ90sBHyUleeiUVzxO3IvtbKmud8DvIl5XHvletM/JRvHLjlca
         S4sVqK0YNppYULmpTC8MROBTMstOOUdGGClW5/KBvTtHcNKJaZ4GiL4l6fmfC3NiPtbC
         /xF0r8Ex8R2qFuyPmtEDTYUBVnopMWP1L+HH26ySFNTgFB+V3Hnxy+LqGGSAv3gVuNu5
         ifs09ItQNzDSN9JKHz3J8xl/Py4dIS/FDzOjo5/iB9gOnW1BkKQQSh3ai1XjvS41v3Ze
         aor38BSDQSGKozzTO8x3V2sNRO1vMijd55noIxB67U3owWq0kOKpzhr2HO8Po9ujC3XE
         9DSQ==
X-Gm-Message-State: AOAM530ri8XpF5ufEYlpgYuJ5mBUzfK4XeQgyFRw+HOFIO9TSOz+v/ou
        1k1UKW9PTZe++cESBw8146KLXDjvtW0P4fOvrTfRNg==
X-Google-Smtp-Source: ABdhPJzqb/cUXWaFHPYbdlIHfd8m3yBFhec5Kh8+qcA+mY/y8sl8WzknhKEePGCSuaCP9Qxhq6MTXD6I9in9Oh14XbU=
X-Received: by 2002:a05:6820:169:: with SMTP id k9mr8907033ood.92.1621967007509;
 Tue, 25 May 2021 11:23:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 May 2021 14:23:27 -0400
MIME-Version: 1.0
In-Reply-To: <20210525133242.188603-1-senozhatsky@chromium.org>
References: <20210525133242.188603-1-senozhatsky@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 25 May 2021 14:23:27 -0400
Message-ID: <CAE-0n53MvSNZ+EZDLMzTzvvnQ-GZq8g29qxcEXQ-h9s-eQJ4Wg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: remove camera_mem region
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergey Senozhatsky (2021-05-25 06:32:42)
> qcom camera driver allocates the ICP firmware memory
> dynamically, so the carveout region is unnecessary.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
