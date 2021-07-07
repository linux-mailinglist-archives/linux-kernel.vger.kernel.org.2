Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93903BF241
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 00:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhGGWvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 18:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhGGWuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 18:50:54 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4821C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 15:48:12 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so3917932otl.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 15:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=TlJ0F5dHSC5zR5+dmIIRirAimmk6emojztfdcHPFyhM=;
        b=iMgiT/t2DG9+L36g6Z700bppQIeVqoM9zkbhhy9SIfRX4frPRyU+ouQTFXMl2R0sPJ
         LgFhnvvMRiiZj8S2wa4NJ8Vz/mvohesUF9FmRmrKoQBLP8NAEICnfegtJAZyEZci1MnR
         YXNnhH4XnQ6qFU9A6Nak7+ldW82JmnVqr9Ne0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=TlJ0F5dHSC5zR5+dmIIRirAimmk6emojztfdcHPFyhM=;
        b=rL16UCh2g3IylPr13z+nvvtUQLeiJa2c4jt7MpvQmnn/74cYmaKyg4ZM3zwH6LfSV2
         xONHyJNflqIuv6lEUfiJ1nybKA8y24K2Di6W2qU8dHFnaoytzwF3WgyBtf2uiGGtZQeC
         RGU0IMoTWi0j/0pvU40aABbn7MsMwtfjlwNgeKqoXcjrozBpjG4EggUQg/l8j+WQ3+Mf
         w6OwGZ6GyaDot91Pv26vWl8Yom4xERbXu3kHKIOdoHJfmJa9VYeeRGyAC/erbjXcKMOG
         EKNxi55Bp46JPPHczSPHK6obmQK/PV/2HQgmHzb3dko3iniPmUSUY5LVB/X78RP71wAR
         1Gfg==
X-Gm-Message-State: AOAM532q/TDW0YAmbfJlT8DIuF2AOa4nsRDiA8hNjBXWqnIOfmVYgkZx
        xOehKKMP57m3pKhuJMuupnLCokMONT7xK79sIkLHuRTGleA=
X-Google-Smtp-Source: ABdhPJyK2J6zY8vd+mAvTD6S4Q34neALxBbIk2xo/Gd2aFsHatAbSL4Frt0t2jEEBoiHqPWNmkE4CS05ggxrMn4Vy0o=
X-Received: by 2002:a9d:2781:: with SMTP id c1mr20809050otb.34.1625698092020;
 Wed, 07 Jul 2021 15:48:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Jul 2021 22:48:11 +0000
MIME-Version: 1.0
In-Reply-To: <20210707074517.2775-1-thunder.leizhen@huawei.com>
References: <20210707074517.2775-1-thunder.leizhen@huawei.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 7 Jul 2021 22:48:11 +0000
Message-ID: <CAE-0n51C__Lbi8uYU0QmnU5KUPRskL8NujzgrSE9nhdu8T-6EQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] media: venus: hfi: fix return value check in sys_get_prop_image_version()
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>
Cc:     Dikshita Agarwal <dikshita@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhen Lei (2021-07-07 00:45:17)
> In case of error, the function qcom_smem_get() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
>
> Fixes: d566e78dd6af ("media: venus : hfi: add venus image info into smem")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
