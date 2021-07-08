Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9633C1ABF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 22:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhGHU7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 16:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhGHU7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 16:59:42 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E20AC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 13:57:00 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id z12so5957550qtj.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=txIBa7izt4FT4BE1+BkMaR3RCAXYErSxPttMfK5CXlI=;
        b=faOfPE42FMx2/m3f1QlT02pCHNK9sLreFKyjuOGb3tFGZWwE2u9n8c/m01lIAh4ZOK
         EnmFa0gKFLxLThifMO9hhFhEQ4otXF6Oz60t2oagtPcqwMmWE6MpBNGY7PQqbM+PnszO
         57ZF/9M4sfs2AV0fc381Kc/3WufCncVrAupIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=txIBa7izt4FT4BE1+BkMaR3RCAXYErSxPttMfK5CXlI=;
        b=DplRPccb8yj+LDjJ2/ODP9jgKtceEtKwSurWk8oawHyzrKy56QE0q9tH+brTcqASn6
         Xs3393y688oYnTi4in9mjtcgjebbW6YqnLha8HnfWEKdo+wkp21w9ptGTo8PRt5Kt7n6
         PVkVLT11cbJQPLU9MXiEOqEEqQKde9Ve6FW8obT/8ME9tpzyAtl/RAax3BGWMlod3Azw
         vGOGdg9/t59Pudylb0AkygTQ+c+2yc28Ds/JwfOCTG97w2lyiO/b/cX8UaodczpSD0e6
         07tSwaQG21u4D54fEnn70lCMqYI0sbHfXt+0SBu1xjgsdWNEgwR1pAYTWnzdRhEtKeVy
         BvXA==
X-Gm-Message-State: AOAM533fLpDA/Vq3kCZ9WKPKXxh1fWF/Fhj3dEfhHOMYTQjl7VfnYq68
        5DBrPE92o5hl0npASsIrumCODpYPVtvSWyQmEALJLA==
X-Google-Smtp-Source: ABdhPJy01WzZkz2fmE/A+D4JFf/YjrN+FkodfFEoNH/4qM6i1zp4YmjJ7cZ+I4HUiGMQweSEOpnYAwyEvPRnI/WHXdM=
X-Received: by 2002:a05:622a:1051:: with SMTP id f17mr30357847qte.226.1625777819121;
 Thu, 08 Jul 2021 13:56:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jul 2021 13:56:58 -0700
MIME-Version: 1.0
In-Reply-To: <1625592020-22658-5-git-send-email-khsieh@codeaurora.org>
References: <1625592020-22658-1-git-send-email-khsieh@codeaurora.org> <1625592020-22658-5-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 8 Jul 2021 13:56:58 -0700
Message-ID: <CAE-0n53EtG=Kd-i+q-Yg-GNNAkXwPnOOgFE_zG249OH5=i-f6w@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm/msm/dp: replug event is converted into an unplug
 followed by an plug events
To:     Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-07-06 10:20:17)
> Remove special handling of replug interrupt and instead treat replug event
> as a sequential unplug followed by a plugin event. This is needed to meet
> the requirements of DP Link Layer CTS test case 4.2.1.3.
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

This needs a Fixes tag of some kind.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
