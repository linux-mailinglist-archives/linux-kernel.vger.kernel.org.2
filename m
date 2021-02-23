Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57DA32267B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBWHkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhBWHjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:39:12 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A0DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:38:32 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t26so11868879pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Uq7G+VtpoQoqq71TCIjSx9Y9sX/Ug87Got6NSD0YuxI=;
        b=LzwLVnx8KjWDAsLm4xqzxKT3Poi8GdKTRa8S+7YQDV5NNCntisjIVrgX6BgeAwYOvB
         5sm/YEGemxySQ7cyoLtaQ5DrH1ZccFbgA5PfIVT25r4t/xwlmnlW3oDpuemuESHguTaE
         63nqwq4qbmRFrDpvuR39eGD8vFVZknZGt3IEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Uq7G+VtpoQoqq71TCIjSx9Y9sX/Ug87Got6NSD0YuxI=;
        b=jsM6OmcErMvjD+jinDreO+4NI//iRwPabnboRAfhWYGtiAFeheOwCR4daYRKeKUxgM
         0dHamrCHu3iy7NCc4scclF1FfNj7rXlYETodaEVe5MD2pxrzef40bAum6UmaeG8zXIfz
         6E9MX3JbEhSQSWjPPmCJDGPz4RuSlEYgCEdZ+72sp1wNt6U0mlb0eXO34PIdV7p5jM1P
         +nQ98M0B5v/pnPFfypxaSS1NdexNUroYto03v5amhOdOjcFaRe4NotUcKKw+GI4Jank8
         EtvsVodtUg6WXNJfmu78WVO6AzMmQV9RylSiuIj++JX4DWp1RamZs0hjq0j4paxSkgyK
         APfQ==
X-Gm-Message-State: AOAM532W6fZDM7VjRZOnizRUG/NUpL/5NbUVi9wqk2Re4jUOzZA2FU7e
        oRCxU+qPVCH2kX2xqk0JSnlyFw==
X-Google-Smtp-Source: ABdhPJwLqtN8OE/Z3RkI+XzDBNdrUeDNeIBS+X4//zAsKSvkh8WqXsnQw460Q50eoopo+QLxJYvdhg==
X-Received: by 2002:a63:181e:: with SMTP id y30mr22526423pgl.324.1614065911870;
        Mon, 22 Feb 2021 23:38:31 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:68e6:d68b:3887:f216])
        by smtp.gmail.com with ESMTPSA id e15sm9520691pfl.59.2021.02.22.23.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 23:38:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1613114930-1661-5-git-send-email-rnayak@codeaurora.org>
References: <1613114930-1661-1-git-send-email-rnayak@codeaurora.org> <1613114930-1661-5-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH 04/13] dt-bindings: qcom,pdc: Add compatible for sc7280
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Date:   Mon, 22 Feb 2021 23:38:30 -0800
Message-ID: <161406591008.1254594.15135311472143997847@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2021-02-11 23:28:41)
> Add the compatible string for sc7180 SoC from Qualcomm
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
