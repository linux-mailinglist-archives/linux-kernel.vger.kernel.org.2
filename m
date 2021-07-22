Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC433D2CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 21:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhGVSvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 14:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhGVSvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:51:16 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E3AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:31:51 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so2801788otf.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=3DPSLi1ybTov0O3fVuhOjatTS2Xdr450c8Bfvi+v/u0=;
        b=GqohWEvgFPJC3JRlNzTRsN23DE727KvCgqmYzDx9xP2zTrTlCe2yEmDIMYGRLKzcTj
         GKW94djcAqQ0Ad3gH1ni6cdXVomMkQkXdR+WpuRFETT/StZvuTroYsQWZDMyyJy5Unn6
         Y1vAA4AeLgB7qZRtvOiM1F/LMgvfi2JdPuX+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=3DPSLi1ybTov0O3fVuhOjatTS2Xdr450c8Bfvi+v/u0=;
        b=YQWqjprtbJK9enKvHyLp2/1RuQw1z7qNUNEV6TddQkRel9ddOnw5OBL1oSmX+j+w64
         P9xoTo3NZ7sRT/DdoqMvpvSe9H3TlAY8hbCmp18GHucq8YqQwXbKRsdy1ij4074/aP0Y
         NFeOtspblEclSRaIxtYHpDymxVCUdW5k+8ccElpM2Bhh5APr+UhNTwk8yAlGbYLpEgfZ
         I7L7KHPc7bM94X8vnBXENTXSOsCsUOx7F3Eso2IMGAZ/1hbv7i1G5IV/iJTUE3HswZDG
         NbA3hti7z1m7ypNKnOcI2QWVqVK16E5YPuQihCNhijXQm1xwc4gHNM2ATiU+9R6KZ1VB
         O+6w==
X-Gm-Message-State: AOAM530TVYzYJ07s59xWWI/UqRM7iKKTBbW27ji6rFjCVo6mENje5cYo
        /xQ3DJ78YD3ATTb/ZzYuKTxgch/zU2LJX52c/4t1Qw==
X-Google-Smtp-Source: ABdhPJw9ktILTFVqvmgK8/4f/ODg5WVoOdDcD7oHmbTkk7H7ihrgo6bxEqQNWbmdgqFDdtUm/MTGlBvbs8tOcVDnNms=
X-Received: by 2002:a9d:8c7:: with SMTP id 65mr906170otf.25.1626982310796;
 Thu, 22 Jul 2021 12:31:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jul 2021 19:31:50 +0000
MIME-Version: 1.0
In-Reply-To: <20210722030738.3385821-1-bjorn.andersson@linaro.org>
References: <20210722030738.3385821-1-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 22 Jul 2021 19:31:50 +0000
Message-ID: <CAE-0n52n=ci=k-1Q64L8_pjpjmmxZ74fHUQ4i8rBiOSFS0o_mg@mail.gmail.com>
Subject: Re: [PATCH] phy: qmp: Provide unique clock names for DP clocks
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-07-21 20:07:38)
> The USB/DP combo PHY exposes the "qmp_dp_phy_pll_link_clk" and
> "qmp_dp_phy_pll_vco_div_clk" clocks, that are consumed by the display
> clock controller. But for boards with multiple enabled QMP USB/DP combo
> instances the hard coded names collides - and hence only the first
> probed device is allowed to register.
>
> Given that clocks are no longer reference globally by name and it's
> possible to replace the hard coded names by something unique, but still
> user friendly.
>
> The two new clock names are based on dev_name() and results in names
> such as "88ee000.phy::link_clk" and "88ee000.phy::vco_div_clk".
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Maybe we should make this a clk flag like CLK_NAME_PREFIX_DEVNAME so
that clk_init_data::name is prefixed with dev_name() so the caller
doesn't have to do the concatenation themselves.
