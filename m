Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D2233C94E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhCOWYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhCOWXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:23:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B069C061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:23:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so374937pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7L9Oec5FsRNWNPbGHpgjHARldSZeoiC0UDAj6abdt30=;
        b=Pir6/qWhzaX22FbaWtnga7RvasSshDErvembCe9mIrnfDBqlv2Q66dewUKWrXqJX4a
         AcxdpuIgAlII0bhKLG1K+1xsoNVGA/xWNwZFEpc7MifhJT35AscSqZaYK6Yn/xqnEBYW
         A1RUSD7VZd8kg9eSWiREBFmqqIENDwRT2vhxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7L9Oec5FsRNWNPbGHpgjHARldSZeoiC0UDAj6abdt30=;
        b=qRqLpG/uqw5AwSgSYpqM6W4xCel5iwTjk9iCMTysoteEB5hEChrX1MHVZaBqRWLsBT
         OxEVaOSj5mTrkLCi5z3AejzdluxljkfoSkJ17K+s9Nmwop/BX6CXufeNv/Ah2YrBudyt
         en13oq5yc7fyBblEPPceO/s8UtYhetxMPC3uHkE727pSpvDQs1UwZLqva9ndc2uvlL1C
         Q9R8c9dOvdfm6dlBeslnJDf8vLG7omuID3qaxTmNS+3iU/vfEJIcnBwbK0Wg7wbxj3Ub
         NDjDG8HsXF2FgikpodKDxHx1Ize2+J0tIaF/3jFYz0RA5WHpSxQCp/Sa8cy11Y+2Em0Y
         7zbg==
X-Gm-Message-State: AOAM530gqovXmuChT+6kKGD7dRFa9bJS3zHT4gv4qHcdUnwRHm5VEd6r
        t6r15dj953U2ctnZj+QJfzqE9w==
X-Google-Smtp-Source: ABdhPJxgcvn09izl/efsVfK83Z7KBeiQ3BlApkPxrJepjcbfs+4VTOzlvHZAWlTN9baNJuLDMfwZiw==
X-Received: by 2002:a17:90a:7344:: with SMTP id j4mr1229461pjs.223.1615847009910;
        Mon, 15 Mar 2021 15:23:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:9867:b969:5d4f:e017])
        by smtp.gmail.com with UTF8SMTPSA id e8sm14256260pgb.35.2021.03.15.15.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 15:23:29 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:23:27 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: Add "dmic_clk_en" for
 sc7180-trogdor-coachz
Message-ID: <YE/eX9IGkT2tzq/o@google.com>
References: <20210315133924.v2.1.I601a051cad7cfd0923e55b69ef7e5748910a6096@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210315133924.v2.1.I601a051cad7cfd0923e55b69ef7e5748910a6096@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:39:30PM -0700, Douglas Anderson wrote:
> This was present downstream. Add upstream too. NOTE: upstream I
> managed to get some sort of halfway state and got one pinctrl entry in
> the coachz-r1 device tree. Remove that as part of this since it's now
> in the dtsi.
> 
> Cc: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Cc: Ajit Pandey <ajitp@codeaurora.org>
> Cc: Judy Hsiao <judyhsiao@chromium.org>
> Cc: Cheng-Yi Chiang <cychiang@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
