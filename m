Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A4F454111
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhKQGq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbhKQGq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:46:26 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE432C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:43:28 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so2977224otj.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=//I1TVp7dTuZFMgwOKyJoAu2cQfvXhC1d7f5K65wAYg=;
        b=W4+dGHWHFret9QtsEmcwlFjLqGEyyi9t7/oCkJZ/TwkTYuYEa/jV1aBJZC87aZFH+Z
         ZcwfLRewlOAYtKlQcrcRTwVVUovIj8uV2Ks+n5lVYIbDuJKeK22Y7wufVsX+8XFaMG9j
         x8SAYO9b7shYj3pUqD4qzMX1wOtDq01iBWKQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=//I1TVp7dTuZFMgwOKyJoAu2cQfvXhC1d7f5K65wAYg=;
        b=WOadofXBeqjlI4aG4n+G0wv67F9enlRcO6DOhzkYrHzHKnMxYy7w1LhX0YTFc2iYOG
         Ef+S3G/6fWe6GpZXHSeKjTF8foL4NM/Q2dxsPZD2NQPDPBRFIMbhK51eaY1oMKGky8O3
         gg8EjwL2BW+Ht6JpePt+MGnRFfXnWqeTBd5jTuoeQKvr2Czy4cIEsMSp0WVTpzeKrfvV
         k8BNXUTa8P6Kg8UvryweQSJAP2buCiYH/N2UhuAg+rhbwrm3Rzj3tLtCgacxxWEcnd0V
         wBimzCN0obiWlDBIFVTIYY5NdnjZsMoTjJ7QpqqhLD2+4VKATpVi/nwDh2tyWQMoRSTh
         mUMA==
X-Gm-Message-State: AOAM530BM1qmQ2RS9ztFInDnocvknHZPUVmWl9ql+Icmc/mkhMT24IQb
        VE9DS1+ZU7B/lkYDr1C8qBX6TG/SBTkcEelDCd8vCw==
X-Google-Smtp-Source: ABdhPJwsKo1fEanM9NX3oCL5hyNK8f/aAd2sJcSS0+gxRvzjdO1BOo0snB/j/kUcnxhMJsS/ejuxg0vZQzHnPyroIEs=
X-Received: by 2002:a9d:7655:: with SMTP id o21mr11596628otl.126.1637131408127;
 Tue, 16 Nov 2021 22:43:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Nov 2021 22:43:27 -0800
MIME-Version: 1.0
In-Reply-To: <1637046458-20607-2-git-send-email-quic_sbillaka@quicinc.com>
References: <1637046458-20607-1-git-send-email-quic_sbillaka@quicinc.com> <1637046458-20607-2-git-send-email-quic_sbillaka@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 16 Nov 2021 22:43:27 -0800
Message-ID: <CAE-0n50cjm3O+i12Jxvfe6DdVDVG3cRrmz0ej6bMCKAeL0zHCA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: phy: Add eDP PHY compatible for sc7280
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robdclark@gmail.com, seanpaul@chromium.org,
        quic_kalyant@quicinc.com, quic_abhinavk@quicinc.com,
        dianders@chromium.org, quic_khsieh@quicinc.com,
        quic_mkrishn@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2021-11-15 23:07:36)
> Add compatible string for the supported eDP PHY on sc7280 platform.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
