Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6E443D374
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbhJ0VEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhJ0VEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:04:50 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C72C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:02:24 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 107-20020a9d0a74000000b00553bfb53348so5575277otg.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=EWGuNWBIhypYPfhEwftufgfwqDqQ723njHLWk1GFVNA=;
        b=MmzNbp++wNza27ctdQLLqrbr070EwEsA68FErbYt9pXcWuV/40LvGqgr/h53l2qCvi
         0gjOxvnnkQeULOA/8abqsLbXqGJFcY4j3WiDOhVr9Cqn2GnOikq6Oy10PEcYqs7fbl/J
         KfHL0PNMZn2F+HtqLJIz6ei7aNF53jusSnYBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=EWGuNWBIhypYPfhEwftufgfwqDqQ723njHLWk1GFVNA=;
        b=nG1gTqATya41AJR8lPxGxxXXBR3tUwW6So3Irt3O3YFCnPIBkaQsvkqtgPTX8hUKwb
         8T9DiW84Q8BYX3un3LZeVfFz0HNZhW8rck2Y34xJr1FnYzZvg7LRZDkHn4+JzHj5Wp8Z
         UAix79ecnYIhecJsG7AuV4BVhfXiM3BIq5WWtHPHW3ezjG5hus1HL9pSiiRBrE5Spq7t
         PaBMpoK9niNdMVN/mud4YB2TxntEQ4KuUIGYALyYdmnbqekFtr6krtzqt61KusLMmHNL
         9jZFP6U2HuB8SrQqVqja5IL/H5XwqNDwRXRsY1dK5QW6g53wAfOwRvPYmBA0wq6Sfsd7
         tjnA==
X-Gm-Message-State: AOAM533t4y3a6Cdw9Ddj3ycwgw8vO4fonkBLpYWa15oQN8jkMgSYWawE
        fWV6KwjfcbN1JF3NcnNloTI3RfbmBaWq3oz8ywXRBw==
X-Google-Smtp-Source: ABdhPJwh99/Sh85MxoTTnuIvD5jp6hvye9B7r5N4NVAEnB3jm3m/LIvK9076YdNwy13oqDkW7nn0cj9KPHILd7ZjSOU=
X-Received: by 2002:a9d:6e16:: with SMTP id e22mr89272otr.77.1635368544206;
 Wed, 27 Oct 2021 14:02:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Oct 2021 14:02:23 -0700
MIME-Version: 1.0
In-Reply-To: <1635250764-13994-4-git-send-email-srivasam@codeaurora.org>
References: <1635250764-13994-1-git-send-email-srivasam@codeaurora.org> <1635250764-13994-4-git-send-email-srivasam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 27 Oct 2021 14:02:23 -0700
Message-ID: <CAE-0n53SMuHkWzNfBUw2Dym5hBGha1rWF-F3W5XpQvuWaULyAg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] soundwire: qcom: Add compatible name for v1.6.0
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, plai@codeaurora.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-10-26 05:19:24)
> Update compatible string and master data information in soundwire driver
> to support v1.6.0 in lpass sc7280 based platform.
>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> ---
>  drivers/soundwire/qcom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 2492190..2b39f4c 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -173,6 +173,11 @@ static struct qcom_swrm_data swrm_v1_5_data = {
>         .default_cols = 16,
>  };
>
> +static struct qcom_swrm_data swrm_v1_6_data = {

const?

> +       .default_rows = 50,
> +       .default_cols = 16,
> +};
> +
>  #define to_qcom_sdw(b) container_of(b, struct qcom_swrm_ctrl, bus)
>
>  static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
