Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487C533A16D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 22:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhCMVhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 16:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbhCMVgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 16:36:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACB1C061762
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:36:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so12440143pjq.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=aMPU7eg7e28bJ2i0Qjxrkr9xGQBKH90SvGB4qDX91wg=;
        b=TUgKKVNA/XNTDmNpcJVNzctA21mlwIVtElF2PO9BBNfhXUwi/31TmspgkjDtV3Empx
         W2YV4GCx1ox+wbadu8Ic6CV36uweDdEzR29jdHx3LjEhnlaRsiwY0il3qUk7g9WY37h6
         cIg45A5owD2KMO0bzKlMjs2oxiAA2Fx3wFatk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=aMPU7eg7e28bJ2i0Qjxrkr9xGQBKH90SvGB4qDX91wg=;
        b=RHyw/cwD8m1L0DXox/UU/fxRYiRxLaQ5605MH0pWeO2CwZon1RtI0CQd1B9UNeNYuR
         5hoB0aDjAUmfQfQ6A27bDvxY7YObqn6fh/fK3/79C72fC78VDP7RYs7lIlDmBHsX5f+N
         PtWof94uJnCqEbzMcZjMn/+NpUR/AkWDI/rxi0qY/LSPLcxHd1ZBia3Zy4jY4VWIsvJz
         2nINrMNEgrAxPZDKUe8PRfwteB5bw/CsAnrXNPZC465ezV5eBpGMMA6L+P9rDD+CSEj1
         XKW9BGKTtcsiZr6/hMmDf/FTrEl00oHdiKDFq7aTdt1d+0Yx03H+mZt1Y7pX28L92Dvb
         cImw==
X-Gm-Message-State: AOAM533tO2iiygg/+C0ZRzX83gKDXR+O9EFvdDtcAB+mFLSCuKx8Tf+D
        jc7pVCpsX1e4tICxJGpKsxGCpg==
X-Google-Smtp-Source: ABdhPJwzK6lzLHjkj9lABLF3foT7chb7OnaZYk8ViG03amzm2xDGkeiRYX/vCyza1Jr8+P+Jo+hSJw==
X-Received: by 2002:a17:90a:bb91:: with SMTP id v17mr5160682pjr.24.1615671413426;
        Sat, 13 Mar 2021 13:36:53 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:e859:c7d5:7d7b:5ed8])
        by smtp.gmail.com with ESMTPSA id c193sm9531324pfc.180.2021.03.13.13.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 13:36:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1615269111-25559-2-git-send-email-sibis@codeaurora.org>
References: <1615269111-25559-1-git-send-email-sibis@codeaurora.org> <1615269111-25559-2-git-send-email-sibis@codeaurora.org>
Subject: Re: [PATCH 1/6] soc: qcom: smem: Update max processor count
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, mani@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org
Date:   Sat, 13 Mar 2021 13:36:51 -0800
Message-ID: <161567141134.1478170.1759471645511900157@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-03-08 21:51:46)
> Update max processor count to reflect the number of co-processors on
> SC7280 SoCs.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
