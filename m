Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE23226A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhBWHvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhBWHu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:50:28 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69646C06178B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:49:48 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w18so8262796pfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=vs+Po/qDl+LMilqgZYSJdN00NlVMDFdkH9R9v7dPCJ0=;
        b=XZ+C6W4OOQZh/kFBb2huxk3/wpyfdWB1ChY7eVghcoLCrdFpJl05LzNymU7oK5e0gr
         ZXu6O4X74LTzIh+Lc821uFUc43B1csV/zndLv15FGMC6K4Uk99lbEwyDcPvjil2iwZpL
         MAswBicxTLaavccxaZwGzdkG6WR6jjIQijEAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=vs+Po/qDl+LMilqgZYSJdN00NlVMDFdkH9R9v7dPCJ0=;
        b=cvBPp3bsRgijjF3PppnqGKWtOTC/0PZ9AbsadJoUM3bp2JUXvm+Op/dGHlHZrgsN5R
         QkAhe2Gxhq+QzWHAkajJL/DMy/pHzlXa+9CrNv+hujZJmuVIhg5EB9UQJx+TbqeUd21M
         O7RVeu2eYy5dfs058nnf/0h8FF0TI9ymF4vjcsk4oLIWdkpwfpJCM+MgemgOPU2iyoI2
         3I+qrTwp/ECed94z8Z2r6ePVObcK1Nt+e4TgHJqhuK+NBRwnmlqYX8ArBpV2Nw5M80es
         vIfRtFB+DBmrur32DdKg7Y0CHB5M7tI/Ux+xlW4LtR5frYAXtmc9acSCyUrN11NR4zjt
         q3Zw==
X-Gm-Message-State: AOAM5338a9ENNwN2c7yNWg1z/ZN7SDRu91pUi0c+pWNxbkF+Er88d0Gp
        5BD8eiDi8Ty597vKzgVuzbXxbQ==
X-Google-Smtp-Source: ABdhPJxGbMGJrV4PwG5EMGdsmKoBx3keygbgbAJ4uJhqxUNj+HFibldW/FYkZbmo2+XGEjikappoFQ==
X-Received: by 2002:a63:2948:: with SMTP id p69mr23230491pgp.15.1614066587989;
        Mon, 22 Feb 2021 23:49:47 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:68e6:d68b:3887:f216])
        by smtp.gmail.com with ESMTPSA id 137sm21405427pgb.80.2021.02.22.23.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 23:49:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1613114930-1661-2-git-send-email-rnayak@codeaurora.org>
References: <1613114930-1661-1-git-send-email-rnayak@codeaurora.org> <1613114930-1661-2-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH 01/13] dt-bindings: arm: qcom: Document SC7280 SoC and board
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Date:   Mon, 22 Feb 2021 23:49:46 -0800
Message-ID: <161406658623.1254594.9002506853157482065@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2021-02-11 23:28:38)
> Document the SC7280 SoC and the IDP board bindings
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
