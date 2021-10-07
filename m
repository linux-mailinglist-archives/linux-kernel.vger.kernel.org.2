Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B548C425ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhJGSgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhJGSgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:36:38 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA28BC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 11:34:44 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so8606395otq.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=pMbvU4NuLdDg7x2gXhImMJJO8NYwPnWe5Vdp9WJAd/o=;
        b=lYFzTwpxajvpajNgQ3XKznusSHTanFX+EeDXtgylVlLxQ6102Fn+EndYOXTM9n5nZ9
         5ATqjdI+ZjKtzsFBGtAlPzRwEPrsAwhdobvc/jMce7fENw1Uq4w5HLoQELHmK32Nepaw
         bBNcE8vmGxGcTGShbB8McfBqSlmzqmydwk56w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=pMbvU4NuLdDg7x2gXhImMJJO8NYwPnWe5Vdp9WJAd/o=;
        b=iDf6Mw1pk1dX1tvIOAHYObyk3xKzwNMc7slR/T9fyKpYUwVqWA3lGhQwinvFpUKDW2
         75HfqzEud97v8o0zaW7vv/fm3mDarWRcFtTO/jWgGaDH8ixfER3HP65rtpELsWpOXM5V
         DOJmr6AOGIWMuYq9RSwMBV6iPFfwLzC4smnVoS+RCanHriQ2+JzJ+Ae5j1mmxwXpjqAs
         xwHrprmZgnJGa51TRrAvDdxZkov4d5RLoN3ukgXRK22YTHrKPgs8ywVwoH6wBvJ6C3Wt
         N+TRxCpL2xaFisaNpu6Cm+XGd8qmPtp2z812W9I8jzVAMF5Zb7R2UHCnLjPAsKgEykAC
         j33w==
X-Gm-Message-State: AOAM532mVEcCXBl59bLR6fAj1Fj1ki2hGZn1H7qoLxEraS258zpeywTl
        Y04iDQrboJ8WUAa0hwqOuK2b2CveuDymOeWDhyIfs/IYlTs=
X-Google-Smtp-Source: ABdhPJyDJU9ANF00rxAGsnwYPAeFgl12LTvc5zWIlHFElQD2qEn72bHEeASpKui2Xeg3tM2e25hEinotUfg/QCJJLSI=
X-Received: by 2002:a05:6830:1c2e:: with SMTP id f14mr4797816ote.159.1633631684290;
 Thu, 07 Oct 2021 11:34:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Oct 2021 14:34:43 -0400
MIME-Version: 1.0
In-Reply-To: <1633330133-29617-1-git-send-email-pillair@codeaurora.org>
References: <1633330133-29617-1-git-send-email-pillair@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 7 Oct 2021 14:34:43 -0400
Message-ID: <CAE-0n53rkv5SKO74M+7bkuMgaD7tS0k6a8m7KeQL8j3DTHdB_Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add support for sc7280 WPSS PIL loading
To:     Rakesh Pillai <pillair@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        ohad@wizery.com, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sibis@codeaurora.org,
        mpubbise@codeaurora.org, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rakesh Pillai (2021-10-03 23:48:50)
> Add support for PIL loading of WPSS co-processor for SC7280 SOCs.
>
> Changes from v4/v5:
> - Add yaml conversion for adsp/cdsp dt-bindings
> - Change clock names in wpss dt-bindings
> - Correct mistake in signed-off enail ID

Can you keep a running tally here of the full progression of the series?
That helps to look back and make sure we don't make a comment that has
already been made before.

One more request. Can you add support for 'firmware-name' like there is
in Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt so that we
can install firmware into some namespaced/versioned place instead of
having to put wpss files into /lib/firmware? It would also be nice to
load a single firmware file instead of having to split the file into
many pieces.

>
> Rakesh Pillai (3):
>   dt-bindings: remoteproc: qcom: adsp: Convert binding to YAML
>   dt-bindings: remoteproc: qcom: Add SC7280 WPSS support
>   remoteproc: qcom: q6v5_wpss: Add support for sc7280 WPSS
>
