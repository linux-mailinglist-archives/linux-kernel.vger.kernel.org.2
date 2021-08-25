Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81F63F7BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbhHYRvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbhHYRvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:51:44 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B340AC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:50:58 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so104553oti.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=joeEMSfwbKFOWf42c6X25rE4u+SwXoFheY/55rlm6LU=;
        b=KQ/HOnYdFw+ZF7qnp9jzF+z2MCLSv7IKlKnFCKpkaTpBdl0IV/CWYsbPjRASTs3VWj
         C8D+/SNYVY9IGiA27L3o8j3qjmjjMV97Yu49ksmzJ38yL5BetbwX6MhIAwcJao+hAYSH
         jTyNQJKSx3VVVhDdnWLkrTjoCNTbzOFv6mOCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=joeEMSfwbKFOWf42c6X25rE4u+SwXoFheY/55rlm6LU=;
        b=oV1612ChZi6N1XdvQzuoYkvf5RCYsI06bAAjJCorI2BlzDIKsv3maVJJyln1QgavS6
         Nt6dV679UaEE3EGuMiEfzk8pR2wdac9gwMMf6sD7vNA2EW8Q8nK8q6DUG1K28LnInYbf
         qMCxE5h4R+D2kPU4KOznWjVwXXQYeE2iJzhwA7qTEP5i5g0gUKdveEUo+SmeJk9KB+Ds
         BruHAfguizjryQcFLOerVHwz5crc1FPhGhKShGaKT0f4LldPVW+xToYXO+Y0E7oAS4Jl
         UQLmr/Mj2u0UQzYiuaQIqftzlEigQPFthBocYfFTuJB70SX1pi+Wj5aalSl6hjGixSS1
         wazA==
X-Gm-Message-State: AOAM530y+CkxMUCHTA6diIMoNbnWhfLFR00SwGXOsG3Y1+PwtsujN9L9
        u1I6Rl9/r4yH/QzCwRRGJKZNUFl5c6G3hu6jvzOBGQ==
X-Google-Smtp-Source: ABdhPJymKW+Q9r5NjGs3NkVet38E9V3EJHm+kKtdiXNkSMyDOfTN6qr7Dk5rQ6mPq/5GfCmqKJ5umNsFLQNCvxojzg8=
X-Received: by 2002:a05:6830:2b24:: with SMTP id l36mr21464418otv.25.1629913858077;
 Wed, 25 Aug 2021 10:50:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Aug 2021 17:50:57 +0000
MIME-Version: 1.0
In-Reply-To: <1628726882-27841-3-git-send-email-sbillaka@codeaurora.org>
References: <1628726882-27841-1-git-send-email-sbillaka@codeaurora.org> <1628726882-27841-3-git-send-email-sbillaka@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 25 Aug 2021 17:50:57 +0000
Message-ID: <CAE-0n536PraSR4oqGNtxcDnR0+H-N3eQTpsgTt84oU3NAXEjeA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: Add SC7280 compatible string
To:     Sankeerth Billakanti <sbillaka@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robdclark@gmail.com, seanpaul@chromium.org,
        kalyan_t@codeaurora.org, abhinavk@codeaurora.org,
        dianders@chromium.org, khsieh@codeaurora.org,
        mkrishn@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2021-08-11 17:08:02)
> The Qualcomm SC7280 platform supports an eDP controller, add
> compatible string for it to msm/binding.
>
> Signed-off-by: Sankeerth Billakanti <sbillaka@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 64d8d9e..23b78ac 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -17,6 +17,9 @@ properties:
>    compatible:
>      enum:
>        - qcom,sc7180-dp
> +      - qcom,sc8180x-dp
> +      - qcom,sc8180x-edp
> +      - qcom,sc7280-edp

Also add qcom,sc7280-dp here?
