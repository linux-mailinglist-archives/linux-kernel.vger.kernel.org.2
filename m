Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85873256D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhBYTiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbhBYTgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:36:02 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAB9C061788
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:35:21 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t5so5499677pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=r6wJvxB68vEymZci/szX9i/8klOR69G6A/W2Bpg+cp4=;
        b=nR9lCpX8XpkcvjIOmCara3uYiZ0lbn61xFo4C6F0Bs7EEf4jYjCeW2+fnj5qI3G6qH
         jGg2x/a4oChUVdBcmXH/Iwgjmglc+Hn8Czx8sSNYPr2jWYL94xZlsKLRwc3C0GIQdNpl
         W2c8M3fwHo2htxJvsNVv0ORyIYh0rpoLp5jEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=r6wJvxB68vEymZci/szX9i/8klOR69G6A/W2Bpg+cp4=;
        b=Mt4SkwL9JEyJCORvnAdm74Re84/axFwz/yeLaCPVkFzhfDRHG9zYCilglWeVfKUtsn
         /z4l1Gvy23W5Y9TynS9Arh8vy0NP+0goXg5MMF0NqF9+wQUX3iGi4vvUMHDoggg+4Qi2
         Br545FOg3bw2yUKFpwUUwmgjq0v+mwkGI1ivFndKWYxJRkdHxhVSk+2TRLXazOOQ5Sl8
         zEhPo+Vejg2S0fgyf4mBzi1ZtfR1ZzgEoAgFGAeWbpfXwzHE1qdZpwoFi2vnJf2zSy/S
         oDFUcqDK+UrSAr/RSC/QLoIK0TaeotebxxTQTNv0Br/ZQmicOCRXKMneaghUM72s8vMT
         ky+w==
X-Gm-Message-State: AOAM530K4rBD/oGFA1yLwoGGlHFMcdpkMVCNyei85EKNhzQdFYPjobHI
        Uq41zE9SIRaWretdXlefkcdaig==
X-Google-Smtp-Source: ABdhPJyskkONjLaGupEVZE1oDumXRSl08agvlDUkTMsRlO97Qz2/uswJYrl8oGCMV8rpq45ys5GPiw==
X-Received: by 2002:a17:902:ac82:b029:e3:bca2:cca7 with SMTP id h2-20020a170902ac82b02900e3bca2cca7mr4333204plr.43.1614281721158;
        Thu, 25 Feb 2021 11:35:21 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:b942:93a8:e68d:5a90])
        by smtp.gmail.com with ESMTPSA id g15sm6841549pfb.30.2021.02.25.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:35:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f3b32d437d7c1165a74ceec2cd52ff56b496e5a3.1614244789.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1614244789.git.saiprakash.ranjan@codeaurora.org> <f3b32d437d7c1165a74ceec2cd52ff56b496e5a3.1614244789.git.saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 1/9] dt-bindings: arm: msm: Add LLCC for SC7280
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Date:   Thu, 25 Feb 2021 11:35:18 -0800
Message-ID: <161428171894.1254594.5730779825217339020@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2021-02-25 01:30:17)
> Add LLCC compatible for SC7280 SoC.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
