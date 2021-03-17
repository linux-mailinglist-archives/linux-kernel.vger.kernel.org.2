Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F75D33E5A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhCQBGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 21:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhCQBAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 21:00:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48806C061762
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 17:59:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso406819pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 17:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=A2bEAqIF45uVIy1NyhLffdc3Vl3zlbiHGv1l9FcXM1U=;
        b=hXr7Dv22ffhDrMpBEx2FnaUv5d4cLxWaJzE15/1oSyFNPaaBA06p+hW1FUU3YDX5kv
         pcsPNuhGhO7X/hhryV8BpOc667fHSwFWujz3V84WXZdapkqsWhTwU375xx9K3lBFU7nj
         LGV3iTXnb9GHeqHdEZKZz432kt8RdWNHPbWwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=A2bEAqIF45uVIy1NyhLffdc3Vl3zlbiHGv1l9FcXM1U=;
        b=YoaTHHymFGsle9odDHecscrm1qfuXBI/W0YSmgvx8OtyZboRWK6LL0Ub036NtBvEqD
         bvvQc8EUodfcEDTbtcKlxgBGCNgFON7JFVmSvWH7eJB7kC4E8Ff009jAarhAaZBPGYdv
         qkkL18spEa2MrvKBbWv0JIMGSfjWj2aGZ6wBXu77VM7r6/s1w92p2Dkhy+D7ofQkIv4A
         kARSSl2F40F6/+IKQzXyyrQj/Nwp4NHe6/0N3b2x2rA0y+RY26bHwG+jitlNWfoSdvMs
         ygcGN0U8mWpRbpSsGJ72KpDfnr68LWgZPbsn/c6pUn7C/Lz1U/Jo6Sq/Xe8M/34nRDKs
         et8w==
X-Gm-Message-State: AOAM533SMkK6jtCGmLh8+KZqQ9qpgN05xRf1MxCxfBhdCnKZG4h95KeT
        adJyrTLil437nmfbqnZiugXqTw==
X-Google-Smtp-Source: ABdhPJxfV0VD4LpWQQN9RPf1oD4VSYvZciDFI0ECk+IGfhlQmTgha1/hmVw+zMhQJpGrP33Kfs2hOg==
X-Received: by 2002:a17:90a:b10a:: with SMTP id z10mr1741356pjq.125.1615942796783;
        Tue, 16 Mar 2021 17:59:56 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e1e0:9aee:aecc:ef78])
        by smtp.gmail.com with ESMTPSA id 205sm13008405pfc.201.2021.03.16.17.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 17:59:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210315133924.v2.1.I601a051cad7cfd0923e55b69ef7e5748910a6096@changeid>
References: <20210315133924.v2.1.I601a051cad7cfd0923e55b69ef7e5748910a6096@changeid>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: Add "dmic_clk_en" for sc7180-trogdor-coachz
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
Date:   Tue, 16 Mar 2021 17:59:54 -0700
Message-ID: <161594279473.1478170.12227892343505111031@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-03-15 13:39:30)
> This was present downstream. Add upstream too. NOTE: upstream I
> managed to get some sort of halfway state and got one pinctrl entry in
> the coachz-r1 device tree. Remove that as part of this since it's now
> in the dtsi.
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
