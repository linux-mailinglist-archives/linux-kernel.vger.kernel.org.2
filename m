Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B0D32BBDF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358817AbhCCNDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349063AbhCCIQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:16:05 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ACDC061788
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:15:49 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q20so15716870pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=GTl72NabGi/IKpwlgFnK8VxUBIaVwPwtxb0HRt0N0tM=;
        b=bqQ18CjlBrGl8T5bZD8lHCg75fqppP0zhYH4O0zoPbiUP9pTm/+5ANgTRVM69yBWI0
         ZvsdBu2AqL0K9KW87nWY7c5xG/B0GRfU/nVUMfBBEwfwPez0+lqvVFxETsCY4/p5ugJG
         l2hk1yi8qcbUXcEw9yC5QFNF0Jq+V1GK9O4Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=GTl72NabGi/IKpwlgFnK8VxUBIaVwPwtxb0HRt0N0tM=;
        b=KFXoo9BZjPWmUjvWdzdP3rSv5ftERr73evK+iUaDmx6KqpXqx/6lMAqFEnBChGHJYV
         gKwtY1ngDWIwdnKRfiyMKFoj1VVzLJcxQnHgdaXKy4LWBMG03wglxi8hmXvwZ1AvYDF3
         rghadgb/I2oIEFtYnhE4fCFuaWlZfV2jwVvUZoNDlhkj8GAPUXwMd+3fcr6aJN70M3T8
         /v0ftu4jOJRIA2xNzEGIiPI2eg/GGGAFstLhxUbPlTFhqxQzghI7icb299fJXwtB8L4E
         8mdM13ZC9BhKw6bJciRIA4rTc6P59YFGRymVi6c9TV5p8ssN/BLMT+TSS7iqfyls5cqm
         CzdQ==
X-Gm-Message-State: AOAM5331FV98kaaQVNqiebFDrA2HIpfQljAPgcugL4XWOGgdiuCgzBOw
        JfUMwYPaDP/1zHvJpTRg5Vf9/w==
X-Google-Smtp-Source: ABdhPJzA9BCElwlRBD6UFaqEd1DNz3mMFtTjw1FrL9+ZLbCPHQ5AcOFYFyPXKn3SjWn4TnQsVe7AwA==
X-Received: by 2002:aa7:8a11:0:b029:1ee:42d8:a8f5 with SMTP id m17-20020aa78a110000b02901ee42d8a8f5mr7209909pfa.5.1614759349450;
        Wed, 03 Mar 2021 00:15:49 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id f3sm23102706pfe.25.2021.03.03.00.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:15:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210301133318.v2.8.I80c268f163e6d49a70af1238be442b5de400c579@changeid>
References: <20210301213437.4165775-1-dianders@chromium.org> <20210301133318.v2.8.I80c268f163e6d49a70af1238be442b5de400c579@changeid>
Subject: Re: [PATCH v2 08/13] arm64: dts: qcom: sc7180: Remove clock for bluetooth on Trogdor
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 03 Mar 2021 00:15:47 -0800
Message-ID: <161475934760.1478170.16764959964880020501@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-03-01 13:34:32)
> From: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
>=20
> Removed voting for RPMH_RF_CLK2 which is not required as it is
> getting managed by BT SoC through SW_CTRL line.
>=20
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
