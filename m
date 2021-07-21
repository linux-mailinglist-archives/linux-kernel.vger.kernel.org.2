Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF98B3D0829
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 07:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhGUEfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 00:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhGUEfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 00:35:30 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CED0C061766
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 22:16:07 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id y17-20020a4ae7110000b0290262f3c22a63so303623oou.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 22:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=V2Y9FK8B3XEt2CBNMnOBB1fSQfFtt/UMwPYA85/KD5s=;
        b=CKOk08I09kVqDyHTWl5Jm7LtpyXb0tS8INMXUBNAXqEuQVASWYEkI6ceQIVAd6KUU8
         VgOdlEmqvEWIHiSGa+JdsJioQNcICJ5QYAuX5Ouqgri/KnpBnYQkwjO6AC8P9Vn1h9SY
         2wonFd9Q6YFZIfn3RE51prrouC+J188ZTEPOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=V2Y9FK8B3XEt2CBNMnOBB1fSQfFtt/UMwPYA85/KD5s=;
        b=SG0WW/FyPdmBmfVjkjzNSihPJ23I2J9B4ElsB83hzcgfoW8igwEUmfMDekOYbqOVWW
         0EuA8ift+5Ed9ugPj50JwFcS3eZB2W+d6JiVeCk7ayv8VpIzJzvu8TVu61eRZno195tC
         YlYppHCMcx7EE+6dI3pLetqps7iUdhAto5on56kabfWZFeRs7Kx5G3YSfc3X20gczw2T
         FL1CHGC8aWuU8rL0ussG4WtOQGC0z9qPQpXUqjgk1gUoiEntLCCG3oMAktZNEs9T8tWs
         SElW+DccRvzRqUfw/+9tQK9VzPZZlkpBfHRghboVui/0P5+6A+8NwGkc22XpM5vwaese
         mtZg==
X-Gm-Message-State: AOAM531ZPF9/7EP36l8eTM6oZqZmpvdtBF8N0cyeWmYKIvyAWzLzwd9B
        Ca8f0aT7uCrYg6bMrJvxg2kW1DzeJVmmetUTgphpdQ==
X-Google-Smtp-Source: ABdhPJxCJYRZlniT0E2L1KJRisYCloErmXTq0V6N+52uVLiOm2L3iNt58JcJnkGTkkaUDS8usl2FRAroypRGXiSiFxs=
X-Received: by 2002:a4a:e206:: with SMTP id b6mr23323098oot.16.1626844566901;
 Tue, 20 Jul 2021 22:16:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jul 2021 05:16:06 +0000
MIME-Version: 1.0
In-Reply-To: <1626755807-11865-13-git-send-email-sibis@codeaurora.org>
References: <1626755807-11865-1-git-send-email-sibis@codeaurora.org> <1626755807-11865-13-git-send-email-sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 21 Jul 2021 05:16:06 +0000
Message-ID: <CAE-0n51BCqrbRx7g8vPHp-C_5L3owD-c720aiKqxoOVM9UyqkA@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] dt-bindings: msm/dp: Remove aoss-qmp header
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mka@chromium.org, robh+dt@kernel.org
Cc:     ulf.hansson@linaro.org, rjw@rjwysocki.net, agross@kernel.org,
        ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-07-19 21:36:46)
> Remove the unused aoss-qmp header from the list of includes.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
