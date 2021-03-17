Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0280133E5A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhCQBGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 21:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhCQBAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 21:00:18 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D70C061763
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 18:00:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 30so13230040ple.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=JBEnLG6p6/B5IxR4abKEg2z7MsyL/dH1QIZvxapo1/g=;
        b=WwpTaQKV5j1nA95NgWspMB4tSDYauve7lK5W8occUsJekfPrnEB6MVtIT+a2GVH8pn
         ndXmX05Xf11J+plNntxVxXH3jlqdNo4ZQJQHQwhs5ghYUm5LEejn2tK7K4Bx0HiBag8+
         YkooMTUzBgnSmiBv2yMGCGu8X2xQ7CI+01LZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=JBEnLG6p6/B5IxR4abKEg2z7MsyL/dH1QIZvxapo1/g=;
        b=R08GMyjTsYxf/AFDGs1yCQTENSKXNIre4wIGk2jh10JwbHn5djwRo4m/riaU/Hw2B6
         twrP70CDSKCjz9cCpwlgcho2YyYeC5x0JRnEc2eXzgrmZJZHe3TUjgcDIgm2fQmyGox+
         qVi7HrI+HSMeQWc95eaG8vvSgTgJzaKgxBYRmHeBNV1fRPcjk1uRL1pfY+Q92PEQ+iG5
         zeNpTOe4PObW8x/5nPZAx2iDKwdXhdUI/SVCf6eZ06txA0lMLVEMMZfX86SBr4EdLKQz
         hffG5yWLW/xgmrFiL3CX+JdeDQjhWogBp6K3Vblp8u0H9Kq/lHvjXG7b8s2PaUFEcfwc
         4GOQ==
X-Gm-Message-State: AOAM531Re9GNwmGMgnjWW9JuY6czKfYG1kJ7yywLHc0vagMjq2ITR7IG
        88slIaT1SGJU24d2HwwlHhmlMA==
X-Google-Smtp-Source: ABdhPJyWohFwruH6CMfmHeOWwb1l14aXHW2lxKJVTvrPsE4wVlYOllNx4Nxj04F4pqJfLgzdgirllg==
X-Received: by 2002:a17:902:7592:b029:e2:e80f:6893 with SMTP id j18-20020a1709027592b02900e2e80f6893mr1975766pll.61.1615942806582;
        Tue, 16 Mar 2021 18:00:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e1e0:9aee:aecc:ef78])
        by smtp.gmail.com with ESMTPSA id j27sm17217024pgn.61.2021.03.16.18.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 18:00:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210315133924.v2.2.If218189eff613a6c48ba12d75fad992377d8f181@changeid>
References: <20210315133924.v2.1.I601a051cad7cfd0923e55b69ef7e5748910a6096@changeid> <20210315133924.v2.2.If218189eff613a6c48ba12d75fad992377d8f181@changeid>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Add "dmic_clk_en" + sound model for sc7180-trogdor-pompom
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Tue, 16 Mar 2021 18:00:04 -0700
Message-ID: <161594280472.1478170.100740500706598633@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-03-15 13:39:31)
> Match what's downstream for this board.
>=20
> Cc: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Cc: Ajit Pandey <ajitp@codeaurora.org>
> Cc: Judy Hsiao <judyhsiao@chromium.org>
> Cc: Cheng-Yi Chiang <cychiang@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
