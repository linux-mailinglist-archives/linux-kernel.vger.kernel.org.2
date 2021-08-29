Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4EE3FA98E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 08:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhH2GvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 02:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbhH2GvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 02:51:22 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BC3C061796
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 23:50:30 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso13933740ota.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=UcZsfTL7lo6QG03jH0zcLyA1nl3b2l6q7cLqiJ7RM6w=;
        b=C3yZviTdjca8Y6g3vvGkt67eBiVQkzTNyQJZ3Hymfg7j6b8YftJ/j/4/JhVjbttF+A
         Dc5OXJ/rbmHT1kJVqGDi/xWwlbLezhdODZyt5xaSP66IkqgULSKpdks+hB8VQ0i4H7lF
         ktUn5uKtG2eTCU7ZiZyyFbiOC4l/K3nw2Sjrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=UcZsfTL7lo6QG03jH0zcLyA1nl3b2l6q7cLqiJ7RM6w=;
        b=khKA5VcTUCNy/gv0ILQKmSO9K9/mzD3uB0m/WgNr5vDml1IHtb71HAvIzUFxvpiPtV
         yJra86CV+8rSHxRNidVmUG747EFAOlofx18TX3P4F8dv0enQLD7btCA3OyWVc7mrm8j5
         dfPZpysMdowJEGD7ivSSY0CENMoVgSoDzLWUdHotfCTO6FVaY0xUg4h5e7YieXx8a2ZT
         cCbelyyXYb5IbpCW9jVnEPRK+8WG8ScaYvAEEs5xIneQ14/w7+/XUUpWWDXQUsH6YjlS
         qGaST41x/ULQy7YWvLWQwrymnI7HWK19SFxrKCH16wf+7BdcCtp3LsuZMRI+NaHsepd6
         JgQw==
X-Gm-Message-State: AOAM530f63Par28VSBeZWtlnNfsvZQldFNB8etBsU7CklsWnUWpAeU8K
        Zv2/bxnKk4QXiSBHgR/+fwQhjN9nmKfZLAJem2d1hA==
X-Google-Smtp-Source: ABdhPJwt0axpFUQul8bw0k3jGfLZe7Fjddj2YcPWzVIguNKXiCod9lEN608fOnSzy15l8/WSbOgeRxJUsyLHYpXYzJQ=
X-Received: by 2002:a9d:5f85:: with SMTP id g5mr8562392oti.139.1630219829726;
 Sat, 28 Aug 2021 23:50:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 29 Aug 2021 06:50:29 +0000
MIME-Version: 1.0
In-Reply-To: <1630083934-9361-1-git-send-email-khsieh@codeaurora.org>
References: <1630083934-9361-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Sun, 29 Aug 2021 06:50:29 +0000
Message-ID: <CAE-0n51tzL8T2Zoqhu7CqEWRpaCBpRmy=+PZ-N8tCmFj85nbww@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: enable IDP display port
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        robdclark@gmail.com, robh+dt@kernel.org, sean@poorly.run,
        vkoul@kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        mkrishn@codeaurora.org, kalyan_t@codeaurora.org,
        rajeevny@codeaurora.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-08-27 10:05:34)
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

But this must depend on the patch that introduces the phandle to begin
with.
