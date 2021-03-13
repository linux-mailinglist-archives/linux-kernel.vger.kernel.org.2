Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C833A133
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 21:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhCMU6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 15:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhCMU6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 15:58:02 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7797BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 12:58:02 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id a188so4178134pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 12:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=v1c61jKYKEuD14m28VClvmdhx64RhGGT7QNEKqrboQU=;
        b=DFB3DRcDBe95SwMaLJO9jOVsjOaypyxDSWr80UfH+rJ1QSAK0MVzgZJLMhd8MCO3CJ
         fhGcaDRz70at6dIRx8OwDiJwRk2ysa3eZQmLgfjq+10XwPnNX5kTGCj8rGnIX5VqDACk
         sAEiRqOJcLM8yxLHnI45PkL4uc2Zr71U6xaaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=v1c61jKYKEuD14m28VClvmdhx64RhGGT7QNEKqrboQU=;
        b=ZrMmWUEkFYwrtEegm33rA4HqnPMyxpMlYkvBOuJYA7P5lYeYCwhzl86F1ETWnv/Kbs
         NYH5tL716iG353Eg7mSY5IQooQCSDbA5CZmIo3qXiwKez79jtqR2WnJrXdO8LPchFy17
         1QVUTCUt9/D9km6Uh0RzNZMJWQ+gsFPMWOMwqHzfTWo5zt0HQPaq4FYQ2riF7DzolUTa
         /ISeaDiOWNnOIBAs6DapRp1F7ti6jdyGpGqe1SflxZ4SCL7gLdTT4yN5ycMR4tw9xzzY
         3SF1b078tCGH/7lQkVSCHeUtvd1HHjvNHcyx2x3KLzTFCZuru0oibxi849yzwQiJIt9X
         DcWA==
X-Gm-Message-State: AOAM531iOEsrN2SxtkhvFKMnapbTzT7KKe3R8f46wvBuxPuMQ9HLDWvA
        VJBjrUO2vtTWMOXT7tltv8DH6A==
X-Google-Smtp-Source: ABdhPJxZw9wws/SVFXIhAnWiu6mOY3OOZaPluw3y2ci+akVmvHeO7KoEwegJ9wMYU5tjIyNztIExLw==
X-Received: by 2002:a63:5b49:: with SMTP id l9mr17037479pgm.279.1615669082064;
        Sat, 13 Mar 2021 12:58:02 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:e859:c7d5:7d7b:5ed8])
        by smtp.gmail.com with ESMTPSA id l2sm6202673pjg.50.2021.03.13.12.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 12:58:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210313054654.11693-3-srivasam@codeaurora.org>
References: <20210313054654.11693-1-srivasam@codeaurora.org> <20210313054654.11693-3-srivasam@codeaurora.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: Add sound node for sc7180-trogdor-coachz
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Date:   Sat, 13 Mar 2021 12:58:00 -0800
Message-ID: <161566908021.1478170.6789375084827041262@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-03-12 21:46:54)
> This is a trgodor variant, required to have sound node variable
> for coachz specific platform.
>=20
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
